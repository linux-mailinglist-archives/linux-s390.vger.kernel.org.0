Return-Path: <linux-s390+bounces-4045-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F68D121D
	for <lists+linux-s390@lfdr.de>; Tue, 28 May 2024 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820B528400C
	for <lists+linux-s390@lfdr.de>; Tue, 28 May 2024 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131DF1094E;
	Tue, 28 May 2024 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bT0iKA3Y"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060BCDDBE;
	Tue, 28 May 2024 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716863416; cv=none; b=L/GAR5Nhg5SOzbSDQRv8jntmG62XGLPbuxtgkzwfFt8hd7ij1ukdBGtJdd0doiPSaOvfhb4/raSJvyiHVHJWdJN66rvfXm+Vb4wanu8s2ZoEi4+yVH2hJXdkw2s+0lJUHRI8Cg7OvDmuioTCFuiHvhgTquJbj3/Rk5YMBgxe5Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716863416; c=relaxed/simple;
	bh=6AOqr5bo+vgIXak9lJuxSkq8KThhOOO0YuHHVi6pccM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DYBMK3kxPGxvMmMAA0eJsSIVRzwlLzsaK76PDUf9qXdWeg+IW6JzcSZbczEcm7d4hV01h5ww+tgbWXIvZsZUvbnRiBoh5h/JdPIRo0SYcPi5oK4yq5COjfHIA7UTIUeXa8s2uQXyocVAlu6teSSH+YDNpdRNfJ72uNlHcuhh+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bT0iKA3Y; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716863404; h=From:To:Subject:Date:Message-Id;
	bh=4k1evFX5nePvOyOdv03V8iOae8oaqD8neDybdWBMvMY=;
	b=bT0iKA3YLypbqHF6eR5cRc0qVwJMiFSYSQmr1h0K6PajPtAOrwa1+ewHuXJbCxYDbvAiIxI9HN7E2nEyxwlcoEkuVaWUvduvRLKTkdlWZZwm+l1cO/s38xMO5nsMDaxwX78QhwjJcUlkggvKcAiNRX94MW2M+TcVFcZL1kB9kec=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7O6EmH_1716863403;
Received: from j66a10360.sqa.eu95.tbsite.net(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0W7O6EmH_1716863403)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 10:30:04 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com>
To: kgraul@linux.ibm.com,
	wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	wintera@linux.ibm.com,
	guwen@linux.alibaba.com
Cc: kuba@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	tonylu@linux.alibaba.com,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net-next v3 2/3] net/smc: expose smc proto operations
Date: Tue, 28 May 2024 10:29:53 +0800
Message-Id: <1716863394-112399-3-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1716863394-112399-1-git-send-email-alibuda@linux.alibaba.com>
References: <1716863394-112399-1-git-send-email-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

From: "D. Wythe" <alibuda@linux.alibaba.com>

Externalize smc proto operations (smc_xxx) to allow
access from files other that af_smc.c

This is in preparation for the subsequent implementation
of the AF_INET version of SMC.

Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
---
 net/smc/af_smc.c | 60 ++++++++++++++++++++++++++++----------------------------
 net/smc/smc.h    | 33 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 30 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d8c116e..5b7a194 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -170,15 +170,15 @@ static bool smc_hs_congested(const struct sock *sk)
 	return false;
 }
 
-static struct smc_hashinfo smc_v4_hashinfo = {
+struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
 };
 
-static struct smc_hashinfo smc_v6_hashinfo = {
+struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
 };
 
-static int smc_hash_sk(struct sock *sk)
+int smc_hash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 	struct hlist_head *head;
@@ -193,7 +193,7 @@ static int smc_hash_sk(struct sock *sk)
 	return 0;
 }
 
-static void smc_unhash_sk(struct sock *sk)
+void smc_unhash_sk(struct sock *sk)
 {
 	struct smc_hashinfo *h = sk->sk_prot->h.smc_hash;
 
@@ -207,7 +207,7 @@ static void smc_unhash_sk(struct sock *sk)
  * work which we didn't do because of user hold the sock_lock in the
  * BH context
  */
-static void smc_release_cb(struct sock *sk)
+void smc_release_cb(struct sock *sk)
 {
 	struct smc_sock *smc = smc_sk(sk);
 
@@ -307,7 +307,7 @@ static int __smc_release(struct smc_sock *smc)
 	return rc;
 }
 
-static int smc_release(struct socket *sock)
+int smc_release(struct socket *sock)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -401,8 +401,8 @@ static struct sock *smc_sock_alloc(struct net *net, struct socket *sock,
 	return sk;
 }
 
-static int smc_bind(struct socket *sock, struct sockaddr *uaddr,
-		    int addr_len)
+int smc_bind(struct socket *sock, struct sockaddr *uaddr,
+	     int addr_len)
 {
 	struct sockaddr_in *addr = (struct sockaddr_in *)uaddr;
 	struct sock *sk = sock->sk;
@@ -1649,8 +1649,8 @@ static void smc_connect_work(struct work_struct *work)
 	release_sock(&smc->sk);
 }
 
-static int smc_connect(struct socket *sock, struct sockaddr *addr,
-		       int alen, int flags)
+int smc_connect(struct socket *sock, struct sockaddr *addr,
+		int alen, int flags)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -2631,7 +2631,7 @@ static void smc_clcsock_data_ready(struct sock *listen_clcsock)
 	read_unlock_bh(&listen_clcsock->sk_callback_lock);
 }
 
