Return-Path: <linux-s390+bounces-1355-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC94E8440C8
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jan 2024 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70427B2BF8E
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jan 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016B80BF9;
	Wed, 31 Jan 2024 13:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXs8VltE"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7FA80BEB
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708296; cv=none; b=erLjH9Tkt3oHtGpigOiK4N57nihcJ9OpvvHTtbGYvlG20Yuw/2HvWLjpwLfT0Cuw17Uwdz9zKINKSumzszP9NMY08Nhr9zI7uRiOSr3/HOVaPmHBFUAAyx1c5LG+6wgDOyz7ToMbgOi3tj93v+onxNG9AQZzmZ/VleL8yK1uwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708296; c=relaxed/simple;
	bh=EP/VOkvRrFbuplhNL+kIPj0fhAj0V0gvW1a0Gsl/Y28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pnc2TvvnIKTfRm1npCiG0fsM+sziHfLj0mwwi9qxz1wlAIlgtByMY+bGjmRWJC3gUTgjV4xNvJEWOjN+os4Goxb5Qckb/cFulpc/r7dWK5xgHVgf+ZL0Izosa5bBmft74MHFMXMo1KcDjwNHKLG/EgB2g2hkt3nTW3xkjPa4Yk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JXs8VltE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706708293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vNnp/Z0S7DqUPASGq4M26R4kayT9Cyd518Jol1/4wN4=;
	b=JXs8VltEDDI38sWcW2ltl865d9+Jd80OQC1ZXQvy8COslFEkJsgp0wtzQWYgDVcelPXK9Q
	O+/DnxUbiRD4x6z1hLvnc/9O/FIulnjUeYFIwuFOHWYhNo58qtSg/stBje48/87FOQ5LOh
	mBjZiypSLtq7yX6nlZWEazCnrBecHVo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-9OxqnRuTNyS_vhl62oGs1A-1; Wed, 31 Jan 2024 08:38:12 -0500
X-MC-Unique: 9OxqnRuTNyS_vhl62oGs1A-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso36813205e9.2
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 05:38:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706708291; x=1707313091;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNnp/Z0S7DqUPASGq4M26R4kayT9Cyd518Jol1/4wN4=;
        b=PjIDW7i870u5nhN8TtY/wF8NVWUIZ25XJ/Brw0yhZ66DxEJ0p5MTWJe8GqIpXYONUX
         y1DCCA0736rPax8xpMTZF52chMl2YGncshLeHOQWsV/+tn/8ss7B0OpG/VD+KXxZWYv/
         RsnDVCl98AmqJbVJvHep5OagYZAjX3AigwutMb/LOetajt4jZLD+5qCkMrCl1PjepgIR
         x0DPALCB4KydT5q3WrOH8hjmhbyySOLG4ZR4RxeEsrtaa3gV9KH+gB3RttFy5H/qqJjw
         0GXRVQ/FyrFKYEk7FyDO9wiALApO62JIBzX5c7lDcCu9XlrPrNqCjj2n1rdC/vkwBWo9
         Awqw==
X-Gm-Message-State: AOJu0YwPz/Nk2ah7aDGnJg7mfvjn9oSCb7yVCSWblUOHbk3/BXA0rev7
	VDjdgQgxBgiVkwfPdNWN3pPwE30asyQWQdyIK6FtSlEJJTvfFwWyzT6TodDFIfo466Z+yx+xN8q
	DvT8QpsqS64J23sbnOs8Jczh8KNoet9JoTDAJQ+xorwav2ruJXgYgmm0HHmM=
X-Received: by 2002:a05:600c:6551:b0:40e:b93e:4a0f with SMTP id dn17-20020a05600c655100b0040eb93e4a0fmr1406564wmb.19.1706708291162;
        Wed, 31 Jan 2024 05:38:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoAHxE3D/zHX4Njds0uFxoI5Tm9039gsOQ1jUjIaqjF15lPY9fb5u6xV8tefJ0lfUgXMicvQ==
X-Received: by 2002:a05:600c:6551:b0:40e:b93e:4a0f with SMTP id dn17-20020a05600c655100b0040eb93e4a0fmr1406543wmb.19.1706708290739;
        Wed, 31 Jan 2024 05:38:10 -0800 (PST)
