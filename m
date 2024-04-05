Return-Path: <linux-s390+bounces-3043-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 834BB89963F
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 09:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEA61F27159
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 07:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B8D2C68B;
	Fri,  5 Apr 2024 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daiJgRI5"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA252C1B6
	for <linux-s390@vger.kernel.org>; Fri,  5 Apr 2024 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300978; cv=none; b=EWn3Tzq3Wt4dIpa81l8RJ50zLaxAoF7aY3jIbhP8CMCGXlf+ubrm4OsuDslahUNohd2EPIqgNWVY6LvJYd+XqTqzXwew1AsrEl2OAnRlRUoC4o2Ws1w54RXJAoF0QvQBnoxgteOKoRZ4D/kZFa4PaIB54s5AoeeusFFEpwcE+TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300978; c=relaxed/simple;
	bh=oBpQTQQF+RxUjK0qQTdFBdRzlIfgYkZc4RMyIDNRwQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULnhnQ/w2VZqHli8sg2Od3DjLyvmGHTW7jOksnGTy18+kmZyTeL2U45E1udgxvwNLXnqjObwQ2OgQZhYQQf4irK3xeDlyi1L1vRZFLKV8qDJHgtoxW6ExWI2Tki6LO/n+XOp4UGScGnJivM8lM6OlOrrHlreseqJYSK65Gfr+uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=daiJgRI5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712300975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bWsrv37YfNRYFkefj79IxZMucsyie5Vbns2PoB6HIB4=;
	b=daiJgRI5FtxmwkoHGO0BstKF/LaLkVWS+uS18lxUS48xBPHJi0VyFZlHptjjr3gTkDqrJh
	i7GQ8OL5mrCAGe/Y0C/R41u3VqFvHjBA/cUN4K0XJ4CQDtMtPiZTnJ3dQfD3hxT4SzjGQb
	072xJBbMKhKFGJ+y2uK7GmX2eeJMvVY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-FN7ZNmCSONyKwTLRK9jTaA-1; Fri, 05 Apr 2024 03:09:33 -0400
X-MC-Unique: FN7ZNmCSONyKwTLRK9jTaA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-41401f598cfso11473415e9.2
        for <linux-s390@vger.kernel.org>; Fri, 05 Apr 2024 00:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300972; x=1712905772;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWsrv37YfNRYFkefj79IxZMucsyie5Vbns2PoB6HIB4=;
        b=V9BhWzR2HXH69OzmLSairxTu5mc/PstEiwESJbXESKzFS7GeYhXRcUQpaRQCOhS6bi
         49fA2ZlPH43UMfJFS3pNglcH0yHEu4hOam4wgqrfhIFlEU+JL25V+fUMCJDkZ6+bSxMo
         LO+QZa9cBPU4lp0uYMKFxiyXbujPQcd0hFQrEnLB2RJukSUdoXHGkmJ2ti69Nev8qHd2
         LpgdbXJyJpNZvuaCfPm1pn3pVh4ALEWF6dvvN+I/uHxbV7Valv3WIhuRcYYgdqyWL4oF
         CphPbRsZkEXTC0VdmGFdQpVMAyYt/MdF/xkiz/hxW4GY22eTekEgBxvEx1OHXoyP3MuA
         XA2g==
X-Forwarded-Encrypted: i=1; AJvYcCVrvmtiV5ovb+bDJrLhEaBuOyno6cbCUNOWoxW0KRNmvT/9D+bB7fqo8A0Y3p7u0ZE1ZaW6h+jFsYXqCeiASOGbzBNmavdYPzo90g==
X-Gm-Message-State: AOJu0YxWVLxymiiBqr8ktiuv9ezv45jCQFYaQMQqHKTYawnOjAGbU6Qo
	2L/twmfkKlziGCHtEzcV/cnMqDI7FE9aM5+ECao6rJMaE0FGisUrPN1QeWFRTyqYdCZAljFlPoD
	3ZtoiKHDqP547n/CnWQ5EKhNuETVHdhdiYOfUPNJIsWnU0AMemuPmf+F/sn8=
X-Received: by 2002:a05:600c:1c8a:b0:414:ff4:5957 with SMTP id k10-20020a05600c1c8a00b004140ff45957mr476454wms.5.1712300972204;
        Fri, 05 Apr 2024 00:09:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMRNTzpxyLjqqIYDr2QKngW3j1H6NrSOhPdqHJ7NeqOLqDxzD+y6/Jjotboqeo5fV1ubw0rw==
X-Received: by 2002:a05:600c:1c8a:b0:414:ff4:5957 with SMTP id k10-20020a05600c1c8a00b004140ff45957mr476439wms.5.1712300971838;
        Fri, 05 Apr 2024 00:09:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1? (p200300cbc74b5500e1f8a3108fa34ec1.dip0.t-ipconnect.de. [2003:cb:c74b:5500:e1f8:a310:8fa3:4ec1])
        by smtp.gmail.com with ESMTPSA id h12-20020adfa4cc000000b00343668bc492sm1272710wrb.71.2024.04.05.00.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 00:09:31 -0700 (PDT)
Message-ID: <67557c5b-afd8-4578-a00d-6750accc1026@redhat.com>
Date: Fri, 5 Apr 2024 09:09:30 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] s390/uv: convert gmap_make_secure() to work on
 folios
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
 <20240404163642.1125529-3-david@redhat.com>
 <Zg9wNKTu4JxGXrHs@casper.infradead.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zg9wNKTu4JxGXrHs@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.04.24 05:29, Matthew Wilcox wrote:
> On Thu, Apr 04, 2024 at 06:36:39PM +0200, David Hildenbrand wrote:
>> +		/* We might get PTE-mapped large folios; split them first. */
>> +		if (folio_test_large(folio)) {
>> +			rc = -E2BIG;
> 
> We agree to this point.  I just turned this into -EINVAL.
> 
>>   
>> +	if (rc == -E2BIG) {
>> +		/*
>> +		 * Splitting might fail with -EBUSY due to unexpected folio
>> +		 * references, just like make_folio_secure(). So handle it
>> +		 * ahead of time without the PTL being held.
>> +		 */
>> +		folio_lock(folio);
>> +		rc = split_folio(folio);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +	}
> 
> Ummm ... if split_folio() succeeds, aren't we going to return 0 from
> this function, which will be interpreted as make_folio_secure() having
> succeeded?

I assume the code would have to handle that, because it must deal with 
possible races that would try to convert the folio page.

But the right thing to do is

if (!rc)
	goto again;

after the put.

-- 
Cheers,

David / dhildenb


