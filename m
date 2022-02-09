Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D814AF3C9
	for <lists+linux-s390@lfdr.de>; Wed,  9 Feb 2022 15:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbiBIOLc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Feb 2022 09:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbiBIOLb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Feb 2022 09:11:31 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2CC05CB90;
        Wed,  9 Feb 2022 06:11:26 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V4.oVI6_1644415882;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0V4.oVI6_1644415882)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 09 Feb 2022 22:11:23 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        "D. Wythe" <alibuda@linux.alibaba.com>
Subject: [PATCH net-next v6 3/5] net/smc: Fallback when handshake workqueue congested
Date:   Wed,  9 Feb 2022 22:11:13 +0800
Message-Id: <87d49c573a15e13a26314316692fccca91741042.1644413637.git.alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1644413637.git.alibuda@linux.alibaba.com>
References: <cover.1644413637.git.alibuda@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

This patch intends to provide a mechanism to allow automatic fallback to
TCP according to the pressure of SMC handshake process. At present,
frequent visits will cause the incoming connections to be backlogged in
SMC handshake queue, raise the connections established time. Which is
quite unacceptable for those applications who base on short lived
connections.

There are two ways to implement this mechanism:

1. Fallback when TCP established.
2. Fallback before TCP established.

In the first way, we need to wait and receive CLC messages that the
client will potentially send, and then actively reply with a decline
message, in a sense, which is also a sort of SMC handshake, affect the
connections established time on its way.

In the second way, the only problem is that we need to inject SMC logic
into TCP when it is about to reply the incoming SYN, since we already do
that, it's seems not a problem anymore. And advantage is obvious, few
additional processes are required to complete the fallback.

This patch use the second way.

Link: https://lore.kernel.org/all/1641301961-59331-1-git-send-email-alibuda@linux.alibaba.com/
Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 include/linux/tcp.h  |  1 +
 net/ipv4/tcp_input.c |  3 ++-
 net/smc/af_smc.c     | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 78b91bb..1c4ae5d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -394,6 +394,7 @@ struct tcp_sock {
 	bool	is_mptcp;
 #endif
 #if IS_ENABLED(CONFIG_SMC)
+	bool	(*smc_in_limited)(const struct sock *sk);
 	bool	syn_smc;	/* SYN includes SMC */
 #endif
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index af94a6d..e817ec6 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6703,7 +6703,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	ireq->ir_num = ntohs(tcp_hdr(skb)->dest);
 	ireq->ir_mark = inet_request_mark(sk, skb);
 #if IS_ENABLED(CONFIG_SMC)
-	ireq->smc_ok = rx_opt->smc_ok;
+	ireq->smc_ok = rx_opt->smc_ok && !(tcp_sk(sk)->smc_in_limited &&
+			tcp_sk(sk)->smc_in_limited(sk));
 #endif
 }
 
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ebfce3d..8175f60 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -101,6 +101,22 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk, struct sk_buff
 	return NULL;
 }
 
+static bool smc_is_in_limited(const struct sock *sk)
+{
+	const struct smc_sock *smc;
+
+	smc = (const struct smc_sock *)
+		((uintptr_t)sk->sk_user_data & ~SK_USER_DATA_NOCOPY);
+
+	if (!smc)
+		return true;
+
+	if (workqueue_congested(WORK_CPU_UNBOUND, smc_hs_wq))
+		return true;
+
+	return false;
+}
+
 static struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
 };
@@ -2309,6 +2325,8 @@ static int smc_listen(struct socket *sock, int backlog)
 
 	inet_csk(smc->clcsock->sk)->icsk_af_ops = &smc->af_ops;
 
+	tcp_sk(smc->clcsock->sk)->smc_in_limited = smc_is_in_limited;
+
 	rc = kernel_listen(smc->clcsock, backlog);
 	if (rc) {
 		smc->clcsock->sk->sk_data_ready = smc->clcsk_data_ready;
-- 
1.8.3.1

