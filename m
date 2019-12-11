Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820ED11A3B5
	for <lists+linux-s390@lfdr.de>; Wed, 11 Dec 2019 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfLKFWC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Dec 2019 00:22:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35504 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfLKFWC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 00:22:02 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so10170615pgk.2
        for <linux-s390@vger.kernel.org>; Tue, 10 Dec 2019 21:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:subject:in-reply-to:references:date:message-id:mime-version;
        bh=OGsdV5jSDDEFcnOk4gJS+m/O081C8UQbyskvOH4VTPw=;
        b=d+vkKjwN/B7Eemt4aTf5+2EppVPiUSkGgGmMGibO69VudKHjSmIcTbfwnpxCCc+oVT
         2S6XUMuiwAyy1OK8j/g/0ywNzRSnfEzqdVVtBSWr6aCDKX4cMZa65yqdTSngOAoSerQG
         ZZ/fl2c0wRuhrRu2sVo6USDP7/ZGWJSzW6Sc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OGsdV5jSDDEFcnOk4gJS+m/O081C8UQbyskvOH4VTPw=;
        b=miCKvTa17R94ADQ3F/27ZifHh8LEoZki00FCbaVxIqehr1aB1senyQm+X4T+wtJMo9
         NAmgPmH612Dp2wgJ0tkwN4HAiDOmbAVZaPfLV5KMJ2iQ1w6mnBM1cPBWL2rOa15gsEu+
         70X2emVC1q6a006lpCnqfEkPkFVbw/uHyz4LnGcZt0buNCwPp+sum9gFO/bTaNlIiKRg
         SLvTc5bcEFX/a0JvK3Y6QTLNkeNHpz55RwBiw2zjPtMV5ngPVNFv2aoYRQWZHK3FXNyE
         pmus56KMHhL6JBDHUyTLO8EaKrqsivcrWWrVPQcidDBUrRJ8o2hVvkHHoQlx+AWwHurc
         TCXw==
X-Gm-Message-State: APjAAAUrVuakgQKLpGtOPHqQszh4bFLAE8+QWGi4wTdHjnF5ajUQpp5a
        B6dyNkIfU9IVR6xW56FAEE0Xlw==
X-Google-Smtp-Source: APXvYqy8kiPOFzQDhHNR7yZIAuZ3DCi8vXHTVH/NuDcXMhPAyICB5cohpd05/qlLbtvTlkWmL2TaeA==
X-Received: by 2002:a63:5d4d:: with SMTP id o13mr2058179pgm.182.1576041721369;
        Tue, 10 Dec 2019 21:22:01 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-899f-c50f-5647-b1f9.static.ipv6.internode.on.net. [2001:44b8:1113:6700:899f:c50f:5647:b1f9])
        by smtp.gmail.com with ESMTPSA id y62sm966374pfg.45.2019.12.10.21.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 21:22:00 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Balbir Singh <bsingharora@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kasan-dev@googlegroups.com, christophe.leroy@c-s.fr,
        aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
References: <20191210044714.27265-1-dja@axtens.net> <20191210044714.27265-5-dja@axtens.net> <71751e27-e9c5-f685-7a13-ca2e007214bc@gmail.com>
Date:   Wed, 11 Dec 2019 16:21:57 +1100
Message-ID: <875zincu8a.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Balbir,

>> +Discontiguous memory can occur when you have a machine with memory spread
>> +across multiple nodes. For example, on a Talos II with 64GB of RAM:
>> +
>> + - 32GB runs from 0x0 to 0x0000_0008_0000_0000,
>> + - then there's a gap,
>> + - then the final 32GB runs from 0x0000_2000_0000_0000 to 0x0000_2008_0000_0000
>> +
>> +This can create _significant_ issues:
>> +
>> + - If we try to treat the machine as having 64GB of _contiguous_ RAM, we would
>> +   assume that ran from 0x0 to 0x0000_0010_0000_0000. We'd then reserve the
>> +   last 1/8th - 0x0000_000e_0000_0000 to 0x0000_0010_0000_0000 as the shadow
>> +   region. But when we try to access any of that, we'll try to access pages
>> +   that are not physically present.
>> +
>
> If we reserved memory for KASAN from each node (discontig region), we might survive
> this no? May be we need NUMA aware KASAN? That might be a generic change, just thinking
> out loud.

