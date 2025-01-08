Return-Path: <linux-s390+bounces-8057-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3BA05395
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jan 2025 07:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849B53A580A
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jan 2025 06:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0BA1A9B3B;
	Wed,  8 Jan 2025 06:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lkjsf6mt"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3B1A840F
	for <linux-s390@vger.kernel.org>; Wed,  8 Jan 2025 06:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319589; cv=none; b=nT0eJD3W+cSQZxf2jvdC5QR8uexz0Ls4bJYF5usRg6a/sZi2Q+olg8txI+EyrvlLq4u9slh/oQZSYaR0jv/i8TNolJn76lVkaZMXItgUvvi8aY2mIcmfNEr7105Ytgr6g8j1RS35xrHXKAV06oZmAw9quveKQLdhS/fElPjzhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319589; c=relaxed/simple;
	bh=ma5h64nM92pGVw8WsUJDDYGPNfXZFgLftucZEsbzZpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jYOXlyMFgcIiU+eoRHtU4nBb/Nqt0QNP+kL7RdC5vjQmnfp8zuKL+Ry0WliAHEYg34Zsl4OJ5dz+PcjUwAEt4lJPm2FjXnx5gcROpWBI0bg6Z0as8sr1qDIj9Wfrxq9uR+k4zTQB2EqEn5ue7wW80kav+uiIR9zFN72T4e3EqZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lkjsf6mt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216395e151bso7101985ad.0
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 22:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319586; x=1736924386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=lkjsf6mtx7iieDBNQgHtDsNwfH81+Ahx5znscEAY+uMyGeqVwDbxKilg3fHzJFKf7m
         yyZZ7rtjWp0OBVs0551xO1oX49k2Oy9EQMjn5paprIo8V/l6Yy5iT6s9+oCibH4HIooX
         31HtOM0khddPN9cF0IM7JQ96jiBOW7NVDLoFWud+rNan94G1yv//xmjhloxmIF8XRxhm
         AEouloJS4x6ju49vfHa+FORb2R7BT80AgfdZjVlEvUA4SMjvzUUAK93CguXuZ6a55P1A
         ZALeoJVB36ib9+/NtHSGuMIWrm0PG9Xjbzz1sB9Ynbww8v5X85/P8EQZcFSLqhbymKos
         VSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319586; x=1736924386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgpljFzcR37DW+k0izImY02NXJU+2N4CamZhPf6BMmU=;
        b=h6L5wjThtZrj11tS7zNhPt5/9tHgd7KAKJB8/q7VwVnbplb2wIxaa0LthI5mkqfLcA
         TAfPUqj1hKDCqgj4/3sLyb+L3tmaXDw33QV6ZDAyA4spFTp5l51apW5crUIjDCJJ9mH8
         LReRBoxFYShIuGMebT++wn6rDCKggQB5c8gPeZdL9dBQYtgBsULcaVHtNjhVGaOmLYrY
         btMCn6ICPtJNwN5pILoKbbVH6CEe9onFFQN+qxs2h5kpAYWMe7VriM0vkmIvruvq2z1X
         kzEEWmt70Lrt8SRg7YXbgbPqsLfL0C16YAERKv3mxqqrpLsY/dV33pu67JWjdRZmM+I2
         w2mw==
X-Forwarded-Encrypted: i=1; AJvYcCVxGXOIrRX5HOdn2mpjE4PLXsTmFZVRFrP/XIF42buNXD/Nsp++XAyrcz4m0kUMGDtJ7bH1y9iAfoQ2@vger.kernel.org
X-Gm-Message-State: AOJu0YycNU9iVbkfK/P+MS9sd54Sr4oqwwCWNRK0pkNN4mQfp8NBxSAa
	4xLO+fA5Iyxd1iIIPItRKlQyBcqYSmiuqBTU5zXovF1N3InD9EKR10WE0hg75tU=
X-Gm-Gg: ASbGnctTA2BPZ2YHHKKiSvzHoC6bNOC04Sf+erHJ/PKgiibUONtBqMsWHTL6krLdgqA
	XqulW/wsqiPu+Anl2N26KLHDUDzn6wmVswMKCbCy44391AnHPP3K+7lQbp8AWebOPBDQtFwTnkD
	AEERW2IA99hFXibgOKUsYdaxQt2lvYYKzFrGJHw7c3DnBi0VpcnhjjvHyrnSJbqIDbhlWAWPb0/
	5bW5QiQHhiQIRJlnGDoV2TFDBIbK8HeHMMCD3V/LkQjpWkJRgEv4RetzErgoQgmSSe6J46cIKPj
	rAtgBYh4V5YajlIwTCCq4hu3rzM=
X-Google-Smtp-Source: AGHT+IEXmx6aGyXUatDDUSC3BIwwvJRBe2xxgGmNdG6bwRG2a4u7PgHO01+qr8GDOf9tBGHx3RRkKg==
X-Received: by 2002:a17:902:fc4d:b0:216:5db1:5dc1 with SMTP id d9443c01a7336-21a83bb9991mr32206305ad.1.1736319586298;
        Tue, 07 Jan 2025 22:59:46 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 22:59:45 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 02/17] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Wed,  8 Jan 2025 14:57:18 +0800
Message-Id: <93a1c6bddc0ded9f1a9f15658c1e4af5c93d1194.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1


