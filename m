Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D2A436625
	for <lists+linux-s390@lfdr.de>; Thu, 21 Oct 2021 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbhJUP1B (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 21 Oct 2021 11:27:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232221AbhJUP0o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Oct 2021 11:26:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19LEOZxu021348;
        Thu, 21 Oct 2021 11:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=UK58jJkoMhdAgrXXtTr1/C7Y6We0PrFiCLEHqbyp5Do=;
 b=sNUg5UOvIlWgAxqUW7gjpAxrABByA/uBQJOe8SdXSMgVa+GMWxyID56M93b4XJ0/qtGt
 Hfr0oL8FVl8h6dhTeX1Jnck4SMz/1oRRa8ITETKAw77tNmk7Qa2vyRt6SzvbbnmRDICT
 85fqosCL6xz1+ZgCfl4JV6R9ev+NXJvJp3YKE17g93ztygvHuCMorPEp1EHzdSkvIKvO
 tufBn9yLtEk6RvMm8wQHCZ8k+pPT/FBHv2omOxofz/Jl2C58YllakXJ/lGrgpYp1WDdF
 n+8N1h5vf2E3gbohbsxlrIUv7jSwpWsDROZvxhelZmBEIRPzuRPWFZVobVHDRFb6jVyD Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu9xr1fb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 11:24:26 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19LEo5KR016964;
        Thu, 21 Oct 2021 11:24:26 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bu9xr1fas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 11:24:26 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19LF2Li3000334;
        Thu, 21 Oct 2021 15:24:25 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 3bqpcdr7by-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Oct 2021 15:24:25 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19LFONJI31326966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Oct 2021 15:24:23 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9253BE08A;
        Thu, 21 Oct 2021 15:24:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB6C7BE082;
        Thu, 21 Oct 2021 15:24:18 +0000 (GMT)
Received: from cpe-172-100-181-211.stny.res.rr.com.com (unknown [9.160.98.118])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 21 Oct 2021 15:24:18 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, freude@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v17 14/15] s390/ap: notify drivers on config changed and scan complete callbacks
Date:   Thu, 21 Oct 2021 11:23:31 -0400
Message-Id: <20211021152332.70455-15-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211021152332.70455-1-akrowiak@linux.ibm.com>
References: <20211021152332.70455-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2nUfUTr1uUETixJl29OQtZMm7VmFMflL
X-Proofpoint-ORIG-GUID: nerLRaDjDAYZ1IXkheo5WoyLR0EdUWUN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-21_04,2021-10-21_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110210079
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch introduces an extension to the ap bus to notify device drivers
when the host AP configuration changes - i.e., adapters, domains or
control domains are added or removed. When an adapter or domain is added to
the host's AP configuration, the AP bus will create the associated queue
devices in the linux sysfs device model. Each new type 10 (i.e., CEX4) or
newer queue device with an APQN that is not reserved for the default device
driver will get bound to the vfio_ap device driver. Likewise, whan an
adapter or domain is removed from the host's AP configuration, the AP bus
will remove the associated queue devices from the sysfs device model. Each
of the queues that is bound to the vfio_ap device driver will get unbound.

With the introduction of hot plug support, binding or unbinding of a
queue device will result in plugging or unplugging one or more queues from
a guest that is using the queue. If there are multiple changes to the
host's AP configuration, it could result in the probe and remove callbacks
getting invoked multiple times. Each time queues are plugged into or
unplugged from a guest, the guest's VCPUs must be taken out of SIE.
If this occurs multiple times due to changes in the host's AP
configuration, that can have an undesirable negative affect on the guest's
performance.

To alleviate this problem, this patch introduces two new callbacks: one to
notify the vfio_ap device driver when the AP bus scan routine detects a
change to the host's AP configuration; and, one to notify the driver when
the AP bus is done scanning. This will allow the vfio_ap driver to do
bulk processing of all affected adapters, domains and control domains for
affected guests rather than plugging or unplugging them one at a time when
the probe or remove callback is invoked. The two new callbacks are:

