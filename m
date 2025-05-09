Return-Path: <linux-s390+bounces-10515-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E8FAB1084
	for <lists+linux-s390@lfdr.de>; Fri,  9 May 2025 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13BD3B6A67
	for <lists+linux-s390@lfdr.de>; Fri,  9 May 2025 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7900928EA44;
	Fri,  9 May 2025 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f25HfDGl"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573528ECF3;
	Fri,  9 May 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746786261; cv=none; b=oNYxREq6MQCmsUmyccq+mJA3T+ryvdKRhVOSbvhGAsOjkXLGTwJAXfdaqiBMZead5HyspLj6jA3kgUJfka/Nmeju/0sS92kr5LTd1jfCsgR8IZQ9yfszoZSb+ehS4+zuxcKT2iQMcovDY64Uo9OygEj44l/fu+mgYbEhloywW5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746786261; c=relaxed/simple;
	bh=jRzEwHLuEU2q60OAA1bDgvDNs5ry2jxH09UUlWzi7bs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHPBfOQvr4l3mkSfEQUC8Tm2eAW2ruA0HkF2fXsbe+7eFyC6zY8DxVr4K65wFCNRP/CHZCCQamWc18b9weZLOg2HBq6sQP8zSCesAQdALgMkxIuegXe1vHxt4/6XH/ZRZc+ZyNtrTuMU4f+sGqx0VLLob7QRJ69Z7AuqrNLYuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f25HfDGl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BvxA012177;
	Fri, 9 May 2025 10:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xkvNTL9NGNO94iBYD
	9ozRjOwrly8lP34RfMclL3OwoQ=; b=f25HfDGlA41E/z+6TiLltjuXaXS8VRcBy
	GZJXfdRSbMRm90F7P2WaEZFrtf7DnYCnJDsa0/t8vjNinLqflxIFdBxH6oqA3uDo
	NMd/niea+Hvn2h1TAxvmrVWzk0NqY7ZMsaEZIIH0sweeZlS1/ESOtrMl4FVpsLWw
	eUOdOw/zVReRtW9WQI9E6btzEF7iyaxihZgGlzCfRiy3oNHEWKQ8fQYf9BXmgjZZ
	3ZF9SaVr+IxhE+xpil5e+QxJsnPXJMqZm1SX6LJqmIHLC7qpGgs3Zr0N9L3HvBUP
	sR6JM85znNrS594+RjlZO7WSpULziupFD6mX7Mty64uXmGWCg7WQQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h4q8u6h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 10:24:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5499fA0n014137;
	Fri, 9 May 2025 10:24:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm2m2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 10:24:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549AO3qb41484614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 10:24:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E2F20040;
	Fri,  9 May 2025 10:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C23B20043;
	Fri,  9 May 2025 10:24:03 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.111.70.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 10:24:03 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: herbert@gondor.apana.org.au, dengler@linux.ibm.com, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 2/3] s390/crypto: Rework protected key AES for true asynch support
Date: Fri,  9 May 2025 12:24:01 +0200
Message-ID: <20250509102402.27287-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509102402.27287-1-freude@linux.ibm.com>
References: <20250509102402.27287-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N6spF39B c=1 sm=1 tr=0 ts=681dd7c9 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FMNqgE8MKb9_f45wKQsA:9
X-Proofpoint-GUID: QsirKQQW35J8akreofrMv3T3vncCUq3I
X-Proofpoint-ORIG-GUID: QsirKQQW35J8akreofrMv3T3vncCUq3I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA5MiBTYWx0ZWRfX3VQekDoeYRmF 39k+JMsciws8Lxd+3ZLAGIh2KDqetlAU1CFgsqATZbORE8YVMMlLs/26hQ2I+UPppGTl7O35KbE MMlnBEi6S2WkboHUbVVpVGrdG7MOyJqUf1XXAC230Jgiy6vqTyfgwqUInbsDCz/GfUn+tXMHCFg
 4cawEsSpv6Qea5iwRi0odNl6k8C7+W468bk4tFOtvhe5vxQA3dHsbKVDogy0RmaXmmmd4F8z9kP TYQ+u2Of6dlorTH5NAnILam8sgyXoU7ue0ybuV/me2EbtFs9GjMfx/JfiQRy/X/FcWGMrQibkjQ 4mX3DzdVod4m9Y/3GdALU7rDsbAS8K/Tjvlj+KlJ5oATA8A8Dh67M1sFKK1rO+IsdJHthGaAI4E
 iqCv3CjpFcxnvy6X15WOWy37v2jOv2LTBBqZBcayptmGPjiLaGdDUyXCqFB0YhG+K1OzZ7tL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_03,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090092

This is a complete rework of the protected key AES (PAES) implementation.
The goal of this rework is to implement the 4 modes (ecb, cbc, ctr, xts)
in a real asynchronous fashion:
- init(), exit() and setkey() are synchronous and don't allocate any memory.
- the encrypt/decrypt functions first try to do the job in a synchronous
  manner. If this fails, for example the protected key got invalid caused
  by a guest suspend/resume or guest migration action, the encrypt/decrypt
  is transferred to an instance of the crypto engine (see below) for
  asynchronous processing.
  These postponed requests are then handled by the crypto engine by
  invoking the do_one_request() callback but may of course again run into
  a still not converted key or the key is getting invalid. If the key is
  still not converted, the first thread does the conversion and updates
  the key status in the transformation context. The conversion is
  invoked via pkey API with a new flag PKEY_XFLAG_NOMEMALLOC.
  Note that once there is an active requests enqueued to get async
  processed via crypto engine, further requests also need to go via
  crypto engine to keep the request sequence.

This patch together with the pkey/zcrypt/AP extensions to support
the new PKEY_XFLAG_NOMEMMALOC should toughen the paes crypto algorithms
to truly meet the requirements for in-kernel skcipher implementations
and the usage patterns for the dm-crypt and dm-integrity layers.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/crypto/paes_s390.c | 1812 ++++++++++++++++++++++++----------
 1 file changed, 1270 insertions(+), 542 deletions(-)

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 1f62a9460405..596698ce7084 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -5,7 +5,7 @@
  * s390 implementation of the AES Cipher Algorithm with protected keys.
  *
  * s390 Version:
- *   Copyright IBM Corp. 2017, 2023
+ *   Copyright IBM Corp. 2017, 2025
  *   Author(s): Martin Schwidefsky <schwidefsky@de.ibm.com>
  *		Harald Freudenberger <freude@de.ibm.com>
  */
@@ -13,16 +13,18 @@
 #define KMSG_COMPONENT "paes_s390"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <crypto/aes.h>
-#include <crypto/algapi.h>
-#include <linux/bug.h>
-#include <linux/err.h>
-#include <linux/module.h>
+#include <linux/atomic.h>
 #include <linux/cpufeature.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/init.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
-#include <linux/delay.h>
+#include <crypto/aes.h>
+#include <crypto/algapi.h>
+#include <crypto/engine.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/xts.h>
 #include <asm/cpacf.h>
@@ -44,23 +46,61 @@ static DEFINE_MUTEX(ctrblk_lock);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions;
 
+static struct crypto_engine *paes_crypto_engine;
+#define MAX_QLEN 10
+
+/*
+ * protected key specific stuff
+ */
+
 struct paes_protkey {
 	u32 type;
 	u32 len;
 	u8 protkey[PXTS_256_PROTKEY_SIZE];
 };
 
