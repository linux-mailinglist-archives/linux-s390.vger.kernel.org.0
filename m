Return-Path: <linux-s390+bounces-9227-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E21A468D8
	for <lists+linux-s390@lfdr.de>; Wed, 26 Feb 2025 19:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB73173765
	for <lists+linux-s390@lfdr.de>; Wed, 26 Feb 2025 18:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5E233714;
	Wed, 26 Feb 2025 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UPpzitt6"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965B221F21;
	Wed, 26 Feb 2025 18:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593042; cv=none; b=ZEc2UbMXPMYUmaY+tCElDq7LMt2/5Flxk2oqdxLWxtaNuoDAHFr4+x9VwqLCUx5fTdw7BlDBuGT6PbC9L96Vf0bZv7TFn/Kex5IYB1U97qV5IV3texFyC6B03grAM6A5F8WoCrbYszDHK4XbK3HxGLEMok0SGN9AWuCWPeJRmUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593042; c=relaxed/simple;
	bh=jyfgZ7hdGQ+7vkMlHbZAbEyF8hHA3oXzDRcU6/jBrqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uS/Xt+BJcEX09U7EqB6ISb2sBzNKjd6gvK+OH9VPecLnOEltyDfZgnmIO4jebMou6Yrh2CTmHRnapdn1v/mTzBIelO55VTYYFCKVZzZyzJlBewqNufugKh8cqqVgsFTtMYDsZYTh10hw2FByROIHU3WoonxdPuvF2RX3TfjdoRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UPpzitt6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QE0VFV027764;
	Wed, 26 Feb 2025 18:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qucujcqLhUwdL3YtH
	IiokciTxPKndQxWgwwJYybcvak=; b=UPpzitt6a5UkJzov93/EcB8TV/PWe5JIh
	IcMN6PDoJn1jWvwm6AjKw8j9kI3JTJ/ifO31Tpl0bRnPDgCOm5D+M0oLBFGPJjs3
	Ge9ygDc7G/5ztvsazsR4sK7WkZ3kPJQZkkzJCA5eyf4BF8ZD23koK+ljI05YfvDi
	GTbC0o1PD5lLAFjCpdCEyPHv2UsOmyMUdmQfC3yNjPm9RXb14fbKrQ25qGojcjfL
	riVWKXFfHByz8++r+UCkIXcWVkAB16nTNke9Kmad2GFXIQBzPWT+lMr63OvnMNKS
	OPNnKdTqnF2OWnCl2gKok5HbVsi4rU2vpw7CwI0wPz71zBgYPNJkw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5jcw51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:03:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51QGxrGn027340;
	Wed, 26 Feb 2025 18:03:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum23q67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 18:03:57 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51QI3tPq17171102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 18:03:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3371A5803F;
	Wed, 26 Feb 2025 18:03:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 724C858060;
	Wed, 26 Feb 2025 18:03:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.248.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 18:03:54 +0000 (GMT)
From: Rorie Reyes <rreyes@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: hca@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com, pasic@linux.ibm.com, jjherne@linux.ibm.com,
        alex.williamson@redhat.com, akrowiak@linux.ibm.com,
        rreyes@linux.ibm.com
Subject: [RFC PATCH v2 1/2] s390/vfio-ap: Signal eventfd when guest AP configuration is changed
Date: Wed, 26 Feb 2025 13:03:52 -0500
Message-ID: <20250226180353.15511-2-rreyes@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226180353.15511-1-rreyes@linux.ibm.com>
References: <20250226180353.15511-1-rreyes@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wJ7XRjP4Bw5hHiK6MqQHO70dugd3ks7J
X-Proofpoint-ORIG-GUID: wJ7XRjP4Bw5hHiK6MqQHO70dugd3ks7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260142

In this patch, an eventfd object is created by the vfio_ap device driver
and used to notify userspace when a guests's AP configuration is
dynamically changed. Such changes may occur whenever:

* An adapter, domain or control domain is assigned to or unassigned from a
  mediated device that is attached to the guest.
* A queue assigned to the mediated device that is attached to a guest is
  bound to or unbound from the vfio_ap device driver. This can occur
  either by manually binding/unbinding the queue via the vfio_ap driver's
  sysfs bind/unbind attribute interfaces, or because an adapter, domain or
  control domain assigned to the mediated device is added to or removed
  from the host's AP configuration via an SE/HMC

Signed-off-by: Rorie Reyes <rreyes@linux.ibm.com>
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Tested-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 52 ++++++++++++++++++++++++++-
 drivers/s390/crypto/vfio_ap_private.h |  2 ++
 include/uapi/linux/vfio.h             |  1 +
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a52c2690933f..c6ff4ab13f16 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -650,13 +650,22 @@ static void vfio_ap_matrix_init(struct ap_config_info *info,
 	matrix->adm_max = info->apxa ? info->nd : 15;
 }
 
