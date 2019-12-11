Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8204911ABCA
	for <lists+linux-s390@lfdr.de>; Wed, 11 Dec 2019 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfLKNOr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Dec 2019 08:14:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729173AbfLKNOr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Dec 2019 08:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576070086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=T+UmRSAJumJkyVb2/Xa8NpUKyYfVwWuqVj3MmTM25gw=;
        b=PghkjdDneZx8iWsw+Pk2B6FFNgMzm+/0qM77v1eYhYQZIYxOnAs6daVCfYZ3b218MBWNY/
        Nxov1VrAKxWUIPBSTYO4cL++wdK+DdMD1rBJBuq391hLD6V1/PZzcQ8Uv6IFBHlhoOF+rU
        PcZCSFQQ5UZYQ4sTBAcFgorZ+IaZEsg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-T3O_dlbNNpm_wehjpZz6ew-1; Wed, 11 Dec 2019 08:14:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CCDBADBE5;
        Wed, 11 Dec 2019 13:14:41 +0000 (UTC)
Received: from [10.36.117.148] (ovpn-117-148.ams2.redhat.com [10.36.117.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C711076FFA;
        Wed, 11 Dec 2019 13:14:40 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: smp: Setup CRs from cpu 0
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, linux-s390@vger.kernel.org
References: <20191211115923.9191-1-frankja@linux.ibm.com>
 <20191211115923.9191-3-frankja@linux.ibm.com>
 <75eadbf8-1159-1c3f-12c4-bda518adb2ef@redhat.com>
 <15cd9f10-a56b-949d-dc0f-2d5aa175222a@linux.ibm.com>
 <03e80db5-dee7-b646-dd01-f713cdecbc29@redhat.com>
 <73296143-98cb-bb86-924d-400bcc027c34@linux.ibm.com>
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
Message-ID: <de8319a4-a1dd-3109-5ee5-aa6847494341@redhat.com>
Date:   Wed, 11 Dec 2019 14:14:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <73296143-98cb-bb86-924d-400bcc027c34@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: T3O_dlbNNpm_wehjpZz6ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.12.19 14:08, Janosch Frank wrote:
> On 12/11/19 1:54 PM, David Hildenbrand wrote:
>> On 11.12.19 13:37, Janosch Frank wrote:
>>> On 12/11/19 1:32 PM, David Hildenbrand wrote:
>>>> On 11.12.19 12:59, Janosch Frank wrote:
>>>>> Grab the CRs (currently only 0, 1, 7, 13) from cpu 0, so we can
>>>>> bringup the new cpu in DAT mode or set other control options.
>>>>>
>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>> ---
>>>>>  lib/s390x/smp.c  | 5 ++++-
>>>>>  s390x/cstart64.S | 2 +-
>>>>>  2 files changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
>>>>> index e17751a..4dfe7c6 100644
>>>>> --- a/lib/s390x/smp.c
>>>>> +++ b/lib/s390x/smp.c
>>>>> @@ -191,7 +191,10 @@ int smp_cpu_setup(uint16_t addr, struct psw psw)
>>>>>  	cpu->lowcore->sw_int_grs[15] = (uint64_t)cpu->stack + (PAGE_SIZE * 4);
>>>>>  	lc->restart_new_psw.mask = 0x0000000180000000UL;
>>>>>  	lc->restart_new_psw.addr = (uint64_t)smp_cpu_setup_state;
>>>>> -	lc->sw_int_crs[0] = 0x0000000000040000UL;
>>>>> +	lc->sw_int_crs[0] = stctg(0);
>>>>> +	lc->sw_int_crs[1] = stctg(1);
>>>>> +	lc->sw_int_crs[7] = stctg(7);
>>>>> +	lc->sw_int_crs[13] = stctg(13);
>>>>
>>>> Wouldn't it be better to also be able to specify the CRs explicitly here?
>>>>
>>>
>>> Yes, but currently there are no users for something like that and it
>>> would mean that we might need to add more code to support it.
>>>
>>> As I said in the cover letter, this is a good first step to allow DAT on
>>> additional cpus without any real setup needed in a test. Later we could
>>> add a function to specify the CRs explicitly.
>>>
>>
>> Can you clarify why we need this patch now (e.g., DAT)? This patch
>> sounds like it would make sense in the future only (it is easier to
>> review with future changes IMHO).
>>
> 
> Some G1 UV calls need the home space and therefore I added this patch to
> my concurrency tests which are still in my queue. I thought these fixes
> might make sense anyway and could be flushed from my queue before the UV
> patches are ready.

Okay, so it needs e.g., CR13, but we only populate CR0 and CR1 right now
if I'm not wrong. IOW, let's send this with the other patches (or only
populate cr0/cr1 in this patch and add the other stuff on top later on).

-- 
Thanks,

David / dhildenb

