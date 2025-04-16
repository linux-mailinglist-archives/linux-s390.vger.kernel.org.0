Return-Path: <linux-s390+bounces-10069-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D92EA905BB
	for <lists+linux-s390@lfdr.de>; Wed, 16 Apr 2025 16:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25D78E32D3
	for <lists+linux-s390@lfdr.de>; Wed, 16 Apr 2025 14:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E11FC7D2;
	Wed, 16 Apr 2025 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ViaAv1eV"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ECD1F418B
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744811896; cv=none; b=dAGfJgxznxBD+94XSafBoZ2J0mldjwT7t9iziq1/DtEcr/5iNObPPO3XekYxlNXLlMX68aQHBudtgU2Rw7K711+GLQwlgbXP7bI3F/sWKYRmFRLxxBEDpn8Q70SJdxAwf68nNMrnU7irfkPqgWzMNCgzWXZHgmxsuWoP8D+9VVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744811896; c=relaxed/simple;
	bh=M5HjbR7UvCChz8vfj2t0VVkAtD2w3Q7dPhn04goklec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMsqB+Ri//VnEzo93lzSm4WdKb/PGiPvWdP1+lC8iMJaYr+wOj3M2lraXPwiPKrdkFK5DEUcUXVy8jT4DdgAfhwA2km2ezvcld+L36TFBMffysmEAqfcP0RC5czNPiWFIIn32HmMqPmiSzavHfHXrGvToMmj/btmPker7uJo8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ViaAv1eV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53GA3tHI028954;
	Wed, 16 Apr 2025 13:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sRXY4Oihnvi6xSjDG
	I8eI3VC2NvZwbn8F5x/tZWaflY=; b=ViaAv1eV6E2CVGIBb401/5iQPOMW8Gq6q
	jlMgYQzzlV5RV5tLc/HNv9TxS7kFxJt0RS5ubfLSmALio2iA0EqHOV392KKFaQkU
	7t+CJt799kd8556Z0Ua/heg5D7UavJ8IAbkb8JobEyaVn6zAKw9dQxleGew/gCjJ
	NWdbmKhCKNaGXNh3eoyh37Z3eXR7C4pHbOlFBL+Rx4LmlY6xgb6/CkjsKhS9eVyS
	yWQBReiG0+J7gSOOQZK89jzL+GchJSRhejXFo3vngcH1cxuiafFwTNoUT+0+5Hhj
	yGPa03IMISssu3768v/w8IQ8TPvk3au3o0lF2TNYwOePxG+QaEksQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 462aff97hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53GATsaO030943;
	Wed, 16 Apr 2025 13:58:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4603gnrnc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 13:58:10 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53GDw66i60228048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 13:58:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C9842004B;
	Wed, 16 Apr 2025 13:58:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1B6920043;
	Wed, 16 Apr 2025 13:58:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.41.243])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 13:58:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        seiden@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v6 07/25] s390/zcrypt: Introduce cprb mempool for ep11 misc functions
Date: Wed, 16 Apr 2025 15:57:42 +0200
Message-ID: <20250416135801.133909-8-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250416135801.133909-1-freude@linux.ibm.com>
References: <20250416135801.133909-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sLbdI6Sui7Y1zBOZuVvXqJ8Ulrah57be
X-Proofpoint-GUID: sLbdI6Sui7Y1zBOZuVvXqJ8Ulrah57be
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2504160111

Introduce a cprb mempool for the zcrypt ep11 misc functions
(zcrypt_ep11misc.*) do some preparation rework to support
a do-not-allocate path through some zcrypt ep11 misc functions.

The mempool is controlled by the zcrypt module parameter
"mempool_threshold" which shall control the minimal amount
of memory items for CCA and EP11.

The mempool shall support "mempool_threshold" requests/replies
in parallel which means for EP11 to hold a send and receive
buffer memory per request. Each of this cprb space items is
limited to 8 KB. So by default the mempool consumes
  5 * 2 * 8KB = 80KB

If the mempool is depleted upon one ep11 misc functions is
called with the ZCRYPT_XFLAG_NOMEMALLOC xflag set, the function
will fail with -ENOMEM and the caller is responsible for taking
further actions.

This is only part of an rework to support a new xflag
ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/zcrypt_api.c      |   6 ++
 drivers/s390/crypto/zcrypt_ep11misc.c | 149 +++++++++++++++-----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
 3 files changed, 95 insertions(+), 61 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index 154ec1cc3425..5cddcc4bc790 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -2169,6 +2169,10 @@ int __init zcrypt_api_init(void)
 	if (rc)
 		goto out_ccamisc_init_failed;
 
