Return-Path: <linux-s390+bounces-13973-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF29BE95B4
	for <lists+linux-s390@lfdr.de>; Fri, 17 Oct 2025 16:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7BF188B7DA
	for <lists+linux-s390@lfdr.de>; Fri, 17 Oct 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D546337108;
	Fri, 17 Oct 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dXtEyu6v"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1A3370FE
	for <linux-s390@vger.kernel.org>; Fri, 17 Oct 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712858; cv=none; b=rRrjS35bqQX4fs+2Z98xfs5T4bFNtpa3MIddvtEp0wBgILu2fcyPal8C5VukSspBMTdh00bZaVKZYIMCg1yZKjb5S8dDl4pK8Zms/3vNAqq5z+IJRwZ6+HEb1aAZ7IBz0nxdz2Z8i/7zmhGx7MglTo/fgnDVerGpG6rBTZZR8+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712858; c=relaxed/simple;
	bh=ODoMSp+xvQn4/jR2mgceN3qvccWf2toY9+KFUZPJbUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaH1HAF2JTJLDGbBoqxY1K4BeKQQ/UZ3GQgkauorC6LNK7z4wWWudfPz3ddrmvj25VbOCBsMFmnsYoHeHW5/ouvpXCd8uRrP7js5c0MjFZWxcPtEHt+DkXL2yvm2X/VrWgZ7WqtiL54TTyhncW40XGjUUsxch/rnDLCOGeQ57PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dXtEyu6v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760712855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KVg3pi7NpQHtM6ZoxI30PgKBLj0yHkiDuj7fimQcvas=;
	b=dXtEyu6vp5Nsi2eSfm1wHHtsPoExkT+aQQsTTubCoWJ6ZSW/H06MlowI5MDdfYc49WuWom
	TzSPLb8H45ZAgtBaQyCxao5szVbz0btBA7YHGCiBs0VigDUVnHmbqNeohTGyc+5DmhjfyC
	WG4TPsLQIDTOrrjCoiNACU9h1RmfafE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-iYNjzjQWOZCQ1kUVnq1kVA-1; Fri, 17 Oct 2025 10:54:14 -0400
X-MC-Unique: iYNjzjQWOZCQ1kUVnq1kVA-1
X-Mimecast-MFC-AGG-ID: iYNjzjQWOZCQ1kUVnq1kVA_1760712853
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47108163eeaso10939875e9.3
        for <linux-s390@vger.kernel.org>; Fri, 17 Oct 2025 07:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760712853; x=1761317653;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVg3pi7NpQHtM6ZoxI30PgKBLj0yHkiDuj7fimQcvas=;
        b=ARUwbUJFcZEQwZQgc8d2GI9Pnihx5MSe+v8HOlVfOsXhQz2ewNyhFrmF54sGzQVecM
         avdjtAgqzefPUsXsOogz6yeWATfxHVi+jCQb038hgwbJffvKHfEjWwLMGhSj50Ni+yR5
         9pIqMECk0SvS5RhOgTqRPujWvDJbqNt/6csHn0X0QKoNg6FNEh+8KYmBxrvV22uzUh/A
         XuOVvpQizFUyiSkIrb+ZJ75/GSQlldCpR5Rk6IrYeFhRz2xLe5HRlRNTt1oBOImBGfig
         DLU8wGSvFHZIfUY0Mv3vJOrihuCRsC91Su5uPSuYg9agNZOSEHKsbcFjfikotjCZhXP9
         EIWw==
X-Forwarded-Encrypted: i=1; AJvYcCWvV5t5Ik8dzaz5sg9b3f82I7j2oS5t0BD/eURjbaiKwpyzJ6qgS0YbTy3kPNy6cVgjc/smHvsIueyT@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9jfcS87b2q/UchyMnrdDNWY2HWSxtFIlhTaW9+7xbLdr0yoi
	36giWU7da3NrR3xmE+2ctrK4v8AzBm22+Md/5UhngZTRynd4DAiXn9TP7JrFXKtFjByDpkIZYqc
	HsG+roP1WHZQuFYg1YYhbHXRYPI6RXE8J693va15qSItYtL0IpOSDag/PJdVKDu8=
