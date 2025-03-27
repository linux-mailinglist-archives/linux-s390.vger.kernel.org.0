Return-Path: <linux-s390+bounces-9648-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F47A734AB
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 15:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9DD171C34
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F982185A6;
	Thu, 27 Mar 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="egTBvVyL"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283849460
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086398; cv=none; b=ss7PXI81T7anOjq68rwkif4vjjTTVPiGFpqv9LfSV5sOs6CAHnMO/95LYzJ4eOzouZLMhZVG2RF7eOXPEQuhyub5ayNTJwmveYhWyjI6ilaWP2uCCGTDt90t4EDOQ76afrYWz1o27uGqwpt6KIxNKcqdKRXlRskoifWUZoLfGQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086398; c=relaxed/simple;
	bh=aJefv8e1Rb6EDYLZJfoHSRkO1KKt/5WAw7n4W5FxqD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTyRxJzsc7e/ZHdFFY/VX2L8QHewC0v1mFKRjDUjHVfqPjNSzqzi5KEbDVrig137oy5R8F3kE9YbdoCNtna4REbSi3bZRL7RXGO28ya5ky6bwJ2ICtb1MQI0pmRA6HEDbr7XQO73zpfXu6+DopzdpvO3UUJrMuSUI5FDaiAqWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=egTBvVyL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCo9Mb029861;
	Thu, 27 Mar 2025 14:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xsqAm/qZZG5FNkgaf
	GAKKHDESeszIYSxhYllycnMnI0=; b=egTBvVyLyQkM5+GwELuVMgXmK45Gnd+E9
	SspUbYcTpNBpkxO2BB1ZQJRkBGsxMEo4sws9ucH95BSHsiYvJSvkcjcT7P0W1Kp3
	IMmof4/clRVwGkNz31kumfQ2O8HTvJF1efWzGpOnRGOp0gYI5IwtGNv51a87kX0x
	qGItJffuIolKXgQt5JVB1trNWbWqiiReTaOHivdqN3gV1550hynu4itCfDgs6cuZ
	jGGLAZAXeVT9vBrYxB6mskXhTn20C3+Gs+VbQHFgHOWEVKHdQ+6GcY6Xvmt+2Me8
	7INR9N1B3zneDahX2OVVsEUYtJGrNsnLBKoJexiVntJ6G+f83Xx+g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29b5xh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RAEdIg025489;
	Thu, 27 Mar 2025 14:39:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0dw96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdnO210944848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2EE22004D;
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 442F420043;
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:49 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 13/21] s390/zcrypt/pkey: Rework ep11 findcard() implementation and callers
Date: Thu, 27 Mar 2025 15:39:33 +0100
Message-ID: <20250327143941.45507-14-freude@linux.ibm.com>
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
X-Proofpoint-GUID: tFJTLPYeC_KJSh4-QG-IIKI3PBb19vqn
X-Proofpoint-ORIG-GUID: tFJTLPYeC_KJSh4-QG-IIKI3PBb19vqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

Rework the memory usage of the ep11 findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c       | 19 +++++++---------
 drivers/s390/crypto/zcrypt_ep11misc.c | 31 ++++++---------------------
 drivers/s390/crypto/zcrypt_ep11misc.h | 12 +++++------
 3 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index 5b033ca3e828..b970f0be84be 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -73,7 +73,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			  struct pkey_apqn *apqns, size_t *nr_apqns)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	if (!flags)
@@ -98,7 +98,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			minhwtype = ZCRYPT_CEX7;
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    minhwtype, api, kb->wkvp);
 		if (rc)
 			goto out;
@@ -115,7 +115,7 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 			minhwtype = ZCRYPT_CEX7;
 			api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
 		}
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    minhwtype, api, kb->wkvp);
 		if (rc)
 			goto out;
