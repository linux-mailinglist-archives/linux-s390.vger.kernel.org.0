Return-Path: <linux-s390+bounces-1279-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55451841E53
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jan 2024 09:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A680283382
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jan 2024 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4154FBE;
	Tue, 30 Jan 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uev4/vDg"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3F756745
	for <linux-s390@vger.kernel.org>; Tue, 30 Jan 2024 08:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604547; cv=none; b=o0u+NDLLWJHaAggj0ccg/eJnz5u0Wdx5nVK9asxgfTwdooXTYmt6NNNan1SWoBDFQBq4KAbQ1Rb33BRN/pLNqQnzTnMzn401wODsufeOYUKs/YNXNQSMB6Ws417xqXTo3RR+0GvhKfQJM4EvS8j5yCiOl1hDScZK6I8pT6+Aq+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604547; c=relaxed/simple;
	bh=lDHvUzDGp0g80avCSIGF2BmOR0m3AH/F2DgYJLL1Bv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGS6sDplvGILV3JC9ioBxq+5395wSYh2CGCiUlCWVd49EG66/ONJZQUb+JvZTe9nYsp6MgxCKKVrEK/wIpF8587/ARCQkZUWzFhQ2/G7Tez5/VDdOK3HswGZM79X6LAzwgmOYxD+xl4lu84z9KxGaxzVZyNN6gBJSHIhdFTRv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uev4/vDg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706604544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tLfZl+fldZUWURuuVV8KM4xVht5va0e9XkE00pk9Viw=;
	b=Uev4/vDgkPmzYjsjYrxBxxI5zH0wBb5tfEfwy7Y1WithnRSO6iiSLKFsDTUpKJkZVM4IQc
	sqGAOhRCRHrbVeKMs9QLDJRsAPmQvV8Pr2wJH3DlrUN63oPJ4XDRc3AgfC1LLgI+TJ9rGo
	uVKKmsaWEq+g4biGtQOcnAtWBq+0ZLc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-7re5SbXsMqmbB-DaH3Etow-1; Tue, 30 Jan 2024 03:49:02 -0500
X-MC-Unique: 7re5SbXsMqmbB-DaH3Etow-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40ef6b8d0f6so11645165e9.2
        for <linux-s390@vger.kernel.org>; Tue, 30 Jan 2024 00:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604541; x=1707209341;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tLfZl+fldZUWURuuVV8KM4xVht5va0e9XkE00pk9Viw=;
        b=CWPJKZqLjOnRMq7yGDYCUP08MX1vTeT3su+POkmJGzo0Fx5LW8hm94ZkizGRx2iDxP
         D1I5+OvcmxdCl9voZswLxztP6hI9Uk87aADCVLXsx8F99xVsvO6lWk/Wcm93bt5rcBV6
         6bHexmvGl9SV6IvI9e9pbkRabsDLIndJM9UAWnJc22LiXVxLQqjN1yCJqQx7Y2F+08cG
         ZcyRaBpE3wJ+JCfuVvDldYWTrwHbOCbuOi023s2dldgr7qsIW2WYXRIA4Erv8nKlsLzc
         KWyVqXg31b4O0oh86SpeY4DwkclDsRzJwINHpWBWbm/czTl29nHkRebZneyS48pBgQQo
         V/dQ==
X-Gm-Message-State: AOJu0YyXuL7npNZpvT9ERhG9mq8CXO4EUn7SKSlpcPZxMATMjUCwqSTT
	a/N4qAHzWgAUVm4y8vQaSpBFNG/VknrLrOTtKbLX2E2o5UPdWUQh6WC0CrlfkYaRKqqrFkqStwE
	MJdxY3cSRvdRP6Fej84l/2ajixmFa3SvRTUuQDXeR/GnOkRwbCHWCLsujbcE=
X-Received: by 2002:a05:600c:450a:b0:40e:fc1e:5e18 with SMTP id t10-20020a05600c450a00b0040efc1e5e18mr2016000wmo.29.1706604541736;
        Tue, 30 Jan 2024 00:49:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIADSFu/VLFBneg+ablqaQ3sRSUSEyd5TXfS8n4CC9eUA/qPPKEbmU+QH7A9IQuAIWoIz5GQ==
X-Received: by 2002:a05:600c:450a:b0:40e:fc1e:5e18 with SMTP id t10-20020a05600c450a00b0040efc1e5e18mr2015977wmo.29.1706604541358;
        Tue, 30 Jan 2024 00:49:01 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:2700:bdf6:739b:9f9d:862f? (p200300cbc7082700bdf6739b9f9d862f.dip0.t-ipconnect.de. [2003:cb:c708:2700:bdf6:739b:9f9d:862f])
        by smtp.gmail.com with ESMTPSA id r15-20020adfe68f000000b0033af51eafc6sm2538195wrm.104.2024.01.30.00.49.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 00:49:00 -0800 (PST)
Message-ID: <5ee757bd-c940-4cb7-a113-f4501330896e@redhat.com>
Date: Tue, 30 Jan 2024 09:49:00 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] mm/memory: factor out zapping of present pte into
 zap_present_pte()
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240129143221.263763-1-david@redhat.com>
 <20240129143221.263763-2-david@redhat.com>
 <40e87333-4da9-4497-a117-9885986e376a@arm.com>
 <8d19d635-2f55-4c0d-958b-0640f99ff0ce@redhat.com>
 <cae11a08-2f5c-43ca-92fc-a78e9acf4dd8@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <cae11a08-2f5c-43ca-92fc-a78e9acf4dd8@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30.01.24 09:46, Ryan Roberts wrote:
> On 30/01/2024 08:41, David Hildenbrand wrote:
>> On 30.01.24 09:13, Ryan Roberts wrote:
>>> On 29/01/2024 14:32, David Hildenbrand wrote:
>>>> Let's prepare for further changes by factoring out processing of present
>>>> PTEs.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    mm/memory.c | 92 ++++++++++++++++++++++++++++++-----------------------
>>>>    1 file changed, 52 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index b05fd28dbce1..50a6c79c78fc 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1532,13 +1532,61 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct
>>>> *vma,
>>>>        pte_install_uffd_wp_if_needed(vma, addr, pte, pteval);
>>>>    }
>>>>    +static inline void zap_present_pte(struct mmu_gather *tlb,
>>>> +        struct vm_area_struct *vma, pte_t *pte, pte_t ptent,
>>>> +        unsigned long addr, struct zap_details *details,
>>>> +        int *rss, bool *force_flush, bool *force_break)
>>>> +{
>>>> +    struct mm_struct *mm = tlb->mm;
>>>> +    bool delay_rmap = false;
>>>> +    struct folio *folio;
>>>
>>> You need to init this to NULL otherwise its a random value when calling
>>> should_zap_folio() if vm_normal_page() returns NULL.
>>
>> Right, and we can stop setting it to NULL in the original function. Patch #2
>> changes these checks, which is why it's only a problem in this patch.
> 
> Yeah I only noticed that after sending out this reply and moving to the next
> patch. Still worth fixing this intermediate state I think.

Absolutely, I didn't do path-by-patch compilation yet (I suspect the 
compiler would complain).

-- 
Cheers,

David / dhildenb


