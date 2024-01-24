Return-Path: <linux-s390+bounces-1131-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB3583A112
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jan 2024 06:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9137028DDEC
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jan 2024 05:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C4C17544;
	Wed, 24 Jan 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aohIb/Rh"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1298F171AF
	for <linux-s390@vger.kernel.org>; Wed, 24 Jan 2024 05:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073245; cv=none; b=E7Sq9CQtG+ULf6+AwOVHLkNSM8Lw9AKO2HRfr8Md5zT8abeGYUbNOJcDu5tUXWDVj1LXwdLLlk9pZAzbR+S+EZ295uJfKC27p7b04KI9dWbGD1R3fPjWwozkVFJ3Rz5ikpaXV/Cshz82e3ewibdS/2LNFFNvfe+Uw41SBtcYhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073245; c=relaxed/simple;
	bh=SwKTYhqF3vapdayBBHL5fa8lI3JifUYyDl1bRGMZKPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=I1N0SuW8b1/cYj1QP2p+Y29NkMtmOLQmg8sttVBZzRiJhfjTCRtctCtZq3WMx8j1WTmBLtyyiKyc2NTHbtoKfQ3EVsF3XtjvBItgjNWKZFVwwsjnSKWPy+YNRJaTLk8ys7KWI9c3HQDFt6aIbwiTOqRb7VoEHg1f/87J5Jb1tSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aohIb/Rh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Phdml9nXkCmStja6K/ul2BV3Rap702N5eGmMqDodNlo=;
	b=aohIb/RhfGw4WEgIJCaJRikOJ4xnP1VOajpw4QoHNvIK6imLB+vOJ8cE8aW62nt5fxGyJr
	A3Z9Np5p/qF1a8FINJL/Fulu770DtfF2mMG+UOXFgmrjcrEevGjIfgAxGXw9xBk7jUbBl6
	MipciR4UeGsbSqR/7cOQCqX5ilN7LcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-zlaUeep3MaKZl_-kOvhPYQ-1; Wed, 24 Jan 2024 00:13:55 -0500
X-MC-Unique: zlaUeep3MaKZl_-kOvhPYQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96BC0837225;
	Wed, 24 Jan 2024 05:13:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E65CE1C060AF;
	Wed, 24 Jan 2024 05:13:48 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 07/14] arm64, crash: wrap crash dumping code into crash related ifdefs
Date: Wed, 24 Jan 2024 13:12:47 +0800
Message-ID: <20240124051254.67105-8-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Now crash codes under kernel/ folder has been split out from kexec
code, crash dumping can be separated from kexec reboot in config
items on arm64 with some adjustments.

Here wrap up crash dumping codes with CONFIG_CRASH_DUMP ifdeffery.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/include/asm/kexec.h         |  2 +-
 arch/arm64/kernel/machine_kexec.c      |  2 +-
 arch/arm64/kernel/machine_kexec_file.c | 10 ++++++++--
 arch/arm64/mm/init.c                   |  2 +-
 4 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 9ac9572a3bbe..4d9cc7a76d9c 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -80,7 +80,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 	}
 }
 
-#if defined(CONFIG_KEXEC_CORE) && defined(CONFIG_HIBERNATION)
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_HIBERNATION)
 extern bool crash_is_nosave(unsigned long pfn);
 extern void crash_prepare_suspend(void);
 extern void crash_post_resume(void);
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index b38aae5b488d..82e2203d86a3 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -255,7 +255,7 @@ void machine_crash_shutdown(struct pt_regs *regs)
 	pr_info("Starting crashdump kernel...\n");
 }
 
-#ifdef CONFIG_HIBERNATION
+#if defined(CONFIG_CRASH_DUMP) && defined(CONFIG_HIBERNATION)
 /*
  * To preserve the crash dump kernel image, the relevant memory segments
  * should be mapped again around the hibernation.
diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 0e017358f4ba..af1ca875c52c 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,6 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
+#ifdef CONFIG_CRASH_DUMP
 static int prepare_elf_headers(void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
@@ -80,6 +81,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	kfree(cmem);
 	return ret;
 }
+#endif
 
 /*
  * Tries to add the initrd and DTB to the image. If it is not possible to find
@@ -93,8 +95,8 @@ int load_other_segments(struct kimage *image,
 			char *cmdline)
 {
 	struct kexec_buf kbuf;
-	void *headers, *dtb = NULL;
-	unsigned long headers_sz, initrd_load_addr = 0, dtb_len,
+	void *dtb = NULL;
+	unsigned long initrd_load_addr = 0, dtb_len,
 		      orig_segments = image->nr_segments;
 	int ret = 0;
 
@@ -102,7 +104,10 @@ int load_other_segments(struct kimage *image,
 	/* not allocate anything below the kernel */
 	kbuf.buf_min = kernel_load_addr + kernel_size;
 
+#ifdef CONFIG_CRASH_DUMP
 	/* load elf core header */
+	void *headers;
+	unsigned long headers_sz;
 	if (image->type == KEXEC_TYPE_CRASH) {
 		ret = prepare_elf_headers(&headers, &headers_sz);
 		if (ret) {
@@ -130,6 +135,7 @@ int load_other_segments(struct kimage *image,
 		kexec_dprintk("Loaded elf core header at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
 			      image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 	}
+#endif
 
 	/* load initrd */
 	if (initrd) {
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 74c1db8ce271..c1f6213e77f3 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -100,7 +100,7 @@ static void __init arch_reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
-	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+	if (!IS_ENABLED(CONFIG_CRASH_RESERVE))
 		return;
 
 	ret = parse_crashkernel(cmdline, memblock_phys_mem_size(),
-- 
2.41.0


