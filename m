Return-Path: <linux-s390+bounces-10023-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D3A8A0E5
	for <lists+linux-s390@lfdr.de>; Tue, 15 Apr 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91F63189F080
	for <lists+linux-s390@lfdr.de>; Tue, 15 Apr 2025 14:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A313D891;
	Tue, 15 Apr 2025 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nVKpciV/"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA01A0712
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727089; cv=none; b=npFACo4MgfuKkrzN6+QUsAv0FUSGRRMhjSV89AsZfo45g8YywoyRom4BxI78tpQzVf9/AWE0flOOV6VAzG1+Jnv5URtJHaWkpixnfnOKDC/qulay0Glq8SMK4I6+toUZfOno/RvzdROY+joeqJXIv3dOaAsMrlhEPRIA8PUhhEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727089; c=relaxed/simple;
	bh=7iONNdutyxLIuYnqy0s37P6CJ6amoXgwH/BRl1M1d7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P6DC1fQv7LmR5Rv4xSB9DcLCJqH2fPzdOAT+8JyoZLcyUz9OOsyjX6E4eUFlDlYySklEp/UcIjMmd3kHJuz6Wg5gqiQEtFsu9sHF9tkPk9yo5Vvpl0XdC8Lf60IE7Sk5uwrHrtk6hg6BzNyiaNq4+pAy8W5Ka3bkECdBUsm0F5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nVKpciV/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FAxnKl021284;
	Tue, 15 Apr 2025 14:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V25DvVsNKVr+7TF7y
	EN86ltZ27AJZHVh7L/v9uM5rzI=; b=nVKpciV/hkr9mzenohdqLSheRxIxLeFgq
	zcCBrssVuKyuMt2oMGAXs18QT5gEE6bKHpvQQTLYyoySNdpV5JVerCCYrslsKBUD
	qY4b6Yqd/2ADKGJVyQWdO8yRrYTo62KEQo1Gcqeesu2VSbofPpa2UfTtG6oxpBHL
	OwWTZbj/GCSNNSpKsu4SdGIjK7t8+bm2rosH03uwkv7FlYPOOd8Aa9nh444Hrn5/
	nNEjMfhVoLG6+GUnJbr7oMujKa6x91PrTkxem92v4g+4v95fkrf1GP5lEss+HHrA
	bKpXumHzt8kbnCKYP2hfUbEKwK9MyqxBVwWH3B7SeR6V77h2G2VFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461af544nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FD8AmK001265;
	Tue, 15 Apr 2025 14:24:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyuptj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOeaM38666512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C56462004F;
	Tue, 15 Apr 2025 14:24:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C97D2004B;
	Tue, 15 Apr 2025 14:24:40 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:40 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 03/25] s390/ap: Introduce ap message buffer pool
Date: Tue, 15 Apr 2025 16:24:16 +0200
Message-ID: <20250415142438.118474-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415142438.118474-1-freude@linux.ibm.com>
References: <20250415142438.118474-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Nzhkm6Vfa0SKAzwAKhNUD8S83D4WKj3W
X-Proofpoint-GUID: Nzhkm6Vfa0SKAzwAKhNUD8S83D4WKj3W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

There is a need for a do-not-allocate-memory path through the AP bus
layer. The pkey layer may be triggered via the in-kernel interface
from a protected key crypto algorithm (namely PAES) to convert a
secure key into a protected key. This happens in a workqueue context,
so sleeping is allowed but memory allocations causing IO operations
are not permitted.

To accomplish this, an AP message memory pool with pre-allocated space
is established. When ap_init_apmsg() with use_mempool set to true is
called, instead of kmalloc() the ap message buffer is allocated from
the ap_msg_pool. This pool only holds a limited amount of buffers:
ap_msg_pool_min_items with the item size AP_DEFAULT_MAX_MSG_SIZE and
exactly one of these items (if available) is returned if
ap_init_apmsg() with the use_mempool arg set to true is called. When
this pool is exhausted and use_mempool is set true, ap_init_apmsg()
returns -ENOMEM without any attempt to allocate memory and the caller
has to deal with that.

Default values for this mempool of ap messages is:
 * Each buffer is 12KB (that is the default AP bus size
   and all the urgent messages should fit into this space).
 * Minimum items held in the pool is 8. This value is adjustable
   via module parameter ap.msgpool_min_items.

The zcrypt layer may use this flag to indicate to the ap bus that the
processing path for this message should not allocate memory but should
use pre-allocated memory buffer instead.  This is to prevent deadlocks
with crypto and io for example with encrypted swap volumes.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c     | 54 ++++++++++++++++++++++++++++++--
 drivers/s390/crypto/ap_bus.h     |  3 +-
 drivers/s390/crypto/zcrypt_api.c | 10 +++---
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 8935b3ee3a33..067eb0fcde41 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -41,6 +41,7 @@
 #include <linux/module.h>
 #include <asm/uv.h>
 #include <asm/chsc.h>
