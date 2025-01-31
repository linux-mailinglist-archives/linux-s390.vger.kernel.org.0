Return-Path: <linux-s390+bounces-8737-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D97A23BD6
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jan 2025 11:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6BAF3A9875
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jan 2025 10:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC4514B08E;
	Fri, 31 Jan 2025 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XKMKNHpF"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC2C145A18
	for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2025 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317808; cv=none; b=QpoBCKRMca5at1p1XoSrDPv8ngRklF8uFQtslOOr+aVspgD+w9uif4bUky2kEXNeSO6NENrEbGNVnvOHY6D14/HOO3eyOtpNCIUaj0a9tmzRBhiHH9AWNA3L76wTJNAXAlq4GLjCxdr/CNA+JxdQSoUDz6ouFHw1FwxpTpM6kDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317808; c=relaxed/simple;
	bh=sfTmv6UJeiHQauoDO0M76zyw0wSGSPZdTWhzcsqtDHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7DkA0DSJd1SP+HelF8QvPtVWg/WaMa3TFQcrHVwts0hj8OTPNLpc1AkHeMPqtk6PJarKVCF6NpLFsszf12sQjQ7Jtkk7nU8zRsm/PblgBQAHBz2FkUy6w2xDCJxd/zq0asYVRB807R0jrHZNuM/LfzCJSFGFffG20tIPm8lJYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XKMKNHpF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2OBch014461;
	Fri, 31 Jan 2025 10:03:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Dwv94uMM0AzhtzR0X
	mQyzVTe8yIEraJ+00lHfdgy3t4=; b=XKMKNHpFKOpQhl+m2kZURP/0hvHyGELvM
	SFURjFhf+cNgyxD4U/sil+Je0yw9nZgkSKOe+napiQdPTc2Zf6ipwaZh08dCv0R6
	0fx5BzyzBRfJOeR9ok4qDAdzcqzFURJI1fGI7tba5kkpTIVHwpTnNAZ1RiiQVMtd
	Y5u+/ihJg1v6+ZFw3V5rmYLDWhM8rtCuKkmi6Qtr71caZIfIn1UttRNAkgUcgLpJ
	B6Qvl0I7Vns4ahMOpq/gcuaW5arPwxGJzC3kKY1bYoLIlHLwMli1DB+i9THzja5U
	jhZbaB5EBpG8lARqqAQ03Wx4/ByzyOSgNKPidz7zvhZNy9j0rPftg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gfn4u4ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:03:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V8MOYh017346;
	Fri, 31 Jan 2025 10:03:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44gfaxb0mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:03:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VA35mw34276014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:03:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C98E6200EC;
	Fri, 31 Jan 2025 10:03:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D6D200EB;
	Fri, 31 Jan 2025 10:03:05 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 10:03:05 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, agk@redhat.com,
        snitzer@kernel.org, mpatocka@redhat.com
Cc: linux-s390@vger.kernel.org, dm-devel@lists.linux.dev,
        herbert@gondor.apana.org.au
Subject: [PATCH v3 2/2] dm-integrity: introduce ahash support for the internal hash
Date: Fri, 31 Jan 2025 11:03:04 +0100
Message-ID: <20250131100304.932064-3-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131100304.932064-1-freude@linux.ibm.com>
References: <20250131100304.932064-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LNHw028BThIuG3APcMHB4hcJ_wGyf2ur
X-Proofpoint-ORIG-GUID: LNHw028BThIuG3APcMHB4hcJ_wGyf2ur
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310075

Introduce ahash support for the "internal hash" algorithm.

Rework the dm-integrity code to be able to run the "internal hash"
either with a synchronous ("shash") or asynchronous ("ahash") hash
algorithm implementation.

The get_mac() function now tries to decide which of the digest
implemenations to use if there is a choice:
- If an ahash and shash tfm is available and both are backed by the
  same driver name it is assumed that the shash is the faster
  implementation and thus the shash tfm is delivered to the caller.
- If an ahash and shash tfm is available but the backing device driver
  divers (different driver names) it is assumed that the ahash
  implementation is a "better" hardware based implementation and thus
  the ahash tfm is delivered to the caller.
