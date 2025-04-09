Return-Path: <linux-s390+bounces-9891-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 706E8A824AD
	for <lists+linux-s390@lfdr.de>; Wed,  9 Apr 2025 14:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222B11BC20BE
	for <lists+linux-s390@lfdr.de>; Wed,  9 Apr 2025 12:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54764262D38;
	Wed,  9 Apr 2025 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyd5n5em"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853BC25E80B
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 12:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201480; cv=none; b=YQX3CJWO/kasr+gy5mNSuwcwKUwiZiTTVod92kCWZKWinpvAMdKKl+aZR3ESJX+b8qyn9ufQ9wVab88PXsEkIZKimHXUk4kHW2ae7NYCBpEofAA+fcPwdyU7k6XzVfWB8TL+pLyCKJ6ADFzYdPxqhirXOsqNMRfJx7RpAnEIQBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201480; c=relaxed/simple;
	bh=50fY5CqvbIXRuOQjF6sVR9Vhlh7zPPI5xAkTQE68g/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmtJbAJKKlYQ3KHhiQdsNliEEcjkAeaKctfmXTDTL2VTDIb71t3RkN39JxIc7ZQ+bay7Ovuu9m5NEXai8HRsAm33hZi4i2tZLngh4Qmyd7fP9+cREm+MDD+QiJp0vBXilv56bXs7VuLvYVqikgZ2i46dDfJ6MtvciEnuy8j4x1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyd5n5em; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744201477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BB0co1XQSYhwpSvOjb23lF2MGsgWfCMGL+h6GKHJnpU=;
	b=hyd5n5em0A6Ws+1U4tGwWEMIFi21SedmqhhuZ3zBHGe80/OXK1xPKVcb2fDYCY9nF1YahU
	yyGDDbFh3QhWTjHHlgTDRM5H6yjkQlFWCM38VopPXTNNpffDcH6l4SNqOU7uuuo+EZqO92
	UT6ojwS3NNCrYn7v9pBuwn3a2fYxtUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-lAJaUDTgPaGv1cSQFDzPog-1; Wed, 09 Apr 2025 08:24:36 -0400
X-MC-Unique: lAJaUDTgPaGv1cSQFDzPog-1
X-Mimecast-MFC-AGG-ID: lAJaUDTgPaGv1cSQFDzPog_1744201475
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d08915f61so39110455e9.2
        for <linux-s390@vger.kernel.org>; Wed, 09 Apr 2025 05:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744201475; x=1744806275;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BB0co1XQSYhwpSvOjb23lF2MGsgWfCMGL+h6GKHJnpU=;
        b=rk0L239UVqR5uJAs1lhkhHVCv9ksgiKHhxgFVNm6n59UWR/fFfPAIaTK9TdQB45JPQ
         nYnfk1iWtWWHc8JtCA5mmslfxNzIjdu/fWaofAGqk36fsfgRTLUwMcVQnoQ9YiTteS3j
         HLTdOh/1aIU8v1OEEugkbfDnGrfnfN0c04xySEBMsDo5et7ot+0wEhUrfken+bDvuNtC
         vPF7GCxT/8hEDszA2a5VSh7xdoH/VitXPwpbGe4QN7OkciNwlmaUw6E7XHhpPfULyOTz
         8+R2rAZs5dz0LisW1rbBEOgB5YX8Ick0KXYTflyAFUH2jTJSFoUC6aKoRjj9XLZqDa0z
         KWpA==
X-Forwarded-Encrypted: i=1; AJvYcCUqxamOYR0JODgmEHFsmCwXxoLby/xb/i9dJfYyeLqNsN7e7OHxt2dCGq0lTNPCTb5LHA5PiaiyEra7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyujh4RatA83PoyQQiinMU4c+UjXTPeh+ey3EMgUT4Axn/EiTdo
	C2NSnT13uiaVyYNXTRua6pbOKDB/4tSKxExn7W7UErE/uvd6bB+nMnGZpX1kSCVbUklXsHO/8kS
	34EtvJg/UD8Y1qMDQsC81LZdDE5Z/6Mb7Er19f0l81JCTkn2RuhF0LSeO5UU=
X-Gm-Gg: ASbGnctS+l0Ta5wPDStvZ+HS2eNctGHkKXeNsNTviJ5Dzqv27SXpI0xacn5A7Q4zmwf
	3+71c/yAaPPkcq0NWGTYDUL9wdUEVxk90i6WcB7sdyDl4yTnIrp8Z362OwOEUWaxIqjQdYbc9k/
	4UFwlPxvkB2oWXS3US2M/3gmybLrGLwSZH5TRURV59vCeuZUMUWjVg+Z2ONoCf45yfLJr/nF44y
	DgjuNiGNddeaG3U1XlWm0u4pnyFOtsa/B1yLHbiVnULY8j+QBhtosBF4/pB+7bMDoQWxn03m2jy
	qYEYnay5UTfEpMwhZ92PKpKr7jnFLRq7aaUy/DF6xQ==
X-Received: by 2002:a05:600c:3c9f:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-43f1ed4bc36mr23576395e9.26.1744201474917;
        Wed, 09 Apr 2025 05:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2pJ0AXoGi87tl94rBYvAXq1MU8VYDVKHvStf7fiGqkSwDqMeylbppcsKE9zj5NgoInD/2Q==
