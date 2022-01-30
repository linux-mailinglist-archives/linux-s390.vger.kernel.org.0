Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069FF4A37F5
	for <lists+linux-s390@lfdr.de>; Sun, 30 Jan 2022 19:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355777AbiA3SDI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 30 Jan 2022 13:03:08 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:57639 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354844AbiA3SDI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sun, 30 Jan 2022 13:03:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V3BCr70_1643565784;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V3BCr70_1643565784)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 31 Jan 2022 02:03:05 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     kgraul@linux.ibm.com, kuba@kernel.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH net-next 1/3] net/smc: Send directly when TCP_CORK is cleared
Date:   Mon, 31 Jan 2022 02:02:55 +0800
Message-Id: <20220130180256.28303-2-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220130180256.28303-1-tonylu@linux.alibaba.com>
References: <20220130180256.28303-1-tonylu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

According to the man page of TCP_CORK [1], if set, don't send out
partial frames. All queued partial frames are sent when option is
cleared again.

When applications call setsockopt to disable TCP_CORK, this call is
protected by lock_sock(), and tries to mod_delayed_work() to 0, in order
to send pending data right now. However, the delayed work smc_tx_work is
also protected by lock_sock(). There introduces lock contention for
sending data.

To fix it, send pending data directly which acts like TCP, without
lock_sock() protected in the context of setsockopt (already lock_sock()ed),
and cancel unnecessary dealyed work, which is protected by lock.

[1] https://linux.die.net/man/7/tcp

Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/af_smc.c |  4 ++--
 net/smc/smc_tx.c | 25 +++++++++++++++----------
 net/smc/smc_tx.h |  1 +
 3 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index ffab9cee747d..ef021ec6b361 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2600,8 +2600,8 @@ static int smc_setsockopt(struct socket *sock, int level, int optname,
 		    sk->sk_state != SMC_CLOSED) {
 			if (!val) {
 				SMC_STAT_INC(smc, cork_cnt);
-				mod_delayed_work(smc->conn.lgr->tx_wq,
-						 &smc->conn.tx_work, 0);
+				smc_tx_pending(&smc->conn);
+				cancel_delayed_work(&smc->conn.tx_work);
 			}
 		}
 		break;
diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index be241d53020f..7b0b6e24582f 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -597,27 +597,32 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	return rc;
 }
 
-/* Wakeup sndbuf consumers from process context
- * since there is more data to transmit
- */
-void smc_tx_work(struct work_struct *work)
+void smc_tx_pending(struct smc_connection *conn)
 {
-	struct smc_connection *conn = container_of(to_delayed_work(work),
-						   struct smc_connection,
-						   tx_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	int rc;
 
-	lock_sock(&smc->sk);
 	if (smc->sk.sk_err)
-		goto out;
+		return;
 
 	rc = smc_tx_sndbuf_nonempty(conn);
 	if (!rc && conn->local_rx_ctrl.prod_flags.write_blocked &&
 	    !atomic_read(&conn->bytes_to_rcv))
 		conn->local_rx_ctrl.prod_flags.write_blocked = 0;
+}
+
+/* Wakeup sndbuf consumers from process context
+ * since there is more data to transmit
+ */
+void smc_tx_work(struct work_struct *work)
+{
+	struct smc_connection *conn = container_of(to_delayed_work(work),
+						   struct smc_connection,
+						   tx_work);
+	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 
-out:
+	lock_sock(&smc->sk);
+	smc_tx_pending(conn);
 	release_sock(&smc->sk);
 }
 
diff --git a/net/smc/smc_tx.h b/net/smc/smc_tx.h
index 07e6ad76224a..a59f370b8b43 100644
--- a/net/smc/smc_tx.h
+++ b/net/smc/smc_tx.h
@@ -27,6 +27,7 @@ static inline int smc_tx_prepared_sends(struct smc_connection *conn)
 	return smc_curs_diff(conn->sndbuf_desc->len, &sent, &prep);
 }
 
+void smc_tx_pending(struct smc_connection *conn);
 void smc_tx_work(struct work_struct *work);
 void smc_tx_init(struct smc_sock *smc);
 int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len);
-- 
2.32.0.3.g01195cf9f

