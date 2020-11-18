Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A8F2B7BDF
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgKRKyF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 05:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgKRKyF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:05 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BD5C0613D4
        for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2020 02:54:04 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw68nSaxy2DsM5p8c/067XJiHi9tEZghD2ewgHNVX+c=;
        b=m8Ta1TCaLqOaON/O1QH/dd0CueQ03HZ+LNIvzD6TB8a/OUfviOGnbvloquEWWliLjuuWeO
        ugEng6N4poP7KrL9d8uz5kadcl9sLlHG+eRh1Uqfi6y6lOwAJ/KajQLtlv/ZT5WHBdwLF2
        xyWr59hDpM1QnQgJMv8R/mnu2zY158T0wR2+V1Qy30+3RVaMXgPExXQuHMgPRVamdrEg02
        awfyOzuF9xKPw4DE6smby1w9+8I5YMzWHkM5c2uz8+s0yJhKm02PO0AoRXjGq3QM4UVCms
        uTd+SKXxX03Gu9DDdxVWbbKcqcUpE75Yv9S55dVhNKgiV8G+uJ1S1ImJdASdXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kw68nSaxy2DsM5p8c/067XJiHi9tEZghD2ewgHNVX+c=;
        b=x+zvECIM1ltpTRAOOEZuHGt1Ex2//uVmfjCm31FsvK/Lkx72Xsr40wvS93QN0mdnI7jcNO
        fcbMcwXIovT7BLDA==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 6/6] s390/ctcm: Use GFP_ATOMIC in ctcmpc_tx().
Date:   Wed, 18 Nov 2020 11:53:17 +0100
Message-Id: <20201118105317.605671-7-bigeasy@linutronix.de>
In-Reply-To: <20201118105317.605671-1-bigeasy@linutronix.de>
References: <20201118105317.605671-1-bigeasy@linutronix.de>
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

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 drivers/s390/net/ctcm_main.h | 5 -----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index ca218489e0be4..ee5c3981c0061 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -905,7 +905,7 @@ static int ctcmpc_tx(struct sk_buff *skb, struct net_de=
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