-struct key_blob {
-	/*
-	 * Small keys will be stored in the keybuf. Larger keys are
-	 * stored in extra allocated memory. In both cases does
-	 * key point to the memory where the key is stored.
-	 * The code distinguishes by checking keylen against
-	 * sizeof(keybuf). See the two following helper functions.
-	 */
-	u8 *key;
-	u8 keybuf[128];
+#define PK_STATE_NO_KEY		     0
+#define PK_STATE_CONVERT_IN_PROGRESS 1
+#define PK_STATE_VALID		     2
+
+struct s390_paes_ctx {
+	/* source key material used to derive a protected key from */
+	u8 keybuf[PAES_MAX_KEYSIZE];
+	unsigned int keylen;
+
+	/* cpacf function code to use with this protected key type */
+	long fc;
+
+	/* nr of requests enqueued via crypto engine which use this tfm ctx */
+	atomic_t via_engine_ctr;
+
+	/* spinlock to atomic read/update all the following fields */
+	spinlock_t pk_lock;
+
+	/* see PK_STATE* defines above, < 0 holds convert failure rc  */
+	int pk_state;
+	/* if state is valid, pk holds the protected key */
+	struct paes_protkey pk;
+};
+
+struct s390_pxts_ctx {
+	/* source key material used to derive a protected key from */
+	u8 keybuf[2 * PAES_MAX_KEYSIZE];
 	unsigned int keylen;
+
+	/* cpacf function code to use with this protected key type */
+	long fc;
+
+	/* nr of requests enqueued via crypto engine which use this tfm ctx */
+	atomic_t via_engine_ctr;
+
+	/* spinlock to atomic read/update all the following fields */
+	spinlock_t pk_lock;
+
+	/* see PK_STATE* defines above, < 0 holds convert failure rc  */
+	int pk_state;
+	/* if state is valid, pk[] hold(s) the protected key(s) */
+	struct paes_protkey pk[2];
 };
 
 /*
@@ -89,214 +129,367 @@ static inline u32 make_clrkey_token(const u8 *ck, size_t cklen, u8 *dest)
 	return sizeof(*token) + cklen;
 }
 
-static inline int _key_to_kb(struct key_blob *kb,
-			     const u8 *key,
-			     unsigned int keylen)
+/*
+ * paes_ctx_setkey() - Set key value into context, maybe construct
+ * a clear key token digestable by pkey from a clear key value.
+ */
+static inline int paes_ctx_setkey(struct s390_paes_ctx *ctx,
+				  const u8 *key, unsigned int keylen)
 {
+	if (keylen > sizeof(ctx->keybuf))
+		return -EINVAL;
+
 	switch (keylen) {
 	case 16:
 	case 24:
 	case 32:
 		/* clear key value, prepare pkey clear key token in keybuf */
-		memset(kb->keybuf, 0, sizeof(kb->keybuf));
-		kb->keylen = make_clrkey_token(key, keylen, kb->keybuf);
-		kb->key = kb->keybuf;
+		memset(ctx->keybuf, 0, sizeof(ctx->keybuf));
+		ctx->keylen = make_clrkey_token(key, keylen, ctx->keybuf);
 		break;
 	default:
 		/* other key material, let pkey handle this */
-		if (keylen <= sizeof(kb->keybuf))
-			kb->key = kb->keybuf;
-		else {
-			kb->key = kmalloc(keylen, GFP_KERNEL);
-			if (!kb->key)
-				return -ENOMEM;
-		}
-		memcpy(kb->key, key, keylen);
-		kb->keylen = keylen;
+		memcpy(ctx->keybuf, key, keylen);
+		ctx->keylen = keylen;
 		break;
 	}
 
 	return 0;
 }
 
-static inline int _xts_key_to_kb(struct key_blob *kb,
-				 const u8 *key,
-				 unsigned int keylen)
+/*
+ * pxts_ctx_setkey() - Set key value into context, maybe construct
+ * a clear key token digestable by pkey from a clear key value.
+ */
+static inline int pxts_ctx_setkey(struct s390_pxts_ctx *ctx,
+				  const u8 *key, unsigned int keylen)
 {
 	size_t cklen = keylen / 2;
 
-	memset(kb->keybuf, 0, sizeof(kb->keybuf));
+	if (keylen > sizeof(ctx->keybuf))
+		return -EINVAL;
 
 	switch (keylen) {
 	case 32:
 	case 64:
 		/* clear key value, prepare pkey clear key tokens in keybuf */
-		kb->key = kb->keybuf;
-		kb->keylen  = make_clrkey_token(key, cklen, kb->key);
-		kb->keylen += make_clrkey_token(key + cklen, cklen,
-						kb->key + kb->keylen);
+		memset(ctx->keybuf, 0, sizeof(ctx->keybuf));
+		ctx->keylen = make_clrkey_token(key, cklen, ctx->keybuf);
+		ctx->keylen += make_clrkey_token(key + cklen, cklen,
+						 ctx->keybuf + ctx->keylen);
 		break;
 	default:
 		/* other key material, let pkey handle this */
-		if (keylen <= sizeof(kb->keybuf)) {
-			kb->key = kb->keybuf;
-		} else {
-			kb->key = kmalloc(keylen, GFP_KERNEL);
-			if (!kb->key)
-				return -ENOMEM;
-		}
-		memcpy(kb->key, key, keylen);
-		kb->keylen = keylen;
+		memcpy(ctx->keybuf, key, keylen);
+		ctx->keylen = keylen;
 		break;
 	}
 
 	return 0;
 }
 
-static inline void _free_kb_keybuf(struct key_blob *kb)
+/*
+ * Convert the raw key material into a protected key via PKEY api.
+ * This function may sleep - don't call in non-sleeping context.
+ */
+static inline int convert_key(const u8 *key, unsigned int keylen,
+			      struct paes_protkey *pk)
 {
-	if (kb->key && kb->key != kb->keybuf
-	    && kb->keylen > sizeof(kb->keybuf)) {
-		kfree_sensitive(kb->key);
-		kb->key = NULL;
+	int rc, i;
+
+	pk->len = sizeof(pk->protkey);
+
+	/* try three times in case of busy card */
+	for (rc = -EIO, i = 0; rc && i < 3; i++) {
+		if (rc == -EBUSY && msleep_interruptible((1 << i) * 100)) {
+			rc = -EINTR;
+			goto out;
+		}
+		rc = pkey_key2protkey(key, keylen,
+				      pk->protkey, &pk->len, &pk->type,
+				      PKEY_XFLAG_NOMEMALLOC);
 	}
-	memzero_explicit(kb->keybuf, sizeof(kb->keybuf));
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-struct s390_paes_ctx {
-	struct key_blob kb;
+/*
+ * (Re-)Convert the raw key material from the ctx into a protected key
+ * via convert_key() function. Update the pk_state, pk_type, pk_len
+ * and the protected key in the tfm context.
+ * Please note this function may be invoked concurrently with the very
+ * same tfm context. The pk_lock spinlock in the context ensures an
+ * atomic update of the pk and the pk state but does not guarantee any
+ * order of update. So a fresh converted valid protected key may get
+ * updated with an 'old' expired key value. As the cpacf instructions
+ * detect this, refuse to operate with an invalid key and the calling
+ * code triggers a (re-)conversion this does no harm. This may lead to
+ * unnecessary additional conversion but never to invalid data on en-
+ * or decrypt operations.
+ */
+static int paes_convert_key(struct s390_paes_ctx *ctx)
+{
 	struct paes_protkey pk;
-	spinlock_t pk_lock;
-	unsigned long fc;
-};
+	int rc;
 
-struct s390_pxts_ctx {
-	struct key_blob kb;
-	struct paes_protkey pk[2];
-	spinlock_t pk_lock;
-	unsigned long fc;
-};
+	spin_lock_bh(&ctx->pk_lock);
+	ctx->pk_state = PK_STATE_CONVERT_IN_PROGRESS;
+	spin_unlock_bh(&ctx->pk_lock);
 
-static inline int __paes_keyblob2pkey(const u8 *key, unsigned int keylen,
-				      struct paes_protkey *pk)
-{
-	int i, rc = -EIO;
+	rc = convert_key(ctx->keybuf, ctx->keylen, &pk);
 
-	/* try three times in case of busy card or no mem */
-	for (i = 0; rc && i < 3; i++) {
-		if ((rc == -EBUSY || rc == -ENOMEM) && in_task()) {
-			if (msleep_interruptible(1000))
-				return -EINTR;
-		}
-		rc = pkey_key2protkey(key, keylen, pk->protkey, &pk->len,
-				      &pk->type, PKEY_XFLAG_NOMEMALLOC);
+	/* update context */
+	spin_lock_bh(&ctx->pk_lock);
+	if (rc) {
+		ctx->pk_state = rc;
+	} else {
+		ctx->pk_state = PK_STATE_VALID;
+		ctx->pk = pk;
 	}
+	spin_unlock_bh(&ctx->pk_lock);
 
+	memzero_explicit(&pk, sizeof(pk));
+	pr_debug("rc=%d\n", rc);
 	return rc;
 }
 
-static inline int __paes_convert_key(struct s390_paes_ctx *ctx)
+/*
+ * (Re-)Convert the raw xts key material from the ctx into a
+ * protected key via convert_key() function. Update the pk_state,
+ * pk_type, pk_len and the protected key in the tfm context.
+ * See also comments on function paes_convert_key.
+ */
+static int pxts_convert_key(struct s390_pxts_ctx *ctx)
 {
-	struct paes_protkey pk;
+	struct paes_protkey pk0, pk1;
+	size_t split_keylen;
 	int rc;
 
-	pk.len = sizeof(pk.protkey);
-	rc = __paes_keyblob2pkey(ctx->kb.key, ctx->kb.keylen, &pk);
+	spin_lock_bh(&ctx->pk_lock);
+	ctx->pk_state = PK_STATE_CONVERT_IN_PROGRESS;
+	spin_unlock_bh(&ctx->pk_lock);
+
+	rc = convert_key(ctx->keybuf, ctx->keylen, &pk0);
 	if (rc)
-		return rc;
+		goto out;
+
+	switch (pk0.type) {
+	case PKEY_KEYTYPE_AES_128:
+	case PKEY_KEYTYPE_AES_256:
+		/* second keytoken required */
+		if (ctx->keylen % 2) {
+			rc = -EINVAL;
+			goto out;
+		}
+		split_keylen = ctx->keylen / 2;
+		rc = convert_key(ctx->keybuf + split_keylen,
+				 split_keylen, &pk1);
+		if (rc)
+			goto out;
+		if (pk0.type != pk1.type) {
+			rc = -EINVAL;
+			goto out;
+		}
+		break;
+	case PKEY_KEYTYPE_AES_XTS_128:
+	case PKEY_KEYTYPE_AES_XTS_256:
+		/* single key */
+		pk1.type = 0;
+		break;
+	default:
+		/* unsupported protected keytype */
+		rc = -EINVAL;
+		goto out;
+	}
 
+out:
+	/* update context */
 	spin_lock_bh(&ctx->pk_lock);
-	memcpy(&ctx->pk, &pk, sizeof(pk));
+	if (rc) {
+		ctx->pk_state = rc;
+	} else {
+		ctx->pk_state = PK_STATE_VALID;
+		ctx->pk[0] = pk0;
+		ctx->pk[1] = pk1;
+	}
 	spin_unlock_bh(&ctx->pk_lock);
 
-	return 0;
+	memzero_explicit(&pk0, sizeof(pk0));
+	memzero_explicit(&pk1, sizeof(pk1));
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int ecb_paes_init(struct crypto_skcipher *tfm)
-{
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+/*
+ * PAES ECB implementation
+ */
 
-	ctx->kb.key = NULL;
-	spin_lock_init(&ctx->pk_lock);
+struct ecb_param {
+	u8 key[PAES_256_PROTKEY_SIZE];
+} __packed;
 
-	return 0;
-}
+struct s390_pecb_req_ctx {
+	unsigned long modifier;
+	struct skcipher_walk walk;
+	bool param_init_done;
+	struct ecb_param param;
+};
 
-static void ecb_paes_exit(struct crypto_skcipher *tfm)
+static int ecb_paes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+			   unsigned int key_len)
 {
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-
-	_free_kb_keybuf(&ctx->kb);
-}
-
-static inline int __ecb_paes_set_key(struct s390_paes_ctx *ctx)
-{
-	unsigned long fc;
+	long fc;
 	int rc;
 
-	rc = __paes_convert_key(ctx);
+	/* set raw key into context */
+	rc = paes_ctx_setkey(ctx, in_key, key_len);
 	if (rc)
-		return rc;
+		goto out;
 
-	/* Pick the correct function code based on the protected key type */
-	fc = (ctx->pk.type == PKEY_KEYTYPE_AES_128) ? CPACF_KM_PAES_128 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_192) ? CPACF_KM_PAES_192 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_256) ? CPACF_KM_PAES_256 : 0;
+	/* convert key into protected key */
+	rc = paes_convert_key(ctx);
+	if (rc)
+		goto out;
 
-	/* Check if the function code is available */
+	/* Pick the correct function code based on the protected key type */
+	switch (ctx->pk.type) {
+	case PKEY_KEYTYPE_AES_128:
+		fc = CPACF_KM_PAES_128;
+		break;
+	case PKEY_KEYTYPE_AES_192:
+		fc = CPACF_KM_PAES_192;
+		break;
+	case PKEY_KEYTYPE_AES_256:
+		fc = CPACF_KM_PAES_256;
+		break;
+	default:
+		fc = 0;
+		break;
+	}
 	ctx->fc = (fc && cpacf_test_func(&km_functions, fc)) ? fc : 0;
 
-	return ctx->fc ? 0 : -EINVAL;
+	rc = fc ? 0 : -EINVAL;
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int ecb_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
-			    unsigned int key_len)
+static int ecb_paes_do_crypt(struct s390_paes_ctx *ctx,
+			     struct s390_pecb_req_ctx *req_ctx,
+			     bool maysleep)
 {
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int rc;
-
-	_free_kb_keybuf(&ctx->kb);
-	rc = _key_to_kb(&ctx->kb, in_key, key_len);
+	struct ecb_param *param = &req_ctx->param;
+	struct skcipher_walk *walk = &req_ctx->walk;
+	unsigned int nbytes, n, k;
+	int pk_state, rc = 0;
+
+	if (!req_ctx->param_init_done) {
+		/* fetch and check protected key state */
+		spin_lock_bh(&ctx->pk_lock);
+		pk_state = ctx->pk_state;
+		switch (pk_state) {
+		case PK_STATE_NO_KEY:
+			rc = -ENOKEY;
+			break;
+		case PK_STATE_CONVERT_IN_PROGRESS:
+			rc = -EKEYEXPIRED;
+			break;
+		case PK_STATE_VALID:
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			req_ctx->param_init_done = true;
+			break;
+		default:
+			rc = pk_state < 0 ? pk_state : -EIO;
+			break;
+		}
+		spin_unlock_bh(&ctx->pk_lock);
+	}
 	if (rc)
-		return rc;
+		goto out;
+
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) != 0) {
+		/* only use complete blocks */
+		n = nbytes & ~(AES_BLOCK_SIZE - 1);
+		k = cpacf_km(ctx->fc | req_ctx->modifier, param,
+			     walk->dst.virt.addr, walk->src.virt.addr, n);
+		if (k)
+			rc = skcipher_walk_done(walk, nbytes - k);
+		if (k < n) {
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = paes_convert_key(ctx);
+			if (rc)
+				goto out;
+			spin_lock_bh(&ctx->pk_lock);
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			spin_unlock_bh(&ctx->pk_lock);
+		}
+	}
 
-	return __ecb_paes_set_key(ctx);
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
 static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 {
+	struct s390_pecb_req_ctx *req_ctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct {
-		u8 key[PAES_256_PROTKEY_SIZE];
-	} param;
-	struct skcipher_walk walk;
-	unsigned int nbytes, n, k;
+	struct skcipher_walk *walk = &req_ctx->walk;
 	int rc;
 
-	rc = skcipher_walk_virt(&walk, req, false);
+	/*
+	 * Attempt synchronous encryption first. If it fails, schedule the request
+	 * asynchronously via the crypto engine. To preserve execution order,
+	 * once a request is queued to the engine, further requests using the same
+	 * tfm will also be routed through the engine.
+	 */
+
+	rc = skcipher_walk_virt(walk, req, false);
 	if (rc)
-		return rc;
+		goto out;
 
-	spin_lock_bh(&ctx->pk_lock);
-	memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-	spin_unlock_bh(&ctx->pk_lock);
+	req_ctx->modifier = modifier;
+	req_ctx->param_init_done = false;
 
-	while ((nbytes = walk.nbytes) != 0) {
-		/* only use complete blocks */
-		n = nbytes & ~(AES_BLOCK_SIZE - 1);
-		k = cpacf_km(ctx->fc | modifier, &param,
-			     walk.dst.virt.addr, walk.src.virt.addr, n);
-		if (k)
-			rc = skcipher_walk_done(&walk, nbytes - k);
-		if (k < n) {
-			if (__paes_convert_key(ctx))
-				return skcipher_walk_done(&walk, -EIO);
-			spin_lock_bh(&ctx->pk_lock);
-			memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-			spin_unlock_bh(&ctx->pk_lock);
-		}
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&ctx->via_engine_ctr)) {
+		rc = ecb_paes_do_crypt(ctx, req_ctx, false);
+		if (rc == 0)
+			goto out;
+	}
+
+	/*
+	 * If sync operation failed or key expired or there are already
+	 * requests enqueued via engine, fallback to async. Mark tfm as
+	 * using engine to serialize requests.
+	 */
+	if (rc == 0 || rc == -EKEYEXPIRED) {
+		atomic_inc(&ctx->via_engine_ctr);
+		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&ctx->via_engine_ctr);
 	}
+
+	if (rc != -EINPROGRESS)
+		skcipher_walk_done(walk, rc);
+
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("rc=%d\n", rc);
 	return rc;
 }
 
