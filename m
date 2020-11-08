Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA62AA92B
	for <lists+linux-s390@lfdr.de>; Sun,  8 Nov 2020 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgKHFRz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 8 Nov 2020 00:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgKHFRs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Nov 2020 00:17:48 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895CFC0613CF
        for <linux-s390@vger.kernel.org>; Sat,  7 Nov 2020 21:17:46 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so4955016wme.1
        for <linux-s390@vger.kernel.org>; Sat, 07 Nov 2020 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNfLr2MUDn+yRnjMBh+JTqbF61rd26wUzAa4aRLLOQ0=;
        b=HEI8SQGYtXIV+QZl6JJjDaPUkZG0ISuzaeDIP6HZy6g9tm5OgDQurVVWtVk5GINgh6
         71oVVjA05Of0/EFMg720id1UOgeo9/3e0cHlMhRvyWuYJ+8gNcGr6LLRbZMbWbtgwbnJ
         d8my0E6zwFxl5JW9RUwh9C4oqKTz+l3tVZiaEJNUcZ6PoZnLjmtpdfOw5fwxsSb9JuUz
         ntuCgLeorOdFc5Oh1d4k/rfgCGMo/oZpdFPGlzDEi01qURYX0oT52mo8K4zBHtR6/3LO
         Mj4rJmVnajEF6qbrdR/yhaE1EjZGP2PlUA5QE4FT+vTsWcQBU8EjaaSPg6snBSkKeuA+
         1rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNfLr2MUDn+yRnjMBh+JTqbF61rd26wUzAa4aRLLOQ0=;
        b=D9V2tqSmGD55uqotvgWlcYfhc1wZAkjpvkG/cvfvh+LAUMTEae9xdTevMGrbuSiLjo
         5Z4COE4oCZyP/Vk6MmpdGBCTXaiw3OUddYaYN4T9aJeqWT/lV86yrzymiB3EEI82Spwl
         R8PNRYVucgJSQF9D6nOqPMHZ1JrgfGhyDFla4LgGgFbNhfzOkmrdxC/R97UTblTvon6o
         va6svUm/bOIsS7uYBxXoCmAGNzFFO80Z7JL9JI7PFvo/sIVxlMstbqM7KaJLOIM9l2IU
         eh5OYhmXlWQM5V0DFTwr4WyX2rYxEVOWpDX80OT3YnBCM6TDClwfL+BIEOiaQ0sCKARl
         8RAw==
X-Gm-Message-State: AOAM530psltPYTOtNNKsLYe0oKVUNq7mfp3kiff9i290e2ERUoK9ZJKM
        5o3pEit4rQMT5YJT4fyyCW9pMg==
X-Google-Smtp-Source: ABdhPJzn8OMvPlB5ADLsaEbzJcXV9HtJJO6R7x4EgeCZCrjs+1+6ZvuUSpkVxJDwjTHCtpjhyRtYCA==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr7477214wmo.97.1604812665214;
        Sat, 07 Nov 2020 21:17:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:44 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 09/19] s390/vdso: Remove vdso_base pointer from mm->context
Date:   Sun,  8 Nov 2020 05:17:19 +0000
Message-Id: <20201108051730.2042693-10-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Not used any more.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/include/asm/mmu.h |  1 -
 arch/s390/kernel/vdso.c     | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index e12ff0f29d1a..095d0596f700 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -15,7 +15,6 @@ typedef struct {
 	unsigned long gmap_asce;
 	unsigned long asce;
 	unsigned long asce_limit;
-	unsigned long vdso_base;
 	/* The mmu context belongs to a secure guest. */
 	atomic_t is_protected;
 	/*
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 810b72f8985c..3f07711a07c1 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -58,18 +58,9 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		       struct vm_area_struct *vma)
-{
-	current->mm->context.vdso_base = vma->vm_start;
-
-	return 0;
-}
-
 static const struct vm_special_mapping vdso_mapping = {
 	.name = "[vdso]",
 	.fault = vdso_fault,
-	.mremap = vdso_mremap,
 };
 
 static int __init vdso_setup(char *str)
@@ -204,7 +195,6 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 		goto out_up;
 	}
 
-	current->mm->context.vdso_base = vdso_base;
 	*sysinfo_ehdr = vdso_base;
 	rc = 0;
 
-- 
2.28.0

