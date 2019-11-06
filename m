Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88983F1822
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 15:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbfKFOOB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Nov 2019 09:14:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51806 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731921AbfKFONl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id q70so3627985wme.1
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EtW7c5+Vxuw361NPgarxEa4pkxF91xrS2XEr4qnN4jI=;
        b=e5nNk39VJ5IOgRqdcXf58JkLAmLsag2O4+U458JjYo5P0PSEMekSFRL7LZc2d3m3VJ
         URQyFUvE8jMn4eVvMtPS4S4bwU+o51HOhtfgwYme4dhoLAOHd8OHl1q5buqF/oxhumhw
         +z3jc1g7Ck1yBgoUiT30MrVfaQcI9SAZcV6//J2C/MjC41OM02IYNasElc3UDquPybqb
         baWyh7WRSDEfEhipTjcqjxsGo/IM/qSUCmUCE5UrGsB4dj0txgaPvPHy4E6e/8b6xTks
         +7wsbS1O4VTbwJoSISfsP2WPk3MvEuhRHnX4Tq6FkCgrC9KgWh7M7bDPmgQZAuRo+xGE
         Q0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EtW7c5+Vxuw361NPgarxEa4pkxF91xrS2XEr4qnN4jI=;
        b=jHoIdtSnYS6pxUKOUFi7f17okD2r4VnJd2SzvCsoMG+M4i9mVRX99O7Q8d6fLXmjPV
         +jw7Q142uS8eWtSTCmz6lAVKe9o0naH4ryGtj+nRFuA/FIcReHsgMezEvUynIvjP5OoJ
         C7KuwJ1jmUtGJgQmIRylkRkcQ1w6KjSZezKiuIakX1gOr7hbPWF/u2B+LvfsgpkhDpUF
         j30QwX8++3ejJk9utkdIB5vn0klf0bg82KYM+UnJxvuRqeW4DLNbocB5D8U2+Ji/0mh/
         ZwoECBa/cta+NKExe1UufF8FFLbsGd3lRvdWjfspHq5AdyXQ8oh3zujBg1lpJ4KGE65+
         C/KQ==
X-Gm-Message-State: APjAAAVZaX7W8eG1LFdBTiFgR8XGUfKXMwkUKbe5QMXduTWpP8c8+oPM
        C26l8J1fZuPYpALPqB0misZp5Q==
X-Google-Smtp-Source: APXvYqwQkS3HkPb4xqO71j4GDBQsJDOPu6hiWKUGgF3l2gy8AO8EiMAAlXbkknCw6t0pwT+ISh1RMQ==
X-Received: by 2002:a7b:c776:: with SMTP id x22mr2609658wmk.144.1573049619319;
        Wed, 06 Nov 2019 06:13:39 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:38 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 10/10] s390x: Mark archrandom.h functions __must_check
Date:   Wed,  6 Nov 2019 15:13:08 +0100
Message-Id: <20191106141308.30535-11-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We must not use the pointer output without validating the
success of the random read.

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/s390/include/asm/archrandom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/archrandom.h b/arch/s390/include/asm/archrandom.h
index 9a6835137a16..de61ce562052 100644
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@ -21,17 +21,17 @@ extern atomic64_t s390_arch_random_counter;
 
 bool s390_arch_random_generate(u8 *buf, unsigned int nbytes);
 
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return false;
 }
 
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
@@ -39,7 +39,7 @@ static inline bool arch_get_random_seed_long(unsigned long *v)
 	return false;
 }
 
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	if (static_branch_likely(&s390_arch_random_available)) {
 		return s390_arch_random_generate((u8 *)v, sizeof(*v));
-- 
2.17.1

