Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0428F1827
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 15:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbfKFOOA (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Nov 2019 09:14:00 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731687AbfKFON2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 09:13:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id q130so3523196wme.2
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 06:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gp6KNxHNYtmFYMKMCYa0gsOo8NLakQXjLI1+wdZrrFY=;
        b=Opt6blMOd91CMO9Sq9Y5A3q4PwF3GSjNzIXhSluaGOyG+rbDxGLdCQGbPVE5bXKBKZ
         aiLXzj4m6i5ZQoTXpmx5rChqonOJISLaMtdj1+byk7Lr8lPtDs28C0jlPzGHMMtEbZmm
         7dm9d8IvcXzRGMnZAKYMbPIBPY2bDTOk49lIHT4bFr5KqZ5prLSSgXUOv6jUPSLjGUYR
         6DJPE/b5BRZTkL0wI0LsgP3k3jLyGQ9uB69hYUuVFG9xxRxpoVLOxmiRAUjNlawvAFIn
         cXqLhSYYSbeV1YOl+1KwcdK62FIuDKKMLAF0JTvEXftqvOXeMxpVSFsKMNrZ9n/m2c0V
         I1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gp6KNxHNYtmFYMKMCYa0gsOo8NLakQXjLI1+wdZrrFY=;
        b=rwC6Rmc8ZNQALo3scqfmYAzX8urfXlorH2SW6pssSSVLxnXbAX6ATQ25w4VUhc+dM+
         rww8g7iSX/LolFkA+AuktJjNbb3TalxEZhjuPzNLuJnLIdj742PnxZ4N+s6n9IwYVT9P
         oPqCCa4OP+uFCd8UrTH1/VeF6vuv2Ks9QWta51DdmD6S4fA03rSL2QWPNBFMdp4VHHjj
         g5ZzbHN9XA8MrrAaD8Qc90t8CieZ1D+IS16l8+5gLGKA2ry/u4oR3CPwhcLWSu4jm2xQ
         7DUw4gXPHgXLs+SFA7mEiLjElcvJDkjfaHzzMNh5eQhpMZXkWnIAkJXqm9hMKU3eQnw3
         iI0Q==
X-Gm-Message-State: APjAAAXfQk/rixwwoSgm9nrY6SsPIRwsMP/lv69mvuYa1c32HHEe2iQB
        0hw24cEsml7DfJK/TmOGqPaJ7g==
X-Google-Smtp-Source: APXvYqxzkw9+rREvmeedrYS01ECAtNQ4De91+b1ooIUzZfNnnzCG5td8seHkoCoHaz61lQ9u/onNCg==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr2820695wmk.88.1573049605900;
        Wed, 06 Nov 2019 06:13:25 -0800 (PST)
Received: from localhost.localdomain (31.red-176-87-122.dynamicip.rima-tde.net. [176.87.122.31])
        by smtp.gmail.com with ESMTPSA id b3sm2837556wma.13.2019.11.06.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 06:13:25 -0800 (PST)
From:   Richard Henderson <richard.henderson@linaro.org>
X-Google-Original-From: Richard Henderson <rth@twiddle.net>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 02/10] powerpc: Remove arch_has_random, arch_has_random_seed
Date:   Wed,  6 Nov 2019 15:13:00 +0100
Message-Id: <20191106141308.30535-3-rth@twiddle.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191106141308.30535-1-rth@twiddle.net>
References: <20191106141308.30535-1-rth@twiddle.net>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These symbols are currently part of the generic archrandom.h
interface, but are currently unused and can be removed.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 arch/powerpc/include/asm/archrandom.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/powerpc/include/asm/archrandom.h b/arch/powerpc/include/asm/archrandom.h
index 9c63b596e6ce..c2ed3b4681f5 100644
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@ -34,16 +34,6 @@ static inline int arch_get_random_seed_int(unsigned int *v)
 
 	return rc;
 }
-
-static inline int arch_has_random(void)
-{
-	return 0;
-}
-
-static inline int arch_has_random_seed(void)
-{
-	return !!ppc_md.get_random_seed;
-}
 #endif /* CONFIG_ARCH_RANDOM */
 
 #ifdef CONFIG_PPC_POWERNV
-- 
2.17.1

