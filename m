Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91302DCD6
	for <lists+linux-s390@lfdr.de>; Wed, 29 May 2019 14:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfE2M1M (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 29 May 2019 08:27:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49578 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727237AbfE2M1L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 May 2019 08:27:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4TCQ6oc076009
        for <linux-s390@vger.kernel.org>; Wed, 29 May 2019 08:27:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sssn0s7yx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 29 May 2019 08:27:10 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <mimu@linux.ibm.com>;
        Wed, 29 May 2019 13:27:08 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 May 2019 13:27:04 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4TCR2wH38863042
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 May 2019 12:27:03 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83CD84C04A;
        Wed, 29 May 2019 12:27:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C8384C046;
        Wed, 29 May 2019 12:27:02 +0000 (GMT)
Received: from s38lp84.lnxne.boe (unknown [9.152.108.100])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 29 May 2019 12:27:01 +0000 (GMT)
From:   Michael Mueller <mimu@linux.ibm.com>
To:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v3 6/8] virtio/s390: add indirection to indicators access
Date:   Wed, 29 May 2019 14:26:55 +0200
X-Mailer: git-send-email 2.13.4
In-Reply-To: <20190529122657.166148-1-mimu@linux.ibm.com>
References: <20190529122657.166148-1-mimu@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19052912-4275-0000-0000-00000339B79A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052912-4276-0000-0000-00003849631D
Message-Id: <20190529122657.166148-7-mimu@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=960 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905290082
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

This will come in handy soon when we pull out the indicators from
virtio_ccw_device to a memory area that is shared with the hypervisor
(in particular for protected virtualization guests).

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 drivers/s390/virtio/virtio_ccw.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 1da7430f94c8..e96a8cc56ec2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -68,6 +68,16 @@ struct virtio_ccw_device {
 	void *airq_info;
 };
 
+static inline unsigned long *indicators(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators;
+}
+
+static inline unsigned long *indicators2(struct virtio_ccw_device *vcdev)
+{
+	return &vcdev->indicators2;
+}
+
 struct vq_info_block_legacy {
 	__u64 queue;
 	__u32 align;
@@ -338,17 +348,17 @@ static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
 		ccw->cda = (__u32)(unsigned long) thinint_area;
 	} else {
 		/* payload is the address of the indicators */
-		indicatorp = kmalloc(sizeof(&vcdev->indicators),
+		indicatorp = kmalloc(sizeof(indicators(vcdev)),
 				     GFP_DMA | GFP_KERNEL);
 		if (!indicatorp)
 			return;
 		*indicatorp = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 	}
 	/* Deregister indicators from host. */
-	vcdev->indicators = 0;
+	*indicators(vcdev) = 0;
 	ccw->flags = 0;
 	ret = ccw_io_helper(vcdev, ccw,
 			    vcdev->is_thinint ?
@@ -657,10 +667,10 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * We need a data area under 2G to communicate. Our payload is
 	 * the address of the indicators.
 	*/
-	indicatorp = kmalloc(sizeof(&vcdev->indicators), GFP_DMA | GFP_KERNEL);
+	indicatorp = kmalloc(sizeof(indicators(vcdev)), GFP_DMA | GFP_KERNEL);
 	if (!indicatorp)
 		goto out;
-	*indicatorp = (unsigned long) &vcdev->indicators;
+	*indicatorp = (unsigned long) indicators(vcdev);
 	if (vcdev->is_thinint) {
 		ret = virtio_ccw_register_adapter_ind(vcdev, vqs, nvqs, ccw);
 		if (ret)
@@ -669,21 +679,21 @@ static int virtio_ccw_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	}
 	if (!vcdev->is_thinint) {
 		/* Register queue indicators with host. */
-		vcdev->indicators = 0;
+		*indicators(vcdev) = 0;
 		ccw->cmd_code = CCW_CMD_SET_IND;
 		ccw->flags = 0;
-		ccw->count = sizeof(&vcdev->indicators);
+		ccw->count = sizeof(indicators(vcdev));
 		ccw->cda = (__u32)(unsigned long) indicatorp;
 		ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_IND);
 		if (ret)
 			goto out;
 	}
 	/* Register indicators2 with host for config changes */
-	*indicatorp = (unsigned long) &vcdev->indicators2;
-	vcdev->indicators2 = 0;
+	*indicatorp = (unsigned long) indicators2(vcdev);
+	*indicators2(vcdev) = 0;
 	ccw->cmd_code = CCW_CMD_SET_CONF_IND;
 	ccw->flags = 0;
-	ccw->count = sizeof(&vcdev->indicators2);
+	ccw->count = sizeof(indicators2(vcdev));
 	ccw->cda = (__u32)(unsigned long) indicatorp;
 	ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_SET_CONF_IND);
 	if (ret)
@@ -1093,17 +1103,17 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 			vcdev->err = -EIO;
 	}
 	virtio_ccw_check_activity(vcdev, activity);
-	for_each_set_bit(i, &vcdev->indicators,
-			 sizeof(vcdev->indicators) * BITS_PER_BYTE) {
+	for_each_set_bit(i, indicators(vcdev),
+			 sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
 		/* The bit clear must happen before the vring kick. */
-		clear_bit(i, &vcdev->indicators);
+		clear_bit(i, indicators(vcdev));
 		barrier();
 		vq = virtio_ccw_vq_by_ind(vcdev, i);
 		vring_interrupt(0, vq);
 	}
-	if (test_bit(0, &vcdev->indicators2)) {
+	if (test_bit(0, indicators2(vcdev))) {
 		virtio_config_changed(&vcdev->vdev);
-		clear_bit(0, &vcdev->indicators2);
+		clear_bit(0, indicators2(vcdev));
 	}
 }
 
-- 
2.13.4