X-Gm-Gg: ASbGncsrTBhvzQOVkZX1w1QIiUxehqXLMIoHzIAf10PNYjIINmue5xftOAvdI+SPo5P
	5wf3/npGnucwZFvg5kA3FUCHDostBwpC/ke0Qqoo2hJibbswxUn1zz40c65GB2uKyAl4NARSbnf
	axgaVk2mQgdnI5CdipfBRDCRf0CgDozgTDIu1hyAPWZkw12YJYPDlvVBPtTL2zQ8aVQNkge2b63
	1peJ6gkI6tBHFkL/1K8792iV2U0H16e0RDPdshPkBYDtcaTxHuS8XFZXseHU9nYVK4VA8/zAJEO
	T7fIc0nco9JbBSIT/3Z1RzgB+Vf0iAYN8pFbkEpFl4BZ6s62/VsfR/63DJOSJUhFZ9e448wboLc
	tUm5QaBytMW/72VuYV+a3+7TI+wiExZxd0b9WfSUIFx2JQGEi+hLY3T4RDd3osdgxhlKhDPvUeC
	4tEfwEUKb3zFLqZIoE/jYG/Y6O/hM=
X-Received: by 2002:a05:600c:1d9b:b0:46e:4f25:aace with SMTP id 5b1f17b1804b1-4711787604fmr35583365e9.6.1760712853314;
        Fri, 17 Oct 2025 07:54:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY2i/XrXLNkdMltGFV0J0tBrRne+zVRBnrRcoyDQuxJFLmGYGJuLXfF8xyMKL8G2V4YC2CkQ==
X-Received: by 2002:a05:600c:1d9b:b0:46e:4f25:aace with SMTP id 5b1f17b1804b1-4711787604fmr35583205e9.6.1760712852931;
        Fri, 17 Oct 2025 07:54:12 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4711441f975sm87898455e9.4.2025.10.17.07.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 07:54:12 -0700 (PDT)
Message-ID: <9beff9d6-47c7-4a65-b320-43efd1e12687@redhat.com>
Date: Fri, 17 Oct 2025 16:54:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: KVM/s390x regression
To: Christian Borntraeger <borntraeger@linux.ibm.com>, balbirs@nvidia.com
Cc: Liam.Howlett@oracle.com, airlied@gmail.com, akpm@linux-foundation.org,
 apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 byungchul@sk.com, dakr@kernel.org, dev.jain@arm.com,
 dri-devel@lists.freedesktop.org, francois.dugast@intel.com,
 gourry@gourry.net, joshua.hahnjy@gmail.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, lyude@redhat.com,
 matthew.brost@intel.com, mpenttil@redhat.com, npache@redhat.com,
 osalvador@suse.de, rakie.kim@sk.com, rcampbell@nvidia.com,
 ryan.roberts@arm.com, simona@ffwll.ch, ying.huang@linux.alibaba.com,
 ziy@nvidia.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-next@vger.kernel.org
References: <20251001065707.920170-4-balbirs@nvidia.com>
 <20251017144924.10034-1-borntraeger@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251017144924.10034-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.10.25 16:49, Christian Borntraeger wrote:
> This patch triggers a regression for s390x kvm as qemu guests can no longer start
> 
> error: kvm run failed Cannot allocate memory
> PSW=mask 0000000180000000 addr 000000007fd00600
> R00=0000000000000000 R01=0000000000000000 R02=0000000000000000 R03=0000000000000000
> R04=0000000000000000 R05=0000000000000000 R06=0000000000000000 R07=0000000000000000
> R08=0000000000000000 R09=0000000000000000 R10=0000000000000000 R11=0000000000000000
> R12=0000000000000000 R13=0000000000000000 R14=0000000000000000 R15=0000000000000000
> C00=00000000000000e0 C01=0000000000000000 C02=0000000000000000 C03=0000000000000000
> C04=0000000000000000 C05=0000000000000000 C06=0000000000000000 C07=0000000000000000
> C08=0000000000000000 C09=0000000000000000 C10=0000000000000000 C11=0000000000000000
> C12=0000000000000000 C13=0000000000000000 C14=00000000c2000000 C15=0000000000000000
> 
> KVM on s390x does not use THP so far, will investigate. Does anyone have a quick idea?

Only when running KVM guests and apart from that everything else seems 
to be fine?

That's weird :)

-- 
Cheers

David / dhildenb


