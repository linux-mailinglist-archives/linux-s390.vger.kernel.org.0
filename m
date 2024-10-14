Return-Path: <linux-s390+bounces-6481-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70B99D788
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2024 21:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35AC6B218C7
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2024 19:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FB1CC893;
	Mon, 14 Oct 2024 19:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB9rQnF+"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E93A1B6
	for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934536; cv=none; b=L/Z16qczRmpAxF58WZXQgFWRgMiocj74D9eO1TqBaBSiZezAEJWCIQ1pR5yQmxybsyvkwxUhj6wonm/7lT7wBwi/tDigiNNfVfO7bVvdt7Z4PiBBS4gyq7uRqoDGhpDbFkXBvvwYre12cM98MvIl0xFOFux68QL/1nWZedZesxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934536; c=relaxed/simple;
	bh=ATb9FQ16x78hfIMSaPpd+FQuWIsSjOLL9lHPFZfzluE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv8kklNfZfOTAppyo8wMk1sdrNwaWXmHmYaFn1UilRaiGg7FmmF7wtX9/0Uixzrpo/zCc9a3QVzcKxNTYWsKfeHrEFkD5eJWBuhKk22+gmnCmhB2dkrL8YoFjgQRjU6jo8mbY7AXJTDd2qj0cWInty/J/Ew4l5qFfqhM3GJrvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QB9rQnF+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728934534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=sgEXWzSvIwubbV7unridAoQa4cdce3CR6+dDgB9+5yc=;
	b=QB9rQnF+aydkcMj9IRVzStoL2Ma4BdHMkhZbMyA3FNi7c72k4MVg52m20vX/TlYEGxmnYz
	KZX8DcQZzbi/x9Hj7HRdHAkzBdtK51Q62Q1hSKloMTI40kN4bGCIzjJpRW9J4rY4XXuOiN
	yEHyZIPfGjfNYeIdcMP+ZPhh21ThXUU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-8Voehr_XP2O1oZIww8-cMw-1; Mon, 14 Oct 2024 15:35:32 -0400
X-MC-Unique: 8Voehr_XP2O1oZIww8-cMw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d4d51b4efso1740567f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 12:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728934530; x=1729539330;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgEXWzSvIwubbV7unridAoQa4cdce3CR6+dDgB9+5yc=;
        b=brfppY10aY9f+9gE5Ys2fI48nWacRlsgHfohoW523w5EeYmbDaQACIE3uCMpPmqd7J
         bNLIcn82JDcHCRKY3HRZwAigVWDoX2oY3YC23o3Jc5W4RBvyp5aNu9LFB8DSFPNFSPwL
         u+WiYPcnRS+YNU8f5SxyxQHj5mTPaaHNWjcFKHtXb1s75z0rcRjt8E4htBVUYNm/Q99L
         Fbsd0ubAVfK94aEUN4m+ZvEq+Y97IuPIxAjotG1jLeW0HNQexB2QBxxfmscBXLe3GSV0
         m4D6PFn8zU+OETnKxuZwic34+lMDO1PSgVYVAMBcvOrZ4Q6Ko2+Jxk0igGRxmImcvWEi
         AaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVox56kDDbKzgrjOCe36699SgcxZjm5P1Er703isqK2yx+I+OzZ3HsEYYj184CShR4moxoJUtjloZvQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyQp1fGVdcb8nHFIDj3CZmWhGbmJWr92YBc0z2RQ/o3MgipbPiD
	lJcaFRWAO3Hb2lo2+vsPhUgyVAPLMDbQfB8B7Z3oIVmJOHIA8elCg2TvZSP7LA2AnF5wmVujOJt
	kkz7EOgHeT3xfnDh1APLr8FL5nFYdwKg3+HGraIdYTaDjiI85kj0FSnNmzT8=
X-Received: by 2002:adf:f98a:0:b0:37c:ce58:5a1a with SMTP id ffacd0b85a97d-37d552d22efmr8719163f8f.54.1728934529928;
        Mon, 14 Oct 2024 12:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmLVPlsR53bsF9ZXTvVKgUGcOHdy2gZRmudwBVh0AEj48pcH21cjEcwhpIbdusHD2n/ntBeg==
