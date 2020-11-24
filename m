Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C305C2C1A00
	for <lists+linux-s390@lfdr.de>; Tue, 24 Nov 2020 01:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgKXA3v (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Nov 2020 19:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729749AbgKXA3u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Nov 2020 19:29:50 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83D8C0613CF
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2020 16:29:49 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a3so1180620wmb.5
        for <linux-s390@vger.kernel.org>; Mon, 23 Nov 2020 16:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GtpVEK2AhHht05u643nAzhNZYWjkRP1wpDVNSCUXwZw=;
        b=O+0wOeauQiRoFtf5fWf0wut4YMeQpaWBddIFsHi6nl2vcIYj9MDyOxkfSo8pNEn56p
         r9PqkfR/sDYCk84fGKpIQ5whwKdu5lO2F9lVEQv5j5fPRPWSqaxcq9R14ModUev+o9ei
         mCQL/y6F6qfz9/sfj8clYBc3iuMJj95KiNNA5fJNybQUnBhh54w92d/CcWNhxjvX9LdZ
         GPFsIBATIdW+G2EOTLzDGJEYJealPW9XBsJpFAVS40DiRFyItQh+r2AFLGETqjFhe5h4
         LuQmk471OYld9+pa2y0bcHUT98Rk23LToYeGjVtMXizDdkI0k/VlQq+oLFP3FshD49X+
         ulyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GtpVEK2AhHht05u643nAzhNZYWjkRP1wpDVNSCUXwZw=;
        b=NYhU6vu4a8VoKOv5j8jK7kNx/qTqtaRVDujSd1lFQxbtoo7JnJ1IaOzvNBl6qByyfR
         uCB6DqMeNau124fB395n9NH45rv2Ty5HtjQt8Uv4msLmCaMoH7Eb2E9qG5vCdKgtmfnR
         tOghOt2nNejzMhTnri11yJ5J7QdTF8fT7mOnG/8AXGuY/Yovv3fNCM68CSvljfGEpjht
         4OpQwTkmH7lzVcRM8XCnsbmOOuMpfWmYzKo8UclkkBaVMsIOZJh9od6GyDN4hw9OBpCA
         hoUjq8Q8VUtxHTbPu7IWTAVo66ox5Fuo7gq8GXyXzoRumj87cbSi7iIa2CFv7MrzngRx
         +rng==
X-Gm-Message-State: AOAM532UEKtVdDeC3eANHzs+o8TSj/0fHLVh6LVbOZJ3u3EFvqQ0SfDW
        OBHYuNsxORStdKN9BF7xsFt9bA==
X-Google-Smtp-Source: ABdhPJzMYZsaDRK/zbSVz8/fZ8oCg+qyvVslwcd9K9TbXnww3vHWJVyYPt+y4z0lfYFFoOskgj28dg==
X-Received: by 2002:a1c:a9c4:: with SMTP id s187mr1437405wme.180.1606177788611;
        Mon, 23 Nov 2020 16:29:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:48 -0800 (PST)
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
Subject: [PATCH v2 09/19] s390/vdso: Remove vdso_base pointer from mm->context
Date:   Tue, 24 Nov 2020 00:29:22 +0000
Message-Id: <20201124002932.1220517-10-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
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
2.29.2

