Return-Path: <linux-s390+bounces-6913-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A509BB482
	for <lists+linux-s390@lfdr.de>; Mon,  4 Nov 2024 13:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2611F21F29
	for <lists+linux-s390@lfdr.de>; Mon,  4 Nov 2024 12:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277C81B6D12;
	Mon,  4 Nov 2024 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUov7vpC"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655E61B6CEA
	for <linux-s390@vger.kernel.org>; Mon,  4 Nov 2024 12:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730722739; cv=none; b=pvk+qtXdHD5w1QSWuswmHdvJLM1OtZ1UfPjH2LlG8PLZ1KoQYIvWUDTi3N6TmXNEiDpUEEjLpSZ0vBfJM+U9y45pC8TMl/jrGIyOqhaF6VnuSb/b5vGmCMZBEYvmEaa7DW0tOdM0HOH1zJkPUq3G7e0NLyRvw0yjQsXOzep9/d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730722739; c=relaxed/simple;
	bh=mATfRnv3WaO/g2+GM7NFqpYOfENuJYPDfVgLx2OkuAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fL/WWsWl4SAlr/XmNoMRGJNBOPqyOj7RtBHCMLSxhH7z8l7xjyB1AsBMAz5XmAxZla1/boPk5pFOpBQMXe6Sny7KJ83tpH1jpjvCSI9+gyPTsgWTWp91FVbuxhYVy3bGXbFtOE07jKcRIApay5wRPGF5RW29vYk6U+v8968geRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUov7vpC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730722736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ekj68x/5561NfPpq6VBhFf4fvoAXBdLk2oVjJQdOwyc=;
	b=jUov7vpCQtK2+lqTNC9MByvAwwuPWQIZHX7xSsuJpl07/vgGHKlMawZXDLslZXmUIfDHxw
	ORnaH6NvqdI9/L0qy8oGVvT7XMnKR7xJPpfO1o8MqqQidfsG+pCLTrUzQeyZ3BuAhvU8H2
	J0u/uKwMJIsDX6I/vc7vLaWu1+fOvsw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-87bfDY0wPHGNNhABn7pPdQ-1; Mon, 04 Nov 2024 07:18:55 -0500
X-MC-Unique: 87bfDY0wPHGNNhABn7pPdQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so2322493f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2024 04:18:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730722734; x=1731327534;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ekj68x/5561NfPpq6VBhFf4fvoAXBdLk2oVjJQdOwyc=;
        b=hTXXsooIDwhQzSCgGSUvhdztLyKLBYxnZHn4BmM8ziLkQZ22WWh8rKL8/OL0X0WmPQ
         VzIuHu3Ht5dmx/fKVr0B7hw5U2f6Qf2yYpsvcnt/r3LRyAVfBdpai2jY8by9OE8w4Jby
         hVCo2fQ4qsYxlEbFy9CDKX9BRXrhJ5HvWb0wdUQgUDrodbBgEkRxlgpVZsYuFIe+CttG
         jcqY7yarlQ3NaKUcDa4WOHQ+CmczrQ+w7wcMYRKRzNidXQo/I1ofFkTksCsLfNMPcZ55
         hPt7sjQ5tXl4f5YxVDF3EW0TbDoWt1HQp45AMGzJtNwqAORQ+uctwZQU+e7/GrVq8H39
         5SPA==
X-Forwarded-Encrypted: i=1; AJvYcCWFkqE1e+qvVJGq96BAmNLoRnVTSP1T9/iBPx/AY18W6FISO4kUWaJ14fnBEgby0Tm9EjAVB++paCKG@vger.kernel.org
X-Gm-Message-State: AOJu0YzGf7HLpaUB8qb5367jnbtCHH5a52oZNQY5voCW0jwF72YVcXbj
	h2LASLs08VPzZtNXpVDtxUOyM4dd0aAyvupMp2XmzZornxclyMOStksuGSDiNRcBhB1Pf5Y2A9V
	v313KtNK8iKMUPPwntY7iUTNNP4Jzdpj/f4WhyRdlt+XTbrigY7uhVAFwMus=
X-Received: by 2002:a5d:64c7:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-381be7c6d38mr12976243f8f.14.1730722734161;
        Mon, 04 Nov 2024 04:18:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFks1Vg1EGJ6kG/ABNcRU757iJju9STT8kBWmpSO5OP6IyVzEWTv0ofagBRVbHOOPCmUXAkvA==
