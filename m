Return-Path: <linux-s390+bounces-12283-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F78B36BCD
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 16:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C091C45FF0
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 14:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD0835AADA;
	Tue, 26 Aug 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwP4Vj3A"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E817481CD
	for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219196; cv=none; b=oxHGjuVgm99vAXbFF5ctCMXnssNoLe6j+aC/t0KwpAPPIeX11E/KeCRpnjM50rMtyzZqI7oK5BwzEV8uFES7BZzQuV9vYalx5Z2vZwLMl0AITucfGxMR8LP41EIXNc//tDIPMcXf91OIi7MLPoIG0cczxkRzqLc8MW27pUw9yuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219196; c=relaxed/simple;
	bh=kOx2wyAS5FIlvweLVk9mWXhq0zauNHlUJaZZUd/rijY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sHIPJu81ILrtcZzbX6+qX9ziDnUWJ/Xa/ZF85UWzkB4xElPe47qaw6/U4c6o7UVjp71O/3x68zgH5cCdHWyPx28o9XmqngQ92snKWYTvoId2tSj0rwvFmNJAbOw7zhtEyXE1efMplZgoqgcgjJRTCSuChd3Hj9POYiNt/PcM5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwP4Vj3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=slDXyPiLY+VWKDnK/YkiBKtXwQa1uwRTqvakr09fVFU=;
	b=XwP4Vj3A373yWc+UiI9DuHV5fniwYVam1vPoJuFW3R+cMHJuwfWlz2ArGExyUaPT1AgLDc
	KJzhNAd9h1ZG5J31xK3tVZ7ZxOEM99muoucyRO9S3bZHTKBYVAGE2i9pYiAGXmJ+jZAu2n
	q8BUp4P/4Aq72HfiP71bKas8woMEBic=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-1-gp9i-xS6NcKpXl8_YNhUgQ-1; Tue,
 26 Aug 2025 10:39:49 -0400
X-MC-Unique: gp9i-xS6NcKpXl8_YNhUgQ-1
X-Mimecast-MFC-AGG-ID: gp9i-xS6NcKpXl8_YNhUgQ_1756219186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1DB57180029C;
	Tue, 26 Aug 2025 14:39:46 +0000 (UTC)
Received: from debian4.vm (unknown [10.22.80.227])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id C9E251800446;
	Tue, 26 Aug 2025 14:39:41 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation); Tue, 26 Aug 2025 16:39:40 +0200
Message-ID: <20250826143940.069921597@debian4.vm>
User-Agent: quilt/0.68
Date: Tue, 26 Aug 2025 16:36:49 +0200
From: Mikulas Patocka <mpatocka@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Biggers <ebiggers@kernel.org>,
 dengler@linux.ibm.com,
 linux-s390@vger.kernel.org,
 dm-devel@lists.linux.dev,
 ifranzki@linux.ibm.com,
 agk@redhat.com,
 snitzer@kernel.org,
 gmazyland@gmail.com,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH 3/7] dm-integrity: introduce integrity_kmap and integrity_kunmap
References: <20250826143646.570314717@debian4.vm>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This abstraction will be used later, for the asynchronous hash interface.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-integrity.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

Index: linux-2.6/drivers/md/dm-integrity.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-integrity.c	2025-08-21 18:21:12.000000000 +0200
+++ linux-2.6/drivers/md/dm-integrity.c	2025-08-21 18:22:00.000000000 +0200
@@ -1688,6 +1688,16 @@ failed:
 	get_random_bytes(result, ic->tag_size);
 }
 
