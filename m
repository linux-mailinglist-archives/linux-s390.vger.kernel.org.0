Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D872B93FA
	for <lists+linux-s390@lfdr.de>; Thu, 19 Nov 2020 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgKSN5a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Nov 2020 08:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbgKSN53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Nov 2020 08:57:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D493C0613CF
        for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2020 05:57:29 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zxke28TtfO0JNYoIKGt/TuSDo9QLSIOk8rafEZ14XE=;
        b=v2Z15WetPU3GeT7/G3/YcnOoTcIRlVQsir+VIvdPV3SkWjwQwvbpSGKWnfhNGhV1muZ7ny
        Lay+RJe4uV9ggcTVsxWn6HfLqaKqj2SycVQmDI20bFZOwLqDbM+dEZpf6cmi41MvrcTBKx
        6XQ95rVHMdANIxYw/MrCtEgKKoY/T7JydAWPbcV46BrdEJZc0/xQ6D98wh7iMk7XvSvDqY
        f+/4ICTcMFRhOgBXIUQ2AL/JrMneWoNLnh3wVTO9Iv6GEYv8xXaHM4nxClKDzLK181XJsw
        a/OPEuofDQdGDNO2PRUwFV0Q5xYlNbfrPqtut/aIb06j6S7kgO2jhnHaEcARaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605794248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zxke28TtfO0JNYoIKGt/TuSDo9QLSIOk8rafEZ14XE=;
        b=f4g+Q4m1K6AeSpNIYJ2kjUceLzfeiHWM05xeVs40YDk6cmdaX4rMHF48olUmaj8NIavWst
        /26R8ct8+YoFBkBw==
To:     linux-s390@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 5/6] s390/ctcm: Use GFP_KERNEL in add_channel().
Date:   Thu, 19 Nov 2020 14:57:17 +0100
Message-Id: <20201119135719.983170-6-bigeasy@linutronix.de>
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

The memory allocation of `ch' a few lines above is using GFP_KERNEL,
also an allocation a few lines later is using GFP_KERNEL.

Use GFP_KERNEL for the memory allocation.

Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/s390/net/ctcm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 0cb130c280031..88efffe81c5ff 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1322,7 +1322,7 @@ static int add_channel(struct ccw_device *cdev, enum =
ctcm_channel_types type,
=20
 	ch->protocol =3D priv->protocol;
 	if (IS_MPC(priv)) {
-		ch->discontact_th =3D kzalloc(TH_HEADER_LENGTH, gfp_type());
+		ch->discontact_th =3D kzalloc(TH_HEADER_LENGTH, GFP_KERNEL);
 		if (ch->discontact_th =3D=3D NULL)
 					goto nomem_return;
=20
--=20
2.29.2

