Return-Path: <linux-s390+bounces-3383-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C53808A6CAC
	for <lists+linux-s390@lfdr.de>; Tue, 16 Apr 2024 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B09BB224A2
	for <lists+linux-s390@lfdr.de>; Tue, 16 Apr 2024 13:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C8B12C54D;
	Tue, 16 Apr 2024 13:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP1zk27Y"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B7412C481
	for <linux-s390@vger.kernel.org>; Tue, 16 Apr 2024 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713274890; cv=none; b=kgFbqQgacUZ7ktZ6LWY0Dl7HcJTD8o2X52qXGNCtKQxFZVS6Usr5md6LcoCcoorxpt4hT7jmRBy3RiP7DzHoRG9L8Z+Jf59UElQokG3SKnGy1oaPu+E0i9yNV65C6fjcw3dyAQ6yEgJmLT41l1e9H7SDHwuOZx0HoVMQBaA9h+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713274890; c=relaxed/simple;
	bh=MDdFbylWi7jLUhulOnyfKThGCIZGH6oC/xjbX1Jyk+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwgfZN6fPLUdxWU6nXL7ushp/Sp8/DOJvXQFcr7gRPpo8L43XlAhls8A17aej8gytjGKRbz5Ovs4fIIMuK6hxRj14ZWwm2x+gowd7bC2h9NAmI+RYJ8RuiTdmZUeE9icR3K4pW4gCBXHuvgmZEBr/Q8R8bQnSSlapdbNaKK9v0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP1zk27Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713274888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Dr11CEnQo6o/6WX8/bz57IHiwW8Fb6G/zTIFdQaHNpo=;
	b=VP1zk27YAwtJM2dXmXHBeLxEaBa0xkhTRHa8cSEq+zopO3krM1nsyngqJVZDo9jDFY387f
	hVmtxa2HZDkGvOvqO0+WOrPSaT2wcV60kGG1cV7ZXPD0mFkAcDnVuCQmPykfL6Bixt1CPQ
	Si3rnLP+12Sx40y2e5i2hgkFxwOtPgg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-5QeJuLkmP1KTsHQ_S4M4fg-1; Tue, 16 Apr 2024 09:41:24 -0400
X-MC-Unique: 5QeJuLkmP1KTsHQ_S4M4fg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-343e775c794so2695696f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 16 Apr 2024 06:41:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713274883; x=1713879683;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Dr11CEnQo6o/6WX8/bz57IHiwW8Fb6G/zTIFdQaHNpo=;
        b=Xadh2f0iWlECseBtcySD/Tnc1N6FyzHO2rANPmILV8aOiiMf7AiB4OSpsF3Kvlcngs
         k5UzeszI7ziFTndyNYL3LBKdqTEvf7fM87qQdkYJ2rwmvAmlqtFeepsUecFg/RwHMWbV
         2ncJJmfyP40fhGz1MUznbWZf3r6aSiITQmrbsntoiF/eN/Em6qnZ3qjGqBM/U2KpAruF
         Np0vIrGyUVyvAHtj6MvKCq376r6eIss7UGQW52m18barap4DW0wvmspISdJpdExEAqS0
         nZPn8KHrgppyueXzKd92tJl6vdcWdBeaEB59QnFYD5gAn3It4TbpHzN8EYAIHi8YaYEM
         lI5A==
X-Forwarded-Encrypted: i=1; AJvYcCVgawR67K/RnPp+GFjRppzgDou+GoJbWEgudoY6KyGAafdP1abrnAanGULLgwfkbEmx51C9pd28t+IQVUKchnCt0qbJYWlw+T1n7g==
X-Gm-Message-State: AOJu0YxPL7UotPqQK2wT2HQdDsHR4s0K3vxKiz0M4InKeXiRBIo2GKA/
	gwoM5VbpaaB/Fa6+N+GOmzbSEJRiJkhqPPQl05zgIsuCW59c/EYrvQASPMwZ7dXm/T4htuVFx+V
	/ZPWuY2+q/LEs+6VEbcjCws0TqOSs4zPPHcGMONFBRIdOIXrv8Yz9knm0Vfc=
X-Received: by 2002:a05:6000:402c:b0:346:1ab6:dbd5 with SMTP id cp44-20020a056000402c00b003461ab6dbd5mr11590280wrb.20.1713274883582;
        Tue, 16 Apr 2024 06:41:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0jglEtIQZrQU4VrAnm9UUOQbxIDrqeVHpWbaKbj+NgBBw4aE4d2eyNf/fl5AEwN4YQPjSIg==
X-Received: by 2002:a05:6000:402c:b0:346:1ab6:dbd5 with SMTP id cp44-20020a056000402c00b003461ab6dbd5mr11590249wrb.20.1713274883090;
        Tue, 16 Apr 2024 06:41:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c718:6400:7621:b88a:e99e:2fa8? (p200300cbc71864007621b88ae99e2fa8.dip0.t-ipconnect.de. [2003:cb:c718:6400:7621:b88a:e99e:2fa8])
        by smtp.gmail.com with ESMTPSA id m4-20020adff384000000b0033e7de97214sm14871567wro.40.2024.04.16.06.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 06:41:22 -0700 (PDT)
Message-ID: <a6a4b284-e21b-4a04-88d1-7402eb5a08ef@redhat.com>
Date: Tue, 16 Apr 2024 15:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] s390/mm: re-enable the shared zeropage for !PV and
 !skeys KVM guests
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20240411161441.910170-1-david@redhat.com>
 <20240411161441.910170-3-david@redhat.com>
 <Zh1w1QTNSy+rrCH7@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <8533cb18-42ff-42bc-b9e5-b0537aa51b21@redhat.com>
 <Zh4cqZkuPR9V1t1o@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20d1d8c5-70e9-4b00-965b-918f275cfae7@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20d1d8c5-70e9-4b00-965b-918f275cfae7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.04.24 14:02, Christian Borntraeger wrote:
> 
> 
> Am 16.04.24 um 08:37 schrieb Alexander Gordeev:
> 
>>> We could piggy-back on vm_fault_to_errno(). We could use
>>> vm_fault_to_errno(rc, FOLL_HWPOISON), and only continue (retry) if the rc is 0 or
>>> -EFAULT, otherwise fail with the returned error.
>>>
>>> But I'd do that as a follow up, and also use it in break_ksm() in the same fashion.
>>
>> @Christian, do you agree with this suggestion?
> 
> I would need to look into that more closely to give a proper answer. In general I am ok
> with this but I prefer to have more eyes on that.
>   From what I can tell we should cover all the normal cases with our CI as soon as it hits
> next. But maybe we should try to create/change a selftest to trigger these error cases?

If we find a shared zeropage we expect the next unsharing fault to 
succeed except:

(1) OOM, in which case we translate to -ENOMEM.

(2) Some obscure race with MADV_DONTNEED paired with concurrent 
truncate(), in which case we get an error, but if we look again, we will 
find the shared zeropage no longer mapped. (this is what break_ksm() 
describes)

(3) MCE while copying the page, which doesn't quite apply here.

For the time being, we only get shared zeropages in (a) anon mappings 
(b) MAP_PRIVATE shmem mappings via UFFDIO_ZEROPAGE. So (2) is hard or 
even impossible to trigger. (1) is hard to test as well, and (3) ...

No easy way to extend selftests that I can see.

If we repeatedly find a shared zeropage in a COW mapping and get an 
error from the unsharing fault, something else would be deeply flawed. 
So I'm not really worried about that, but I agree that having a more 
centralized check will make sense.

-- 
Cheers,

David / dhildenb


