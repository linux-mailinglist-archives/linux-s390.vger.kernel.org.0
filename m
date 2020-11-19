Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37D62B93F8
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKSN53 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33832 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgKSN53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:29 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgsMQYV7shQIjw0yMtHxsulSxvodV9Nwz7TYQfaJ5KI=;
        b=4mo4Td7WcTPDJSh0O9MdFBMuTdrCBqUv/RurnaFV5/Bquc2WX//QEugHO0WIzwRWiD//Tq
        gM6sd72f0MYQNbjROMot0PCc+0WUDa/+qNMSbBmhPX0ZOlD7ZkIiUQc1RfjKfrVos1wLgK
        /30DVGmn/Y8ddMIo7FNCw9Wy5/qZ/hOO9Wjut91fDBjTm+12zdu/Xj3X/XAIKM+ocwUJzE
        GJ+oyWAsmoZfMbSO/i139icSQ0hhGN49J0ZK6v3HYtkfnURimuhlBEJ0Zic12EYWuC79LZ
        Psgy7d1QAgdDCfJW05D77d6e0CEn3k54ezx26HJd2CHfXHN5VmA2yAY52HEMiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JgsMQYV7shQIjw0yMtHxsulSxvodV9Nwz7TYQfaJ5KI=;
        b=3rkifBBks/ykCp07ihDejHO1WmC826HTSEdHbdXcg3g2ST0I7jCadSEMh8GqlS23SmlxDu
        cIkgu7Cye4r/sWBw==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/6] s390/ctcm: Use explicit allocation mask in ctcmpc_unpack_skb().
Date:   Thu, 19 Nov 2020 14:57:16 +0100
Message-Id: <20201119135719.983170-5-bigeasy@linutronix.de>
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

The call chain of ctcmpc_unpack_skb():
ctcmpc_bh()
 -> ctcmpc_unpack_skb()

ctcmpc_bh() is a tasklet handler so GFP_ATOMIC is needed.

Use GFP_ATOMIC as allocation type in ctcmpc_unpack_skb().

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 76a9e0d0c0710..829deeedf21a2 100644
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