@@ -310,112 +503,256 @@ static int ecb_paes_decrypt(struct skcipher_request *req)
 	return ecb_paes_crypt(req, CPACF_DECRYPT);
 }
 
-static struct skcipher_alg ecb_paes_alg = {
-	.base.cra_name		=	"ecb(paes)",
-	.base.cra_driver_name	=	"ecb-paes-s390",
-	.base.cra_priority	=	401,	/* combo: aes + ecb + 1 */
-	.base.cra_blocksize	=	AES_BLOCK_SIZE,
-	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
-	.base.cra_module	=	THIS_MODULE,
-	.base.cra_list		=	LIST_HEAD_INIT(ecb_paes_alg.base.cra_list),
-	.init			=	ecb_paes_init,
-	.exit			=	ecb_paes_exit,
-	.min_keysize		=	PAES_MIN_KEYSIZE,
-	.max_keysize		=	PAES_MAX_KEYSIZE,
-	.setkey			=	ecb_paes_set_key,
-	.encrypt		=	ecb_paes_encrypt,
-	.decrypt		=	ecb_paes_decrypt,
-};
-
-static int cbc_paes_init(struct crypto_skcipher *tfm)
+static int ecb_paes_init(struct crypto_skcipher *tfm)
 {
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	ctx->kb.key = NULL;
+	memset(ctx, 0, sizeof(*ctx));
 	spin_lock_init(&ctx->pk_lock);
 
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct s390_pecb_req_ctx));
+
 	return 0;
 }
 
-static void cbc_paes_exit(struct crypto_skcipher *tfm)
+static void ecb_paes_exit(struct crypto_skcipher *tfm)
 {
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	_free_kb_keybuf(&ctx->kb);
+	memzero_explicit(ctx, sizeof(*ctx));
 }
 
-static inline int __cbc_paes_set_key(struct s390_paes_ctx *ctx)
+static int ecb_paes_do_one_request(struct crypto_engine *engine, void *areq)
 {
-	unsigned long fc;
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct s390_pecb_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
 	int rc;
 
-	rc = __paes_convert_key(ctx);
-	if (rc)
-		return rc;
+	/* walk has already been prepared */
+
+	rc = ecb_paes_do_crypt(ctx, req_ctx, true);
+	if (rc == -EKEYEXPIRED) {
+		/*
+		 * Protected key expired, conversion is in process.
+		 * Trigger a re-schedule of this request by returning
+		 * -ENOSPC ("hardware queue is full") to the crypto engine.
+		 * To avoid immediately re-invocation of this callback,
+		 * tell the scheduler to voluntarily give up the CPU here.
+		 */
+		cond_resched();
+		pr_debug("rescheduling request\n");
+		return -ENOSPC;
+	} else if (rc) {
+		skcipher_walk_done(walk, rc);
+	}
 
-	/* Pick the correct function code based on the protected key type */
-	fc = (ctx->pk.type == PKEY_KEYTYPE_AES_128) ? CPACF_KMC_PAES_128 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_192) ? CPACF_KMC_PAES_192 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_256) ? CPACF_KMC_PAES_256 : 0;
+	memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("request complete with rc=%d\n", rc);
+	local_bh_disable();
+	atomic_dec(&ctx->via_engine_ctr);
+	crypto_finalize_skcipher_request(engine, req, rc);
+	local_bh_enable();
+	return rc;
+}
 
-	/* Check if the function code is available */
-	ctx->fc = (fc && cpacf_test_func(&kmc_functions, fc)) ? fc : 0;
+static struct skcipher_engine_alg ecb_paes_alg = {
+	.base = {
+		.base.cra_name	      = "ecb(paes)",
+		.base.cra_driver_name = "ecb-paes-s390",
+		.base.cra_priority    = 401,	/* combo: aes + ecb + 1 */
+		.base.cra_blocksize   = AES_BLOCK_SIZE,
+		.base.cra_ctxsize     = sizeof(struct s390_paes_ctx),
+		.base.cra_module      = THIS_MODULE,
+		.base.cra_list	      = LIST_HEAD_INIT(ecb_paes_alg.base.base.cra_list),
+		.init		      = ecb_paes_init,
+		.exit		      = ecb_paes_exit,
+		.min_keysize	      = PAES_MIN_KEYSIZE,
+		.max_keysize	      = PAES_MAX_KEYSIZE,
+		.setkey		      = ecb_paes_setkey,
+		.encrypt	      = ecb_paes_encrypt,
+		.decrypt	      = ecb_paes_decrypt,
+	},
+	.op = {
+		.do_one_request	      = ecb_paes_do_one_request,
+	},
+};
 
-	return ctx->fc ? 0 : -EINVAL;
-}
+/*
+ * PAES CBC implementation
+ */
+
+struct cbc_param {
+	u8 iv[AES_BLOCK_SIZE];
+	u8 key[PAES_256_PROTKEY_SIZE];
+} __packed;
+
+struct s390_pcbc_req_ctx {
+	unsigned long modifier;
+	struct skcipher_walk walk;
+	bool param_init_done;
+	struct cbc_param param;
+};
 
