Return-Path: <linux-s390+bounces-3176-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D7289F254
	for <lists+linux-s390@lfdr.de>; Wed, 10 Apr 2024 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 956EB1C20C2B
	for <lists+linux-s390@lfdr.de>; Wed, 10 Apr 2024 12:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388FE2BAFC;
	Wed, 10 Apr 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HrOLe9+q"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A92BAEC
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 12:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752483; cv=none; b=ma7ME7f7JZLijq+pa75BHsD64ACJ9LSH2yulwrqk0AfNCH8Ahf1s3zqzCF3MGVJ+Rmln9yaX6bHANrurPIOJa0n138sog9yp6aeQ3M2Ya9fDy2yVbWC6lMdsvBgN7Y85yISqOH5CG+GLQ8SAxkzwrw0beHD4aB83U3iNlu/1xQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752483; c=relaxed/simple;
	bh=pkstAhEZCvjIMm3/KfVddEa0JmzJ8EuXOJY+A9bV6Pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hb39OEbW9+yTDxptG5qoK/u4kXCzVdOrgc2YTRcA9QxdTbQoU4q+uCtR6sWij5k4JvIMLuWkek8X9qwJ0GUtFBK3pRIuTJct99ym5WBSlrNKI9xZkQNhZ0uLZRfJKA1oj0WdduHJ3lQjKTQ/c0apgqCSDZ/pr3GM97mGWguxm74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HrOLe9+q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712752480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SGeEQTYX/N6LJYhZCdDmcWoBaL25Lib85+jnSFUMr0o=;
	b=HrOLe9+qy/uR0mN75ujQ7l1wb4A5HaMxamhn9dUwFwis+UFyUwFm+CSRWdGwXxXTajRkOW
	j29cVJnPkoc9FOr2RlPp6nnf1rxz6nVPcN+KJhVUUlt1VTZOJZ41KE6tIiRDN3FyyK7mgG
	BcslFmaCZzFwryla73OXtKn8swHyi2g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-pdly9kVqNt-NBUzlTm00Zg-1; Wed, 10 Apr 2024 08:34:39 -0400
X-MC-Unique: pdly9kVqNt-NBUzlTm00Zg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516c2460e71so5904515e87.0
        for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 05:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752477; x=1713357277;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SGeEQTYX/N6LJYhZCdDmcWoBaL25Lib85+jnSFUMr0o=;
        b=G2X3HD94AYoo9wytAMwB/5U6U7bYexhp9p8SO28jAVc3/yYoLgMvTOTATKJbJOoDLE
         LI+Y4xWs/SCNQyIew75WBF5FtdRigYO95IEbUMdNQG7PN77Pr/S/dNCX186PzBz29N+h
         3ncjDqNJoZd0BH0sb4C67fRQVnI6gG61lD/wqeogRaUWGUXSNaI1ud8m55jHHFPGi7el
         Z13PFQKiLpUfZvPjCPPQOKO16IrniLsa5SlnZSvNA1iktUeKQs09iF5+6w1ACWi0g7Xq
         KGpHRKfG8+z9OuBiEHvNPM88efwEZt50SMAtunrihYCh5AgL91vYylmo10WOiFdIoD3n
         Mbbg==
X-Forwarded-Encrypted: i=1; AJvYcCUIRcBWIdTJ0mKg6qqONBK1rXy4NAna8liQ2VRutU2zFsOpycv5ek9lA7hXq8w6ohTm4HcazwGId/P3gSHm0TDmragnopvG9HevrA==
X-Gm-Message-State: AOJu0YzbLZmOhdQGFVkNFkikLMQoHFfpSGPJ2jsWb3k42yqc8I+wmFz6
	SyfhFBsTUe/ulwlmifL1Weu2ZmkhJeKYOSY4apL5M0JmVvLhL8gNPDqAQ+J7hDWsgSd1BNdSH9H
	/hCHxQ4+6V5eVO1FxW90kmQryuSyJHeWT6N+tDXjmCXy6z5/BI0DYlDTdmKf8MjHM6/U=
X-Received: by 2002:a05:6512:1249:b0:516:a302:f29c with SMTP id fb9-20020a056512124900b00516a302f29cmr2497240lfb.55.1712752477515;
        Wed, 10 Apr 2024 05:34:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdIoQWgnS6VH8XnM/nKKzpVauhZ/seIZDhMORj8oKiPpegF33cCQt2WaXIAM0gbW4TLiGR9g==
X-Received: by 2002:a05:6512:1249:b0:516:a302:f29c with SMTP id fb9-20020a056512124900b00516a302f29cmr2497221lfb.55.1712752477099;
        Wed, 10 Apr 2024 05:34:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id d11-20020adff84b000000b0033e7a102cfesm13679872wrq.64.2024.04.10.05.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:34:36 -0700 (PDT)
Message-ID: <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
Date: Wed, 10 Apr 2024 14:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent
 hugepages
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org
Cc: hughd@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, iii@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.24 17:54, Sumanth Korikkar wrote:
> In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
> compiler might choose to make a regular function call (out-of-line) for
> shmem_is_huge() instead of inlining it. When transparent hugepages are
> disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
> error.
> 
> mm/shmem.c: In function ‘shmem_getattr’:
> ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
>    383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>        |                           ^~~~~~~~~
> mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>   1148 |                 stat->blksize = HPAGE_PMD_SIZE;
> 
> To prevent the possible error, always inline shmem_is_huge() when
> transparent hugepages are disabled.
> 

Do you know which commit introduced that?

-- 
Cheers,

David / dhildenb