X-Received: by 2002:a05:600c:3c9f:b0:43d:17f1:2640 with SMTP id 5b1f17b1804b1-43f1ed4bc36mr23576175e9.26.1744201474550;
        Wed, 09 Apr 2025 05:24:34 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23667.dip0.t-ipconnect.de. [79.242.54.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233c7a68sm14567855e9.19.2025.04.09.05.24.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 05:24:33 -0700 (PDT)
Message-ID: <5cd8463e-21ed-4c99-a9b2-9af45c6eb7af@redhat.com>
Date: Wed, 9 Apr 2025 14:24:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Verkamp <dverkamp@chromium.org>, Halil Pasic
 <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 kvm@vger.kernel.org, Chandra Merla <cmerla@redhat.com>,
 Stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Wei Wang <wei.w.wang@intel.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
References: <20250407045456-mutt-send-email-mst@kernel.org>
 <a86240bc-8417-48a6-bf13-01dd7ace5ae9@redhat.com>
 <33def1b0-d9d5-46f1-9b61-b0269753ecce@redhat.com>
 <88d8f2d2-7b8a-458f-8fc4-c31964996817@redhat.com>
 <CABVzXAmMEsw70Tftg4ZNi0G4d8j9pGTyrNqOFMjzHwEpy0JqyA@mail.gmail.com>
 <3bbad51d-d7d8-46f7-a28c-11cc3af6ef76@redhat.com>
 <20250407170239-mutt-send-email-mst@kernel.org>
 <440de313-e470-4afa-9f8a-59598fe8dc21@redhat.com>
 <20250409065216-mutt-send-email-mst@kernel.org>
 <4ad4b12e-b474-48bb-a665-6c1dc843cd51@redhat.com>
 <20250409073652-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250409073652-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.04.25 14:07, Michael S. Tsirkin wrote:
> On Wed, Apr 09, 2025 at 01:12:19PM +0200, David Hildenbrand wrote:
>> On 09.04.25 12:56, Michael S. Tsirkin wrote:
>>> On Wed, Apr 09, 2025 at 12:46:41PM +0200, David Hildenbrand wrote:
>>>> On 07.04.25 23:20, Michael S. Tsirkin wrote:
>>>>> On Mon, Apr 07, 2025 at 08:47:05PM +0200, David Hildenbrand wrote:
>>>>>>> In my opinion, it makes the most sense to keep the spec as it is and
>>>>>>> change QEMU and the kernel to match, but obviously that's not trivial
>>>>>>> to do in a way that doesn't break existing devices and drivers.
>>>>>>
>>>>>> If only it would be limited to QEMU and Linux ... :)
>>>>>>
>>>>>> Out of curiosity, assuming we'd make the spec match the current QEMU/Linux
>>>>>> implementation at least for the 3 involved features only, would there be a
>>>>>> way to adjust crossvm without any disruption?
>>>>>>
>>>>>> I still have the feeling that it will be rather hard to get that all
>>>>>> implementations match the spec ... For new features+queues it will be easy
>>>>>> to force the usage of fixed virtqueue numbers, but for free-page-hinting and
>>>>>> reporting, it's a mess :(
>>>>>
>>>>>
>>>>> Still thinking about a way to fix drivers... We can discuss this
>>>>> theoretically, maybe?
>>>>
>>>> Yes, absolutely. I took the time to do some more digging; regarding drivers
>>>> only Linux seems to be problematic.
>>>>
>>>> virtio-win, FreeBSD, NetBSD and OpenBSD and don't seem to support
>>>> problematic features (free page hinting, free page reporting) in their
>>>> virtio-balloon implementations.
>>>>
>>>> So from the known drivers, only Linux is applicable.
>>>>
>>>> reporting_vq is either at idx 4/3/2
>>>> free_page_vq is either at idx 3/2
>>>> statsq is at idx2 (only relevant if the feature is offered)
>>>>
>>>> So if we could test for the existence of a virtqueue at an idx easily, we
>>>> could test from highest-to-smallest idx.
>>>>
>>>> But I recall that testing for the existance of a virtqueue on s390x resulted
>>>> in the problem/deadlock in the first place ...
>>>>
>>>> -- 
>>>> Cheers,
>>>>
>>>> David / dhildenb
>>>
>>> So let's talk about a new feature bit?
>>
>> Are you thinking about a new feature that switches between "fixed queue
>> indices" and "compressed queue indices", whereby the latter would be the
>> legacy default and we would expect all devices to switch to the new
>> fixed-queue-indices layout?
>>
>> We could make all new features require "fixed-queue-indices".
> 
> I see two ways:
> 1. we make driver behave correctly with in spec and out of spec devices
>     and we make qemu behave correctly with in spec and out of spec devices
> 2. a new feature bit
> 
> I prefer 1, and when we add a new feature we can also
> document that it should be in spec if negotiated.
> 
> My question is if 1 is practical.

AFAIKT, 1) implies:

virtio-balloon:

a) Driver

As mentioned above, we'd need a reliable way to test for the existence 
of a virtqueue, so we can e.g., test for reporting_vq idx 4 -> 3 -> 2

With that we'd be able to support compressed+fixed at the same time.

Q: Is it possible/feasible?

b) Device: virtio-balloon: we can fake existence of STAT and 
FREE_PAGE_HINTING easily, such that the compressed layout corresponds to 
the fixed layout easily.

Q: alternatives? We could try creating multiple queues for the same 
feature, but it's going to be a mess I'm afraid ...


virtio-fs:

a) Driver

Linux does not even implement VIRTIO_FS_F_NOTIFICATION or respect 
VIRTIO_FS_F_NOTIFICATION when calculating queue indices, ...

b) Device

Same applies to virtiofsd ...

Q: Did anybody actually implement VIRTIO_FS_F_NOTIFICATION ever? If not, 
can we just remove it from the spec completely and resolve the issue 
that way?

-- 
Cheers,

David / dhildenb


