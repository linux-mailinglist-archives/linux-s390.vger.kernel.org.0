Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3375B3557FE
	for <lists+linux-s390@lfdr.de>; Tue,  6 Apr 2021 17:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345707AbhDFPcY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 6 Apr 2021 11:32:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345798AbhDFPcK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Apr 2021 11:32:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136FU31Z022824;
        Tue, 6 Apr 2021 11:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VYzRwafwAWPeNoGYtgY+K2uTrycffqn5jevuN+4pIko=;
 b=pLncsV5PrdoRFMRBMoGslOZJvRBjnL1Lz8Fp5slEd1PPo1bsf01vNaKcPDH0wPMmadH9
 1l9+KLZyJXs9FOVIIutIMsT5LPJlRZaMsKG83fQx2eAKvMlLhuIFMANq3F5hTVSjmoeL
 6LfNHOl70nck5BOoXnN+wb2n7aOsNF6NOB0uyLjuwBGlBDycF0DpqB62RGnptnGn2EzD
 N8FrRIzBPHSLTRvgjRAxGaaaG5kQeR3PGK4nZKBRaI3w+iJYKRl4ZDNHa5UfCPKTS8xH
 vAHnMSLWT/389GI7U/ZtDex0c/AvRPXtBAhzGu+RG1fA9zd+XqcMcCra0cxBx2shjxLY Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5c074g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 11:31:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136FU5YJ023312;
        Tue, 6 Apr 2021 11:31:59 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5c074f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 11:31:58 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136FNie9017719;
        Tue, 6 Apr 2021 15:31:57 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 37q2yhrp3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 15:31:57 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136FVrio23265732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 15:31:53 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD85BE054;
        Tue,  6 Apr 2021 15:31:53 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D7B2BE053;
        Tue,  6 Apr 2021 15:31:52 +0000 (GMT)
Received: from cpe-172-100-182-241.stny.res.rr.com.com (unknown [9.85.175.110])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  6 Apr 2021 15:31:51 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     jjherne@linux.ibm.com, freude@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com,
        pasic@linux.ibm.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: [PATCH v15 12/13] s390/zcrypt: notify drivers on config changed and scan complete callbacks
Date:   Tue,  6 Apr 2021 11:31:21 -0400
Message-Id: <20210406153122.22874-13-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20210406153122.22874-1-akrowiak@linux.ibm.com>
References: <20210406153122.22874-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -Qznp7zwhhVgWdr7xEgRYeaUFrNLd4ov
X-Proofpoint-ORIG-GUID: QiNYLh7ItaQ8WX2jw5klxdAhasuR2HLt
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_04:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060104
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch intruduces an extension to the ap bus to notify device drivers
when the host AP configuration changes - i.e., adapters, domains or
control domains are added or removed. To that end, two new callbacks are
introduced for AP device drivers:

  void (*on_config_changed)(struct ap_config_info *new_config_info,
                            struct ap_config_info *old_config_info);

     This callback is invoked at the start of the AP bus scan
     function when it determines that the host AP configuration information
     has changed since the previous scan. This is done by storing
     an old and current QCI info struct and comparing them. If there is any
     difference, the callback is invoked.

     Note that when the AP bus scan detects that AP adapters, domains or
     control domains have been removed from the host's AP configuration, it
     will remove the associated devices from the AP bus subsystem's device
     model. This callback gives the device driver a chance to respond to
     the removal of the AP devices from the host configuration prior to
     calling the device driver's remove callback. The primary purpose of
     this callback is to allow the vfio_ap driver to do a bulk unplug of
     all affected adapters, domains and control domains from affected
     guests rather than unplugging them one at a time when the remove
     callback is invoked.

  void (*on_scan_complete)(struct ap_config_info *new_config_info,
                           struct ap_config_info *old_config_info);

     The on_scan_complete callback is invoked after the ap bus scan is
     complete if the host AP configuration data has changed.

     Note that when the AP bus scan detects that adapters, domains or
     control domains have been added to the host's configuration, it will
     create new devices in the AP bus subsystem's device model. The primary
     purpose of this callback is to allow the vfio_ap driver to do a bulk
     plug of all affected adapters, domains and control domains into
     affected guests rather than plugging them one at a time when the
     probe callback is invoked.

