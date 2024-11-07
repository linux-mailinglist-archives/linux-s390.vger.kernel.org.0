Return-Path: <linux-s390+bounces-6992-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8629C0962
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2024 15:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44901F24AA6
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2024 14:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862CD20FA81;
	Thu,  7 Nov 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Legtdh+o"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650AB212EE1;
	Thu,  7 Nov 2024 14:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991335; cv=none; b=fp80VSlW0nK3jY75Q2rPyefJi8ATo0HclcMT1pR+RKSKcSr7bWZym54j/fUvq7XpuUFYZll3fQZNa0AZzzIafX4Bd1HJsCELvsmN1tiVZ9adrJKCsQUfhvBK1JKJ8qTRGmvzkOob6kclRcHLkgVTufb7Odtm0pp80n2jo2NgGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991335; c=relaxed/simple;
	bh=CmwHGpymvrXNXZ/PzbB9xeW0Wd0n1/ff6hwDivbBsMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wa5396GKxGaINqN1k3QYOlE2C+Fd3swIA2yGipGYTuymT2X719/Vg6Db1dT9PuKlf0wntui6sbWS1J2qACbXzCKlnDm3ppwaFCDmFT7d4+DdW/rzlf89Yl6CIoLYfzTwl9p3HWYYmEfizhIEAbdzMrm6eHKGpsgVypu+4TwEM2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Legtdh+o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DlsZQ000571;
	Thu, 7 Nov 2024 14:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dqconioEwlagYcODE
	oMaJ2OVxepaDk3IDxmBkEF/QvA=; b=Legtdh+oZ9f6B02wZlGUGb+5sAfGosWSH
	/tJZMfDcmlQ6Kn4hDfZ5hQO3U9mPsj4LhfP7k4QpusUR6xH0UGIzi1aJIxiICKv5
	h7kNTpj7KEN7h6LfaKkK1g1wlgR77Va0abHCo5XSi+bKE2VtNJjaGMrpZ08TWx5t
	TZumAOneWzFJ7Nq08UGx2G6PaLpmWFO+Etjqolsp6o06oFHlsjHxSlJx4BdRGwD5
	OEFNEU0hM95GTKyIwzB+MzvDBfPpufxGOR+LZenfht9cKEJ/M8bkIdF13AfsTpUw
	0oRyN14NFbzNl8cFfbbwZtZ2GFSWr0zvynb7ZOwu1g1ZRmyovWf5Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rwag8skq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:55:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7DcuAh008453;
	Thu, 7 Nov 2024 14:55:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nywm78fr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 14:55:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A7EtNOM58917266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 14:55:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 984A920040;
	Thu,  7 Nov 2024 14:55:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27DE420043;
	Thu,  7 Nov 2024 14:55:23 +0000 (GMT)
Received: from funtu2.boeblingen.de.ibm.com (unknown [9.152.224.229])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 14:55:23 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        hca@linux.ibm.com
Cc: linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH v3 3/3] s390/crypto: New s390 specific shash phmac
Date: Thu,  7 Nov 2024 15:55:21 +0100
Message-ID: <20241107145521.424769-4-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241107145521.424769-1-freude@linux.ibm.com>
References: <20241107145521.424769-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8M5ko2eGMry7_nu6PfXolemp56PWxH8j
X-Proofpoint-ORIG-GUID: 8M5ko2eGMry7_nu6PfXolemp56PWxH8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411070114

From: Holger Dengler <dengler@linux.ibm.com>

Add support for protected key hmac ("phmac") for s390 arch.

With the latest machine generation there is now support for
protected key (that is a key wrapped by a master key stored
in firmware) hmac for sha2 (sha224, sha256, sha384 and sha512)
for the s390 specific CPACF instruction kmac.

This patch adds support via 4 new shashes registered as
phmac(sha224), phmac(sha256), phmac(sha384) and phmac(sha512).

Please note that as of now, there is no selftest enabled for
these shashes, but the implementation has been tested with
testcases via AF_ALG interface.

Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 arch/s390/crypto/Makefile         |   1 +
 arch/s390/crypto/phmac_s390.c     | 473 ++++++++++++++++++++++++++++++
 drivers/crypto/Kconfig            |  12 +
 5 files changed, 488 insertions(+)
 create mode 100644 arch/s390/crypto/phmac_s390.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 6b602d972e91..a8ba72e7162d 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -804,6 +804,7 @@ CONFIG_PKEY_EP11=m
 CONFIG_PKEY_PCKMO=m
 CONFIG_PKEY_UV=m
 CONFIG_CRYPTO_PAES_S390=m