+static void *integrity_kmap(struct dm_integrity_c *ic, struct page *p)
+{
+	return kmap_local_page(p);
+}
+
+static void integrity_kunmap(struct dm_integrity_c *ic, const void *ptr)
+{
+	kunmap_local(ptr);
+}
+
 static noinline void integrity_recheck(struct dm_integrity_io *dio, char *checksum)
 {
 	struct bio *bio = dm_bio_from_per_bio_data(dio, sizeof(struct dm_integrity_io));
@@ -1838,7 +1848,7 @@ static void integrity_metadata(struct wo
 			char *mem, *checksums_ptr;
 
 again:
-			mem = kmap_local_page(bv_copy.bv_page);
+			mem = integrity_kmap(ic, bv_copy.bv_page);
 			pos = 0;
 			checksums_ptr = checksums;
 			do {
@@ -1848,7 +1858,7 @@ again:
 				pos += ic->sectors_per_block << SECTOR_SHIFT;
 				sector += ic->sectors_per_block;
 			} while (pos < bv_copy.bv_len && sectors_to_process && checksums != checksums_onstack);
-			kunmap_local(mem);
+			integrity_kunmap(ic, mem);
 
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
@@ -2072,19 +2082,6 @@ retry_kmap:
 					js++;
 					mem_ptr += 1 << SECTOR_SHIFT;
 				} while (++s < ic->sectors_per_block);
-#ifdef INTERNAL_VERIFY
-				if (ic->internal_hash) {
-					char checksums_onstack[MAX_T(size_t, HASH_MAX_DIGESTSIZE, MAX_TAG_SIZE)];
-
-					integrity_sector_checksum(ic, logical_sector, mem + bv.bv_offset, checksums_onstack);
-					if (unlikely(crypto_memneq(checksums_onstack, journal_entry_tag(ic, je), ic->tag_size))) {
-						DMERR_LIMIT("Checksum failed when reading from journal, at sector 0x%llx",
-							    logical_sector);
-						dm_audit_log_bio(DM_MSG_PREFIX, "journal-checksum",
-								 bio, logical_sector, 0);
-					}
-				}
-#endif
 			}
 
 			if (!ic->internal_hash) {
@@ -2506,11 +2503,11 @@ skip_spinlock:
 		unsigned pos = 0;
 		while (dio->bio_details.bi_iter.bi_size) {
 			struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
-			const char *mem = kmap_local_page(bv.bv_page);
+			const char *mem = integrity_kmap(ic, bv.bv_page);
 			if (ic->tag_size < ic->tuple_size)
 				memset(dio->integrity_payload + pos + ic->tag_size, 0, ic->tuple_size - ic->tuple_size);
 			integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem + bv.bv_offset, dio->integrity_payload + pos);
-			kunmap_local(mem);
+			integrity_kunmap(ic, mem);
 			pos += ic->tuple_size;
 			bio_advance_iter_single(bio, &dio->bio_details.bi_iter, ic->sectors_per_block << SECTOR_SHIFT);
 		}
@@ -2626,17 +2623,17 @@ static int dm_integrity_end_io(struct dm
 			while (dio->bio_details.bi_iter.bi_size) {
 				char digest[HASH_MAX_DIGESTSIZE];
 				struct bio_vec bv = bio_iter_iovec(bio, dio->bio_details.bi_iter);
-				char *mem = kmap_local_page(bv.bv_page);
+				char *mem = integrity_kmap(ic, bv.bv_page);
 				integrity_sector_checksum(ic, dio->bio_details.bi_iter.bi_sector, mem + bv.bv_offset, digest);
 				if (unlikely(crypto_memneq(digest, dio->integrity_payload + pos,
 						min(ic->internal_hash_digestsize, ic->tag_size)))) {
-					kunmap_local(mem);
+					integrity_kunmap(ic, mem);
 					dm_integrity_free_payload(dio);
 					INIT_WORK(&dio->work, dm_integrity_inline_recheck);
 					queue_work(ic->offload_wq, &dio->work);
 					return DM_ENDIO_INCOMPLETE;
 				}
-				kunmap_local(mem);
+				integrity_kunmap(ic, mem);
 				pos += ic->tuple_size;
 				bio_advance_iter_single(bio, &dio->bio_details.bi_iter, ic->sectors_per_block << SECTOR_SHIFT);
 			}


