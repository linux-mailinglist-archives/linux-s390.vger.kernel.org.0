Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B96350347
	for <lists+linux-s390@lfdr.de>; Wed, 31 Mar 2021 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbhCaPX6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 31 Mar 2021 11:23:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24726 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236287AbhCaPX3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 31 Mar 2021 11:23:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VF3YQm058857;
        Wed, 31 Mar 2021 11:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q2tyrZvf6RGEW7ww6sXQNEGMYwL0OnvIwDBulqaFqro=;
 b=tXRNEV5UUcEVHlYq/fCMfHHohrqh4JaQvW9qs88RgQjh0AkKoOHAZU1JFQKgfrC993jj
 6nkdrsuXzg3Ow47idHzLe64WcQp7Fs/xCmBk/lSPHKiJ7ZeKCzCjPBVshkEExzN1Ym1P
 PKgoowjzW9qgHM0WOnFkUk6HApA26BWhoDq0aU+orMGQ9Dp5pVVcVXMon0leNJSzIPN1
 x9gPtqjYKx2jqGuW+vbo2VNew1xi1aLsFSQnMbeEP+/XtsJ4OsHISLtlPFUYo7aYEnN8
 fI0/aAnPnBA5pVbCAVdcvA6gTVvKovY+b0xHKJkkrm3JosuCtY5ZnWpiWBAKu69RZYC8 Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mpdtjtss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 11:23:27 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12VF6jfX073889;
        Wed, 31 Mar 2021 11:23:27 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37mpdtjtsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 11:23:27 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12VF5cQO002356;
        Wed, 31 Mar 2021 15:23:26 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 37maacwxkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 15:23:26 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12VFNMNp10682864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Mar 2021 15:23:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7F836E05D;
        Wed, 31 Mar 2021 15:23:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB34D6E050;
        Wed, 31 Mar 2021 15:23:20 +0000 (GMT)
Received: from cpe-66-24-58-13.stny.res.rr.com.com (unknown [9.85.146.149])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 31 Mar 2021 15:23:20 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, freude@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v14 06/13] s390/vfio-ap: refresh guest's APCB by filtering APQNs assigned to mdev
Date:   Wed, 31 Mar 2021 11:22:49 -0400
Message-Id: <20210331152256.28129-7-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210331152256.28129-1-akrowiak@linux.ibm.com>
References: <20210331152256.28129-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ehemqZt62pf0-lzeVtpX7t6rKyUAADa8
X-Proofpoint-ORIG-GUID: ss2MP-N0QvqFU784o2Ap8EvWpSkklm5O
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_06:2021-03-31,2021-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103300000 definitions=main-2103310107
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Refresh the guest's APCB by filtering the APQNs assigned to the matrix mdev
that do not reference an AP queue device bound to the vfio_ap device
driver. The mdev's APQNs will be filtered according to the following rules:

* The APID of each adapter and the APQI of each domain that is not in the
  host's AP configuration is filtered out.

* The APID of each adapter comprising an APQN that does not reference a
  queue device bound to the vfio_ap device driver is filtered. The APQNs
  are derived from the Cartesian product of the APID of each adapter and
  APQI of each domain assigned to the mdev.

The filtering will take place:

* Whenever an adapter, domain or control domains is assigned or
  unassigned.

* When a queue device is bound to or unbound from the vfio_ap device
  driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 84 +++++++++++++++++++++++++++++--
 1 file changed, 81 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 588de7ec4866..241051565783 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -311,6 +311,76 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
 	matrix->adm_max = info->apxa ? info->Nd : 15;
 }
 