+CONFIG_CRYPTO_PHMAC_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 7844b9f5851b..cd2e9c94b736 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -790,6 +790,7 @@ CONFIG_PKEY_EP11=m
 CONFIG_PKEY_PCKMO=m
 CONFIG_PKEY_UV=m
 CONFIG_CRYPTO_PAES_S390=m
+CONFIG_CRYPTO_PHMAC_S390=m
 CONFIG_CRYPTO_DEV_VIRTIO=m
 CONFIG_SYSTEM_BLACKLIST_KEYRING=y
 CONFIG_CORDIC=m
diff --git a/arch/s390/crypto/Makefile b/arch/s390/crypto/Makefile
index a0cb96937c3d..47637140b95c 100644
--- a/arch/s390/crypto/Makefile
+++ b/arch/s390/crypto/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_S390_PRNG) += prng.o
 obj-$(CONFIG_CRYPTO_GHASH_S390) += ghash_s390.o
 obj-$(CONFIG_CRYPTO_CRC32_S390) += crc32-vx_s390.o
 obj-$(CONFIG_CRYPTO_HMAC_S390) += hmac_s390.o
+obj-$(CONFIG_CRYPTO_PHMAC_S390) += phmac_s390.o
 obj-y += arch_random.o
 
 crc32-vx_s390-y := crc32-vx.o crc32le-vx.o crc32be-vx.o
