Return-Path: <linux-s390+bounces-12286-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D049B36B54
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A4CE7B4B65
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7752E35E4D6;
	Tue, 26 Aug 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C69JJjW8"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D922128B
	for <linux-s390@vger.kernel.org>; Tue, 26 Aug 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219212; cv=none; b=hmxlqrbA8gnbyFlekTkUOD4Nb0fA6FQXkQuSlaYHTrWdNzU/UJe4O8dvMz8zSkklofXMTK7dPv3GSFtpI+K18ruwAJ8wZ2HcVXEbcDF00zldO3Ews5iYCRmdkmlXp+y138dZKzQD3S/UNnnyEzYYdPsF+Wuiv9MYTg8gNkhlzfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219212; c=relaxed/simple;
	bh=TaMtshfmq7VD9kWh1Xk1B8MEuPO2dQgTtQZlkXjoLxk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=dQuHNUTe09fjAUeGB1TuJRMAZ1s0NwiNNJehEDUdrsDfH9SHTlI/Hcljebughu3t3Ke76J0rZecuFFFDk7U1rVyWXILLCd0kXMXoPW3rFxFY4toqKMioGJG4wci18H9VKeXAO12TZQpAz63RuyHmeLwg38QluBkIEncMsb16Lzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C69JJjW8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756219208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fC+y9/8vXMpqwJhCpe+5a7TEd7HQnfNaiISG9m3MZZc=;
	b=C69JJjW8D+a59uO8wwAz5i0tsrqYwlEc2uF2uPhOZJ0kUNIPgAjfVo0+8sjoEVBTaL4ASi
	0ZKil3T56uAGVaPwUBYSkskyNhlXXhmB9qADXdOd+ee5gSYjgNAMVcJ9lYLNYury86gsFX
	tip3cPM/xGXU7c6G8HcJKkOrNA+aGIA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-6OSEhOxIObuUjVqJ5F3_rQ-1; Tue,
 26 Aug 2025 10:40:05 -0400
X-MC-Unique: 6OSEhOxIObuUjVqJ5F3_rQ-1
X-Mimecast-MFC-AGG-ID: 6OSEhOxIObuUjVqJ5F3_rQ_1756219204
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB2DF1800293;
	Tue, 26 Aug 2025 14:40:03 +0000 (UTC)
Received: from debian4.vm (unknown [10.22.80.227])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AEDA330001A2;
	Tue, 26 Aug 2025 14:39:59 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation); Tue, 26 Aug 2025 16:39:57 +0200
Message-ID: <20250826143957.963979920@debian4.vm>
User-Agent: quilt/0.68
Date: Tue, 26 Aug 2025 16:36:52 +0200
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
Subject: [PATCH 6/7] dm-integrity: rename internal_hash
References: <20250826143646.570314717@debian4.vm>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Rename "internal_hash" to "internal_shash" and introduce a boolean value
"internal_hash".

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-integrity.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/md/dm-integrity.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-integrity.c	2025-08-25 15:46:51.000000000 +0200
+++ linux-2.6/drivers/md/dm-integrity.c	2025-08-25 15:46:51.000000000 +0200
@@ -219,10 +219,11 @@ struct dm_integrity_c {
 	__u8 log2_blocks_per_bitmap_bit;
 
 	unsigned char mode;
+	bool internal_hash;
 
 	int failed;
 
-	struct crypto_shash *internal_hash;
+	struct crypto_shash *internal_shash;
 	unsigned int internal_hash_digestsize;
 
 	struct dm_target *ti;
@@ -1639,11 +1640,11 @@ static void integrity_sector_checksum(st
 				      const char *data, unsigned offset, char *result)
 {
 	__le64 sector_le = cpu_to_le64(sector);
-	SHASH_DESC_ON_STACK(req, ic->internal_hash);
+	SHASH_DESC_ON_STACK(req, ic->internal_shash);
 	int r;
 	unsigned int digest_size;
 
-	req->tfm = ic->internal_hash;
+	req->tfm = ic->internal_shash;
 
 	r = crypto_shash_init(req);
 	if (unlikely(r < 0)) {
@@ -4708,12 +4709,14 @@ static int dm_integrity_ctr(struct dm_ta
 		buffer_sectors = 1;
 	ic->log2_buffer_sectors = min((int)__fls(buffer_sectors), 31 - SECTOR_SHIFT);
 
-	r = get_mac(&ic->internal_hash, &ic->internal_hash_alg, &ti->error,
+	r = get_mac(&ic->internal_shash, &ic->internal_hash_alg, &ti->error,
 		    "Invalid internal hash", "Error setting internal hash key");
 	if (r)
 		goto bad;
-	if (ic->internal_hash)
-		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_hash);
+	if (ic->internal_shash) {
+		ic->internal_hash = true;
+		ic->internal_hash_digestsize = crypto_shash_digestsize(ic->internal_shash);
+	}
 
 	r = get_mac(&ic->journal_mac, &ic->journal_mac_alg, &ti->error,
 		    "Invalid journal mac", "Error setting journal mac key");
@@ -5235,8 +5238,8 @@ static void dm_integrity_dtr(struct dm_t
 	if (ic->sb)
 		free_pages_exact(ic->sb, SB_SECTORS << SECTOR_SHIFT);
 
-	if (ic->internal_hash)
-		crypto_free_shash(ic->internal_hash);
+	if (ic->internal_shash)
+		crypto_free_shash(ic->internal_shash);
 	free_alg(&ic->internal_hash_alg);
 
 	if (ic->journal_crypt)