-static int cbc_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
-			    unsigned int key_len)
+static int cbc_paes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+			   unsigned int key_len)
 {
 	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	long fc;
 	int rc;
 
-	_free_kb_keybuf(&ctx->kb);
-	rc = _key_to_kb(&ctx->kb, in_key, key_len);
+	/* set raw key into context */
+	rc = paes_ctx_setkey(ctx, in_key, key_len);
 	if (rc)
-		return rc;
+		goto out;
+
+	/* convert raw key into protected key */
+	rc = paes_convert_key(ctx);
+	if (rc)
+		goto out;
+
+	/* Pick the correct function code based on the protected key type */
+	switch (ctx->pk.type) {
+	case PKEY_KEYTYPE_AES_128:
+		fc = CPACF_KMC_PAES_128;
+		break;
+	case PKEY_KEYTYPE_AES_192:
+		fc = CPACF_KMC_PAES_192;
+		break;
+	case PKEY_KEYTYPE_AES_256:
+		fc = CPACF_KMC_PAES_256;
+		break;
+	default:
+		fc = 0;
+		break;
+	}
+	ctx->fc = (fc && cpacf_test_func(&kmc_functions, fc)) ? fc : 0;
+
+	rc = fc ? 0 : -EINVAL;
 
-	return __cbc_paes_set_key(ctx);
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
+static int cbc_paes_do_crypt(struct s390_paes_ctx *ctx,
+			     struct s390_pcbc_req_ctx *req_ctx,
+			     bool maysleep)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct {
-		u8 iv[AES_BLOCK_SIZE];
-		u8 key[PAES_256_PROTKEY_SIZE];
-	} param;
-	struct skcipher_walk walk;
+	struct cbc_param *param = &req_ctx->param;
+	struct skcipher_walk *walk = &req_ctx->walk;
 	unsigned int nbytes, n, k;
-	int rc;
-
-	rc = skcipher_walk_virt(&walk, req, false);
+	int pk_state, rc = 0;
+
+	if (!req_ctx->param_init_done) {
+		/* fetch and check protected key state */
+		spin_lock_bh(&ctx->pk_lock);
+		pk_state = ctx->pk_state;
+		switch (pk_state) {
+		case PK_STATE_NO_KEY:
+			rc = -ENOKEY;
+			break;
+		case PK_STATE_CONVERT_IN_PROGRESS:
+			rc = -EKEYEXPIRED;
+			break;
+		case PK_STATE_VALID:
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			req_ctx->param_init_done = true;
+			break;
+		default:
+			rc = pk_state < 0 ? pk_state : -EIO;
+			break;
+		}
+		spin_unlock_bh(&ctx->pk_lock);
+	}
 	if (rc)
-		return rc;
+		goto out;
 
-	memcpy(param.iv, walk.iv, AES_BLOCK_SIZE);
-	spin_lock_bh(&ctx->pk_lock);
-	memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-	spin_unlock_bh(&ctx->pk_lock);
+	memcpy(param->iv, walk->iv, AES_BLOCK_SIZE);
 
-	while ((nbytes = walk.nbytes) != 0) {
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) != 0) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
-		k = cpacf_kmc(ctx->fc | modifier, &param,
-			      walk.dst.virt.addr, walk.src.virt.addr, n);
+		k = cpacf_kmc(ctx->fc | req_ctx->modifier, param,
+			      walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k) {
-			memcpy(walk.iv, param.iv, AES_BLOCK_SIZE);
-			rc = skcipher_walk_done(&walk, nbytes - k);
+			memcpy(walk->iv, param->iv, AES_BLOCK_SIZE);
+			rc = skcipher_walk_done(walk, nbytes - k);
 		}
 		if (k < n) {
-			if (__paes_convert_key(ctx))
-				return skcipher_walk_done(&walk, -EIO);
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = paes_convert_key(ctx);
+			if (rc)
+				goto out;
 			spin_lock_bh(&ctx->pk_lock);
-			memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
 			spin_unlock_bh(&ctx->pk_lock);
 		}
 	}
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
+{
+	struct s390_pcbc_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
+	int rc;
+
+	/*
+	 * Attempt synchronous encryption first. If it fails, schedule the request
+	 * asynchronously via the crypto engine. To preserve execution order,
+	 * once a request is queued to the engine, further requests using the same
+	 * tfm will also be routed through the engine.
+	 */
+
+	rc = skcipher_walk_virt(walk, req, false);
+	if (rc)
+		goto out;
+
+	req_ctx->modifier = modifier;
+	req_ctx->param_init_done = false;
+
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&ctx->via_engine_ctr)) {
+		rc = cbc_paes_do_crypt(ctx, req_ctx, false);
+		if (rc == 0)
+			goto out;
+	}
+
+	/*
+	 * If sync operation failed or key expired or there are already
+	 * requests enqueued via engine, fallback to async. Mark tfm as
+	 * using engine to serialize requests.
+	 */
+	if (rc == 0 || rc == -EKEYEXPIRED) {
+		atomic_inc(&ctx->via_engine_ctr);
+		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&ctx->via_engine_ctr);
+	}
+
+	if (rc != -EINPROGRESS)
+		skcipher_walk_done(walk, rc);
+
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("rc=%d\n", rc);
 	return rc;
 }
 
@@ -429,496 +766,882 @@ static int cbc_paes_decrypt(struct skcipher_request *req)
 	return cbc_paes_crypt(req, CPACF_DECRYPT);
 }
 
-static struct skcipher_alg cbc_paes_alg = {
-	.base.cra_name		=	"cbc(paes)",
-	.base.cra_driver_name	=	"cbc-paes-s390",
-	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
-	.base.cra_blocksize	=	AES_BLOCK_SIZE,
-	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
-	.base.cra_module	=	THIS_MODULE,
-	.base.cra_list		=	LIST_HEAD_INIT(cbc_paes_alg.base.cra_list),
-	.init			=	cbc_paes_init,
-	.exit			=	cbc_paes_exit,
-	.min_keysize		=	PAES_MIN_KEYSIZE,
-	.max_keysize		=	PAES_MAX_KEYSIZE,
-	.ivsize			=	AES_BLOCK_SIZE,
-	.setkey			=	cbc_paes_set_key,
-	.encrypt		=	cbc_paes_encrypt,
-	.decrypt		=	cbc_paes_decrypt,
-};
-
-static int xts_paes_init(struct crypto_skcipher *tfm)
+static int cbc_paes_init(struct crypto_skcipher *tfm)
 {
-	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	ctx->kb.key = NULL;
+	memset(ctx, 0, sizeof(*ctx));
 	spin_lock_init(&ctx->pk_lock);
 
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct s390_pcbc_req_ctx));
+
 	return 0;
 }
 
-static void xts_paes_exit(struct crypto_skcipher *tfm)
+static void cbc_paes_exit(struct crypto_skcipher *tfm)
 {
-	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	_free_kb_keybuf(&ctx->kb);
+	memzero_explicit(ctx, sizeof(*ctx));
 }
 
-static inline int __xts_paes_convert_key(struct s390_pxts_ctx *ctx)
+static int cbc_paes_do_one_request(struct crypto_engine *engine, void *areq)
 {
-	struct paes_protkey pk0, pk1;
-	size_t split_keylen;
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct s390_pcbc_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
 	int rc;
 
-	pk0.len = sizeof(pk0.protkey);
-	pk1.len = sizeof(pk1.protkey);
-
-	rc = __paes_keyblob2pkey(ctx->kb.key, ctx->kb.keylen, &pk0);
-	if (rc)
-		return rc;
+	/* walk has already been prepared */
+
+	rc = cbc_paes_do_crypt(ctx, req_ctx, true);
+	if (rc == -EKEYEXPIRED) {
+		/*
+		 * Protected key expired, conversion is in process.
+		 * Trigger a re-schedule of this request by returning
+		 * -ENOSPC ("hardware queue is full") to the crypto engine.
+		 * To avoid immediately re-invocation of this callback,
+		 * tell the scheduler to voluntarily give up the CPU here.
+		 */
+		cond_resched();
+		pr_debug("rescheduling request\n");
+		return -ENOSPC;
+	} else if (rc) {
+		skcipher_walk_done(walk, rc);
+	}
 
-	switch (pk0.type) {
-	case PKEY_KEYTYPE_AES_128:
-	case PKEY_KEYTYPE_AES_256:
-		/* second keytoken required */
-		if (ctx->kb.keylen % 2)
-			return -EINVAL;
-		split_keylen = ctx->kb.keylen / 2;
+	memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("request complete with rc=%d\n", rc);
+	local_bh_disable();
+	atomic_dec(&ctx->via_engine_ctr);
+	crypto_finalize_skcipher_request(engine, req, rc);
+	local_bh_enable();
+	return rc;
+}
 
-		rc = __paes_keyblob2pkey(ctx->kb.key + split_keylen,
-					 split_keylen, &pk1);
-		if (rc)
-			return rc;
+static struct skcipher_engine_alg cbc_paes_alg = {
+	.base = {
+		.base.cra_name	      = "cbc(paes)",
+		.base.cra_driver_name = "cbc-paes-s390",
+		.base.cra_priority    = 402,	/* cbc-paes-s390 + 1 */
+		.base.cra_blocksize   = AES_BLOCK_SIZE,
+		.base.cra_ctxsize     = sizeof(struct s390_paes_ctx),
+		.base.cra_module      = THIS_MODULE,
+		.base.cra_list	      = LIST_HEAD_INIT(cbc_paes_alg.base.base.cra_list),
+		.init		      = cbc_paes_init,
+		.exit		      = cbc_paes_exit,
+		.min_keysize	      = PAES_MIN_KEYSIZE,
+		.max_keysize	      = PAES_MAX_KEYSIZE,
+		.ivsize		      = AES_BLOCK_SIZE,
+		.setkey		      = cbc_paes_setkey,
+		.encrypt	      = cbc_paes_encrypt,
+		.decrypt	      = cbc_paes_decrypt,
+	},
+	.op = {
+		.do_one_request	      = cbc_paes_do_one_request,
+	},
+};
 
-		if (pk0.type != pk1.type)
-			return -EINVAL;
-		break;
-	case PKEY_KEYTYPE_AES_XTS_128:
-	case PKEY_KEYTYPE_AES_XTS_256:
-		/* single key */
-		pk1.type = 0;
-		break;
-	default:
-		/* unsupported protected keytype */
-		return -EINVAL;
-	}
+/*
+ * PAES CTR implementation
+ */
 