diff --git a/arch/s390/crypto/phmac_s390.c b/arch/s390/crypto/phmac_s390.c
new file mode 100644
index 000000000000..77a5244b2eb4
--- /dev/null
+++ b/arch/s390/crypto/phmac_s390.c
@@ -0,0 +1,473 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright IBM Corp. 2024
+ *
+ * s390 specific HMAC support for protected keys.
+ */
+
+#define KMSG_COMPONENT	"phmac_s390"
+#define pr_fmt(fmt)	KMSG_COMPONENT ": " fmt
+
+#include <asm/cpacf.h>
+#include <asm/pkey.h>
+#include <crypto/sha2.h>
+#include <crypto/internal/hash.h>
+#include <linux/cpufeature.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
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
+ * cv	| 224/256 | blocksize/2 |   32 |  u64[8]
+ *	| 384/512 |		|   64 | u128[8]
+ * imbl | 224/256 | blocksize/8 |    8 |     u64
+ *	| 384/512 |		|   16 |    u128
+ * key	| 224/256 | blocksize	|   96 |  u8[96]
+ *	| 384/512 |		|  160 | u8[160]
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
+#define PHMAC_SHA256_KEY_SIZE	(SHA256_BLOCK_SIZE + 32)
+#define PHMAC_SHA512_KEY_SIZE	(SHA512_BLOCK_SIZE + 32)
+#define PHMAC_MAX_KEY_SIZE	PHMAC_SHA512_KEY_SIZE
+
+struct phmac_protkey {
+	u32 type;
+	u32 len;
+	u8 protkey[PHMAC_MAX_KEY_SIZE];
+};
+
+struct s390_phmac_ctx {
+	u8 *key;
+	unsigned int keylen;
+
+	struct phmac_protkey pk;
+	/* spinlock to atomic update pk */
+	spinlock_t pk_lock;
+};
+
+union s390_kmac_gr0 {
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
+struct s390_kmac_sha2_ctx {
+	u8 param[MAX_DIGEST_SIZE + MAX_IMBL_SIZE + PHMAC_MAX_KEY_SIZE];
+	union s390_kmac_gr0 gr0;
+	u8 buf[MAX_BLOCK_SIZE];
+	unsigned int buflen;
+};
+
+/*
+ * kmac_sha2_set_imbl - sets the input message bit-length based on the blocksize
+ */
+static inline void kmac_sha2_set_imbl(u8 *param, unsigned int buflen,
+				      unsigned int blocksize)
+{
+	u8 *imbl = param + SHA2_IMBL_OFFSET(blocksize);
+
+	switch (blocksize) {
+	case SHA256_BLOCK_SIZE:
+		*(u64 *)imbl = (u64)buflen * BITS_PER_BYTE;
+		break;
+	case SHA512_BLOCK_SIZE:
+		*(u128 *)imbl = (u128)buflen * BITS_PER_BYTE;
+		break;
+	default:
+		break;
+	}
+}
+
+static inline int phmac_keyblob2pkey(const u8 *key, unsigned int keylen,
+				     struct phmac_protkey *pk)
+{
+	int i, rc = -EIO;
+
+	/* try three times in case of busy card */
+	for (i = 0; rc && i < 3; i++) {
+		if (rc == -EBUSY && in_task()) {
+			if (msleep_interruptible(1000))
+				return -EINTR;
+		}
+		rc = pkey_key2protkey(key, keylen,
+				      pk->protkey, &pk->len, &pk->type);
+	}
+
+	return rc;
+}
+
+static inline int phmac_convert_key(struct crypto_shash *tfm)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(tfm);
+	struct phmac_protkey pk;
+	int rc;
+
+	pk.len = sizeof(pk.protkey);
+	rc = phmac_keyblob2pkey(tfm_ctx->key, tfm_ctx->keylen, &pk);
+	if (rc)
+		goto out;
+
+	rc = -EINVAL;
+	switch (crypto_shash_digestsize(tfm)) {
+	case SHA224_DIGEST_SIZE:
+	case SHA256_DIGEST_SIZE:
+		if (pk.type != PKEY_KEYTYPE_HMAC_512)
+			goto out;
+		break;
+	case SHA384_DIGEST_SIZE:
+	case SHA512_DIGEST_SIZE:
+		if (pk.type != PKEY_KEYTYPE_HMAC_1024)
+			goto out;
+		break;
+	default:
+		goto out;
+	}
+
+	spin_lock_bh(&tfm_ctx->pk_lock);
+	tfm_ctx->pk = pk;
+	spin_unlock_bh(&tfm_ctx->pk_lock);
+
+	rc = 0;
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static inline int s390_phmac_sha2_setkey(struct crypto_shash *tfm,
+					 const u8 *key, unsigned int keylen)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(tfm);
+
+	if (tfm_ctx->keylen) {
+		kfree_sensitive(tfm_ctx->key);
+		tfm_ctx->key = NULL;
+		tfm_ctx->keylen = 0;
+	}
+
+	tfm_ctx->key = kmemdup(key, keylen, GFP_ATOMIC);
+	if (!tfm_ctx->key)
+		return -ENOMEM;
+	tfm_ctx->keylen = keylen;
+
+	return 0;
+}
+
+static int s390_phmac_sha2_init(struct shash_desc *desc)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(desc->tfm);
+	struct s390_kmac_sha2_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int bs = crypto_shash_blocksize(desc->tfm);
+	int rc;
+
+	rc = phmac_convert_key(desc->tfm);
+	if (rc)
+		goto out;
+
+	spin_lock_bh(&tfm_ctx->pk_lock);
+	memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+	       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+	spin_unlock_bh(&tfm_ctx->pk_lock);
+
+	ctx->buflen = 0;
+	ctx->gr0.reg = 0;
+
+	switch (crypto_shash_digestsize(desc->tfm)) {
+	case SHA224_DIGEST_SIZE:
+		ctx->gr0.fc = CPACF_KMAC_PHMAC_SHA_224;
+		break;
+	case SHA256_DIGEST_SIZE:
+		ctx->gr0.fc = CPACF_KMAC_PHMAC_SHA_256;
+		break;
+	case SHA384_DIGEST_SIZE:
+		ctx->gr0.fc = CPACF_KMAC_PHMAC_SHA_384;
+		break;
+	case SHA512_DIGEST_SIZE:
+		ctx->gr0.fc = CPACF_KMAC_PHMAC_SHA_512;
+		break;
+	default:
+		rc = -EINVAL;
+	}
+
+out:
+	pr_debug("rc=%d\n", rc);
+	return rc;
+}
+
+static int s390_phmac_sha2_update(struct shash_desc *desc,
+				  const u8 *data, unsigned int len)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(desc->tfm);
+	struct s390_kmac_sha2_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int bs = crypto_shash_blocksize(desc->tfm);
+	unsigned int offset, n, k;
+
+	/* check current buffer */
+	offset = ctx->buflen % bs;
+	ctx->buflen += len;
+	if (offset + len < bs)
+		goto store;
+
+	/* process one stored block */
+	if (offset) {
+		n = bs - offset;
+		memcpy(ctx->buf + offset, data, n);
+		ctx->gr0.iimp = 1;
+		for (k = bs;;) {
+			k -= _cpacf_kmac(&ctx->gr0.reg, ctx->param,
+					 ctx->buf + bs - k, k);
+			if (!k)
+				break;
+			if (phmac_convert_key(desc->tfm))
+				return -EIO;
+			spin_lock_bh(&tfm_ctx->pk_lock);
+			memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+			       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+			spin_unlock_bh(&tfm_ctx->pk_lock);
+		}
+		data += n;
+		len -= n;
+		offset = 0;
+	}
+	/* process as many blocks as possible */
+	if (len >= bs) {
+		n = (len / bs) * bs;
+		ctx->gr0.iimp = 1;
+		for (k = n;;) {
+			k -= _cpacf_kmac(&ctx->gr0.reg, ctx->param,
+					 data + n - k, k);
+			if (!k)
+				break;
+			if (phmac_convert_key(desc->tfm))
+				return -EIO;
+			spin_lock_bh(&tfm_ctx->pk_lock);
+			memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+			       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+			spin_unlock_bh(&tfm_ctx->pk_lock);
+		}
+		data += n;
+		len -= n;
+	}
+store:
+	/* store incomplete block in buffer */
+	if (len)
+		memcpy(ctx->buf + offset, data, len);
+
+	return 0;
+}
+
+static int s390_phmac_sha2_final(struct shash_desc *desc, u8 *out)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(desc->tfm);
+	struct s390_kmac_sha2_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int bs = crypto_shash_blocksize(desc->tfm);
+	unsigned int n, k;
+
+	n = ctx->buflen % bs;
+	ctx->gr0.iimp = 0;
+	kmac_sha2_set_imbl(ctx->param, ctx->buflen, bs);
+	for (k = n;;) {
+		k -= _cpacf_kmac(&ctx->gr0.reg, ctx->param,
+				 ctx->buf + n - k, k);
+		if (!k)
+			break;
+		if (phmac_convert_key(desc->tfm))
+			return -EIO;
+		spin_lock_bh(&tfm_ctx->pk_lock);
+		memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+		       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+		spin_unlock_bh(&tfm_ctx->pk_lock);
+	}
+	memcpy(out, ctx->param, crypto_shash_digestsize(desc->tfm));
+
+	return 0;
+}
+
+static int s390_phmac_sha2_digest(struct shash_desc *desc,
+				  const u8 *data, unsigned int len, u8 *out)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(desc->tfm);
+	struct s390_kmac_sha2_ctx *ctx = shash_desc_ctx(desc);
+	unsigned int ds = crypto_shash_digestsize(desc->tfm);
+	unsigned int bs = crypto_shash_blocksize(desc->tfm);
+	unsigned int k;
+	int rc;
+
+	rc = s390_phmac_sha2_init(desc);
+	if (rc)
+		return rc;
+
+	ctx->gr0.iimp = 0;
+	kmac_sha2_set_imbl(ctx->param, len, bs);
+	for (k = len;;) {
+		k -= _cpacf_kmac(&ctx->gr0.reg, ctx->param,
+				 data + len - k, k);
+		if (!k)
+			break;
+		if (phmac_convert_key(desc->tfm))
+			return -EIO;
+		spin_lock_bh(&tfm_ctx->pk_lock);
+		memcpy(ctx->param + SHA2_KEY_OFFSET(bs),
+		       tfm_ctx->pk.protkey, tfm_ctx->pk.len);
+		spin_unlock_bh(&tfm_ctx->pk_lock);
+	}
+	memcpy(out, ctx->param, ds);
+
+	return 0;
+}
+
+static int s390_phmac_sha2_init_tfm(struct crypto_shash *tfm)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(tfm);
+
+	tfm_ctx->key = NULL;
+	tfm_ctx->keylen = 0;
+	spin_lock_init(&tfm_ctx->pk_lock);
+
+	return 0;
+}
+
+static void s390_phmac_sha2_exit_tfm(struct crypto_shash *tfm)
+{
+	struct s390_phmac_ctx *tfm_ctx = crypto_shash_ctx(tfm);
+
+	memzero_explicit(&tfm_ctx->pk, sizeof(tfm_ctx->pk));
+	kfree_sensitive(tfm_ctx->key);
+}
+
+static int s390_phmac_sha2_clone_tfm(struct crypto_shash *dst,
+				     struct crypto_shash *src)
+{
+	struct s390_phmac_ctx *src_ctx = crypto_shash_ctx(src);
+	int rc;
+
+	rc = s390_phmac_sha2_init_tfm(dst);
+	if (rc)
+		return rc;
+
+	if (src_ctx->key && src_ctx->keylen)
+		rc = s390_phmac_sha2_setkey(dst, src_ctx->key, src_ctx->keylen);
+
+	return rc;
+}
+
+#define S390_HMAC_SHA2_ALG(x) {						\
+	.fc = CPACF_KMAC_PHMAC_SHA_##x,					\
+	.alg = {							\
+		.init = s390_phmac_sha2_init,				\
+		.update = s390_phmac_sha2_update,			\
+		.final = s390_phmac_sha2_final,				\
+		.digest = s390_phmac_sha2_digest,			\
+		.setkey = s390_phmac_sha2_setkey,			\
+		.init_tfm = s390_phmac_sha2_init_tfm,			\
+		.exit_tfm = s390_phmac_sha2_exit_tfm,			\
+		.clone_tfm = s390_phmac_sha2_clone_tfm,			\
+		.descsize = sizeof(struct s390_kmac_sha2_ctx),		\
+		.halg = {						\
+			.digestsize = SHA##x##_DIGEST_SIZE,		\
+			.base = {					\
+				.cra_name = "phmac(sha" #x ")",		\
+				.cra_driver_name = "phmac_s390_sha" #x,	\
+				.cra_blocksize = SHA##x##_BLOCK_SIZE,	\
+				.cra_priority = 400,			\
+				.cra_ctxsize = sizeof(struct s390_phmac_ctx), \
+				.cra_module = THIS_MODULE,		\
+			},						\
+		},							\
+	},								\
+}
+
+static struct s390_hmac_alg {
+	bool registered;
+	unsigned int fc;
+	struct shash_alg alg;
+} s390_hmac_algs[] = {
+	S390_HMAC_SHA2_ALG(224),
+	S390_HMAC_SHA2_ALG(256),
+	S390_HMAC_SHA2_ALG(384),
+	S390_HMAC_SHA2_ALG(512),
+};
+
+static __always_inline void _s390_hmac_algs_unregister(void)
+{
+	struct s390_hmac_alg *hmac;
+	int i;
+
+	for (i = ARRAY_SIZE(s390_hmac_algs) - 1; i >= 0; i--) {
+		hmac = &s390_hmac_algs[i];
+		if (!hmac->registered)
+			continue;
+		crypto_unregister_shash(&hmac->alg);
+	}
+}
+
+static int __init phmac_s390_init(void)
+{
+	struct s390_hmac_alg *hmac;
+	int i, rc = -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(s390_hmac_algs); i++) {
+		hmac = &s390_hmac_algs[i];
+		if (!cpacf_query_func(CPACF_KMAC, hmac->fc))
+			continue;
+
+		rc = crypto_register_shash(&hmac->alg);
+		if (rc) {
+			pr_err("unable to register %s\n",
+			       hmac->alg.halg.base.cra_name);
+			goto out;
+		}
+		hmac->registered = true;
+		pr_debug("registered %s\n", hmac->alg.halg.base.cra_name);
+	}
+	return rc;
+out:
+	_s390_hmac_algs_unregister();
+	return rc;
+}
+
+static void __exit phmac_s390_exit(void)
+{
+	_s390_hmac_algs_unregister();
+}
+
+module_init(phmac_s390_init);
+module_exit(phmac_s390_exit);
+
+MODULE_DESCRIPTION("S390 HMAC driver for protected keys");
+MODULE_LICENSE("GPL");
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0a9cdd31cbd9..519305e04f18 100644
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


