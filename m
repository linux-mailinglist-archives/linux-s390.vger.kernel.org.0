Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5862262E2
	for <lists+linux-s390@lfdr.de>; Mon, 20 Jul 2020 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgGTPEu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Jul 2020 11:04:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729016AbgGTPEu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 20 Jul 2020 11:04:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KF4NT1171804;
        Mon, 20 Jul 2020 11:04:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d2m3aru0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:04:40 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KF4WWt172323;
        Mon, 20 Jul 2020 11:04:32 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d2m3arf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:04:31 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KEk4kR006440;
        Mon, 20 Jul 2020 15:04:00 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 32d5dpm8s3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 15:04:00 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KF3v9Q60555768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 15:03:57 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B76A6E052;
        Mon, 20 Jul 2020 15:03:57 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7B3B6E050;
        Mon, 20 Jul 2020 15:03:55 +0000 (GMT)
Received: from cpe-172-100-175-116.stny.res.rr.com.com (unknown [9.85.188.6])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 15:03:55 +0000 (GMT)
From:   Tony Krowiak <akrowiak@linux.ibm.com>
To:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        fiuczy@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v9 04/15] s390/zcrypt: driver callback to indicate resource in use
Date:   Mon, 20 Jul 2020 11:03:33 -0400
Message-Id: <20200720150344.24488-5-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200720150344.24488-1-akrowiak@linux.ibm.com>
References: <20200720150344.24488-1-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 suspectscore=3 phishscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200104
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Introduces a new driver callback to prevent a root user from unbinding
an AP queue from its device driver if the queue is in use. The intent of
this callback is to provide a driver with the means to prevent a root user
from inadvertently taking a queue away from a matrix mdev and giving it to
the host while it is assigned to the matrix mdev. The callback will
be invoked whenever a change to the AP bus's sysfs apmask or aqmask
attributes would result in one or more AP queues being removed from its
driver. If the callback responds in the affirmative for any driver
queried, the change to the apmask or aqmask will be rejected with a device
in use error.

For this patch, only non-default drivers will be queried. Currently,
there is only one non-default driver, the vfio_ap device driver. The
vfio_ap device driver facilitates pass-through of an AP queue to a
guest. The idea here is that a guest may be administered by a different
sysadmin than the host and we don't want AP resources to unexpectedly
disappear from a guest's AP configuration (i.e., adapters, domains and
control domains assigned to the matrix mdev). This will enforce the proper
procedure for removing AP resources intended for guest usage which is to
first unassign them from the matrix mdev, then unbind them from the
vfio_ap device driver.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/s390/crypto/ap_bus.c | 148 ++++++++++++++++++++++++++++++++---
 drivers/s390/crypto/ap_bus.h |   4 +
 2 files changed, 142 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index e71ca4a719a5..d6a732c8d90a 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -35,6 +35,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/debugfs.h>
 #include <linux/ctype.h>
+#include <linux/module.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -876,6 +877,23 @@ static int modify_bitmap(const char *str, unsigned long *bitmap, int bits)
 	return 0;
 }
 
+static int ap_parse_bitmap_str(const char *str, unsigned long *bitmap, int bits,
+			       unsigned long *newmap)
+{
+	unsigned long size;
+	int rc;
+
+	size = BITS_TO_LONGS(bits)*sizeof(unsigned long);
+	if (*str == '+' || *str == '-') {
+		memcpy(newmap, bitmap, size);
+		rc = modify_bitmap(str, newmap, bits);
+	} else {
+		memset(newmap, 0, size);
+		rc = hex2bitmap(str, newmap, bits);
+	}
+	return rc;
+}
+
 int ap_parse_mask_str(const char *str,
 		      unsigned long *bitmap, int bits,
 		      struct mutex *lock)
@@ -895,14 +913,7 @@ int ap_parse_mask_str(const char *str,
 		kfree(newmap);
 		return -ERESTARTSYS;
 	}
-
-	if (*str == '+' || *str == '-') {
-		memcpy(newmap, bitmap, size);
-		rc = modify_bitmap(str, newmap, bits);
-	} else {
-		memset(newmap, 0, size);
-		rc = hex2bitmap(str, newmap, bits);
-	}
+	rc = ap_parse_bitmap_str(str, bitmap, bits, newmap);
 	if (rc == 0)
 		memcpy(bitmap, newmap, size);
 	mutex_unlock(lock);
@@ -1092,12 +1103,70 @@ static ssize_t apmask_show(struct bus_type *bus, char *buf)
 	return rc;
 }
 
