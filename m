Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4552864FF
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgJGQpb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 12:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728523AbgJGQou (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Oct 2020 12:44:50 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36694C0613DE
        for <linux-s390@vger.kernel.org>; Wed,  7 Oct 2020 09:44:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so2973766wrp.8
        for <linux-s390@vger.kernel.org>; Wed, 07 Oct 2020 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTBabPHcIR29EuHLrnWP/T+AJBtGm5KhLqQZnLrmjOk=;
        b=B6Y78U/CizMgqSGef4CNcX/ZAbAZRMLDFtT3Y2Q78gZFvfPXiYMD2psghmGlUqhbMN
         TaNgc3Hhm84l0AUdn7xg+cuNmGGercHUpnIZxgoDThibeFauGRMKYmgw5TdXCBtpaqci
         vToCVY3fwvV6lpfhfUPwrCrAx1SI7cFeAhgWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTBabPHcIR29EuHLrnWP/T+AJBtGm5KhLqQZnLrmjOk=;
        b=pNfyMLcQLnQdsj81j8jmjMWKcM59Na+MuM0Yh+4xq4qy/gyIhbeD+7lSmn4rAC3EuF
         gT7wU6EsPEHX6eQISWMVkMV8Dx46ZpSPhhLk05QQyHF4ibHAfvnPm+xU9KLh9PgL6URJ
         uG99LxW57LqiErGmeXnaYpfkkfN3UygW9rtF9LqYxLUTRo6y2xL+aGGGH4edMHq9Kyen
         Yb4Y4E2rz83dMn7TXsErIs4cLcLFR9jPUQ9fpiS67XvQ407b5qWmQYLBM6dq3ws/YTLS
         aTTLHP3jdwkzW2cWeJ2We5eroiUjct2BIN3CaHYiw2cUGWCRSPsSGFYzFWVMmIG++rLo
         G2TA==
X-Gm-Message-State: AOAM532SLQKNQAcmflXFFLYC3q1gOhUm4D/5BklzWD4sRIGtSWwxeI3D
        nOPadCZwVcV3rfXaYSSD86XkSQ==
X-Google-Smtp-Source: ABdhPJzDCkm6WtDsou+bjbEDH4oOgBt0QrRTTZxw26yFUl0NTd3VcvyK2uewsnDtS4YDsx0KJws7rA==
X-Received: by 2002:a5d:6551:: with SMTP id z17mr4510042wrv.200.1602089088894;
        Wed, 07 Oct 2020 09:44:48 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z191sm3332280wme.40.2020.10.07.09.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 09:44:48 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 11/13] mm: add unsafe_follow_pfn
Date:   Wed,  7 Oct 2020 18:44:24 +0200
Message-Id: <20201007164426.1812530-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Way back it was a reasonable assumptions that iomem mappings never
change the pfn range they point at. But this has changed:

- gpu drivers dynamically manage their memory nowadays, invalidating
ptes with unmap_mapping_range when buffers get moved

- contiguous dma allocations have moved from dedicated carvetouts to
cma regions. This means if we miss the unmap the pfn might contain
pagecache or anon memory (well anything allocated with GFP_MOVEABLE)

- even /dev/mem now invalidates mappings when the kernel requests that
iomem region when CONFIG_IO_STRICT_DEVMEM is set, see 3234ac664a87
("/dev/mem: Revoke mappings when a driver claims the region")

Accessing pfns obtained from ptes without holding all the locks is
therefore no longer a good idea.

Unfortunately there's some users where this is not fixable (like v4l
userptr of iomem mappings) or involves a pile of work (vfio type1
iommu). For now annotate these as unsafe and splat appropriately.

