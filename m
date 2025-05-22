Return-Path: <linux-s390+bounces-10741-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE844AC080B
	for <lists+linux-s390@lfdr.de>; Thu, 22 May 2025 10:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA52B1BC4FF8
	for <lists+linux-s390@lfdr.de>; Thu, 22 May 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2765B288C2C;
	Thu, 22 May 2025 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mB/9K1g8"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8832882DF;
	Thu, 22 May 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904288; cv=none; b=cKx7sYzyZXUvV2q9LA3IyhovhEK5C/z0G30z4kAmwES+f/jRGRK0BkTwcSkR8PP5BZa3SEVlle0yijaBhL+1uSlhL+Hb0WNh51xH+JJzainFu1FrPfSJDlepg+LTy9No7MWHjDFXdcyOC6k1XrhmxnYWi3mFJ7TeTmyTD2Ipl5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904288; c=relaxed/simple;
	bh=kJlHd2+obwZfPi+iHm3ZCc+infNnyA3fl7yy7qE4xls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJQzHXPa6x553QzSwz0c6K2wrbiKQjoLWVljqWJBj0x89zr2o6GDZ2Ks+jdwIGsIhkSUsfR53Tu2eoZZN90SK/wThTYuNNRADb05qC/SpVNjQoUdnM3+NNrxgoQ/F3HnLWqZIx59T/uYCbpj604NLdxCmBXuN5JdjizGHPmomRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mB/9K1g8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54M7AZc0003213;
	Thu, 22 May 2025 08:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=BVVstLsvbMmmvFZ74
	cI7R0SnwgDKpBLxm6Pqun43hPQ=; b=mB/9K1g8jLBoXHajps9NRXA93NmmQsau4
	sTCNRwCSIl520VYGAPg5igwJ1xxoK/+ErWKU7si6A7o1+w78p0PVX2BYsQw7VfcS
	+QvbVAxGtFe4/yP1cUxHaOoU9wUBEDQ25JLysHqrqpvU/XZ2VUxm460LmX4DdJQx
	/BbhDkGptJ14CrikZna1KPgYaGj3I0b0wTNuoY1zhgaUH06r97ooG6AHPaGNsn2I
	uwgW54/Mka3DwKeoH7fq2odLWNZLnxGxqQaK/JLrscik1kpsTBqoDSo5UqZvCZCw
	IT0BBLw/Tx+teahUT7PqXuSqZQW+4rBPlALoS6125m39KalxdrF4w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46smh7340h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:58:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54M5IxNc031977;
	Thu, 22 May 2025 08:58:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmq8nyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 May 2025 08:58:00 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54M8vu1n19530184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 May 2025 08:57:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3D6A20040;
	Thu, 22 May 2025 08:57:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 744C420043;
	Thu, 22 May 2025 08:57:56 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.152.224.229])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 May 2025 08:57:56 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: herbert@gondor.apana.org.au, dengler@linux.ibm.com, ifranzki@linux.ibm.com
Cc: linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        fcallies@linux.ibm.com
Subject: [PATCH v11 3/6] s390/crypto: New s390 specific protected key hash phmac
Date: Thu, 22 May 2025 10:57:52 +0200
Message-ID: <20250522085755.40732-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250522085755.40732-1-freude@linux.ibm.com>
References: <20250522085755.40732-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDA4NiBTYWx0ZWRfXyboggl8FkLHg r5Gu19jMZcuaK2vPFEvaZS2EALW30ocEHXX4seMixRo/8PjyFenUgip3yDXbcDiB5i26fFIowCv CQHmptvcfqvz38w6twlUtAxdKZSdoQ1ea0BsOHi9FGzWGiHh5IoSXJJrIir6BepFNf+sTcVyaYi
 HkgfQ19+vXsf6uaV69HBjlJSblR/egd6mZK5kKZczdHVHz6Rj7bxquZcms+afyE7lHjFlINXzmm 03l67lyPXmHl2ZO7go7fxLwteUwWkuAT6+Cq4hE/9mIPrGbqhVgvkKS+PwIJFuze2Jc9JTrv0Uw i3eHBlxdRJzkK8XsVAN/cOgBI5E0M64TbckfreMqYes1/mUIKDOQRzFCRPRbkC/knb/rEkRnn8Z
 5xu26CooOlYcJTiaawJ/zygDtmds2r0Ba56Ys+i4wK9SGtIyOZiF924LJ9dR/lh/EClkQF5j
