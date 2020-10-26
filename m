Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C77298AF9
	for <lists+linux-s390@lfdr.de>; Mon, 26 Oct 2020 12:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772588AbgJZK6e (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 26 Oct 2020 06:58:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36367 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772398AbgJZK6b (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Oct 2020 06:58:31 -0400
Received: by mail-wr1-f66.google.com with SMTP id x7so11916254wrl.3
        for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2020 03:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VujIMeu4s9glQHD7csuDCyNoNKl6Zu7MMMJFOASMnXs=;
        b=Ghd448QeH/JpCHvVE51pHD/gv1aq9xL/1owNFBCiwBZSBWw36ulRGro2rbjavW8HCm
         tpvgHYSA74mCT5+uyBNL8JCAIV8+TSzuSAdovyibD14KcIKytMRX6O8hoK25tjhehc2D
         7GZJatk+wlASdgpbFnGrN0Wke1bO/fVz4YTuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VujIMeu4s9glQHD7csuDCyNoNKl6Zu7MMMJFOASMnXs=;
        b=cOPkxQaF2IMPsCeR0ZI25qOW4mOg5xA4qA8iKNkmXnd3e+yvBySRxmMGu2vHs4QLNx
         BxCY+0LHrSwV37c/ppuBBD7jN+8EQvU/gFS+Kb9ggsQYsPJCpsdSn1vi+wiEVgNt5JHJ
         DyabHpFomaa7aytvhGqEWoIPzJ/wkNNaV/AwH5Pr8B62bUqmo+jkKB1kYYjA8vbUxbUj
         t3Thzxcg2vYeZfOctp0shBYKQeDGk/nNpXZzI4Nqscv13At5F/fAMtYIVuNVTQ6qBjlU
         gYIHT5SW4DXTLxOzDvJXQpIypH1dhfe7dqplUukvNPpVj4LyRm/9oiECedWnbPJ/W9aQ
         Wp7Q==
X-Gm-Message-State: AOAM530IvTJwjaqQjB63EpIFAQ3Sa/b6KUOytSx3my4yFn8yLiy86+gF
        CCbLFZ9TKa4MszvXkPNCHexJlg==
X-Google-Smtp-Source: ABdhPJypi/6Cbees0NGq1yum4JVfOyvtLJ54ljnHY5mG0+HM7dRuCdSdcl5NsPm+FmtB0NGqEYAv1Q==
X-Received: by 2002:adf:f3cb:: with SMTP id g11mr18176883wrp.210.1603709908008;
        Mon, 26 Oct 2020 03:58:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id w83sm21165156wmg.48.2020.10.26.03.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 03:58:27 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v4 02/15] drm/exynos: Use FOLL_LONGTERM for g2d cmdlists
Date:   Mon, 26 Oct 2020 11:58:05 +0100
Message-Id: <20201026105818.2585306-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The exynos g2d interface is very unusual, but it looks like the
userptr objects are persistent. Hence they need FOLL_LONGTERM.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/exynos/exynos_drm_g2d.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index ecede41af9b9..1e0c5a7f206e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -475,7 +475,8 @@ static dma_addr_t *g2d_userptr_get_dma_addr(struct g2d_data *g2d,
 		goto err_free;
 	}
 
-	ret = pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
+	ret = pin_user_pages_fast(start, npages,
+				  FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
 				  g2d_userptr->pages);
 	if (ret != npages) {
 		DRM_DEV_ERROR(g2d->dev,
-- 
2.28.0

