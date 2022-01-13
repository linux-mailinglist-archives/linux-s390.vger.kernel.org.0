Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4C48DA60
	for <lists+linux-s390@lfdr.de>; Thu, 13 Jan 2022 16:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiAMPDJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 13 Jan 2022 10:03:09 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33795 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233641AbiAMPDI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Jan 2022 10:03:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1k7W57_1642086178;
Received: from e02h04404.eu6sqa(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0V1k7W57_1642086178)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 13 Jan 2022 23:03:06 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, davem@davemloft.net, kuba@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: Transitional solution for clcsock race issue
Date:   Thu, 13 Jan 2022 23:02:57 +0800
Message-Id: <1642086177-130611-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We encountered a crash in smc_setsockopt() and it is caused by
accessing smc->clcsock after clcsock was released.

 BUG: kernel NULL pointer dereference, address: 0000000000000020
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 50309 Comm: nginx Kdump: loaded Tainted: G E     5.16.0-rc4+ #53
 RIP: 0010:smc_setsockopt+0x59/0x280 [smc]
 Call Trace:
  <TASK>
  __sys_setsockopt+0xfc/0x190
  __x64_sys_setsockopt+0x20/0x30
  do_syscall_64+0x34/0x90
  entry_SYSCALL_64_after_hwframe+0x44/0xae
 RIP: 0033:0x7f16ba83918e
  </TASK>

This patch tries to fix it by holding clcsock_release_lock and
checking whether clcsock has already been released before access.

In case that a crash of the same reason happens in smc_getsockopt()
or smc_switch_to_fallback(), this patch also checkes smc->clcsock
in them too. And the caller of smc_switch_to_fallback() will identify
whether fallback succeeds according to the return value.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/af_smc.c | 63 +++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 12c52c7..c625af3 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -566,12 +566,17 @@ static void smc_stat_fallback(struct smc_sock *smc)
 	mutex_unlock(&net->smc.mutex_fback_rsn);
 }
 
-static void smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
+static int smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 {
 	wait_queue_head_t *smc_wait = sk_sleep(&smc->sk);
-	wait_queue_head_t *clc_wait = sk_sleep(smc->clcsock->sk);
+	wait_queue_head_t *clc_wait;
 	unsigned long flags;
 
+	mutex_lock(&smc->clcsock_release_lock);
+	if (!smc->clcsock) {
+		mutex_unlock(&smc->clcsock_release_lock);
+		return -EBADF;
+	}
 	smc->use_fallback = true;
 	smc->fallback_rsn = reason_code;
 	smc_stat_fallback(smc);
@@ -586,18 +591,30 @@ static void smc_switch_to_fallback(struct smc_sock *smc, int reason_code)
 		 * smc socket->wq, which should be removed
 		 * to clcsocket->wq during the fallback.
 		 */
+		clc_wait = sk_sleep(smc->clcsock->sk);
 		spin_lock_irqsave(&smc_wait->lock, flags);
 		spin_lock_nested(&clc_wait->lock, SINGLE_DEPTH_NESTING);
 		list_splice_init(&smc_wait->head, &clc_wait->head);
 		spin_unlock(&clc_wait->lock);
 		spin_unlock_irqrestore(&smc_wait->lock, flags);
 	}
