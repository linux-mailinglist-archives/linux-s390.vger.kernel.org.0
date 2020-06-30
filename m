Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A741420FA30
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2020 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgF3RLO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jun 2020 13:11:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387539AbgF3RLK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 13:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593537069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhbgPy3RIqyVco+ZXtnNx1YEyJATW1/whGxTMYYXUd4=;
        b=HbyolUhnNLwBVpSElPLFXwTs47DHo8Afdz+jKYF7+NEkKNsEz2yMyKA77iExt6CR4BytrP
        9aYC5uv5oJgfMiCUGsDOv7o3xBgzNL8yZnEv2aR2lDC8FvP5ZwriCDRZb1Kpxf1E69sUV3
        45btHEs5QuV9FnIlyrfBlBgOW83dx0k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-VxRrETvcPcG0C0wAvikQ_Q-1; Tue, 30 Jun 2020 13:11:07 -0400
X-MC-Unique: VxRrETvcPcG0C0wAvikQ_Q-1
Received: by mail-wr1-f70.google.com with SMTP id w4so17144513wrm.5
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2020 10:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=yhbgPy3RIqyVco+ZXtnNx1YEyJATW1/whGxTMYYXUd4=;
        b=l0QMNrq4iA7YMrIWOKrJY0Z6/+q9vgjKss9l8n6WM0z4RxWN3N6iFyTi2EcJusOjkp
         jeutQ++dHGojZL1/Uk/ynJNl7GeOputpRuXJUILYu34i9dYiIAms1yzntvuQxuxovfaz
         YVR4Ry4phJZFTXDrONPZmRA5S9A88ceS1d/n/XPRj4KRT+Kx4H6Gv1fMljiAiMsCaFtH
         3R0LWHZMwqKHuMBh2y9Sac+XZXfHjiz2WnHQFcWgvbB7npdgs2jk0/4fx32IS9ErYD+0
         FvFtgRv9WBEMgupgCUQO6ziC3kbS+iNgkpziK/4lI4Xy1OJIIq9YfV45ZYpj64ot6DLs
         2uUg==
X-Gm-Message-State: AOAM532mXotneY1SHhd6Ow9/fYBR+vnvwvrISOs3DEEMuKG7+GnD4dMA
        fBa3nTvEVSfkIn+fz/oWhJaOGaegW2Cgs6zQ0J2xzf2j/cYCHiHsco7b5r4Zx0RepLwsl3IrGjV
        MJC9o1qtIqV/dCMmhCrircg==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr22262818wmg.74.1593537066601;
        Tue, 30 Jun 2020 10:11:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhWL0b5uQZGwO3pRNQJ9BrMkXvpSgnuuAKj9ZmkWwjoEQcUJ/87vEBLfiBSM7064L0HKcPHg==
X-Received: by 2002:a05:600c:2058:: with SMTP id p24mr22262797wmg.74.1593537066344;
        Tue, 30 Jun 2020 10:11:06 -0700 (PDT)
Received: from [192.168.3.122] (p4ff23ffe.dip0.t-ipconnect.de. [79.242.63.254])
        by smtp.gmail.com with ESMTPSA id v24sm5200496wrd.92.2020.06.30.10.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 10:11:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to add/walk physmem
Date:   Tue, 30 Jun 2020 19:11:04 +0200
Message-Id: <31512CDA-4B5E-447C-B84A-C1A592323975@redhat.com>
References: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 30.06.2020 um 18:58 schrieb David Hildenbrand <david@redhat.com>:
>=20
> =EF=BB=BF
>>=20
>>> extern struct memblock memblock;
>>> @@ -114,6 +110,19 @@ int memblock_remove(phys_addr_t base, phys_addr_t s=
ize);
>>> int memblock_free(phys_addr_t base, phys_addr_t size);
>>> int memblock_reserve(phys_addr_t base, phys_addr_t size);
>>> #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>>> +/**
>>> + * for_each_physmem_range - iterate through physmem areas not included i=
n type.
>>> + * @i: u64 used as loop variable
>>> + * @type: ptr to memblock_type which excludes from the iteration, can b=
e %NULL
>>> + * @p_start: ptr to phys_addr_t for start address of the range, can be %=
NULL
>>> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NUL=
L
>>> + */
>>> +#define for_each_physmem_range(i, type, p_start, p_end)            \
>>> +    for (i =3D 0, __next_physmem_range(&i, type, p_start, p_end);    \
>>> +         i !=3D (u64)ULLONG_MAX;                    \
>>> +         __next_physmem_range(&i, type, p_start, p_end))
>>> +void __next_physmem_range(u64 *idx, struct memblock_type *type,
>>> +              phys_addr_t *out_start, phys_addr_t *out_end);
>>=20
>> __next_physmem_range() is not really necessary, the
>> for_each_physmem_range() macro can use __next_mem_range() directly, but
>> I suspect it won't look nice :)
>>=20
>> Can you please make __next_physmem_range() static inline if we are to
>> keep it?
>=20
> The thing is, then I have to expose "physmem" to something outside
> memblock.c. That's what I wanted to avoid here. (instead, have a minimal
> interface that is sufficient enough for this special case of physmem -
> add memory during boot, walk memory after boot. Performance is not an
> issue).

... but it might do with an extern declaration within the inline function. W=
ill have a look tomorrow, thanks!=