+static int __verify_card_reservations(struct device_driver *drv, void *data)
+{
+	int rc = 0;
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+	unsigned long *newapm = (unsigned long *)data;
+
+	/*
+	 * No need to verify whether the driver is using the queues if it is the
+	 * default driver.
+	 */
+	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
+		return 0;
+
+	/* The non-default driver's module must be loaded */
+	if (!try_module_get(drv->owner))
+		return 0;
+
+	if (ap_drv->in_use)
+		if (ap_drv->in_use(newapm, ap_perms.aqm))
+			rc = -EADDRINUSE;
+
+	module_put(drv->owner);
+
+	return rc;
+}
+
+static int apmask_commit(unsigned long *newapm)
+{
+	int rc;
+	unsigned long reserved[BITS_TO_LONGS(AP_DEVICES)];
+
+	/*
+	 * Check if any bits in the apmask have been set which will
+	 * result in queues being removed from non-default drivers
+	 */
+	if (bitmap_andnot(reserved, newapm, ap_perms.apm, AP_DEVICES)) {
+		rc = bus_for_each_drv(&ap_bus_type, NULL, reserved,
+				      __verify_card_reservations);
+		if (rc)
+			return rc;
+	}
+
+	memcpy(ap_perms.apm, newapm, APMASKSIZE);
+
+	return 0;
+}
+
 static ssize_t apmask_store(struct bus_type *bus, const char *buf,
 			    size_t count)
 {
 	int rc;
+	DECLARE_BITMAP(newapm, AP_DEVICES);
+
+	if (mutex_lock_interruptible(&ap_perms_mutex))
+		return -ERESTARTSYS;
+
+	rc = ap_parse_bitmap_str(buf, ap_perms.apm, AP_DEVICES, newapm);
+	if (rc)
+		goto done;
 
-	rc = ap_parse_mask_str(buf, ap_perms.apm, AP_DEVICES, &ap_perms_mutex);
+	rc = apmask_commit(newapm);
+
+done:
+	mutex_unlock(&ap_perms_mutex);
 	if (rc)
 		return rc;
 
@@ -1123,12 +1192,71 @@ static ssize_t aqmask_show(struct bus_type *bus, char *buf)
 	return rc;
 }
 
+static int __verify_queue_reservations(struct device_driver *drv, void *data)
+{
+	int rc = 0;
+	struct ap_driver *ap_drv = to_ap_drv(drv);
+	unsigned long *newaqm = (unsigned long *)data;
+
+	/*
+	 * If the reserved bits do not identify queues reserved for use by the
+	 * non-default driver, there is no need to verify the driver is using
+	 * the queues.
+	 */
+	if (ap_drv->flags & AP_DRIVER_FLAG_DEFAULT)
+		return 0;
+
+	/* The non-default driver's module must be loaded */
+	if (!try_module_get(drv->owner))
+		return 0;
+
+	if (ap_drv->in_use)
+		if (ap_drv->in_use(ap_perms.apm, newaqm))
+			rc = -EADDRINUSE;
+
+	module_put(drv->owner);
+
+	return rc;
+}
+
+static int aqmask_commit(unsigned long *newaqm)
+{
+	int rc;
+	unsigned long reserved[BITS_TO_LONGS(AP_DOMAINS)];
+
+	/*
+	 * Check if any bits in the aqmask have been set which will
+	 * result in queues being removed from non-default drivers
+	 */
+	if (bitmap_andnot(reserved, newaqm, ap_perms.aqm, AP_DOMAINS)) {
+		rc = bus_for_each_drv(&ap_bus_type, NULL, reserved,
+				      __verify_queue_reservations);
+		if (rc)
+			return rc;
+	}
+
+	memcpy(ap_perms.aqm, newaqm, AQMASKSIZE);
+
+	return 0;
+}
+
 static ssize_t aqmask_store(struct bus_type *bus, const char *buf,
 			    size_t count)
 {
 	int rc;
+	DECLARE_BITMAP(newaqm, AP_DOMAINS);
 
-	rc = ap_parse_mask_str(buf, ap_perms.aqm, AP_DOMAINS, &ap_perms_mutex);
+	if (mutex_lock_interruptible(&ap_perms_mutex))
+		return -ERESTARTSYS;
+
+	rc = ap_parse_bitmap_str(buf, ap_perms.aqm, AP_DOMAINS, newaqm);
+	if (rc)
+		goto done;
+
+	rc = aqmask_commit(newaqm);
+
+done:
+	mutex_unlock(&ap_perms_mutex);
 	if (rc)
 		return rc;
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 053cc34d2ca2..7d9646251bfd 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -136,6 +136,7 @@ struct ap_driver {
 
 	int (*probe)(struct ap_device *);
 	void (*remove)(struct ap_device *);
+	bool (*in_use)(unsigned long *apm, unsigned long *aqm);
 };
 
 #define to_ap_drv(x) container_of((x), struct ap_driver, driver)
@@ -254,6 +255,9 @@ void ap_queue_init_state(struct ap_queue *aq);
 struct ap_card *ap_card_create(int id, int queue_depth, int raw_device_type,
 			       int comp_device_type, unsigned int functions);
 
+#define APMASKSIZE (BITS_TO_LONGS(AP_DEVICES) * sizeof(unsigned long))
+#define AQMASKSIZE (BITS_TO_LONGS(AP_DOMAINS) * sizeof(unsigned long))
+
 struct ap_perms {
 	unsigned long ioctlm[BITS_TO_LONGS(AP_IOCTLS)];
 	unsigned long apm[BITS_TO_LONGS(AP_DEVICES)];
-- 
2.21.1

