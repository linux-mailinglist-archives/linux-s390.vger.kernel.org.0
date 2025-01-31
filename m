Return-Path: <linux-s390+bounces-8736-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005D1A23BD4
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jan 2025 11:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA6188A2CF
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jan 2025 10:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0920715B111;
	Fri, 31 Jan 2025 10:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePjTApVu"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527B317C225
	for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2025 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738317802; cv=none; b=a277UlRppQBIbD+0SQUr4peRj1YJw2IhNsC/LRKhukxT97k+5oeU6Y24+tYkYrYHmH2C5xLQelNn9yiGhYfsqqMSygDoPU/sAa3s1EK5jHQ6J65v2gC720Z/5k/opl1Y9/nVYq5AMr/O+/6MMcuLObELekHJf1lcVOB0HlLy6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738317802; c=relaxed/simple;
	bh=YMINWYio9onxDsSX5ySZiScInIUkqrWgU8BU8dbMPh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpZ0QhVpul3SyKu5/tNbVQODOI+DEhoyp3yt9hWMlmnq3G5CnxkVln/wsXuKzd7r8xLRz6B+NeDPhWAIpK+6lvmk5cvKog/vfgCQ8TPNrlFbX54qiNLmMhD6ttKDPBlRc8Nr7U5JzWNYETlkGg5HUXE2WWNDEd/UFX4pGBouGZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePjTApVu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2PHIi032083;
	Fri, 31 Jan 2025 10:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fGidHFQhTyijkTNe2
	/Fg5BqtUVRKUHMFZuE0dAvfn8s=; b=ePjTApVu7lPDe1fZ7VM2SWdxy3h/oJ77v
	d5M9uQO/MU/WDNtM3jq/5BrByQdkldrj/HXKn/4WRpazdO/csZBlxXsCI6SL3Jil
	uCfeoa7ZIsz/3LAHrLqUR5EzzzVIwEzdJhslmCkcsSnhP701Eem33zvJ8/rle3TR
	F3JsEq3Ri128cjm8pacDlTL+/q1Ksaf2vL2pm0/9lBtGovGVfs731S6OmB6D8C3V
	jjCVN4Cn79kLzp2wnAgxqmYIzuingcRMBJm9MUdpSFJlffHLglPgHyQmftSF3und
	1qMCN33hc9x0AjNRnOTRblvZ+8a28hSAUP9ee/pGjLoUzFsky50Sw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gfn5b00n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:03:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V88g45016031;
	Fri, 31 Jan 2025 10:03:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gfaub0mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 10:03:08 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50VA35cK34276012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 10:03:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5779E200E9;
	Fri, 31 Jan 2025 10:03:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2837200EC;
	Fri, 31 Jan 2025 10:03:04 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.80.148])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 10:03:04 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, ifranzki@linux.ibm.com, agk@redhat.com,
        snitzer@kernel.org, mpatocka@redhat.com
Cc: linux-s390@vger.kernel.org, dm-devel@lists.linux.dev,
        herbert@gondor.apana.org.au
Subject: [PATCH v3 1/2] dm-integrity: use internal variable for digestsize
Date: Fri, 31 Jan 2025 11:03:03 +0100
Message-ID: <20250131100304.932064-2-freude@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: GBxTnzQ2cH9C71zL6G0cPEhqQLagIJPW
X-Proofpoint-GUID: GBxTnzQ2cH9C71zL6G0cPEhqQLagIJPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_04,2025-01-31_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2501310075

Instead of calling digestsize() each time the digestsize for
the internal hash is needed, store the digestsize in a new
field internal_hash_digestsize within struct dm_integrity_c
once and use this value when needed.

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
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
-- 
2.43.0