void (*on_config_changed)(struct ap_config_info *new_config_info,
                          struct ap_config_info *old_config_info);

This callback is invoked at the start of the AP bus scan
function when it determines that the host AP configuration information
has changed since the previous scan. This is done by storing
an old and current QCI info struct and comparing them. If there is any
difference, the callback is invoked.

The vfio_ap device driver registers a callback function for this callback
that performs the following operations:

1. Unplugs the adapters, domains and control domains removed from the
   host's AP configuration from the guests to which they are
   assigned in a single operation.

2. Disconnects the links between each queue structure representing a
   queue that was unplugged from the structure representing
   the mediated device to which the queue is assigned. Thus, when the
   vfio_ap device driver's remove callback is invoked, the unplugging of
   the queue from the guest and the unlinking of the queue structure from
   the mediated device structure will be bypassed because the queues and
   control domains will have already been unplugged in bulk.

3. Stores bitmaps identifying the adapters, domains and control domains
   added to the host's AP configuration with the structure representing
   the mediated device. When the vfio_ap device driver's probe callback is
   subsequently invoked, the probe function will recognize that the
   queue is being probed due to a change in the host's AP configuration
   and the plugging of the queue into the guest will be bypassed.

void (*on_scan_complete)(struct ap_config_info *new_config_info,
                         struct ap_config_info *old_config_info);

The on_scan_complete callback is invoked after the ap bus scan is
completed if the host AP configuration data has changed. The vfio_ap
device driver registers a callback function for this callback that hot
plugs each queue and control domain added to the AP configuration for each
guest using them in a single hot plug operation.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
[akrowiak@linux.ibm.com: implemented callback functions in vfio_ap driver]
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  81 ++++++-
 drivers/s390/crypto/ap_bus.h          |  12 +
 drivers/s390/crypto/vfio_ap_drv.c     |   4 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 332 ++++++++++++++++++++++++--
 drivers/s390/crypto/vfio_ap_private.h |  23 +-
 5 files changed, 429 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 15886610f61a..b97149d02da6 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -88,6 +88,7 @@ static atomic64_t ap_bindings_complete_count = ATOMIC64_INIT(0);
 static DECLARE_COMPLETION(ap_init_apqn_bindings_complete);
 
 static struct ap_config_info *ap_qci_info;