X-Received: by 2002:a5d:64c7:0:b0:37d:4cd6:6f2b with SMTP id ffacd0b85a97d-381be7c6d38mr12976219f8f.14.1730722733722;
        Mon, 04 Nov 2024 04:18:53 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm13084440f8f.49.2024.11.04.04.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:18:53 -0800 (PST)
Message-ID: <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
Date: Mon, 4 Nov 2024 13:18:51 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, ackerleytng@google.com, vannapurve@google.com,
 rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31.10.24 11:42, Patrick Roy wrote:
> On Thu, 2024-10-31 at 09:50 +0000, David Hildenbrand wrote:
>> On 30.10.24 14:49, Patrick Roy wrote:
>>> Unmapping virtual machine guest memory from the host kernel's direct map
>>> is a successful mitigation against Spectre-style transient execution
>>> issues: If the kernel page tables do not contain entries pointing to
>>> guest memory, then any attempted speculative read through the direct map
>>> will necessarily be blocked by the MMU before any observable
>>> microarchitectural side-effects happen. This means that Spectre-gadgets
>>> and similar cannot be used to target virtual machine memory. Roughly 60%
>>> of speculative execution issues fall into this category [1, Table 1].
>>>
>>> This patch series extends guest_memfd with the ability to remove its
>>> memory from the host kernel's direct map, to be able to attain the above
>>> protection for KVM guests running inside guest_memfd.
>>>
>>> === Changes to v2 ===
>>>
>>> - Handle direct map removal for physically contiguous pages in arch code
>>>     (Mike R.)
>>> - Track the direct map state in guest_memfd itself instead of at the
>>>     folio level, to prepare for huge pages support (Sean C.)
>>> - Allow configuring direct map state of not-yet faulted in memory
>>>     (Vishal A.)
>>> - Pay attention to alignment in ftrace structs (Steven R.)
>>>
>>> Most significantly, I've reduced the patch series to focus only on
>>> direct map removal for guest_memfd for now, leaving the whole "how to do
>>> non-CoCo VMs in guest_memfd" for later. If this separation is
>>> acceptable, then I think I can drop the RFC tag in the next revision
>>> (I've mainly kept it here because I'm not entirely sure what to do with
>>> patches 3 and 4).
>>
>> Hi,
>>
>> keeping upcoming "shared and private memory in guest_memfd" in mind, I
>> assume the focus would be to only remove the direct map for private memory?
>>
>> So in the current upstream state, you would only be removing the direct
>> map for private memory, currently translating to "encrypted"/"protected"
>> memory that is inaccessible either way already.
>>
>> Correct?
> 
> Yea, with the upcomming "shared and private" stuff, I would expect the
> the shared<->private conversions would call the routines from patch 3 to
> restore direct map entries on private->shared, and zap them on
> shared->private.

I wanted to follow-up to the discussion we had in the bi-weekly call.

We talked about shared (faultable) vs. private (unfaultable), and how it 
would interact with the directmap patches here.

As discussed, having private (unfaultable) memory with the direct-map 
removed and shared (faultable) memory with the direct-mapping can make 
sense for non-TDX/AMD-SEV/... non-CoCo use cases. Not sure about CoCo, 
the discussion here seems to indicate that it might currently not be 
required.

So one thing we could do is that shared (faultable) will have a direct 
mapping and be gup-able and private (unfaultable) memory will not have a 
direct mapping and is, by design, not gup-able.

Maybe it could make sense to not have a direct map for all guest_memfd 
memory, making it behave like secretmem (and it would be easy to 
implement)? But I'm not sure if that is really desirable in VM context.

Having a mixture of "has directmap" and "has no directmap" for shared 
(faultable) memory should not be done. Similarly, private memory really 
should stay "unfaultable".

I think one of the points raised during the bi-weekly call was that 
using a viommu/swiotlb might be the right call, such that all memory can 
be considered private (unfaultable) that is not explicitly 
shared/expected to be modified by the hypervisor (-> faultable, -> 
GUP-able).

Further, I think Sean had some good points why we should explore that 
direction, but I recall that there were some issue to be sorted out 
(interpreted instructions requiring direct map when accessing "private" 
memory?), not sure if that is already working/can be made working in KVM.

What's your opinion after the call and the next step for use cases like 
you have in mind (IIRC firecracker, which wants to not have the 
direct-map for guest memory where it can be avoided)?

-- 
Cheers,

David / dhildenb