+	mutex_unlock(&smc->clcsock_release_lock);
+	return 0;
 }
 
 /* fall back during connect */
 static int smc_connect_fallback(struct smc_sock *smc, int reason_code)
 {
-	smc_switch_to_fallback(smc, reason_code);
+	struct net *net = sock_net(&smc->sk);
+	int rc = 0;
+
+	rc = smc_switch_to_fallback(smc, reason_code);
+	if (rc) { /* fallback fails */
+		this_cpu_inc(net->smc.smc_stats->clnt_hshake_err_cnt);
+		if (smc->sk.sk_state == SMC_INIT)
+			sock_put(&smc->sk); /* passive closing */
+		return rc;
+	}
 	smc_copy_sock_settings_to_clc(smc);
 	smc->connect_nonblock = 0;
 	if (smc->sk.sk_state == SMC_INIT)
@@ -1518,11 +1535,12 @@ static void smc_listen_decline(struct smc_sock *new_smc, int reason_code,
 {
 	/* RDMA setup failed, switch back to TCP */
 	smc_conn_abort(new_smc, local_first);
-	if (reason_code < 0) { /* error, no fallback possible */
+	if (reason_code < 0 ||
+	    smc_switch_to_fallback(new_smc, reason_code)) {
+		/* error, no fallback possible */
 		smc_listen_out_err(new_smc);
 		return;
 	}
-	smc_switch_to_fallback(new_smc, reason_code);
 	if (reason_code && reason_code != SMC_CLC_DECL_PEERDECL) {
 		if (smc_clc_send_decline(new_smc, reason_code, version) < 0) {
 			smc_listen_out_err(new_smc);
@@ -1964,8 +1982,11 @@ static void smc_listen_work(struct work_struct *work)
 
 	/* check if peer is smc capable */
 	if (!tcp_sk(newclcsock->sk)->syn_smc) {
-		smc_switch_to_fallback(new_smc, SMC_CLC_DECL_PEERNOSMC);
-		smc_listen_out_connected(new_smc);
+		rc = smc_switch_to_fallback(new_smc, SMC_CLC_DECL_PEERNOSMC);
+		if (rc)
+			smc_listen_out_err(new_smc);
+		else
+			smc_listen_out_connected(new_smc);
 		return;
 	}
 
@@ -2254,7 +2275,9 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 
 	if (msg->msg_flags & MSG_FASTOPEN) {
 		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
-			smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+			if (rc)
+				goto out;
 		} else {
 			rc = -EINVAL;
 			goto out;
@@ -2447,6 +2470,11 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	/* generic setsockopts reaching us here always apply to the
 	 * CLC socket
 	 */
+	mutex_lock(&smc->clcsock_release_lock);
+	if (!smc->clcsock) {
+		mutex_unlock(&smc->clcsock_release_lock);
+		return -EBADF;
+	}
 	if (unlikely(!smc->clcsock->ops->setsockopt))
 		rc = -EOPNOTSUPP;
 	else
@@ -2456,6 +2484,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		sk->sk_err = smc->clcsock->sk->sk_err;
 		sk_error_report(sk);
 	}
+	mutex_unlock(&smc->clcsock_release_lock);
 
 	if (optlen < sizeof(int))
 		return -EINVAL;
@@ -2472,7 +2501,7 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	case TCP_FASTOPEN_NO_COOKIE:
 		/* option not supported by SMC */
 		if (sk->sk_state == SMC_INIT && !smc->connect_nonblock) {
-			smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
+			rc = smc_switch_to_fallback(smc, SMC_CLC_DECL_OPTUNSUPP);
 		} else {
 			rc = -EINVAL;
 		}
@@ -2515,13 +2544,23 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
 			  char __user *optval, int __user *optlen)
 {
 	struct smc_sock *smc;
+	int rc;
 
 	smc = smc_sk(sock->sk);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (!smc->clcsock) {
+		mutex_unlock(&smc->clcsock_release_lock);
+		return -EBADF;
+	}
 	/* socket options apply to the CLC socket */
-	if (unlikely(!smc->clcsock->ops->getsockopt))
+	if (unlikely(!smc->clcsock->ops->getsockopt)) {
+		mutex_unlock(&smc->clcsock_release_lock);
 		return -EOPNOTSUPP;
-	return smc->clcsock->ops->getsockopt(smc->clcsock, level, optname,
-					     optval, optlen);
+	}
+	rc = smc->clcsock->ops->getsockopt(smc->clcsock, level, optname,
+					   optval, optlen);
+	mutex_unlock(&smc->clcsock_release_lock);
+	return rc;
 }
 
 static int smc_ioctl(struct socket *sock, unsigned int cmd,
-- 
1.8.3.1

