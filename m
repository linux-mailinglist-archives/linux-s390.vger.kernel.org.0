Return-Path: <linux-s390+bounces-9640-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA282A734B9
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 15:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018213AB935
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C9B218592;
	Thu, 27 Mar 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDfsC7pa"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BB217F36
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086395; cv=none; b=CKX5ih38Lx0cbMWf82cwe/7/LTVjiqbk4qRG2KDeCmP8ARQSbuW9/u8sAJC5SEhguSGqk4MjdYfKDTKOxMe0wLDbMmzBpax+1bFb06l/1VazLUb8RS4+LADKpB1yXdpNZCRpArkDQeLLnhfHgtfAOvgon1pdkxX+g+7YzxsvHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086395; c=relaxed/simple;
	bh=jpc7mcdixHEC6oG9ZD57FSeslsvWK4/RCk4rT4GM3nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dHO6HzoBEclgvRuV3wgzpRgAig26V01/a14ai6V/01mALV6Pl7k53RkxFxVpuoQKiX3zxof0GUhU/e3+DR892uJz9DG+4vpqF1aw5m4HRZx1SolI3+y5LdDsoplcslNEPydZB9a97I/VrU1FGUbGB7g3ADxVnCIxDPSRMP5K+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDfsC7pa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R8KRXv011821;
	Thu, 27 Mar 2025 14:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/URjHY7lYbmR8wWAb
	hR+5s4MLay77QO8V7Sjbf/d6uo=; b=lDfsC7payf3DZPZvYO/DNJlFQFxcUOm1l
	uCdDwYbuy3wgf2cd6rnpKgDTQhAkqoUKAHNVX8zPTx7CU+2+jNOaly9XjIm66Xuq
	CSPY2hItY2bF/zcGRi0zYZnFY0J867VxnjJuvewep7+ssAvhddtP01CoNCg0vUr/
	f8O8rxgnkuVQGPtZuKf0m6jIuYfMTIcfn2rqsPK7yZt4I4qsSTjDdZs52IZnsmm4
	C2b0G0KyRF6LXcWUI10/EHPUbPXjl+TuhUmyGVMQGf7UQwBglWZHEoXFwtw+YO+L
	vvpF6/YdRSmYzcovUXLeM9bLeNQbgXIb0EZPeXl8v+YQE4H028ouA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mrt04e04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RBmXaB012234;
	Thu, 27 Mar 2025 14:39:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91mdq2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdjqe30605992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA2D20040;
	Thu, 27 Mar 2025 14:39:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EB0120043;
	Thu, 27 Mar 2025 14:39:44 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:44 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 04/21] s390/ap/zcrypt: New xflag parameter
Date: Thu, 27 Mar 2025 15:39:24 +0100
Message-ID: <20250327143941.45507-5-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327143941.45507-1-freude@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8L2Gn8p8tkgyl8DB2mg94_rspqht0qeT
X-Proofpoint-GUID: 8L2Gn8p8tkgyl8DB2mg94_rspqht0qeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Introduce a new flag parameter for the both cprb send functions
zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
xflags parameter ("execution flags") shall be used to provide
execution hints and flags for this crypto request.

There are two flags implemented to be used with these functions:
* ZCRYPT_XFLAG_USERSPACE - indicates to the lower layers that
  all the ptrs address userspace. So when construction the ap msg
  copy_from_user() is to be used. If this flag is NOT set, the ptrs
  address kernel memory and thus memcpy() is to be used.
* ZCRYPT_XFLAG_NOMEMALLOC - indicates that this task must not
  allocate memory which may be allocated with io operations.
  For the zcrypt layer this limits the number of EP11 targets
  to 16 APQNs. But as this flag is passed down the stack, it
  may induce further restrictions.

For the AP bus and zcrypt message layer this means:
* The ZCRYPT_XFLAG_USERSPACE is mapped to the already existing
  bool variable "userspace" which is propagated to the zcrypt
  proto implementations.
* The ZCRYPT_XFLAG_NOMEMALLOC results in setting the AP flag
  AP_MSG_FLAG_MEMPOOL when the AP msg buffer is initialized.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/ap_bus.c          |  6 +--
 drivers/s390/crypto/ap_bus.h          |  2 +-
 drivers/s390/crypto/zcrypt_api.c      | 76 +++++++++++++++------------
 drivers/s390/crypto/zcrypt_api.h      | 11 +++-
 drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++---
 drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++--
 6 files changed, 69 insertions(+), 52 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 75dbab9dff4a..7b092fb82ac3 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -569,18 +569,18 @@ static void ap_poll_thread_stop(void)
  * Initialize struct ap_message and allocate buffer to construct
  * the ap message.
  */
