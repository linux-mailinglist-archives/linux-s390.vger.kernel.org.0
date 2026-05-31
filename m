Return-Path: <linux-s390+bounces-20262-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QD1lGPFAHGqQLwkAu9opvQ
	(envelope-from <linux-s390+bounces-20262-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 31 May 2026 16:08:49 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D40B46169CB
	for <lists+linux-s390@lfdr.de>; Sun, 31 May 2026 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D693015867
	for <lists+linux-s390@lfdr.de>; Sun, 31 May 2026 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCB315D53;
	Sun, 31 May 2026 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGXGIWpW"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FAF314A6F
	for <linux-s390@vger.kernel.org>; Sun, 31 May 2026 14:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780236526; cv=none; b=Is0bN2LnfE4LofJRk0imuaPiyvo1DU+mMGJtts0wv/1i6rHa/9GUDMSi5ZxuUQRLJac4yM+MDPDdtPJ6vkN99MzoljEpQdcLeIqmMiIVWpKibKes1+j3GArkcdHSrxTJJntPl55RTCxGWQSj0s8sa0/UaVQrAPQPT4E+750kQhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780236526; c=relaxed/simple;
	bh=YM3GfhNDfJBy00W76gc1jr8oZN0EYLtk5ux/a60QvD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ndmfROMZse/G0gpbI8t6brRRa/vZND9mS2h6aZ3ql7KCohoIQdSQWx+HkN0C6RXu8e6EzbdngsKuN9DIQEVDeSAootf7p5KMTAOHuVJOID+2Mc0RANtx0iPlUnWrI1Xq2eEMicIUqhYTMYWDQ5z4dBogLnSY4lfKZKkYgIyd3HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGXGIWpW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA54C1F00893;
	Sun, 31 May 2026 14:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780236525;
	bh=avzUdc+f+8HKj7UZ0pWYuSeSSFdQ0uUVKl49kZ8Duog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jGXGIWpWwQ3H66u4nGu4IDGnl50JylcVohRyeZ0cOijkAQ/psxm83eLpU8rYtkoNc
	 85l6X49/TTuzh+PUesFtzoxGjY6gZQ7dSy9XzWzq9psb/TrDXpqNnKPDgphCXy+q6G
	 D0fY5B7DZAUNFnzdaVhptO/6Ak+MgR7PrlhIS3TSjWT3+hPwF4Opt2qC79j4mcBnzb
	 eNTKXUub9oNJraV1Kxiwu+ZEIWYHEEPhdbZyLR3wdNwpLE3VTbRkh8tVw4XntMxLGA
	 ktXcIH7VRpxyQ3sHKbCr10S8xNthhijyoHm7BKB1LcI4iFxCwVBN+YHVBA98TAbEHD
	 i4BBmeptW1pPg==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sun, 31 May 2026 17:08:25 +0300
Subject: [PATCH v2 4/6] s390/qeth: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-b4-s390-drivers-v2-4-f7985308ed90@kernel.org>
References: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
In-Reply-To: <20260531-b4-s390-drivers-v2-0-f7985308ed90@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Vlastimil Babka <vbabka@kernel.org>, linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20262-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D40B46169CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

qeth_get_trap_id() allocates a temporary buffer for STSI system
information queries used to build trap identification strings.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of get_zeroed_page() with kzalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Acked-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index cf5f760d0e02..20fb0d2e02a9 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3362,9 +3362,9 @@ static int qeth_query_setdiagass(struct qeth_card *card)
 
 static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 {
-	unsigned long info = get_zeroed_page(GFP_KERNEL);
-	struct sysinfo_2_2_2 *info222 = (struct sysinfo_2_2_2 *)info;
-	struct sysinfo_3_2_2 *info322 = (struct sysinfo_3_2_2 *)info;
+	void *info = kzalloc(PAGE_SIZE, GFP_KERNEL);
+	struct sysinfo_2_2_2 *info222 = info;
+	struct sysinfo_3_2_2 *info322 = info;
 	struct ccw_dev_id ccwid;
 	int level;
 
@@ -3381,7 +3381,7 @@ static void qeth_get_trap_id(struct qeth_card *card, struct qeth_trap_id *tid)
 		EBCASC(info322->vm[0].name, sizeof(info322->vm[0].name));
 		memcpy(tid->vmname, info322->vm[0].name, sizeof(tid->vmname));
 	}
-	free_page(info);
+	kfree(info);
 }
 
 static int qeth_hw_trap_cb(struct qeth_card *card,

-- 
2.53.0


