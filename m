Return-Path: <linux-s390+bounces-20133-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKFyI2vqF2osVQgAu9opvQ
	(envelope-from <linux-s390+bounces-20133-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 09:10:35 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA615ED853
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 09:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DF89305C527
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 07:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B4E33ADB0;
	Thu, 28 May 2026 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca+BCHyv"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6914326951
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 07:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779952226; cv=none; b=AuRwXUwX8ZkBjG8eGL4drXX3rF6Asegao3wUdAbgvYj4tAeAOXmpi64kpYx7ZZIvdBCuGnNtqNua5ee0h7EitMTZRhmBkyCmrw2dspAwbvRfQocjKqkYtS1XnBMRiAkbCFzorAMSeWyg+xSSta4enuVapEDQIAktOTBEH8ojSdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779952226; c=relaxed/simple;
	bh=zb7M7O0621Z/CS2NplopxtbPFom4ZI1LW17WtgMmm/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XTu/dg6wfMPwWUauNzljJtuxoA+ZCHKdcEbbdn6iyP9PeAVVtrf2ERtIf2vc36xHvpzuKuqtLjhvlsqENX1abIBHxmIhcrZtgREH30vrTRi3WrVgbja8jo8mnAChbvGVNC789LVS0YUWfLPcQJcUnOiioXlsoJQkRGM8K5M1Sfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca+BCHyv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 641511F00A3D;
	Thu, 28 May 2026 07:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779952225;
	bh=bABJS1IyOWLuKWruCwY6MEMCbWYv2Cp1ja2605kvLWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ca+BCHyvKvZ5dzcPL5vhPWS/6qUdx//YIc0S2jhpW7XAQ+hmdSYeK9O7rt1qSdp2a
	 kEaU2oLq878VCzJSfp36VQ77imXIMtRly5d0goFevbyBo7rGa2UABWm9AkXNrGyvlo
	 KCJ8MFwgjHTXvumnTLh64tvdj0V9jeeVXcXnU6WU+FBdbS7SlQRJ2o5xzb4si9erP9
	 8GcaWIJBS9hjGXfIKOkupVJHAHuT94U8vPufQeMAZkWUBDMYM94/4ZN2XjJ649UE/A
	 JQN/J3MjX5vVvXU0cWml5sXJuFK2wQe3p3PiI5tm2tkaWwYwpkf5/XLiCiNkW2Y5rA
	 iIGIQKWTPwX1Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 28 May 2026 10:09:54 +0300
Subject: [PATCH 6/6] s390/zcrypt: replace get_zeroed_page() with kzalloc()
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b4-s390-drivers-v1-6-b7108f54d722@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
In-Reply-To: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>, 
 Aswin Karuvally <aswin@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Holger Dengler <dengler@linux.ibm.com>, 
 Jan Hoeppner <hoeppner@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>, 
 Stefan Haberland <sth@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 linux-s390@vger.kernel.org
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20133-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4BA615ED853
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

zcrypt_rng_device_add() allocates a buffer for the software random
number generator data cache.

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
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/s390/crypto/zcrypt_api.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index d6a455df228d..f57189c2b839 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -1782,7 +1782,7 @@ int zcrypt_rng_device_add(void)
 
 	mutex_lock(&zcrypt_rng_mutex);
 	if (zcrypt_rng_device_count == 0) {
-		zcrypt_rng_buffer = (u32 *)get_zeroed_page(GFP_KERNEL);
+		zcrypt_rng_buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!zcrypt_rng_buffer) {
 			rc = -ENOMEM;
 			goto out;
@@ -1799,7 +1799,7 @@ int zcrypt_rng_device_add(void)
 	return 0;
 
 out_free:
-	free_page((unsigned long)zcrypt_rng_buffer);
+	kfree(zcrypt_rng_buffer);
 out:
 	mutex_unlock(&zcrypt_rng_mutex);
 	return rc;
@@ -1811,7 +1811,7 @@ void zcrypt_rng_device_remove(void)
 	zcrypt_rng_device_count--;
 	if (zcrypt_rng_device_count == 0) {
 		hwrng_unregister(&zcrypt_rng_dev);
-		free_page((unsigned long)zcrypt_rng_buffer);
+		kfree(zcrypt_rng_buffer);
 	}
 	mutex_unlock(&zcrypt_rng_mutex);
 }

-- 
2.53.0