-int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool)
+int ap_init_apmsg(struct ap_message *ap_msg, u32 flags)
 {
 	unsigned int maxmsgsize;
 
 	memset(ap_msg, 0, sizeof(*ap_msg));
+	ap_msg->flags = flags;
 
-	if (use_mempool) {
+	if (flags & AP_MSG_FLAG_MEMPOOL) {
 		ap_msg->msg = mempool_alloc_preallocated(ap_msg_pool);
 		if (!ap_msg->msg)
 			return -ENOMEM;
 		ap_msg->bufsize = AP_DEFAULT_MAX_MSG_SIZE;
-		ap_msg->flags |= AP_MSG_FLAG_MEMPOOL;
 		return 0;
 	}
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 60c41d8116ad..88b625ba1978 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -238,7 +238,7 @@ struct ap_message {
 #define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) msg */
 #define AP_MSG_FLAG_MEMPOOL  0x0008 /* ap msg buffer allocated via mempool */
 
-int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
+int ap_init_apmsg(struct ap_message *ap_msg, u32 flags);
 void ap_release_apmsg(struct ap_message *ap_msg);
 
 enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event event);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index ad09c5306e28..01cb72fed828 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -648,7 +648,7 @@ static long zcrypt_rsa_modexpo(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(mex, TP_ICARSAMODEXPO);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -753,7 +753,7 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(crt, TP_ICARSACRT);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 
@@ -844,10 +844,11 @@ static long zcrypt_rsa_crt(struct ap_perms *perms,
 	return rc;
 }
 
-static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_cprb(u32 xflags, struct ap_perms *perms,
 			      struct zcrypt_track *tr,
 			      struct ica_xcRB *xcrb)
 {
+	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
 	struct ap_message ap_msg;
@@ -861,7 +862,8 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 
 	xcrb->status = 0;
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
+			   AP_MSG_FLAG_MEMPOOL : 0);
 	if (rc)
 		goto out;
 
@@ -977,7 +979,7 @@ static long _zcrypt_send_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_cprb(struct ica_xcRB *xcrb)
+long zcrypt_send_cprb(struct ica_xcRB *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -985,13 +987,13 @@ long zcrypt_send_cprb(struct ica_xcRB *xcrb)
 	memset(&tr, 0, sizeof(tr));
 
 	do {
-		rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
+		rc = _zcrypt_send_cprb(xflags, &ap_perms, &tr, xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(false, &ap_perms, &tr, xcrb);
+			rc = _zcrypt_send_cprb(xflags, &ap_perms, &tr, xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1029,13 +1031,14 @@ static bool is_desired_ep11_queue(unsigned int dev_qid,
 	return false;
 }
 
-static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
+static long _zcrypt_send_ep11_cprb(u32 xflags, struct ap_perms *perms,
 				   struct zcrypt_track *tr,
 				   struct ep11_urb *xcrb)
 {
+	bool userspace = xflags & ZCRYPT_XFLAG_USERSPACE;
 	struct zcrypt_card *zc, *pref_zc;
 	struct zcrypt_queue *zq, *pref_zq;
-	struct ep11_target_dev *targets;
+	struct ep11_target_dev targetbuf[16], *targets = NULL;
 	unsigned short target_num;
 	unsigned int wgt = 0, pref_wgt = 0;
 	unsigned int func_code = 0, domain;
@@ -1045,36 +1048,40 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 
 	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
+			   AP_MSG_FLAG_MEMPOOL : 0);
 	if (rc)
 		goto out;
 
 	target_num = (unsigned short)xcrb->targets_num;
 
 	/* empty list indicates autoselect (all available targets) */
-	targets = NULL;
+	rc = -ENOMEM;
 	if (target_num != 0) {
 		struct ep11_target_dev __user *uptr;
 
-		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
-		if (!targets) {
-			func_code = 0;
-			rc = -ENOMEM;
+		if (target_num <= ARRAY_SIZE(targetbuf)) {
+			targets = targetbuf;
+		} else if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
 			goto out;
+		} else {
+			targets = kcalloc(target_num,
+					  sizeof(*targets), GFP_KERNEL);
+			if (!targets)
+				goto out;
 		}
 
 		uptr = (struct ep11_target_dev __force __user *)xcrb->targets;
 		if (z_copy_from_user(userspace, targets, uptr,
 				     target_num * sizeof(*targets))) {
-			func_code = 0;
 			rc = -EFAULT;
-			goto out_free;
+			goto out;
 		}
 	}
 
 	rc = prep_ep11_ap_msg(userspace, xcrb, &ap_msg, &func_code, &domain);
 	if (rc)
-		goto out_free;
+		goto out;
 	print_hex_dump_debug("ep11req: ", DUMP_PREFIX_ADDRESS, 16, 1,
 			     ap_msg.msg, ap_msg.len, false);
 
@@ -1082,11 +1089,11 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 		if (ap_msg.flags & AP_MSG_FLAG_ADMIN) {
 			if (!test_bit_inv(domain, perms->adm)) {
 				rc = -ENODEV;
-				goto out_free;
+				goto out;
 			}
 		} else if ((ap_msg.flags & AP_MSG_FLAG_USAGE) == 0) {
 			rc = -EOPNOTSUPP;
-			goto out_free;
+			goto out;
 		}
 	}
 
@@ -1154,7 +1161,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 			pr_debug("no match for address ff.ffff => ENODEV\n");
 		}
 		rc = -ENODEV;
-		goto out_free;
+		goto out;
 	}
 
 	qid = pref_zq->queue->qid;
@@ -1168,9 +1175,9 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	zcrypt_drop_queue(pref_zc, pref_zq, mod, wgt);
 	spin_unlock(&zcrypt_list_lock);
 
-out_free:
-	kfree(targets);
 out:
+	if (targets && targets != targetbuf)
+		kfree(targets);
 	ap_release_apmsg(&ap_msg);
 	if (tr) {
 		tr->last_rc = rc;
@@ -1181,7 +1188,7 @@ static long _zcrypt_send_ep11_cprb(bool userspace, struct ap_perms *perms,
 	return rc;
 }
 
-long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
+long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb, u32 xflags)
 {
 	struct zcrypt_track tr;
 	int rc;
@@ -1189,13 +1196,13 @@ long zcrypt_send_ep11_cprb(struct ep11_urb *xcrb)
 	memset(&tr, 0, sizeof(tr));
 
 	do {
-		rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
+		rc = _zcrypt_send_ep11_cprb(xflags, &ap_perms, &tr, xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_ep11_cprb(false, &ap_perms, &tr, xcrb);
+			rc = _zcrypt_send_ep11_cprb(xflags, &ap_perms, &tr, xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1219,7 +1226,7 @@ static long zcrypt_rng(char *buffer)
 
 	trace_s390_zcrypt_req(buffer, TP_HWRNGCPRB);
 
-	rc = ap_init_apmsg(&ap_msg, false);
+	rc = ap_init_apmsg(&ap_msg, 0);
 	if (rc)
 		goto out;
 	rc = prep_rng_ap_msg(&ap_msg, &func_code, &domain);
@@ -1532,6 +1539,7 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ica_xcRB xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ica_xcRB __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1539,13 +1547,13 @@ static int zsecsendcprb_ioctl(struct ap_perms *perms, unsigned long arg)
 		return -EFAULT;
 
 	do {
-		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
+		rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb);
+			rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1562,6 +1570,7 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 	int rc;
 	struct ep11_urb xcrb;
 	struct zcrypt_track tr;
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct ep11_urb __user *uxcrb = (void __user *)arg;
 
 	memset(&tr, 0, sizeof(tr));
@@ -1569,13 +1578,13 @@ static int zsendep11cprb_ioctl(struct ap_perms *perms, unsigned long arg)
 		return -EFAULT;
 
 	do {
-		rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
+		rc = _zcrypt_send_ep11_cprb(xflags, perms, &tr, &xcrb);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_ep11_cprb(true, perms, &tr, &xcrb);
+			rc = _zcrypt_send_ep11_cprb(xflags, perms, &tr, &xcrb);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
@@ -1836,6 +1845,7 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
 			 unsigned int cmd, unsigned long arg)
 {
 	struct compat_ica_xcrb __user *uxcrb32 = compat_ptr(arg);
+	u32 xflags = ZCRYPT_XFLAG_USERSPACE;
 	struct compat_ica_xcrb xcrb32;
 	struct zcrypt_track tr;
 	struct ica_xcRB xcrb64;
@@ -1865,13 +1875,13 @@ static long trans_xcrb32(struct ap_perms *perms, struct file *filp,
 	xcrb64.priority_window = xcrb32.priority_window;
 	xcrb64.status = xcrb32.status;
 	do {
-		rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb64);
+		rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb64);
 	} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 
 	/* on ENODEV failure: retry once again after a requested rescan */
 	if (rc == -ENODEV && zcrypt_process_rescan())
 		do {
-			rc = _zcrypt_send_cprb(true, perms, &tr, &xcrb64);
+			rc = _zcrypt_send_cprb(xflags, perms, &tr, &xcrb64);
 		} while (rc == -EAGAIN && ++tr.again_counter < TRACK_AGAIN_MAX);
 	if (rc == -EAGAIN && tr.again_counter >= TRACK_AGAIN_MAX)
 		rc = -EIO;
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 4ed481df57ca..b1e2e8804932 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -76,6 +76,13 @@ struct zcrypt_track {
 #define TRACK_AGAIN_CARD_WEIGHT_PENALTY  1000
 #define TRACK_AGAIN_QUEUE_WEIGHT_PENALTY 10000
 
+/*
+ * xflags - to be used with zcrypt_send_cprb() and
+ * zcrypt_send_ep11_cprb() for the xflags parameter.
+ */
+#define ZCRYPT_XFLAG_USERSPACE  0x0001  /* data ptrs address userspace */
+#define ZCRYPT_XFLAG_NOMEMALLOC 0x0002  /* do not allocate fresh memory */
+
 struct zcrypt_ops {
 	long (*rsa_modexpo)(struct zcrypt_queue *, struct ica_rsa_modexpo *,
 			    struct ap_message *);
@@ -161,8 +168,8 @@ void zcrypt_msgtype_unregister(struct zcrypt_ops *);
 struct zcrypt_ops *zcrypt_msgtype(unsigned char *, int);
 int zcrypt_api_init(void);
 void zcrypt_api_exit(void);
-long zcrypt_send_cprb(struct ica_xcRB *xcRB);
-long zcrypt_send_ep11_cprb(struct ep11_urb *urb);
+long zcrypt_send_cprb(struct ica_xcRB *xcRB, u32 xflags);
+long zcrypt_send_ep11_cprb(struct ep11_urb *urb, u32 xflags);
 void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext *devstatus);
 int zcrypt_device_status_ext(int card, int queue,
 			     struct zcrypt_device_status_ext *devstatus);
diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
index 43a27cb3db84..521baaea06ff 100644
--- a/drivers/s390/crypto/zcrypt_ccamisc.c
+++ b/drivers/s390/crypto/zcrypt_ccamisc.c
@@ -379,7 +379,7 @@ int cca_genseckey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, errno %d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -517,7 +517,7 @@ int cca_clr2seckey(u16 cardnr, u16 domain, u32 keybitsize,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -644,7 +644,7 @@ int cca_sec2protkey(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -872,7 +872,7 @@ int cca_gencipherkey(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1038,7 +1038,7 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1249,7 +1249,7 @@ int cca_cipher2protkey(u16 cardnr, u16 domain, const u8 *ckey,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1412,7 +1412,7 @@ int cca_ecc2protkey(u16 cardnr, u16 domain, const u8 *key,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -1526,7 +1526,7 @@ int cca_query_crypto_facility(u16 cardnr, u16 domain,
 	prep_xcrb(&xcrb, cardnr, preqcblk, prepcblk);
 
 	/* forward xcrb with request CPRB and reply CPRB to zcrypt dd */
-	rc = zcrypt_send_cprb(&xcrb);
+	rc = zcrypt_send_cprb(&xcrb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_cprb (cardnr=%d domain=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index cb7e6da43602..b60e262bcaa3 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -636,7 +636,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -892,7 +892,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1049,7 +1049,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + rep_pl_size);
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1212,7 +1212,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1372,7 +1372,7 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb);
+	rc = zcrypt_send_ep11_cprb(urb, 0);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
-- 
2.43.0


