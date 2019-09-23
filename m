Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCEBB3D9
	for <lists+linux-s390@lfdr.de>; Mon, 23 Sep 2019 14:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394371AbfIWMfL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Sep 2019 08:35:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394324AbfIWMfL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 08:35:11 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8NCRO1o020983
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v6vce4amd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 08:35:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 23 Sep 2019 13:35:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 23 Sep 2019 13:35:05 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8NCZ3RJ60686590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Sep 2019 12:35:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83BC211C064;
        Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2613811C05C;
        Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 23 Sep 2019 12:35:03 +0000 (GMT)
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [RFC PATCH 3/3] dma-mapping: warn on harmful GFP_* flags
Date:   Mon, 23 Sep 2019 14:34:18 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923123418.22695-1-pasic@linux.ibm.com>
References: <20190923123418.22695-1-pasic@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19092312-4275-0000-0000-0000036A0B34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19092312-4276-0000-0000-0000387C7F68
Message-Id: <20190923123418.22695-4-pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909230124
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The commit message of commit 57bf5a8963f8 ("dma-mapping: clear harmful
GFP_* flags in common code") says that probably warn when we encounter
harmful GFP_* flags which we clean -- because the client code is best
case silly if not buggy. I concur with that.

Let's warn once when we encounter silly GFP_* flags. The guys caring
about the respective client code will hopefully fix these soon.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
---

I'm not too happy with my warning message. Suggestions welcome!
---
 include/linux/dma-mapping.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 5024bc863fa7..299f36ac8668 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -823,6 +823,9 @@ extern gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags);
 static inline gfp_t dma_override_gfp_flags(struct device *dev, gfp_t flags)
 {
 	/* let the implementation decide on the zone to allocate from: */
+	dev_WARN_ONCE(dev,
+		      flags & (__GFP_DMA32 | __GFP_DMA | __GFP_HIGHMEM),
+		      "fixme: don't dma_alloc with any of: __GFP_DMA32, __GFP_DMA, __GFP_HIGHMEM\n");
 	return flags & ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 }
 #endif
-- 
2.17.1

