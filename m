Return-Path: <linux-s390+bounces-532-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7FF80F93B
	for <lists+linux-s390@lfdr.de>; Tue, 12 Dec 2023 22:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B941F21CE2
	for <lists+linux-s390@lfdr.de>; Tue, 12 Dec 2023 21:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7492E6414F;
	Tue, 12 Dec 2023 21:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Uiz7bAf5"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF1DF2;
	Tue, 12 Dec 2023 13:25:33 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCK2Wwg030609;
	Tue, 12 Dec 2023 21:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yyT/W3/te9EOKgIXE0xPbPV+ObBeSsB2AX4VhVDzucQ=;
 b=Uiz7bAf53dGJsFpn8KB0Vzsp4cEavdEwh9WKkG0W0jsZyWgPvrhgYTf8hbnMJjg6wUH5
 eM4EsRudf4ZyUU6zx3IbK+x1AIyZNqL0PYrNwO0mv6rHRfbnRE6CXedS79/xIhm6doJ+
 szWCjCJteEXpd6R0viqSpstDhFlh/VL7C1JGnCU/soFUo4vpqQqs5jZpe0cfrOq8EdsX
 LVwZBRlyZGxoUyOHUNrECsBm1Z8Y6kIRhhzhCaNJhTumDF8TMXpTflz2jFzhWXRkwYll
 QRe2p7ynU/ZEEsivJPONsu8B8QYpUCiMYKh4b4rhnO6/54Kw2st3ZNk0lKwuMpF9/Jl7 yQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxx6usyq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 21:25:32 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCLP5ra022088;
	Tue, 12 Dec 2023 21:25:31 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxx6usype-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 21:25:31 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCJ1BQY012585;
	Tue, 12 Dec 2023 21:25:30 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jnv494-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 21:25:30 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCLPSLk25428554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 21:25:28 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8988D58067;
	Tue, 12 Dec 2023 21:25:28 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F0B558056;
	Tue, 12 Dec 2023 21:25:27 +0000 (GMT)
Received: from li-2c1e724c-2c76-11b2-a85c-ae42eaf3cb3d.ibm.com.com (unknown [9.61.187.43])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Dec 2023 21:25:27 +0000 (GMT)
From: Tony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        stable@vger.kernel.org
Subject: [PATCH v2 4/6] s390/vfio-ap: reset queues filtered from the guest's AP config
Date: Tue, 12 Dec 2023 16:25:15 -0500
Message-ID: <20231212212522.307893-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231212212522.307893-1-akrowiak@linux.ibm.com>
References: <20231212212522.307893-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -qzyUlVkK4Wgew0LL2qRBRplYYZwpnws
X-Proofpoint-ORIG-GUID: pCo4cbxAEQsyF46cKB3fpMkhkTrwBgzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_12,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120165

When filtering the adapters from the configuration profile for a guest to
create or update a guest's AP configuration, if the APID of an adapter and
the APQI of a domain identify a queue device that is not bound to the
vfio_ap device driver, the APID of the adapter will be filtered because an
individual APQN can not be filtered due to the fact the APQNs are assigned
to an AP configuration as a matrix of APIDs and APQIs. Consequently, a
guest will not have access to all of the queues associated with the
filtered adapter. If the queues are subsequently made available again to
the guest, they should re-appear in a reset state; so, let's make sure all
queues associated with an adapter unplugged from the guest are reset.

In order to identify the set of queues that need to be reset, let's allow a
vfio_ap_queue object to be simultaneously stored in both a hashtable and a
list: A hashtable used to store all of the queues assigned
to a matrix mdev; and/or, a list used to store a subset of the queues that
need to be reset. For example, when an adapter is hot unplugged from a
guest, all guest queues associated with that adapter must be reset. Since
that may be a subset of those assigned to the matrix mdev, they can be
stored in a list that can be passed to the vfio_ap_mdev_reset_queues
function.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: <stable@vger.kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 171 +++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |  11 +-
 2 files changed, 133 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 26bd4aca497a..11f8f0bcc7ed 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -32,7 +32,8 @@
 
 #define AP_RESET_INTERVAL		20	/* Reset sleep interval (20ms)		*/
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable);
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
 static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q);
@@ -661,16 +662,23 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  *				device driver.
  *
  * @matrix_mdev: the matrix mdev whose matrix is to be filtered.
+ * @apm_filtered: a 256-bit bitmap for storing the APIDs filtered from the
+ *		  guest's AP configuration that are still in the host's AP
+ *		  configuration.
  *
  * Note: If an APQN referencing a queue device that is not bound to the vfio_ap
  *	 driver, its APID will be filtered from the guest's APCB. The matrix
  *	 structure precludes filtering an individual APQN, so its APID will be
- *	 filtered.
+ *	 filtered. Consequently, all queues associated with the adapter that
+ *	 are in the host's AP configuration must be reset. If queues are
+ *	 subsequently made available again to the guest, they should re-appear
+ *	 in a reset state
  *
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
+				       unsigned long *apm_filtered)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -680,6 +688,7 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	bitmap_clear(apm_filtered, 0, AP_DEVICES);
 
 	/*
 	 * Copy the adapters, domains and control domains to the shadow_apcb
@@ -705,8 +714,16 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 			apqn = AP_MKQID(apid, apqi);
 			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
 			if (!q || q->reset_status.response_code) {
-				clear_bit_inv(apid,
-					      matrix_mdev->shadow_apcb.apm);
+				clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+
+				/*
+				 * If the adapter was previously plugged into
+				 * the guest, let's let the caller know that
+				 * the APID was filtered.
+				 */
+				if (test_bit_inv(apid, prev_shadow_apm))
+					set_bit_inv(apid, apm_filtered);
+
 				break;
 			}
 		}