+static void signal_guest_ap_cfg_changed(struct ap_matrix_mdev *matrix_mdev)
+{
+		if (matrix_mdev->cfg_chg_trigger)
+			eventfd_signal(matrix_mdev->cfg_chg_trigger);
+}
+
 static void vfio_ap_mdev_update_guest_apcb(struct ap_matrix_mdev *matrix_mdev)
 {
-	if (matrix_mdev->kvm)
+	if (matrix_mdev->kvm) {
 		kvm_arch_crypto_set_masks(matrix_mdev->kvm,
 					  matrix_mdev->shadow_apcb.apm,
 					  matrix_mdev->shadow_apcb.aqm,
 					  matrix_mdev->shadow_apcb.adm);
+
+		signal_guest_ap_cfg_changed(matrix_mdev);
+	}
 }
 
 static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
@@ -792,6 +801,7 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	if (ret)
 		goto err_put_vdev;
 	matrix_mdev->req_trigger = NULL;
+	matrix_mdev->cfg_chg_trigger = NULL;
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
@@ -1860,6 +1870,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		get_update_locks_for_kvm(kvm);
 
 		kvm_arch_crypto_clear_masks(kvm);
+		signal_guest_ap_cfg_changed(matrix_mdev);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
 		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
@@ -2097,6 +2108,10 @@ static ssize_t vfio_ap_get_irq_info(unsigned long arg)
 		info.count = 1;
 		info.flags = VFIO_IRQ_INFO_EVENTFD;
 		break;
+	case VFIO_AP_CFG_CHG_IRQ_INDEX:
+		info.count = 1;
+		info.flags = VFIO_IRQ_INFO_EVENTFD;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -2160,6 +2175,39 @@ static int vfio_ap_set_request_irq(struct ap_matrix_mdev *matrix_mdev,
 	return 0;
 }
 
+static int vfio_ap_set_cfg_change_irq(struct ap_matrix_mdev *matrix_mdev, unsigned long arg)
+{
+	s32 fd;
+	void __user *data;
+	unsigned long minsz;
+	struct eventfd_ctx *cfg_chg_trigger;
+
+	minsz = offsetofend(struct vfio_irq_set, count);
+	data = (void __user *)(arg + minsz);
+
+	if (get_user(fd, (s32 __user *)data))
+		return -EFAULT;
+
+	if (fd == -1) {
+		if (matrix_mdev->cfg_chg_trigger)
+			eventfd_ctx_put(matrix_mdev->cfg_chg_trigger);
+		matrix_mdev->cfg_chg_trigger = NULL;
+	} else if (fd >= 0) {
+		cfg_chg_trigger = eventfd_ctx_fdget(fd);
+		if (IS_ERR(cfg_chg_trigger))
+			return PTR_ERR(cfg_chg_trigger);
+
+		if (matrix_mdev->cfg_chg_trigger)
+			eventfd_ctx_put(matrix_mdev->cfg_chg_trigger);
+
+		matrix_mdev->cfg_chg_trigger = cfg_chg_trigger;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int vfio_ap_set_irqs(struct ap_matrix_mdev *matrix_mdev,
 			    unsigned long arg)
 {
@@ -2175,6 +2223,8 @@ static int vfio_ap_set_irqs(struct ap_matrix_mdev *matrix_mdev,
 		switch (irq_set.index) {
 		case VFIO_AP_REQ_IRQ_INDEX:
 			return vfio_ap_set_request_irq(matrix_mdev, arg);
+		case VFIO_AP_CFG_CHG_IRQ_INDEX:
+			return vfio_ap_set_cfg_change_irq(matrix_mdev, arg);
 		default:
 			return -EINVAL;
 		}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 437a161c8659..37de9c69b6eb 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -105,6 +105,7 @@ struct ap_queue_table {
  * @mdev:	the mediated device
  * @qtable:	table of queues (struct vfio_ap_queue) assigned to the mdev
  * @req_trigger eventfd ctx for signaling userspace to return a device
+ * @cfg_chg_trigger eventfd ctx to signal AP config changed to userspace
  * @apm_add:	bitmap of APIDs added to the host's AP configuration
  * @aqm_add:	bitmap of APQIs added to the host's AP configuration
  * @adm_add:	bitmap of control domain numbers added to the host's AP
@@ -120,6 +121,7 @@ struct ap_matrix_mdev {
 	struct mdev_device *mdev;
 	struct ap_queue_table qtable;
 	struct eventfd_ctx *req_trigger;
+	struct eventfd_ctx *cfg_chg_trigger;
 	DECLARE_BITMAP(apm_add, AP_DEVICES);
 	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
 	DECLARE_BITMAP(adm_add, AP_DOMAINS);
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index c8dbf8219c4f..a2d3e1ac6239 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -671,6 +671,7 @@ enum {
  */
 enum {
 	VFIO_AP_REQ_IRQ_INDEX,
+	VFIO_AP_CFG_CHG_IRQ_INDEX,
 	VFIO_AP_NUM_IRQS
 };
 
-- 
2.39.5 (Apple Git-154)


