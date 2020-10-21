Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1BA2949F2
	for <lists+linux-s390@lfdr.de>; Wed, 21 Oct 2020 10:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502308AbgJUI5K (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 21 Oct 2020 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502302AbgJUI5K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 21 Oct 2020 04:57:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42EC0613D6
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 01:57:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so2130485wre.4
        for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2020 01:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X91vcdrvFkENyRAE7ngumttfTvuoYERNqnOUmx1loc8=;
        b=GPnXCMyD+ghMvqTjeYNcG8HYusAwuJxpfHWnTLJKQIsMVr4ZAhrveCWfs4AXdeBUPw
         Y5mupIyBAV9NDJ8u8gy061IQONEWL5h8a9oYpovitSRm7WeaCy/YPrPbgEp1B6AXN1YC
         FZ2gAxPTsOCGgSfQP+HaV8u3GtfeNX/N9iPJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X91vcdrvFkENyRAE7ngumttfTvuoYERNqnOUmx1loc8=;
        b=i39TODtUw4DcxelFwTi+iHrqZQoas3MCxHs7EcVpRnAv1eSvcZ4xca3n4m9erVqnT1
         j+A5Q65icXvK85yX00Wmqz4WkHPBkKZuzWfi/rHFdLG61Vi52dlvYHQAWmU9iL5lsJGg
         bQMFP7QPvh2ZnEB/cRZyekWokkJzj8GSZJ/U8FrzVxCT8oDcbThBlE1Pn7QblApru46V
         2aFQQLPhmampoylN9+gc/tlI6wO2HXisV4dVF0aNeTVtsr2aobpSXiiS615AszNXx5Yi
         cQRToaNZlKS5G6QHcDyUi7tc2BKDNlmTPYQLtjX5h26SweEXqEa+atWbu4wXxu+L+4y7
         mwYA==
X-Gm-Message-State: AOAM531+WEVWsBe5eXxSQn6X9bgNCOPysbjO1SfNUckQs3k8rUBmLe2n
        T8f39HFpwwbXydo2AynypzlVkw==
X-Google-Smtp-Source: ABdhPJwRJSi1MhjUwKHGSaK47xh7Klwun5uHdPZbkNE0DXk17iEFA5dRgyjIq8Do+yUzr74H0TKxFQ==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr3494901wrw.370.1603270627906;
        Wed, 21 Oct 2020 01:57:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q8sm2675939wro.32.2020.10.21.01.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 01:57:07 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-s390@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Piskorski <ppiskorski@habana.ai>,
        Daniel Vetter <daniel.vetter@ffwll.com>
Subject: [PATCH v3 04/16] misc/habana: Use FOLL_LONGTERM for userptr
Date:   Wed, 21 Oct 2020 10:56:43 +0200
Message-Id: <20201021085655.1192025-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
References: <20201021085655.1192025-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

These are persistent, not just for the duration of a dma operation.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Oded Gabbay <oded.gabbay@gmail.com>
Cc: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Ofir Bitton <obitton@habana.ai>
Cc: Tomer Tayar <ttayar@habana.ai>
Cc: Moti Haimovski <mhaimovski@habana.ai>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pawel Piskorski <ppiskorski@habana.ai>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.com>
---
 drivers/misc/habanalabs/common/memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 327b64479f97..767d3644c033 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -1288,7 +1288,8 @@ static int get_user_memory(struct hl_device *hdev, u64 addr, u64 size,
 		return -ENOMEM;
 	}
 
-	rc = pin_user_pages_fast(start, npages, FOLL_FORCE | FOLL_WRITE,
+	rc = pin_user_pages_fast(start, npages,
+				 FOLL_FORCE | FOLL_WRITE | FOLL_LONGTERM,
 				 userptr->pages);
 
 	if (rc != npages) {
-- 
2.28.0

