Return-Path: <linux-s390+bounces-9769-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD41A7A52F
	for <lists+linux-s390@lfdr.de>; Thu,  3 Apr 2025 16:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DD33B3658
	for <lists+linux-s390@lfdr.de>; Thu,  3 Apr 2025 14:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB13624EA90;
	Thu,  3 Apr 2025 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NW1IDQa+"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F7824EA96
	for <linux-s390@vger.kernel.org>; Thu,  3 Apr 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690518; cv=none; b=TGzndoJDU8s1hzl4SAABVGC8xB0eV9M7qdHyjd4hYY+zJ6hpZc/MuEF5czHQOxxGCM4MSCzbHu7IHdPQ4a4eMWPUNmyh1lkDIu4IFadBha0tk/lo1k0XVoAo4eYFz0++uYBg9WgtiAwitFjev2v3T0rTt12cFTmRQztVpV9jdkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690518; c=relaxed/simple;
	bh=JSdl1NHgYZZU2bfUpnSc5LnVXy/6jHxK40NGSVwnkV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8lbm9iWxvUrpjFEk1MqJ5g7LlNEpFvwccibboOL5bOvvA9q+5dp/1sAGWwAzr2659elPIZWUVaGx41naGGzFbz0YcaPVRCp7oWYdRT8Cydqa2WwTNfy/+m6v7qDgyG7emGGBVpciYwwPNmCExJ/rKWiehQgHiXebsoAwF8kcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NW1IDQa+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743690515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9J+OJ+p7+R3Pc2Foxa5sUhyKVxUU6ZZSnXnmsmIjetQ=;
	b=NW1IDQa+THqKxmBwef9NNzARyrY+pHX7ERtjSs09J04lzRsCiWVaoIQ3hZDoR43IffRtFT
	pd4UorhgdYuEAl18H55u7eek7hpRn5OxX3dwPc7GnvhUch/fVr0tn0pPC5WTg+OW0wqZV3
	JXRmypvjmkpDq3vYe6PaI23XrdFcvkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-BFsuh3ftOCGQaSO4fNDcyw-1; Thu, 03 Apr 2025 10:28:34 -0400
X-MC-Unique: BFsuh3ftOCGQaSO4fNDcyw-1
X-Mimecast-MFC-AGG-ID: BFsuh3ftOCGQaSO4fNDcyw_1743690513
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912a0439afso472515f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 03 Apr 2025 07:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690513; x=1744295313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9J+OJ+p7+R3Pc2Foxa5sUhyKVxUU6ZZSnXnmsmIjetQ=;
        b=FufOh9HPcmkH0HEM9LanSuCQvxmejcFq9ctMBrh3WQFieAnKBkyVY+q2t5pzYqIfBr
         j0hP7uIAl91QTjLs6l/9TU4hEubXF+O1M3avmJA8WQoNf/Md1t3vhO7roA+KVxnIw7mu
         Ni137J38O2CI8KY07HGoYT+LIdzy/3xoFbS+AZQFUkM0JHDekJ7GMQP0GMoxMpCSSuOq
         Wa89oY6k5PmmEkkpMT4j9ZR5FbAhffmgjZe7ukHpnPJJ0jXK/cjvqRbRQrCF1fB+w3Pf
         9Pog4rb7mQeiScd1+wqhxtajfPo3ClR3mbUTCSzHDfnHQHwYOBJrffa9ts3YAL8Pu4Kx
         WOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs7GkWUo64hzN1yDyUVIbNrrNSFGb3PWU85NeNck97R0Th6nqDbhFvTa7vPTJrq8TDjLFAr++iuoTp@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhiOq2j1Afy/wGCHlC37LGL7dm6byhsmOEepOSsPGQ93t1sDw
	z7OHpNUZDyzK7J5rzz5u7IlI0kBfjXeaHDTF9CEO57rbCCcYFYWHo8t8hxbN15lqOcnepJpfEpy
	mnhovrFBj7pFGqyS/7qSrhvW1Ljvz9/AXwp6c8Npgip8Byxb4Qk5CD/zy1GtvWPRjS1B62Q==
X-Gm-Gg: ASbGncuwzEH6HJALy2Uvt9BFOeiYscuK73tJ4C7tgn/5QwjoI4G8ltYj4ix7ZW+XfUu
	uvImSJ92OnXkgAxIwHJ02BmV0197iVWdZaGLAVboKXqe9An/Ewi/lcs/QcnngXTad6JErKGP2fh
	0RbJYyh3RcuuoxKCzQxR/J5erIfouwchQ7ftcE5B+pf/Yfp+SOMNUZpUS6Ax8Mu6fY+v/QCFk2w
	U4A3YZs7+nSfQBVcOcz1nX++HfrCDhVf6lFsKp1rgc/rQEYPfR689I9/iMcSIRdStx8IgXbDAK2
	SxwqhXoLLBJP6LpIVcfFneK2QbSWD7C6joVi6d230psS
X-Received: by 2002:a05:6000:4205:b0:39c:2690:fe0a with SMTP id ffacd0b85a97d-39c29737d37mr6593010f8f.10.1743690513312;
        Thu, 03 Apr 2025 07:28:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAK3ydOSly/Trv07/K/qF4LIZl/e96tY/ernCa8V6ZollUsEDOblyip4uh9Skt+5jzAcrIXw==