-	spin_lock_bh(&ctx->pk_lock);
-	ctx->pk[0] = pk0;
-	ctx->pk[1] = pk1;
-	spin_unlock_bh(&ctx->pk_lock);
+struct ctr_param {
+	u8 key[PAES_256_PROTKEY_SIZE];
+} __packed;
 
-	return 0;
-}
+struct s390_pctr_req_ctx {
+	unsigned long modifier;
+	struct skcipher_walk walk;
+	bool param_init_done;
+	struct ctr_param param;
+};
 
-static inline int __xts_paes_set_key(struct s390_pxts_ctx *ctx)
+static int ctr_paes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+			   unsigned int key_len)
 {
-	unsigned long fc;
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	long fc;
 	int rc;
 
-	rc = __xts_paes_convert_key(ctx);
+	/* set raw key into context */
+	rc = paes_ctx_setkey(ctx, in_key, key_len);
 	if (rc)
-		return rc;
+		goto out;
+
+	/* convert raw key into protected key */
+	rc = paes_convert_key(ctx);
+	if (rc)
+		goto out;
 
 	/* Pick the correct function code based on the protected key type */
-	switch (ctx->pk[0].type) {
+	switch (ctx->pk.type) {
 	case PKEY_KEYTYPE_AES_128:
-		fc = CPACF_KM_PXTS_128;
+		fc = CPACF_KMCTR_PAES_128;
 		break;
-	case PKEY_KEYTYPE_AES_256:
-		fc = CPACF_KM_PXTS_256;
-		break;
-	case PKEY_KEYTYPE_AES_XTS_128:
-		fc = CPACF_KM_PXTS_128_FULL;
+	case PKEY_KEYTYPE_AES_192:
+		fc = CPACF_KMCTR_PAES_192;
 		break;
-	case PKEY_KEYTYPE_AES_XTS_256:
-		fc = CPACF_KM_PXTS_256_FULL;
+	case PKEY_KEYTYPE_AES_256:
+		fc = CPACF_KMCTR_PAES_256;
 		break;
 	default:
 		fc = 0;
 		break;
 	}
+	ctx->fc = (fc && cpacf_test_func(&kmctr_functions, fc)) ? fc : 0;
 
-	/* Check if the function code is available */
-	ctx->fc = (fc && cpacf_test_func(&km_functions, fc)) ? fc : 0;
+	rc = fc ? 0 : -EINVAL;
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static inline unsigned int __ctrblk_init(u8 *ctrptr, u8 *iv, unsigned int nbytes)
+{
+	unsigned int i, n;
+
+	/* only use complete blocks, max. PAGE_SIZE */
+	memcpy(ctrptr, iv, AES_BLOCK_SIZE);
+	n = (nbytes > PAGE_SIZE) ? PAGE_SIZE : nbytes & ~(AES_BLOCK_SIZE - 1);
+	for (i = (n / AES_BLOCK_SIZE) - 1; i > 0; i--) {
+		memcpy(ctrptr + AES_BLOCK_SIZE, ctrptr, AES_BLOCK_SIZE);
+		crypto_inc(ctrptr + AES_BLOCK_SIZE, AES_BLOCK_SIZE);
+		ctrptr += AES_BLOCK_SIZE;
+	}
+	return n;
+}
+
+static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
+			     struct s390_pctr_req_ctx *req_ctx,
+			     bool maysleep)
+{
+	struct ctr_param *param = &req_ctx->param;
+	struct skcipher_walk *walk = &req_ctx->walk;
+	u8 buf[AES_BLOCK_SIZE], *ctrptr;
+	unsigned int nbytes, n, k;
+	int pk_state, locked, rc = 0;
+
+	if (!req_ctx->param_init_done) {
+		/* fetch and check protected key state */
+		spin_lock_bh(&ctx->pk_lock);
+		pk_state = ctx->pk_state;
+		switch (pk_state) {
+		case PK_STATE_NO_KEY:
+			rc = -ENOKEY;
+			break;
+		case PK_STATE_CONVERT_IN_PROGRESS:
+			rc = -EKEYEXPIRED;
+			break;
+		case PK_STATE_VALID:
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			req_ctx->param_init_done = true;
+			break;
+		default:
+			rc = pk_state < 0 ? pk_state : -EIO;
+			break;
+		}
+		spin_unlock_bh(&ctx->pk_lock);
+	}
+	if (rc)
+		goto out;
+
+	locked = mutex_trylock(&ctrblk_lock);
+
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
+		n = AES_BLOCK_SIZE;
+		if (nbytes >= 2 * AES_BLOCK_SIZE && locked)
+			n = __ctrblk_init(ctrblk, walk->iv, nbytes);
+		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;
+		k = cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
+				walk->src.virt.addr, n, ctrptr);
+		if (k) {
+			if (ctrptr == ctrblk)
+				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
+				       AES_BLOCK_SIZE);
+			crypto_inc(walk->iv, AES_BLOCK_SIZE);
+			rc = skcipher_walk_done(walk, nbytes - k);
+		}
+		if (k < n) {
+			if (!maysleep) {
+				if (locked)
+					mutex_unlock(&ctrblk_lock);
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = paes_convert_key(ctx);
+			if (rc) {
+				if (locked)
+					mutex_unlock(&ctrblk_lock);
+				goto out;
+			}
+			spin_lock_bh(&ctx->pk_lock);
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			spin_unlock_bh(&ctx->pk_lock);
+		}
+	}
+	if (locked)
+		mutex_unlock(&ctrblk_lock);
+
+	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
+	if (nbytes) {
+		memset(buf, 0, AES_BLOCK_SIZE);
+		memcpy(buf, walk->src.virt.addr, nbytes);
+		while (1) {
+			if (cpacf_kmctr(ctx->fc, param, buf,
+					buf, AES_BLOCK_SIZE,
+					walk->iv) == AES_BLOCK_SIZE)
+				break;
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = paes_convert_key(ctx);
+			if (rc)
+				goto out;
+			spin_lock_bh(&ctx->pk_lock);
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			spin_unlock_bh(&ctx->pk_lock);
+		}
+		memcpy(walk->dst.virt.addr, buf, nbytes);
+		crypto_inc(walk->iv, AES_BLOCK_SIZE);
+		rc = skcipher_walk_done(walk, 0);
+	}
 
