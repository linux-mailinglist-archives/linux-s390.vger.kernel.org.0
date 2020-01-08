Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99607134B3D
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jan 2020 20:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgAHTIO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jan 2020 14:08:14 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728789AbgAHTIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 14:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578510492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Amws6MWhDh9ExYW39LjH1zvpuHRVUUVI5bKPn/z5HTo=;
        b=MgrzUElRXSqqnGryin3ePG5/wLCinB1rGbHGoagz4D+fKKE5ukqp8Uo3sYWeTVSqCt/rWr
        lirw98n1ZbFmu7pMx5xSuDMT5/tA4l0TipOQwCHOpxPVylTAVDTR+Y9Svxh8dc/Ar1km+U
        MVNHYTqdDlci2Ogw7GZSwP+DKWyOpsY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-IGp8nmWkNrWiVRn7MNeJKQ-1; Wed, 08 Jan 2020 14:08:11 -0500
X-MC-Unique: IGp8nmWkNrWiVRn7MNeJKQ-1
Received: by mail-wm1-f69.google.com with SMTP id l11so129200wmi.0
        for <linux-s390@vger.kernel.org>; Wed, 08 Jan 2020 11:08:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Amws6MWhDh9ExYW39LjH1zvpuHRVUUVI5bKPn/z5HTo=;
        b=FEaEJYl38LREV4aD+1xOsU3/BR9LETvqySTkSpeB9Oe2T5nto/0DXVdet8910e1RBT
         +PHgL9wXNOa3l6JXC4PE8FoSxG2VCNHlNfhDQf4UIEybaMkmC4ZF7XGNFW0H61nOjEfk
         o63mznykDo9tD+TJs59zmi3o7YxgGn/oEc23JI857AdngK2wv6aLaXWxuvh6SUiPnx0u
         nM/Muda76wQuua7qsPSaf5bJkvvbN2eOKuPrWj2CZ1gI4f97vT/BEscB/vEHiqzHlxyU
         /kkUmRKpdlvaxGVYmJuiExZi7PaC6CIQ9XGCbsRNn9Bm4iM2Wq1CHJu56PoQqQNaTX2i
         Yejw==
X-Gm-Message-State: APjAAAXl0HPjfqF/h3F8n/elHhapStrm1kP5IiXY5oN1H42fYEaxNH+q
        wJVLHJd0rHlfG5epXaSbEw50jZoTZ35hS22p1Cb0qFL1tjKgwBXaemIBDQ1tUre4ZsQT75LdNXs
        6+gdGU+O3zD0/b8SRyYF0lQ==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr6334282wrv.77.1578510490048;
        Wed, 08 Jan 2020 11:08:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqzwSf5xR5AuD7FXuI2qLWJMD45CtNqKofERmd6oZKYNzsaH7aKCx0AwVIr77ei63TWVvkuj2Q==
X-Received: by 2002:a5d:534d:: with SMTP id t13mr6334244wrv.77.1578510489748;
        Wed, 08 Jan 2020 11:08:09 -0800 (PST)
Received: from [192.168.3.122] (p5B0C6BAD.dip0.t-ipconnect.de. [91.12.107.173])
        by smtp.gmail.com with ESMTPSA id f12sm49809wmf.28.2020.01.08.11.08.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:08:09 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 2/8] mm/memory_hotplug: Rename mhp_restrictions to mhp_modifiers
Date:   Wed, 8 Jan 2020 20:08:07 +0100
Message-Id: <5D5ED235-EB67-4072-8CCA-C046B7EC031C@redhat.com>
References: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
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
In-Reply-To: <CAPcyv4hdpMs5om4_VrYUz98aWDJ9eRhj7WJr312Jwn6LCmAm9Q@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> Am 08.01.2020 um 20:00 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Wed, Jan 8, 2020 at 9:17 AM Logan Gunthorpe <logang@deltatee.c=
om> wrote:
>>=20
>>=20
>>=20
>>> On 2020-01-08 5:28 a.m., David Hildenbrand wrote:
>>> On 07.01.20 21:59, Logan Gunthorpe wrote:
>>>> The mhp_restrictions struct really doesn't specify anything resembling
>>>> a restriction anymore so rename it to be mhp_modifiers.
>>>=20
>>> I wonder if something like "mhp_params" would be even better. It's
>>> essentially just a way to avoid changing call chains rough-out all archs=

>>> whenever we want to add a new parameter.
>>=20
>> Sure, that does sound a bit nicer to me. I can change it for v3.
>=20
> Oh, I was just about to chime in to support "modifiers" because I
> would expect all parameters to folded into a "params" struct. The
> modifiers seem to be limited to the set of items that are only
> considered in a non-default / expert memory hotplug use cases.
>=20

It=E2=80=98s a set of extended parameters I=E2=80=98d say.=20=