- If there is no choice, for example only an ahash or an shash
  implementation is available then this tfm is delivered to the
  caller. Especially in cases where only an ahash implementation is
  available this is now used instead of failing.
- The caller can steer this choice by passing a NULL to the ahash or
  shash parameter, thus enforcing to only allocate an algorithm of the
  remaining possibility.

The function integrity_sector_checksum() is now only a dispatcher
function calling one of the two new functions
integrity_ahash_sector_checksum() or integrity_shash_sector_checksum()
based on which tfm is allocated based on the two new fields
internal_shash and internal_ahash in struct dm_integrity_c.

Together with this comes some slight rework around availability and
digest size of the internal hash in use.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 drivers/md/dm-integrity.c | 221 +++++++++++++++++++++++++++++---------
 1 file changed, 172 insertions(+), 49 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 9ab0f0836c86..418bdc57054b 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -221,7 +221,9 @@ struct dm_integrity_c {
 
 	int failed;
 
-	struct crypto_shash *internal_hash;
+	bool have_internal_hash;
+	struct crypto_shash *internal_shash;
+	struct crypto_ahash *internal_ahash;
 	unsigned int internal_hash_digestsize;
 
 	struct dm_target *ti;
@@ -1635,57 +1637,128 @@ static void integrity_end_io(struct bio *bio)
 	dec_in_flight(dio);
 }
 
