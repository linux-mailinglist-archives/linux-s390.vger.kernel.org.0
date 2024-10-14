Return-Path: <linux-s390+bounces-6478-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9E399D72B
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2024 21:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A4B1F2415F
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2024 19:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E521CC881;
	Mon, 14 Oct 2024 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo4eXykn"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9381CACD8
	for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933414; cv=none; b=rM/OhwiOMzSwwKBEZRUN6wO/SraU5ToZOQ9ebAav1BDodoZBw8Y9T+iWbGK+ci6pBkLHUzdkQE7U+j6WY1eOLDPKAy6sN+NROwgIl/1R6tnxe+4ZTKydRHed6JXm6TzqCulBV5o4rgsjEyvkiQ1ZGfpUUwF9YgnvRJ8id61WU/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933414; c=relaxed/simple;
	bh=4dLSC1AqyzV3uC10Q3HwD5XOgaZY1SpinKQv+dE8wno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYLXvdy8R6jVYQrsFMHKdcQsfOLMxyXcKueRfKBay7qZrHcy4aopVEie/0ljT1RhPEwJQFuxCJZ3CMqvKU1EC5RXl7EW1m1sg6Yy8f8EaEqjcxcwWLpi1fGlk8UZAVBCJfdutfiOE/BtHnREDQA2+/n/nI7kEFG/DYgNzNkoxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo4eXykn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728933411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sQIx8Zvd1bi6csR0yDCe7VkAynOD+MUuQmAi1iHX0fA=;
	b=Lo4eXyknESQkjxxNGgx/lo8ShBohjbJcbZprAq+IiL8HbL9bO0WDg4yS0G0mgN6/WqBh1/
	9It6Yv8510ZFukUZzgQnYbAemn6TWx1vpNuHfSGwSOP7C7faXQIWl7iU1MYngoW/TX6dBL
	5LwLQvCrmwKHPdTwZCspWcqMahoD9nM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-0qSqIGT5MNqFZUOLXbK3oQ-1; Mon, 14 Oct 2024 15:16:49 -0400
X-MC-Unique: 0qSqIGT5MNqFZUOLXbK3oQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d589138a9so1492260f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 12:16:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933408; x=1729538208;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQIx8Zvd1bi6csR0yDCe7VkAynOD+MUuQmAi1iHX0fA=;
        b=ZnaQ9r/qEs6f7NvfUu8EhaFWT4lpw3DHQgqRFTbTZ16kXxgvQZeLDoGdlLF/F9J3du
         3Bf4reifTWqqm6NN31MOF6LSNbWHI6+pLjfq9Em19k3rLP45AhbuJmKi6eY8ZkG3eBKm
         oey6AU06P+RCdr+VANuh9VMHbKitMiSd2KIq0OGeo1Iv6pGs6FdqPPWpKEmJ23K7nAdq
         +f3/CkyVhOsTjUHlBd7+nDVg71UAXA9tV91ylOG8r4pGzocouvm7nBbQtY9Nl+cG8hAH
         gjuThws189ecO7NSu8Ghkq7+hSQRyvP0h1Y16RvrKLlmspDofGHxEkpQ41cFOcM1AIik
         0rFg==
X-Forwarded-Encrypted: i=1; AJvYcCWvQMfx+VgC1ueLw5NIjMuS1P2uTCM+tkvEXdN4eYLmwa5Siv/3sfyPhNajpESNfWlP3usXv37yWy2z@vger.kernel.org
X-Gm-Message-State: AOJu0YyLXvz5C/0BCzc4mzWVU/2o9xGt3pvXnk+z4ZOBHH8O1jUqI7oN
	f4JF7Zs1sE6EDp1O11i+vpDh+1188YEdwrJWGbUdl935pPLUAL5HML2jRw1SpqjeywNjcWUwac6
	DsBpCOd8Dw9cH7izX44GMRJhJxb38LaudKhsvS+qZRGoK9ZDWplOeP8ejmiQeHqYwNczN+Q==
X-Received: by 2002:a5d:4348:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-37d551e3d0cmr8006253f8f.17.1728933408033;
        Mon, 14 Oct 2024 12:16:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6sBThr6RdJ9UzUqBJZ/Z2oXOcyxnQX4PJcKNdIkMaURe8S9HvwixtiT1L8Zrvsmei+/RVow==
X-Received: by 2002:a5d:4348:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-37d551e3d0cmr8006241f8f.17.1728933407562;
        Mon, 14 Oct 2024 12:16:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:600:9fbb:f0bf:d958:5c70? (p200300cbc71e06009fbbf0bfd9585c70.dip0.t-ipconnect.de. [2003:cb:c71e:600:9fbb:f0bf:d958:5c70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cffa5sm12197664f8f.53.2024.10.14.12.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 12:16:47 -0700 (PDT)
Message-ID: <ebce486f-71a0-4196-b52a-a61d0403e384@redhat.com>
Date: Mon, 14 Oct 2024 21:16:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] virtio-mem: s390 support
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, virtualization@lists.linux.dev,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Mario Casquero <mcasquer@redhat.com>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-6-david@redhat.com>
 <20241014184824.10447-F-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241014184824.10447-F-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 20:48, Heiko Carstens wrote:
> On Mon, Oct 14, 2024 at 04:46:17PM +0200, David Hildenbrand wrote:
>> The special s390 kdump mode, whereby the 2nd kernel creates the ELF
>> core header, won't currently dump virtio-mem memory. The virtio-mem
>> driver has a special kdump mode, from where we can detect memory ranges
>> to dump. Based on this, support for dumping virtio-mem memory can be
>> added in the future fairly easily.
> 

Thanks for the review.

> Hm.. who will add this support? This looks like a showstopper to me.

The cover letter is clearer on that: "One remaining work item is kdump 
support for virtio-mem memory. This will be sent out separately once 
initial support landed."

I had a prototype, but need to spend some time to clean it up -- or find 
someone to hand it over to clean it up.

I have to chose wisely what I work on nowadays, and cannot spend that 
time if the basic support won't get ACKed.

> Who is supposed to debug crash dumps where memory parts are missing?

For many production use cases it certainly needs to exist.

But note that virtio-mem can be used with ZONE_MOVABLE, in which case 
mostly only user data (e.g., pagecache,anon) ends up on hotplugged 
memory, that would get excluded from makedumpfile in the default configs 
either way.

It's not uncommon to let kdump support be added later (e.g., AMD SNP 
variants).

-- 
Cheers,

David / dhildenb


