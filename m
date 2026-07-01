Return-Path: <linux-s390+bounces-21429-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dr2JL1IhRWoa7goAu9opvQ
	(envelope-from <linux-s390+bounces-21429-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 16:16:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6FE6EE983
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 16:16:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UGfOlK2a;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21429-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21429-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DE0C306DC00
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 13:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F0239E60;
	Wed,  1 Jul 2026 13:47:36 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDE02264A7
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 13:47:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913656; cv=none; b=F6IvYsh5cyG9BikeW+TE7QNUbSAr6lLuToyMGElZ1CSZUVRyEBg72+A30yZWQnA9iwKB4H4J3aRl8SgvRs97QXhff/RS9QyVBMG+Mjj4Jaj9IzujoRwdYgqzV2a0sx/5NipE6jgTV05JgSjL3DwuAHKez4jfyUOWx0Ui+oMeNSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913656; c=relaxed/simple;
	bh=oP5PJMkbRl5dj1lHU4rEKskYkm1XL5NnkDocVsQSdYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tuxk3txEBezXISiq1IzEFU3NELbkTFCYbd05iJdkBe5NEnCRU98gC4lCoIkBK734XQBvmZjf8z8SkayDECyaOXa+fsZmbhd2nz3dKgZKX+mU8/+AzDwLxrgdMzCMF94jmrO2EJEgLK15b/HsbfGjytkPpgeRyMRA2OMQuX4VkLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UGfOlK2a; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782913654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H3QrgaH2kGVjm0vYXAyWHX2mTkxr9HQ1g/8ADPb9HI0=;
	b=UGfOlK2aZRqLRl7Pf2rD8/LUHibQwgNWeyFhIdi0+bJlr4FzkKwGzS85+VQyQ2Xyjze+H3
	LidB0UAULccNv4OMxN1Q3xWUEnG9nJLav6dmwAQjiwNCS59DvMEle5gPiDJvsI6JoOd3XC
	5twv244FlIyCDxS58Ex3h/1WVZ0Qx64=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-Xbvoa-_6Ow2rQWXlr2FsHw-1; Wed,
 01 Jul 2026 09:47:32 -0400
X-MC-Unique: Xbvoa-_6Ow2rQWXlr2FsHw-1
X-Mimecast-MFC-AGG-ID: Xbvoa-_6Ow2rQWXlr2FsHw_1782913651
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 19A6B18E6A58;
	Wed,  1 Jul 2026 13:47:31 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 30960195E486;
	Wed,  1 Jul 2026 13:47:28 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/uapi: Remove obsolete unistd_32.h from Kbuild file
Date: Wed,  1 Jul 2026 15:47:27 +0200
Message-ID: <20260701134727.882734-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21429-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[thuth@redhat.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thuth@redhat.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D6FE6EE983

From: Thomas Huth <thuth@redhat.com>

unistd_32.h is not build anymore since commit 4ac286c4a8d90
("s390/syscalls: Switch to generic system call table generation").
Thus drop the superfluous line from the Kbuild file now, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/include/uapi/asm/Kbuild | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 46c1ff0b842a1..378151cef3cce 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 
-generated-y += unistd_32.h
 generated-y += unistd_64.h
-- 
2.54.0


