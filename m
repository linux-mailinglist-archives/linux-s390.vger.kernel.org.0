Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786A6218706
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2020 14:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgGHMQt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jul 2020 08:16:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728896AbgGHMQs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 08:16:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594210606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=IytwUfkabOOQaPkWmBAwl3owXErFfQxs/p+ghsFbWy4=;
        b=A+AgsYLl513rmhGa1Koq8n61xORCJVZoEOHsHAP5cOa1ntz3DgomR6VE4QjSmf2vnqjRNe
        k8pB7PDrd2PXYkxdMMHkkS068PS4usbviXA641Nsas/rwzMHxgPvY/ozAI9WtoVf57cSFu
        PzlDlmXwFywHoJ/49Vuw3l9d2Ghtlfc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-cUd40XKtMf-9G8H0HBa3rA-1; Wed, 08 Jul 2020 08:16:43 -0400
X-MC-Unique: cUd40XKtMf-9G8H0HBa3rA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C628D800401;
        Wed,  8 Jul 2020 12:16:41 +0000 (UTC)
Received: from [10.36.113.117] (ovpn-113-117.ams2.redhat.com [10.36.113.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB4C10016E8;
        Wed,  8 Jul 2020 12:16:40 +0000 (UTC)
Subject: Re: [PATCH v1 0/9] s390: implement and optimize vmemmap_free()
From:   David Hildenbrand <david@redhat.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20200703133917.39045-1-david@redhat.com>
 <20200707120849.GB12303@osiris>
 <f4a87c47-4987-e3f8-8c06-ff6dd60f6a39@redhat.com>
 <51813747-a2d6-03a4-fe61-b8d62dbca05b@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <13549874-c33b-c47a-adbd-d625c83cc87d@redhat.com>
Date:   Wed, 8 Jul 2020 14:16:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <51813747-a2d6-03a4-fe61-b8d62dbca05b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.07.20 08:50, David Hildenbrand wrote:
> On 07.07.20 14:13, David Hildenbrand wrote:
>> On 07.07.20 14:08, Heiko Carstens wrote:
>>> On Fri, Jul 03, 2020 at 03:39:08PM +0200, David Hildenbrand wrote:
>>>> This series is based on the latest s390/features branch [1]. It implements
>>>> vmemmap_free(), consolidating it with vmem_add_range(), and optimizes it by
>>>> - Freeing empty page tables (now also done for idendity mapping).
>>>> - Handling cases where the vmemmap of a section does not fill huge pages
>>>>   completely.
>>>>
>>>> vmemmap_free() is currently never used, unless adiing standby memory fails
>>>> (unlikely). This is relevant for virtio-mem, which adds/removes memory
>>>> in memory block/section granularity (always removes memory in the same
>>>> granularity it added it).
>>>>
>>>> I gave this a proper test with my virtio-mem prototype (which I will share
>>>> once the basic QEMU implementation is upstream), both with 56 byte memmap
>>>> per page and 64 byte memmap per page, with and without huge page support.
>>>> In both cases, removing memory (routed through arch_remove_memory()) will
>>>> result in
>>>> - all populated vmemmap pages to get removed/freed
>>>> - all applicable page tables for the vmemmap getting removed/freed
>>>> - all applicable page tables for the idendity mapping getting removed/freed
>>>> Unfortunately, I don't have access to bigger and z/VM (esp. dcss)
>>>> environments.
>>>>
>>>> This is the basis for real memory hotunplug support for s390x and should
>>>> complete my journey to s390x vmem/vmemmap code for now :)
>>>>
>>>> What needs double-checking is tlb flushing. AFAIKS, as there are no valid
>>>> accesses, doing a single range flush at the end is sufficient, both when
>>>> removing vmemmap pages and the idendity mapping.
>>>>
>>>> Along, some minor cleanups.
>>>
>>> Hmm.. I really would like to see if there would be only a single page
>>> table walker left in vmem.c, which handles both adding and removing
>>> things.
>>> Now we end up with two different page table walk implementations
>>> within the same file. However not sure if it is worth the effort to
>>> unify them though.
>>
>> I tried to unify vmemmap_populate() and vmem_add_range() already and
>> didn't like the end result ... so, unifying these along with the removal
>> part won't be any better - most probably. Open for suggestions :)
>>
>> (at least arm64 and x86-64 handle it similarly)
>>
> 
> I'll play with something like
> 
> static void modify_pagetable(unsigned long start, unsigned long end,
> 			     bool direct, bool add)
> 
> and see how it turns out.
> 

Did a quick hack. With a single walker (modify_pagetable) I get

 arch/s390/mm/vmem.c | 628 ++++++++++++++++++++++++++++++--------------
 1 file changed, 434 insertions(+), 194 deletions(-)

Overall looks cleaner, only modify_pte_table() and modify_pmd_table()
are a little more involved ...

-- 
Thanks,

David / dhildenb