+	rc = zcrypt_ep11misc_init();
+	if (rc)
+		goto out_ep11misc_init_failed;
+
 	/* Register the request sprayer. */
 	rc = misc_register(&zcrypt_misc_device);
 	if (rc < 0)
@@ -2180,6 +2184,8 @@ int __init zcrypt_api_init(void)
 	return 0;
 
 out_misc_register_failed:
+	zcrypt_ep11misc_exit();
+out_ep11misc_init_failed:
 	zcrypt_ccamisc_exit();
 out_ccamisc_init_failed:
 	zcdn_exit();
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index b60e262bcaa3..8b37b045fd92 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -10,9 +10,10 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/init.h>
+#include <linux/mempool.h>
 #include <linux/module.h>
-#include <linux/slab.h>
 #include <linux/random.h>
+#include <linux/slab.h>
 #include <asm/zcrypt.h>
 #include <asm/pkey.h>
 #include <crypto/aes.h>
@@ -30,6 +31,14 @@
 static const u8 def_iv[16] = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 			       0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff };
 
+/*
+ * Cprb memory pool held for urgent cases where no memory
+ * can be allocated via kmalloc. This pool is only used when
+ * alloc_cprbmem() is called with the xflag ZCRYPT_XFLAG_NOMEMALLOC.
+ */
+#define CPRB_MEMPOOL_ITEM_SIZE (8 * 1024)
+static mempool_t *cprb_mempool;
+
 /* ep11 card info cache */
 struct card_list_entry {
 	struct list_head list;
@@ -411,14 +420,20 @@ EXPORT_SYMBOL(ep11_check_aes_key);
 /*
  * Allocate and prepare ep11 cprb plus additional payload.
  */
-static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
+static void *alloc_cprbmem(size_t payload_len, u32 xflags)
 {
 	size_t len = sizeof(struct ep11_cprb) + payload_len;
-	struct ep11_cprb *cprb;
+	struct ep11_cprb *cprb = NULL;
 
-	cprb = kzalloc(len, GFP_KERNEL);
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
+		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
+			cprb = mempool_alloc_preallocated(cprb_mempool);
+	} else {
+		cprb = kmalloc(len, GFP_KERNEL);
+	}
 	if (!cprb)
 		return NULL;
+	memset(cprb, 0, len);
 
 	cprb->cprb_len = sizeof(struct ep11_cprb);
 	cprb->cprb_ver_id = 0x04;
@@ -429,6 +444,20 @@ static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
 	return cprb;
 }
 
+/*
+ * Free ep11 cprb buffer space.
+ */
+static void free_cprbmem(void *mem, size_t payload_len, bool scrub, u32 xflags)
+{
+	if (scrub)
+		memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);
+
+	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC)
+		mempool_free(mem, cprb_mempool);
+	else
+		kfree(mem);
+}
+
 /*
  * Some helper functions related to ASN1 encoding.
  * Limited to length info <= 2 byte.
@@ -489,6 +518,7 @@ static inline void prep_urb(struct ep11_urb *u,
 			    struct ep11_cprb *req, size_t req_len,
 			    struct ep11_cprb *rep, size_t rep_len)
 {
+	memset(u, 0, sizeof(*u));
 	u->targets = (u8 __user *)t;
 	u->targets_num = nt;
 	u->req = (u8 __user *)req;
@@ -605,11 +635,12 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
-	req = alloc_cprb(sizeof(struct ep11_info_req_pl));
+	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct ep11_info_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -621,22 +652,19 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	req_pl->query_subtype_len = sizeof(u32);
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct ep11_info_rep_pl) + buflen);
+	rep = alloc_cprbmem(sizeof(struct ep11_info_rep_pl) + buflen, xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct ep11_info_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = cardnr;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + sizeof(*req_pl),
 		 rep, sizeof(*rep) + sizeof(*rep_pl) + buflen);
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)cardnr, (int)domain, rc);
@@ -667,9 +695,8 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	memcpy(buf, ((u8 *)rep_pl) + sizeof(*rep_pl), rep_pl->data_len);
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, 0, false, xflags);
 	return rc;
 }
 
@@ -823,9 +850,10 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	size_t req_pl_size, pinblob_size = 0;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -851,7 +879,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 		pinblob_size = EP11_PINBLOB_V1_BYTES;
 	}
 	req_pl_size = sizeof(struct keygen_req_pl) + ASN1TAGLEN(pinblob_size);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct keygen_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -877,22 +905,19 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	*p++ = pinblob_size;
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct keygen_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct keygen_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct keygen_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -925,9 +950,8 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, 0, false, xflags);
+	free_cprbmem(rep, sizeof(struct keygen_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1000,10 +1024,11 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1012,7 +1037,7 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct crypt_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keysize) + ASN1TAGLEN(inbufsize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct crypt_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1034,22 +1059,19 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 
 	/* reply cprb and payload, assume out data size <= in data size + 32 */
 	rep_pl_size = sizeof(struct crypt_rep_pl) + ASN1TAGLEN(inbufsize + 32);
