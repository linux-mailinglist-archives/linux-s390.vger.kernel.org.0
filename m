Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAAD1725FA
	for <lists+linux-s390@lfdr.de>; Thu, 27 Feb 2020 19:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgB0SIV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Feb 2020 13:08:21 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40429 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgB0SIV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Feb 2020 13:08:21 -0500
Received: by mail-ot1-f65.google.com with SMTP id a36so34223otb.7
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 10:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4F3CkEYboenOdYfvgxaEFjzaB88Ias8AvgF6y2bsYJo=;
        b=btVB1/kCSyh3miQnMYs3e17lMek8QSVYBuP0FlHl1SN8jj8AK7ZcsZTrZLYZcDr8L0
         NSJ9MeY7RriOXGf8mxUIHycStwVTMNeNi3yrQla6dMYLj551Rp9KWZnTu9g5AKGKvvYT
         9WlFsCXT0V4ckXbqldT9RpXG/xwR6Da9kdRkEzPi8tdoEUk2abNALGro5ZLdP/rXl0tG
         /sptmzlpcqEIizzSfsWPT6ZSjga8U2PolwmP3cK/7EJmAplRWGpIpx3oVOIujglDOBPB
         U/jmRkYeKgZuoKDQ/uKn2xiCIfawYUF6S/k5E1dLzCZ3Me3N7Bit13cPq5fiueJNzJqi
         dLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4F3CkEYboenOdYfvgxaEFjzaB88Ias8AvgF6y2bsYJo=;
        b=FghcynKHtBiWChUss6zZAMaIygtli6QCZg666r5HAsGsCBjkn7qVJ7yRCPgjiUMWWg
         B03TlSw/v6Lqj+YTwf3k4HV7muoSXEyarwiXIHySBPbbDYsMmrvXUcnB4gIORwr8sxc6
         UU6DT2Hd08jmNdrZE7MPIP+4NqrO9igOgZCJIiI3LX8GLAAQn29GF623Y3hN1lb2+f22
         38EpXWkbBF2bAehzpVSZ4arFgt7m2JUipsxVITdMzepOttt3UXj3WiSjiTMI2luHspaY
         49PwHD2bwW5IRAl1M4JB3UWKdbewSxsLsw5dWh04PSPV4rID2kSxvvhhEK9dHZcbIuUW
         gGsw==
X-Gm-Message-State: APjAAAXWBZWBvYoap6sKcYl4egxmmhm9+Inj33Isybyth0Z9dNH8dULV
        9gHxjiRcLJWDcceQ3BWULn1CCIrdRFRZS2ZYGKB0pQ==
X-Google-Smtp-Source: APXvYqzWZDXbIbzo1esKuuymk2opANK/r16XeVx9wwrPYC7dcJfvghbSyviygno+FjUiHqeLzBQ9brN5G7f+Od4lm4g=
X-Received: by 2002:a9d:6c9:: with SMTP id 67mr93279otx.363.1582826900650;
 Thu, 27 Feb 2020 10:08:20 -0800 (PST)
MIME-Version: 1.0
References: <20200221182503.28317-1-logang@deltatee.com> <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com> <20200227174311.GL31668@ziepe.ca>
 <CAPcyv4iek=EmNk9JgXq=-HcZjd9Kz4m2+qXMhnDWMshFKFZPXQ@mail.gmail.com> <20200227180346.GM31668@ziepe.ca>
In-Reply-To: <20200227180346.GM31668@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Feb 2020 10:08:09 -0800
Message-ID: <CAPcyv4g6OYvD57LdWcqGuWVanckQv4a1uzJrE1OZyMH+z=5KZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 27, 2020 at 10:03 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Feb 27, 2020 at 09:55:04AM -0800, Dan Williams wrote:
> > On Thu, Feb 27, 2020 at 9:43 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >
> > > On Thu, Feb 27, 2020 at 10:21:50AM -0700, Logan Gunthorpe wrote:
> > > >
> > > >
> > > > On 2020-02-27 10:17 a.m., Jason Gunthorpe wrote:
> > > > >> Instead of this, this series proposes a change to arch_add_memory()
> > > > >> to take the pgprot required by the mapping which allows us to
> > > > >> explicitly set pagetable entries for P2PDMA memory to WC.
> > > > >
> > > > > Is there a particular reason why WC was selected here? I thought for
> > > > > the p2pdma cases there was no kernel user that touched the memory?
> > > >
> > > > Yes, that's correct. I choose WC here because the existing users are
> > > > registering memory blocks without side effects which fit the WC
> > > > semantics well.
> > >
> > > Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> > > Linux, so while it is true the memory has no side effects, there would
> > > be surprising concurrency risks if anything in the kernel tried to
> > > write to it.
> > >
> > > Not compatible means the locks don't contain stores to WC memory the
> > > way you would expect. AFAIK on many CPUs extra barriers are required
> > > to keep WC stores ordered, the same way ARM already has extra barriers
> > > to keep UC stores ordered with locking..
> > >
> > > The spinlocks are defined to contain UC stores though.
> >
> > How are spinlocks and mutexes getting into p2pdma ranges in the first
> > instance? Even with UC, the system has bigger problems if it's trying
> > to send bus locks targeting PCI, see the flurry of activity of trying
> > to trigger faults on split locks [1].
>
> This is not what I was trying to explain.
>
> Consider
>
>  static spinlock lock; // CPU DRAM
>  static idx = 0;
>  u64 *wc_memory = [..];
>
>  spin_lock(&lock);
>  wc_memory[0] = idx++;
>  spin_unlock(&lock);
>
> You'd expect that the PCI device will observe stores where idx is
> strictly increasing, but this is not guarenteed. idx may decrease, idx
> may skip. It just won't duplicate.
>
> Or perhaps
>
>  wc_memory[0] = foo;
>  writel(doorbell)
>
> foo is not guarenteed observable by the device before doorbell reaches
> the device.
>
> All of these are things that do not happen with UC or NC memory, and
> are surprising violations of our programming model.
>
> Generic kernel code should never touch WC memory unless the code is
> specifically designed to handle it.

Ah, yes, agree.