Received: from [10.32.64.237] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600016c900b0033aedb71269sm8183465wrf.88.2024.01.31.05.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 05:38:10 -0800 (PST)
Message-ID: <c63870b0-690a-4051-b4f5-296cf3b73be2@redhat.com>
Date: Wed, 31 Jan 2024 14:38:09 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/15] mm/memory: optimize fork() with PTE-mapped THP
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Dinh Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org
References: <20240129124649.189745-1-david@redhat.com>
 <a335a9d2-9b8f-4eb8-ba22-23a223b59b06@arm.com>
 <a1a0e9b3-dae2-418f-bd63-50e65f471728@redhat.com>
 <57eb82c7-4816-42a2-b5ab-cc221e289b21@arm.com>
 <e6eaba5b-f290-4d1f-990b-a47d89f56ee4@redhat.com>
 <714d0930-2202-48b6-9728-d248f820325e@arm.com>
 <dcaa20c4-bd1f-4f15-bb0a-3a790808937d@arm.com>
 <30718fc8-15cf-41e4-922c-5cdbf00a0840@redhat.com>
 <de975655-8f8f-40dc-b281-75c40dd1e2c1@arm.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <de975655-8f8f-40dc-b281-75c40dd1e2c1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

>>> Nope: looks the same. I've taken my test harness out of the picture and done
>>> everything manually from the ground up, with the old tests and the new. Headline
>>> is that I see similar numbers from both.
>>
>> I took me a while to get really reproducible numbers on Intel. Most importantly:
>> * Set a fixed CPU frequency, disabling any boost and avoiding any
>>    thermal throttling.
>> * Pin the test to CPUs and set a nice level.
> 
> I'm already pinning the test to cpu 0. But for M2, at least, I'm running in a VM
> on top of macos, and I don't have a mechanism to pin the QEMU threads to the
> physical CPUs. Anyway, I don't think these are problems because for a given
> kernel build I can accurately repro numbers.

Oh, you do have a layer of virtualization in there. I *suspect* that 
might amplify some odd things regarding code layout, caching effects, etc.

I guess especially the fork() benchmark is too sensible (fast) for 
things like that, so I would just focus on bare metal results where you 
can control the environment completely.

Note that regarding NUMA effects, I mean when some memory access within 
the same socket is faster/slower even with only a single node. On AMD 
EPYC that's possible, depending on which core you are running and on 
which memory controller the memory you want to access is located. If 
both are in different quadrants IIUC, the access latency will be different.

>> But yes: I was observing something similar on AMD EPYC, where you get
>> consecutive pages from the buddy, but once you allocate from the PCP it might no
>> longer be consecutive.
>>
>>>    - test is 5-10% slower when output is printed to terminal vs when redirected to
>>>      file. I've always effectively been redirecting. Not sure if this overhead
>>>      could start to dominate the regression and that's why you don't see it?
>>
>> That's weird, because we don't print while measuring? Anyhow, 5/10% variance on
>> some system is not the end of the world.
> 
> I imagine its cache effects? More work to do to print the output could be
> evicting some code that's in the benchmark path?

Maybe. Do you also see these oddities on the bare metal system?

> 
>>
>>>
>>> I'm inclined to run this test for the last N kernel releases and if the number
>>> moves around significantly, conclude that these tests don't really matter.
>>> Otherwise its an exercise in randomly refactoring code until it works well, but
>>> that's just overfitting to the compiler and hw. What do you think?
>>
>> Personally, I wouldn't lose sleep if you see weird, unexplainable behavior on
>> some system (not even architecture!). Trying to optimize for that would indeed
>> be random refactorings.
>>
>> But I would not be so fast to say that "these tests don't really matter" and
>> then go wild and degrade them as much as you want. There are use cases that care
>> about fork performance especially with order-0 pages -- such as Redis.
> 
> Indeed. But also remember that my fork baseline time is ~2.5ms, and I think you
> said yours was 14ms :)

Yes, no idea why M2 is that fast (BTW, which page size? 4k or 16k? ) :)

> 
> I'll continue to mess around with it until the end of the day. But I'm not
> making any headway, then I'll change tack; I'll just measure the performance of
> my contpte changes using your fork/zap stuff as the baseline and post based on that.

You should likely not focus on M2 results. Just pick a representative 
bare metal machine where you get consistent, explainable results.

Nothing in the code is fine-tuned for a particular architecture so far, 
only order-0 handling is kept separate.

BTW: I see the exact same speedups for dontneed that I see for munmap. 
For example, for order-9, it goes from 0.023412s -> 0.009785, so -58%. 
So I'm curious why you see a speedup for munmap but not for dontneed.

-- 
Cheers,

David / dhildenb