Please note that changes to the apmask and aqmask do not trigger
these two callbacks since the bus scan function is not invoked by changes
to those masks.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  89 ++++++++++-
 drivers/s390/crypto/ap_bus.h          |  12 ++
 drivers/s390/crypto/vfio_ap_drv.c     |   4 +-
 drivers/s390/crypto/vfio_ap_ops.c     | 215 +++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h |  15 +-
 5 files changed, 306 insertions(+), 29 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index b7653cec81ac..ccc87fb84c6d 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -82,6 +82,7 @@ static atomic64_t ap_scan_bus_count;
 static DECLARE_COMPLETION(ap_init_apqn_bindings_complete);
 
 static struct ap_config_info *ap_qci_info;
+static struct ap_config_info *ap_qci_info_old;
 
 /*
  * AP bus related debug feature things.
@@ -1579,6 +1580,50 @@ static int __match_queue_device_with_queue_id(struct device *dev, const void *da
 		&& AP_QID_QUEUE(to_ap_queue(dev)->qid) == (int)(long) data;
 }
 
+/* Helper function for notify_config_changed */
+static int __drv_notify_config_changed(struct device_driver *drv, void *data)
+{
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+
+	if (try_module_get(drv->owner)) {
+		if (ap_drv->on_config_changed)
+			ap_drv->on_config_changed(ap_qci_info,
+						  ap_qci_info_old);
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
@@ -1857,15 +1902,51 @@ static inline void ap_scan_adapter(int ap)
 	put_device(&ac->ap_dev.device);
 }
 
+/*
+ * ap_get_configuration
+ *
+ * Stores the host AP configuration information returned from the previous call
+ * to Query Configuration Information (QCI), then retrieves and stores the
+ * current AP configuration returned from QCI.
+ *
+ * Returns true if the host AP configuration changed between calls to QCI;
+ * otherwise, returns false.
+ */
+static bool ap_get_configuration(void)
+{
+	bool cfg_chg = false;
+
+	if (ap_qci_info) {
+		if (!ap_qci_info_old) {
+			ap_qci_info_old = kzalloc(sizeof(*ap_qci_info_old),
+						  GFP_KERNEL);
+			if (!ap_qci_info_old)
+				return false;
+		} else {
+			memcpy(ap_qci_info_old, ap_qci_info,
+			       sizeof(struct ap_config_info));
+		}
+		ap_fetch_qci_info(ap_qci_info);
+		cfg_chg = memcmp(ap_qci_info,
+				 ap_qci_info_old,
+				 sizeof(struct ap_config_info)) != 0;
+	}
+
+	return cfg_chg;
+}
+
 /**
  * ap_scan_bus(): Scan the AP bus for new devices
  * Runs periodically, workqueue timer (ap_config_time)
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
@@ -1874,6 +1955,10 @@ static void ap_scan_bus(struct work_struct *unused)
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
index 95c9da072f81..e91082bd159c 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -146,6 +146,18 @@ struct ap_driver {
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
index 8934471b7944..075495fc44c0 100644
--- a/drivers/s390/crypto/vfio_ap_drv.c
+++ b/drivers/s390/crypto/vfio_ap_drv.c
@@ -87,7 +87,7 @@ static int vfio_ap_matrix_dev_create(void)
 
 	/* Fill in config info via PQAP(QCI), if available */
 	if (test_facility(12)) {
-		ret = ap_qci(&matrix_dev->info);
+		ret = ap_qci(&matrix_dev->config_info);
 		if (ret)
 			goto matrix_alloc_err;
 	}
@@ -148,6 +148,8 @@ static int __init vfio_ap_init(void)
 	vfio_ap_drv.probe = vfio_ap_mdev_probe_queue;
 	vfio_ap_drv.remove = vfio_ap_mdev_remove_queue;
 	vfio_ap_drv.in_use = vfio_ap_mdev_resource_in_use;
+	vfio_ap_drv.on_config_changed = vfio_ap_on_cfg_changed;
+	vfio_ap_drv.on_scan_complete = vfio_ap_on_scan_complete;
 	vfio_ap_drv.ids = ap_queue_ids;
 
 	ret = ap_driver_register(&vfio_ap_drv, THIS_MODULE, VFIO_AP_DRV_NAME);
diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 618d9e37e82b..664d54b05509 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -335,24 +335,14 @@ static void vfio_ap_mdev_commit_apcb(struct ap_matrix_mdev *matrix_mdev)
 static void vfio_ap_mdev_filter_apcb(struct ap_matrix_mdev *matrix_mdev,
 				     struct ap_matrix *shadow_apcb)
 {
-	int ret;
 	unsigned long apid, apqi, apqn;
 
-	ret = ap_qci(&matrix_dev->info);
-	if (ret)
-		return;
-
-	/*
-	 * Copy the adapters, domains and control domains to the shadow_apcb
-	 * from the matrix mdev, but only those that are assigned to the host's
-	 * AP configuration.
-	 */
 	bitmap_and(shadow_apcb->apm, matrix_mdev->matrix.apm,
-		   (unsigned long *)matrix_dev->info.apm, AP_DEVICES);
+		   (unsigned long *)matrix_dev->config_info.apm, AP_DEVICES);
 	bitmap_and(shadow_apcb->aqm, matrix_mdev->matrix.aqm,
-		   (unsigned long *)matrix_dev->info.aqm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.aqm, AP_DOMAINS);
 	bitmap_and(shadow_apcb->adm, matrix_mdev->matrix.adm,
-		   (unsigned long *)matrix_dev->info.adm, AP_DOMAINS);
+		   (unsigned long *)matrix_dev->config_info.adm, AP_DOMAINS);
 
 	for_each_set_bit_inv(apid, shadow_apcb->apm, AP_DEVICES) {
 		for_each_set_bit_inv(apqi, shadow_apcb->aqm, AP_DOMAINS) {
@@ -385,7 +375,7 @@ static void vfio_ap_mdev_refresh_apcb(struct ap_matrix_mdev *matrix_mdev)
 {
 	struct ap_matrix shadow_apcb;
 
-	vfio_ap_matrix_init(&matrix_dev->info, &shadow_apcb);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &shadow_apcb);
 	vfio_ap_mdev_filter_apcb(matrix_mdev, &shadow_apcb);
 
 	if (memcmp(&shadow_apcb, &matrix_mdev->shadow_apcb,
@@ -410,9 +400,9 @@ static int vfio_ap_mdev_create(struct kobject *kobj, struct mdev_device *mdev)
 	}
 
 	matrix_mdev->mdev = mdev;
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->matrix);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->matrix);
 	init_waitqueue_head(&matrix_mdev->wait_for_kvm);
-	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	vfio_ap_matrix_init(&matrix_dev->config_info, &matrix_mdev->shadow_apcb);
 	hash_init(matrix_mdev->qtable);
 	mdev_set_drvdata(mdev, matrix_mdev);
 	matrix_mdev->pqap_hook.hook = handle_pqap;
@@ -952,7 +942,8 @@ static void vfio_ap_mdev_hot_plug_cdom(struct ap_matrix_mdev *matrix_mdev,
 				       unsigned long domid)
 {
 	if (!test_bit_inv(domid, matrix_mdev->shadow_apcb.adm) &&
-	    test_bit_inv(domid, (unsigned long *)matrix_dev->info.adm)) {
+	    test_bit_inv(domid,
+			 (unsigned long *)matrix_dev->config_info.adm)) {
 		set_bit_inv(domid, matrix_mdev->shadow_apcb.adm);
 		vfio_ap_mdev_commit_apcb(matrix_mdev);
 	}
@@ -1596,15 +1587,27 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	vfio_ap_queue_link_mdev(q);
 	if (q->matrix_mdev) {
 		/*
-		 * If the KVM pointer is in the process of being set, wait until the
-		 * process has completed.
+		 * If we are in the process of adding adapters and/or domains
+		 * due to a change to the host's AP configuration, it is more
+		 * efficient to refresh the guest's APCB in a single operation
+		 * after the AP bus scan is complete (see the
+		 * vfio_ap_on_scan_complete function) rather than to do the
+		 * refresh for each queue added, so if that is not the case,
+		 * let's go ahead and refresh the guest's APCB here.
 		 */
-		wait_event_cmd(q->matrix_mdev->wait_for_kvm,
-			       !q->matrix_mdev->kvm_busy,
-			       mutex_unlock(&matrix_dev->lock),
-			       mutex_lock(&matrix_dev->lock));
+		if (bitmap_empty(matrix_dev->ap_add, AP_DEVICES) &&
+		    bitmap_empty(matrix_dev->aq_add, AP_DOMAINS)) {
+			/*
+			 * If the KVM pointer is in the process of being set, wait until the
+			 * process has completed.
+			 */
+			wait_event_cmd(q->matrix_mdev->wait_for_kvm,
+				       !q->matrix_mdev->kvm_busy,
+				       mutex_unlock(&matrix_dev->lock),
+				       mutex_lock(&matrix_dev->lock));
 
-		vfio_ap_mdev_refresh_apcb(q->matrix_mdev);
+			vfio_ap_mdev_refresh_apcb(q->matrix_mdev);
+		}
 	}
 	dev_set_drvdata(&apdev->device, q);
 	mutex_unlock(&matrix_dev->lock);
@@ -1646,8 +1649,172 @@ int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
 
 	if (!mutex_trylock(&matrix_dev->lock))
 		return -EBUSY;
+
 	ret = vfio_ap_mdev_verify_no_sharing(apm, aqm);
 	mutex_unlock(&matrix_dev->lock);
 
 	return ret;
 }
+
+/*
+ * vfio_ap_mdev_unlink_apids
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apid_rem: The bitmap specifying the APIDs of the adapters removed from
+ *	      the host's AP configuration
+ *
+ * Unlinks @matrix_mdev from each queue assigned to @matrix_mdev whose APQN
+ * contains an APID specified in @apid_rem.
+ *
+ * Returns true if one or more AP queue devices were unlinked; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unlink_apids(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apid_rem)
+{
+	int bkt, apid;
+	bool q_unlinked = false;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apid = AP_QID_CARD(q->apqn);
+		if (test_bit_inv(apid, apid_rem)) {
+			vfio_ap_mdev_reset_queue(q, 1);
+			vfio_ap_mdev_unlink_queue(q);
+			q_unlinked = true;
+		}
+	}
+
+	return q_unlinked;
+}
+
+/*
+ * vfio_ap_mdev_unlink_apqis
+ *
+ * @matrix_mdev: The matrix mediated device
+ *
+ * @apqi_rem: The bitmap specifying the APQIs of the domains removed from
+ *	      the host's AP configuration
+ *
+ * Unlinks @matrix_mdev from each queue assigned to @matrix_mdev whose APQN
+ * contains an APQI specified in @apqi_rem.
+ *
+ * Returns true if one or more AP queue devices were unlinked; otherwise,
+ * returns false.
+ */
+static bool vfio_ap_mdev_unlink_apqis(struct ap_matrix_mdev *matrix_mdev,
+				      unsigned long *apqi_rem)
+{
+	int bkt, apqi;
+	bool q_unlinked = false;
+	struct vfio_ap_queue *q;
+
+	hash_for_each(matrix_mdev->qtable, bkt, q, mdev_qnode) {
+		apqi = AP_QID_QUEUE(q->apqn);
+		if (test_bit_inv(apqi, apqi_rem)) {
+			vfio_ap_mdev_reset_queue(q, 1);
+			vfio_ap_mdev_unlink_queue(q);
+			q_unlinked = true;
+		}
+	}
+
+	return q_unlinked;
+}
+
+static void vfio_ap_mdev_on_cfg_remove(void)
+{
+	bool refresh_apcb = false;
+	int ap_remove, aq_remove;
+	struct ap_matrix_mdev *matrix_mdev;
+	DECLARE_BITMAP(aprem, AP_DEVICES);
+	DECLARE_BITMAP(aqrem, AP_DOMAINS);
+	unsigned long *cur_apm, *cur_aqm, *prev_apm, *prev_aqm;
+
+	cur_apm = (unsigned long *)matrix_dev->config_info.apm;
+	cur_aqm = (unsigned long *)matrix_dev->config_info.aqm;
+	prev_apm = (unsigned long *)matrix_dev->config_info_prev.apm;
+	prev_aqm = (unsigned long *)matrix_dev->config_info_prev.aqm;
+
+	ap_remove = bitmap_andnot(aprem, prev_apm, cur_apm, AP_DEVICES);
+	aq_remove = bitmap_andnot(aqrem, prev_aqm, cur_aqm, AP_DOMAINS);
+
+	if (!ap_remove && !aq_remove)
+		return;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (ap_remove)
+			refresh_apcb = vfio_ap_mdev_unlink_apids(matrix_mdev,
+								 aprem);
+
+		if (aq_remove)
+			refresh_apcb = vfio_ap_mdev_unlink_apqis(matrix_mdev,
+								 aqrem);
+
+		if (refresh_apcb)
+			vfio_ap_mdev_refresh_apcb(matrix_mdev);
+	}
+}
+
+static void vfio_ap_mdev_on_cfg_add(void)
+{
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
+	bitmap_andnot(matrix_dev->ap_add, cur_apm, prev_apm, AP_DEVICES);
+	bitmap_andnot(matrix_dev->aq_add, cur_aqm, prev_aqm, AP_DOMAINS);
+	bitmap_andnot(matrix_dev->ad_add, cur_adm, prev_adm, AP_DOMAINS);
+}
+
+void vfio_ap_init_mdev_matrixes(struct ap_config_info *config_info)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		vfio_ap_matrix_init(config_info, &matrix_mdev->matrix);
+		vfio_ap_matrix_init(config_info, &matrix_mdev->shadow_apcb);
+	}
+}
+
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info)
+{
+	mutex_lock(&matrix_dev->lock);
+	memcpy(&matrix_dev->config_info, new_config_info,
+	       sizeof(struct ap_config_info));
+	memcpy(&matrix_dev->config_info_prev, old_config_info,
+	       sizeof(struct ap_config_info));
+	vfio_ap_init_mdev_matrixes(new_config_info);
+	vfio_ap_mdev_on_cfg_remove();
+	vfio_ap_mdev_on_cfg_add();
+	mutex_unlock(&matrix_dev->lock);
+}
+
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info)
+{
+	struct ap_matrix_mdev *matrix_mdev;
+
+	mutex_lock(&matrix_dev->lock);
+	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		if (bitmap_intersects(matrix_mdev->matrix.apm,
+				      matrix_dev->ap_add, AP_DEVICES) ||
+		    bitmap_intersects(matrix_mdev->matrix.aqm,
+				      matrix_dev->aq_add, AP_DOMAINS) ||
+		    bitmap_intersects(matrix_mdev->matrix.adm,
+				      matrix_dev->ad_add, AP_DOMAINS))
+			vfio_ap_mdev_refresh_apcb(matrix_mdev);
+	}
+
+	bitmap_clear(matrix_dev->ap_add, 0, AP_DEVICES);
+	bitmap_clear(matrix_dev->aq_add, 0, AP_DOMAINS);
+	mutex_unlock(&matrix_dev->lock);
+}
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 601012751a4a..a1e0ee395e95 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -29,7 +29,9 @@
  * ap_matrix_dev - the AP matrix device structure
  * @device:	generic device structure associated with the AP matrix device
  * @available_instances: number of mediated matrix devices that can be created
