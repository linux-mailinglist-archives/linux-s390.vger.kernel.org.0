Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D962B93FB
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbgKSN5a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbgKSN5a (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:30 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdfhgkXEY/MyPqFyvIUXzuTPc0RiPbOsHtkUhRnoEVA=;
        b=nuOARc9KzSD7DOIpWJnZ329rI33RTmphZrLcpqftz5niPt91oa6wleDx8yr1LDG4O+sPQD
        Zo5MqCNkhYwHPzmJS6JAo6jPDwMx2gUMqs0yprjjiFP7cyO01t4qmQDgOq/mL6o8f4xxNs
        zzUdYIODZyi8fVHWK5OlmiC2atRcGyPIpCYbkdmikfiRj4E6jNdUMlX0gZeqAyAATwEGIf
        6+mHrANY9IFGj32zHfV7yLE2HMWOXXoj4ad/PEnvV86VGjVjXh5CXySNLEOH8p7M4SWIzO
        ck95P65EZEWrGKrmqypBlcCq1ZIqLNTf9TzbX8dVQ8o6sjxm1Y84Ug13j4fS7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VdfhgkXEY/MyPqFyvIUXzuTPc0RiPbOsHtkUhRnoEVA=;
        b=tJPHo4nTnl6kITVXDbFz8qx+wBHHUs+9SXagFrbIJ/JZmMEGNT2lekGTyE7RKIe7nLPrgx
        Rn/TmLiDMsd71DBw==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 6/6] s390/ctcm: Use GFP_ATOMIC in ctcmpc_tx().
Date:   Thu, 19 Nov 2020 14:57:18 +0100
Message-Id: <20201119135719.983170-7-bigeasy@linutronix.de>
In-Reply-To: <20201119135719.983170-1-bigeasy@linutronix.de>
References: <20201119135719.983170-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

gfp_type() uses in_interrupt() to figure out the correct GFP mask.

The usage of in_interrupt() in drivers is phased out and Linus clearly
requested that code which changes behaviour depending on context should
either be separated or the context be conveyed in an argument passed by the
caller, which usually knows the context.

ctcmpc_tx() is used as net_device_ops::ndo_start_xmit. This callback is
invoked with disabled bottom halves.

Use GFP_ATOMIC for memory allocation in ctcmpc_tx().
Remove gfp_type() since the last user is gone.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 drivers/s390/net/ctcm_main.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 88efffe81c5ff..59e491b344fa9 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -904,7 +904,7 @@ static int ctcmpc_tx(struct sk_buff *skb, struct net_de=
vice *dev)
 		CTCM_D3_DUMP((char *)skb->data, min_t(int, 32, skb->len));
=20
 		len =3D  skb->len + TH_HEADER_LENGTH + PDU_HEADER_LENGTH;
-		newskb =3D __dev_alloc_skb(len, gfp_type() | GFP_DMA);
+		newskb =3D __dev_alloc_skb(len, GFP_ATOMIC | GFP_DMA);
=20
 		if (!newskb) {
 			CTCM_DBF_TEXT_(MPC_TRACE, CTC_DBF_ERROR,
diff --git a/drivers/s390/net/ctcm_main.h b/drivers/s390/net/ctcm_main.h
index 16bdf23ee02b1..90bd7b3f80c31 100644
--- a/drivers/s390/net/ctcm_main.h
+++ b/drivers/s390/net/ctcm_main.h
@@ -298,11 +298,6 @@ struct mpc_group *ctcmpc_init_mpc_group(struct ctcm_pr=
iv *priv);
 /* test if struct ctcm_priv of struct net_device has MPC protocol setting =
*/
 #define IS_MPCDEV(dev) IS_MPC((struct ctcm_priv *)dev->ml_priv)
=20
-static inline gfp_t gfp_type(void)
-{
-	return in_interrupt() ? GFP_ATOMIC : GFP_KERNEL;
-}
-
 /*
  * Definition of our link level header.
  */
--=20
2.29.2

