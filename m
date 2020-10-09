Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A10288490
	for <lists+linux-s390@lfdr.de>; Fri,  9 Oct 2020 10:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgJIIBP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 9 Oct 2020 04:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732729AbgJIIAN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Oct 2020 04:00:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BBBC0610E0
        for <linux-s390@vger.kernel.org>; Fri,  9 Oct 2020 01:00:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e18so9230991wrw.9
        for <linux-s390@vger.kernel.org>; Fri, 09 Oct 2020 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=le1GUptU9JjBH114uU563JmUcYegKwYn9xh0zAQdRv8=;
        b=D1VJi6UDBiQk2hO8dFve4gh+DKwL/4hvYIL5H14t+/WkC6EkC0QuzB+xVNaIVhimgb
         u3J/6YYVnKsy9E3ATy/UWE+cLNXaPddTma9scUgc+w9imr71cIasK3qOPcYgE9YB/pK2
         huXf9HsnQzVH0icRGFbigbp5CUz+XW5pf1/tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=le1GUptU9JjBH114uU563JmUcYegKwYn9xh0zAQdRv8=;
        b=l6zuTqF5oAoVYkOmBrBFTbLR1t8gzjCLhBlEricZ+kaixjZ5uC0ML1c45rDv/28lc9
         ZuVSEVZL92sMxbEVN+Q2bYZt1cEif+rMdm46GqJrn1xzO6RPDuaSf+V9H+VYvOx3ovU8
         Hh3osZO8SSCPL8aUziVtK7jbOMPyo6qrFKhsjoUAnYiPZOAMRV1YGLpYHmoT7KkHF1Y0
         JI4wM7grr9Pw1qe4QH3/PPWE2fDA4uZGWkUVtJ4gMP68g6zZpQcESdKPQGhUUKObIH8x
         zZ3oc1zYRVJYrKtcjkJyrTRDnMgt5ehwyiJyJapxeq7PlNHvaDGpe7Zr1sAy4S+5GWsE
         GlYQ==
X-Gm-Message-State: AOAM530arJJtg6FgKT/C8NdnLpIBlzgA6c1W16fQO5lAdrQNFpm73VWw
        1QzGcVvewC64nntjgcyPN3knrA==
X-Google-Smtp-Source: ABdhPJz4MKP5KGohAdR58eqqZNbRUjATksd5quRpBzCsMu6hT8STZxdOkUvTUNe8EYXb+jIiohIVBA==
X-Received: by 2002:adf:bc14:: with SMTP id s20mr14299261wrg.220.1602230408064;
        Fri, 09 Oct 2020 01:00:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u17sm11634118wri.45.2020.10.09.01.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 01:00:07 -0700 (PDT)
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
        Jan Kara <jack@suse.cz>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 11/17] vfio/type1: Mark follow_pfn as unsafe
Date:   Fri,  9 Oct 2020 09:59:28 +0200
Message-Id: <20201009075934.3509076-12-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The code seems to stuff these pfns into iommu pts (or something like
that, I didn't follow), but there's no mmu_notifier to ensure that
access is synchronized with pte updates.

Hence mark these as unsafe. This means that with
CONFIG_STRICT_FOLLOW_PFN, these will be rejected.

Real fix is to wire up an mmu_notifier ... somehow. Probably means any
invalidate is a fatal fault for this vfio device, but then this
shouldn't ever happen if userspace is reasonable.

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
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: kvm@vger.kernel.org
---
 drivers/vfio/vfio_iommu_type1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 5fbf0c1f7433..a4d53f3d0a35 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -421,7 +421,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 {
 	int ret;
 
-	ret = follow_pfn(vma, vaddr, pfn);
+	ret = unsafe_follow_pfn(vma, vaddr, pfn);
 	if (ret) {
 		bool unlocked = false;
 
@@ -435,7 +435,7 @@ static int follow_fault_pfn(struct vm_area_struct *vma, struct mm_struct *mm,
 		if (ret)
 			return ret;
 
-		ret = follow_pfn(vma, vaddr, pfn);
+		ret = unsafe_follow_pfn(vma, vaddr, pfn);
 	}
 
 	return ret;
-- 
2.28.0

