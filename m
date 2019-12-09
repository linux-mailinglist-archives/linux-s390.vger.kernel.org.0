Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 549301177E4
	for <lists+linux-s390@lfdr.de>; Mon,  9 Dec 2019 22:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLIVA0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 9 Dec 2019 16:00:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34799 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIVAZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 16:00:25 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so13548419otf.1
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 13:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMFJWolzCCUGyRUuaILC3spwwtCuqvBuPYOOVXEp/aA=;
        b=xJUcW/ZJZqhBrirgnJUXRH9YFWt+xzEM6e4gecFQ6NSsUXaM8QRtq93mV3xIMtdnxI
         hwZO34hrDP+h/SvMzEgMKtvQJdml3hl4u8Dk2JbZ+yNZrYeuwfs+GQHvGkrOXCYjVYBM
         h1YB45XPZeWKDmwzWRJaxFbllbHyJwyu4Y4ZrjVAHuwCJoklEOKkhF2iY7wakYwatD0Y
         yTsZilbwBrxKad2PDw+AsboTcGf+TSYC6FfXq2xZl9CL2FrRHGKjDB93f5M6o2gRfjWa
         f5oibYzs7r3R8ibaS0mzMWQ1NjYVhoDKOJkf0PiqFM7DbE27F0s5OMjWrpQToA9BqDrr
         kc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMFJWolzCCUGyRUuaILC3spwwtCuqvBuPYOOVXEp/aA=;
        b=AmCh42/RZe9qOJb4KQI9ZTo3JemGuUzMnNURLIu57AVnAwMwJWGQmuAwovhcg4GVzN
         QpYGWEh2dof2TFL96uUY4soVwmQ1AIiXFUpg3KUbDDAZxAFbM9ufyQ5UrPmO7uGPFYnb
         1QWCGwzV9Sm/NnfWE4x8DOPKaeTVz5nfblWxHe58zlnmlkFYbQ0sCu/lMcUG6OQHkH02
         InwfMI6RZFrEEAvVd1BDhauiWBOpY0w7NSkkRqQJADsXZbMnVojIEY/PSZ9/BrKS6XNw
         XQ+w9FPfsHHr98foH9zOD/Js+D3cAwSPPYOZNLS8ibML6EJVPOgr5n7jMPZfuxYJlBA3
         4S5w==
X-Gm-Message-State: APjAAAWZaDlpF2ILyffnVL5Af4jxwmGOehdiU4laBpM7jm408NiQ54j9
        uLGpX+ppAs7aTGbj7EtGmNDNmMJl7PsSRq+I5qN5sPggIbs=
X-Google-Smtp-Source: APXvYqwi+gYj1cVL4mF8Xopoq9y5To6+x5iJhC9e0WbcEazDDmPLdLZBK/hlPgH1EYJCfb16RNbXAt7Qn0TURN7r5Vw=
X-Received: by 2002:a9d:4789:: with SMTP id b9mr21728446otf.247.1575925224491;
 Mon, 09 Dec 2019 13:00:24 -0800 (PST)
MIME-Version: 1.0
References: <20191209191346.5197-1-logang@deltatee.com> <20191209191346.5197-6-logang@deltatee.com>
 <ce50d9da-c60e-05a1-a86b-3bb3629de502@redhat.com> <f34a4c52-cc95-15ed-8a72-c05ab4fd6d33@deltatee.com>
 <20191209204128.GC7658@dhcp22.suse.cz>
In-Reply-To: <20191209204128.GC7658@dhcp22.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 9 Dec 2019 13:00:13 -0800
Message-ID: <CAPcyv4iKKw8cuFyDrY2VLN2ecd-qAbDCfYa7SufuhUb59e89Rw@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm, memory_hotplug: Provide argument for the pgprot_t
 in arch_add_memory()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Dec 9, 2019 at 12:47 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 09-12-19 13:24:19, Logan Gunthorpe wrote:
