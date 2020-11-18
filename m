Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 896B72B7BDD
	for <lists+linux-s390@lfdr.de>; Wed, 18 Nov 2020 11:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgKRKyD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 18 Nov 2020 05:54:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgKRKyC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 18 Nov 2020 05:54:02 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1QlPsBgPvrBYpulPq+LhfHyZz5kWXu8lMwqn5ZhU7E=;
        b=dt/XfWstgwK7feVKs7TzCVNgVSPfU85tQi6T7GsWPGkqLtxRcqoryuBK0ClVrS3Y1ay6Tf
        f+Y13Z4Ur2wNuzhp2Wm14/EIO/+/Vfh61Sbkozps1UV2EPlxS1rKyCnJP6wOrcm3W9/sHu
        fxwLXULUZYLV0IpP5Pzr7VO6OR31SEk9YuyCFjmKx9U78mW9UbayF9k7QTtpL94zww1nKK
        C7MjeGzINHjNCOvZKoUeW6/VwX85D60ynORiBDVAOY4jkCaVJrVCEZfVEUse4DN0o1RFlC
        P1cY0Ds06KC3WMeIMzZrSrfBdVDDV5mxHaciVyQHJ5poGdKXtaB+lscXjmQn/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605696841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e1QlPsBgPvrBYpulPq+LhfHyZz5kWXu8lMwqn5ZhU7E=;
        b=k73ET1fti7hZLO7ja63mpeKIdzSYQSpyPDSAdZ2JRM6FTygXaTiIbrTot0MqCQHjX1nFsa
        SxtWgmnSUQxUgBBg==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/6] s390/ctcm: Use explicit allocation mask in ctcmpc_unpack_skb().
Date:   Wed, 18 Nov 2020 11:53:15 +0100
Message-Id: <20201118105317.605671-5-bigeasy@linutronix.de>
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

The call chain of ctcmpc_unpack_skb():
ctcmpc_bh()
 -> ctcmpc_unpack_skb()

ctcmpc_bh() is a tasklet handler so GFP_ATOMIC is needed.

Use GFP_ATOMIC as allocation type in ctcmpc_unpack_skb().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 4ff51af44d338..38c535f016363 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -1164,7 +1164,7 @@ static void ctcmpc_unpack_skb(struct channel *ch, str=
uct sk_buff *pskb)
 			skb_pull(pskb, new_len); /* point to next PDU */
 		}
 	} else {
-		mpcginfo =3D kmalloc(sizeof(struct mpcg_info), gfp_type());
+		mpcginfo =3D kmalloc(sizeof(struct mpcg_info), GFP_ATOMIC);
 		if (mpcginfo =3D=3D NULL)
 					goto done;
=20
--=20
2.29.2

