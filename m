Return-Path: <linux-s390+bounces-6828-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E0E9B6976
	for <lists+linux-s390@lfdr.de>; Wed, 30 Oct 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156271F21010
	for <lists+linux-s390@lfdr.de>; Wed, 30 Oct 2024 16:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21421E573B;
	Wed, 30 Oct 2024 16:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hicAZC5g"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA95768FC
	for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2024 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306740; cv=none; b=MPjC+dzIUdyPO5onZCwS4njAawLEQB0xRP0nJxKbUEsgsVwlpvFjuZqsIJZO1npPirboMpQFM/9rZtQtdYcleINVC/szT6ZgC9N/F57c8ax8oFQRGD5XZiTi7VKFjoA32u6T6geCXZN2H6TlXRacx0goVuFY/5LLKaIk5nAsOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306740; c=relaxed/simple;
	bh=m8OthHp3SAjiv0zKnDxglY8U4vs0DCMY/HHcyfT9uTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ooPfJaBoB6S7OJRmr9ZMi6qMdzTmOM66s2OxTQWLxNlYALJog9242LQhh7jiF3dvJ7IV6Bp7mnmwoQC8b6wDpJhqXZvxZuyGBpO0VZW+va68/PS/Meva8beIPOWoruWr+myxLDGEIiNPWqcCFAVYOF6U1Z1DQ/dDxcbq47iO2O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hicAZC5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730306737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2prj1vBARz2TRWE6oRBlqTY8pIpwqPBns44dk5+Rnd4=;
	b=hicAZC5gdUVr9UfNi8RMI5MfoehG6FIJzgm2hec5YGFBk7lueCv1b1v7p8wFgBDghnCPKB
	5fQXVWHQr0b17q9Qh7vP49uzAPCGTHVmqVixoieWLinazIwQFv7xvLXZjPycMTiEUzU8g1
	SQr83DamAnUtiwqajCC/tetb9DJUWG8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-8hDSRuqLN0uTLYK9yUk6qQ-1; Wed, 30 Oct 2024 12:43:58 -0400
X-MC-Unique: 8hDSRuqLN0uTLYK9yUk6qQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4314f1e0f2bso132415e9.1
        for <linux-s390@vger.kernel.org>; Wed, 30 Oct 2024 09:43:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306637; x=1730911437;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2prj1vBARz2TRWE6oRBlqTY8pIpwqPBns44dk5+Rnd4=;
        b=L8HtEqwqKqViF4OIeaRi7cA623Zm8lAZP2kvh0uNZw+uAZSCNErxm1mLzau11nYKlM
         RIGdCQcIJzG0pVzUWyNl1LvmLY/SY9DZ9npfSAR7s7aMuc2weNbbTupCSmn+UUDG8wLD
         EAzkM/b1PSF1PauSAk0tiUqGmfuEwhLltQqutCuvzbWXu/IWIcwnfEtpkNyVbru/GiiQ
         hhtonnRoi1fJq30AZpr1SPa+ZwX2AlkdrR7/YeIWUflc5E7AUoKLSLARWmxgcsQvuyUV
         HJAEFSvVbiwL/JwlvQVaAgzVpFD3Wbw2uk9IoLOe4/ARQ2LEyzbCxWunEzP4BGsGCgXu
         qLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqpmyCTYq9hznrGnm6IIhsfdUaz/ppDD+A2MovYFVfhVqlKUnftQlyQduM58GHGHez8hko74TXuOwE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2dR4A5+DIp8/P3uPNm1ajPYP8EIDSVVtbSd0y5jUSXr1SAos
	33fr+6jIkZmUIalWzXxHreUrttNZRnMLXpffjtR3m/0Pn0xfj/ocAAjfKg+ns0BVj00EbJ8BKgL
	JaF51lcF5d5IeOXOBjas7oHGvBxE+ncwEoxjGeK72wDRpUCUYc0jOLPOKbOw=
X-Received: by 2002:a5d:6082:0:b0:37d:4937:c9eb with SMTP id ffacd0b85a97d-3806113de46mr11924113f8f.21.1730306637500;
        Wed, 30 Oct 2024 09:43:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMaXZ4qwwVX8gPGZNbj4VQFicDJ4FE9uDfYitKw51Mvh8VbNoR2SY8GR2Eucf8hZZ4r+X1w==
X-Received: by 2002:a5d:6082:0:b0:37d:4937:c9eb with SMTP id ffacd0b85a97d-3806113de46mr11924097f8f.21.1730306637117;
        Wed, 30 Oct 2024 09:43:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b712cbsm15866975f8f.77.2024.10.30.09.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:43:56 -0700 (PDT)
Message-ID: <e97e01dc-7db6-4d14-b5e6-40fb306489ce@redhat.com>
Date: Wed, 30 Oct 2024 17:43:55 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] s390/physmem_info: query diag500(STORAGE LIMIT) to
 support QEMU/KVM memory devices
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>,
 Mario Casquero <mcasquer@redhat.com>
References: <20241025141453.1210600-1-david@redhat.com>
 <20241025141453.1210600-4-david@redhat.com>
 <ZyJDelNH7bvo/TnO@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyJDelNH7bvo/TnO@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 15:32, Alexander Gordeev wrote:
> On Fri, Oct 25, 2024 at 04:14:48PM +0200, David Hildenbrand wrote:
>> To support memory devices under QEMU/KVM, such as virtio-mem,
>> we have to prepare our kernel virtual address space accordingly and
>> have to know the highest possible physical memory address we might see
>> later: the storage limit. The good old SCLP interface is not suitable for
>> this use case.
>>
>> In particular, memory owned by memory devices has no relationship to
>> storage increments, it is always detected using the device driver, and
>> unaware OSes (no driver) must never try making use of that memory.
>> Consequently this memory is located outside of the "maximum storage
>> increment"-indicated memory range.
>>
>> Let's use our new diag500 STORAGE_LIMIT subcode to query this storage
>> limit that can exceed the "maximum storage increment", and use the
>> existing interfaces (i.e., SCLP) to obtain information about the initial
>> memory that is not owned+managed by memory devices.
>>
>> If a hypervisor does not support such memory devices, the address exposed
>> through diag500 STORAGE_LIMIT will correspond to the maximum storage
>> increment exposed through SCLP.
>>
>> To teach kdump on s390 to include memory owned by memory devices, there
>> will be ways to query the relevant memory ranges from the device via a
>> driver running in special kdump mode (like virtio-mem already implements
>> to filter /proc/vmcore access so we don't end up reading from unplugged
>> device blocks).
>>
>> Update setup_ident_map_size(), to clarify that there can be more than
>> just online and standby memory.
>>
>> Tested-by: Mario Casquero <mcasquer@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   arch/s390/boot/physmem_info.c        | 47 +++++++++++++++++++++++++++-
>>   arch/s390/boot/startup.c             |  7 +++--
>>   arch/s390/include/asm/physmem_info.h |  3 ++
>>   3 files changed, 54 insertions(+), 3 deletions(-)
> 
> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 

Thanks Alexander!

-- 
Cheers,

David / dhildenb