-static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector,
-				      const char *data, char *result)
+static bool integrity_shash_sector_checksum(struct dm_integrity_c *ic,
+					    sector_t sector, const char *data,
+					    char *result)
 {
 	__le64 sector_le = cpu_to_le64(sector);
-	SHASH_DESC_ON_STACK(req, ic->internal_hash);
+	SHASH_DESC_ON_STACK(req, ic->internal_shash);
 	int r;
-	unsigned int digest_size;
 
-	req->tfm = ic->internal_hash;
+	req->tfm = ic->internal_shash;
 
 	r = crypto_shash_init(req);
 	if (unlikely(r < 0)) {
 		dm_integrity_io_error(ic, "crypto_shash_init", r);
-		goto failed;
+		return false;
 	}
 
 	if (ic->sb->flags & cpu_to_le32(SB_FLAG_FIXED_HMAC)) {
 		r = crypto_shash_update(req, (__u8 *)&ic->sb->salt, SALT_SIZE);
 		if (unlikely(r < 0)) {
 			dm_integrity_io_error(ic, "crypto_shash_update", r);
-			goto failed;
+			return false;
 		}
 	}
 
 	r = crypto_shash_update(req, (const __u8 *)&sector_le, sizeof(sector_le));
 	if (unlikely(r < 0)) {
 		dm_integrity_io_error(ic, "crypto_shash_update", r);
-		goto failed;
+		return false;
 	}
 
 	r = crypto_shash_update(req, data, ic->sectors_per_block << SECTOR_SHIFT);
 	if (unlikely(r < 0)) {
 		dm_integrity_io_error(ic, "crypto_shash_update", r);
-		goto failed;
+		return false;
 	}
 
 	r = crypto_shash_final(req, result);
 	if (unlikely(r < 0)) {
 		dm_integrity_io_error(ic, "crypto_shash_final", r);
-		goto failed;
+		return false;
 	}
 
-	digest_size = ic->internal_hash_digestsize;
-	if (unlikely(digest_size < ic->tag_size))
-		memset(result + digest_size, 0, ic->tag_size - digest_size);
+	if (unlikely(ic->internal_hash_digestsize < ic->tag_size))
+		memset(result + ic->internal_hash_digestsize,
+		       0, ic->tag_size - ic->internal_hash_digestsize);
 
-	return;
+	return true;
+}
+
+static bool integrity_ahash_sector_checksum(struct dm_integrity_c *ic,
+					    sector_t sector, const char *data,
+					    char *result)
+{
+	struct ahash_request *req = NULL;
+	struct scatterlist sg[3], *s;
+	DECLARE_CRYPTO_WAIT(wait);
+	__le64 *sector_le = NULL;
+	unsigned int nbytes = 0;
+	int r = -ENOMEM;
+
+	req = ahash_request_alloc(ic->internal_ahash, GFP_KERNEL);
+	if (unlikely(!req)) {
+		dm_integrity_io_error(ic, "ahash_request_alloc", r);
+		return false;
+	}
+	ahash_request_set_callback(req, 0, crypto_req_done, &wait);
+
+	s = sg;
+	if (ic->sb->flags & cpu_to_le32(SB_FLAG_FIXED_HMAC)) {
+		sg_init_table(sg, 3);
+		sg_set_buf(s, (const __u8 *)&ic->sb->salt, SALT_SIZE);
+		nbytes += SALT_SIZE;
+		s++;
+	} else {
+		sg_init_table(sg, 2);
+	}
+
+	sector_le = kmalloc(sizeof(__le64), GFP_KERNEL);
+	if (unlikely(!sector_le)) {
+		dm_integrity_io_error(ic, "kmalloc(sizeof(__le64))", r);
+		goto out;
+	}
+	*sector_le = cpu_to_le64(sector);
+	sg_set_buf(s, (const __u8 *)sector_le, sizeof(*sector_le));
+	nbytes += sizeof(*sector_le);
+	s++;
+
+	sg_set_buf(s, data, ic->sectors_per_block << SECTOR_SHIFT);
+	nbytes += ic->sectors_per_block << SECTOR_SHIFT;
+
+	ahash_request_set_crypt(req, sg, result, nbytes);
+
+	r = crypto_wait_req(crypto_ahash_digest(req), &wait);
+	if (r) {
+		dm_integrity_io_error(ic, "crypto_ahash_digest", r);
+		goto out;
+	}
+
+	if (unlikely(ic->internal_hash_digestsize < ic->tag_size))
+		memset(result + ic->internal_hash_digestsize,
+		       0, ic->tag_size - ic->internal_hash_digestsize);
 
-failed:
-	/* this shouldn't happen anyway, the hash functions have no reason to fail */
-	get_random_bytes(result, ic->tag_size);
+out:
+	ahash_request_free(req);
+	kfree(sector_le);
+
+	return r ? false : true;
+}
+
+static void integrity_sector_checksum(struct dm_integrity_c *ic,
+				      sector_t sector, const char *data,
+				      char *result)
+{
+	bool r;
+
+	if (likely(ic->internal_shash))
+		r = integrity_shash_sector_checksum(ic, sector, data, result);
+	else
+		r = integrity_ahash_sector_checksum(ic, sector, data, result);
+
+	if (unlikely(!r))
+		get_random_bytes(result, ic->tag_size);
 }
 
 static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checksum)
@@ -1774,7 +1847,7 @@ static void integrity_metadata(struct work_struct *w)
 
 	int r;
 
