Return-Path: <linux-s390+bounces-18102-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C+lK1NOxGljyAQAu9opvQ
	(envelope-from <linux-s390+bounces-18102-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 25 Mar 2026 22:06:27 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D0D32C222
	for <lists+linux-s390@lfdr.de>; Wed, 25 Mar 2026 22:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46CC930607C0
	for <lists+linux-s390@lfdr.de>; Wed, 25 Mar 2026 21:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7432F770;
	Wed, 25 Mar 2026 21:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W1FpEpV5"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C533264E2;
	Wed, 25 Mar 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774472536; cv=none; b=VsnqE/MQb0/DbpkQ+doodcDLTnSGPuCtQolcGzsWd+wguePAaqxBbajuqzbxUB/qXUT5fsojPRjahX/g193uKQpzosVY0EKwLb/RzFzmpg8FynzqlCC7V0hCc1iN084IBWYgSLy4lU1eBcf/b8+sNaZ6YiKg58IGV4Js51QGfwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774472536; c=relaxed/simple;
	bh=r1BBO8THHMD1nvEdzLFbhKsfOs+aaK6tcAlXZfrclc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB2f/gM1DZzs19Gs7+RrLSSfh0JyyCiglKRES/j6roSUzdqMNLVq9exY2GcR9bMHNRx/YHkLgQ0iYtfhGFD4lSMRAwVRSm6icZSbGJGioPu6tl//jsUG+5g75X9HbRlPFo+CUYuklRTXrEWJlHQyQ/sjzRdm3vTCXK//9Qm8WKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W1FpEpV5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PITXbl3850414;
	Wed, 25 Mar 2026 21:02:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aRsoX3F8eLgpQ8AJ8
	3uz73PGQ0Uf1COx5P29N1OoJiY=; b=W1FpEpV5ArebsxWWCZXd5MMQ3K+8F2kAp
	Rqnc8qVghNV0ZlDLnc6Tu0C1VYjl0+8z5QnTXsEy7SZMm+6iR81AXL13Rp31B6tT
	kDa0uYV565Aszlxo56YPkhlQACtqkemo5jAulYSVJRpYzLSIcUxQmGeRgYEhbHaA
	vx9X0LJU4T6FGynQR3ckPDo8TibO8kELinJclOfp9KvdX3s63zgCc7zgRqyZ2TQI
	tnbYZ7Ky6qpn0oh4Iprsta09XI6Q2wDX8R80gGaGGjxU3Ai3ZMUafPAVGNAmnVdU
	pMduMUNK4mqLsSXoPDoaB0L/sVUeyXZvlzRCMaZKH8gRAzhBKvDqg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqjeq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PK32jK026864;
	Wed, 25 Mar 2026 21:02:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m053n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:02:07 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PL25if6554614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:02:06 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1505806E;
	Wed, 25 Mar 2026 21:02:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1E4758052;
	Wed, 25 Mar 2026 21:02:04 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.136.69])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:02:04 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex@shazbot.org, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, pbonzini@redhat.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Subject: [PATCH v1 13/24] s390/vfio-ap: Transition guest migration state from STOP to STOP_COPY
Date: Wed, 25 Mar 2026 17:01:00 -0400
Message-ID: <20260325210149.888028-14-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260325210149.888028-1-akrowiak@linux.ibm.com>
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8nBXdxKT5OtJ9xWlojuD2ZkfkPfVn0o2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE0OSBTYWx0ZWRfX2IjgXdbdxHvO
 TTF/JX8zaAIAQgNGpaZRXn0zRV69KxHUXuNrLqjWXtokx9rBE+Zx7NQe1Cqgq2Q/jjqONPnfxp5
 jhkggeLg6hTFAmf9R/Hm2aJ9LEQTZrb56Rw7N5Kdvk/T4gQbZ+uYgFGB8v3XbJct9C8lkd1wz8R
 bxoL5DRfdkzp81J69+lYA7xqclTg5aUHbtd6sMhXai79d5VJ8P5DPkENV4YQxrPpiinn+ccGeR7
 Y+4q5M/bVbgx+dpd9un1k8QnG7XhNhbyL8ChKDGejejWhUxGx60cWWpQE6iloW0MyQNv3nYCxND
 OIs8PN+A/ad5ndNTSaUWQun+2ctK41/VU4Oxn8Mk4MCnE03G12o05LxlyhwQnwNv06dt93+o9Yf
 SghuM7iieF8S6ZQaPicJ8R+5qqQiwp3PYDcbm5vRtPkcAjtfhzvNkaxashHdvgl0uaBoANeqBO4
 8toDTL07nuDmx6Mmzlg==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c44d50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=M0PqInsX-VO7aBZjA1gA:9
