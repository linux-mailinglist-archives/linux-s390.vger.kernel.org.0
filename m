Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 849051287B8
	for <lists+linux-s390@lfdr.de>; Sat, 21 Dec 2019 07:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfLUGO3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 21 Dec 2019 01:14:29 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41822 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLUGO3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 21 Dec 2019 01:14:29 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so6040195pgk.8
        for <linux-s390@vger.kernel.org>; Fri, 20 Dec 2019 22:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTnZCv2aSGwJmyGwQM3YyM4zBrhZwLDodmQtAuyxwbs=;
        b=uIStqWHsY2Q0yPZJMb+1/Dvm8PC1uUZY6zBIPCIMzwVNT6hre/9QxCQYw9iYW+rTHb
         wM45nomeSMh0xJ6XvbPWYdfPo+czsfE/5Wj8t1+8s5vaXTCukSTyJrE3mKrSkfywORuj
         /99Q0stX5TC549E3MPNO4Mqs7Nzb71UKjw1sN4BnbVat8CLvazfsJIIP/1kVAVZFD6la
         fNJdjd+vYGPFFenq6ZqHoRcS3zE3bpV44WQtgJ6prFH/haGGpS+UjR8BP8GCXOZbMSoO
         BuZXA4XvdPhqrFUYk1zP+DQs4laQQLca1H8F/mOnXL+xlcmgH+CRAdMZllTcibbx/deR
         3jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lTnZCv2aSGwJmyGwQM3YyM4zBrhZwLDodmQtAuyxwbs=;
        b=KyXXfie1EVY+K/FpcVkD8oIf38Ixi1ncL7amwcEUIUfRHZzi8P4/Sq20Vmk3kPfYc+
         bK7063kJYwwUtlnoGEMwXJg25BaCSvangBmg4yC9NxJhRerWMHcW/bUkRmAui4C5vVom
         WycMTQnGOSU9TwrJQr24gtoBEnzanaBmfKmWkg3H8kVLpuR7qObv7DgKeMlMSvDsPFxy
         +lG67UcZ8jNj18c+d7GsF9t4gxsWK2szOBg5I+5wl/9MhJZdQdngjq5X6glHEYoAKtxJ
         0BlY0f0mLGX3F90x/DPs8BGSmdsCktMiufiF/6PmcclbZObUSrdeWPZTg4X8nNQvplSA
         0LbQ==
X-Gm-Message-State: APjAAAVjf5b8Xk9k6RAQr1zVzPTCPC6FQtxGDOohgDrY/sD0JaW5Cbvf
        MRzZcSmZMvTFFr2W0ebl3/lQiEv954I=
X-Google-Smtp-Source: APXvYqyqW9eABkcIhvBlPcFhIIQpva9r5d23KReH4J+vlaggEKLdOs7pIJ/MXkxTFzb1gJbZsWZXfA==
X-Received: by 2002:a63:d848:: with SMTP id k8mr18191514pgj.114.1576908868439;
        Fri, 20 Dec 2019 22:14:28 -0800 (PST)
Received: from localhost.localdomain ([240f:31:945c:1:dc69:5342:c32f:f3e1])
        by smtp.gmail.com with ESMTPSA id i22sm13514473pfd.19.2019.12.20.22.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 22:14:27 -0800 (PST)
From:   maholova <maholova.wda@gmail.com>
To:     linux-s390@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, maholova <maholova.wda@gmail.com>
Subject: [PATCH] s390: IEEE FPU emulation error in Kernel-3.16.y
Date:   Sat, 21 Dec 2019 15:12:54 +0900
Message-Id: <20191221061253.31997-1-maholova.wda@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: maholova <maholova.wda@gmail.com>
---
 arch/s390/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index c5762324d9ee..fda8b571466e 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -19,6 +19,8 @@
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include "entry.h"
+#include <asm/mathemu.h>
+
 
 int show_unhandled_signals = 1;
 
-- 
2.20.1

