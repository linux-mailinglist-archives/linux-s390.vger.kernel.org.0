Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AE92B7BE1
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 11:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKRKyG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 05:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbgKRKyF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C09C061A4D
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 02:54:04 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605696840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQIch/QUDy0PFTzkj/1r5k0RynRFmMasRxIEVWtftDI=;
        b=2ocjmuTAiEv5xYmrSY34v9uSkzHYGWkFINhoqqrQ88hoyCcTp3oYH4P9ArUbaqiE22+YKU
        uTbm4jxGS8O0EEne1qM6TI7mPMG8o42Ep/eaEg4CHWkdMzojkHQIXpp/StZvP6569o5mM1
        p+gsWBIYHyEA5re3hjI6HAFIA8cZZdegpLjHcGy8nAzM449q06erGyQlpxcmebeUsgcrHb
        2a1SU7XtBAFn4qnR7XsdN7MndhxCL3XOwkMg7dVVFBzBhM2ZWQDWpNuJKxmI7DAnGIrUzb
        zdr4/pgv/adnKFCZO5mJDysYLTlEEx2cFHhGIj1bUiVodyJxGYTaVpVaLSPkuw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605696840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQIch/QUDy0PFTzkj/1r5k0RynRFmMasRxIEVWtftDI=;
        b=wqmfJ9Yjp9X1DcWhQHEEQJQrYlmG0vmP2QxrDBLE05JoroUxHAfWCFQyq90vqr6UbQT9bL
        4Gp9i3CRgZwD0UAw==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/6] s390/ctcm: Put struct qllc on stack.
Date:   Wed, 18 Nov 2020 11:53:13 +0100
Message-Id: <20201118105317.605671-3-bigeasy@linutronix.de>
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The size of struct qllc is 2 byte. The memory for is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and keeping the
variable on stack. Especially since the compiler is smart enough to not
allocate the memory on stack but assign the values directly.

Rename `qllcptr' to `qllc' and use it on stack.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 04a51cc89e74c..4ff51af44d338 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -2049,11 +2049,10 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm,=
 int event, void *arg)
  */
 static int mpc_send_qllc_discontact(struct net_device *dev)
 {
-	__u32	new_len	=3D 0;
 	struct sk_buff   *skb;
-	struct qllc      *qllcptr;
 	struct ctcm_priv *priv =3D dev->ml_priv;
 	struct mpc_group *grp =3D priv->mpcg;
+	struct qllc	qllc;
=20
 	CTCM_PR_DEBUG("%s: GROUP STATE: %s\n",
 		__func__, mpcg_state_names[grp->saved_state]);
@@ -2080,31 +2079,20 @@ static int mpc_send_qllc_discontact(struct net_devi=
ce *dev)
 	case MPCG_STATE_FLOWC:
 	case MPCG_STATE_READY:
 		grp->send_qllc_disc =3D 2;
-		new_len =3D sizeof(struct qllc);
-		qllcptr =3D kzalloc(new_len, gfp_type() | GFP_DMA);
-		if (qllcptr =3D=3D NULL) {
-			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
-				"%s(%s): qllcptr allocation error",
-						CTCM_FUNTAIL, dev->name);
-			return -ENOMEM;
-		}
-
-		qllcptr->qllc_address =3D 0xcc;
-		qllcptr->qllc_commands =3D 0x03;
-
-		skb =3D __dev_alloc_skb(new_len, GFP_ATOMIC);
=20
+		skb =3D __dev_alloc_skb(sizeof(struct qllc), GFP_ATOMIC);
 		if (skb =3D=3D NULL) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
 				"%s(%s): skb allocation error",
 						CTCM_FUNTAIL, dev->name);
 			priv->stats.rx_dropped++;
-			kfree(qllcptr);
 			return -ENOMEM;
 		}
=20
-		skb_put_data(skb, qllcptr, new_len);
-		kfree(qllcptr);
+		qllc.qllc_address =3D 0xcc;
+		qllc.qllc_commands =3D 0x03;
+
+		skb_put_data(skb, &qllc, sizeof(struct qllc));
=20
 		if (skb_headroom(skb) < 4) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
--=20
2.29.2

