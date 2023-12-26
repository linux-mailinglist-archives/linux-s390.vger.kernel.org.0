Return-Path: <linux-s390+bounces-755-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A65281E389
	for <lists+linux-s390@lfdr.de>; Tue, 26 Dec 2023 01:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E12287E93
	for <lists+linux-s390@lfdr.de>; Tue, 26 Dec 2023 00:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96556466;
	Tue, 26 Dec 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjtDJpRb"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6856463;
	Tue, 26 Dec 2023 00:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F5EC433CA;
	Tue, 26 Dec 2023 00:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550193;
	bh=gi6qhhYJP934f9AYPMUTLeOnw0dazoS62LJiKSGqsgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjtDJpRbfJZDUJXb6ue7onc/+ovrQ2rYUEA2H52E3OJ2QMJPdpXXSvS69yo20LP9o
	 WK2b7EPePY10vGaXfFeI0fDNruF3fKBFGLC9rElw6a6QNCYV1JpIpYw176q1AiKLgo
	 xd2EmpFgx84ceGE7yo/wCCkLc1HLYLp1qR6IGNFPt4Il4Vns8osrQLvlUvbuHgMGVC
	 ltqR4CBAY6x99QnYOoI67XLCA1ZGHwIvKZMMAUBVqlJzytGS5HByCejYJEkDaVMXPF
	 4wEJ7heMCmAv/7B/BBZFLMLaZ8FI/OXkmR4WvbLohj7p+d8WzzFmHO4y7xML7lCQ/w
	 5Ccx+hJw5TJYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/24] s390/scm: fix virtual vs physical address confusion
Date: Mon, 25 Dec 2023 19:21:59 -0500
Message-ID: <20231226002255.5730-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit b1a6a1a77f0666a5a6dc0893ab6ec8fcae46f24c ]

Fix virtual vs physical address confusion (which currently are the same).

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/scm_blk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/scm_blk.c b/drivers/s390/block/scm_blk.c
index 0c1df1d5f1aca..a165b1a59fde5 100644
--- a/drivers/s390/block/scm_blk.c
+++ b/drivers/s390/block/scm_blk.c
@@ -17,6 +17,7 @@
 #include <linux/blk-mq.h>
 #include <linux/slab.h>
 #include <linux/list.h>
+#include <linux/io.h>
 #include <asm/eadm.h>
 #include "scm_blk.h"
 
@@ -130,7 +131,7 @@ static void scm_request_done(struct scm_request *scmrq)
 
 	for (i = 0; i < nr_requests_per_io && scmrq->request[i]; i++) {
 		msb = &scmrq->aob->msb[i];
-		aidaw = msb->data_addr;
+		aidaw = (u64)phys_to_virt(msb->data_addr);
 
 		if ((msb->flags & MSB_FLAG_IDA) && aidaw &&
 		    IS_ALIGNED(aidaw, PAGE_SIZE))
@@ -195,12 +196,12 @@ static int scm_request_prepare(struct scm_request *scmrq)
 	msb->scm_addr = scmdev->address + ((u64) blk_rq_pos(req) << 9);
 	msb->oc = (rq_data_dir(req) == READ) ? MSB_OC_READ : MSB_OC_WRITE;
 	msb->flags |= MSB_FLAG_IDA;
-	msb->data_addr = (u64) aidaw;
+	msb->data_addr = (u64)virt_to_phys(aidaw);
 
 	rq_for_each_segment(bv, req, iter) {
 		WARN_ON(bv.bv_offset);
 		msb->blk_count += bv.bv_len >> 12;
-		aidaw->data_addr = (u64) page_address(bv.bv_page);
+		aidaw->data_addr = virt_to_phys(page_address(bv.bv_page));
 		aidaw++;
 	}
 
-- 
2.43.0


