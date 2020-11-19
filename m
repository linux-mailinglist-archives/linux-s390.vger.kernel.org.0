Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB922B93F6
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgKSN53 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbgKSN52 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B6EC0613D4
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2020 05:57:28 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzwN5zDxXYrRSPyltZOc6bRdfTxPJA8iudrpy3yAP54=;
        b=kRbdD4oMNLev71Q/pjBDV+NrjDkZVBnEjbOL+sMX3hVkxXJR1yPSUtYEwO3+eF9yGTSJfY
        LWZuhz9I8R1vj5rx/66dwagXZVMnzKqaHmhjRRXvK8guZCgxQrksMUJSnS1Jb6wrwmBmvm
        0bQ+7GtOMZxod2GaqC8JBaIfRDy5SyRPjOtzugRMiL6B+3Aw29KjBScVCtYter3dpBKxgo
        UyLA32wTXURfU1O9fFh//+Mm5wJmsDpxOO96Ti0/J3kertD2Rzhdts15Ss5zkwpETJAvoi
        T28tvx4y0t27SC7i8Ta2q2cNsMDjPeSOLZ3GguLrrtZXD8jH3Ph61t/qbdeHqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LzwN5zDxXYrRSPyltZOc6bRdfTxPJA8iudrpy3yAP54=;
        b=TKnhtcDsO2X1F0QfOQHgx59Ow9Ztr4kapc0ns3r5SG7RoDNAGQH93H0kcOUnDWEk3kIx86
        FoKH07ib2kcx7YDA==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/6] s390/ctcm: Avoid temporary allocation of struct qllc.
Date:   Thu, 19 Nov 2020 14:57:14 +0100
Message-Id: <20201119135719.983170-3-bigeasy@linutronix.de>
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The size of struct qllc is 2 byte. The memory for is allocated, initialized,
used and deallocated a few lines later.

It is more efficient to avoid the allocation/free dance and assign the
values directly to skb's data part instead of using memcpy() for it.

Avoid an allocation of struct qllc and use the resulting skb pointer instea=
d.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 0929ff2fd5c1a..76a9e0d0c0710 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -2049,7 +2049,6 @@ static void mpc_action_rcvd_xid7(fsm_instance *fsm, i=
nt event, void *arg)
  */
 static int mpc_send_qllc_discontact(struct net_device *dev)
 {
-	__u32	new_len	=3D 0;
 	struct sk_buff   *skb;
 	struct qllc      *qllcptr;
 	struct ctcm_priv *priv =3D dev->ml_priv;
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
+
+		qllcptr =3D skb_put(skb, sizeof(struct qllc));
+		qllcptr->qllc_address =3D 0xcc;
+		qllcptr->qllc_commands =3D 0x03;
=20
 		if (skb_headroom(skb) < 4) {
 			CTCM_DBF_TEXT_(MPC_ERROR, CTC_DBF_ERROR,
--=20
2.29.2