-	return ctx->fc ? 0 : -EINVAL;
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int xts_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
-			    unsigned int in_keylen)
+static int ctr_paes_crypt(struct skcipher_request *req)
+{
+	struct s390_pctr_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
+	int rc;
+
+	/*
+	 * Attempt synchronous encryption first. If it fails, schedule the request
+	 * asynchronously via the crypto engine. To preserve execution order,
+	 * once a request is queued to the engine, further requests using the same
+	 * tfm will also be routed through the engine.
+	 */
+
+	rc = skcipher_walk_virt(walk, req, false);
+	if (rc)
+		goto out;
+
+	req_ctx->param_init_done = false;
+
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&ctx->via_engine_ctr)) {
+		rc = ctr_paes_do_crypt(ctx, req_ctx, false);
+		if (rc == 0)
+			goto out;
+	}
+
+	/*
+	 * If sync operation failed or key expired or there are already
+	 * requests enqueued via engine, fallback to async. Mark tfm as
+	 * using engine to serialize requests.
+	 */
+	if (rc == 0 || rc == -EKEYEXPIRED) {
+		atomic_inc(&ctx->via_engine_ctr);
+		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&ctx->via_engine_ctr);
+	}
+
+	if (rc != -EINPROGRESS)
+		skcipher_walk_done(walk, rc);
+
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int ctr_paes_init(struct crypto_skcipher *tfm)
+{
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memset(ctx, 0, sizeof(*ctx));
+	spin_lock_init(&ctx->pk_lock);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct s390_pctr_req_ctx));
+
+	return 0;
+}
+
+static void ctr_paes_exit(struct crypto_skcipher *tfm)
+{
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+
+static int ctr_paes_do_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct s390_pctr_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
+	int rc;
+
+	/* walk has already been prepared */
+
+	rc = ctr_paes_do_crypt(ctx, req_ctx, true);
+	if (rc == -EKEYEXPIRED) {
+		/*
+		 * Protected key expired, conversion is in process.
+		 * Trigger a re-schedule of this request by returning
+		 * -ENOSPC ("hardware queue is full") to the crypto engine.
+		 * To avoid immediately re-invocation of this callback,
+		 * tell the scheduler to voluntarily give up the CPU here.
+		 */
+		cond_resched();
+		pr_debug("rescheduling request\n");
+		return -ENOSPC;
+	} else if (rc) {
+		skcipher_walk_done(walk, rc);
+	}
+
+	memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("request complete with rc=%d\n", rc);
+	local_bh_disable();
+	atomic_dec(&ctx->via_engine_ctr);
+	crypto_finalize_skcipher_request(engine, req, rc);
+	local_bh_enable();
+	return rc;
+}
+
+static struct skcipher_engine_alg ctr_paes_alg = {
+	.base = {
+		.base.cra_name	      =	"ctr(paes)",
+		.base.cra_driver_name =	"ctr-paes-s390",
+		.base.cra_priority    =	402,	/* ecb-paes-s390 + 1 */
+		.base.cra_blocksize   =	1,
+		.base.cra_ctxsize     =	sizeof(struct s390_paes_ctx),
+		.base.cra_module      =	THIS_MODULE,
+		.base.cra_list	      =	LIST_HEAD_INIT(ctr_paes_alg.base.base.cra_list),
+		.init		      =	ctr_paes_init,
+		.exit		      =	ctr_paes_exit,
+		.min_keysize	      =	PAES_MIN_KEYSIZE,
+		.max_keysize	      =	PAES_MAX_KEYSIZE,
+		.ivsize		      =	AES_BLOCK_SIZE,
+		.setkey		      =	ctr_paes_setkey,
+		.encrypt	      =	ctr_paes_crypt,
+		.decrypt	      =	ctr_paes_crypt,
+		.chunksize	      =	AES_BLOCK_SIZE,
+	},
+	.op = {
+		.do_one_request	      = ctr_paes_do_one_request,
+	},
+};
+
+/*
+ * PAES XTS implementation
+ */
+
+struct xts_full_km_param {
+	u8 key[64];
+	u8 tweak[16];
+	u8 nap[16];
+	u8 wkvp[32];
+} __packed;
+
+struct xts_km_param {
+	u8 key[PAES_256_PROTKEY_SIZE];
+	u8 init[16];
+} __packed;
+
+struct xts_pcc_param {
+	u8 key[PAES_256_PROTKEY_SIZE];
+	u8 tweak[16];
+	u8 block[16];
+	u8 bit[16];
+	u8 xts[16];
+} __packed;
+
+struct s390_pxts_req_ctx {
+	unsigned long modifier;
+	struct skcipher_walk walk;
+	bool param_init_done;
+	union {
+		struct xts_full_km_param full_km_param;
+		struct xts_km_param km_param;
+	} param;
+};
+
+static int xts_paes_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
+			   unsigned int in_keylen)
 {
 	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
 	u8 ckey[2 * AES_MAX_KEY_SIZE];
 	unsigned int ckey_len;
+	long fc;
 	int rc;
 
 	if ((in_keylen == 32 || in_keylen == 64) &&
 	    xts_verify_key(tfm, in_key, in_keylen))
 		return -EINVAL;
 
-	_free_kb_keybuf(&ctx->kb);
-	rc = _xts_key_to_kb(&ctx->kb, in_key, in_keylen);
+	/* set raw key into context */
+	rc = pxts_ctx_setkey(ctx, in_key, in_keylen);
 	if (rc)
-		return rc;
+		goto out;
 
-	rc = __xts_paes_set_key(ctx);
+	/* convert raw key(s) into protected key(s) */
+	rc = pxts_convert_key(ctx);
 	if (rc)
-		return rc;
+		goto out;
 
-	/*
-	 * It is not possible on a single protected key (e.g. full AES-XTS) to
-	 * check, if k1 and k2 are the same.
-	 */
-	if (ctx->pk[0].type == PKEY_KEYTYPE_AES_XTS_128 ||
-	    ctx->pk[0].type == PKEY_KEYTYPE_AES_XTS_256)
-		return 0;
 	/*
 	 * xts_verify_key verifies the key length is not odd and makes
 	 * sure that the two keys are not the same. This can be done
-	 * on the two protected keys as well
+	 * on the two protected keys as well - but not for full xts keys.
 	 */
-	ckey_len = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ?
-		AES_KEYSIZE_128 : AES_KEYSIZE_256;
-	memcpy(ckey, ctx->pk[0].protkey, ckey_len);
-	memcpy(ckey + ckey_len, ctx->pk[1].protkey, ckey_len);
-	return xts_verify_key(tfm, ckey, 2*ckey_len);
+	if (ctx->pk[0].type == PKEY_KEYTYPE_AES_128 ||
+	    ctx->pk[0].type == PKEY_KEYTYPE_AES_256) {
+		ckey_len = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ?
+			AES_KEYSIZE_128 : AES_KEYSIZE_256;
+		memcpy(ckey, ctx->pk[0].protkey, ckey_len);
+		memcpy(ckey + ckey_len, ctx->pk[1].protkey, ckey_len);
+		rc = xts_verify_key(tfm, ckey, 2 * ckey_len);
+		memzero_explicit(ckey, sizeof(ckey));
+		if (rc)
+			goto out;
+	}
+
+	/* Pick the correct function code based on the protected key type */
+	switch (ctx->pk[0].type) {
+	case PKEY_KEYTYPE_AES_128:
+		fc = CPACF_KM_PXTS_128;
+		break;
+	case PKEY_KEYTYPE_AES_256:
+		fc = CPACF_KM_PXTS_256;
+		break;
+	case PKEY_KEYTYPE_AES_XTS_128:
+		fc = CPACF_KM_PXTS_128_FULL;
+		break;
+	case PKEY_KEYTYPE_AES_XTS_256:
+		fc = CPACF_KM_PXTS_256_FULL;
+		break;
+	default:
+		fc = 0;
+		break;
+	}
+	ctx->fc = (fc && cpacf_test_func(&km_functions, fc)) ? fc : 0;
+
+	rc = fc ? 0 : -EINVAL;
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int paes_xts_crypt_full(struct skcipher_request *req,
-			       unsigned long modifier)
+static int xts_paes_do_crypt_fullkey(struct s390_pxts_ctx *ctx,
+				     struct s390_pxts_req_ctx *req_ctx,
+				     bool maysleep)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct xts_full_km_param *param = &req_ctx->param.full_km_param;
+	struct skcipher_walk *walk = &req_ctx->walk;
 	unsigned int keylen, offset, nbytes, n, k;
-	struct {
-		u8 key[64];
-		u8 tweak[16];
-		u8 nap[16];
-		u8 wkvp[32];
-	} fxts_param = {
-		.nap = {0},
-	};
-	struct skcipher_walk walk;
-	int rc;
+	int rc = 0;
 
-	rc = skcipher_walk_virt(&walk, req, false);
-	if (rc)
-		return rc;
+	/*
+	 * The calling function xts_paes_do_crypt() ensures the
+	 * protected key state is always PK_STATE_VALID when this
+	 * function is invoked.
+	 */
 
 	keylen = (ctx->pk[0].type == PKEY_KEYTYPE_AES_XTS_128) ? 32 : 64;
 	offset = (ctx->pk[0].type == PKEY_KEYTYPE_AES_XTS_128) ? 32 : 0;
 
-	spin_lock_bh(&ctx->pk_lock);
-	memcpy(fxts_param.key + offset, ctx->pk[0].protkey, keylen);
-	memcpy(fxts_param.wkvp, ctx->pk[0].protkey + keylen,
-	       sizeof(fxts_param.wkvp));
-	spin_unlock_bh(&ctx->pk_lock);
-	memcpy(fxts_param.tweak, walk.iv, sizeof(fxts_param.tweak));
-	fxts_param.nap[0] = 0x01; /* initial alpha power (1, little-endian) */
+	if (!req_ctx->param_init_done) {
+		memset(param, 0, sizeof(*param));
+		spin_lock_bh(&ctx->pk_lock);
+		memcpy(param->key + offset, ctx->pk[0].protkey, keylen);
+		memcpy(param->wkvp, ctx->pk[0].protkey + keylen, sizeof(param->wkvp));
+		spin_unlock_bh(&ctx->pk_lock);
+		memcpy(param->tweak, walk->iv, sizeof(param->tweak));
+		param->nap[0] = 0x01; /* initial alpha power (1, little-endian) */
+		req_ctx->param_init_done = true;
+	}
 
-	while ((nbytes = walk.nbytes) != 0) {
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) != 0) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
-		k = cpacf_km(ctx->fc | modifier, fxts_param.key + offset,
-			     walk.dst.virt.addr, walk.src.virt.addr, n);
+		k = cpacf_km(ctx->fc | req_ctx->modifier, param->key + offset,
+			     walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k)
-			rc = skcipher_walk_done(&walk, nbytes - k);
+			rc = skcipher_walk_done(walk, nbytes - k);
 		if (k < n) {
-			if (__xts_paes_convert_key(ctx))
-				return skcipher_walk_done(&walk, -EIO);
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = pxts_convert_key(ctx);
+			if (rc)
+				goto out;
 			spin_lock_bh(&ctx->pk_lock);
-			memcpy(fxts_param.key + offset, ctx->pk[0].protkey,
-			       keylen);
-			memcpy(fxts_param.wkvp, ctx->pk[0].protkey + keylen,
-			       sizeof(fxts_param.wkvp));
+			memcpy(param->key + offset, ctx->pk[0].protkey, keylen);
+			memcpy(param->wkvp, ctx->pk[0].protkey + keylen, sizeof(param->wkvp));
 			spin_unlock_bh(&ctx->pk_lock);
 		}
 	}
 
+out:
+	pr_debug("rc=%d\n", rc);
 	return rc;
 }
 
-static int paes_xts_crypt(struct skcipher_request *req, unsigned long modifier)
+static inline int __xts_2keys_prep_param(struct s390_pxts_ctx *ctx,
+					 struct xts_km_param *param,
+					 struct skcipher_walk *walk,
+					 unsigned int keylen,
+					 unsigned int offset, bool maysleep)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct xts_pcc_param pcc_param;
+	unsigned long cc = 1;
+	int rc = 0;
+
+	while (cc) {
+		memset(&pcc_param, 0, sizeof(pcc_param));
+		memcpy(pcc_param.tweak, walk->iv, sizeof(pcc_param.tweak));
+		spin_lock_bh(&ctx->pk_lock);
+		memcpy(pcc_param.key + offset, ctx->pk[1].protkey, keylen);
+		memcpy(param->key + offset, ctx->pk[0].protkey, keylen);
+		spin_unlock_bh(&ctx->pk_lock);
+		cc = cpacf_pcc(ctx->fc, pcc_param.key + offset);
+		if (cc) {
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				break;
+			}
+			rc = pxts_convert_key(ctx);
+			if (rc)
+				break;
+			continue;
+		}
+		memcpy(param->init, pcc_param.xts, 16);
+	}
+
+	memzero_explicit(pcc_param.key, sizeof(pcc_param.key));
+	return rc;
+}
+
+static int xts_paes_do_crypt_2keys(struct s390_pxts_ctx *ctx,
+				   struct s390_pxts_req_ctx *req_ctx,
+				   bool maysleep)
+{
+	struct xts_km_param *param = &req_ctx->param.km_param;
+	struct skcipher_walk *walk = &req_ctx->walk;
 	unsigned int keylen, offset, nbytes, n, k;
-	struct {
-		u8 key[PAES_256_PROTKEY_SIZE];
-		u8 tweak[16];
-		u8 block[16];
-		u8 bit[16];
-		u8 xts[16];
-	} pcc_param;
-	struct {
-		u8 key[PAES_256_PROTKEY_SIZE];
-		u8 init[16];
-	} xts_param;
-	struct skcipher_walk walk;
-	int rc;
+	int rc = 0;
 
-	rc = skcipher_walk_virt(&walk, req, false);
-	if (rc)
-		return rc;
+	/*
+	 * The calling function xts_paes_do_crypt() ensures the
+	 * protected key state is always PK_STATE_VALID when this
+	 * function is invoked.
+	 */
 
 	keylen = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ? 48 : 64;
 	offset = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ? 16 : 0;
 
-	memset(&pcc_param, 0, sizeof(pcc_param));
-	memcpy(pcc_param.tweak, walk.iv, sizeof(pcc_param.tweak));
-	spin_lock_bh(&ctx->pk_lock);
-	memcpy(pcc_param.key + offset, ctx->pk[1].protkey, keylen);
-	memcpy(xts_param.key + offset, ctx->pk[0].protkey, keylen);
-	spin_unlock_bh(&ctx->pk_lock);
-	cpacf_pcc(ctx->fc, pcc_param.key + offset);
-	memcpy(xts_param.init, pcc_param.xts, 16);
+	if (!req_ctx->param_init_done) {
+		rc = __xts_2keys_prep_param(ctx, param, walk,
+					    keylen, offset, maysleep);
+		if (rc)
+			goto out;
+		req_ctx->param_init_done = true;
+	}
 
-	while ((nbytes = walk.nbytes) != 0) {
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) != 0) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
-		k = cpacf_km(ctx->fc | modifier, xts_param.key + offset,
-			     walk.dst.virt.addr, walk.src.virt.addr, n);
+		k = cpacf_km(ctx->fc | req_ctx->modifier, param->key + offset,
+			     walk->dst.virt.addr, walk->src.virt.addr, n);
 		if (k)
