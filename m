Return-Path: <linux-s390+bounces-8835-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B8A29B0F
	for <lists+linux-s390@lfdr.de>; Wed,  5 Feb 2025 21:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FC918887B5
	for <lists+linux-s390@lfdr.de>; Wed,  5 Feb 2025 20:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7B211A0B;
	Wed,  5 Feb 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="io+bFkbg"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA920CCDD
	for <linux-s390@vger.kernel.org>; Wed,  5 Feb 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786941; cv=none; b=WSTrVMFSGIwLuS60fyyM1lRQNKlAmnj1hUx5vh5biMwin9djy7GiChnaEWMt3nOUJLxX54qrf+JfIQD4gQWyVDDijcRjZDGkermzN+x00q8waxkWg3/7aMnyTkiBQqTjcYCGDHurw9pOrBfOfxtKX0YWPhX8T1de3g0xl+Ps688=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786941; c=relaxed/simple;
	bh=WRBprM4GKmPEhRr4XZqz8zMk+4LdNRdIAMoS2XqFKFg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=PgbWLfDN9FB7ViqlynT/gIpbWEsf8EwmlryD8Ya9yZDoREF0HI00yRzE4UayzyugeZyqmJs9uiOzZTewV8TtiQC3CvyKZ8gXkzAO8uNM3nlZwp0LwHOpjRg6ORzhVs2PPp1QYcEDpFwzOxV6KZaq6xnKBdmBOQ/bipwPPOhEp6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=io+bFkbg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738786937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MeJPYQajHO+49u+HQQk61hf2YffQJ/LKv+qj7gpuZ90=;
	b=io+bFkbgihEHxFgKISw1dSEKJNdbjbLQcc0aEPZk1k6ohxPW6VEwPwcAbmU2G6kwmNuqhi
	K4YAWLhRdOf1qLEJyA73ZhmBM0BOZQoGjNBZr0RrzxlPezMOKlXY3fAd9q37l52XpUrUib
	zxrBB+8ndaZSUMcCsXUjjyLViAcYPpU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-127-xn8JxcATNYCCaM2wIt0zwQ-1; Wed,
 05 Feb 2025 15:22:14 -0500
X-MC-Unique: xn8JxcATNYCCaM2wIt0zwQ-1
X-Mimecast-MFC-AGG-ID: xn8JxcATNYCCaM2wIt0zwQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1C361800373;
	Wed,  5 Feb 2025 20:22:12 +0000 (UTC)
Received: from [10.45.224.44] (unknown [10.45.224.44])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C52A91955BCB;
	Wed,  5 Feb 2025 20:22:09 +0000 (UTC)
Date: Wed, 5 Feb 2025 21:22:07 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, agk@redhat.com, 
    snitzer@kernel.org, linux-s390@vger.kernel.org, dm-devel@lists.linux.dev, 
    herbert@gondor.apana.org.au, Milan Broz <gmazyland@gmail.com>
