Return-Path: <linux-s390+bounces-9655-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4E7A734C0
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 15:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD303AD592
	for <lists+linux-s390@lfdr.de>; Thu, 27 Mar 2025 14:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235720F071;
	Thu, 27 Mar 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7BrJeL7"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9941218587
	for <linux-s390@vger.kernel.org>; Thu, 27 Mar 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743086401; cv=none; b=s3vE/fDETqRnkXSKyBDO6ve9Dg1eS+0zqOhrEjSLezKkSoISX03bbLFa7u4Bt4caI29GnEuwAdfs2K9ypIzV3v27unbkMQJHBN0dOmAGNYROx/oEYflnoHiMhRkcwsBKJs4HmQ9sR2GCuigdvoGVicLey2IRQ1ffp/cwANu7la4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743086401; c=relaxed/simple;
	bh=8AcrxddZHxwaLzg1189twyqqnZIYkh5RQWOS6Mf58Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=khZbJxjF/7vs1juEbqYC7+vD7CCJcjHDQKHxdNFNny2NgX0OAOo1hLv0LSmp6ngu6Ng92WrxMTCdQa83b5pBdqPYfOUhFPZ+VvWvnRsZeDSXaX4srdRuUFN9Hxi6Gnj98K24poE5vgOJwVUxxun3da5EfbH7ior2SeJkQ+wDJCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7BrJeL7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52RDjNLH029031;
	Thu, 27 Mar 2025 14:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZufiBhyzgKNZ2Wd7A
	1PaIFUGwbJkhIsCLLv7SL/SS60=; b=H7BrJeL7JpzZUa5CbbEfoLHKvOmwC7EHd
	Zab6Tds2TT0iRnSYUCmvpGXN6PMg+DkZteYQYk3e63wyx2x6xLlMakSutiyYdbOE
	bs3ijzC5fkeHCeQAHZe1LNEMEBG9AKWxw5/AHMhLIJZ4LHp2PXUM9WmbA/PuUtZm
	oW4kb4WMB/rq8QsFK/d4isIWrXom/ayDsEstjnbOisuSuFUaBZEWhH4ziv09rCIQ
	DWphy2YLLxMyyUJhBznxJQ5rWR4HCnKmtSOav+PJFQXhd0SrnHod/f0LbftWHx2p
	9rCAzLpT+DQLUEkrLzKv0wUPhgHDPEjoiVIkmsh62rL1+2/c/Fffw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45my29b5xp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RAbvu8025463;
	Thu, 27 Mar 2025 14:39:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7x0dw99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:39:55 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REdpj832506230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:39:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A855A2004B;
	Thu, 27 Mar 2025 14:39:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D3832004D;
	Thu, 27 Mar 2025 14:39:51 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.24])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Mar 2025 14:39:51 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
Subject: [PATCH v3 17/21] s390/zcrypt: Rework ep11 misc functions to use cprb mempool
Date: Thu, 27 Mar 2025 15:39:37 +0100
Message-ID: <20250327143941.45507-18-freude@linux.ibm.com>
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
X-Proofpoint-GUID: aTlT5U3KqapmvNcJtfjnPytZOK5cItyP
X-Proofpoint-ORIG-GUID: aTlT5U3KqapmvNcJtfjnPytZOK5cItyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503270099

There are two places in the ep11 misc code where a short term
memory buffer is needed. Rework this code to use the cprb mempool
to satisfy this ephemeral memory requirements.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
---
 drivers/s390/crypto/pkey_ep11.c       |   3 +-
 drivers/s390/crypto/zcrypt_cex4.c     |  12 +--
 drivers/s390/crypto/zcrypt_ep11misc.c | 103 ++++++++++++++++----------
 drivers/s390/crypto/zcrypt_ep11misc.h |   7 +-
 4 files changed, 76 insertions(+), 49 deletions(-)

