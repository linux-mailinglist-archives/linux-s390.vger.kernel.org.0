Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC813A52
	for <lists+linux-s390@lfdr.de>; Sat,  4 May 2019 15:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfEDNY7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 4 May 2019 09:24:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41933 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbfEDNYv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 4 May 2019 09:24:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id m4so9453527edd.8
        for <linux-s390@vger.kernel.org>; Sat, 04 May 2019 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilJMImjlYVy70bBELZy9Jn7imshjw1ckAQEWKZMZSgA=;
        b=kHk2+JWRL/cGbPjnkWGob5MrdcSMAbvrNrGgqY4ptSrD91uypp+Vq+W6LqZ2SzdNPE
         rqhrOB1Mv49q0CzhmJlb8yvM9bbLe3nrZf36IzqLMK/n5yUGPX2ncpB5oFck2z1hMfxg
         AqeyMj5B6bRf6B+53EGk6s/43P27f97PgW1EgH+hzjnyQyru2apIMio9bh3E5AfvxbB4
         ZKHESO05fwbw3JCIdISFH6QBNbxP/P9NUoCf71vTAQ1EfMsr8Ial0FNQKC2eP7csG7Ni
         YzI0SuYDlcznFA2cjWTkrdfYIxpTmn3wrE066epBIP80jRLMpbCUt1cDYGrCIiopZOyd
         nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilJMImjlYVy70bBELZy9Jn7imshjw1ckAQEWKZMZSgA=;
        b=pJYaSh3lPgbp95LrF3UB5R7CPB8CPbaf0KcWeFkwH3Cz01Aws1s2z0PuCUmBAS2nZg
         uNaXaMqmozPay4vQ6nltcG06YNxaqNnWEJeLxPIXKXqr5MHpQZ+SITiT+VYTuTGRiTOt
         pxWwFMGAptah5LUi3x0M6SwdsjQbblzhhVroI00B5npoqTWhDQYXIdbwrHZgeX9HEB5S
         pnJnUpbnI7WmLJkGMlzclquLaT/8mHNDe7SbD4AwhtHsp3iQKXVH4mROfAjQrrGPzHFY
         /mlb1vnLR48gisHtB8qTUpuOBk1ONmArxegNrJnGJCZdP4xXSk6rNjHTD2lWgi1G8WMO
         Xcng==
X-Gm-Message-State: APjAAAWL+j7iNsYiewc/8rn4f5cdgIKzeLrlWxUohG7uLpcdGWl16BVg
        7cInq7p3zMumj4R1I7t3I/zTeQ==
X-Google-Smtp-Source: APXvYqxvfnAmtfi/HRH+5Vwm5xT8Q6YfnIc2JocZD/ewrQb7MbDvGkg7DJVtT1tIUxVEjnF4JYMjkg==
X-Received: by 2002:a50:b669:: with SMTP id c38mr1398711ede.201.1556976289385;
        Sat, 04 May 2019 06:24:49 -0700 (PDT)
Received: from localhost.localdomain ([79.97.203.116])
        by smtp.gmail.com with ESMTPSA id s53sm1391106edb.20.2019.05.04.06.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 May 2019 06:24:48 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     murphyt7@tcd.ie, Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, kvm@vger.kernel.org
Subject: [RFC 7/7] iommu/vt-d: Always set DMA_PTE_READ if the iommu doens't support zero length reads
Date:   Sat,  4 May 2019 14:23:23 +0100
Message-Id: <20190504132327.27041-8-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190504132327.27041-1-tmurphy@arista.com>
References: <20190504132327.27041-1-tmurphy@arista.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

To match the dma-ops api path the DMA_PTE_READ should be set if ZLR
isn't supported in the iommu

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/intel-iommu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 980fc4816d72..e78b0000056d 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4378,6 +4378,17 @@ static void intel_iommu_detach_device(struct iommu_domain *domain,
 	dmar_remove_one_dev_info(dev);
 }
 
+static bool supports_zlr(struct dmar_domain *domain)
+{
+	int i;
+
+	for_each_domain_iommu(i, domain) {
+		if (cap_zlr(g_iommus[i]->cap))
+			return true;
+	}
+	return false;
+}
+
 static int intel_iommu_map(struct iommu_domain *domain,
 			   unsigned long iova, phys_addr_t hpa,
 			   size_t size, int iommu_prot)
@@ -4391,7 +4402,7 @@ static int intel_iommu_map(struct iommu_domain *domain,
 	if (dmar_domain == si_domain && hw_pass_through)
 		return 0;
 
-	if (iommu_prot & IOMMU_READ)
+	if (iommu_prot & IOMMU_READ || !supports_zlr(dmar_domain))
 		prot |= DMA_PTE_READ;
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= DMA_PTE_WRITE;
-- 
2.17.1

