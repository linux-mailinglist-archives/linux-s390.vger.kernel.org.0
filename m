Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3FA2D5452
	for <lists+linux-s390@lfdr.de>; Thu, 10 Dec 2020 08:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLJHGF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Dec 2020 02:06:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732490AbgLJHGF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Dec 2020 02:06:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607583878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HcG7hVx/CRN4t/5i18tJCttaxP6IQshP6VJEl2g4fpM=;
        b=A6+IXha+DqFWDFAqkeJst1fUW4UpUXMtwt/7paPcQsnRqnzkpHois8SFth7lFXsPHaEsp1
        qluF2v2kPr21QN8632/rQkF6BQ3CLwBgtyHzxpQDLJwHrFucFNaC/CeZAXGifjYgHHMQMj
        kA4/PiiMejk94VxqaOXHx4itBHKTOKY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-77uegNdNOIOhzUwEr0E-yA-1; Thu, 10 Dec 2020 02:04:36 -0500
X-MC-Unique: 77uegNdNOIOhzUwEr0E-yA-1
Received: by mail-wr1-f71.google.com with SMTP id o4so1540850wrw.19
        for <linux-s390@vger.kernel.org>; Wed, 09 Dec 2020 23:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HcG7hVx/CRN4t/5i18tJCttaxP6IQshP6VJEl2g4fpM=;
        b=CvDAi1hauPPaGxmmdGl5VGII27fPq1onUQZ9DI/hxZ9xeaxxOdz3hXfRtlSwuKLZUH
         SL0t2erSBGRzzaFnRph9lcHYv3Zb/g+T21pyGCPPP/ngQD1rnIcnm4qeK0JhD8n2Fgoi
         YCT+JCgi6Zy1ypBDTVSIMO/tHM87hJ5FY40WTjcfBryUfPAv1c1QZdMV1mrAMvJNi0IT
         HqMJW904O6/+wTMeEcjHh8T/jBlxZ9PwaYeFamhGCXs2/JXiTPR2QocFVDi0Am/v6vME
         /Z4CSPxtni3c2kiXd/QyxSro6xKIRwkV0N36l+AwjElviMfozI4ivaofi7NWh+CXaYPJ
         7WMA==
X-Gm-Message-State: AOAM533IXEffnPVArYEzqDO0NiZ7MNbf5ITzoKptFGOS2yczOl16pGzC
        +solSBGckqUl8sUvr4Ed8vc5PhGQzz9wNlBuni5LXEyIxlxphwJeEgy54gv7aTq+r+S5nqmK3gE
        GVgTI1dgGPKEOYbORd7LKtQ==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr6419172wrp.116.1607583874783;
        Wed, 09 Dec 2020 23:04:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9ov4rxUQSJuQKQCETVo2JsPSa0cpqOkgVH6rYsEkEZsiespnxMc4OGEi1K5RhXAOlmCqPUQ==
X-Received: by 2002:a5d:4112:: with SMTP id l18mr6419156wrp.116.1607583874621;
        Wed, 09 Dec 2020 23:04:34 -0800 (PST)
Received: from [192.168.3.114] (p4ff23fc5.dip0.t-ipconnect.de. [79.242.63.197])
        by smtp.gmail.com with ESMTPSA id q17sm7350456wrr.53.2020.12.09.23.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 23:04:33 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/3] s390/mm: Define arch_get_mappable_range()
Date:   Thu, 10 Dec 2020 08:04:32 +0100
Message-Id: <E026809E-4624-4ACE-B309-0443704C637B@redhat.com>
References: <20201210065845.GA20691@osiris>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, david@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
In-Reply-To: <20201210065845.GA20691@osiris>
To:     Heiko Carstens <hca@linux.ibm.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


> Am 10.12.2020 um 07:58 schrieb Heiko Carstens <hca@linux.ibm.com>:
>=20
> =EF=BB=BFOn Thu, Dec 10, 2020 at 09:48:11AM +0530, Anshuman Khandual wrote=
:
>>>> Alternatively leaving __segment_load() and vmem_add_memory() unchanged
>>>> will create three range checks i.e two memhp_range_allowed() and the
>>>> existing VMEM_MAX_PHYS check in vmem_add_mapping() on all the hotplug
>>>> paths, which is not optimal.
>>>=20
>>> Ah, sorry. I didn't follow this discussion too closely. I just thought
>>> my point of view would be clear: let's not have two different ways to
>>> check for the same thing which must be kept in sync.
>>> Therefore I was wondering why this next version is still doing
>>> that. Please find a way to solve this.
>>=20
>> The following change is after the current series and should work with
>> and without memory hotplug enabled. There will be just a single place
>> i.e vmem_get_max_addr() to update in case the maximum address changes
>> from VMEM_MAX_PHYS to something else later.
>=20
> Still not. That's way too much code churn for what you want to achieve.
> If the s390 specific patch would look like below you can add
>=20
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>=20
> But please make sure that the arch_get_mappable_range() prototype in
> linux/memory_hotplug.h is always visible and does not depend on
> CONFIG_MEMORY_HOTPLUG. I'd like to avoid seeing sparse warnings
> because of this.
>=20
> Thanks.
>=20
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index 77767850d0d0..e0e78234ae57 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -291,6 +291,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>    if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot))
>        return -EINVAL;
>=20
> +    VM_BUG_ON(!memhp_range_allowed(start, size, 1));
>    rc =3D vmem_add_mapping(start, size);
>    if (rc)
>        return rc;
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..ccd55e2f97f9 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -4,6 +4,7 @@
>  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>  */
>=20
> +#include <linux/memory_hotplug.h>
> #include <linux/memblock.h>
> #include <linux/pfn.h>
> #include <linux/mm.h>
> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsign=
ed long size)
>    mutex_unlock(&vmem_mutex);
> }
>=20
> +struct range arch_get_mappable_range(void)
> +{
> +    struct range range;
> +
> +    range.start =3D 0;
> +    range.end =3D VMEM_MAX_PHYS;
> +    return range;
> +}
> +
> int vmem_add_mapping(unsigned long start, unsigned long size)
> {
> +    struct range range;
>    int ret;
>=20
> -    if (start + size > VMEM_MAX_PHYS ||
> +    range =3D arch_get_mappable_range();
> +    if (start < range.start ||
> +        start + size > range.end ||
>        start + size < start)
>        return -ERANGE;
>=20
>=20

Right, what I had in mind as reply to v1. Not sure if we really need new che=
cks in common code. Having a new memhp_get_pluggable_range() would be suffic=
ient for my use case (virtio-mem).=