@@ -135,7 +135,6 @@ static int ep11_apqns4key(const u8 *key, u32 keylen, u32 flags,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -144,7 +143,7 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 			   u8 cur_mkvp[32], u8 alt_mkvp[32], u32 flags,
 			   struct pkey_apqn *apqns, size_t *nr_apqns)
 {
-	u32 _nr_apqns, *_apqns = NULL;
+	u32 _apqns[MAXAPQNSINLIST], _nr_apqns = ARRAY_SIZE(_apqns);
 	int rc;
 
 	zcrypt_wait_api_operational();
@@ -158,7 +157,7 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 		if (flags & PKEY_FLAGS_MATCH_CUR_MKVP)
 			wkvp = cur_mkvp;
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
+		rc = ep11_findcard2(_apqns, &_nr_apqns, 0xFFFF, 0xFFFF,
 				    ZCRYPT_CEX7, api, wkvp);
 		if (rc)
 			goto out;
@@ -178,7 +177,6 @@ static int ep11_apqns4type(enum pkey_key_type ktype,
 	*nr_apqns = _nr_apqns;
 
 out:
-	kfree(_apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
@@ -423,7 +421,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 			  u32 *keytype, u32 *keybitsize, u32 *flags)
 {
 	struct keytoken_header *hdr = (struct keytoken_header *)key;
-	u32 nr_apqns, *apqns = NULL;
+	u32 apqns[MAXAPQNSINLIST], nr_apqns = ARRAY_SIZE(apqns);
 	int rc;
 
 	if (keylen < sizeof(*hdr))
@@ -443,7 +441,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = kb->head.bitlen;
 
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
 				    ep11_kb_wkvp(key, keylen));
 		if (rc)
@@ -467,7 +465,7 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 		*keybitsize = kh->bitlen;
 
 		api = ap_is_se_guest() ? EP11_API_V6 : EP11_API_V4;
-		rc = ep11_findcard2(&apqns, &nr_apqns, *card, *dom,
+		rc = ep11_findcard2(apqns, &nr_apqns, *card, *dom,
 				    ZCRYPT_CEX7, api,
 				    ep11_kb_wkvp(key, keylen));
 		if (rc)
@@ -484,7 +482,6 @@ static int ep11_verifykey(const u8 *key, u32 keylen,
 	}
 
 out:
-	kfree(apqns);
 	pr_debug("rc=%d\n", rc);
 	return rc;
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index 42963640d035..8f93c54c238c 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1523,14 +1523,14 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
 
-int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		   int minhwtype, int minapi, const u8 *wkvp)
 {
 	struct zcrypt_device_status_ext *device_status;
-	u32 *_apqns = NULL, _nr_apqns = 0;
-	int i, card, dom, rc;
 	struct ep11_domain_info edi;
 	struct ep11_card_info eci;
+	u32 _nr_apqns = 0;
+	int i, card, dom;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1542,13 +1542,6 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				      ZCRYPT_DEV_STATUS_CARD_MAX,
 				      ZCRYPT_DEV_STATUS_QUEUE_MAX);
 
-	/* allocate 1k space for up to 256 apqns */
-	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
-	if (!_apqns) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	/* walk through all the crypto apqnss */
 	for (i = 0; i < ZCRYPT_DEV_STATUS_ENTRIES; i++) {
 		card = AP_QID_CARD(device_status[i].qid);
@@ -1585,25 +1578,15 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 				continue;
 		}
 		/* apqn passed all filtering criterons, add to the array */
-		if (_nr_apqns < 256)
-			_apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
+		if (_nr_apqns < *nr_apqns)
+			apqns[_nr_apqns++] = (((u16)card) << 16) | ((u16)dom);
 	}
 
-	/* nothing found ? */
-	if (!_nr_apqns) {
-		kfree(_apqns);
-		rc = -ENODEV;
-	} else {
-		/* no re-allocation, simple return the _apqns array */
-		*apqns = _apqns;
-		*nr_apqns = _nr_apqns;
-		rc = 0;
-	}
+	*nr_apqns = _nr_apqns;
 
-out:
 	mutex_unlock(&dev_status_mem_mutex);
 
-	return rc;
+	return _nr_apqns ? 0 : -ENODEV;
 }
 EXPORT_SYMBOL(ep11_findcard2);
 
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index dc1e418a6db1..2abd77aa16cf 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -136,14 +136,12 @@ int ep11_clr2keyblob(u16 cardnr, u16 domain, u32 keybitsize, u32 keygenflags,
  *   key for this domain. When a wkvp is given there will always be a re-fetch
  *   of the domain info for the potential apqn - so this triggers an request
  *   reply to each apqn eligible.
- * The array of apqn entries is allocated with kmalloc and returned in *apqns;
- * the number of apqns stored into the list is returned in *nr_apqns. One apqn
- * entry is simple a 32 bit value with 16 bit cardnr and 16 bit domain nr and
- * may be casted to struct pkey_apqn. The return value is either 0 for success
- * or a negative errno value. If no apqn meeting the criteria is found,
- * -ENODEV is returned.
+ * The caller should set *nr_apqns to the nr of elements available in *apqns.
+ * On return *nr_apqns is then updated with the nr of apqns filled into *apqns.
+ * The return value is either 0 for success or a negative errno value.
+ * If no apqn meeting the criteria is found, -ENODEV is returned.
  */
-int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
+int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 		   int minhwtype, int minapi, const u8 *wkvp);
 
 /*
-- 
2.43.0


