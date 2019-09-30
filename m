Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C73CAC2284
	for <lists+linux-s390@lfdr.de>; Mon, 30 Sep 2019 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfI3Nyy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Sep 2019 09:54:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729738AbfI3Nyx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 09:54:53 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UDsZu8087387
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 09:54:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbg9w7xna-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 09:54:48 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 30 Sep 2019 14:53:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 14:53:34 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UDrXJZ59310148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 13:53:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 405954C044;
        Mon, 30 Sep 2019 13:53:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C83904C04A;
        Mon, 30 Sep 2019 13:53:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 13:53:32 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>, Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 1/1] s390/cio: fix virtio-ccw DMA without PV
Date:   Mon, 30 Sep 2019 15:53:10 +0200
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19093013-0012-0000-0000-0000035214B6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093013-0013-0000-0000-0000218CB756
Message-Id: <20190930135310.26148-1-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300144
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 37db8985b211 ("s390/cio: add basic protected virtualization
support") breaks virtio-ccw devices with VIRTIO_F_IOMMU_PLATFORM for non
Protected Virtualization (PV) guests. The problem is that the dma_mask
of the ccw device, which is used by virtio core, gets changed from 64 to
31 bit, because some of the DMA allocations do require 31 bit
addressable memory. For PV the only drawback is that some of the virtio
structures must end up in ZONE_DMA because we have the bounce the
buffers mapped via DMA API anyway.

But for non PV guests we have a problem: because of the 31 bit mask
guests bigger than 2G are likely to try bouncing buffers. The swiotlb
however is only initialized for PV guests, because we don't want to
bounce anything for non PV guests. The first such map kills the guest.

Since the DMA API won't allow us to specify for each allocation whether
we need memory from ZONE_DMA (31 bit addressable) or any DMA capable
memory will do, let us use coherent_dma_mask (which is used for
allocations) to force allocating form ZONE_DMA while changing dma_mask
to DMA_BIT_MASK(64) so that at least the streaming API will regard
the whole memory DMA capable.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Fixes: 37db8985b211 ("s390/cio: add basic protected virtualization support")
---

The idea of enabling the client code to specify on s390 whether a chunk
of allocated DMA memory is to be allocated form ZONE_DMA for each
allocation was not well received [1]. 

Making the streaming API threat all addresses as DMA capable, while
restricting the DMA API allocations to  ZONE_DMA (regardless of needed
or not) is the next best thing we can do (from s390 perspective).

[1] https://lkml.org/lkml/2019/9/23/531 
---
 drivers/s390/cio/cio.h    | 1 +
 drivers/s390/cio/css.c    | 8 +++++++-
 drivers/s390/cio/device.c | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index ba7d2480613b..dcdaba689b20 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -113,6 +113,7 @@ struct subchannel {
 	enum sch_todo todo;
 	struct work_struct todo_work;
 	struct schib_config config;
+	u64 dma_mask;
 	char *driver_override; /* Driver name to force a match */
 } __attribute__ ((aligned(8)));
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 1fbfb0a93f5f..012e26e7bbbb 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -232,7 +232,13 @@ struct subchannel *css_alloc_subchannel(struct subchannel_id schid,
 	 * belong to a subchannel need to fit 31 bit width (e.g. ccw).
 	 */
 	sch->dev.coherent_dma_mask = DMA_BIT_MASK(31);
-	sch->dev.dma_mask = &sch->dev.coherent_dma_mask;
+	/*
+	 * But we don't have such restrictions imposed on the stuff that
+	 * is handled by the streaming API. Using coherent_dma_mask != dma_mask
+	 * is just a workaround.
+	 */
+	sch->dma_mask = DMA_BIT_MASK(64);
+	sch->dev.dma_mask = &sch->dma_mask;
 	return sch;
 
 err:
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 131430bd48d9..0c6245fc7706 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -710,7 +710,7 @@ static struct ccw_device * io_subchannel_allocate_dev(struct subchannel *sch)
 	if (!cdev->private)
 		goto err_priv;
 	cdev->dev.coherent_dma_mask = sch->dev.coherent_dma_mask;
-	cdev->dev.dma_mask = &cdev->dev.coherent_dma_mask;
+	cdev->dev.dma_mask = sch->dev.dma_mask;
 	dma_pool = cio_gp_dma_create(&cdev->dev, 1);
 	if (!dma_pool)
 		goto err_dma_pool;
-- 
2.17.1

