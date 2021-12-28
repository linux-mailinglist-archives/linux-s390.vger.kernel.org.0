Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068D24809BE
	for <lists+linux-s390@lfdr.de>; Tue, 28 Dec 2021 14:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhL1NpQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 28 Dec 2021 08:45:16 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:50170 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231989AbhL1NpQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Dec 2021 08:45:16 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V06rKpi_1640699113;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V06rKpi_1640699113)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Dec 2021 21:45:14 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     kgraul@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net-next] net/smc: Introduce TCP ULP support
Date:   Tue, 28 Dec 2021 21:44:36 +0800
Message-Id: <20211228134435.41774-1-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This implements TCP ULP for SMC, helps applications to replace TCP with
SMC protocol in place. And we use it to implement transparent
replacement.

This replaces original TCP sockets with SMC, reuse TCP as clcsock when
calling setsockopt with TCP_ULP option, and without any overhead.

To replace TCP sockets with SMC, there are two approaches:

- use setsockopt() syscall with TCP_ULP option, if error, it would
  fallback to TCP.

- use BPF prog with types BPF_CGROUP_INET_SOCK_CREATE or others to
  replace transparently. BPF hooks some points in create socket, bind
  and others, users can inject their BPF logics without modifying their
  applications, and choose which connections should be replaced with SMC
  by calling setsockopt() in BPF prog, based on rules, such as TCP tuples,
  PID, cgroup, etc...

  BPF doesn't support calling setsockopt with TCP_ULP now, I will send the
  patches after this accepted.

Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c | 93 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ba9d1a8ebb4a..deb40307820d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2700,8 +2700,8 @@ static const struct proto_ops smc_sock_ops = {
 	.splice_read	= smc_splice_read,
 };
 
-static int smc_create(struct net *net, struct socket *sock, int protocol,
-		      int kern)
+static int __smc_create(struct net *net, struct socket *sock, int protocol,
+			int kern, struct socket *clcsock)
 {
 	int family = (protocol == SMCPROTO_SMC6) ? PF_INET6 : PF_INET;
 	struct smc_sock *smc;
@@ -2726,12 +2726,19 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 	smc = smc_sk(sk);
 	smc->use_fallback = false; /* assume rdma capability first */
 	smc->fallback_rsn = 0;
-	rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
-			      &smc->clcsock);
-	if (rc) {
-		sk_common_release(sk);
-		goto out;
+
+	rc = 0;
+	if (!clcsock) {
+		rc = sock_create_kern(net, family, SOCK_STREAM, IPPROTO_TCP,
+				      &smc->clcsock);
+		if (rc) {
+			sk_common_release(sk);
+			goto out;
+		}
+	} else {
+		smc->clcsock = clcsock;
 	}
+
 	smc->sk.sk_sndbuf = max(smc->clcsock->sk->sk_sndbuf, SMC_BUF_MIN_SIZE);
 	smc->sk.sk_rcvbuf = max(smc->clcsock->sk->sk_rcvbuf, SMC_BUF_MIN_SIZE);
 
@@ -2739,12 +2746,76 @@ static int smc_create(struct net *net, struct socket *sock, int protocol,
 	return rc;
 }
 
+static int smc_create(struct net *net, struct socket *sock, int protocol,
+		      int kern)
+{
+	return __smc_create(net, sock, protocol, kern, NULL);
+}
+
 static const struct net_proto_family smc_sock_family_ops = {
 	.family	= PF_SMC,
 	.owner	= THIS_MODULE,
 	.create	= smc_create,
 };
 
+static int smc_ulp_init(struct sock *sk)
+{
+	struct socket *tcp = sk->sk_socket;
+	struct net *net = sock_net(sk);
+	struct socket *smcsock;
+	int protocol, ret;
+
+	/* only TCP can be replaced */
+	if (tcp->type != SOCK_STREAM || sk->sk_protocol != IPPROTO_TCP ||
+	    (sk->sk_family != AF_INET && sk->sk_family != AF_INET6))
+		return -ESOCKTNOSUPPORT;
+	/* don't handle wq now */
+	if (tcp->state != SS_UNCONNECTED || !tcp->file || tcp->wq.fasync_list)
+		return -ENOTCONN;
+
+	if (sk->sk_family == AF_INET)
+		protocol = SMCPROTO_SMC;
+	else
+		protocol = SMCPROTO_SMC6;
+
+	smcsock = sock_alloc();
+	if (!smcsock)
+		return -ENFILE;
+
+	smcsock->type = SOCK_STREAM;
+	__module_get(THIS_MODULE); /* tried in __tcp_ulp_find_autoload */
+	ret = __smc_create(net, smcsock, protocol, 1, tcp);
+	if (ret) {
+		sock_release(smcsock); /* module_put() which ops won't be NULL */
+		return ret;
+	}
+
+	/* replace tcp socket to smc */
+	smcsock->file = tcp->file;
+	smcsock->file->private_data = smcsock;
+	smcsock->file->f_inode = SOCK_INODE(smcsock); /* replace inode when sock_close */
+	smcsock->file->f_path.dentry->d_inode = SOCK_INODE(smcsock); /* dput() in __fput */
+	tcp->file = NULL;
+
+	return ret;
+}
+
+static void smc_ulp_clone(const struct request_sock *req, struct sock *newsk,
+			  const gfp_t priority)
+{
+	struct inet_connection_sock *icsk = inet_csk(newsk);
+
+	/* don't inherit ulp ops to child when listen */
+	icsk->icsk_ulp_ops = NULL;
+}
+
+static struct tcp_ulp_ops smc_ulp_ops __read_mostly = {
+	.name		= "smc",
+	.owner		= THIS_MODULE,
+	.init		= smc_ulp_init,
+	.clone		= smc_ulp_clone,
+};
+
 unsigned int smc_net_id;
 
 static __net_init int smc_net_init(struct net *net)
@@ -2855,6 +2926,12 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
+	rc = tcp_register_ulp(&smc_ulp_ops);
+	if (rc) {
+		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
+		goto out_sock;
+	}
+
 	static_branch_enable(&tcp_have_smc);
 	return 0;
 
@@ -2883,6 +2960,7 @@ static int __init smc_init(void)
 static void __exit smc_exit(void)
 {
 	static_branch_disable(&tcp_have_smc);
+	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
 	smc_ib_unregister_client();
@@ -2905,3 +2983,4 @@ MODULE_AUTHOR("Ursula Braun <ubraun@linux.vnet.ibm.com>");
 MODULE_DESCRIPTION("smc socket address family");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_SMC);
+MODULE_ALIAS_TCP_ULP("smc");
-- 
2.32.0.3.g01195cf9f

