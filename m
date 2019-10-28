Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC07E7AD9
	for <lists+linux-s390@lfdr.de>; Mon, 28 Oct 2019 22:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbfJ1VGI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 28 Oct 2019 17:06:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54838 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389550AbfJ1VGG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 28 Oct 2019 17:06:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id g7so409210wmk.4
        for <linux-s390@vger.kernel.org>; Mon, 28 Oct 2019 14:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5fdqGpsTwRZzstj7gG8G4eynLpsoyPuwBiWzvUXzIcI=;
        b=d90aNC76Z65wi1qyl4LR/h4h7b/L01Zgboc3RhCWk336Xyh2t5COYQWc8Spj8aNKpV
         3IyU7rkdlbyrL3VcFzY+XJ0RDwDeU3uSGnBYVF/YtkpR+1e7LGzNrEKbXy3HKezmhyX6
         H/npgaJyq1LNevmp89zjnlO59XFdrIs9YoC6m6KyDfA03KrQqN3cTGb8VGgTN1rtIVab
         89vt+61pZYpoN26FQgwmaYsJ3Mn8VipHO5aQbJrzadfNwXSFdjqeoBiOLQ7vhnusaXk5
         5KaaUq9OKtTFWQnMNKFg+qAhaTnMZndhT+qW5eG6A9AZl8DolLQ4sFKvJnv/K0i3Mkt4
         rQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5fdqGpsTwRZzstj7gG8G4eynLpsoyPuwBiWzvUXzIcI=;
        b=q89ROD++4QH2ZcsUIJHVaZow46HQjLHI5bwchJ//oM0jzWi97jjzd3c9HwYLTNvHSJ
         zN+6SnMqd6MsCl3+zftjcv3fY4KOljvOwh4zPXxvJjipO7zuo8/lWz2itPLJDIoARpDa
         csFYzoyCiAMNNF5weQZXduE9/w46KzfDeXEmV0YfHbc2lQgKeCYVRPobQ2eeEgvTvO+o
         COhBbCdsMkVh7eDNfT/w3Nc2v7BmbPXzeZNPZJ3Mf4c0+vwfOPRKvSq0ZHkrwYFfZ29L
         cEgbB44xnQOFr64iYctwG9QV1q4KFYeNXBsR4+BErMKWL5T/Z0/yqh2cY61fhr/Qo+np
         bSjQ==
X-Gm-Message-State: APjAAAWIMdm4MwBoq9N5AuwvE2btQa+J3Z29DD7MYCZThsZszvJzy6GB
        NYnslGmiT+YR5wMyAkq+3+43zA==
X-Google-Smtp-Source: APXvYqzrmbIZmiYJeRI8foiZBFn/3gbaj86T1/tVP1Bb5VrPLCuZQ0g/WmL7p4dJ4/LUsgNkETKzXA==
X-Received: by 2002:a05:600c:2908:: with SMTP id i8mr1147516wmd.142.1572296763797;
        Mon, 28 Oct 2019 14:06:03 -0700 (PDT)
Received: from localhost.localdomain (230.106.138.88.rev.sfr.net. [88.138.106.230])
        by smtp.gmail.com with ESMTPSA id b196sm927822wmd.24.2019.10.28.14.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 14:06:03 -0700 (PDT)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-arch@vger.kernel.org
Cc:     x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/6] random: Mark CONFIG_ARCH_RANDOM functions __must_check
Date:   Mon, 28 Oct 2019 22:05:54 +0100
Message-Id: <20191028210559.8289-2-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191028210559.8289-1-rth@twiddle.net>
References: <20191028210559.8289-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

We cannot use the pointer output without validating the
success of the random read.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
Cc: Kees Cook <keescook@chromium.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org
---
 include/linux/random.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index f189c927fdea..84947b489649 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -167,11 +167,11 @@ static inline void prandom_seed_state(struct rnd_state *state, u64 seed)
 #ifdef CONFIG_ARCH_RANDOM
 # include <asm/archrandom.h>
 #else
-static inline bool arch_get_random_long(unsigned long *v)
+static inline bool __must_check arch_get_random_long(unsigned long *v)
 {
 	return 0;
 }
-static inline bool arch_get_random_int(unsigned int *v)
+static inline bool __must_check arch_get_random_int(unsigned int *v)
 {
 	return 0;
 }
@@ -179,11 +179,11 @@ static inline bool arch_has_random(void)
 {
 	return 0;
 }
-static inline bool arch_get_random_seed_long(unsigned long *v)
+static inline bool __must_check arch_get_random_seed_long(unsigned long *v)
 {
 	return 0;
 }
-static inline bool arch_get_random_seed_int(unsigned int *v)
+static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
 {
 	return 0;
 }
-- 
2.17.1

