Return-Path: <linux-s390+bounces-3234-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2668A112F
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9461C23B8C
	for <lists+linux-s390@lfdr.de>; Thu, 11 Apr 2024 10:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDE8147C9D;
	Thu, 11 Apr 2024 10:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqPfXEPe"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F171465BE
	for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832078; cv=none; b=LmZ1xidezFt2d74JbWL13LrxSpIgs43TTMYmIsXRdRU7HzVspVsUycPDN5E8XtMuFuuNv37ulIrEyf5cM/CNrd92kqJJ+E4qbQ/ccLOI66n42XJ9e8VmCHmfbw/IVkCq2+WnZAlMyyXnoFuzKOQtGetZP4tnWBNdW3cV7myHt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832078; c=relaxed/simple;
	bh=d9vIZIcZYhb0hmTNPAaKe83STvyr9oF27Ohb0ptaxd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XaAmA5lt4KmBqkDtL6oigsFWg6CSf/n/+JmxxTegnPiFt04clbZdP30GWIFycDxWiSpuFmRaTTDXJDbZ/V5xT2WJl1nH4OJlkEyJvlGo1mkpil2wUjNuqEaY4iHYOfE9zui+mtv3WJemJehDQxzgBIhZS+gBTK51y7DS20n4shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RqPfXEPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712832075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jlD3g/3UH/GCYNXn2++1vOlMUP0XwbmyYwNqqY29lSI=;
	b=RqPfXEPeyzbSqhzQa606FqEprsId9XMpchAr1+W68t1epVqcouVC254fYRhgUvSY/5m/wa
	me0kSrSLsNFiwnRqKYpyXgScARm5qI8J1J/jIBcAGdRwePG6GPjhrLPQnnb9pSMfN8r16+
	r8FKwI/9kSePN/8DU+03OTpKB0yn41I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-AgFzcHFONDOrR_b6jriM7A-1; Thu, 11 Apr 2024 06:41:13 -0400
X-MC-Unique: AgFzcHFONDOrR_b6jriM7A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-345aa380e51so2219351f8f.3
        for <linux-s390@vger.kernel.org>; Thu, 11 Apr 2024 03:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712832072; x=1713436872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jlD3g/3UH/GCYNXn2++1vOlMUP0XwbmyYwNqqY29lSI=;
        b=Cd/AtGSzTyftRBtZhj3efuLSe4/9cpCQI7mg+krKeNBMONq9ApMDRfVpeGimYOlpYJ
         ot9P7JsVygIDKZOKBMXQIX8PsORLp9pdsuBBrBDFdWimYpO/LOY0P1VRuzhsvptp2sXg
         mk2wYuZ3pGrF+NgfUecnrwpa5baQn0ItzS2LakTdJKcVQIEUzmxv8RWWDAgmjFggLhQv
         8xXK1CZWsSBoUesrlYAzKfd5t+AolKBTeQ9Nt1nhoKevLy/KcFzFJiLZLUy8ZZNG50bw
         2gOYhE30VR/GBLR9wUHQiWZP/XpQQ+Kv7S9IEsQsEU8auq65wLhazKnh/uQ6oZqpT0nW
         Us2A==
X-Forwarded-Encrypted: i=1; AJvYcCVg4u4iroglEnLOfTUYAZMPw7a6kSETv/ArecIFP6TGDGNzQ2aR0lzUfUxGAA1uFzTnIytrIt4de+4yuHBrWiil7+j/GvvoZW9P/g==
X-Gm-Message-State: AOJu0Yxbuhw6ED9sHPp20gW22oWV3ZCVnHMwQuNMXh8lYOvVVQeZAkPl
	7smHoDKQlvk4ZcI+ctoflXpHYgPg7FPkKGBTEam8G4pywZFlmML15qT+MzYp31hq/GT7+qdi1Bl
	civQpTOGJt78EqQfBgylRqZdElSDQEt5w5+XwZVa6xV59YhUe6GHUQ/mp/XCjwQORxUY=
X-Received: by 2002:a05:6000:7:b0:33e:5fb4:49d1 with SMTP id h7-20020a056000000700b0033e5fb449d1mr3626267wrx.44.1712832071913;
        Thu, 11 Apr 2024 03:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2C0Ga4ppVzXBZ3fO+MpSA8qjneoeZnncWFt3fsIu4r28mJwFqWa3ODJJkuXz26LamLC5EbQ==
X-Received: by 2002:a05:6000:7:b0:33e:5fb4:49d1 with SMTP id h7-20020a056000000700b0033e5fb449d1mr3626254wrx.44.1712832071442;
        Thu, 11 Apr 2024 03:41:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c724:4300:430f:1c83:1abc:1d66? (p200300cbc7244300430f1c831abc1d66.dip0.t-ipconnect.de. [2003:cb:c724:4300:430f:1c83:1abc:1d66])
        by smtp.gmail.com with ESMTPSA id u7-20020adfeb47000000b0033ec9ddc638sm1460690wrn.31.2024.04.11.03.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 03:41:11 -0700 (PDT)
Message-ID: <da266113-37da-4b61-ba6f-47f0761e3cb8@redhat.com>
Date: Thu, 11 Apr 2024 12:41:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/5] s390/uv: convert PG_arch_1 users to only work on
 small folios
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240404163642.1125529-1-david@redhat.com>
 <20240404163642.1125529-4-david@redhat.com>
 <Zg9xozcubKUYe-BV@casper.infradead.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zg9xozcubKUYe-BV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 05:36, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 06:36:40PM +0200, David Hildenbrand wrote:
>> Now that make_folio_secure() may only set PG_arch_1 for small folios,
>> let's convert relevant remaining UV code to only work on (small) folios
>> and simply reject large folios early. This way, we'll never end up
>> touching PG_arch_1 on tail pages of a large folio in UV code.
>>
>> The folio_get()/folio_put() for functions that are documented to already
>> hold a folio reference look weird and it should probably be removed.
>> Similarly, uv_destroy_owned_page() and uv_convert_owned_from_secure()
>> should really consume a folio reference instead. But these are cleanups for
>> another day.
> 
> Yes, and we should convert arch_make_page_accessible() to
> arch_make_folio_accessible() ... one of the two callers already has the
> folio (and page-writeback already calls arch_make_folio_accessible()
> 

Yes. We should then get rid of the arch_make_folio_accessible() loop 
over pages. Arch code can handle that, if required. Will include that in 
this series.

-- 
Cheers,

David / dhildenb


