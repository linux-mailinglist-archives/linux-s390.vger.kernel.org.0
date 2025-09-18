Return-Path: <linux-s390+bounces-12612-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 840CBB3E989
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 17:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EA87AD54E
	for <lists+linux-s390@lfdr.de>; Mon,  1 Sep 2025 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B353451A5;
	Mon,  1 Sep 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHBYzpJh"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE99343D9B
	for <linux-s390@vger.kernel.org>; Mon,  1 Sep 2025 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739468; cv=none; b=nBn6Hgx8nUC4WN6oiQ9rdwBUgpyNPSftjECFz3AVlxp74SYFLTi1ErshNPxbHxkXyeVK8xNQFXmUe6PqujO2FhAjpTd8fF8gFQu6w6TrtPGQMR9vjFEE1BlWUVwhB6kiaJoIz0F5BrCICLyUbFfEnUOx932aVIJFgLkmDepoXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739468; c=relaxed/simple;
	bh=Ma/UP1lSiVqJNi8TyJQVaTJF/dk/rmw8jKKc9OcTuvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nmYY9c8X6ctZubqUGWzmBku8oATf+isKCuJ21UML3dCncc2sTJ2kmu28tD4FeJwYWBiwPyktWpaEZNMT6NQFsjnkB5z92SJYPGlRmxLzQcEbU4lNWXIOEFz6mUt5U+j8xsM0uisv2Jd/osntLfm1HpNFtyGwl4ydDHovbUHoe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHBYzpJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756739465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VMxdRy5rmNFmudF6fK3kGDCxNJBEq1WURzElFRewt34=;
	b=hHBYzpJhe/5Fy5xlEm2qhQyaFY7U7LZZsL8wzV7k7F7FplZEbBfCXEzf//RX+jzRug9IGz
	46PvB8XQmGmfNd/2ZdsszYrK9vqwrdgzsELR4Ak7kFVAreCcWfkGziiA/JQPYOZspIuggE
	hzmEuNGsd9BE9ub5+j27Im5TZmUmJeQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-BexRZM7PNTS-5bYDMzlixg-1; Mon, 01 Sep 2025 11:11:04 -0400
X-MC-Unique: BexRZM7PNTS-5bYDMzlixg-1
X-Mimecast-MFC-AGG-ID: BexRZM7PNTS-5bYDMzlixg_1756739463
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45b7d497abbso26469455e9.0
        for <linux-s390@vger.kernel.org>; Mon, 01 Sep 2025 08:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739463; x=1757344263;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VMxdRy5rmNFmudF6fK3kGDCxNJBEq1WURzElFRewt34=;
        b=J4ZaLH4GEmUr3lS9wOCbtDTwoyE5eb31JBeLnEU9AS63ERC0Jw3MVhCJvykFeekjIJ
         NpFWgprDQLZTFKqBs0zAc4P0KUJEKFbYTWTHBSmIawGAf/tU3T6SLiEcFRKRsLAltqfy
         Y+FLkWRWce+yvGYPgV8T197kayWuwJC7QpWkiHhre2khERyIK+sZbjQ2llX4ag0H4txj
         czbUydGAlJsamJeP1BiR/zYOYdE9Rl8B4TNGwyh6ObHtK1trRg+nXnUzGHjSjutf0Wii
         aLX3HodRxKG3WKsbaJ4pVRXOU133whetqLui8UQ/VKrmq4WFRjMfvHekh71dTiaEfdZr
         7CEA==
X-Forwarded-Encrypted: i=1; AJvYcCU6a07wQgepZ668USw4sJFksZhInTM2B6E8tJUcbASHaFCD8SpX72qYtK+dkGSvxPoiPjqwi0WNfEZG@vger.kernel.org
X-Gm-Message-State: AOJu0YwgRlG7FLHIUQweySC9l9/CclNX+1CqVQ/iBnoDU/7p4MSqLW6M
	pG0ZATiUBpLW3skJj3Es4V66GcvHEplkuUIZCyoMQpbJAem2v9PWkKuUU8hssGGTCpKKMnq59xq
	XveSeX94GIefDbmydlz8jtDfsd4RVKjnGpse3DnQKCKqtNnzy7wh7JMUDEn8I3qY=
X-Gm-Gg: ASbGncvUutKj8SkVtV6MC22vtLdr72ZNfUbegLOLRoJJwOXQ43/igI4WLOGmRHATFsj
	nqZ9QCqQ1mKVq2SkG2975JzT8204cMe0RcM7l/9xNZKaORNPo1T3CP9RGJXLJ51hHoOr6N3obGu
	GzrQ9IZ8PJjJQzTideVG0P4Nco/oC3D47JhCeY9LbX6u41jnwGMlp5yScy2hetDfX8iX29vwTmx
	AAeqnFN5E+SqYoXqQKUg+nGrQLJItvSHZV7IQb15xHXy9x82ZksMRZQyXdujct8wizEptLBZZ/T
	zpcQHnOv07P0iBXJFfxw3YSoyGfmdFS1BJRqvAIwQR8YCBs3rvs7HFiJf3YcSUxpJKoTHHWOE0+
	/3IiF1GnlETzKsPW4pGVvvz2YkXPKiJO5RzWzJX6Q/XWSTxjKH+gRIW0SLuWHBSQcwFw=
X-Received: by 2002:a05:600c:3b99:b0:45b:88b1:373f with SMTP id 5b1f17b1804b1-45b88b138cfmr49843265e9.19.1756739463450;
        Mon, 01 Sep 2025 08:11:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGf6Rd6PfORW/LyvT41zVzRuA2itBBI/jcr5+K/tI5o0lZ645Xd5UGGPJrfen/4NaJ0FQpwRw==
X-Received: by 2002:a05:600c:3b99:b0:45b:88b1:373f with SMTP id 5b1f17b1804b1-45b88b138cfmr49842935e9.19.1756739462931;
        Mon, 01 Sep 2025 08:11:02 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e8ab832sm159807805e9.23.2025.09.01.08.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:11:02 -0700 (PDT)
Message-ID: <0bcb2d4d-9fb5-40c0-ab61-e021277a6ba3@redhat.com>
Date: Mon, 1 Sep 2025 17:11:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
 linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com, deller@gmx.de,
 agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 davem@davemloft.net, andreas@gaisler.com, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, x86@kernel.org, hpa@zytor.com, chris@zankel.net,
 jcmvbkbc@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, weixugc@google.com, baolin.wang@linux.alibaba.com,
 rientjes@google.com, shakeel.butt@linux.dev, thuth@redhat.com,
 broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com,
 mpe@ellerman.id.au, nysal@linux.ibm.com,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com>
 <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
 <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 17:02, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 3:54 PM David Hildenbrand <david@redhat.com> wrote:
>>> -int vma_is_stack_for_current(struct vm_area_struct *vma);
>>> +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>>
>> Should this also be *const ?
> 
> No. These are function protoypes. A "const" on a parameter value
> (pointer address, not pointed-to memory) makes no sense on a
> prototype.

But couldn't you argue the same about variable names? In most (not all 
:) ) we keep declaration + definition in sync. So thus my confusion.

-- 
Cheers

David / dhildenb


