Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E67615D8C7
	for <lists+linux-s390@lfdr.de>; Fri, 14 Feb 2020 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgBNNvj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Feb 2020 08:51:39 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41679 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgBNNvi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 08:51:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id j9so4923742pfa.8
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 05:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rv1ZG70VJM4cecj0RUqEn63+ZwDOcQfIvz06DQDDe98=;
        b=HtR3ub45NmCrRKKvtsPa8UdaxXxYSMkxuxmDZDDii2+y6sGIe9dKOKEuBOqTNuBSXf
         LHwz5TH5Qd0LoXl34ym3bhnNKRcD1FkeWhO7VwAWo2kcoCXwukrs6BKJRrO8tpoo5y0D
         qg/nVFOxlBvCQ/3KJoYFLhLObadT2d3ie9r2IkRb0yuHQ4G1j/ZF8Y18yaAL/9LxelFX
         VL4CDWdBY31odywl9yZdurpPEbh8IA/fCSul0D8THE0wRQRDgRtzy0oHN9nB0midMcJw
         4+Kne/6az0/iexShTwvjUhhyovn9fR6uz/GYKAhmkAAJuemVzm3guF3FFiZ1Nt7bcZ8u
         pWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rv1ZG70VJM4cecj0RUqEn63+ZwDOcQfIvz06DQDDe98=;
        b=Hnnn7Zy7iGEnRGoVDbqzKXBEJm9dx17tNOwa5DczAM53oTBlIxae/2I44tBrfiDvII
         TTCn7+pGwe8bUr950dIF6gBhsYn4ne+8havVyWd+YBRrjWbu9Yu3/SdBN7IlkJqRkTQK
         4WqlTuVjgqq2f4lADqvQuumRk17lgte2KgKHsgjDb2moSLscHOzZiWiPlvUZEigEaknF
         hy10yjdag/ff0Dv6NeomVaix1ODEv07aq4anLV8aIRNWiRpOUIGP1q6xfJ+2perWJzkg
         obxY4FDuJv6ll0trYPR8iy43O/eZO+2V970OY+iD4e1k9Hki2tVUnhA8KKt97P7b6pUZ
         MnbA==
X-Gm-Message-State: APjAAAX6bbGZKop30ktSjrftS4ApBFuKK4jP0jcRhM6Uit1h8IMEkZ9S
        U8TcPutZaxmbyxAIiEl/T1o=
X-Google-Smtp-Source: APXvYqz5PUqqm32WrktmeThe1QSoSknnb2hRUhvIjesCsEOuaU8cIEGhGD6dWi5wN6Qph9OAuHTERw==
X-Received: by 2002:a63:5f8e:: with SMTP id t136mr3514954pgb.411.1581688298248;
        Fri, 14 Feb 2020 05:51:38 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id x28sm7197547pgc.83.2020.02.14.05.51.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 05:51:37 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>,
        chenqiwu <qiwuchen55@gmail.com>
Subject: [PATCH v2] s390/cio: use kobj_to_dev() API
Date:   Fri, 14 Feb 2020 21:51:33 +0800
Message-Id: <1581688293-17283-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use kobj_to_dev() API instead of container_of().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Signed-off-by: chenqiwu <qiwuchen55@gmail.com>
---
changes in v2:
 - add signed off for my gmail adderss.
--- 
 drivers/s390/cio/chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 51038ec..dfcbe54 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -135,7 +135,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
 	struct channel_path *chp;
 	struct device *device;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	if (chp->cmg == -1)
 		return 0;
@@ -184,7 +184,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
 	struct device *device;
 	unsigned int size;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	css = to_css(chp->dev.parent);
 
-- 
1.9.1