-			rc = skcipher_walk_done(&walk, nbytes - k);
+			rc = skcipher_walk_done(walk, nbytes - k);
 		if (k < n) {
-			if (__xts_paes_convert_key(ctx))
-				return skcipher_walk_done(&walk, -EIO);
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = pxts_convert_key(ctx);
+			if (rc)
+				goto out;
 			spin_lock_bh(&ctx->pk_lock);
-			memcpy(xts_param.key + offset,
-			       ctx->pk[0].protkey, keylen);
+			memcpy(param->key + offset, ctx->pk[0].protkey, keylen);
 			spin_unlock_bh(&ctx->pk_lock);
 		}
 	}
 
+out:
+	pr_debug("rc=%d\n", rc);
 	return rc;
 }
 
-static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long modifier)
+static int xts_paes_do_crypt(struct s390_pxts_ctx *ctx,
+			     struct s390_pxts_req_ctx *req_ctx,
+			     bool maysleep)
 {
-	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int pk_state, rc = 0;
 
+	/* fetch and check protected key state */
+	spin_lock_bh(&ctx->pk_lock);
+	pk_state = ctx->pk_state;
+	switch (pk_state) {
+	case PK_STATE_NO_KEY:
+		rc = -ENOKEY;
+		break;
+	case PK_STATE_CONVERT_IN_PROGRESS:
+		rc = -EKEYEXPIRED;
+		break;
+	case PK_STATE_VALID:
+		break;
+	default:
+		rc = pk_state < 0 ? pk_state : -EIO;
+		break;
+	}
+	spin_unlock_bh(&ctx->pk_lock);
+	if (rc)
+		goto out;
+
+	/* Call the 'real' crypt function based on the xts prot key type. */
 	switch (ctx->fc) {
 	case CPACF_KM_PXTS_128:
 	case CPACF_KM_PXTS_256:
-		return paes_xts_crypt(req, modifier);
+		rc = xts_paes_do_crypt_2keys(ctx, req_ctx, maysleep);
+		break;
 	case CPACF_KM_PXTS_128_FULL:
 	case CPACF_KM_PXTS_256_FULL:
-		return paes_xts_crypt_full(req, modifier);
+		rc = xts_paes_do_crypt_fullkey(ctx, req_ctx, maysleep);
+		break;
 	default:
-		return -EINVAL;
+		rc = -EINVAL;
 	}
-}
 
-static int xts_paes_encrypt(struct skcipher_request *req)
-{
-	return xts_paes_crypt(req, 0);
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static int xts_paes_decrypt(struct skcipher_request *req)
+static inline int xts_paes_crypt(struct skcipher_request *req, unsigned long modifier)
 {
-	return xts_paes_crypt(req, CPACF_DECRYPT);
-}
+	struct s390_pxts_req_ctx *req_ctx = skcipher_request_ctx(req);
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
+	int rc;
 
-static struct skcipher_alg xts_paes_alg = {
-	.base.cra_name		=	"xts(paes)",
-	.base.cra_driver_name	=	"xts-paes-s390",
-	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
-	.base.cra_blocksize	=	AES_BLOCK_SIZE,
-	.base.cra_ctxsize	=	sizeof(struct s390_pxts_ctx),
-	.base.cra_module	=	THIS_MODULE,
-	.base.cra_list		=	LIST_HEAD_INIT(xts_paes_alg.base.cra_list),
-	.init			=	xts_paes_init,
-	.exit			=	xts_paes_exit,
-	.min_keysize		=	2 * PAES_MIN_KEYSIZE,
-	.max_keysize		=	2 * PAES_MAX_KEYSIZE,
-	.ivsize			=	AES_BLOCK_SIZE,
-	.setkey			=	xts_paes_set_key,
-	.encrypt		=	xts_paes_encrypt,
-	.decrypt		=	xts_paes_decrypt,
-};
+	/*
+	 * Attempt synchronous encryption first. If it fails, schedule the request
+	 * asynchronously via the crypto engine. To preserve execution order,
+	 * once a request is queued to the engine, further requests using the same
+	 * tfm will also be routed through the engine.
+	 */
 
-static int ctr_paes_init(struct crypto_skcipher *tfm)
-{
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	rc = skcipher_walk_virt(walk, req, false);
+	if (rc)
+		goto out;
 
-	ctx->kb.key = NULL;
-	spin_lock_init(&ctx->pk_lock);
+	req_ctx->modifier = modifier;
+	req_ctx->param_init_done = false;
 
-	return 0;
-}
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&ctx->via_engine_ctr)) {
+		rc = xts_paes_do_crypt(ctx, req_ctx, false);
+		if (rc == 0)
+			goto out;
+	}
 
-static void ctr_paes_exit(struct crypto_skcipher *tfm)
-{
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
+	/*
+	 * If sync operation failed or key expired or there are already
+	 * requests enqueued via engine, fallback to async. Mark tfm as
+	 * using engine to serialize requests.
+	 */
+	if (rc == 0 || rc == -EKEYEXPIRED) {
+		atomic_inc(&ctx->via_engine_ctr);
+		rc = crypto_transfer_skcipher_request_to_engine(paes_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&ctx->via_engine_ctr);
+	}
+
+	if (rc != -EINPROGRESS)
+		skcipher_walk_done(walk, rc);
 
-	_free_kb_keybuf(&ctx->kb);
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("rc=%d\n", rc);
+	return rc;
 }
 
-static inline int __ctr_paes_set_key(struct s390_paes_ctx *ctx)
+static int xts_paes_encrypt(struct skcipher_request *req)
 {
-	unsigned long fc;
-	int rc;
-
-	rc = __paes_convert_key(ctx);
-	if (rc)
-		return rc;
-
-	/* Pick the correct function code based on the protected key type */
-	fc = (ctx->pk.type == PKEY_KEYTYPE_AES_128) ? CPACF_KMCTR_PAES_128 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_192) ? CPACF_KMCTR_PAES_192 :
-		(ctx->pk.type == PKEY_KEYTYPE_AES_256) ?
-		CPACF_KMCTR_PAES_256 : 0;
-
-	/* Check if the function code is available */
-	ctx->fc = (fc && cpacf_test_func(&kmctr_functions, fc)) ? fc : 0;
+	return xts_paes_crypt(req, 0);
+}
 
-	return ctx->fc ? 0 : -EINVAL;
+static int xts_paes_decrypt(struct skcipher_request *req)
+{
+	return xts_paes_crypt(req, CPACF_DECRYPT);
 }
 
-static int ctr_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
-			    unsigned int key_len)
+static int xts_paes_init(struct crypto_skcipher *tfm)
 {
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	int rc;
+	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	_free_kb_keybuf(&ctx->kb);
-	rc = _key_to_kb(&ctx->kb, in_key, key_len);
-	if (rc)
-		return rc;
+	memset(ctx, 0, sizeof(*ctx));
+	spin_lock_init(&ctx->pk_lock);
+
+	crypto_skcipher_set_reqsize(tfm, sizeof(struct s390_pxts_req_ctx));
 
-	return __ctr_paes_set_key(ctx);
+	return 0;
 }
 
-static unsigned int __ctrblk_init(u8 *ctrptr, u8 *iv, unsigned int nbytes)
+static void xts_paes_exit(struct crypto_skcipher *tfm)
 {
-	unsigned int i, n;
+	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
 
-	/* only use complete blocks, max. PAGE_SIZE */
-	memcpy(ctrptr, iv, AES_BLOCK_SIZE);
-	n = (nbytes > PAGE_SIZE) ? PAGE_SIZE : nbytes & ~(AES_BLOCK_SIZE - 1);
-	for (i = (n / AES_BLOCK_SIZE) - 1; i > 0; i--) {
-		memcpy(ctrptr + AES_BLOCK_SIZE, ctrptr, AES_BLOCK_SIZE);
-		crypto_inc(ctrptr + AES_BLOCK_SIZE, AES_BLOCK_SIZE);
-		ctrptr += AES_BLOCK_SIZE;
-	}
-	return n;
+	memzero_explicit(ctx, sizeof(*ctx));
 }
 
