Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB51A16CBD
	for <lists+linux-s390@lfdr.de>; Tue,  7 May 2019 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbfEGU6F (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 May 2019 16:58:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37990 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfEGU6E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 May 2019 16:58:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id u199so5512035oie.5
        for <linux-s390@vger.kernel.org>; Tue, 07 May 2019 13:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1mkmD4Z4DaLqsFVMxyizn2ogd6gC2HtEG84lOnN4epw=;
        b=qmbcluUnRpOQqSYRBKyovFsqnRyKdZV6CKWDoAJpSXQgJX7TkK70etljQyZyVQQnWK
         c/TZ+swgI53npSGuu+2JE/6bhNbaKy50WoMbrLuYyKHZOgqRoVScpSt0AHUDQRiAcQzX
         oCyb7TNqVt24+RL0Vtf6NVC5n0CHu3+rUn0PpLS9pEtxDWSdjTEzY+2ThOkn98GdTmda
         WmIbbUjijC2Xp4qKF6wR2l25YLIsQ8YxWCiZOFzDQPqyWI7L+PornZQly/H7EWMuQpgU
         mqhMDZu6CDJUg4UY9KVxC9TDUrtrrctwMCXZWKSFyTMkz/OdmaK1KBlJJy5VFIuOBhbY
         bP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mkmD4Z4DaLqsFVMxyizn2ogd6gC2HtEG84lOnN4epw=;
        b=N2BhGIHQWocfiseEyHZMoCvsXeUeLhIuV6Zf+dGWtrdKSrxlNfL3o/hC64u1Q9po3i
         NC+SUtdfA733rgz7VXsn1cGVzmipVmqKl2eRYfT9QPAYdidNCECEXzZV/lyOJtrTUe9j
         5fGxf3JPPAeewkqE4G4t4ijSI8uJNVqUlCsrlI+Do24LgdIkG2KKsKsikseal471aB9g
         i3pNyx2H3+yCadS2LM/UghDIl1RFVbC4ihNV5R8RO8C06UcFDsAmxeZ2c5lCahOpJpTQ
         z/oMRbWSOBpKoSVaQoHL2FZcbl9c6tdTWpIIKjvESrdarU09a7juZasud1vFd2K6gVQC
         bjlQ==
X-Gm-Message-State: APjAAAWvKDz86lSyZLxCA8BuLI5snax3gLmOXnaDEE6YxRbyTuDddHZn
        wgrAUX5P+x4IlK8pgnHMhoZDClxwmRsox2StXDCEhQ==
X-Google-Smtp-Source: APXvYqzD5+iPmR82mW0JcgXC+OAUQI8mo10rE9WLLRa7cfVMYW4IBqbIoZo+d7Cn/arRPuEVXDJreevhDqywHe+Kspk=
X-Received: by 2002:aca:b108:: with SMTP id a8mr333966oif.0.1557262684029;
 Tue, 07 May 2019 13:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190507183804.5512-1-david@redhat.com> <20190507183804.5512-3-david@redhat.com>
 <CAPcyv4gtAMn2mDz0s1GRTJ52MeTK3jJYLQne6MiEx_ipPFUsmA@mail.gmail.com> <97a6a2ab-0e8b-d403-ca39-ffa4425e15a5@redhat.com>
In-Reply-To: <97a6a2ab-0e8b-d403-ca39-ffa4425e15a5@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 13:57:53 -0700
Message-ID: <CAPcyv4hvpBo=6c6pFCoGiEf3xiPsjc8w2p4Y6_bW4PrzcN=Few@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] s390x/mm: Implement arch_remove_memory()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 7, 2019 at 1:47 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.05.19 22:46, Dan Williams wrote:
> > On Tue, May 7, 2019 at 11:38 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Will come in handy when wanting to handle errors after
> >> arch_add_memory().
> >>
> >> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Vasily Gorbik <gor@linux.ibm.com>
> >> Cc: Oscar Salvador <osalvador@suse.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  arch/s390/mm/init.c | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> >> index 31b1071315d7..1e0cbae69f12 100644
> >> --- a/arch/s390/mm/init.c
> >> +++ b/arch/s390/mm/init.c
> >> @@ -237,12 +237,13 @@ int arch_add_memory(int nid, u64 start, u64 size,
> >>  void arch_remove_memory(int nid, u64 start, u64 size,
> >>                         struct vmem_altmap *altmap)
> >>  {
> >> -       /*
> >> -        * There is no hardware or firmware interface which could trigger a
> >> -        * hot memory remove on s390. So there is nothing that needs to be
> >> -        * implemented.
> >> -        */
> >> -       BUG();
> >> +       unsigned long start_pfn = start >> PAGE_SHIFT;
> >> +       unsigned long nr_pages = size >> PAGE_SHIFT;
> >> +       struct zone *zone;
> >> +
> >> +       zone = page_zone(pfn_to_page(start_pfn));
> >
> > Does s390 actually support passing in an altmap? If 'yes', I think it
> > also needs the vmem_altmap_offset() fixup like x86-64:
> >
> >         /* With altmap the first mapped page is offset from @start */
> >         if (altmap)
> >                 page += vmem_altmap_offset(altmap);
> >
> > ...but I suspect it does not support altmap since
> > arch/s390/mm/vmem.c::vmemmap_populate() does not arrange for 'struct
> > page' capacity to be allocated out of an altmap defined page pool.
> >
> > I think it would be enough to disallow any arch_add_memory() on s390
> > where @altmap is non-NULL. At least until s390 gains ZONE_DEVICE
> > support and can enable the pmem use case.
> >
>
> As far as I know, it doesn't yet, however I guess this could change once
> virtio-pmem is supported?

I would expect and request virtio-pmem remain a non-starter on s390
until s390 gains ZONE_DEVICE support. As it stands virtio-pmem is just
another flavor of the general pmem driver and the pmem driver
currently only exports ZONE_DEVICE pfns tagged by the PTE_DEVMAP
pte-flag and PFN_DEV+PFN_MAP pfn_t-flags.

A hamstrung version of DAX (CONFIG_FS_DAX_LIMITED) is enabled for the
s390/dcssblk driver, but that requires that the driver indicate this
limited use case via the PTE_SPECIAL pte-flag and PFN_SPECIAL
pfn_t-flag. I otherwise do not want to see CONFIG_FS_DAX_LIMITED
spread outside of the s390/dcssblk use case.