> >
> >
> > On 2019-12-09 12:23 p.m., David Hildenbrand wrote:
> > > On 09.12.19 20:13, Logan Gunthorpe wrote:
> > >> devm_memremap_pages() is currently used by the PCI P2PDMA code to create
> > >> struct page mappings for IO memory. At present, these mappings are created
> > >> with PAGE_KERNEL which implies setting the PAT bits to be WB. However, on
> > >> x86, an mtrr register will typically override this and force the cache
> > >> type to be UC-. In the case firmware doesn't set this register it is
> > >> effectively WB and will typically result in a machine check exception
> > >> when it's accessed.
> > >>
> > >> Other arches are not currently likely to function correctly seeing they
> > >> don't have any MTRR registers to fall back on.
> > >>
> > >> To solve this, add an argument to arch_add_memory() to explicitly
> > >> set the pgprot value to a specific value.
> > >>
> > >> Of the arches that support MEMORY_HOTPLUG: x86_64, s390 and arm64 is a
> > >> simple change to pass the pgprot_t down to their respective functions
> > >> which set up the page tables. For x86_32, set the page tables explicitly
> > >> using _set_memory_prot() (seeing they are already mapped). For sh, reject
> > >> anything but PAGE_KERNEL settings -- this should be fine, for now, seeing
> > >> sh doesn't support ZONE_DEVICE anyway.
> > >>
> > >> Cc: Dan Williams <dan.j.williams@intel.com>
> > >> Cc: David Hildenbrand <david@redhat.com>
> > >> Cc: Michal Hocko <mhocko@suse.com>
> > >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > >> ---
> > >>  arch/arm64/mm/mmu.c            | 4 ++--
> > >>  arch/ia64/mm/init.c            | 5 ++++-
> > >>  arch/powerpc/mm/mem.c          | 4 ++--
> > >>  arch/s390/mm/init.c            | 4 ++--
> > >>  arch/sh/mm/init.c              | 5 ++++-
> > >>  arch/x86/mm/init_32.c          | 7 ++++++-
> > >>  arch/x86/mm/init_64.c          | 4 ++--
> > >>  include/linux/memory_hotplug.h | 2 +-
> > >>  mm/memory_hotplug.c            | 2 +-
> > >>  mm/memremap.c                  | 2 +-
> > >>  10 files changed, 25 insertions(+), 14 deletions(-)
> > >>
> > >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > >> index 60c929f3683b..48b65272df15 100644
> > >> --- a/arch/arm64/mm/mmu.c
> > >> +++ b/arch/arm64/mm/mmu.c
> > >> @@ -1050,7 +1050,7 @@ int p4d_free_pud_page(p4d_t *p4d, unsigned long addr)
> > >>  }
> > >>
> > >>  #ifdef CONFIG_MEMORY_HOTPLUG
> > >> -int arch_add_memory(int nid, u64 start, u64 size,
> > >> +int arch_add_memory(int nid, u64 start, u64 size, pgprot_t prot,
> > >>                    struct mhp_restrictions *restrictions)
> > >
> > > Can we fiddle that into "struct mhp_restrictions" instead?
> >
> > Yes, if that's what people want, it's pretty trivial to do. I chose not
> > to do it that way because it doesn't get passed down to add_pages() and
> > it's not really a "restriction". If I don't hear any objections, I will
> > do that for v2.
>
> I do agree that restriction is not the best fit. But I consider prot
> argument to complicate the API to all users even though it is not really
> clear whether we are going to have many users really benefiting from it.
> Look at the vmalloc API and try to find how many users of __vmalloc do
> not use PAGE_KERNEL.

At least for this I can foresee at least one more user in the
pipeline, encrypted memory support for persistent memory mappings that
will store the key-id in the ptes.

>
> So I can see two options. One of them is to add arch_add_memory_prot
> that would allow to have give and extra prot argument or simply call
> an arch independent API to change the protection after arch_add_memory.
> The later sounds like much less code. The memory shouldn't be in use by
> anybody at that stage yet AFAIU. Maybe there even is an API like that.

I'm ok with passing it the same way as altmap or a new
arch_add_memory_prot() my only hangup with after the fact changes is
the wasted effort it inflicts in the init path for potentially large
address ranges.