Subject: [PATCH v4 1/2] dm-integrity: use internal variable for digestsize
Message-ID: <6708dedf-7968-1a01-d55a-f2fbb97247a2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Instead of calling digestsize() each time the digestsize for
the internal hash is needed, store the digestsize in a new
field internal_hash_digestsize within struct dm_integrity_c
once and use this value when needed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-integrity.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index ee9f7cecd78e..9ab0f0836c86 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -222,6 +222,7 @@ struct dm_integrity_c {
 	int failed;
 
 	struct crypto_shash *internal_hash;
+	unsigned int internal_hash_digestsize;
 
 	struct dm_target *ti;
 
@@ -1676,7 +1677,7 @@ static void integrity_sector_checksum(struct dm_integrity_c *ic, sector_t sector
 		goto failed;
 	}
 
-	digest_size = crypto_shash_digestsize(ic->internal_hash);
+	digest_size = ic->internal_hash_digestsize;
 	if (unlikely(digest_size < ic->tag_size))
 		memset(result + digest_size, 0, ic->tag_size - digest_size);
 
@@ -1776,7 +1777,7 @@ static void integrity_metadata(struct work_struct *w)
 	if (ic->internal_hash) {
 		struct bvec_iter iter;
 		struct bio_vec bv;
-		unsigned int digest_size = crypto_shash_digestsize(ic->internal_hash);
+		unsigned int digest_size = ic->internal_hash_digestsize;
 		struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
 		char *checksums;
 		unsigned int extra_space = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
@@ -2124,7 +2125,7 @@ static bool __journal_read_write(struct dm_integrity_io *dio, struct bio *bio,
 				} while (++s < ic->sectors_per_block);
 
 				if (ic->internal_hash) {
-					unsigned int digest_size = crypto_shash_digestsize(ic->internal_hash);
+					unsigned int digest_size = ic->internal_hash_digestsize;
 
 					if (unlikely(digest_size > ic->tag_size)) {
 						char checksums_onstack[HASH_MAX_DIGESTSIZE];
@@ -2428,7 +2429,7 @@ static int dm_integrity_map_inline(struct dm_integrity_io *dio, bool from_map)
 	if (!dio->integrity_payload) {
 		unsigned digest_size, extra_size;
 		dio->payload_len = ic->tuple_size * (bio_sectors(bio) >> ic->sb->log2_sectors_per_block);
-		digest_size = crypto_shash_digestsize(ic->internal_hash);
+		digest_size = ic->internal_hash_digestsize;
 		extra_size = unlikely(digest_size > ic->tag_size) ? digest_size - ic->tag_size : 0;
 		dio->payload_len += extra_size;
 		dio->integrity_payload = kmalloc(dio->payload_len, GFP_NOIO | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN);
@@ -2595,7 +2596,8 @@ static void dm_integrity_inline_recheck(struct work_struct *w)
 		bio_put(outgoing_bio);
 
 		integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, outgoing_data, digest);
-		if (unlikely(memcmp(digest, dio->integrity_payload, min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
+		if (unlikely(memcmp(digest, dio->integrity_payload,
+				    min(ic->internal_hash_digestsize, ic->tag_size)))) {
 			DMERR_LIMIT("%pg: Checksum failed at sector 0x%llx",
 				ic->dev->bdev, dio->bio_details.bi_iter.bi_sector);
 			atomic64_inc(&ic->number_of_mismatches);
@@ -2635,7 +2637,7 @@ static int dm_integrity_end_io(struct dm_target *ti, struct bio *bio, blk_status
 				//memset(mem, 0xff, ic->sectors_per_block << SECTOR_SHIFT);
 				integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem, digest);
 				if (unlikely(memcmp(digest, dio->integrity_payload + pos,
-						min(crypto_shash_digestsize(ic->internal_hash), ic->tag_size)))) {
+						min(ic->internal_hash_digestsize, ic->tag_size)))) {
 					kunmap_local(mem);
 					dm_integrity_free_payload(dio);
 					INIT_WORK(&dio->work, dm_integrity_inline_recheck);
@@ -3017,8 +3019,8 @@ static void integrity_recalc(struct work_struct *w)
 		goto free_ret;
 	}
 	recalc_tags_size = (recalc_sectors >> ic->sb->log2_sectors_per_block) * ic->tag_size;
-	if (crypto_shash_digestsize(ic->internal_hash) > ic->tag_size)
-		recalc_tags_size += crypto_shash_digestsize(ic->internal_hash) - ic->tag_size;
+	if (ic->internal_hash_digestsize > ic->tag_size)
+		recalc_tags_size += ic->internal_hash_digestsize - ic->tag_size;
 	recalc_tags = kvmalloc(recalc_tags_size, GFP_NOIO);
 	if (!recalc_tags) {
 		vfree(recalc_buffer);
@@ -3177,8 +3179,8 @@ static void integrity_recalc_inline(struct work_struct *w)
 	}
 
 	recalc_tags_size = (recalc_sectors >> ic->sb->log2_sectors_per_block) * ic->tuple_size;
-	if (crypto_shash_digestsize(ic->internal_hash) > ic->tuple_size)
-		recalc_tags_size += crypto_shash_digestsize(ic->internal_hash) - ic->tuple_size;
+	if (ic->internal_hash_digestsize > ic->tuple_size)
+		recalc_tags_size += ic->internal_hash_digestsize - ic->tuple_size;
 	recalc_tags = kmalloc(recalc_tags_size, GFP_NOIO | __GFP_NOWARN);
 	if (!recalc_tags) {
 		kfree(recalc_buffer);
@@ -4695,6 +4697,8 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 		    "Invalid internal hash", "Error setting internal hash key");
 	if (r)
 		goto bad;
+	if (ic->internal_hash)
+		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_hash);
 
 	r = get_mac(&ic->journal_mac, &ic->journal_mac_alg, &ti->error,
 		    "Invalid journal mac", "Error setting journal mac key");
@@ -4707,7 +4711,7 @@ static int dm_integrity_ctr(struct dm_target *ti, unsigned int argc, char **argv
 			r = -EINVAL;
 			goto bad;
 		}
-		ic->tag_size = crypto_shash_digestsize(ic->internal_hash);
+		ic->tag_size = ic->internal_hash_digestsize;
 	}
 	if (ic->tag_size > MAX_TAG_SIZE) {
 		ti->error = "Too big tag size";