+static struct ap_config_info *ap_qci_info_old;
 
 /*
  * AP bus related debug feature things.
@@ -225,9 +226,14 @@ static void __init ap_init_qci_info(void)
 	ap_qci_info = kzalloc(sizeof(*ap_qci_info), GFP_KERNEL);
 	if (!ap_qci_info)
 		return;
+	ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old), GFP_KERNEL);
+	if (!ap_qci_info_old)
+		return;
 	if (ap_fetch_qci_info(ap_qci_info) != 0) {
 		kfree(ap_qci_info);
+		kfree(ap_qci_info_old);
 		ap_qci_info = NULL;
+		ap_qci_info_old = NULL;
 		return;
 	}
 	AP_DBF_INFO("%s successful fetched initial qci info\n", __func__);
@@ -244,6 +250,8 @@ static void __init ap_init_qci_info(void)
 				    __func__, ap_max_domain_id);
 		}
 	}
+
+	memcpy(ap_qci_info_old, ap_qci_info, sizeof(*ap_qci_info));
 }
 
 /*
@@ -1635,6 +1643,49 @@ static int __match_queue_device_with_queue_id(struct device *dev, const void *da
 		&& AP_QID_QUEUE(to_ap_queue(dev)->qid) == (int)(long) data;
 }
 
+/* Helper function for notify_config_changed */
+static int __drv_notify_config_changed(struct device_driver *drv, void *data)
+{
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+
+	if (try_module_get(drv->owner)) {
+		if (ap_drv->on_config_changed)
+			ap_drv->on_config_changed(ap_qci_info, ap_qci_info_old);
+		module_put(drv->owner);
+	}
+
+	return 0;
+}
+
+/* Notify all drivers about an qci config change */
+static inline void notify_config_changed(void)
+{
+	bus_for_each_drv(&ap_bus_type, NULL, NULL,
+			 __drv_notify_config_changed);
+}
+
+/* Helper function for notify_scan_complete */
+static int __drv_notify_scan_complete(struct device_driver *drv, void *data)
+{
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+
+	if (try_module_get(drv->owner)) {
+		if (ap_drv->on_scan_complete)
+			ap_drv->on_scan_complete(ap_qci_info,
+						 ap_qci_info_old);
+		module_put(drv->owner);
+	}
+
+	return 0;
+}
+
+/* Notify all drivers about bus scan complete */
+static inline void notify_scan_complete(void)
+{
+	bus_for_each_drv(&ap_bus_type, NULL, NULL,
+			 __drv_notify_scan_complete);
+}
+
 /*
  * Helper function for ap_scan_bus().
  * Remove card device and associated queue devices.
@@ -1923,6 +1974,25 @@ static inline void ap_scan_adapter(int ap)
 	put_device(&ac->ap_dev.device);
 }
 
+/**
+ * ap_get_configuration - get the host AP configuration
+ *
+ * Stores the host AP configuration information returned from the previous call
+ * to Query Configuration Information (QCI), then retrieves and stores the
+ * current AP configuration returned from QCI.
+ *
+ * Return: true if the host AP configuration changed between calls to QCI;
+ * otherwise, return false.
+ */
+static bool ap_get_configuration(void)
+{
+	memcpy(ap_qci_info_old, ap_qci_info, sizeof(*ap_qci_info));
+	ap_fetch_qci_info(ap_qci_info);
+
+	return memcmp(ap_qci_info, ap_qci_info_old,
+		      sizeof(struct ap_config_info)) != 0;
+}
+
 /**
  * ap_scan_bus(): Scan the AP bus for new devices
  * Runs periodically, workqueue timer (ap_config_time)
@@ -1930,9 +2000,12 @@ static inline void ap_scan_adapter(int ap)
  */
 static void ap_scan_bus(struct work_struct *unused)
 {
-	int ap;
+	int ap, config_changed = 0;
 
-	ap_fetch_qci_info(ap_qci_info);
+	/* config change notify */
+	config_changed = ap_get_configuration();
+	if (config_changed)
+		notify_config_changed();
 	ap_select_domain();
 
 	AP_DBF_DBG("%s running\n", __func__);
@@ -1941,6 +2014,10 @@ static void ap_scan_bus(struct work_struct *unused)
 	for (ap = 0; ap <= ap_max_adapter_id; ap++)
 		ap_scan_adapter(ap);
 
+	/* scan complete notify */
+	if (config_changed)
+		notify_scan_complete();
+
 	/* check if there is at least one queue available with default domain */
 	if (ap_domain_index >= 0) {
 		struct device *dev =
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 67c1bef60ad5..4de062ea6b76 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -143,6 +143,18 @@ struct ap_driver {
 	int (*probe)(struct ap_device *);
 	void (*remove)(struct ap_device *);
 	int (*in_use)(unsigned long *apm, unsigned long *aqm);
+	/*
+	 * Called at the start of the ap bus scan function when
+	 * the crypto config information (qci) has changed.
+	 */
+	void (*on_config_changed)(struct ap_config_info *new_config_info,
+				  struct ap_config_info *old_config_info);
+	/*
+	 * Called at the end of the ap bus scan function when
+	 * the crypto config information (qci) has changed.
+	 */
+	void (*on_scan_complete)(struct ap_config_info *new_config_info,
+				 struct ap_config_info *old_config_info);
 };
 
 #define to_ap_drv(x) container_of((x), struct ap_driver, driver)
diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
index df7528dcf6ed..5edd45d4d2fc 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -45,6 +45,8 @@ static struct ap_driver vfio_ap_drv = {
 	.probe = vfio_ap_mdev_probe_queue,
 	.remove = vfio_ap_mdev_remove_queue,
 	.in_use = vfio_ap_mdev_resource_in_use,
+	.on_config_changed = vfio_ap_on_cfg_changed,
+	.on_scan_complete = vfio_ap_on_scan_complete,
 	.ids = ap_queue_ids,
 };
 
@@ -92,7 +94,7 @@ static int vfio_ap_matrix_dev_create(void)
 
 	/* Fill in config info via PQAP(QCI), if available */
 	if (test_facility(12)) {
-		ret = ap_qci(&matrix_dev->info);
+		ret = ap_qci(&matrix_dev->config_info);
 		if (ret)
 			goto matrix_alloc_err;
 	}
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 8075080ef2dd..cedf491c0df4 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -330,7 +330,7 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
 
 	bitmap_copy(shadow_adm, matrix_mdev->shadow_apcb.adm, AP_DOMAINS);
 	bitmap_and(matrix_mdev->shadow_apcb.adm, matrix_mdev->matrix.adm,
-		   (unsigned long *)matrix_dev->info.adm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.adm, AP_DOMAINS);
 
 	return !bitmap_equal(shadow_adm, matrix_mdev->shadow_apcb.adm,
 			     AP_DOMAINS);
@@ -349,19 +349,15 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  */
 static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 {
-	int ret;
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(shadow_apm, AP_DEVICES);
 	DECLARE_BITMAP(shadow_aqm, AP_DOMAINS);
 	struct vfio_ap_queue *q;
 
-	ret = ap_qci(&matrix_dev->info);
-	if (ret)
-		return false;
-
 	bitmap_copy(shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	vfio_ap_matrix_init(&matrix_dev->config_info,
+			    &matrix_mdev->shadow_apcb);
 
 	/*
 	 * Copy the adapters, domains and control domains to the shadow_apcb
@@ -369,9 +365,9 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 	 * AP configuration.
 	 */
 	bitmap_and(matrix_mdev->shadow_apcb.apm, matrix_mdev->matrix.apm,
-		   (unsigned long *)matrix_dev->info.apm, AP_DEVICES);
+		   (unsigned long *)matrix_dev->config_info.apm, AP_DEVICES);
 	bitmap_and(matrix_mdev->shadow_apcb.aqm, matrix_mdev->matrix.aqm,
-		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.aqm, AP_DOMAINS);
 
 	for_each_set_bit_inv(apid, matrix_mdev->shadow_apcb.apm, AP_DEVICES) {
 		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
@@ -417,8 +413,9 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 			    &vfio_ap_matrix_dev_ops);
 
 	matrix_mdev->mdev = mdev;
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->matrix);
+	vfio_ap_matrix_init(&matrix_dev->config_info,
+			    &matrix_mdev->shadow_apcb);
 	hash_init(matrix_mdev->qtable.queues);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	mutex_lock(&matrix_dev->lock);
@@ -772,13 +769,17 @@ static void vfio_ap_unlink_apqn_fr_mdev(struct ap_matrix_mdev *matrix_mdev,
 
 	q = vfio_ap_mdev_get_queue(matrix_mdev, AP_MKQID(apid, apqi));
 	/* If the queue is assigned to the matrix mdev, unlink it. */
-	if (q)
+	if (q) {
 		vfio_ap_unlink_queue_fr_mdev(q);
 
-	/* If the queue is assigned to the APCB, store it in @qtable. */
-	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
-	    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-		hash_add(qtable->queues, &q->mdev_qnode, q->apqn);
+		/* If the queue is assigned to the APCB, store it in @qtable. */
+		if (qtable) {
+			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
+			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
+				hash_add(qtable->queues, &q->mdev_qnode,
+					 q->apqn);
+		}
+	}
 }
 
 /**
@@ -1702,9 +1703,31 @@ static void vfio_ap_mdev_put_qlocks(struct ap_guest *guest)
 		mutex_unlock(&guest->kvm->lock);
 
 	mutex_unlock(&matrix_dev->lock);
+
 	up_read(&matrix_dev->guests_lock);
 }
 
+static bool vfio_ap_mdev_do_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
+					  struct vfio_ap_queue *q)
+{
+	unsigned long apid = AP_QID_CARD(q->apqn);
+	unsigned long apqi = AP_QID_QUEUE(q->apqn);
+
+	/*
+	 * If the queue is being probed because its APID or APQI is in the
+	 * process of being added to the host's AP configuration, then we don't
+	 * want to filter the matrix now as the filtering will be done after
+	 * the driver is notified that the AP bus scan operation has completed
+	 * (see the vfio_ap_on_scan_complete callback function).
+	 */
+	if (test_bit_inv(apid, matrix_mdev->apm_add) ||
+	    test_bit_inv(apqi, matrix_mdev->aqm_add))
+		return false;
+
+
+	return true;
+}
+
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	struct vfio_ap_queue *q;
@@ -1722,8 +1745,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	if (guest) {
 		vfio_ap_mdev_link_queue(guest->matrix_mdev, q);
 
-		if (vfio_ap_mdev_filter_matrix(guest->matrix_mdev))
-			vfio_ap_mdev_hotplug_apcb(guest->matrix_mdev);
+		if (vfio_ap_mdev_do_filter_matrix(guest->matrix_mdev, q)) {
+			if (vfio_ap_mdev_filter_matrix(guest->matrix_mdev))
+				vfio_ap_mdev_hotplug_apcb(guest->matrix_mdev);
+		}
 	} else {
 		vfio_ap_queue_link_mdev(q);
 	}
@@ -1767,3 +1792,274 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	return ret;
 }