-	if (ic->internal_hash) {
+	if (ic->have_internal_hash) {
 		struct bvec_iter iter;
 		struct bio_vec bv;
 		unsigned int digest_size = ic->internal_hash_digestsize;
@@ -1992,7 +2065,7 @@ static int dm_integrity_map(struct dm_target *ti, struct bio *bio)
 		return DM_MAPIO_KILL;
 
 	bip = bio_integrity(bio);
-	if (!ic->internal_hash) {
+	if (!ic->have_internal_hash) {
 		if (bip) {
 			unsigned int wanted_tag_size = bio_sectors(bio) >> ic->sb->log2_sectors_per_block;
 
@@ -2073,7 +2146,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 					mem_ptr += 1 << SECTOR_SHIFT;
 				} while (++s < ic->sectors_per_block);
 #ifdef INTERNAL_VERIFY
-				if (ic->internal_hash) {
+				if (ic->have_internal_hash) {
 					char checksums_onstack[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
@@ -2087,7 +2160,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 #endif
 			}
 
-			if (!ic->internal_hash) {
+			if (!ic->have_internal_hash) {
 				struct bio_integrity_payload *bip = bio_integrity(bio);
 				unsigned int tag_todo = ic->tag_size;
 				char *tag_ptr = journal_entry_tag(ic, je);
@@ -2124,7 +2197,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 					je->last_bytes[s] = js[s].commit_id;
 				} while (++s < ic->sectors_per_block);
 
-				if (ic->internal_hash) {
+				if (ic->have_internal_hash) {
 					unsigned int digest_size = ic->internal_hash_digestsize;
 
 					if (unlikely(digest_size > ic->tag_size)) {
@@ -2187,7 +2260,7 @@ static void dm_integrity_map_continue(struct dm_integrity_io *dio, bool from_map
 	sector_t recalc_sector;
 	struct completion read_comp;
 	bool discard_retried = false;
-	bool need_sync_io = ic->internal_hash && dio->op == REQ_OP_READ;
+	bool need_sync_io = ic->have_internal_hash && dio->op == REQ_OP_READ;
 
 	if (unlikely(dio->op == REQ_OP_DISCARD) && ic->mode != 'D')
 		need_sync_io = true;
@@ -2908,7 +2981,7 @@ static void do_journal_write(struct dm_integrity_c *ic, unsigned int write_start
 #ifndef INTERNAL_VERIFY
 				    unlikely(from_replay) &&
 #endif
-				    ic->internal_hash) {
+				    ic->have_internal_hash) {
 					char test_tag[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
 
 					integrity_sector_checksum(ic, sec + ((l - j) << ic->sb->log2_sectors_per_block),
@@ -3905,7 +3978,7 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->discard_granularity = ic->sectors_per_block << SECTOR_SHIFT;
 	}
 
-	if (!ic->internal_hash) {
+	if (!ic->have_internal_hash) {
 		struct blk_integrity *bi = &limits->integrity;
 
 		memset(bi, 0, sizeof(*bi));
@@ -4213,32 +4286,76 @@ static int get_alg_and_key(const char *arg, struct alg_spec *a, char **error, ch
 	return -ENOMEM;
 }
 
-static int get_mac(struct crypto_shash **hash, struct alg_spec *a, char **error,
+static int get_mac(struct crypto_shash **shash, struct crypto_ahash **ahash,
+		   struct alg_spec *a, char **error,
 		   char *error_alg, char *error_key)
 {
+	const char *ahash_driver_name = NULL;
 	int r;
 
-	if (a->alg_string) {
-		*hash = crypto_alloc_shash(a->alg_string, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
-		if (IS_ERR(*hash)) {
+	if (!a->alg_string || !(shash || ahash))
+		return 0;
+
+	if (ahash) {
+		*ahash = crypto_alloc_ahash(a->alg_string, 0, 0);
+		if (IS_ERR(*ahash)) {
 			*error = error_alg;
-			r = PTR_ERR(*hash);
-			*hash = NULL;
+			r = PTR_ERR(*ahash);
+			*ahash = NULL;
 			return r;
 		}
+		ahash_driver_name = crypto_ahash_driver_name(*ahash);
+	}
 
-		if (a->key) {
-			r = crypto_shash_setkey(*hash, a->key, a->key_size);
-			if (r) {
-				*error = error_key;
-				return r;
+	if (shash) {
+		*shash = crypto_alloc_shash(a->alg_string, 0, CRYPTO_ALG_ALLOCATES_MEMORY);
+		if (IS_ERR(*shash) && !ahash_driver_name) {
+			*error = error_alg;
+			r = PTR_ERR(*shash);
+			*shash = NULL;
+			return r;
+		}
+		if (!IS_ERR(shash) && ahash_driver_name) {
+			if (strcmp(crypto_shash_driver_name(*shash), ahash_driver_name)) {
+				/*
+				 * ahash gave a different driver than shash, so probably
+				 * this is a case of real hardware offload.  Use ahash.
+				 */
+				crypto_free_shash(*shash);
+				*shash = NULL;
+			} else {
+				/* ahash and shash are same driver. Use shash. */
+				crypto_free_ahash(*ahash);
+				*ahash = NULL;
 			}
-		} else if (crypto_shash_get_flags(*hash) & CRYPTO_TFM_NEED_KEY) {
+		}
+	}
+
+	/* either *ahash or *shash is set now */
+
+	if (a->key) {
+		r = shash && *shash ?
+			crypto_shash_setkey(*shash, a->key, a->key_size) :
+			crypto_ahash_setkey(*ahash, a->key, a->key_size);
+		if (r) {
 			*error = error_key;
-			return -ENOKEY;
+			return r;
 		}
+	} else if ((shash && *shash ?
+		    crypto_shash_get_flags(*shash) :
+		    crypto_ahash_get_flags(*ahash))
+		   & CRYPTO_TFM_NEED_KEY) {
+		*error = error_key;
+		return -ENOKEY;
 	}
 
+	pr_debug("Using %s %s (driver name %s)\n",
+		 ahash && *ahash ? "ahash" : "shash",
+		 a->alg_string,
+		 ahash && *ahash ?
+		 crypto_ahash_driver_name(*ahash) :
+		 crypto_shash_driver_name(*shash));
+
 	return 0;
 }
 
@@ -4693,20 +4810,24 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		buffer_sectors = 1;
 	ic->log2_buffer_sectors = min((int)__fls(buffer_sectors), 31 - SECTOR_SHIFT);
 
-	r = get_mac(&ic->internal_hash, &ic->internal_hash_alg, &ti->error,
+	r = get_mac(&ic->internal_shash, &ic->internal_ahash,
+		    &ic->internal_hash_alg, &ti->error,
 		    "Invalid internal hash", "Error setting internal hash key");
 	if (r)
 		goto bad;
-	if (ic->internal_hash)
-		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_hash);
+	ic->have_internal_hash = ic->internal_shash || ic->internal_ahash;
+	if (ic->have_internal_hash)
+		ic->internal_hash_digestsize = ic->internal_shash ?
+			crypto_shash_digestsize(ic->internal_shash) :
+			crypto_ahash_digestsize(ic->internal_ahash);
 
-	r = get_mac(&ic->journal_mac, &ic->journal_mac_alg, &ti->error,
+	r = get_mac(&ic->journal_mac, NULL, &ic->journal_mac_alg, &ti->error,
 		    "Invalid journal mac", "Error setting journal mac key");
 	if (r)
 		goto bad;
 
 	if (!ic->tag_size) {
-		if (!ic->internal_hash) {
+		if (!ic->have_internal_hash) {
 			ti->error = "Unknown tag size";
 			r = -EINVAL;
 			goto bad;
@@ -4770,13 +4891,13 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		}
 	}
 
-	if (ic->mode == 'B' && !ic->internal_hash) {
+	if (ic->mode == 'B' && !ic->have_internal_hash) {
 		r = -EINVAL;
 		ti->error = "Bitmap mode can be only used with internal hash";
 		goto bad;
 	}
 
-	if (ic->discard && !ic->internal_hash) {
+	if (ic->discard && !ic->have_internal_hash) {
 		r = -EINVAL;
 		ti->error = "Discard can be only used with internal hash";
 		goto bad;
@@ -5038,7 +5159,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		ic->sb->recalc_sector = cpu_to_le64(0);
 	}
 
-	if (ic->internal_hash) {
+	if (ic->have_internal_hash) {
 		ic->recalc_wq = alloc_workqueue("dm-integrity-recalc", WQ_MEM_RECLAIM, 1);
 		if (!ic->recalc_wq) {
 			ti->error = "Cannot allocate workqueue";
@@ -5229,8 +5350,10 @@ static void dm_integrity_dtr(struct dm_target *ti)
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
 
-	if (ic->internal_hash)
-		crypto_free_shash(ic->internal_hash);
+	if (ic->internal_shash)
+		crypto_free_shash(ic->internal_shash);
+	if (ic->internal_ahash)
+		crypto_free_ahash(ic->internal_ahash);
 	free_alg(&ic->internal_hash_alg);
 
 	if (ic->journal_crypt)
-- 
2.43.0


