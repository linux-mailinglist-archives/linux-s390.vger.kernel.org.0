Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F70424E164
	for <lists+linux-s390@lfdr.de>; Fri, 21 Aug 2020 21:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHUT4n (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Aug 2020 15:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33268 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726846AbgHUT4h (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Aug 2020 15:56:37 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07LJW0AJ086100;
        Fri, 21 Aug 2020 15:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Q83ZffGYATxIZXUMd+md0kXm5JAcARVD+UGuULz5O7U=;
 b=pAWD3kVdZuY8j4g33+wlgcqqlNRFQrrzYi98Msr4jq67aV6gX5HWnnaexo4VhI8j2DYi
 8cZlDFC6oXUm9Z+fZ1Oyxf2c83qezoQ8uz7Dl2rfrStFJyGaBpLstSXd0pCvSu3slCPI
 HRFKEN2Rl0rc24sHGrAPxGvlSPERMtSoCootMaM7g8ZGzFTS7lae2Pmb4hOu0saEv1Dz
 YljHFHi6qp7kspZQJBlfaZoCbRI35EfdrRSkttaInB3cvDtH+x8MiodwIQE14gDaIuJV
 J7RB78NrnDsgIQy0+J+CZyBIcZWj1jc+nCJDXGS69r3KUI8OuK9bH1XJjaZ5sK4YvfwV Xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332jhakdm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 15:56:34 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07LJXj86090839;
        Fri, 21 Aug 2020 15:56:33 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 332jhakdkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 15:56:33 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07LJsqXM013481;
        Fri, 21 Aug 2020 19:56:32 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma01wdc.us.ibm.com with ESMTP id 3304tm6m7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Aug 2020 19:56:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07LJuTQH60096978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 19:56:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0F07805F;
        Fri, 21 Aug 2020 19:56:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C96857805C;
        Fri, 21 Aug 2020 19:56:27 +0000 (GMT)
Received: from cpe-172-100-175-116.stny.res.rr.com.com (unknown [9.85.191.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 21 Aug 2020 19:56:27 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v10 03/16] s390/vfio-ap: manage link between queue struct and matrix mdev
Date:   Fri, 21 Aug 2020 15:56:03 -0400
Message-Id: <20200821195616.13554-4-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200821195616.13554-1-akrowiak@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-21_08:2020-08-21,2020-08-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=11 bulkscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008210178
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's create links between each queue device bound to the vfio_ap device
driver and the matrix mdev to which the queue is assigned. The idea is to
facilitate efficient retrieval of the objects representing the queue
devices and matrix mdevs as well as to verify that a queue assigned to
a matrix mdev is bound to the driver.

The links will be created as follows:

   * When the queue device is probed, if its APQN is assigned to a matrix
     mdev, the structures representing the queue device and the matrix mdev
     will be linked.

   * When an adapter or domain is assigned to a matrix mdev, for each new
     APQN assigned that references a queue device bound to the vfio_ap
     device driver, the structures representing the queue device and the
     matrix mdev will be linked.

The links will be removed as follows:

   * When the queue device is removed, if its APQN is assigned to a matrix
     mdev, the structures representing the queue device and the matrix mdev
     will be unlinked.

   * When an adapter or domain is unassigned from a matrix mdev, for each
     APQN unassigned that references a queue device bound to the vfio_ap
     device driver, the structures representing the queue device and the
     matrix mdev will be unlinked.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 132 +++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |   2 +
 2 files changed, 129 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index ad3925f04f61..2e37ee82e422 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -50,6 +50,19 @@ static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
 	return q;
 }
 
+static struct vfio_ap_queue *vfio_ap_get_mdev_queue(struct ap_matrix_mdev *matrix_mdev,
+						    unsigned long apqn)
+{
+	struct vfio_ap_queue *q;
+
+	hash_for_each_possible(matrix_mdev->qtable, q, mdev_qnode, apqn) {
+		if (q && (q->apqn == apqn))
+			return q;
+	}
+
+	return NULL;
+}
+
 /**
  * vfio_ap_wait_for_irqclear
  * @apqn: The AP Queue number
@@ -160,7 +173,6 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 		  status.response_code);
 end_free:
 	vfio_ap_free_aqic_resources(q);
-	q->matrix_mdev = NULL;
 	return status;
 }
 
@@ -262,7 +274,6 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 	struct vfio_ap_queue *q;
 	struct ap_queue_status qstatus = {
 			       .response_code = AP_RESPONSE_Q_NOT_AVAIL, };
-	struct ap_matrix_mdev *matrix_mdev;
 
 	/* If we do not use the AIV facility just go to userland */
 	if (!(vcpu->arch.sie_block->eca & ECA_AIV))
@@ -273,14 +284,11 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
 
 	if (!vcpu->kvm->arch.crypto.pqap_hook)
 		goto out_unlock;
-	matrix_mdev = container_of(vcpu->kvm->arch.crypto.pqap_hook,
-				   struct ap_matrix_mdev, pqap_hook);
 
 	q = vfio_ap_get_queue(apqn);
 	if (!q)
 		goto out_unlock;
 
-	q->matrix_mdev = matrix_mdev;
 	status = vcpu->run->s.regs.gprs[1];
 
 	/* If IR bit(16) is set we enable the interrupt */
@@ -320,6 +328,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 
 	matrix_mdev->mdev = mdev;
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
+	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
 	matrix_mdev->pqap_hook.owner = THIS_MODULE;
@@ -548,6 +557,87 @@ static int vfio_ap_mdev_verify_no_sharing(struct ap_matrix_mdev *matrix_mdev)
 	return 0;
 }
 
+enum qlink_type {
+	LINK_APID,
+	LINK_APQI,
+	UNLINK_APID,
+	UNLINK_APQI,
+};
+
+static void vfio_ap_mdev_link_queue(struct ap_matrix_mdev *matrix_mdev,
+				    unsigned long apid, unsigned long apqi)
+{
+	struct vfio_ap_queue *q;
+
+	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+	if (q) {
+		q->matrix_mdev = matrix_mdev;
+		hash_add(matrix_mdev->qtable,
+			 &q->mdev_qnode, q->apqn);
+	}
+}
+
+static void vfio_ap_mdev_unlink_queue(unsigned long apid, unsigned long apqi)
+{
+	struct vfio_ap_queue *q;
+
+	q = vfio_ap_get_queue(AP_MKQID(apid, apqi));
+	if (q) {
+		q->matrix_mdev = NULL;
+		hash_del(&q->mdev_qnode);
+	}
+}
+
+/**
+ * vfio_ap_mdev_link_queues
+ *
+ * @matrix_mdev: The matrix mdev to link.
+ * @type:	 The type of @qlink_id.
+ * @qlink_id:	 The APID or APQI of the queues to link.
+ *
+ * Sets or clears the links between the queues with the specified @qlink_id
+ * and the @matrix_mdev:
+ *     @type == LINK_APID: Set the links between the @matrix_mdev and the
+ *                         queues with the specified @qlink_id (APID)
+ *     @type == LINK_APQI: Set the links between the @matrix_mdev and the
+ *                         queues with the specified @qlink_id (APQI)
+ *     @type == UNLINK_APID: Clear the links between the @matrix_mdev and the
+ *                           queues with the specified @qlink_id (APID)
+ *     @type == UNLINK_APQI: Clear the links between the @matrix_mdev and the
+ *                           queues with the specified @qlink_id (APQI)
+ */
+static void vfio_ap_mdev_link_queues(struct ap_matrix_mdev *matrix_mdev,
+				     enum qlink_type type,
+				     unsigned long qlink_id)
+{
+	unsigned long id;
+
+	switch (type) {
+	case LINK_APID:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, qlink_id, id);
+		break;
+	case UNLINK_APID:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.aqm,
+				     matrix_mdev->matrix.aqm_max + 1)
+			vfio_ap_mdev_unlink_queue(qlink_id, id);
+		break;
+	case LINK_APQI:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
+				     matrix_mdev->matrix.apm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
+		break;
+	case UNLINK_APQI:
+		for_each_set_bit_inv(id, matrix_mdev->matrix.apm,
+				     matrix_mdev->matrix.apm_max + 1)
+			vfio_ap_mdev_link_queue(matrix_mdev, id, qlink_id);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+	}
+}
+
 /**
  * assign_adapter_store
  *
@@ -617,6 +707,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APID, apid);
 	ret = count;
 	goto done;
 
@@ -668,6 +759,7 @@ static ssize_t unassign_adapter_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apid, matrix_mdev->matrix.apm);
+	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APID, apid);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -758,6 +850,7 @@ static ssize_t assign_domain_store(struct device *dev,
 	if (ret)
 		goto share_err;
 
+	vfio_ap_mdev_link_queues(matrix_mdev, LINK_APQI, apqi);
 	ret = count;
 	goto done;
 
@@ -810,6 +903,7 @@ static ssize_t unassign_domain_store(struct device *dev,
 
 	mutex_lock(&matrix_dev->lock);
 	clear_bit_inv((unsigned long)apqi, matrix_mdev->matrix.aqm);
+	vfio_ap_mdev_link_queues(matrix_mdev, UNLINK_APQI, apqi);
 	mutex_unlock(&matrix_dev->lock);
 
 	return count;
@@ -1282,6 +1376,29 @@ void vfio_ap_mdev_unregister(void)
 	mdev_unregister_device(&matrix_dev->device);
 }
 
+/**
+ * vfio_ap_queue_link_mdev
+ *
+ * @q: The queue to link with the matrix mdev.
+ *
+ * Links @q with the matrix mdev to which the queue's APQN is assigned.
+ */
+static void vfio_ap_queue_link_mdev(struct vfio_ap_queue *q)
+{
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
+		    test_bit_inv(apqi, matrix_mdev->matrix.aqm)) {
+			q->matrix_mdev = matrix_mdev;
+			hash_add(matrix_mdev->qtable, &q->mdev_qnode, q->apqn);
+			break;
+		}
+	}
+}
+
 int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
 {
 	struct vfio_ap_queue *q;
@@ -1290,9 +1407,12 @@ int vfio_ap_mdev_probe_queue(struct ap_queue *queue)
 	if (!q)
 		return -ENOMEM;
 
+	mutex_lock(&matrix_dev->lock);
 	dev_set_drvdata(&queue->ap_dev.device, q);
 	q->apqn = queue->qid;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
+	vfio_ap_queue_link_mdev(q);
+	mutex_unlock(&matrix_dev->lock);
 
 	return 0;
 }
@@ -1309,6 +1429,8 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
 	apqi = AP_QID_QUEUE(q->apqn);
 	vfio_ap_mdev_reset_queue(apid, apqi, 1);
 	vfio_ap_irq_disable(q);
+	if (q->matrix_mdev)
+		hash_del(&q->mdev_qnode);
 	kfree(q);
 	mutex_unlock(&matrix_dev->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index a2aa05bec718..57da703b549a 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -87,6 +87,7 @@ struct ap_matrix_mdev {
 	struct kvm *kvm;
 	struct kvm_s390_module_hook pqap_hook;
 	struct mdev_device *mdev;
+	DECLARE_HASHTABLE(qtable, 8);
 };
 
 extern int vfio_ap_mdev_register(void);
@@ -98,6 +99,7 @@ struct vfio_ap_queue {
 	int	apqn;
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
+	struct hlist_node mdev_qnode;
 };
 
 int vfio_ap_mdev_probe_queue(struct ap_queue *queue);
-- 
2.21.1

