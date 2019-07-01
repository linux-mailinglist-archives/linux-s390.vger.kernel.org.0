Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16158199A9
	for <lists+linux-s390@lfdr.de>; Fri, 10 May 2019 10:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfEJIY1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 10 May 2019 04:24:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbfEJIX0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 10 May 2019 04:23:26 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4A8NFmN136536
        for <linux-s390@vger.kernel.org>; Fri, 10 May 2019 04:23:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sd4q62ky9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 10 May 2019 04:23:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Fri, 10 May 2019 09:22:42 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 10 May 2019 09:22:39 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4A8MbXY49610988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 08:22:37 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75D9EAE051;
        Fri, 10 May 2019 08:22:37 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1608AE055;
        Fri, 10 May 2019 08:22:36 +0000 (GMT)
Received: from morel-ThinkPad-W530.boeblingen.de.ibm.com (unknown [9.145.187.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 May 2019 08:22:36 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     sebott@linux.vnet.ibm.com
Cc:     gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, walling@linux.ibm.com,
        linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org,
        alex.williamson@redhat.com, kvm@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: [PATCH 2/4] vfio: vfio_iommu_type1: Define VFIO_IOMMU_INFO_CAPABILITIES
Date:   Fri, 10 May 2019 10:22:33 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
References: <1557476555-20256-1-git-send-email-pmorel@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19051008-4275-0000-0000-0000033351DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051008-4276-0000-0000-00003842C748
Message-Id: <1557476555-20256-3-git-send-email-pmorel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=783 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100059
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

To use the VFIO_IOMMU_GET_INFO to retrieve IOMMU specific information,
we define a new flag VFIO_IOMMU_INFO_CAPABILITIES in the
vfio_iommu_type1_info structure and the associated capability
information block.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 include/uapi/linux/vfio.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 8f10748..8f68e0f 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -715,6 +715,16 @@ struct vfio_iommu_type1_info {
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
+	__u64   cap_offset;     /* Offset within info struct of first cap */
+};
+
+#define VFIO_IOMMU_INFO_CAP_QFN		1
+#define VFIO_IOMMU_INFO_CAP_QGRP	2
+
+struct vfio_iommu_type1_info_block {
+	struct vfio_info_cap_header header;
+	__u32 data[];
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-- 
2.7.4