X-Received: by 2002:adf:f98a:0:b0:37c:ce58:5a1a with SMTP id ffacd0b85a97d-37d552d22efmr8719138f8f.54.1728934529506;
        Mon, 14 Oct 2024 12:35:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:600:9fbb:f0bf:d958:5c70? (p200300cbc71e06009fbbf0bfd9585c70.dip0.t-ipconnect.de. [2003:cb:c71e:600:9fbb:f0bf:d958:5c70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f776sm163003415e9.3.2024.10.14.12.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 12:35:29 -0700 (PDT)
Message-ID: <78e8794a-d89f-4ded-b102-afc7cea20d1d@redhat.com>
Date: Mon, 14 Oct 2024 21:35:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] Documentation: s390-diag.rst: make diag500 a
 generic KVM hypercall
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
 Jonathan Corbet <corbet@lwn.net>
References: <20241014144622.876731-1-david@redhat.com>
 <20241014144622.876731-3-david@redhat.com>
 <20241014180410.10447-C-hca@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241014180410.10447-C-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 20:04, Heiko Carstens wrote:
> On Mon, Oct 14, 2024 at 04:46:14PM +0200, David Hildenbrand wrote:
>> Let's make it a generic KVM hypercall, allowing other subfunctions to
>> be more independent of virtio.
>>
>> This is a preparation for documenting a new hypercall.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   Documentation/virt/kvm/s390/s390-diag.rst | 15 ++++++++-------
>>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> ...
> 
>> -DIAGNOSE function code 'X'500' - KVM virtio functions
>> ------------------------------------------------------
>> +DIAGNOSE function code 'X'500' - KVM functions
>> +----------------------------------------------
>>   
>> -If the function code specifies 0x500, various virtio-related functions
>> -are performed.
>> +If the function code specifies 0x500, various KVM-specific functions
>> +are performed, including virtio functions.
>>   
>> -General register 1 contains the virtio subfunction code. Supported
>> -virtio subfunctions depend on KVM's userspace. Generally, userspace
>> -provides either s390-virtio (subcodes 0-2) or virtio-ccw (subcode 3).
>> +General register 1 contains the subfunction code. Supported subfunctions
>> +depend on KVM's userspace. Regarding virtio subfunctions, generally
>> +userspace provides either s390-virtio (subcodes 0-2) or virtio-ccw
>> +(subcode 3).
> 
> Reading this file leaves a number of questions open: how does one know
> which subcodes are supported, and what happens if an unsupported
> subcode is used?

Currently they have to be sensed
> 
> I'm afraid there is no indication available and the only way to figure
> out is to try and if it is unsupported the result is a specification
> exception. Is that correct?

Yes exactly.

> 
> If so, it would be nice to document that too; but that is not
> necessarily your problem.

I can squash:

diff --git a/Documentation/virt/kvm/s390/s390-diag.rst b/Documentation/virt/kvm/s390/s390-diag.rst
index d9b7c6cbc99e..48a326d41cc0 100644
--- a/Documentation/virt/kvm/s390/s390-diag.rst
+++ b/Documentation/virt/kvm/s390/s390-diag.rst
@@ -50,6 +50,9 @@ Upon completion of the DIAGNOSE instruction, general register 2 contains
  the function's return code, which is either a return code or a subcode
  specific value.
  
+If the specified subfunction is not supported, a SPECIFICATION exception
+will be triggered.
+
  Subcode 0 - s390-virtio notification and early console printk
      Handled by userspace.
  


> 
> I guess we won't see too many new diag 500 subcodes, or would it make
> sense to implement some query subcode?

In the context of STORAGE LIMIT, a "query" subfunction is not really beneficial:

it's either one invocation of "query", conditionally followed by one invocation of "STORAGE LIMIT"
vs. one invocation of "STORAGE LIMIT".

Once there might be a bunch of other subfunctions, a "query" might make more sense.

Thanks!

-- 
Cheers,

David / dhildenb