+#include <linux/mempool.h>
 
 #include "ap_bus.h"
 #include "ap_debug.h"
@@ -102,6 +103,27 @@ static struct ap_config_info *const ap_qci_info_old = &qci[1];
  */
 debug_info_t *ap_dbf_info;
 
+/*
+ * There is a need for a do-not-allocate-memory path through the AP bus
+ * layer. The pkey layer may be triggered via the in-kernel interface from
+ * a protected key crypto algorithm (namely PAES) to convert a secure key
+ * into a protected key. This happens in a workqueue context, so sleeping
+ * is allowed but memory allocations causing IO operations are not permitted.
+ * To accomplish this, an AP message memory pool with pre-allocated space
+ * is established. When ap_init_apmsg() with use_mempool set to true is
+ * called, instead of kmalloc() the ap message buffer is allocated from
+ * the ap_msg_pool. This pool only holds a limited amount of buffers:
+ * ap_msg_pool_min_items with the item size AP_DEFAULT_MAX_MSG_SIZE and
+ * exactly one of these items (if available) is returned if ap_init_apmsg()
+ * with the use_mempool arg set to true is called. When this pool is exhausted
+ * and use_mempool is set true, ap_init_apmsg() returns -ENOMEM without
+ * any attempt to allocate memory and the caller has to deal with that.
+ */
+static mempool_t *ap_msg_pool;
+static unsigned int ap_msg_pool_min_items = 8;
+module_param_named(msgpool_min_items, ap_msg_pool_min_items, uint, 0440);
+MODULE_PARM_DESC(msgpool_min_items, "AP message pool minimal items.");
+
 /*
  * AP bus rescan related things.
  */
@@ -550,11 +572,22 @@ static void ap_poll_thread_stop(void)
 /*
  * ap_init_apmsg() - Initialize ap_message.
  */
-int ap_init_apmsg(struct ap_message *ap_msg)
+int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool)
 {
-	unsigned int maxmsgsize = atomic_read(&ap_max_msg_size);
+	unsigned int maxmsgsize;
 
 	memset(ap_msg, 0, sizeof(*ap_msg));
+
+	if (use_mempool) {
+		ap_msg->msg = mempool_alloc_preallocated(ap_msg_pool);
+		if (!ap_msg->msg)
+			return -ENOMEM;
+		ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
+		ap_msg->flags |= AP_MSG_FLAG_MEMPOOL;
+		return 0;
+	}
+
+	maxmsgsize = atomic_read(&ap_max_msg_size);
 	ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
 	if (!ap_msg->msg)
 		return -ENOMEM;
@@ -569,7 +602,12 @@ EXPORT_SYMBOL(ap_init_apmsg);
  */
 void ap_release_apmsg(struct ap_message *ap_msg)
 {
-	kfree_sensitive(ap_msg->msg);
+	if (ap_msg->flags & AP_MSG_FLAG_MEMPOOL) {
+		memzero_explicit(ap_msg->msg, ap_msg->bufsize);
+		mempool_free(ap_msg->msg, ap_msg_pool);
+	} else {
+		kfree_sensitive(ap_msg->msg);
+	}
 }
 EXPORT_SYMBOL(ap_release_apmsg);
 
@@ -2457,6 +2495,14 @@ static int __init ap_module_init(void)
 	/* init ap_queue hashtable */
 	hash_init(ap_queues);
 
+	/* create ap msg buffer memory pool */
+	ap_msg_pool = mempool_create_kmalloc_pool(ap_msg_pool_min_items,
+						  AP_DEFAULT_MAX_MSG_SIZE);
+	if (!ap_msg_pool) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
 	/* set up the AP permissions (ioctls, ap and aq masks) */
 	ap_perms_init();
 
@@ -2503,6 +2549,7 @@ static int __init ap_module_init(void)
 out_bus:
 	bus_unregister(&ap_bus_type);
 out:
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 	return rc;
 }
@@ -2513,6 +2560,7 @@ static void __exit ap_module_exit(void)
 	ap_irq_exit();
 	root_device_unregister(ap_root_device);
 	bus_unregister(&ap_bus_type);
+	mempool_destroy(ap_msg_pool);
 	ap_debug_exit();
 }
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 483231bcdea6..60c41d8116ad 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -236,8 +236,9 @@ struct ap_message {
 #define AP_MSG_FLAG_SPECIAL  0x0001	/* flag msg as 'special' with NQAP */
 #define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) msg */
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
+#define AP_MSG_FLAG_MEMPOOL  0x0008 /* ap msg buffer allocated via mempool */
 
-int ap_init_apmsg(struct ap_message *ap_msg);
+int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 78df25da0b95..ad09c5306e28 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -861,7 +861,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -1045,7 +1045,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 
@@ -1219,7 +1219,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg);
+	rc = ap_init_apmsg(&ap_msg, false);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
-- 
2.43.0


