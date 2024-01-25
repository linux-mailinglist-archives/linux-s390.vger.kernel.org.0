Return-Path: <linux-s390+bounces-1157-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC9183B896
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jan 2024 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62FC1F22D8C
	for <lists+linux-s390@lfdr.de>; Thu, 25 Jan 2024 04:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E98C79C6;
	Thu, 25 Jan 2024 04:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnzFqjXf"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414C779C3
	for <linux-s390@vger.kernel.org>; Thu, 25 Jan 2024 04:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706155789; cv=none; b=m8GOBG8kmMwjzxVwGuT76Jl4BrHJECng+nMRbNB4bCeuFS2qUy/CuTZy+zgj/6HutLGiAK/zspLcqCKY7wKjlYy0UlMbxKLrHdhg/FyztPYM/z4rxDwlDl0yHbp5vamqJEYb95J8+pAkTibg7byPhXpbnHV0UOOv3midHtQ3pNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706155789; c=relaxed/simple;
	bh=zupGSwZyGzMVwBtWOwdtEe+wGr5W8ImseAYZk+EG1cI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8UdAqwTloa/FJMZMkTiiviKq2kdLcW3YGJa5c3wIqcHk/XGNNhun6MnKE3nMJ0ovMymrYzsHXqahLZpmL3CsrL2GvEMEfnmVzus82OQMZKE6dRK6tgdbsf0B8MJkblpydHPnunb4VnrvgSt38jdEx/nQa/v8S6fJ8laRp72fDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnzFqjXf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706155786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWkqIM1QddKJmlHq/W4wKL7ORpJYC0uhF5yya8pqsJ8=;
	b=KnzFqjXfvgOwKfaeyy8s22EhbzCi9vt/aaOTuLS1OKTM30Dqriqqj26JL49EkWbE0fxEOb
	pGya8gGio+69UlhpY90RPmz18pqBraP9ARxcb47jgQiBNrw+5uhoKHOhtEPS/VVsLCxeCo
	5X+0NSsxNzqBScpxtYh6L17fea5z+ic=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-AvLrlMuiMWWq7ooKHP2nsQ-1; Wed,
 24 Jan 2024 23:09:41 -0500
X-MC-Unique: AvLrlMuiMWWq7ooKHP2nsQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7936A38143C1;
	Thu, 25 Jan 2024 04:09:40 +0000 (UTC)
Received: from localhost (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 71F7F40C1430;
	Thu, 25 Jan 2024 04:09:39 +0000 (UTC)
Date: Thu, 25 Jan 2024 12:09:36 +0800
From: Baoquan He <bhe@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"hbathini@linux.ibm.com" <hbathini@linux.ibm.com>,
	"piliu@redhat.com" <piliu@redhat.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH linux-next v3 06/14] x86, crash: wrap crash dumping code
 into crash related ifdefs
Message-ID: <ZbHfACpwqi2U9vmK@MiWiFi-R3L-srv>
References: <20240124051254.67105-1-bhe@redhat.com>
 <20240124051254.67105-7-bhe@redhat.com>
 <SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157931105FA68D72E3D3DB8D47B2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On 01/24/24 at 11:02pm, Michael Kelley wrote:
> > diff --git a/arch/x86/kernel/cpu/mshyperv.c
> > b/arch/x86/kernel/cpu/mshyperv.c
> > index 01fa06dd06b6..f8163a59026b 100644
> > --- a/arch/x86/kernel/cpu/mshyperv.c
> > +++ b/arch/x86/kernel/cpu/mshyperv.c
> > @@ -210,6 +210,7 @@ static void hv_machine_shutdown(void)
> >  		hyperv_cleanup();
> >  }
> > 
> > +#ifdef CONFIG_CRASH_DUMP
> >  static void hv_machine_crash_shutdown(struct pt_regs *regs)
> >  {
> >  	if (hv_crash_handler)
> > @@ -221,6 +222,7 @@ static void hv_machine_crash_shutdown(struct
> > pt_regs *regs)
> >  	/* Disable the hypercall page when there is only 1 active CPU. */
> >  	hyperv_cleanup();
> >  }
> > +#endif
> >  #endif /* CONFIG_KEXEC_CORE */
> 
> Note that the #ifdef CONFIG_CRASH_DUMP is nested inside
> #ifdef CONFIG_KEXEC_CODE here, and in the other Hyper-V code
> just below.   It's also nested in xen_hvm_guest_init() at the bottom
> of this patch.  But the KVM case of setting crash_shutdown is
> not nested -- you changed #ifdef CONFIG_KEXEC_CORE to #ifdef
> CONFIG_CRASH_DUMP.
> 
> I think both approaches work because CONFIG_CRASH_DUMP implies
> CONFIG_KEXEC_CORE, but I wonder if it would be better to *not* nest
> in all cases.  I'd like to see the cases be consistent so in the future
> someone doesn't wonder why there's a difference (unless there's
> a reason for the difference that I missed).

I agree with you, it's a great suggestion. Thanks.

Do you think below draft patch includes all changes you are concerned
about?

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index f8163a59026b..2e8cd5a4ae85 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -209,6 +209,7 @@ static void hv_machine_shutdown(void)
 	if (kexec_in_progress)
 		hyperv_cleanup();
 }
+#endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_CRASH_DUMP
 static void hv_machine_crash_shutdown(struct pt_regs *regs)
@@ -222,8 +223,7 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	/* Disable the hypercall page when there is only 1 active CPU. */
 	hyperv_cleanup();
 }
-#endif
-#endif /* CONFIG_KEXEC_CORE */
+#endif /* CONFIG_CRASH_DUMP */
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -497,9 +497,11 @@ static void __init ms_hyperv_init_platform(void)
 	no_timer_check = 1;
 #endif
 
-#if IS_ENABLED(CONFIG_HYPERV) && defined(CONFIG_KEXEC_CORE)
+#if IS_ENABLED(CONFIG_HYPERV)
+#if defined(CONFIG_KEXEC_CORE)
 	machine_ops.shutdown = hv_machine_shutdown;
-#ifdef CONFIG_CRASH_DUMP
+#endif
+#if defined(CONFIG_CRASH_DUMP)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 #endif
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 1287b0d5962f..f3130f762784 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -826,7 +826,7 @@ void machine_halt(void)
 	machine_ops.halt();
 }
 
-#ifdef CONFIG_KEXEC_CORE
+#ifdef CONFIG_CRASH_DUMP
 void machine_crash_shutdown(struct pt_regs *regs)
 {
 	machine_ops.crash_shutdown(regs);