X-Proofpoint-GUID: 8nBXdxKT5OtJ9xWlojuD2ZkfkPfVn0o2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250149
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18102-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akrowiak@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: B8D0D32C222
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The transition of the guest migration state from VFIO_DEVICE_STATE_STOP to
VFIO_DEVICE_STATE_STOP_COPY begins the process of saving the
vfio device state. The vfio device state is comprised of the guest's
AP configuration which specifies the adapters, domains and control
domains to which the guest will be given access.

To begin the process of saving the vfio device state, the VFIO AP device
driver will:

1. Allocate an object in which to store the guest's AP configuration
   information comprised of the APQN and hardware information for each
   queue passed through to the source guest.

2. Opens a file stream that will be used to read the AP configuration
   stored with the object created in #1. The AP configuration will be read
   from this file stream when the guest is resumed on the target system to
   verify that the AP configuration of the source and target guests are
   compatible.

Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_migration.c | 166 +++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_migration.c b/drivers/s390/crypto/vfio_ap_migration.c
index a8b109bc5cf9..ecc9f0f6819e 100644
--- a/drivers/s390/crypto/vfio_ap_migration.c
+++ b/drivers/s390/crypto/vfio_ap_migration.c
@@ -4,6 +4,7 @@
  *
  * Copyright IBM Corp. 2025
  */
+#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include "uapi/linux/vfio_ap.h"
 
@@ -96,12 +97,160 @@ static void vfio_ap_release_mig_files(struct ap_matrix_mdev *matrix_mdev)
 	}
 }
 