The challenge is that - AIUI - in inline instrumentation, the compiler
doesn't generate calls to things like __asan_loadN and
__asan_storeN. Instead it uses -fasan-shadow-offset to compute the
checks, and only calls the __asan_report* family of functions if it
detects an issue. This also matches what I can observe with objdump
across outline and inline instrumentation settings.

This means that for this sort of thing to work we would need to either
drop back to out-of-line calls, or teach the compiler how to use a
nonlinear, NUMA aware mem-to-shadow mapping.

I'll document this a bit better in the next spin.

>> +	if (IS_ENABLED(CONFIG_KASAN) && IS_ENABLED(CONFIG_PPC_BOOK3S_64)) {
>> +		kasan_memory_size =
>> +			((phys_addr_t)CONFIG_PHYS_MEM_SIZE_FOR_KASAN << 20);
>> +
>> +		if (top_phys_addr < kasan_memory_size) {
>> +			/*
>> +			 * We are doomed. Attempts to call e.g. panic() are
>> +			 * likely to fail because they call out into
>> +			 * instrumented code, which will almost certainly
>> +			 * access memory beyond the end of physical
>> +			 * memory. Hang here so that at least the NIP points
>> +			 * somewhere that will help you debug it if you look at
>> +			 * it in qemu.
>> +			 */
>> +			while (true)
>> +				;
>
> Again with the right hooks in check_memory_region_inline() these are recoverable,
> or so I think

So unless I misunderstand the circumstances in which
check_memory_region_inline is used, this isn't going to help with inline
instrumentation.

>> +void __init kasan_init(void)
>> +{
>> +	int i;
>> +	void *k_start = kasan_mem_to_shadow((void *)RADIX_KERN_VIRT_START);
>> +	void *k_end = kasan_mem_to_shadow((void *)RADIX_VMEMMAP_END);
>> +
>> +	pte_t pte = __pte(__pa(kasan_early_shadow_page) |
>> +			  pgprot_val(PAGE_KERNEL) | _PAGE_PTE);
>> +
>> +	if (!early_radix_enabled())
>> +		panic("KASAN requires radix!");
>> +
>
> I think this is avoidable, we could use a static key for disabling kasan in
> the generic code. I wonder what happens if someone tries to boot this
> image on a Power8 box and keeps panic'ing with no easy way of recovering.

Again, assuming I understand correctly that the compiler generates raw
IR->asm for these checks rather than calling out to a function, then I
don't think we get a way to intercept those checks. It's too late to do
anything at the __asan report stage because that will already have
accessed memory that's not set up properly.

If you try to boot this on a Power8 box it will panic and you'll have to
boot into another kernel from the bootloader. I don't think it's
avoidable without disabling inline instrumentation, but I'd love to be
proven wrong.

>
> NOTE: I can't test any of these, well may be with qemu, let me see if I can spin
> the series and provide more feedback

It's actually super easy to do simple boot tests with qemu, it works fine in TCG,
Michael's wiki page at
https://github.com/linuxppc/wiki/wiki/Booting-with-Qemu is very helpful.

I did this a lot in development.

My full commandline, fwiw, is:

qemu-system-ppc64  -m 8G -M pseries -cpu power9  -kernel ../out-3s-radix/vmlinux  -nographic -chardev stdio,id=charserial0,mux=on -device spapr-vty,chardev=charserial0,reg=0x30000000 -initrd ./rootfs-le.cpio.xz -mon chardev=charserial0,mode=readline -nodefaults -smp 4

Regards,
Daniel