-static int smc_listen(struct socket *sock, int backlog)
+int smc_listen(struct socket *sock, int backlog)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -2696,8 +2696,8 @@ static int smc_listen(struct socket *sock, int backlog)
 	return rc;
 }
 
-static int smc_accept(struct socket *sock, struct socket *new_sock,
-		      int flags, bool kern)
+int smc_accept(struct socket *sock, struct socket *new_sock,
+	       int flags, bool kern)
 {
 	struct sock *sk = sock->sk, *nsk;
 	DECLARE_WAITQUEUE(wait, current);
@@ -2766,8 +2766,8 @@ static int smc_accept(struct socket *sock, struct socket *new_sock,
 	return rc;
 }
 
-static int smc_getname(struct socket *sock, struct sockaddr *addr,
-		       int peer)
+int smc_getname(struct socket *sock, struct sockaddr *addr,
+		int peer)
 {
 	struct smc_sock *smc;
 
@@ -2780,7 +2780,7 @@ static int smc_getname(struct socket *sock, struct sockaddr *addr,
 	return smc->clcsock->ops->getname(smc->clcsock, addr, peer);
 }
 
-static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -2818,8 +2818,8 @@ static int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	return rc;
 }
 
-static int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
-		       int flags)
+int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+		int flags)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -2868,8 +2868,8 @@ static __poll_t smc_accept_poll(struct sock *parent)
 	return mask;
 }
 
-static __poll_t smc_poll(struct file *file, struct socket *sock,
-			     poll_table *wait)
+__poll_t smc_poll(struct file *file, struct socket *sock,
+		  poll_table *wait)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -2921,7 +2921,7 @@ static __poll_t smc_poll(struct file *file, struct socket *sock,
 	return mask;
 }
 
-static int smc_shutdown(struct socket *sock, int how)
+int smc_shutdown(struct socket *sock, int how)
 {
 	struct sock *sk = sock->sk;
 	bool do_shutdown = true;
@@ -3061,8 +3061,8 @@ static int __smc_setsockopt(struct socket *sock, int level, int optname,
 	return rc;
 }
 
-static int smc_setsockopt(struct socket *sock, int level, int optname,
-			  sockptr_t optval, unsigned int optlen)
+int smc_setsockopt(struct socket *sock, int level, int optname,
+		   sockptr_t optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
@@ -3148,8 +3148,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 	return rc;
 }
 
-static int smc_getsockopt(struct socket *sock, int level, int optname,
-			  char __user *optval, int __user *optlen)
+int smc_getsockopt(struct socket *sock, int level, int optname,
+		   char __user *optval, int __user *optlen)
 {
 	struct smc_sock *smc;
 	int rc;
@@ -3174,8 +3174,8 @@ static int smc_getsockopt(struct socket *sock, int level, int optname,
 	return rc;
 }
 
-static int smc_ioctl(struct socket *sock, unsigned int cmd,
-		     unsigned long arg)
+int smc_ioctl(struct socket *sock, unsigned int cmd,
+	      unsigned long arg)
 {
 	union smc_host_cursor cons, urg;
 	struct smc_connection *conn;
@@ -3261,9 +3261,9 @@ static int smc_ioctl(struct socket *sock, unsigned int cmd,
  * Note that subsequent recv() calls have to wait till all splice() processing
  * completed.
  */
-static ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
-			       struct pipe_inode_info *pipe, size_t len,
-			       unsigned int flags)
+ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags)
 {
 	struct sock *sk = sock->sk;
 	struct smc_sock *smc;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index a0accb5..ad755ee 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -34,6 +34,39 @@
 extern struct proto smc_proto;
 extern struct proto smc_proto6;
 
+extern struct smc_hashinfo smc_v4_hashinfo;
+extern struct smc_hashinfo smc_v6_hashinfo;
+
+int smc_hash_sk(struct sock *sk);
+void smc_unhash_sk(struct sock *sk);
+void smc_release_cb(struct sock *sk);
+
+int smc_release(struct socket *sock);
+int smc_bind(struct socket *sock, struct sockaddr *uaddr,
+	     int addr_len);
+int smc_connect(struct socket *sock, struct sockaddr *addr,
+		int alen, int flags);
+int smc_accept(struct socket *sock, struct socket *new_sock,
+	       int flags, bool kern);
+int smc_getname(struct socket *sock, struct sockaddr *addr,
+		int peer);
+__poll_t smc_poll(struct file *file, struct socket *sock,
+		  poll_table *wait);
+int smc_ioctl(struct socket *sock, unsigned int cmd,
+	      unsigned long arg);
+int smc_listen(struct socket *sock, int backlog);
+int smc_shutdown(struct socket *sock, int how);
+int smc_setsockopt(struct socket *sock, int level, int optname,
+		   sockptr_t optval, unsigned int optlen);
+int smc_getsockopt(struct socket *sock, int level, int optname,
+		   char __user *optval, int __user *optlen);
+int smc_sendmsg(struct socket *sock, struct msghdr *msg, size_t len);
+int smc_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
+		int flags);
+ssize_t smc_splice_read(struct socket *sock, loff_t *ppos,
+			struct pipe_inode_info *pipe, size_t len,
+			unsigned int flags);
+
 /* smc sock initialization */
 void smc_sock_init(struct net *net, struct sock *sk, int protocol);
 /* clcsock initialization */
-- 
1.8.3.1


