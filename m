Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8475C94C00
	for <lists+linux-s390@lfdr.de>; Mon, 19 Aug 2019 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfHSRtB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Aug 2019 13:49:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726987AbfHSRtA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Aug 2019 13:49:00 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JHmIvf062399;
        Mon, 19 Aug 2019 13:48:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufwgx7du7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 13:48:59 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7JHmH3M062354;
        Mon, 19 Aug 2019 13:48:58 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufwgx7dte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 13:48:58 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7JHixJC015914;
        Mon, 19 Aug 2019 17:48:58 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 2ufye00c08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 17:48:57 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JHmrii40305126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 17:48:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00A3F6A05D;
        Mon, 19 Aug 2019 17:48:52 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E7066A047;
        Mon, 19 Aug 2019 17:48:52 +0000 (GMT)
Received: from akrowiak-ThinkPad-P50.endicott.ibm.com (unknown [9.60.75.238])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Mon, 19 Aug 2019 17:48:52 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     freude@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, frankja@linux.ibm.com,
        jjherne@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable queue interrupts
Date:   Mon, 19 Aug 2019 13:48:49 -0400
Message-Id: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190189
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When an AP queue is reset (zeroized), interrupts are disabled. The queue
reset function currently tries to disable interrupts unnecessarily. This patch
removes the unnecessary calls to disable interrupts after queue reset.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 0604b49a4d32..e3bcb430e214 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1114,18 +1114,19 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
-static void vfio_ap_irq_disable_apqn(int apqn)
+static struct vfio_ap_queue *vfio_ap_find_qdev(int apqn)
 {
 	struct device *dev;
-	struct vfio_ap_queue *q;
+	struct vfio_ap_queue *q = NULL;
 
 	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
 				 &apqn, match_apqn);
 	if (dev) {
 		q = dev_get_drvdata(dev);
-		vfio_ap_irq_disable(q);
 		put_device(dev);
 	}
+
+	return q;
 }
 
 int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
@@ -1164,6 +1165,7 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 	int rc = 0;
 	unsigned long apid, apqi;
 	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
+	struct vfio_ap_queue *q;
 
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
 			     matrix_mdev->matrix.apm_max + 1) {
@@ -1177,7 +1179,18 @@ static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
 			 */
 			if (ret)
 				rc = ret;
-			vfio_ap_irq_disable_apqn(AP_MKQID(apid, apqi));
+
+			/*
+			 * Resetting a queue disables interrupts as a side
+			 * effect, so there is no need to disable interrupts
+			 * here. Note that an error on reset indicates the
+			 * queue is inaccessible, so an attempt to disable
+			 * interrupts would fail and is therefore unnecessary.
+			 * Just free up the resources used by IRQ processing.
+			 */
+			q = vfio_ap_find_qdev(AP_MKQID(apid, apqi));
+			if (q)
+				vfio_ap_free_aqic_resources(q);
 		}
 	}
 
-- 
2.7.4