+/*
+ * vfio_ap_mdev_filter_apcb
+ *
+ * @matrix_mdev: the mdev whose AP configuration is to be filtered.
+ * @shadow_apcb: the APCB to use to store the guest's AP configuration after
+ *		 filtering takes place.
+ */
+static void vfio_ap_mdev_filter_apcb(struct ap_matrix_mdev *matrix_mdev,
+				     struct ap_matrix *shadow_apcb)
+{
+	int ret;
+	unsigned long apid, apqi, apqn;
+
+	ret = ap_qci(&matrix_dev->info);
+	if (ret)
+		return;
+
+	/*
+	 * Copy the adapters, domains and control domains to the shadow_apcb
+	 * from the matrix mdev, but only those that are assigned to the host's
+	 * AP configuration.
+	 */
+	bitmap_and(shadow_apcb->apm, matrix_mdev->matrix.apm,
+		   (unsigned long *)matrix_dev->info.apm, AP_DEVICES);
+	bitmap_and(shadow_apcb->aqm, matrix_mdev->matrix.aqm,
+		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
+	bitmap_and(shadow_apcb->adm, matrix_mdev->matrix.adm,
+		   (unsigned long *)matrix_dev->info.adm, AP_DOMAINS);
+
+	for_each_set_bit_inv(apid, shadow_apcb->apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, shadow_apcb->aqm, AP_DOMAINS) {
+			/*
+			 * If the APQN is not bound to the vfio_ap device
+			 * driver, then we can't assign it to the guest's
+			 * AP configuration. The AP architecture won't
+			 * allow filtering of a single APQN, so if we're
+			 * filtering APIDs, then filter the APID; otherwise,
+			 * filter the APQI.
+			 */
+			apqn = AP_MKQID(apid, apqi);
+			if (!vfio_ap_mdev_get_queue(matrix_mdev, apqn)) {
+				clear_bit_inv(apid, shadow_apcb->apm);
+				break;
+			}
+		}
+	}
+}
+
+/**
+ * vfio_ap_mdev_refresh_apcb
+ *
+ * Refresh the guest's APCB by filtering the APQNs assigned to the matrix mdev
+ * that do not reference an AP queue device bound to the vfio_ap device driver.
+ *
+ * @matrix_mdev:  the matrix mdev whose AP configuration is to be filtered
+ */
+static void vfio_ap_mdev_refresh_apcb(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct ap_matrix shadow_apcb;
+
+	vfio_ap_matrix_init(&matrix_dev->info, &shadow_apcb);
+	vfio_ap_mdev_filter_apcb(matrix_mdev, &shadow_apcb);
+
+	if (memcmp(&shadow_apcb, &matrix_mdev->shadow_apcb,
+		   sizeof(struct ap_matrix)) != 0) {
+		memcpy(&matrix_mdev->shadow_apcb, &shadow_apcb,
+		       sizeof(struct ap_matrix));
+	}
+}
+
 static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 {
 	struct ap_matrix_mdev *matrix_mdev;
@@ -694,6 +764,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 		goto share_err;
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 	goto done;
 
@@ -763,6 +834,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
 	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -871,6 +943,7 @@ static ssize_t assign_domain_store(struct device *dev,
 		goto share_err;
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 	goto done;
 
@@ -940,6 +1013,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
 	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 
 done:
@@ -999,6 +1073,7 @@ static ssize_t assign_control_domain_store(struct device *dev,
 	 * number of control domains that can be assigned.
 	 */
 	set_bit_inv(id, matrix_mdev->matrix.adm);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -1052,6 +1127,7 @@ static ssize_t unassign_control_domain_store(struct device *dev,
 	}
 
 	clear_bit_inv(domid, matrix_mdev->matrix.adm);
+	vfio_ap_mdev_refresh_apcb(matrix_mdev);
 	ret = count;
 done:
 	mutex_unlock(&matrix_dev->lock);
@@ -1185,8 +1261,6 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		}
 
 		kvm_get_kvm(kvm);
-		memcpy(&matrix_mdev->shadow_apcb, &matrix_mdev->matrix,
-		       sizeof(struct ap_matrix));
 		matrix_mdev->kvm_busy = true;
 		mutex_unlock(&matrix_dev->lock);
 		kvm_arch_crypto_set_masks(kvm, matrix_mdev->shadow_apcb.apm,
@@ -1550,6 +1624,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	q->apqn = to_ap_queue(&apdev->device)->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 	vfio_ap_queue_link_mdev(q);
+	if (q->matrix_mdev)
+		vfio_ap_mdev_refresh_apcb(q->matrix_mdev);
 	dev_set_drvdata(&apdev->device, q);
 	mutex_unlock(&matrix_dev->lock);
 
@@ -1563,8 +1639,10 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
 	mutex_lock(&matrix_dev->lock);
 	q = dev_get_drvdata(&apdev->device);
 
-	if (q->matrix_mdev)
+	if (q->matrix_mdev) {
 		vfio_ap_mdev_unlink_queue_fr_mdev(q);
+		vfio_ap_mdev_refresh_apcb(q->matrix_mdev);
+	}
 
 	vfio_ap_mdev_reset_queue(q, 1);
 	dev_set_drvdata(&apdev->device, NULL);
-- 
2.21.3