- * @info:	the struct containing the output from the PQAP(QCI) instruction
+ * @config_info: the current host AP configuration information
+ * @config_info_prev: the host AP configuration information from the previous
+ *		      configuration changed notification
  * mdev_list:	the list of mediated matrix devices created
  * lock:	mutex for locking the AP matrix device. This lock will be
  *		taken every time we fiddle with state managed by the vfio_ap
@@ -40,10 +42,14 @@
 struct ap_matrix_dev {
 	struct device device;
 	atomic_t available_instances;
-	struct ap_config_info info;
+	struct ap_config_info config_info;
+	struct ap_config_info config_info_prev;
 	struct list_head mdev_list;
 	struct mutex lock;
 	struct ap_driver  *vfio_ap_drv;
+	DECLARE_BITMAP(ap_add, AP_DEVICES);
+	DECLARE_BITMAP(aq_add, AP_DOMAINS);
+	DECLARE_BITMAP(ad_add, AP_DOMAINS);
 };
 
 extern struct ap_matrix_dev *matrix_dev;
@@ -111,4 +117,9 @@ void vfio_ap_mdev_remove_queue(struct ap_device *queue);
 
 int vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm);
 
+void vfio_ap_on_cfg_changed(struct ap_config_info *new_config_info,
+			    struct ap_config_info *old_config_info);
+void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
+			      struct ap_config_info *old_config_info);
+
 #endif /* _VFIO_AP_PRIVATE_H_ */
-- 
2.21.3