+static ssize_t vfio_ap_save_read(struct file *, char __user *, size_t, loff_t *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static int vfio_ap_release_migf(struct inode *, struct file *)
+{
+	/* TODO */
+	return -EOPNOTSUPP;
+}
+
+static const struct file_operations vfio_ap_save_fops = {
+	.owner = THIS_MODULE,
+	.read = vfio_ap_save_read,
+	.compat_ioctl = compat_ptr_ioctl,
+	.release = vfio_ap_release_migf,
+};
+
+static struct vfio_ap_config
+*vfio_ap_allocate_config(struct ap_matrix_mdev *matrix_mdev, size_t *config_sz)
+{
+	struct vfio_ap_config *ap_config;
+	size_t qinfo_size;
+	int num_queues;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	num_queues = vfio_ap_mdev_get_num_queues(&matrix_mdev->shadow_apcb);
+	qinfo_size = num_queues * sizeof(struct vfio_ap_queue_info);
+	*config_sz = qinfo_size + sizeof(struct vfio_ap_config);
+	ap_config = kzalloc(*config_sz, GFP_KERNEL_ACCOUNT);
+
+	if (!ap_config)
+		return ERR_PTR(-ENOMEM);
+
+	ap_config->num_queues = num_queues;
+
+	return ap_config;
+}
+
+static void vfio_ap_store_queue_info(struct vfio_ap_migration_file *migf)
+{
+	unsigned long *apm, *aqm, num_queues, apid, apqi, apqn, data;
+	struct ap_matrix_mdev *matrix_mdev;
+	struct vfio_ap_queue *q;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	matrix_mdev = migf->matrix_mdev;
+	apm = matrix_mdev->shadow_apcb.apm;
+	aqm = matrix_mdev->shadow_apcb.aqm;
+	num_queues = 0;
+
+	for_each_set_bit_inv(apid, apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
+			apqn = AP_MKQID(apid, apqi);
+			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
+			if (!q)
+				continue;
+
+			migf->ap_config->qinfo[num_queues].apqn = apqn;
+			data = q->hwinfo.value;
+			migf->ap_config->qinfo[num_queues].data = data;
+			num_queues += 1;
+			dev_dbg(matrix_mdev->vdev.dev,
+				"%s (%d): qinfo: apqn=%04lx data=%016lx\n",
+				__func__, __LINE__, apqn, data);
+		}
+	}
+}
+
+static struct vfio_ap_migration_file
+*vfio_ap_allocate_migf(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_file *migf;
+	struct vfio_ap_config *ap_config;
+	size_t config_size;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	migf = kzalloc_obj(struct vfio_ap_migration_file, GFP_KERNEL_ACCOUNT);
+	if (!migf)
+		return ERR_PTR(-ENOMEM);
+
+	ap_config = vfio_ap_allocate_config(matrix_mdev, &config_size);
+	if (IS_ERR(ap_config)) {
+		kfree(migf);
+		return ERR_CAST(ap_config);
+	}
+
+	migf->ap_config = ap_config;
+	migf->config_sz = config_size;
+	migf->matrix_mdev = matrix_mdev;
+
+	return migf;
+}
+
+static void vfio_ap_deallocate_migf(struct vfio_ap_migration_file *migf)
+{
+	kfree(migf->ap_config);
+	kfree(migf);
+}
+
+static struct file *vfio_ap_open_file_stream(struct vfio_ap_migration_file *migf,
+					     const struct file_operations *fops,
+					     int flags)
+{
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+
+	filp = anon_inode_getfile("vfio_ap_migf", fops, migf, flags);
+	if (IS_ERR(filp))
+		return ERR_CAST(filp);
+
+	stream_open(filp->f_inode, filp);
+
+	return filp;
+}
+
+static struct vfio_ap_migration_file *
+vfio_ap_save_mdev_state(struct ap_matrix_mdev *matrix_mdev)
+{
+	struct vfio_ap_migration_data *mig_data;
+	struct vfio_ap_migration_file *migf;
+	struct file *filp;
+
+	lockdep_assert_held(&matrix_dev->mdevs_lock);
+	mig_data = matrix_mdev->mig_data;
+
+	migf = vfio_ap_allocate_migf(matrix_mdev);
+	if (IS_ERR(migf))
+		return ERR_CAST(migf);
+
+	filp = vfio_ap_open_file_stream(migf, &vfio_ap_save_fops, O_RDONLY);
+	if (IS_ERR(filp)) {
+		vfio_ap_deallocate_migf(migf);
+		return ERR_CAST(filp);
+	}
+
+	migf->filp = filp;
+	mig_data->saving_migf = migf;
+	vfio_ap_store_queue_info(mig_data->saving_migf);
+
+	return mig_data->saving_migf;
+}
+
 static struct file *
 vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 			    enum vfio_device_mig_state new_state)
 {
 	struct vfio_ap_migration_data *mig_data;
 	enum vfio_device_mig_state cur_state;
+	struct vfio_ap_migration_file *migf;
 
 	lockdep_assert_held(&matrix_dev->mdevs_lock);
 	mig_data = matrix_mdev->mig_data;
@@ -109,10 +258,23 @@ vfio_ap_transition_to_state(struct ap_matrix_mdev *matrix_mdev,
 	dev_dbg(matrix_mdev->vdev.dev, "%s: %d -> %d\n", __func__, cur_state,
 		new_state);
 
+	/*
+	 * Begins the process of saving the vfio device state by creating and
+	 * returning a streaming data_fd to be used to read out the internal
+	 * state of the vfio-ap device on the source host.
+	 */
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
 	    new_state == VFIO_DEVICE_STATE_STOP_COPY) {
-		/* TODO */
-		return ERR_PTR(-EOPNOTSUPP);
+		migf = vfio_ap_save_mdev_state(matrix_mdev);
+		if (IS_ERR(migf))
+			return ERR_CAST(migf);
+
+		if (migf) {
+			get_file(migf->filp);
+			return migf->filp;
+		}
+
+		return NULL;
 	}
 
 	if (cur_state == VFIO_DEVICE_STATE_STOP &&
-- 
2.52.0