+
+/**
+ * vfio_ap_mdev_unlink_adapters - unlinks all queues from the matrix mdev with
+ *				  an APQI of a domain that has been removed from
+ *				  the host's AP configuration.
+ *
+ * @matrix_mdev: the matrix mdev from which the queues are to be unlinked
+ * @ap_unlink: a bitmap specifying the APIDs of the adapters removed from the
+ *	       host's AP configuration.
+ */
+static void vfio_ap_mdev_unlink_adapters(struct ap_matrix_mdev *matrix_mdev,
+					 unsigned long *ap_unlink)
+{
+	unsigned long apid;
+
+	for_each_set_bit_inv(apid, ap_unlink, AP_DEVICES)
+		vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, NULL);
+}
+
+/**
+ * vfio_ap_mdev_unlink_domains - unlinks all queues from the matrix mdev with an
+ *				 APQI of a domain that has been removed from the
+ *				 host's AP configuration.
+ *
+ * @matrix_mdev: the matrix mdev from which the queues are to be unlinked
+ * @aq_unlink: a bitmap specifying the APQIs of the domains removed from the
+ *	       host's AP configuration.
+ */
+static void vfio_ap_mdev_unlink_domains(struct ap_matrix_mdev *matrix_mdev,
+					unsigned long *aq_unlink)
+{
+	unsigned long apqi;
+
+	for_each_set_bit_inv(apqi, aq_unlink, AP_DOMAINS)
+		vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, NULL);
+}
+
+/**
+ * vfio_ap_mdev_hot_unplug_cfg - hot unplug the adapters, domains and control
+ *				 domains that have been removed from the host's
+ *				 AP configuration from a guest.
+ *
+ * @guest: the guest
+ * @aprem: the adapters that have been removed from the host's AP configuration
+ * @aqrem: the domains that have been removed from the host's AP configuration
+ */
+static void vfio_ap_mdev_hot_unplug_cfg(struct ap_guest *guest,
+					unsigned long *aprem,
+					unsigned long *aqrem)
+{
+	vfio_ap_mdev_unlink_adapters(guest->matrix_mdev, aprem);
+	vfio_ap_mdev_unlink_domains(guest->matrix_mdev, aqrem);
+
+	if (vfio_ap_mdev_filter_matrix(guest->matrix_mdev) ||
+	    vfio_ap_mdev_filter_cdoms(guest->matrix_mdev)) {
+		mutex_lock(&guest->kvm->lock);
+		mutex_lock(&matrix_dev->lock);
+
+		vfio_ap_mdev_hotplug_apcb(guest->matrix_mdev);
+
+		mutex_unlock(&guest->kvm->lock);
+		mutex_unlock(&matrix_dev->lock);
+	}
+}
+
+/**
+ * vfio_ap_mdev_cfg_remove - determines which guests are using the adapters,
+ *			     domains and control domains that have been removed
+ *			     from the host AP configuration and unplugs them
+ *			     from those guests.
+ *
+ * @ap_remove:	bitmap specifying which adapters have been removed from the host
+ *		config.
+ * @aq_remove:	bitmap specifying which domains have been removed from the host
+ *		config.
+ * @cd_remove:	bitmap specifying which control domains have been removed from
+ *		the host config.
+ */
+static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
+				    unsigned long *aq_remove,
+				    unsigned long *cd_remove)
+{
+	struct ap_guest *guest;
+	DECLARE_BITMAP(aprem, AP_DEVICES);
+	DECLARE_BITMAP(aqrem, AP_DOMAINS);
+	int do_ap_remove, do_aq_remove, do_cd_remove;
+
+	list_for_each_entry(guest, &matrix_dev->guests, node) {
+		do_ap_remove = bitmap_and(aprem, ap_remove,
+					  guest->matrix_mdev->matrix.apm,
+					  AP_DEVICES);
+		do_aq_remove = bitmap_and(aqrem, aq_remove,
+					  guest->matrix_mdev->matrix.aqm,
+					  AP_DOMAINS);
+		do_cd_remove = bitmap_and(aqrem, cd_remove,
+					  guest->matrix_mdev->matrix.aqm,
+					  AP_DOMAINS);
+
+		if (!do_ap_remove && !do_aq_remove && !do_cd_remove)
+			continue;
+
+		vfio_ap_mdev_hot_unplug_cfg(guest, aprem, aqrem);
+	}
+}
+
+/**
+ * vfio_ap_mdev_on_cfg_remove - responds to the removal of adapters, domains and
+ *				control domains from the host AP configuration
+ *				by unplugging them from the guests that are
+ *				using them.
+ */
+static void vfio_ap_mdev_on_cfg_remove(void)
+{
+	int ap_remove, aq_remove, cd_remove;
+	DECLARE_BITMAP(aprem, AP_DEVICES);
+	DECLARE_BITMAP(aqrem, AP_DOMAINS);
+	DECLARE_BITMAP(cdrem, AP_DOMAINS);
+	unsigned long *cur_apm, *cur_aqm, *cur_adm;
+	unsigned long *prev_apm, *prev_aqm, *prev_adm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	cur_adm = (unsigned long *)matrix_dev->config_info.adm;
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+	prev_adm = (unsigned long *)matrix_dev->config_info_prev.adm;
+
+	ap_remove = bitmap_andnot(aprem, prev_apm, cur_apm, AP_DEVICES);
+	aq_remove = bitmap_andnot(aqrem, prev_aqm, cur_aqm, AP_DOMAINS);
+	cd_remove = bitmap_andnot(cdrem, prev_adm, cur_adm, AP_DOMAINS);
+
+	if (ap_remove || aq_remove || cd_remove)
+		vfio_ap_mdev_cfg_remove(aprem, aqrem, cdrem);
+}
+
+/**
+ * vfio_ap_mdev_cfg_add - store bitmaps specifying the adapters, domains and
+ *			  control domains that have been added to the host's
+ *			  AP configuration for each matrix mdev to which they
+ *			  are assigned.
+ *
+ * @apm_add: a bitmap specifying the adapters that have been added to the AP
+ *	     configuration.
+ * @aqm_add: a bitmap specifying the domains that have been added to the AP
+ *	     configuration.
+ * @adm_add: a bitmap specifying the control domains that have been added to the
+ *	     AP configuration.
+ */
+static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
+				 unsigned long *adm_add)
+{
+	struct ap_guest *guest;
+
+	list_for_each_entry(guest, &matrix_dev->guests, node) {
+		bitmap_and(guest->matrix_mdev->apm_add,
+			   guest->matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
+		bitmap_and(guest->matrix_mdev->aqm_add,
+			   guest->matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
+		bitmap_and(guest->matrix_mdev->adm_add,
+			   guest->matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
+	}
+}
+
+/**
+ * vfio_ap_mdev_on_cfg_add - responds to the addition of adapters, domains and
+ *			     control domains to the host AP configuration
+ *			     by updating the bitmaps that specify what adapters,
+ *			     domains and control domains have been added so they
+ *			     can be hot plugged into the guest when the AP bus
+ *			     scan completes (see vfio_ap_on_scan_complete
+ *			     function).
+ */
+static void vfio_ap_mdev_on_cfg_add(void)
+{
+	bool do_add;
+	DECLARE_BITMAP(apm_add, AP_DEVICES);
+	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
+	DECLARE_BITMAP(adm_add, AP_DOMAINS);
+	unsigned long *cur_apm, *cur_aqm, *cur_adm;
+	unsigned long *prev_apm, *prev_aqm, *prev_adm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	cur_adm = (unsigned long *)matrix_dev->config_info.adm;
+
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+	prev_adm = (unsigned long *)matrix_dev->config_info_prev.adm;
+
+	do_add = bitmap_andnot(apm_add, cur_apm, prev_apm, AP_DEVICES);
+	do_add |= bitmap_andnot(aqm_add, cur_aqm, prev_aqm, AP_DOMAINS);
+	do_add |= bitmap_andnot(adm_add, cur_adm, prev_adm, AP_DOMAINS);
+
+	if (do_add)
+		vfio_ap_mdev_cfg_add(apm_add, aqm_add, adm_add);
+}
+
+/**
+ * vfio_ap_on_cfg_changed - handles notification of changes to the host AP
+ *			    configuration.
+ *
+ * @new_config_info: the new host AP configuration
+ * @old_config_info: the previous host AP configuration
+ */
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info)
+{
+	down_read(&matrix_dev->guests_lock);
+
+	memcpy(&matrix_dev->config_info_prev, old_config_info,
+		       sizeof(struct ap_config_info));
+	memcpy(&matrix_dev->config_info, new_config_info,
+	       sizeof(struct ap_config_info));
+	vfio_ap_mdev_on_cfg_remove();
+	vfio_ap_mdev_on_cfg_add();
+
+	up_read(&matrix_dev->guests_lock);
+}
+
+static void vfio_ap_mdev_hot_plug_cfg(struct ap_guest *guest)
+{
+	bool filter_matrix, filter_cdoms, do_hotplug = false;
+
+	filter_matrix = bitmap_intersects(guest->matrix_mdev->matrix.apm,
+					  guest->matrix_mdev->apm_add,
+					  AP_DEVICES) ||
+			bitmap_intersects(guest->matrix_mdev->matrix.aqm,
+					  guest->matrix_mdev->aqm_add,
+					  AP_DOMAINS);
+
+	filter_cdoms = bitmap_intersects(guest->matrix_mdev->matrix.adm,
+					 guest->matrix_mdev->aqm_add,
+					 AP_DOMAINS);
+
+	mutex_lock(&guest->kvm->lock);
+	mutex_lock(&matrix_dev->lock);
+
+	if (filter_matrix)
+		do_hotplug |= vfio_ap_mdev_filter_matrix(guest->matrix_mdev);
+
+	if (filter_cdoms)
+		do_hotplug |= vfio_ap_mdev_filter_cdoms(guest->matrix_mdev);
+
+	if (do_hotplug)
+		vfio_ap_mdev_hotplug_apcb(guest->matrix_mdev);
+
+	mutex_unlock(&matrix_dev->lock);
+	mutex_unlock(&guest->kvm->lock);
+}
+
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info)
+{
+	struct ap_guest *guest;
+
+	down_read(&matrix_dev->guests_lock);
+
+	list_for_each_entry(guest, &matrix_dev->guests, node) {
+		if (bitmap_empty(guest->matrix_mdev->apm_add, AP_DEVICES) &&
+		    bitmap_empty(guest->matrix_mdev->aqm_add, AP_DOMAINS) &&
+		    bitmap_empty(guest->matrix_mdev->adm_add, AP_DOMAINS))
+			continue;
+
+		vfio_ap_mdev_hot_plug_cfg(guest);
+		bitmap_clear(guest->matrix_mdev->apm_add, 0, AP_DEVICES);
+		bitmap_clear(guest->matrix_mdev->aqm_add, 0, AP_DOMAINS);
+		bitmap_clear(guest->matrix_mdev->adm_add, 0, AP_DOMAINS);
+	}
+
+	up_read(&matrix_dev->guests_lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 97da41f87c65..affa63da7f88 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -37,7 +37,9 @@ struct ap_guest {
  *
  * @device:	generic device structure associated with the AP matrix device
  * @available_instances: number of mediated matrix devices that can be created
- * @info:	the struct containing the output from the PQAP(QCI) instruction
+ * @config_info: the struct containing the output from the PQAP(QCI) instruction
+ * @config_info_prev: the struct containing the previous output from the
+ *		      PQAP(AQIC) instruction
  * @mdev_list:	the list of mediated matrix devices created
  * @lock:	mutex for locking the AP matrix device. This lock will be
  *		taken every time we fiddle with state managed by the vfio_ap
@@ -52,7 +54,8 @@ struct ap_guest {
 struct ap_matrix_dev {
 	struct device device;
 	atomic_t available_instances;
-	struct ap_config_info info;
+	struct ap_config_info config_info;
+	struct ap_config_info config_info_prev;
 	struct list_head mdev_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
@@ -110,6 +113,13 @@ struct ap_queue_table {
  * @mdev:	the mediated device
  * @qtable:	table of queues (struct vfio_ap_queue) assigned to the mdev
  * @guest:	the KVM guest using the matrix mdev
+ * @apm_add:	adapters to be hot plugged into the guest when the vfio_ap
+ *		device driver is notified that the AP bus scan has completed.
+ * @aqm_add:	domains to be hot plugged into the guest when the vfio_ap
+ *		device driver is notified that the AP bus scan has completed.
+ * @adm_add:	control domains to be hot plugged into the guest when the
+ *		vfio_ap device driver is notified that the AP bus scan has
+ *		completed.
  */
 struct ap_matrix_mdev {
 	struct vfio_device vdev;
@@ -121,6 +131,9 @@ struct ap_matrix_mdev {
 	struct mdev_device *mdev;
 	struct ap_queue_table qtable;
 	struct ap_guest *guest;
+	DECLARE_BITMAP(apm_add, AP_DEVICES);
+	DECLARE_BITMAP(aqm_add, AP_DOMAINS);
+	DECLARE_BITMAP(adm_add, AP_DOMAINS);
 };
 
 /**
@@ -151,4 +164,10 @@ void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 
 int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
 
+
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info);
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.31.1