X-Proofpoint-GUID: oVpDCryTbVayWom6wnj8Djc2lVM0hlWU
X-Proofpoint-ORIG-GUID: oVpDCryTbVayWom6wnj8Djc2lVM0hlWU
X-Authority-Analysis: v=2.4 cv=EdfIQOmC c=1 sm=1 tr=0 ts=682ee719 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=FA8kfeX-uFw9xX3WsykA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_04,2025-05-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 mlxlogscore=999
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220086

Add support for protected key hmac ("phmac") for s390 arch.

With the latest machine generation there is now support for
protected key (that is a key wrapped by a master key stored
in firmware) hmac for sha2 (sha224, sha256, sha384 and sha512)
for the s390 specific CPACF instruction kmac.

This patch adds support via 4 new ahashes registered as
phmac(sha224), phmac(sha256), phmac(sha384) and phmac(sha512).

Co-developed-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 arch/s390/crypto/Makefile         |   1 +
 arch/s390/crypto/phmac_s390.c     | 899 ++++++++++++++++++++++++++++++
 drivers/crypto/Kconfig            |  12 +
 5 files changed, 914 insertions(+)
 create mode 100644 arch/s390/crypto/phmac_s390.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 6f2c9ce1b154..1356ca7fc55d 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -810,6 +810,7 @@ CONFIG_PKEY_EP11=m
 CONFIG_PKEY_PCKMO=m
 CONFIG_PKEY_UV=m
 CONFIG_CRYPTO_PAES_S390=m
+CONFIG_CRYPTO_PHMAC_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index f18a7d97ac21..58b1621300c8 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -797,6 +797,7 @@ CONFIG_PKEY_EP11=m
 CONFIG_PKEY_PCKMO=m
 CONFIG_PKEY_UV=m
 CONFIG_CRYPTO_PAES_S390=m
+CONFIG_CRYPTO_PHMAC_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index 14dafadbcbed..60c5ed173079 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CRYPTO_CHACHA_S390) += chacha_s390.o
 obj-$(CONFIG_S390_PRNG) += prng.o
 obj-$(CONFIG_CRYPTO_GHASH_S390) += ghash_s390.o
 obj-$(CONFIG_CRYPTO_HMAC_S390) += hmac_s390.o
