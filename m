Return-Path: <linux-s390+bounces-10037-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28405A8A0F2
	for <lists+linux-s390@lfdr.de>; Tue, 15 Apr 2025 16:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC6E73A80B4
	for <lists+linux-s390@lfdr.de>; Tue, 15 Apr 2025 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD81156F45;
	Tue, 15 Apr 2025 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olDEeKIK"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B231DB34C
	for <linux-s390@vger.kernel.org>; Tue, 15 Apr 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744727094; cv=none; b=Fd+wHpolIZGhkJqcV/niw0On/pokW9k+DHqvZrNK9Rxd1bDxvHnfhhRUzWRhQae2GLKUu3y/7l9MMDTWbDlWXhZpHe0HD1KnhRhOO1yFddkAS9t801rSe+7zU0gk2/dnIUX9p3+I4CeRz82X8vluui9yYfIwxwM9ZTSORoTtZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744727094; c=relaxed/simple;
	bh=sjhs6mR7lq2sUkxuI2bir1U9gQka0ldpyYhiifFYXK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KFNnWw7NPbbI95aoW79KGeDD29XYEMste4e9bVJqUTTKrwwS18mz4HuAxjbenOILLfbkXzmaqjkXdfYq7x1v1lY7jlcLQSMDhzvYNQvPfVdotywG6qm4BYpNBu88SZp/DbE2Q0Enh5yZRGq5lGfoCPVXJYgW0vpLQCxfm89qDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olDEeKIK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9lbqd029416;
	Tue, 15 Apr 2025 14:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6ZqJFgHwf2uce9Ozt
	KTzwSPoQblMgXL9jrmCr2y4kxI=; b=olDEeKIKfh3wj0yHYle3nr0Cnqa662rgI
	DGBP1wZG4QM7PsL47TKvkC6rcCcSBXGfSOUD+vedKRuggKz9Qgab9kScCxACf2vc
	eL9w72yVBAQLrJ/guXf51wQLIzb57TLZ6Ra3j/v1y8N62pwxorORvy6h9xu0TbEP
	oKwUR9Eqzrk2/g5egGjY2EmhUzPXwc6lf+2hC+6uYhvP5Y9/Bd1NG91vHWbGYTKZ
	VRU6uPKOI71444DccXvJ3x2Oc5loDQg0fY3jI5cewzTDNNvcZEvId+EpJD1ARk90
	iEOB6l3UVXjUv6v653XThx2zTnNA1uXTDaUOBiCAT9vTN9r7odunA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461agt3xdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53FBct6W010438;
	Tue, 15 Apr 2025 14:24:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk384p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Apr 2025 14:24:48 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53FEOj0N33620488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 14:24:45 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 698E42004D;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11FB92004F;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Apr 2025 14:24:45 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v5 14/25] s390/zcrypt: Rework ep11 findcard() implementation and callers
Date: Tue, 15 Apr 2025 16:24:27 +0200
Message-ID: <20250415142438.118474-15-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _HkbbTxqp-anEAKy4i5rwlIiLAmVvkbW
X-Proofpoint-GUID: _HkbbTxqp-anEAKy4i5rwlIiLAmVvkbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_06,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504150099

Rework the memory usage of the ep11 findcard() implementation:
- findcard does not allocate memory for the list of apqns
  any more.
- the callers are now responsible to provide an array of
  apqns to store the matching apqns into.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
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
index b8b4b9512a73..ba8f2f272cd4 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -1522,14 +1522,14 @@ int ep11_kblob2protkey(u16 card, u16 dom,
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
@@ -1541,13 +1541,6 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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
@@ -1584,25 +1577,15 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
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