This patch adds an unsafe_follow_pfn, which later patches will then
roll out to all appropriate places.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Kees Cook <keescook@chromium.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: kvm@vger.kernel.org
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 32 +++++++++++++++++++++++++++++++-
 mm/nommu.c         | 17 +++++++++++++++++
 security/Kconfig   | 13 +++++++++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2a16631c1fda..ec8c90928fc9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1653,6 +1653,8 @@ int follow_pte_pmd(struct mm_struct *mm, unsigned long address,
 		   pte_t **ptepp, pmd_t **pmdpp, spinlock_t **ptlp);
 int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 	unsigned long *pfn);
+int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
+		      unsigned long *pfn);
 int follow_phys(struct vm_area_struct *vma, unsigned long address,
 		unsigned int flags, unsigned long *prot, resource_size_t *phys);
 int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index 8d467e23b44e..8db7ad1c261c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4821,7 +4821,12 @@ EXPORT_SYMBOL(follow_pte_pmd);
  * @address: user virtual address
  * @pfn: location to store found PFN
  *
- * Only IO mappings and raw PFN mappings are allowed.
+ * Only IO mappings and raw PFN mappings are allowed. Note that callers must
+ * ensure coherency with pte updates by using a &mmu_notifier to follow updates.
+ * If this is not feasible, or the access to the @pfn is only very short term,
+ * use follow_pte_pmd() instead and hold the pagetable lock for the duration of
+ * the access instead. Any caller not following these requirements must use
+ * unsafe_follow_pfn() instead.
  *
  * Return: zero and the pfn at @pfn on success, -ve otherwise.
  */
@@ -4844,6 +4849,31 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL(follow_pfn);
 
+/**
+ * unsafe_follow_pfn - look up PFN at a user virtual address
+ * @vma: memory mapping
+ * @address: user virtual address
+ * @pfn: location to store found PFN
+ *
+ * Only IO mappings and raw PFN mappings are allowed.
+ *
+ * Returns zero and the pfn at @pfn on success, -ve otherwise.
+ */
+int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
+	unsigned long *pfn)
+{
+#ifdef CONFIG_STRICT_FOLLOW_PFN
+	pr_info("unsafe follow_pfn usage rejected, see CONFIG_STRICT_FOLLOW_PFN\n");
+	return -EINVAL;
+#else
+	WARN_ONCE(1, "unsafe follow_pfn usage\n");
+	add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+
+	return follow_pfn(vma, address, pfn);
+#endif
+}
+EXPORT_SYMBOL(unsafe_follow_pfn);
+
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 int follow_phys(struct vm_area_struct *vma,
 		unsigned long address, unsigned int flags,
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..3db2910f0d64 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -132,6 +132,23 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL(follow_pfn);
 
+/**
+ * unsafe_follow_pfn - look up PFN at a user virtual address
+ * @vma: memory mapping
+ * @address: user virtual address
+ * @pfn: location to store found PFN
+ *
+ * Only IO mappings and raw PFN mappings are allowed.
+ *
+ * Returns zero and the pfn at @pfn on success, -ve otherwise.
+ */
+int unsafe_follow_pfn(struct vm_area_struct *vma, unsigned long address,
+	unsigned long *pfn)
+{
+	return follow_pfn(vma, address, pfn);
+}
+EXPORT_SYMBOL(unsafe_follow_pfn);
+
 LIST_HEAD(vmap_area_list);
 
 void vfree(const void *addr)
diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..48945402e103 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -230,6 +230,19 @@ config STATIC_USERMODEHELPER_PATH
 	  If you wish for all usermode helper programs to be disabled,
 	  specify an empty string here (i.e. "").
 
+config STRICT_FOLLOW_PFN
+	bool "Disable unsafe use of follow_pfn"
+	depends on MMU
+	help
+	  Some functionality in the kernel follows userspace mappings to iomem
+	  ranges in an unsafe matter. Examples include v4l userptr for zero-copy
+	  buffers sharing.
+
+	  If this option is switched on, such access is rejected. Only enable
+	  this option when you must run userspace which requires this.
+
+	  If in doubt, say Y.
+
 source "security/selinux/Kconfig"
 source "security/smack/Kconfig"
 source "security/tomoyo/Kconfig"
-- 
2.28.0