+obj-$(CONFIG_CRYPTO_PHMAC_S390) += phmac_s390.o
 obj-y += arch_random.o
 
 chacha_s390-y := chacha-glue.o chacha-s390.o
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
new file mode 100644
index 000000000000..b61454dedf0a
--- /dev/null
+++ b/arch/s390/crypto/phmac_s390.c
@@ -0,0 +1,899 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright IBM Corp. 2025
+ *
+ * s390 specific HMAC support for protected keys.
+ */
+
+#define KMSG_COMPONENT	"phmac_s390"
+#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
+
+#include <asm/cpacf.h>
+#include <asm/pkey.h>
+#include <crypto/engine.h>
+#include <crypto/hash.h>
+#include <crypto/internal/hash.h>
+#include <crypto/sha2.h>
+#include <linux/atomic.h>
+#include <linux/cpufeature.h>
+#include <linux/delay.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+
+static struct crypto_engine *phmac_crypto_engine;
+#define MAX_QLEN 10
+
+/*
+ * A simple hash walk helper
+ */
+
+struct hash_walk_helper {
+	struct crypto_hash_walk walk;
+	const u8 *walkaddr;
+	int walkbytes;
+};
+
+/*
+ * Prepare hash walk helper.
+ * Set up the base hash walk, fill walkaddr and walkbytes.
+ * Returns 0 on success or negative value on error.
+ */
+static inline int hwh_prepare(struct ahash_request *req,
+			      struct hash_walk_helper *hwh)
+{
+	hwh->walkbytes = crypto_hash_walk_first(req, &hwh->walk);
+	if (hwh->walkbytes < 0)
+		return hwh->walkbytes;
+	hwh->walkaddr = hwh->walk.data;
+	return 0;
+}
+
+/*
+ * Advance hash walk helper by n bytes.
+ * Progress the walkbytes and walkaddr fields by n bytes.
+ * If walkbytes is then 0, pull next hunk from hash walk
+ * and update walkbytes and walkaddr.
+ * If n is negative, unmap hash walk and return error.
+ * Returns 0 on success or negative value on error.
+ */
+static inline int hwh_advance(struct hash_walk_helper *hwh, int n)
+{
+	if (n < 0)
+		return crypto_hash_walk_done(&hwh->walk, n);
+
+	hwh->walkbytes -= n;
+	hwh->walkaddr += n;
+	if (hwh->walkbytes > 0)
+		return 0;
+
+	hwh->walkbytes = crypto_hash_walk_done(&hwh->walk, 0);
+	if (hwh->walkbytes < 0)
+		return hwh->walkbytes;
+
+	hwh->walkaddr = hwh->walk.data;
+	return 0;
+}
+
+/*
+ * KMAC param block layout for sha2 function codes:
+ * The layout of the param block for the KMAC instruction depends on the
+ * blocksize of the used hashing sha2-algorithm function codes. The param block
+ * contains the hash chaining value (cv), the input message bit-length (imbl)
+ * and the hmac-secret (key). To prevent code duplication, the sizes of all
+ * these are calculated based on the blocksize.
+ *
+ * param-block:
+ * +-------+
+ * | cv    |
+ * +-------+
+ * | imbl  |
+ * +-------+
+ * | key   |
+ * +-------+
+ *
+ * sizes:
+ * part | sh2-alg | calculation | size | type
+ * -----+---------+-------------+------+--------
+ * cv   | 224/256 | blocksize/2 |   32 |  u64[8]
+ *      | 384/512 |             |   64 | u128[8]
+ * imbl | 224/256 | blocksize/8 |    8 |     u64
+ *      | 384/512 |             |   16 |    u128
+ * key  | 224/256 | blocksize   |   96 |  u8[96]
+ *      | 384/512 |             |  160 | u8[160]
+ */
+
+#define MAX_DIGEST_SIZE		SHA512_DIGEST_SIZE
+#define MAX_IMBL_SIZE		sizeof(u128)
+#define MAX_BLOCK_SIZE		SHA512_BLOCK_SIZE
+
+#define SHA2_CV_SIZE(bs)	((bs) >> 1)
+#define SHA2_IMBL_SIZE(bs)	((bs) >> 3)
+
+#define SHA2_IMBL_OFFSET(bs)	(SHA2_CV_SIZE(bs))
+#define SHA2_KEY_OFFSET(bs)	(SHA2_CV_SIZE(bs) + SHA2_IMBL_SIZE(bs))
+
+#define PHMAC_MAX_KEYSIZE       256
+#define PHMAC_SHA256_PK_SIZE	(SHA256_BLOCK_SIZE + 32)
+#define PHMAC_SHA512_PK_SIZE	(SHA512_BLOCK_SIZE + 32)
+#define PHMAC_MAX_PK_SIZE	PHMAC_SHA512_PK_SIZE
+
+/* phmac protected key struct */
+struct phmac_protkey {
+	u32 type;
+	u32 len;
+	u8 protkey[PHMAC_MAX_PK_SIZE];
+};
+
+#define PK_STATE_NO_KEY		     0
+#define PK_STATE_CONVERT_IN_PROGRESS 1
+#define PK_STATE_VALID		     2
+
+/* phmac tfm context */
+struct phmac_tfm_ctx {
+	/* source key material used to derive a protected key from */
+	u8 keybuf[PHMAC_MAX_KEYSIZE];
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
+	struct phmac_protkey pk;
+};
+
+union kmac_gr0 {
+	unsigned long reg;
+	struct {
+		unsigned long		: 48;
+		unsigned long ikp	:  1;
+		unsigned long iimp	:  1;
+		unsigned long ccup	:  1;
+		unsigned long		:  6;
+		unsigned long fc	:  7;
+	};
+};
+
+struct kmac_sha2_ctx {
+	u8 param[MAX_DIGEST_SIZE + MAX_IMBL_SIZE + PHMAC_MAX_PK_SIZE];
+	union kmac_gr0 gr0;
+	u8 buf[MAX_BLOCK_SIZE];
+	unsigned long total;
+};
+
+/* phmac request context */
+struct phmac_req_ctx {
+	struct hash_walk_helper hwh;
+	struct kmac_sha2_ctx kmac_ctx;
+	bool final;
+};
+
+/*
+ * phmac_tfm_ctx_setkey() - Set key value into tfm context, maybe construct
+ * a clear key token digestible by pkey from a clear key value.
+ */
+static inline int phmac_tfm_ctx_setkey(struct phmac_tfm_ctx *tfm_ctx,
+				       const u8 *key, unsigned int keylen)
+{
+	if (keylen > sizeof(tfm_ctx->keybuf))
+		return -EINVAL;
+
+	memcpy(tfm_ctx->keybuf, key, keylen);
+	tfm_ctx->keylen = keylen;
+
+	return 0;
+}
+
+/*
+ * Convert the raw key material into a protected key via PKEY api.
+ * This function may sleep - don't call in non-sleeping context.
+ */
+static inline int convert_key(const u8 *key, unsigned int keylen,
+			      struct phmac_protkey *pk)
+{
+	int rc, i;
+
+	pk->len = sizeof(pk->protkey);
+
+	/*
+	 * In case of a busy card retry with increasing delay
+	 * of 200, 400, 800 and 1600 ms - in total 3 s.
+	 */
+	for (rc = -EIO, i = 0; rc && i < 5; i++) {
+		if (rc == -EBUSY && msleep_interruptible((1 << i) * 100)) {
+			rc = -EINTR;
+			goto out;
+		}
+		rc = pkey_key2protkey(key, keylen,
+				      pk->protkey, &pk->len, &pk->type,
+				      PKEY_XFLAG_NOMEMALLOC);
+	}
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+/*
+ * (Re-)Convert the raw key material from the tfm ctx into a protected
+ * key via convert_key() function. Update the pk_state, pk_type, pk_len
+ * and the protected key in the tfm context.
+ * Please note this function may be invoked concurrently with the very
+ * same tfm context. The pk_lock spinlock in the context ensures an
+ * atomic update of the pk and the pk state but does not guarantee any
+ * order of update. So a fresh converted valid protected key may get
+ * updated with an 'old' expired key value. As the cpacf instructions
+ * detect this, refuse to operate with an invalid key and the calling
+ * code triggers a (re-)conversion this does no harm. This may lead to
+ * unnecessary additional conversion but never to invalid data on the
+ * hash operation.
+ */
+static int phmac_convert_key(struct phmac_tfm_ctx *tfm_ctx)
+{
+	struct phmac_protkey pk;
+	int rc;
+
+	spin_lock_bh(&tfm_ctx->pk_lock);
+	tfm_ctx->pk_state = PK_STATE_CONVERT_IN_PROGRESS;
+	spin_unlock_bh(&tfm_ctx->pk_lock);
+
+	rc = convert_key(tfm_ctx->keybuf, tfm_ctx->keylen, &pk);
+
+	/* update context */
+	spin_lock_bh(&tfm_ctx->pk_lock);
+	if (rc) {
+		tfm_ctx->pk_state = rc;
+	} else {
+		tfm_ctx->pk_state = PK_STATE_VALID;
+		tfm_ctx->pk = pk;
+	}
+	spin_unlock_bh(&tfm_ctx->pk_lock);
+
+	memzero_explicit(&pk, sizeof(pk));
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+/*
+ * kmac_sha2_set_imbl - sets the input message bit-length based on the blocksize
+ */
+static inline void kmac_sha2_set_imbl(u8 *param, unsigned long nbytes,
+				      unsigned int blocksize)
+{
+	u8 *imbl = param + SHA2_IMBL_OFFSET(blocksize);
+
+	switch (blocksize) {
+	case SHA256_BLOCK_SIZE:
+		*(u64 *)imbl = (u64)nbytes * BITS_PER_BYTE;
+		break;
+	case SHA512_BLOCK_SIZE:
+		*(u128 *)imbl = (u128)nbytes * BITS_PER_BYTE;
+		break;
+	default:
+		break;
+	}
+}
+
+static int phmac_kmac_update(struct ahash_request *req, bool maysleep)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *ctx = &req_ctx->kmac_ctx;
+	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	unsigned int bs = crypto_ahash_blocksize(tfm);
+	unsigned int offset, k, n;
+	int rc = 0;
+
+	/*
+	 * The walk is always mapped when this function is called.
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+
+	while (hwh->walkbytes > 0) {
+		/* check sha2 context buffer */
+		offset = ctx->total % bs;
+		if (offset + hwh->walkbytes < bs)
+			goto store;
+
+		if (offset) {
+			/* fill ctx buffer up to blocksize and process this block */
+			n = bs - offset;
+			memcpy(ctx->buf + offset, hwh->walkaddr, n);
+			ctx->gr0.iimp = 1;
+			for (;;) {
+				k = _cpacf_kmac(&ctx->gr0.reg, ctx->param, ctx->buf, bs);
+				if (likely(k == bs))
+					break;
+				if (unlikely(k > 0)) {
+					/*
+					 * Can't deal with hunks smaller than blocksize.
+					 * And kmac should always return the nr of
+					 * processed bytes as 0 or a multiple of the
+					 * blocksize.
+					 */
+					rc = -EIO;
+					goto out;
+				}
+				/* protected key is invalid and needs re-conversion */
+				if (!maysleep) {
+					rc = -EKEYEXPIRED;
+					goto out;
+				}
+				rc = phmac_convert_key(tfm_ctx);
+				if (rc)
+					goto out;
+				spin_lock_bh(&tfm_ctx->pk_lock);
+				memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+				       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+				spin_unlock_bh(&tfm_ctx->pk_lock);
+			}
+			ctx->total += n;
+			rc = hwh_advance(hwh, n);
+			if (unlikely(rc))
+				goto out;
+			offset = 0;
+		}
+
+		/* process as many blocks as possible from the walk */
+		while (hwh->walkbytes >= bs) {
+			n = (hwh->walkbytes / bs) * bs;
+			ctx->gr0.iimp = 1;
+			k = _cpacf_kmac(&ctx->gr0.reg, ctx->param, hwh->walkaddr, n);
+			if (likely(k > 0)) {
+				ctx->total += k;
+				rc = hwh_advance(hwh, k);
+				if (unlikely(rc))
+					goto out;
+			}
+			if (unlikely(k < n)) {
+				/* protected key is invalid and needs re-conversion */
+				if (!maysleep) {
+					rc = -EKEYEXPIRED;
+					goto out;
+				}
+				rc = phmac_convert_key(tfm_ctx);
+				if (rc)
+					goto out;
+				spin_lock_bh(&tfm_ctx->pk_lock);
+				memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+				       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+				spin_unlock_bh(&tfm_ctx->pk_lock);
+			}
+		}
+
+store:
+		/* store incomplete block in context buffer */
+		if (hwh->walkbytes) {
+			memcpy(ctx->buf + offset, hwh->walkaddr, hwh->walkbytes);
+			ctx->total += hwh->walkbytes;
+			rc = hwh_advance(hwh, hwh->walkbytes);
+			if (unlikely(rc))
+				goto out;
+		}
+
+	} /* end of while (hwh->walkbytes > 0) */
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_kmac_final(struct ahash_request *req, bool maysleep)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *ctx = &req_ctx->kmac_ctx;
+	unsigned int ds = crypto_ahash_digestsize(tfm);
+	unsigned int bs = crypto_ahash_blocksize(tfm);
+	unsigned int k, n;
+	int rc = 0;
+
+	n = ctx->total % bs;
+	ctx->gr0.iimp = 0;
+	kmac_sha2_set_imbl(ctx->param, ctx->total, bs);
+	for (;;) {
+		k = _cpacf_kmac(&ctx->gr0.reg, ctx->param, ctx->buf, n);
+		if (likely(k == n))
+			break;
+		if (unlikely(k > 0)) {
+			/* Can't deal with hunks smaller than blocksize. */
+			rc = -EIO;
+			goto out;
+		}
+		/* protected key is invalid and needs re-conversion */
+		if (!maysleep) {
+			rc = -EKEYEXPIRED;
+			goto out;
+		}
+		rc = phmac_convert_key(tfm_ctx);
+		if (rc)
+			goto out;
+		spin_lock_bh(&tfm_ctx->pk_lock);
+		memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+		       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+		spin_unlock_bh(&tfm_ctx->pk_lock);
+	}
+
+	memcpy(req->result, ctx->param, ds);
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_init(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	unsigned int bs = crypto_ahash_blocksize(tfm);
+	int rc = 0;
+
+	/* zero request context (includes the kmac sha2 context) */
+	memset(req_ctx, 0, sizeof(*req_ctx));
+
+	/*
+	 * setkey() should have set a valid fc into the tfm context.
+	 * Copy this function code into the gr0 field of the kmac context.
+	 */
+	if (!tfm_ctx->fc) {
+		rc = -ENOKEY;
+		goto out;
+	}
+	kmac_ctx->gr0.fc = tfm_ctx->fc;
+
+	/*
+	 * Copy the pk from tfm ctx into kmac ctx. The protected key
+	 * may be outdated but update() and final() will handle this.
+	 */
+	spin_lock_bh(&tfm_ctx->pk_lock);
+	memcpy(kmac_ctx->param + SHA2_KEY_OFFSET(bs),
+	       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+	spin_unlock_bh(&tfm_ctx->pk_lock);
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_update(struct ahash_request *req)
+{
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	int rc;
+
+	/* prep the walk in the request context */
+	rc = hwh_prepare(req, hwh);
+	if (rc)
+		goto out;
+
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&tfm_ctx->via_engine_ctr)) {
+		rc = phmac_kmac_update(req, false);
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
+		atomic_inc(&tfm_ctx->via_engine_ctr);
+		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&tfm_ctx->via_engine_ctr);
+	}
+
+	if (rc != -EINPROGRESS) {
+		hwh_advance(hwh, rc);
+		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
+	}
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_final(struct ahash_request *req)
+{
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	int rc = 0;
+
+	/* Try synchronous operation if no active engine usage */
+	if (!atomic_read(&tfm_ctx->via_engine_ctr)) {
+		rc = phmac_kmac_final(req, false);
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
+		req->nbytes = 0;
+		req_ctx->final = true;
+		atomic_inc(&tfm_ctx->via_engine_ctr);
+		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&tfm_ctx->via_engine_ctr);
+	}
+
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_finup(struct ahash_request *req)
+{
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	int rc;
+
+	/* prep the walk in the request context */
+	rc = hwh_prepare(req, hwh);
+	if (rc)
+		goto out;
+
+	/* Try synchronous operations if no active engine usage */
+	if (!atomic_read(&tfm_ctx->via_engine_ctr)) {
+		rc = phmac_kmac_update(req, false);
+		if (rc == 0)
+			req->nbytes = 0;
+	}
+	if (!rc && !req->nbytes && !atomic_read(&tfm_ctx->via_engine_ctr)) {
+		rc = phmac_kmac_final(req, false);
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
+		req_ctx->final = true;
+		atomic_inc(&tfm_ctx->via_engine_ctr);
+		rc = crypto_transfer_hash_request_to_engine(phmac_crypto_engine, req);
+		if (rc != -EINPROGRESS)
+			atomic_dec(&tfm_ctx->via_engine_ctr);
+	}
+
+	if (rc != -EINPROGRESS)
+		hwh_advance(hwh, rc);
+
+out:
+	if (rc != -EINPROGRESS)
+		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_digest(struct ahash_request *req)
+{
+	int rc;
+
+	rc = phmac_init(req);
+	if (rc)
+		goto out;
+
+	rc = phmac_finup(req);
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_setkey(struct crypto_ahash *tfm,
+			const u8 *key, unsigned int keylen)
+{
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	unsigned int ds = crypto_ahash_digestsize(tfm);
+	int rc = 0;
+
+	/* copy raw key into tfm context */
+	rc = phmac_tfm_ctx_setkey(tfm_ctx, key, keylen);
+	if (rc)
+		goto out;
+
+	/* convert raw key into protected key */
+	rc = phmac_convert_key(tfm_ctx);
+	if (rc)
+		goto out;
+
+	/* set function code in tfm context, check for valid pk type */
+	switch (ds) {
+	case SHA224_DIGEST_SIZE:
+		if (tfm_ctx->pk.type != PKEY_KEYTYPE_HMAC_512)
+			rc = -EINVAL;
+		else
+			tfm_ctx->fc = CPACF_KMAC_PHMAC_SHA_224;
+		break;
+	case SHA256_DIGEST_SIZE:
+		if (tfm_ctx->pk.type != PKEY_KEYTYPE_HMAC_512)
+			rc = -EINVAL;
+		else
+			tfm_ctx->fc = CPACF_KMAC_PHMAC_SHA_256;
+		break;
+	case SHA384_DIGEST_SIZE:
+		if (tfm_ctx->pk.type != PKEY_KEYTYPE_HMAC_1024)
+			rc = -EINVAL;
+		else
+			tfm_ctx->fc = CPACF_KMAC_PHMAC_SHA_384;
+		break;
+	case SHA512_DIGEST_SIZE:
+		if (tfm_ctx->pk.type != PKEY_KEYTYPE_HMAC_1024)
+			rc = -EINVAL;
+		else
+			tfm_ctx->fc = CPACF_KMAC_PHMAC_SHA_512;
+		break;
+	default:
+		tfm_ctx->fc = 0;
+		rc = -EINVAL;
+	}
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int phmac_export(struct ahash_request *req, void *out)
+{
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *ctx = &req_ctx->kmac_ctx;
+
+	memcpy(out, ctx, sizeof(*ctx));
+
+	return 0;
+}
+
+static int phmac_import(struct ahash_request *req, const void *in)
+{
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *ctx = &req_ctx->kmac_ctx;
+
+	memset(req_ctx, 0, sizeof(*req_ctx));
+	memcpy(ctx, in, sizeof(*ctx));
+
+	return 0;
+}
+
+static int phmac_init_tfm(struct crypto_ahash *tfm)
+{
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+
+	memset(tfm_ctx, 0, sizeof(*tfm_ctx));
+	spin_lock_init(&tfm_ctx->pk_lock);
+
+	crypto_ahash_set_reqsize(tfm, sizeof(struct phmac_req_ctx));
+
+	return 0;
+}
+
+static void phmac_exit_tfm(struct crypto_ahash *tfm)
+{
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+
+	memzero_explicit(tfm_ctx->keybuf, sizeof(tfm_ctx->keybuf));
+	memzero_explicit(&tfm_ctx->pk, sizeof(tfm_ctx->pk));
+}
+
+static int phmac_do_one_request(struct crypto_engine *engine, void *areq)
+{
+	struct ahash_request *req = ahash_request_cast(areq);
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct phmac_tfm_ctx *tfm_ctx = crypto_ahash_ctx(tfm);
+	struct phmac_req_ctx *req_ctx = ahash_request_ctx(req);
+	struct kmac_sha2_ctx *kmac_ctx = &req_ctx->kmac_ctx;
+	struct hash_walk_helper *hwh = &req_ctx->hwh;
+	int rc = -EINVAL;
+
+	/*
+	 * Three kinds of requests come in here:
+	 * update when req->nbytes > 0 and req_ctx->final is false
+	 * final  when req->nbytes = 0 and req_ctx->final is true
+	 * finup when req->nbytes > 0 and req_ctx->final is true
+	 * For update and finup the hwh walk needs to be prepared and
+	 * up to date but the actual nr of bytes in req->nbytes may be
+	 * any non zero number. For final there is no hwh walk needed.
+	 */
+
+	if (req->nbytes) {
+		rc = phmac_kmac_update(req, true);
+		if (rc == -EKEYEXPIRED) {
+			/*
+			 * Protected key expired, conversion is in process.
+			 * Trigger a re-schedule of this request by returning
+			 * -ENOSPC ("hardware queue full") to the crypto engine.
+			 * To avoid immediately re-invocation of this callback,
+			 * tell scheduler to voluntarily give up the CPU here.
+			 */
+			pr_debug("rescheduling request\n");
+			cond_resched();
+			return -ENOSPC;
+		} else if (rc) {
+			hwh_advance(hwh, rc);
+			goto out;
+		}
+		req->nbytes = 0;
+	}
+
+	if (req_ctx->final) {
+		rc = phmac_kmac_final(req, true);
+		if (rc == -EKEYEXPIRED) {
+			/*
+			 * Protected key expired, conversion is in process.
+			 * Trigger a re-schedule of this request by returning
+			 * -ENOSPC ("hardware queue full") to the crypto engine.
+			 * To avoid immediately re-invocation of this callback,
+			 * tell scheduler to voluntarily give up the CPU here.
+			 */
+			pr_debug("rescheduling request\n");
+			cond_resched();
+			return -ENOSPC;
+		}
+	}
+
+out:
+	if (rc || req_ctx->final)
+		memzero_explicit(kmac_ctx, sizeof(*kmac_ctx));
+	pr_debug("request complete with rc=%d\n", rc);
+	local_bh_disable();
+	atomic_dec(&tfm_ctx->via_engine_ctr);
+	crypto_finalize_hash_request(engine, req, rc);
+	local_bh_enable();
+	return rc;
+}
+
+#define S390_ASYNC_PHMAC_ALG(x)						\
+{									\
+	.base = {							\
+		.init	  = phmac_init,					\
+		.update	  = phmac_update,				\
+		.final	  = phmac_final,				\
+		.finup	  = phmac_finup,				\
+		.digest	  = phmac_digest,				\
+		.setkey	  = phmac_setkey,				\
+		.import	  = phmac_import,				\
+		.export	  = phmac_export,				\
+		.init_tfm = phmac_init_tfm,				\
+		.exit_tfm = phmac_exit_tfm,				\
+		.halg = {						\
+			.digestsize = SHA##x##_DIGEST_SIZE,		\
+			.statesize  = sizeof(struct kmac_sha2_ctx),	\
+			.base = {					\
+				.cra_name = "phmac(sha" #x ")",		\
+				.cra_driver_name = "phmac_s390_sha" #x,	\
+				.cra_blocksize = SHA##x##_BLOCK_SIZE,	\
+				.cra_priority = 400,			\
+				.cra_flags = CRYPTO_ALG_ASYNC,		\
+				.cra_ctxsize = sizeof(struct phmac_tfm_ctx), \
+				.cra_module = THIS_MODULE,		\
+			},						\
+		},							\
+	},								\
+	.op = {								\
+		.do_one_request = phmac_do_one_request,			\
+	},								\
+}
+
+static struct phmac_alg {
+	unsigned int fc;
+	struct ahash_engine_alg alg;
+	bool registered;
+} phmac_algs[] = {
+	{
+		.fc = CPACF_KMAC_PHMAC_SHA_224,
+		.alg = S390_ASYNC_PHMAC_ALG(224),
+	}, {
+		.fc = CPACF_KMAC_PHMAC_SHA_256,
+		.alg = S390_ASYNC_PHMAC_ALG(256),
+	}, {
+		.fc = CPACF_KMAC_PHMAC_SHA_384,
+		.alg = S390_ASYNC_PHMAC_ALG(384),
+	}, {
+		.fc = CPACF_KMAC_PHMAC_SHA_512,
+		.alg = S390_ASYNC_PHMAC_ALG(512),
+	}
+};
+
+static struct miscdevice phmac_dev = {
+	.name	= "phmac",
+	.minor	= MISC_DYNAMIC_MINOR,
+};
+
+static void s390_phmac_exit(void)
+{
+	struct phmac_alg *phmac;
+	int i;
+
+	if (phmac_crypto_engine) {
+		crypto_engine_stop(phmac_crypto_engine);
+		crypto_engine_exit(phmac_crypto_engine);
+	}
+
+	for (i = ARRAY_SIZE(phmac_algs) - 1; i >= 0; i--) {
+		phmac = &phmac_algs[i];
+		if (phmac->registered)
+			crypto_engine_unregister_ahash(&phmac->alg);
+	}
+
+	misc_deregister(&phmac_dev);
+}
+
+static int __init s390_phmac_init(void)
+{
+	struct phmac_alg *phmac;
+	int i, rc;
+
+	/* with this pseudo device alloc and start a crypto engine */
+	phmac_crypto_engine =
+		crypto_engine_alloc_init_and_set(phmac_dev.this_device,
+						 true, NULL, false, MAX_QLEN);
+	if (!phmac_crypto_engine) {
+		rc = -ENOMEM;
+		goto out_err;
+	}
+	rc = crypto_engine_start(phmac_crypto_engine);
+	if (rc) {
+		crypto_engine_exit(phmac_crypto_engine);
+		phmac_crypto_engine = NULL;
+		goto out_err;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(phmac_algs); i++) {
+		phmac = &phmac_algs[i];
+		if (!cpacf_query_func(CPACF_KMAC, phmac->fc))
+			continue;
+		rc = crypto_engine_register_ahash(&phmac->alg);
+		if (rc)
+			goto out_err;
+		phmac->registered = true;
+		pr_debug("%s registered\n", phmac->alg.base.halg.base.cra_name);
+	}
+
+	return 0;
+
+out_err:
+	s390_phmac_exit();
+	return rc;
+}
+
+module_init(s390_phmac_init);
+module_exit(s390_phmac_exit);
+
+MODULE_ALIAS_CRYPTO("phmac(sha224)");
+MODULE_ALIAS_CRYPTO("phmac(sha256)");
+MODULE_ALIAS_CRYPTO("phmac(sha384)");
+MODULE_ALIAS_CRYPTO("phmac(sha512)");
+
+MODULE_DESCRIPTION("S390 HMAC driver for protected keys");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 47082782008a..639bb17fc97b 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -187,6 +187,18 @@ config CRYPTO_PAES_S390
 	  Select this option if you want to use the paes cipher
 	  for example to use protected key encrypted devices.
 
+config CRYPTO_PHMAC_S390
+	tristate "PHMAC cipher algorithms"
+	depends on S390
+	depends on PKEY
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  protected key HMAC support for SHA224, SHA256, SHA384 and SHA512.
+
+	  Select this option if you want to use the phmac digests
+	  for example to use dm-integrity with secure/protected keys.
+
 config S390_PRNG
 	tristate "Pseudo random number generator device driver"
 	depends on S390
-- 
2.43.0