-static int ctr_paes_crypt(struct skcipher_request *req)
+static int xts_paes_do_one_request(struct crypto_engine *engine, void *areq)
 {
+	struct skcipher_request *req = skcipher_request_cast(areq);
+	struct s390_pxts_req_ctx *req_ctx = skcipher_request_ctx(req);
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
-	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
-	u8 buf[AES_BLOCK_SIZE], *ctrptr;
-	struct {
-		u8 key[PAES_256_PROTKEY_SIZE];
-	} param;
-	struct skcipher_walk walk;
-	unsigned int nbytes, n, k;
-	int rc, locked;
-
-	rc = skcipher_walk_virt(&walk, req, false);
-	if (rc)
-		return rc;
-
-	spin_lock_bh(&ctx->pk_lock);
-	memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-	spin_unlock_bh(&ctx->pk_lock);
-
-	locked = mutex_trylock(&ctrblk_lock);
+	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk *walk = &req_ctx->walk;
+	int rc;
 
-	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
-		n = AES_BLOCK_SIZE;
-		if (nbytes >= 2*AES_BLOCK_SIZE && locked)
-			n = __ctrblk_init(ctrblk, walk.iv, nbytes);
-		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk.iv;
-		k = cpacf_kmctr(ctx->fc, &param, walk.dst.virt.addr,
-				walk.src.virt.addr, n, ctrptr);
-		if (k) {
-			if (ctrptr == ctrblk)
-				memcpy(walk.iv, ctrptr + k - AES_BLOCK_SIZE,
-				       AES_BLOCK_SIZE);
-			crypto_inc(walk.iv, AES_BLOCK_SIZE);
-			rc = skcipher_walk_done(&walk, nbytes - k);
-		}
-		if (k < n) {
-			if (__paes_convert_key(ctx)) {
-				if (locked)
-					mutex_unlock(&ctrblk_lock);
-				return skcipher_walk_done(&walk, -EIO);
-			}
-			spin_lock_bh(&ctx->pk_lock);
-			memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-			spin_unlock_bh(&ctx->pk_lock);
-		}
-	}
-	if (locked)
-		mutex_unlock(&ctrblk_lock);
-	/*
-	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
-	 */
-	if (nbytes) {
-		memset(buf, 0, AES_BLOCK_SIZE);
-		memcpy(buf, walk.src.virt.addr, nbytes);
-		while (1) {
-			if (cpacf_kmctr(ctx->fc, &param, buf,
-					buf, AES_BLOCK_SIZE,
-					walk.iv) == AES_BLOCK_SIZE)
-				break;
-			if (__paes_convert_key(ctx))
-				return skcipher_walk_done(&walk, -EIO);
-			spin_lock_bh(&ctx->pk_lock);
-			memcpy(param.key, ctx->pk.protkey, PAES_256_PROTKEY_SIZE);
-			spin_unlock_bh(&ctx->pk_lock);
-		}
-		memcpy(walk.dst.virt.addr, buf, nbytes);
-		crypto_inc(walk.iv, AES_BLOCK_SIZE);
-		rc = skcipher_walk_done(&walk, nbytes);
+	/* walk has already been prepared */
+
+	rc = xts_paes_do_crypt(ctx, req_ctx, true);
+	if (rc == -EKEYEXPIRED) {
+		/*
+		 * Protected key expired, conversion is in process.
+		 * Trigger a re-schedule of this request by returning
+		 * -ENOSPC ("hardware queue is full") to the crypto engine.
+		 * To avoid immediately re-invocation of this callback,
+		 * tell the scheduler to voluntarily give up the CPU here.
+		 */
+		cond_resched();
+		pr_debug("rescheduling request\n");
+		return -ENOSPC;
+	} else if (rc) {
+		skcipher_walk_done(walk, rc);
 	}
 
+	memzero_explicit(&req_ctx->param, sizeof(req_ctx->param));
+	pr_debug("request complete with rc=%d\n", rc);
+	local_bh_disable();
+	atomic_dec(&ctx->via_engine_ctr);
+	crypto_finalize_skcipher_request(engine, req, rc);
+	local_bh_enable();
 	return rc;
 }
 
-static struct skcipher_alg ctr_paes_alg = {
-	.base.cra_name		=	"ctr(paes)",
-	.base.cra_driver_name	=	"ctr-paes-s390",
-	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
-	.base.cra_blocksize	=	1,
-	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
-	.base.cra_module	=	THIS_MODULE,
-	.base.cra_list		=	LIST_HEAD_INIT(ctr_paes_alg.base.cra_list),
-	.init			=	ctr_paes_init,
-	.exit			=	ctr_paes_exit,
-	.min_keysize		=	PAES_MIN_KEYSIZE,
-	.max_keysize		=	PAES_MAX_KEYSIZE,
-	.ivsize			=	AES_BLOCK_SIZE,
-	.setkey			=	ctr_paes_set_key,
-	.encrypt		=	ctr_paes_crypt,
-	.decrypt		=	ctr_paes_crypt,
-	.chunksize		=	AES_BLOCK_SIZE,
+static struct skcipher_engine_alg xts_paes_alg = {
+	.base = {
+		.base.cra_name	      =	"xts(paes)",
+		.base.cra_driver_name =	"xts-paes-s390",
+		.base.cra_priority    =	402,	/* ecb-paes-s390 + 1 */
+		.base.cra_blocksize   =	AES_BLOCK_SIZE,
+		.base.cra_ctxsize     =	sizeof(struct s390_pxts_ctx),
+		.base.cra_module      =	THIS_MODULE,
+		.base.cra_list	      =	LIST_HEAD_INIT(xts_paes_alg.base.base.cra_list),
+		.init		      =	xts_paes_init,
+		.exit		      =	xts_paes_exit,
+		.min_keysize	      =	2 * PAES_MIN_KEYSIZE,
+		.max_keysize	      =	2 * PAES_MAX_KEYSIZE,
+		.ivsize		      =	AES_BLOCK_SIZE,
+		.setkey		      =	xts_paes_setkey,
+		.encrypt	      =	xts_paes_encrypt,
+		.decrypt	      =	xts_paes_decrypt,
+	},
+	.op = {
+		.do_one_request	      = xts_paes_do_one_request,
+	},
 };
 
-static inline void __crypto_unregister_skcipher(struct skcipher_alg *alg)
+/*
+ * alg register, unregister, module init, exit
+ */
+
+static struct miscdevice paes_dev = {
+	.name	= "paes",
+	.minor	= MISC_DYNAMIC_MINOR,
+};
+
+static inline void __crypto_unregister_skcipher(struct skcipher_engine_alg *alg)
 {
-	if (!list_empty(&alg->base.cra_list))
-		crypto_unregister_skcipher(alg);
+	if (!list_empty(&alg->base.base.cra_list))
+		crypto_engine_unregister_skcipher(alg);
 }
 
 static void paes_s390_fini(void)
 {
+	if (paes_crypto_engine) {
+		crypto_engine_stop(paes_crypto_engine);
+		crypto_engine_exit(paes_crypto_engine);
+	}
 	__crypto_unregister_skcipher(&ctr_paes_alg);
 	__crypto_unregister_skcipher(&xts_paes_alg);
 	__crypto_unregister_skcipher(&cbc_paes_alg);
 	__crypto_unregister_skcipher(&ecb_paes_alg);
 	if (ctrblk)
-		free_page((unsigned long) ctrblk);
+		free_page((unsigned long)ctrblk);
+	misc_deregister(&paes_dev);
 }
 
 static int __init paes_s390_init(void)
 {
 	int rc;
 
+	/* register a simple paes pseudo misc device */
+	rc = misc_register(&paes_dev);
+	if (rc)
+		return rc;
+
+	/* with this pseudo devie alloc and start a crypto engine */
+	paes_crypto_engine =
+		crypto_engine_alloc_init_and_set(paes_dev.this_device,
+						 true, NULL, false, MAX_QLEN);
+	if (!paes_crypto_engine) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
+	rc = crypto_engine_start(paes_crypto_engine);
+	if (rc) {
+		crypto_engine_exit(paes_crypto_engine);
+		paes_crypto_engine = NULL;
+		goto out_err;
+	}
+
 	/* Query available functions for KM, KMC and KMCTR */
 	cpacf_query(CPACF_KM, &km_functions);
 	cpacf_query(CPACF_KMC, &kmc_functions);
@@ -927,40 +1650,45 @@ static int __init paes_s390_init(void)
 	if (cpacf_test_func(&km_functions, CPACF_KM_PAES_128) ||
 	    cpacf_test_func(&km_functions, CPACF_KM_PAES_192) ||
 	    cpacf_test_func(&km_functions, CPACF_KM_PAES_256)) {
-		rc = crypto_register_skcipher(&ecb_paes_alg);
+		rc = crypto_engine_register_skcipher(&ecb_paes_alg);
 		if (rc)
 			goto out_err;
+		pr_debug("%s registered\n", ecb_paes_alg.base.base.cra_driver_name);
 	}
 
 	if (cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
 	    cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
 	    cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256)) {
-		rc = crypto_register_skcipher(&cbc_paes_alg);
+		rc = crypto_engine_register_skcipher(&cbc_paes_alg);
 		if (rc)
 			goto out_err;
+		pr_debug("%s registered\n", cbc_paes_alg.base.base.cra_driver_name);
 	}
 
 	if (cpacf_test_func(&km_functions, CPACF_KM_PXTS_128) ||
 	    cpacf_test_func(&km_functions, CPACF_KM_PXTS_256)) {
-		rc = crypto_register_skcipher(&xts_paes_alg);
+		rc = crypto_engine_register_skcipher(&xts_paes_alg);
 		if (rc)
 			goto out_err;
+		pr_debug("%s registered\n", xts_paes_alg.base.base.cra_driver_name);
 	}
 
 	if (cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_128) ||
 	    cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_192) ||
 	    cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_256)) {
-		ctrblk = (u8 *) __get_free_page(GFP_KERNEL);
+		ctrblk = (u8 *)__get_free_page(GFP_KERNEL);
 		if (!ctrblk) {
 			rc = -ENOMEM;
 			goto out_err;
 		}
-		rc = crypto_register_skcipher(&ctr_paes_alg);
+		rc = crypto_engine_register_skcipher(&ctr_paes_alg);
 		if (rc)
 			goto out_err;
+		pr_debug("%s registered\n", ctr_paes_alg.base.base.cra_driver_name);
 	}
 
 	return 0;
+
 out_err:
 	paes_s390_fini();
 	return rc;
-- 
2.43.0


