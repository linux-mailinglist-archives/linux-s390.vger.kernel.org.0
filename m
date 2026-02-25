Return-Path: <linux-s390+bounces-16457-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OLCIOiwnmlxWwQAu9opvQ
	(envelope-from <linux-s390+bounces-16457-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 09:20:56 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B42C1941ED
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 09:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CD543135045
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D643115BC;
	Wed, 25 Feb 2026 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPjEFtbM"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5253112A5
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007348; cv=none; b=MoYgBszhi2XHInMAABmn76bBcUh+rtMWytPwSV9QvWMGdr2XgCN14SVp0WikC1pVDO9dDRqdtLUcHUWhQWSAcKnmCy19kQmFIuhL0db1IGVl/7jVTS7tIqQpIrIGUL1oQuAC0o0JTxsdJnoiiAT9LpFbsS0ZU+64NCmB/Kh0pi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007348; c=relaxed/simple;
	bh=v/LFI9p5qTGfe93md9EH3J7clj2J/XK4Ls1meB4wWyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=Be93k9O44cEDTp9CJQyXBipazBXQn5dxBzYoUwsxE7oOHJ2eTG9RYlxyAkgR9qjMZP9K6U0WsavEgDCL86bvUOl9uPXg8jijnUJtxZom2YFvSA2u0EyXErLDe7kLK0oBNRQoET7bcjQaFvj1dfGIRDcIUIO/+0g4HkRZlYsdubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dPjEFtbM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I228xoUl4+ZrgdKCBvI2rCmcNIzmRojWxOXL2gQGmtk=;
	b=dPjEFtbMFH80QRmjwJ4OG7ypPzz9ahq87xlEAp0FS3/kAVE2N7skc5ztNE+iRtVj8pSzzJ
	1pXIs+2TiCZJBPwzzrY4zIq41kSQzkjGRvc9g/kmw3zjJmgGAcCkHwEM/1lOr7Q1LMFR4T
	MXhufBZN5VUesauFHo81XE9ghlfwcN0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-rwD-1e3zOqOiSldVPhFTdg-1; Wed,
 25 Feb 2026 03:15:40 -0500
X-MC-Unique: rwD-1e3zOqOiSldVPhFTdg-1
X-Mimecast-MFC-AGG-ID: rwD-1e3zOqOiSldVPhFTdg_1772007338
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01DB51956070;
	Wed, 25 Feb 2026 08:15:38 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68EB31800286;
	Wed, 25 Feb 2026 08:15:29 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org,
	andreyknvl@gmail.com,
	ryabinin.a.a@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	linux-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	linux-s390@vger.kernel.org,
	hca@linux.ibm.com,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 06/15] arch/arm: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:03 +0800
Message-ID: <20260225081412.76502-7-bhe@redhat.com>
In-Reply-To: <20260225081412.76502-1-bhe@redhat.com>
References: <20260225081412.76502-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org,kernel.org,zankel.net,linux.ibm.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16457-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhe@redhat.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 2B42C1941ED
X-Rspamd-Action: no action

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

And also call jump_label_init() early in setup_arch() so that later
kasan_init() can enable static key kasan_flag_enabled. Put
jump_label_init() beofre parse_early_param() as other architectures
do.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/kernel/setup.c  | 6 ++++++
 arch/arm/mm/kasan_init.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 0bfd66c7ada0..453a47a4c715 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1135,6 +1135,12 @@ void __init setup_arch(char **cmdline_p)
 	early_fixmap_init();
 	early_ioremap_init();
 
+	/*
+	 * Initialise the static keys early as they may be enabled by the
+	 * kasan_init() or early parameters.
+	 */
+	jump_label_init();
+
 	parse_early_param();
 
 #ifdef CONFIG_MMU
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index c6625e808bf8..82ec043c891f 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -212,6 +212,9 @@ void __init kasan_init(void)
 	phys_addr_t pa_start, pa_end;
 	u64 i;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
 	/*
 	 * We are going to perform proper setup of shadow memory.
 	 *
-- 
2.52.0


