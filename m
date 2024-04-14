Return-Path: <linux-s390+bounces-3238-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A218A14A5
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 14:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51DE61F2218E
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23F64C6E;
	Thu, 11 Apr 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NC1XB3dt"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C7623AD
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838641; cv=none; b=gfC/q7MAQ37nP06jnFfFm+KVatThk9f4TnMqGwcNLskAVU+5LdrCisrsh7k0rhw9FfUcnh0kFXSIefzKu83yUvGvAQtAN3XbcImNFfE+vWGRBprLc1hnFkBmaz9yot8Vu7tCrMwqeBLC0frBd10focWo6kQPFCAgD/mV2hSwh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838641; c=relaxed/simple;
	bh=19SThbH+HroCA8DKalKKz3GnvI8MQEhAC7iHyh5IYxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDa1hyPXeecdslz0GpaQVbrgVsPOinmR38fjbVyZZWY5KmWAXqcep/LiRSZ9bdLXdp5unVrTGLNBX53PPHKBVyqlnVjF8VvLbZ8kVA52S6WA3QbKS91RRwyxeynWFOHdzanzP/AFz1eAgtyTm1t8mwbjdgzp+c+O74mLSEH/OVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NC1XB3dt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712838638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y7TwXs97cGKCSPlZat8D9T+J4ssIvDgilxKFcQCp65o=;
	b=NC1XB3dt40KDfzAC4finCdEkTmKlDqh5E7h0Y9xjrlENwHzoBtB/IU2TAdlYTvRi0tSK1+
	ZolJ9ScZBayri5Dg3hLbc+8t/ETT8NXbvSr2gFZiQxxPCXbeTV8PTo5+7HqJVziNTAKxFH
	hd8ZtNXFwC8DPKxhe9Z8TU8Xt83H4Vo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-9z59ZKQUP3qiTlySiC82Ug-1; Thu, 11 Apr 2024 08:30:37 -0400
X-MC-Unique: 9z59ZKQUP3qiTlySiC82Ug-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2d6c94d98afso73819721fa.3
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 05:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712838636; x=1713443436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y7TwXs97cGKCSPlZat8D9T+J4ssIvDgilxKFcQCp65o=;
        b=uYAIPSYLX57vwofm/mYi2eJNUaLzwaCYAEMldmCKX+PY+hFjUBpdqH6WTS1kOO19mP
         E0F3O8xeNUe00BDroYhHMNtImphozQPkfoKIwB/FDmVA5zFEW0sp7dZc38YkZWdy4PJw
         RKxzAMK9x9TABXHFERXKJPensM4zLsnekzLhB99kAq5/o4fvscTLQFgxRS9szCXaZLKf
         79cykmO994AXW16V/96CNPns+Hxhr1iwp2/tiZDBIN6hFOoJYprJqNPz5+TFy9Lbjm4S
         w5jp/cid6TDqGSVZQHJMBijn6a2JZF736sy95jokIrp3/ccZKIhhWycra5J+0Ld16P1h
         w3XA==
X-Forwarded-Encrypted: i=1; AJvYcCXmQvfZd2tiyxQmDuq6GBRvcs1AU/UxBlUUCARZ7Y4Liu8sZxBqNqFHem1V9QGwPN0L1HVGzGDYfKP5xGonjeA3qU8lHw9RAVYCHg==
X-Gm-Message-State: AOJu0YxoORidTXVxDVTz2XTe1cgQ0rGqhXs23LvIBqBYd65Bkas/em/g
	pQBMFj372V13ipoi+48l5dp+411HLx89hMzGCUouOTjRk3zFzR2Ir6WDDmAhVne1d9N+H8WTHfE
	ee47WCXpDUgnMbleTI5EM7VAQ6ahaUdpNL6fDUK2mtEWeQnol8url8NaogBM=
X-Received: by 2002:a2e:98c7:0:b0:2d8:dd28:8748 with SMTP id s7-20020a2e98c7000000b002d8dd288748mr2945366ljj.1.1712838636014;
        Thu, 11 Apr 2024 05:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNhbKnm91UzHHYzeclwSv0GXVTE0gXbsFHBBDgl8GE19+0m4lF65G2tfbEM69kj3DPzwh/3g==
X-Received: by 2002:a2e:98c7:0:b0:2d8:dd28:8748 with SMTP id s7-20020a2e98c7000000b002d8dd288748mr2945334ljj.1.1712838635554;
        Thu, 11 Apr 2024 05:30:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b00417e134dd2dsm1142306wms.37.2024.04.11.05.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 05:30:35 -0700 (PDT)
Message-ID: <b9d9af94-5935-4034-bf3f-9ba283df3ede@redhat.com>
Date: Thu, 11 Apr 2024 14:30:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/userfaultfd: don't place zeropages when
 zeropages are disallowed
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Andrea Arcangeli <aarcange@redhat.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20240327171737.919590-1-david@redhat.com>
 <20240327171737.919590-2-david@redhat.com>
 <ZhfW7qzAGPQo3mJN@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZhfW7qzAGPQo3mJN@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.04.24 14:26, Alexander Gordeev wrote:
> On Wed, Mar 27, 2024 at 06:17:36PM +0100, David Hildenbrand wrote:
> 
> Hi David,
> ...
>>   static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
>>   				     struct vm_area_struct *dst_vma,
>>   				     unsigned long dst_addr)
>> @@ -324,6 +355,9 @@ static int mfill_atomic_pte_zeropage(pmd_t *dst_pmd,
>>   	spinlock_t *ptl;
>>   	int ret;
>>   
>> +	if (mm_forbids_zeropage(dst_vma->mm))
> 
> I assume, you were going to pass dst_vma->vm_mm here?
> This patch does not compile otherwise.

Ah, I compiled it only on x86, where the parameter is ignored ... and 
for testing the code path I forced mm_forbids_zeropage to be 1 on x86.

Yes, this must be dst_vma->vm_mm.

Thanks!

-- 
Cheers,

David / dhildenb


