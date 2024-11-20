Return-Path: <linux-s390+bounces-7215-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DBA9D38B0
	for <lists+linux-s390@lfdr.de>; Wed, 20 Nov 2024 11:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 756CBB23AB0
	for <lists+linux-s390@lfdr.de>; Wed, 20 Nov 2024 10:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E16B19E7E2;
	Wed, 20 Nov 2024 10:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsucGR9R"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12119C56C
	for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099733; cv=none; b=fc1tIh4QAIN4xUImnKkWvBLOpxn2WJkbROCEQerqRdolxei9JRpdTJ05XizkXfPaElMfubD/3YySFzhGNzhPPuhnKMTAK8wO/Z7TvQBT1PUOPaIYYQUZ4yl31MtSy9ejfI8SrmCGIPcisHE7qYeeA0XAwlieEramULo6BhsLG4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099733; c=relaxed/simple;
	bh=XC8Mm92Ij6nVgJE1Djy3NtQ0fZS7oZmrFjKmK4b17TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbN70x1qFAzM8zMu35I64UInOvjBLHSdrcwlJ0zV1CJBpmTBwulW4uRjKFYj2vIEZwjicMAgZ/uzAHyTOlGOkICZgklyKxC/RXJolpoRcU4xnxeybL61AGb2Mqa6blPsDBSflOkGBD2F4jyKcsXpYt64DQVHbd7vYyFFC5qGvQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsucGR9R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732099730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TYJiOMspK7IsPxdhCdCDQF9p6uoKVIA0MyWnICkfAEs=;
	b=MsucGR9RwDnFXUUOMPzbo07WFZqUJhBILV3CtDp8kIz7bQN+NKtbKO0UDWrmHGDgtjcQVq
	EnrdjEBYT6uG2QQZhfa9Y6BbvT3eUEL4NGqZaScHsilq1/Re3hHw4tmu0rB2Pu0mR4z1EK
	eWKoDsS57ZfLJ4omBHun/smhBcNe7uE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-fz2NONdZP1qz7SV7OY_4iw-1; Wed, 20 Nov 2024 05:48:47 -0500
X-MC-Unique: fz2NONdZP1qz7SV7OY_4iw-1
X-Mimecast-MFC-AGG-ID: fz2NONdZP1qz7SV7OY_4iw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4316e2dde9eso39898145e9.2
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2024 02:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732099726; x=1732704526;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TYJiOMspK7IsPxdhCdCDQF9p6uoKVIA0MyWnICkfAEs=;
        b=WvE+eLKbcWH++3kxpBec1CqIemwVbN9kNjtUP+54prfalbw2WYeQzs8d22SyK4fIiC
         q4q3blePLyPOwrJ4DtZ1rLYL6SK9R95oQfyl7xhhR4+gMkwOdkf/4jmmIa21PKSn6fcP
         r8DrtJNzFQSGONxLQEe10M94QXOPWFCPWqgC8W1xEoHENkuqRmDxj+zKpgYH1Qf89b/V
         TloLkilsTWoDtjfIA8uR4N7huFkvcT6WDwN6n2Smj8tlZUOMR5SZ1jnVp0SQCZaIOTzl
         8QPS+666v8h35/LH5negDRC8R7rO8Krt3HY7O8wkudbED73wnEy6u2HG3YhsOWpOoG8V
         r0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0FSdTHCh0RQ2h88BzvsPfbVajZRQFVnOjBrIpiXEueNMNeaUhQLxx5x3oG2afK/iTHqeHP4LlZ3Nu@vger.kernel.org
X-Gm-Message-State: AOJu0YxuU5bPfE+Fvo9MvIsaihAs4Z3UsMBeZ5DM5p/8e4TufKbJqc5a
	Q85Q6Y9UFKH3+N3euKf313KMS9YsNUTVGFemqEY2ooZOrLG1YMG2ohF+c+ShZUUfgrKCnJ4IevK
	oWQB9gtqdb8GGaCDZDPiNWmBG3xb/Ubcxo6/iWeYUHgN2phtWjKklGXQblow=
X-Received: by 2002:a05:600c:4ed2:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43348903e9dmr25118895e9.0.1732099726068;
        Wed, 20 Nov 2024 02:48:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5ri0Ctyn0tsKk21xv1/ls13TeHxIMZx0VuvaIyqn9RF2BrSvePdGve47YAO822hbBk4iZ7Q==
X-Received: by 2002:a05:600c:4ed2:b0:431:52a3:d9d5 with SMTP id 5b1f17b1804b1-43348903e9dmr25118425e9.0.1732099725605;
        Wed, 20 Nov 2024 02:48:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4200:ce79:acf6:d832:60df? (p200300cbc7054200ce79acf6d83260df.dip0.t-ipconnect.de. [2003:cb:c705:4200:ce79:acf6:d832:60df])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45fa728sm14606045e9.14.2024.11.20.02.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 02:48:44 -0800 (PST)
Message-ID: <4b07a3eb-aad6-4436-9591-289c6504bb92@redhat.com>
Date: Wed, 20 Nov 2024 11:48:42 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/11] fs/proc/vmcore: introduce PROC_VMCORE_DEVICE_RAM
 to detect device RAM ranges in 2nd kernel
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kexec@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Farman
 <farman@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
