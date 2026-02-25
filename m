Return-Path: <linux-s390+bounces-16460-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHvoJdavnmmRWwQAu9opvQ
	(envelope-from <linux-s390+bounces-16460-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 09:16:22 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF70319407A
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 09:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 373903004DB6
	for <lists+linux-s390@lfdr.de>; Wed, 25 Feb 2026 08:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2241311954;
	Wed, 25 Feb 2026 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dp7SnWCa"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FB030EF87
	for <linux-s390@vger.kernel.org>; Wed, 25 Feb 2026 08:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772007377; cv=none; b=muWQ2fzO4BUzq/1WN0SnAEZMsLOawAWMoGueXv7s5rUS9b/qQ8TptjVbCE4ersmgIQcNgMPrcnOy07yHJZ7c1bwoSWVjVyfig6YOwCjYDCGYFiVESAzGNZFJi5mt1yiEt4hvjVUox1UjeMINqTJgOQrFdc9dWywq7/Dp0VLDQAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772007377; c=relaxed/simple;
	bh=hmRsU+h9C7bdkyWjJGwtbPdzr2AqxYKCI+/j2w33tns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KFyoF+geEU3IZzY4Td6Pf2zGO/BZzjDp6xneWzJD6yuQOtNxrV2yLj76q8RXlj0wUDTSnYeTgSk1yUUWE0O1PiMdqRLJDpuwKeFbgoFsUMAEP9iIrhPfOb5Ej0kOskliIzYflft87hsDpePTBggqmOuuOc1b2FmlDv9t8F94XI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dp7SnWCa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772007375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3+N2FdzBXq7d0qBg17oIVx0hpSGWg6PAf2XJ4iYnD3A=;
	b=Dp7SnWCawm8+4nWspuj5hLUUPXVqBm3HzPbJvsx8pgiErXugpu83I5/fAacQQLUZampiv9
	HFiZAZXox7LSiwJxd9HdhkSFuY9pCCe2Yw06EN0dJSMgdHjdYTSe8lQ01azCl/ZJHYVmm7
	ybbRfybPzV+shcBxMzoxuFscYLauKv8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-5bDMHpyIN7qY2J9aFw6T_w-1; Wed,
 25 Feb 2026 03:16:11 -0500
X-MC-Unique: 5bDMHpyIN7qY2J9aFw6T_w-1
X-Mimecast-MFC-AGG-ID: 5bDMHpyIN7qY2J9aFw6T_w_1772007369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C83718003F6;
	Wed, 25 Feb 2026 08:16:09 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 50E031800465;
	Wed, 25 Feb 2026 08:15:58 +0000 (UTC)
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
Subject: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's disabled
Date: Wed, 25 Feb 2026 16:14:06 +0800
Message-ID: <20260225081412.76502-10-bhe@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kvack.org,gmail.com,google.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org,kernel.org,zankel.net,linux.ibm.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16460-lists,linux-s390=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ozlabs.org:email]
X-Rspamd-Queue-Id: BF70319407A
X-Rspamd-Action: no action

Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.

This includes 32bit, book3s/64 and book3e/64.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
 arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
 arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 1d083597464f..0ea2a636c992 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -141,6 +141,10 @@ void __init kasan_init(void)
 	u64 i;
 	int ret;
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &base, &end) {
 		phys_addr_t top = min(end, total_lowmem);
 
@@ -170,7 +174,7 @@ void __init kasan_init(void)
 
 void __init kasan_late_init(void)
 {
-	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
 		kasan_unmap_early_shadow_vmalloc();
 }
 
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 0d3a73d6d4b0..fbe4c9a7e460 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -111,6 +111,10 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL_RO);
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &start, &end)
 		kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
 
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index dcafa641804c..f7906f9ef9be 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -54,6 +54,10 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL);
 
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg_disabled)
+		return;
+
 	if (!early_radix_enabled()) {
 		pr_warn("KASAN not enabled as it requires radix!");
 		return;
-- 
2.52.0