@@ -808,7 +825,7 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	vfio_ap_mdev_unlink_fr_queues(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->mdevs_lock);
@@ -918,6 +935,47 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 				       AP_MKQID(apid, apqi));
 }
 
+static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long *apm_reset)
+{
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
+	unsigned long apid, apqi;
+	int apqn, ret = 0;
+
+	if (bitmap_empty(apm_reset, AP_DEVICES))
+		return 0;
+
+	INIT_LIST_HEAD(&qlist);
+
+	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
+				     AP_DOMAINS) {
+			/*
+			 * If the domain is not in the host's AP configuration,
+			 * then resetting it will fail with response code 01
+			 * (APQN not valid).
+			 */
+			if (!test_bit_inv(apqi,
+					  (unsigned long *)matrix_dev->info.aqm))
+				continue;
+
+			apqn = AP_MKQID(apid, apqi);
+			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
+			if (q)
+				list_add_tail(&q->reset_qnode, &qlist);
+		}
+	}
+
+	ret = vfio_ap_mdev_reset_qlist(&qlist);
+
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode)
+		list_del(&q->reset_qnode);
+
+	return ret;
+}
+
 /**
  * assign_adapter_store - parses the APID from @buf and sets the
  * corresponding bit in the mediated matrix device's APM
@@ -958,6 +1016,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -987,8 +1046,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1019,11 +1080,12 @@ static struct vfio_ap_queue
  *				 adapter was assigned.
  * @matrix_mdev: the matrix mediated device to which the adapter was assigned.
  * @apid: the APID of the unassigned adapter.
- * @qtable: table for storing queues associated with unassigned adapter.
+ * @qlist: list for storing queues associated with unassigned adapter that
+ *	   need to be reset.
  */
 static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 					unsigned long apid,
-					struct ap_queue_table *qtable)
+					struct list_head *qlist)
 {
 	unsigned long apqi;
 	struct vfio_ap_queue *q;
@@ -1031,11 +1093,10 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1043,26 +1104,23 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
 					    unsigned long apid)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
 
 	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
 		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1163,6 +1221,7 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1192,8 +1251,10 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1206,7 +1267,7 @@ static DEVICE_ATTR_WO(assign_domain);
 
 static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 				       unsigned long apqi,
-				       struct ap_queue_table *qtable)
+				       struct list_head *qlist)
 {
 	unsigned long apid;
 	struct vfio_ap_queue *q;
@@ -1214,11 +1275,10 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1226,26 +1286,23 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 					   unsigned long apqi)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
 
 	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
 		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1600,7 +1657,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		get_update_locks_for_kvm(kvm);
 
 		kvm_arch_crypto_clear_masks(kvm);
-		vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		vfio_ap_mdev_reset_queues(matrix_mdev);
 		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
@@ -1736,15 +1793,33 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 	}
 }
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	int ret = 0, loop_cursor;
 	struct vfio_ap_queue *q;
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode)
+	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode)
 		vfio_ap_mdev_reset_queue(q);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
+		flush_work(&q->reset_work);
+
+		if (q->reset_status.response_code)
+			ret = -EIO;
+	}
+
+	return ret;
+}
+
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
+{
+	int ret = 0;
+	struct vfio_ap_queue *q;
+
+	list_for_each_entry(q, qlist, reset_qnode)
+		vfio_ap_mdev_reset_queue(q);
+
+	list_for_each_entry(q, qlist, reset_qnode) {
 		flush_work(&q->reset_work);
 
 		if (q->reset_status.response_code)
@@ -1930,7 +2005,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
-		ret = vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	case VFIO_DEVICE_GET_IRQ_INFO:
 			ret = vfio_ap_get_irq_info(arg);
@@ -2062,6 +2137,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	int ret;
 	struct vfio_ap_queue *q;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2094,15 +2170,17 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		    !bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS))
 			goto done;
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
+		}
 	}
 
 done:
 	dev_set_drvdata(&apdev->device, q);
 	release_update_locks_for_mdev(matrix_mdev);
 
-	return 0;
+	return ret;
 
 err_remove_group:
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2446,6 +2524,7 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
@@ -2459,7 +2538,7 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 					 matrix_mdev->adm_add, AP_DOMAINS);
 
 	if (filter_adapters || filter_domains)
-		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
 
 	if (filter_cdoms)
 		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
@@ -2467,6 +2546,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
+	reset_queues_for_apids(matrix_mdev, apm_filtered);
+
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_mdev->kvm->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 88aff8b81f2f..20eac8b0f0b9 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -83,10 +83,10 @@ struct ap_matrix {
 };
 
 /**
- * struct ap_queue_table - a table of queue objects.
- *
- * @queues: a hashtable of queues (struct vfio_ap_queue).
- */
+  * struct ap_queue_table - a table of queue objects.
+  *
+  * @queues: a hashtable of queues (struct vfio_ap_queue).
+  */
 struct ap_queue_table {
 	DECLARE_HASHTABLE(queues, 8);
 };
@@ -133,6 +133,8 @@ struct ap_matrix_mdev {
  * @apqn: the APQN of the AP queue device
  * @saved_isc: the guest ISC registered with the GIB interface
  * @mdev_qnode: allows the vfio_ap_queue struct to be added to a hashtable
+ * @reset_qnode: allows the vfio_ap_queue struct to be added to a list of queues
+ *		 that need to be reset
  * @reset_status: the status from the last reset of the queue
  * @reset_work: work to wait for queue reset to complete
  */
@@ -143,6 +145,7 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 	struct hlist_node mdev_qnode;
+	struct list_head reset_qnode;
 	struct ap_queue_status reset_status;
 	struct work_struct reset_work;
 };
-- 
2.43.0