References: <20241025151134.1275575-1-david@redhat.com>
 <20241025151134.1275575-8-david@redhat.com> <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zz22ZidsMqkafYeg@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.11.24 11:13, Baoquan He wrote:
> On 10/25/24 at 05:11pm, David Hildenbrand wrote:
>> s390 allocates+prepares the elfcore hdr in the dump (2nd) kernel, not in
>> the crashed kernel.
>>
>> RAM provided by memory devices such as virtio-mem can only be detected
>> using the device driver; when vmcore_init() is called, these device
>> drivers are usually not loaded yet, or the devices did not get probed
>> yet. Consequently, on s390 these RAM ranges will not be included in
>> the crash dump, which makes the dump partially corrupt and is
>> unfortunate.
>>
>> Instead of deferring the vmcore_init() call, to an (unclear?) later point,
>> let's reuse the vmcore_cb infrastructure to obtain device RAM ranges as
>> the device drivers probe the device and get access to this information.
>>
>> Then, we'll add these ranges to the vmcore, adding more PT_LOAD
>> entries and updating the offsets+vmcore size.
>>
>> Use Kconfig tricks to include this code automatically only if (a) there is
>> a device driver compiled that implements the callback
>> (PROVIDE_PROC_VMCORE_DEVICE_RAM) and; (b) the architecture actually needs
>> this information (NEED_PROC_VMCORE_DEVICE_RAM).
>>
>> The current target use case is s390, which only creates an elf64
>> elfcore, so focusing on elf64 is sufficient.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   fs/proc/Kconfig            |  25 ++++++
>>   fs/proc/vmcore.c           | 156 +++++++++++++++++++++++++++++++++++++
>>   include/linux/crash_dump.h |   9 +++
>>   3 files changed, 190 insertions(+)
>>
>> diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
>> index d80a1431ef7b..1e11de5f9380 100644
>> --- a/fs/proc/Kconfig
>> +++ b/fs/proc/Kconfig
>> @@ -61,6 +61,31 @@ config PROC_VMCORE_DEVICE_DUMP
>>   	  as ELF notes to /proc/vmcore. You can still disable device
>>   	  dump using the kernel command line option 'novmcoredd'.
>>   
>> +config PROVIDE_PROC_VMCORE_DEVICE_RAM
>> +	def_bool n
>> +
>> +config NEED_PROC_VMCORE_DEVICE_RAM
>> +	def_bool n
>> +
>> +config PROC_VMCORE_DEVICE_RAM
>> +	def_bool y
>> +	depends on PROC_VMCORE
>> +	depends on NEED_PROC_VMCORE_DEVICE_RAM
>> +	depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> Kconfig item is always a thing I need learn to master.

Yes, it's usually a struggle to get it right. It took me a couple of 
iterations to get to this point :)

> When I checked
> this part, I have to write them down to deliberate. I am wondering if
> below 'simple version' works too and more understandable. Please help
> point out what I have missed.
> 
> ===========simple version======
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE && VIRTIO_MEM
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
> 
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM
 > ============

So the three changes you did are

(a) Remove the config option but select/depend on them.

(b) Remove the "depends on PROC_VMCORE" from PROC_VMCORE_DEVICE_RAM,
     and the "if PROC_VMCORE" from s390.

(c) Remove the PROVIDE_PROC_VMCORE_DEVICE_RAM


Regarding (a), that doesn't work. If you select a config option that 
doesn't exist, it is silently dropped. It's always treated as if it 
wouldn't be set.

Regarding (b), I think that's an anti-pattern (having config options 
enabled that are completely ineffective) and I don't see a benefit 
dropping them.

Regarding (c), it would mean that s390x unconditionally includes that 
code even if virtio-mem is not configured in.

So while we could drop PROVIDE_PROC_VMCORE_DEVICE_RAM -- (c), it would 
that we end up including code in configurations that don't possibly need 
it. That's why I included that part.

> 
> 
> ======= config items extracted from this patchset====
> config PROVIDE_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config NEED_PROC_VMCORE_DEVICE_RAM
>          def_bool n
> 
> config PROC_VMCORE_DEVICE_RAM
>          def_bool y
>          depends on PROC_VMCORE
>          depends on NEED_PROC_VMCORE_DEVICE_RAM
>          depends on PROVIDE_PROC_VMCORE_DEVICE_RAM
> 
> config VIRTIO_MEM
> 	depends on X86_64 || ARM64 || RISCV
>           ~~~~~ I don't get why VIRTIO_MEM dones't depend on S390 if
>                 s390 need PROC_VMCORE_DEVICE_RAM.

This series depends on s390 support for virtio-mem, which just went 
upstream.

See

commit 38968bcdcc1d46f2fdcd3a72599d5193bf8baf84
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Oct 25 16:14:49 2024 +0200

     virtio-mem: s390 support


>          ......
>          select PROVIDE_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> 
> config S390
>          select NEED_PROC_VMCORE_DEVICE_RAM if PROC_VMCORE
> =================================================
> 

Thanks for having a look!

-- 
Cheers,

David / dhildenb