X-Received: by 2002:a05:6000:4205:b0:39c:2690:fe0a with SMTP id ffacd0b85a97d-39c29737d37mr6592974f8f.10.1743690512915;
        Thu, 03 Apr 2025 07:28:32 -0700 (PDT)
Received: from [192.168.3.141] (p4ff23029.dip0.t-ipconnect.de. [79.242.48.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34a8d67sm20112745e9.12.2025.04.03.07.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 07:28:32 -0700 (PDT)
Message-ID: <e2936e2f-022c-44ee-bb04-f07045ee2114@redhat.com>
Date: Thu, 3 Apr 2025 16:28:31 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] s390/virtio_ccw: don't allocate/assign airqs for
 non-existing queues
To: Halil Pasic <pasic@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 virtualization@lists.linux.dev, kvm@vger.kernel.org,
 Chandra Merla <cmerla@redhat.com>, Stable@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
References: <20250402203621.940090-1-david@redhat.com>
 <20250403161836.7fe9fea5.pasic@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250403161836.7fe9fea5.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.04.25 16:18, Halil Pasic wrote:
> On Wed,  2 Apr 2025 22:36:21 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> If we finds a vq without a name in our input array in
>> virtio_ccw_find_vqs(), we treat it as "non-existing" and set the vq pointer
>> to NULL; we will not call virtio_ccw_setup_vq() to allocate/setup a vq.
>>
>> Consequently, we create only a queue if it actually exists (name != NULL)
>> and assign an incremental queue index to each such existing queue.
> 
> First and foremost: thank you for addressing this! I have to admit, I'm
> still plagued by some cognitive dissonance here. Please bear with me.
> 
> For starters the commit message of a229989d975e ("virtio: don't
> allocate vqs when names[i] = NULL") goes like this:
> """
>      virtio: don't allocate vqs when names[i] = NULL
>      
>      Some vqs may not need to be allocated when their related feature bits
>      are disabled. So callers may pass in such vqs with "names = NULL".
>      Then we skip such vq allocations.
> """
> 
> In my reading it does not talk about "non-existent" queues, but queues
> that do not need to be allocated. This could make sense for something
> like virtio-net where controlq 2N is with N being max_virtqueue_pairs.
> 
> I guess for the guest it could make sense to not set up some of the
> queues initially, but those, I guess would be perfectly existent queues
> spec-wise and we would expect the index of controlq being 2N. And the
> queues that don't get set up initially can get set up later. At least
> this is my naive understanding at the moment.
> 
> Now apparently there is a different case where queues may or may not
> exist, but we would, for some reason like to have the non-existent
> queues in the array, because for an other set of features negotiated
> those queues would actually exist and occupy and index. Frankly
> I don't fully comprehend it at the moment, but I will have another look
> at the code and at the spec.
> 
> So lookign at the spec for virtio-ballon I see:
> 
> 
> 
> 5.5.2 Virtqueues
> 
> 0
>      inflateq
> 1
>      deflateq
> 2
>      statsq
> 3
>      free_page_vq
> 4
>      reporting_vq
> 
> statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
> 
> free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
> 
> reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
> 
> Which is IMHO weird.  I used to think about the number in front of the
> name as the virtqueue index. But based on this patch I'm wondering if
> that is compatible with the approach of this patch.
> 
> What does for example mean if we have VIRTIO_BALLOON_F_STATS_VQ not
> offered, VIRTIO_BALLOON_F_FREE_PAGE_HINT offered but not negotiated
> and VIRTIO_BALLOON_F_PAGE_REPORTING negotiated.
> 
> One reading of the things is that statq is does not exist for sure,
> free_page_vq is a little tricky because "is set" is not precise enough,
> and reporting_vq exists for sure. And in your reading of the spec, if
> I understood you correctly and we assume that free_page_vq does not
> exist, it has index 2. But I from the top of my head, I don't know why
> interpreting the spec like it reporting_vq has index 4 and indexes 2
> and 3 are not mapped to existing-queues would be considered wrong.
> 
> And even if we do want reportig_vq to have index 2, the virtio-balloon
> code could still give us an array where reportig_vq is at index 2. Why
> not?
> 
> Sorry this ended up being a very long rant. the bottom line is that, I
> lack conceptual clarity on where the problem exactly is and how it needs
> to be addressed. I would like to understand this properly before moving
> forward.
> 

I would suggest you take a look at [1] I added below, and the disconnect 
between the spec and what Linux + QEMU actually implemented.

In reality (with QEMU), reporting_vq sits either on index 3 or 4, 
depending on the existence of VIRTIO_BALLOON_F_FREE_PAGE_HINT.


> [..]
>>
>> There was recently a discussion [1] whether the "holes" should be
>> treated differently again, effectively assigning also non-existing
>> queues a queue index: that should also fix the issue, but requires other
>> workarounds to not break existing setups.
>>
> 
> Sorry I have to have a look at that discussion. Maybe it will answer
> some my questions.

Yes, I think so.

> 
>> Let's fix it without affecting existing setups for now by properly ignoring
>> the non-existing queues, so the indicator bits will match the queue
>> indexes.
> 
> Just one question. My understanding is that the crux is that Linux
> and QEMU (or the driver and the device) disagree at which index
> reporting_vq is actually sitting. Is that right?

I thought I made it clear: this is only about the airq indicator bit. 
That's where both disagree.

Not the actual queue index (see above).

-- 
Cheers,

David / dhildenb


