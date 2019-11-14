Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8585DFC56C
	for <lists+linux-s390@lfdr.de>; Thu, 14 Nov 2019 12:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbfKNLeE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Nov 2019 06:34:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38871 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKNLeC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 06:34:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id z19so5504347wmk.3
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hXXV/2kIvB08deAA2EN09TWub+GXZhxQylBGV0wly2o=;
        b=kiaWUZshTXZr77I5eM6Iord4uC+esCXUajeEDu2SLSeAXVtTQJxNXvn/FQxeDmINbP
         hT17ITCVf33E7Nuo5Pa2+FdnKKivHy4MyMPQj4CZH8O0ULOonqs1/Mepgy1lCxDcDDPo
         upBGlMw+9BhH8O2H4d2RY0V+vFjd6vM0zb3QqRYrGGOiaEwfmpMMoyhldK6cQ8vgcDHo
         9zQTdLi2HBjEGiZY49KODbfy6ti/XQ9hA8mH2PPqLNLouCSyZXIFF4NW8Y5QNvIW/7Yd
         /8KJ42P5CDv61U5sOVP7bcOPKI3zBjG5FL6it8hU7ucv8Nz4lbnbLUSrjLtHXxwnRcX7
         oNDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hXXV/2kIvB08deAA2EN09TWub+GXZhxQylBGV0wly2o=;
        b=nE8+aJv4ZdPjR9IcbLqHseQroGxMNr1sCHsM7NaGKd27GYugyf+OTWDQ0VjC+0YqH4
         zanZ4I8AtTXdrKZijDFeIYhdbZ61NfwKI/EI9FhsI51RA7bUYgqYa689e1gMM8ukT+8J
         /4OA8W5eeYrx01VLi7HeVAK+OpRyz02TFjUQZq5/MPBqQlkcNCmxzoRs+ssY9UCQ3/eX
         S6ok8n2dAzWPUAIwdi7LlqDxXv+Pld+ZWHFqPQ2GVa8C1e+WrcDrzTzkkz5rkEl+ckmz
         0hjp4myCWx8af5M2XLwTjv/GvdaoDmrGOvy+otIL/6/hHS/EuzH9DXv8MyQSxluHYp82
         5nvg==
X-Gm-Message-State: APjAAAXnVAGRqeDN06odCcpXlqQX3lj/1D30TwvhsKWXmTTMQu6aoXSh
        SziudvHI2ElJThZ66M8RU6d2jA==
X-Google-Smtp-Source: APXvYqwa7C+SZPaRzDCDqgtRRX+BdBhI757ORIAlSyB2X3yAtBSVEylfezUJgRJyC7Xi8Z+nZfWaVw==
X-Received: by 2002:a05:600c:230d:: with SMTP id 13mr6806183wmo.159.1573731239464;
        Thu, 14 Nov 2019 03:33:59 -0800 (PST)
Received: from localhost.localdomain (184.red-37-158-56.dynamicip.rima-tde.net. [37.158.56.184])
        by smtp.gmail.com with ESMTPSA id m187sm3324275wmf.35.2019.11.14.03.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:33:58 -0800 (PST)
From:   richard.henderson@linaro.org
To:     linux-crypto@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH] random: Make  RANDOM_TRUST_CPU depend on ARCH_RANDOM
Date:   Thu, 14 Nov 2019 12:33:46 +0100
Message-Id: <20191114113346.25138-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Richard Henderson <richard.henderson@linaro.org>

Listing the set of host architectures does not scale.
Depend instead on the existance of the architecture rng.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 drivers/char/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index df0fc997dc3e..3c2123a23600 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -539,7 +539,7 @@ endmenu
 
 config RANDOM_TRUST_CPU
 	bool "Trust the CPU manufacturer to initialize Linux's CRNG"
-	depends on X86 || S390 || PPC
+	depends on ARCH_RANDOM
 	default n
 	help
 	Assume that CPU manufacturer (e.g., Intel or AMD for RDSEED or
@@ -559,4 +559,4 @@ config RANDOM_TRUST_BOOTLOADER
 	device randomness. Say Y here to assume the entropy provided by the
 	booloader is trustworthy so it will be added to the kernel's entropy
 	pool. Otherwise, say N here so it will be regarded as device input that
-	only mixes the entropy pool.
\ No newline at end of file
+	only mixes the entropy pool.
-- 
2.17.1