-	rep = alloc_cprb(rep_pl_size);
+	rep = alloc_cprbmem(rep_pl_size, xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct crypt_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + rep_pl_size);
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1095,9 +1117,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	*outbufsize = n;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, rep_pl_size, true, xflags);
 	return rc;
 }
 
@@ -1143,9 +1164,10 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	size_t req_pl_size, pinblob_size = 0;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1161,7 +1183,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	req_pl_size = sizeof(struct uw_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keksize) + ASN1TAGLEN(0)
 		+ ASN1TAGLEN(pinblob_size) + ASN1TAGLEN(enckeysize);
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	req_pl = (struct uw_req_pl *)(((u8 *)req) + sizeof(*req));
@@ -1197,22 +1219,19 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	p += asn1tag_write(p, 0x04, enckey, enckeysize);
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct uw_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct uw_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct uw_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1245,9 +1264,8 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	*keybufsize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct uw_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1319,15 +1337,16 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	} __packed * rep_pl;
 	struct ep11_cprb *req = NULL, *rep = NULL;
 	struct ep11_target_dev target;
-	struct ep11_urb *urb = NULL;
+	struct ep11_urb urb;
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
+	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
 		+ ASN1TAGLEN(keysize) + 4;
-	req = alloc_cprb(req_pl_size);
+	req = alloc_cprbmem(req_pl_size, xflags);
 	if (!req)
 		goto out;
 	if (!mech || mech == 0x80060001)
@@ -1357,22 +1376,19 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	*p++ = 0;
 
 	/* reply cprb and payload */
-	rep = alloc_cprb(sizeof(struct wk_rep_pl));
+	rep = alloc_cprbmem(sizeof(struct wk_rep_pl), xflags);
 	if (!rep)
 		goto out;
 	rep_pl = (struct wk_rep_pl *)(((u8 *)rep) + sizeof(*rep));
 
 	/* urb and target */
-	urb = kmalloc(sizeof(*urb), GFP_KERNEL);
-	if (!urb)
-		goto out;
 	target.ap_id = card;
 	target.dom_id = domain;
-	prep_urb(urb, &target, 1,
+	prep_urb(&urb, &target, 1,
 		 req, sizeof(*req) + req_pl_size,
 		 rep, sizeof(*rep) + sizeof(*rep_pl));
 
-	rc = zcrypt_send_ep11_cprb(urb, 0);
+	rc = zcrypt_send_ep11_cprb(&urb, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s zcrypt_send_ep11_cprb(card=%d dom=%d) failed, rc=%d\n",
 			       __func__, (int)card, (int)domain, rc);
@@ -1405,9 +1421,8 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	*datasize = rep_pl->data_len;
 
 out:
-	kfree(req);
-	kfree(rep);
-	kfree(urb);
+	free_cprbmem(req, req_pl_size, true, xflags);
+	free_cprbmem(rep, sizeof(struct wk_rep_pl), true, xflags);
 	return rc;
 }
 
@@ -1459,7 +1474,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 			    encbuf, encbuflen, 0, def_iv,
 			    keybitsize, 0, keybuf, keybufsize, keytype);
 	if (rc) {
-		ZCRYPT_DBF_ERR("%s importing key value as new key failed,, rc=%d\n",
+		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
 		goto out;
 	}
@@ -1658,7 +1673,19 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 }
 EXPORT_SYMBOL(ep11_findcard2);
 
-void __exit zcrypt_ep11misc_exit(void)
+int __init zcrypt_ep11misc_init(void)
+{
+	/* Pre-allocate a small memory pool for ep11 cprbs. */
+	cprb_mempool = mempool_create_kmalloc_pool(2 * zcrypt_mempool_threshold,
+						   CPRB_MEMPOOL_ITEM_SIZE);
+	if (!cprb_mempool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void zcrypt_ep11misc_exit(void)
 {
 	card_cache_free();
+	mempool_destroy(cprb_mempool);
 }
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 9f1bdffdec68..a4b98eca8431 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -152,6 +152,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 int ep11_kblob2protkey(u16 card, u16 dom, const u8 *key, u32 keylen,
 		       u8 *protkey, u32 *protkeylen, u32 *protkeytype);
 
+int zcrypt_ep11misc_init(void);
 void zcrypt_ep11misc_exit(void);
 
 #endif /* _ZCRYPT_EP11MISC_H_ */
-- 
2.43.0


