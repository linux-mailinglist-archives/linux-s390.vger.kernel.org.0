Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31A20F9FE
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2020 18:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgF3Q6v (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jun 2020 12:58:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41756 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387980AbgF3Q6v (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 12:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593536329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=cUG+xvpCXBxcoZX1tRhgzPHCdk+MyqeP1/1VUS+YrEs=;
        b=PHS9HS3yxlfx5xe6XHyvM+rspObZAwjDV2Moq27IQRrtyym2y+yRZIyl+1rfwZb6VmoEDi
        AINHdcWz2tzdp0YZBQOEqr9y02dgIIk9xoZvFEI/YQ2lO/s5PY8AO3FSzG8uV+PpL4dcon
        lyRV+KinocxHxSAKSP3T8P938ZT+HvY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-UW9GlsfkMXWdSLu5H0JMBg-1; Tue, 30 Jun 2020 12:58:45 -0400
X-MC-Unique: UW9GlsfkMXWdSLu5H0JMBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04B8D185B381;
        Tue, 30 Jun 2020 16:58:44 +0000 (UTC)
Received: from [10.36.112.210] (ovpn-112-210.ams2.redhat.com [10.36.112.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41E11B3A7A;
        Tue, 30 Jun 2020 16:58:42 +0000 (UTC)
Subject: Re: [PATCH v1 1/2] mm/memblock: expose only miminal interface to
 add/walk physmem
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200630081730.6862-1-david@redhat.com>
 <20200630081730.6862-2-david@redhat.com>
 <20200630162929.GC2500444@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABtCREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT6JAlgEEwEIAEICGwMFCQlmAYAGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl3pImkCGQEACgkQTd4Q
 9wD/g1o+VA//SFvIHUAvul05u6wKv/pIR6aICPdpF9EIgEU448g+7FfDgQwcEny1pbEzAmiw
 zAXIQ9H0NZh96lcq+yDLtONnXk/bEYWHHUA014A1wqcYNRY8RvY1+eVHb0uu0KYQoXkzvu+s
 Dncuguk470XPnscL27hs8PgOP6QjG4jt75K2LfZ0eAqTOUCZTJxA8A7E9+XTYuU0hs7QVrWJ
 jQdFxQbRMrYz7uP8KmTK9/Cnvqehgl4EzyRaZppshruKMeyheBgvgJd5On1wWq4ZUV5PFM4x
 II3QbD3EJfWbaJMR55jI9dMFa+vK7MFz3rhWOkEx/QR959lfdRSTXdxs8V3zDvChcmRVGN8U
 Vo93d1YNtWnA9w6oCW1dnDZ4kgQZZSBIjp6iHcA08apzh7DPi08jL7M9UQByeYGr8KuR4i6e
 RZI6xhlZerUScVzn35ONwOC91VdYiQgjemiVLq1WDDZ3B7DIzUZ4RQTOaIWdtXBWb8zWakt/
 ztGhsx0e39Gvt3391O1PgcA7ilhvqrBPemJrlb9xSPPRbaNAW39P8ws/UJnzSJqnHMVxbRZC
 Am4add/SM+OCP0w3xYss1jy9T+XdZa0lhUvJfLy7tNcjVG/sxkBXOaSC24MFPuwnoC9WvCVQ
 ZBxouph3kqc4Dt5X1EeXVLeba+466P1fe1rC8MbcwDkoUo65Ag0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAGJAiUEGAECAA8FAlXLn5ECGwwFCQlmAYAACgkQTd4Q
 9wD/g1qA6w/+M+ggFv+JdVsz5+ZIc6MSyGUozASX+bmIuPeIecc9UsFRatc91LuJCKMkD9Uv
 GOcWSeFpLrSGRQ1Z7EMzFVU//qVs6uzhsNk0RYMyS0B6oloW3FpyQ+zOVylFWQCzoyyf227y
 GW8HnXunJSC+4PtlL2AY4yZjAVAPLK2l6mhgClVXTQ/S7cBoTQKP+jvVJOoYkpnFxWE9pn4t
 H5QIFk7Ip8TKr5k3fXVWk4lnUi9MTF/5L/mWqdyIO1s7cjharQCstfWCzWrVeVctpVoDfJWp
 4LwTuQ5yEM2KcPeElLg5fR7WB2zH97oI6/Ko2DlovmfQqXh9xWozQt0iGy5tWzh6I0JrlcxJ
 ileZWLccC4XKD1037Hy2FLAjzfoWgwBLA6ULu0exOOdIa58H4PsXtkFPrUF980EEibUp0zFz
 GotRVekFAceUaRvAj7dh76cToeZkfsjAvBVb4COXuhgX6N4pofgNkW2AtgYu1nUsPAo+NftU
 CxrhjHtLn4QEBpkbErnXQyMjHpIatlYGutVMS91XTQXYydCh5crMPs7hYVsvnmGHIaB9ZMfB
 njnuI31KBiLUks+paRkHQlFcgS2N3gkRBzH7xSZ+t7Re3jvXdXEzKBbQ+dC3lpJB0wPnyMcX
 FOTT3aZT7IgePkt5iC/BKBk3hqKteTnJFeVIT7EC+a6YUFg=
Organization: Red Hat GmbH
Message-ID: <bbd86b6e-e344-514f-7a10-e1078cb60e99@redhat.com>
Date:   Tue, 30 Jun 2020 18:58:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630162929.GC2500444@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>>  extern struct memblock memblock;
>> @@ -114,6 +110,19 @@ int memblock_remove(phys_addr_t base, phys_addr_t size);
>>  int memblock_free(phys_addr_t base, phys_addr_t size);
>>  int memblock_reserve(phys_addr_t base, phys_addr_t size);
>>  #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
>> +/**
>> + * for_each_physmem_range - iterate through physmem areas not included in type.
>> + * @i: u64 used as loop variable
>> + * @type: ptr to memblock_type which excludes from the iteration, can be %NULL
>> + * @p_start: ptr to phys_addr_t for start address of the range, can be %NULL
>> + * @p_end: ptr to phys_addr_t for end address of the range, can be %NULL
>> + */
>> +#define for_each_physmem_range(i, type, p_start, p_end)			\
>> +	for (i = 0, __next_physmem_range(&i, type, p_start, p_end);	\
>> +	     i != (u64)ULLONG_MAX;					\
>> +	     __next_physmem_range(&i, type, p_start, p_end))
>> +void __next_physmem_range(u64 *idx, struct memblock_type *type,
>> +			  phys_addr_t *out_start, phys_addr_t *out_end);
> 
> __next_physmem_range() is not really necessary, the
> for_each_physmem_range() macro can use __next_mem_range() directly, but
> I suspect it won't look nice :)
> 
> Can you please make __next_physmem_range() static inline if we are to
> keep it?

The thing is, then I have to expose "physmem" to something outside
memblock.c. That's what I wanted to avoid here. (instead, have a minimal
interface that is sufficient enough for this special case of physmem -
add memory during boot, walk memory after boot. Performance is not an
issue).

[...]

>>   * Each region is represented by :c:type:`struct memblock_region` that
>>   * defines the region extents, its attributes and NUMA node id on NUMA
>>   * systems. Every memory type is described by the :c:type:`struct
>>   * memblock_type` which contains an array of memory regions along with
>> - * the allocator metadata. The memory types are nicely wrapped with
>> - * :c:type:`struct memblock`. This structure is statically initialzed
>> - * at build time. The region arrays for the "memory" and "reserved"
>> - * types are initially sized to %INIT_MEMBLOCK_REGIONS and for the
>> - * "physmap" type to %INIT_PHYSMEM_REGIONS.
>> + * the allocator metadata. The memory types (except "physmem") are nicely
>> + * wrapped with :c:type:`struct memblock`. This structure is statically
>> + * initialized at build time. The region arrays for the "memory" and
>> + * "reserved" types are initially sized to %INIT_MEMBLOCK_REGIONS.
> 
> I'd prefer
> 
> 	... The "memory" and "reserved" types are nicely wrapped 
> 	with :c:type:`struct memblock`. This structure is statically
>         initialized at build time. 
> 
> And while on this we can update the "reserved" size to match the code:
> 
> 	The region arrays are initilily sized to %INIT_MEMBLOCK_REGIONS
>  	for "memory" and %INIT_MEMBLOCK_RESERVED_REGIONS for "reserved".

Ack to both!

-- 
Thanks,

David / dhildenb