diff --git a/drivers/s390/crypto/pkey_ep11.c b/drivers/s390/crypto/pkey_ep11.c
index b970f0be84be..38aa0c7807c2 100644
--- a/drivers/s390/crypto/pkey_ep11.c
+++ b/drivers/s390/crypto/pkey_ep11.c
@@ -280,6 +280,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 {
 	struct pkey_apqn *local_apqns = NULL;
 	int i, len, rc;
+	const u32 xflags = 0;
 
 	/* check keytype, subtype, keybitsize */
 	switch (keytype) {
@@ -328,7 +329,7 @@ static int ep11_gen_key(const struct pkey_apqn *apqns, size_t nr_apqns,
 	for (rc = -ENODEV, i = 0; rc && i < nr_apqns; i++) {
 		rc = ep11_genaeskey(apqns[i].card, apqns[i].domain,
 				    keybitsize, flags,
-				    keybuf, keybuflen, subtype);
+				    keybuf, keybuflen, subtype, xflags);
 	}
 
 out:
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index 84cbcbab2741..6ba7fbddd3f7 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -214,7 +214,7 @@ static ssize_t ep11_api_ordinalnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.API_ord_nr > 0)
 		return sysfs_emit(buf, "%u\n", ci.API_ord_nr);
@@ -234,7 +234,7 @@ static ssize_t ep11_fw_version_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.FW_version > 0)
 		return sysfs_emit(buf, "%d.%d\n",
@@ -256,7 +256,7 @@ static ssize_t ep11_serialnr_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	if (ci.serial[0])
 		return sysfs_emit(buf, "%16.16s\n", ci.serial);
@@ -293,7 +293,7 @@ static ssize_t ep11_card_op_modes_show(struct device *dev,
 
 	memset(&ci, 0, sizeof(ci));
 
-	ep11_get_card_info(ac->id, &ci);
+	ep11_get_card_info(ac->id, &ci, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (ci.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
@@ -343,7 +343,7 @@ static ssize_t ep11_mkvps_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	if (di.cur_wk_state == '0') {
 		n = sysfs_emit(buf, "WK CUR: %s -\n",
@@ -390,7 +390,7 @@ static ssize_t ep11_queue_op_modes_show(struct device *dev,
 	if (zq->online)
 		ep11_get_domain_info(AP_QID_CARD(zq->queue->qid),
 				     AP_QID_QUEUE(zq->queue->qid),
-				     &di);
+				     &di, 0);
 
 	for (i = 0; ep11_op_modes[i].mode_txt; i++) {
 		if (di.op_mode & (1ULL << ep11_op_modes[i].mode_bit)) {
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
index fa9e52287886..645f6a97e92e 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.c
+++ b/drivers/s390/crypto/zcrypt_ep11misc.c
@@ -550,7 +550,7 @@ static int check_reply_cprb(const struct ep11_cprb *rep, const char *func)
  * Helper function which does an ep11 query with given query type.
  */
 static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
-			   size_t buflen, u8 *buf)
+			   size_t buflen, u8 *buf, u32 xflags)
 {
 	struct ep11_info_req_pl {
 		struct pl_head head;
@@ -574,7 +574,6 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 	struct ep11_target_dev target;
 	struct ep11_urb urb;
 	int api = EP11_API_V1, rc = -ENOMEM;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req = alloc_cprbmem(sizeof(struct ep11_info_req_pl), xflags);
@@ -640,7 +639,7 @@ static int ep11_query_info(u16 cardnr, u16 domain, u32 query_type,
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info)
+int ep11_get_card_info(u16 card, struct ep11_card_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_module_query_info {
@@ -670,12 +669,15 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 		u32 max_CP_index;
 	} __packed * pmqi = NULL;
 
-	pmqi = kmalloc(sizeof(*pmqi), GFP_KERNEL);
+	/* use the cprb mempool to satisfy this short term mem alloc */
+	pmqi = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
 	if (!pmqi)
 		return -ENOMEM;
 	rc = ep11_query_info(card, AUTOSEL_DOM,
 			     0x01 /* module info query */,
-			     sizeof(*pmqi), (u8 *)pmqi);
+			     sizeof(*pmqi), (u8 *)pmqi, xflags);
 	if (rc)
 		goto out;
 
@@ -686,7 +688,7 @@ int ep11_get_card_info(u16 card, struct ep11_card_info *info)
 	info->op_mode = pmqi->op_mode;
 
 out:
-	kfree(pmqi);
+	mempool_free(pmqi, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_get_card_info);
@@ -694,7 +696,8 @@ EXPORT_SYMBOL(ep11_get_card_info);
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags)
 {
 	int rc;
 	struct ep11_domain_query_info {
@@ -706,7 +709,8 @@ int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info)
 	} __packed dom_query_info;
 
 	rc = ep11_query_info(card, domain, 0x03 /* domain info query */,
-			     sizeof(dom_query_info), (u8 *)&dom_query_info);
+			     sizeof(dom_query_info), (u8 *)&dom_query_info,
+			     xflags);
 	if (rc)
 		goto out;
 
@@ -740,7 +744,7 @@ EXPORT_SYMBOL(ep11_get_domain_info);
 
 static int _ep11_genaeskey(u16 card, u16 domain,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct keygen_req_pl {
 		struct pl_head head;
@@ -778,7 +782,6 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	switch (keybitsize) {
 	case 128:
@@ -881,7 +884,7 @@ static int _ep11_genaeskey(u16 card, u16 domain,
 }
 
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver)
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -902,7 +905,7 @@ int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return rc;
 
 	rc = _ep11_genaeskey(card, domain, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -922,7 +925,8 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 			    u16 mode, u32 mech, const u8 *iv,
 			    const u8 *key, size_t keysize,
 			    const u8 *inbuf, size_t inbufsize,
-			    u8 *outbuf, size_t *outbufsize)
+			    u8 *outbuf, size_t *outbufsize,
+			    u32 xflags)
 {
 	struct crypt_req_pl {
 		struct pl_head head;
@@ -953,7 +957,6 @@ static int ep11_cryptsingle(u16 card, u16 domain,
 	size_t req_pl_size, rep_pl_size;
 	int n, api = EP11_API_V1, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* the simple asn1 coding used has length limits */
 	if (keysize > 0xFFFF || inbufsize > 0xFFFF)
@@ -1052,7 +1055,7 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 			   const u8 *enckey, size_t enckeysize,
 			   u32 mech, const u8 *iv,
 			   u32 keybitsize, u32 keygenflags,
-			   u8 *keybuf, size_t *keybufsize)
+			   u8 *keybuf, size_t *keybufsize, u32 xflags)
 {
 	struct uw_req_pl {
 		struct pl_head head;
@@ -1092,7 +1095,6 @@ static int _ep11_unwrapkey(u16 card, u16 domain,
 	struct ep11_urb urb;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	api = (!keygenflags || keygenflags & 0x00200000) ?
@@ -1200,7 +1202,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 			  u32 mech, const u8 *iv,
 			  u32 keybitsize, u32 keygenflags,
 			  u8 *keybuf, u32 *keybufsize,
-			  u8 keybufver)
+			  u8 keybufver, u32 xflags)
 {
 	struct ep11kblob_header *hdr;
 	size_t hdr_size, pl_size;
@@ -1214,7 +1216,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 
 	rc = _ep11_unwrapkey(card, domain, kek, keksize, enckey, enckeysize,
 			     mech, iv, keybitsize, keygenflags,
-			     pl, &pl_size);
+			     pl, &pl_size, xflags);
 	if (rc)
 		return rc;
 
@@ -1233,7 +1235,7 @@ static int ep11_unwrapkey(u16 card, u16 domain,
 static int _ep11_wrapkey(u16 card, u16 domain,
 			 const u8 *key, size_t keysize,
 			 u32 mech, const u8 *iv,
-			 u8 *databuf, size_t *datasize)
+			 u8 *databuf, size_t *datasize, u32 xflags)
 {
 	struct wk_req_pl {
 		struct pl_head head;
@@ -1266,7 +1268,6 @@ static int _ep11_wrapkey(u16 card, u16 domain,
 	size_t req_pl_size;
 	int api, rc = -ENOMEM;
 	u8 *p;
-	const u32 xflags = 0;
 
 	/* request cprb and payload */
 	req_pl_size = sizeof(struct wk_req_pl) + (iv ? 16 : 0)
@@ -1356,8 +1357,10 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		     u32 keytype)
 {
 	int rc;
-	u8 encbuf[64], *kek = NULL;
+	void *mem;
+	u8 encbuf[64], *kek;
 	size_t clrkeylen, keklen, encbuflen = sizeof(encbuf);
+	const u32 xflags = 0;
 
 	if (keybitsize == 128 || keybitsize == 192 || keybitsize == 256) {
 		clrkeylen = keybitsize / 8;
@@ -1367,18 +1370,24 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 		return -EINVAL;
 	}
 
-	/* allocate memory for the temp kek */
+	/*
+	 * Allocate space for the temp kek.
+	 * Also we only need up to MAXEP11AESKEYBLOBSIZE bytes for this
+	 * we use the already existing cprb mempool to solve this
+	 * short term memory requirement.
+	 */
+	mem = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+	kek = (u8 *)mem;
 	keklen = MAXEP11AESKEYBLOBSIZE;
-	kek = kmalloc(keklen, GFP_ATOMIC);
-	if (!kek) {
-		rc = -ENOMEM;
-		goto out;
-	}
 
 	/* Step 1: generate AES 256 bit random kek key */
 	rc = _ep11_genaeskey(card, domain, 256,
 			     0x00006c00, /* EN/DECRYPT, WRAP/UNWRAP */
-			     kek, &keklen);
+			     kek, &keklen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s generate kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1387,7 +1396,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 
 	/* Step 2: encrypt clear key value with the kek key */
 	rc = ep11_cryptsingle(card, domain, 0, 0, def_iv, kek, keklen,
-			      clrkey, clrkeylen, encbuf, &encbuflen);
+			      clrkey, clrkeylen, encbuf, &encbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s encrypting key value with kek key failed, rc=%d\n",
 			       __func__, rc);
@@ -1397,7 +1406,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	/* Step 3: import the encrypted key value as a new key */
 	rc = ep11_unwrapkey(card, domain, kek, keklen,
 			    encbuf, encbuflen, 0, def_iv,
-			    keybitsize, 0, keybuf, keybufsize, keytype);
+			    keybitsize, 0, keybuf, keybufsize, keytype, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s importing key value as new key failed, rc=%d\n",
 			       __func__, rc);
@@ -1405,7 +1414,7 @@ int ep11_clr2keyblob(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
 	}
 
 out:
-	kfree(kek);
+	mempool_free(mem, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_clr2keyblob);
@@ -1428,6 +1437,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	} __packed * wki;
 	u8 *wkbuf = NULL;
 	int rc = -EIO;
+	const u32 xflags = 0;
 
 	if (ep11_kb_decode((u8 *)keyblob, keybloblen, &hdr, NULL, &key, &keylen))
 		return -EINVAL;
@@ -1438,15 +1448,29 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	}
 	/* !!! hdr is no longer a valid header !!! */
 
-	/* alloc temp working buffer */
+	/* need a temp working buffer */
 	wkbuflen = (keylen + AES_BLOCK_SIZE) & (~(AES_BLOCK_SIZE - 1));
-	wkbuf = kmalloc(wkbuflen, GFP_ATOMIC);
-	if (!wkbuf)
-		return -ENOMEM;
+	if (wkbuflen > CPRB_MEMPOOL_ITEM_SIZE) {
+		/* this should never happen */
+		rc = -ENOMEM;
+		ZCRYPT_DBF_ERR("%s wkbuflen %d > cprb mempool item size %d, rc=%d\n",
+			       __func__, (int)wkbuflen, CPRB_MEMPOOL_ITEM_SIZE, rc);
+		return rc;
+	}
+	/* use the cprb mempool to satisfy this short term mem allocation */
+	wkbuf = (xflags & ZCRYPT_XFLAG_NOMEMALLOC) ?
+		mempool_alloc_preallocated(cprb_mempool) :
+		mempool_alloc(cprb_mempool, GFP_ATOMIC);
+	if (!wkbuf) {
+		rc = -ENOMEM;
+		ZCRYPT_DBF_ERR("%s allocating tmp buffer via cprb mempool failed, rc=%d\n",
+			       __func__, rc);
+		return rc;
+	}
 
 	/* ep11 secure key -> protected key + info */
 	rc = _ep11_wrapkey(card, dom, (u8 *)key, keylen,
-			   0, def_iv, wkbuf, &wkbuflen);
+			   0, def_iv, wkbuf, &wkbuflen, xflags);
 	if (rc) {
 		ZCRYPT_DBF_ERR("%s rewrapping ep11 key to pkey failed, rc=%d\n",
 			       __func__, rc);
@@ -1513,7 +1537,7 @@ int ep11_kblob2protkey(u16 card, u16 dom,
 	*protkeylen = wki->pkeysize;
 
 out:
-	kfree(wkbuf);
+	mempool_free(wkbuf, cprb_mempool);
 	return rc;
 }
 EXPORT_SYMBOL(ep11_kblob2protkey);
@@ -1526,6 +1550,7 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 	struct ep11_card_info eci;
 	u32 _nr_apqns = 0;
 	int i, card, dom;
+	const u32 xflags = 0;
 
 	/* occupy the device status memory */
 	mutex_lock(&dev_status_mem_mutex);
@@ -1558,14 +1583,14 @@ int ep11_findcard2(u32 *apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
 			continue;
 		/* check min api version if given */
 		if (minapi > 0) {
-			if (ep11_get_card_info(card, &eci))
+			if (ep11_get_card_info(card, &eci, xflags))
 				continue;
 			if (minapi > eci.API_ord_nr)
 				continue;
 		}
 		/* check wkvp if given */
 		if (wkvp) {
-			if (ep11_get_domain_info(card, dom, &edi))
+			if (ep11_get_domain_info(card, dom, &edi, xflags))
 				continue;
 			if (edi.cur_wk_state != '1')
 				continue;
diff --git a/drivers/s390/crypto/zcrypt_ep11misc.h b/drivers/s390/crypto/zcrypt_ep11misc.h
index 2abd77aa16cf..e875af369caf 100644
--- a/drivers/s390/crypto/zcrypt_ep11misc.h
+++ b/drivers/s390/crypto/zcrypt_ep11misc.h
@@ -104,18 +104,19 @@ struct ep11_domain_info {
 /*
  * Provide information about an EP11 card.
  */
-int ep11_get_card_info(u16 card, struct ep11_card_info *info);
+int ep11_get_card_info(u16 card, struct ep11_card_info *info, u32 xflags);
 
 /*
  * Provide information about a domain within an EP11 card.
  */
-int ep11_get_domain_info(u16 card, u16 domain, struct ep11_domain_info *info);
+int ep11_get_domain_info(u16 card, u16 domain,
+			 struct ep11_domain_info *info, u32 xflags);
 
 /*
  * Generate (random) EP11 AES secure key.
  */
 int ep11_genaeskey(u16 card, u16 domain, u32 keybitsize, u32 keygenflags,
-		   u8 *keybuf, u32 *keybufsize, u32 keybufver);
+		   u8 *keybuf, u32 *keybufsize, u32 keybufver, u32 xflags);
 
 /*
  * Generate EP11 AES secure key with given clear key value.
-- 
2.43.0


