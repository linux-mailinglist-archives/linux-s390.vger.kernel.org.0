Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDB71BF2E3
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2020 10:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgD3IeN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Apr 2020 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726685AbgD3IeN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 04:34:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCADC08E934
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2020 01:34:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so3993225ejx.5
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2020 01:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87dIcS/jrU3IxflLIkdtnvU4qll0iHvEZNuLGZ4o7wI=;
        b=C7NzSwQeQ8r7hb6zu0mE43nN5BVsWOZy21t9s86oMspwPoqNG+2r9QwYXMI253bkO+
         f2NXbqJEZlVUDXw2jKOJXTdMksOMSeCU/1+d1/KW3kPK6bDnIkjaV85ydvslVx7+7VaK
         H/Wy8s3jtrbog9dFPbt+U8g4F9a/kPxAFzoHfDtTpSCDud/nTiDKxbIHNOx4gDT1cWli
         scShmtfTOkTf1D6LztaDjOZAMAIUOcl9E1Ehg4s+icpPrmffJn6TfhOtMJuuVZZemCWo
         u5q8IaOdIkls7C87+V/X7frCMtH72XB/et/faVXvhnFad5uP3/TQ8BbSLNTCllAusarT
         BwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87dIcS/jrU3IxflLIkdtnvU4qll0iHvEZNuLGZ4o7wI=;
        b=qM8iHEO+pY2xWQczP6bbbMr6fifr8hOU98NY7T129QVJNEidatMagVtoi6T32nD/nS
         818zr8Y1MKe/uclG9UKRLsQ1pUhxSKTB0LLLgEIoSrxtpEVzbgVJHS9xnGGcoE5vhbb3
         NWfSCXi5dt+J70fUEZlSmnh/fr3fIOtLQNE77uKTVqmZ5Xszv0p3EmnVtZ+8dxS94WH2
         +OX/zsW2JQYhI++8Ga48cNYChqekXNINmK8mL75RC7VsrUNTfbktrsu1IYwjy8AoULls
         vAkr09DBd9W443P+FXHP7nXbpgeU/+fQshdtQlhH7kK5QXIf6Z/5wfWEtQ4MvBpjjxGq
         wBpw==
X-Gm-Message-State: AGi0PubaQuAM36OUD49CageRdJ9ldw4i8Ywt4xz5wV1JmZeNjhqPK3pH
        2R7GgZN6+DBv+cinwSC2AhS4PUtuTtC/Cr9hJWsArw==
X-Google-Smtp-Source: APiQypLBVztlIIHfr3wCtEt+MVa/TaJHl/O1nuNqStB0TwAKkS6wTTbCgFJlPXMDG8iI601GTPaB481cRsH+FNdImHY=
X-Received: by 2002:a17:906:7750:: with SMTP id o16mr1715515ejn.12.1588235651152;
 Thu, 30 Apr 2020 01:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200429160803.109056-1-david@redhat.com> <20200429160803.109056-3-david@redhat.com>
 <a7305cd8-8b2f-1d8f-7654-ecf777c46df6@redhat.com> <CAPcyv4i04+QLxiOyz04_eef2DFetEFKBUmi2A4xxw9abQD8hNQ@mail.gmail.com>
 <e32522cd-31bb-e129-47a6-9ec13b570506@redhat.com>
In-Reply-To: <e32522cd-31bb-e129-47a6-9ec13b570506@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 30 Apr 2020 01:34:00 -0700
Message-ID: <CAPcyv4gjRE23BHsBAnaVWAPUHWdenxYMUwDBnDF7UmoejmmbNQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-hyperv@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Apr 30, 2020 at 1:21 AM David Hildenbrand <david@redhat.com> wrote:
> >> Just because we decided to use some DAX memory in the current kernel as
> >> system ram, doesn't mean we should make that decision for the kexec
> >> kernel (e.g., using it as initial memory, placing kexec binaries onto
> >> it, etc.). This is also not what we would observe during a real reboot.
> >
> > Agree.
> >
> >> I can see that the "System RAM" resource will show up as child resource
> >> under the device e.g., in /proc/iomem.
> >>
> >> However, entries in /sys/firmware/memmap/ are created as "System RAM".
> >
> > True. Do you think this rename should just be limited to what type
> > /sys/firmware/memmap/ emits? I have the concern, but no proof
>
> We could split this patch into
>
> MHP_NO_FIRMWARE_MEMMAP (create firmware memmap entries)
>
> and
>
> MHP_DRIVER_MANAGED (name of the resource)
>
> See below, the latter might not be needed.
>
> > currently, that there are /proc/iomem walkers that explicitly look for
> > "System RAM", but might be thrown off by "System RAM (driver
> > managed)". I was not aware of /sys/firmware/memmap until about 5
> > minutes ago.
>
> The only two users of /proc/iomem I am aware of are kexec-tools and some
> s390x tools.
>
> kexec-tools on x86-64 uses /sys/firmware/memmap to craft the initial
> memmap, but uses /proc/iomem to
> a) Find places for kexec images
> b) Detect memory regions to dump via kdump
>
> I am not yet sure if we really need the "System RAM (driver managed)"
> part. If we can teach kexec-tools to
> a) Don't place kexec images on "System RAM" that has a parent resource
> (most likely requires kexec-tools changes)
> b) Consider for kdump "System RAM" that has a parent resource
> we might be able to avoid renaming that. (I assume that's already done)
>
> E.g., regarding virtio-mem (patch #3) I am currently also looking into
> creating a parent resource instead, like dax/kmem to avoid the rename:
>
> :/# cat /proc/iomem
> 00000000-00000fff : Reserved
> [...]
> 100000000-13fffffff : System RAM
> 140000000-33fffffff : virtio0
>   140000000-147ffffff : System RAM
>   148000000-14fffffff : System RAM
>   150000000-157ffffff : System RAM
> 340000000-303fffffff : virtio1
>   340000000-347ffffff : System RAM
> 3280000000-32ffffffff : PCI Bus 0000:00

Looks good to me if it flies with kexec-tools.
