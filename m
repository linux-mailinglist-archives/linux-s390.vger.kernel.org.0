Return-Path: <linux-s390+bounces-10682-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0CFABCEB3
	for <lists+linux-s390@lfdr.de>; Tue, 20 May 2025 07:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006C34A06C8
	for <lists+linux-s390@lfdr.de>; Tue, 20 May 2025 05:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE3725A645;
	Tue, 20 May 2025 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inDgpo8v"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4439E2550A6
	for <linux-s390@vger.kernel.org>; Tue, 20 May 2025 05:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747719674; cv=none; b=k2VlqSD5ZepLbR0XHRwtUG7eHl+3vbzVIjqxb5BezvmaUtyanr936tR3Qbi9zJcyAbXYy6Mgvq0UkgcZZl1gFipfjQIsBk+TKqbC5yf0VswHsRVh9x8WvlhSotnSF9Zb0yv/qu7wsUjDT91vwlswbxGdU9lkYDzCbKO40XkEUBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747719674; c=relaxed/simple;
	bh=WyWlqnS7MYr2qEx+FkVsXEFiqGDvYUOxuHq29eKdl5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JRHfI2z4Cg9WG49slLHNUEiiiRAXzIAG6p7ZPLWTrIAQFrOeYkubi3cmZsXWC+mZuD+4BShNB/VCG/Keeg5x5WskOb8n8fYIKbMPEVvxD9b7uNn9plNnoW0D3KgNqd3of8jg8rASnL8HnHwMsY0tF7W8naPXNe9UjgSvTRx1ZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inDgpo8v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747719671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GSDjHjiyG4ta8/DF1rRY8RLjHpjIX3oj5thps18bh7c=;
	b=inDgpo8vVf7kaxyaBmB+LBHZ70s6KD64/YDAfWazP+h7oIHePgDLeD8DeyTaLQSAcd917o
	TPjnO+8fnBTzTbPvMfGS5eOfl6Q7jtg4ycaa90OE3myDSTLF88JZfWxsCffEymhPAV0CKk
	7iuIotELhCjXhFdPzGtHtLQ03QbI46g=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-gy424JGKM9GrOPvSjnMB8A-1; Tue, 20 May 2025 01:41:09 -0400
X-MC-Unique: gy424JGKM9GrOPvSjnMB8A-1
X-Mimecast-MFC-AGG-ID: gy424JGKM9GrOPvSjnMB8A_1747719668
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a367b3bb78so1681788f8f.1
        for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 22:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747719668; x=1748324468;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GSDjHjiyG4ta8/DF1rRY8RLjHpjIX3oj5thps18bh7c=;
        b=V0SOZ5mgrJ8hhgjbidSwr8FG5rQnU6b6cujiEPVI9tRKz09gHM7SkOe+8NRlsXm9Sq
         8kFW+ZwL/ZnqkZKzh+a5NNba+K0LN3zuPl78RoKNy28X9YGXKdugJxdc1S2dKxxxdESj
         3gXV7a/+YRhd0yYQ0LIOxuPDRxrK86D3RdgJJwWTd0yRmRZt6hKqy2IgyYqzdL9pvZBJ
         QJnNfp5a4nGwGkEbQdRmddYDHq4/o49ibiFwOIp+LuEiQzEdRUiGiGOThMNgsKPQhzZ9
         U/svhhWBeiy2JfKk7/hBUSzAEMcUuDAPOAbv1DWIBjAMFum3sYT1FajvR6rjGWvPGQJ1
         IzPw==
X-Gm-Message-State: AOJu0Yz76bRw2KNQg11G2qMPqRPdlHEc/gKF9POjRagqpeEqhLtLQL+y
	YlTTtbzG16suS2arBhnDrYkNxT5llG5kDxl7p6K6N9hzMwKVykG27c2+OGeWeRIp+7cYINWBuHh
	FX/GvRQ0pM+PMACgOL0K9+AZkd0MWmEXlKrNiy0WHa2/glzMZ1NrHfFADRoylLPQ=
X-Gm-Gg: ASbGncsvxWAEH789a3h7U7iK5epQB6lOS9C0wwmVL5SylozJPNiAdIfx9geA9eSkUyh
	WiSC1tVYXHfnHi8yLqQV7umLUCditWlaMGSxgJ8h7CQWD0M9fhjSAqKgL0I9NpuRx8oefBR/5b+
	Yflhp8Lt0YPiylwfbUrnFsqd9VshHxN4KXabVxjPldQt5svSy4zYKAG5i5C95e1f4mQ4PPY5wk+
	gRPzbAa9kZ4GUrSdVZ35AxmTzn/1kbo/ACE+rH55xAJ7orsLAzC2K8k8EID6GPpvwr7d839T09t
	kR1trtsG/uUT7dT9I0Xe2pq2wOTX1Lpjga6P50MfPXU=
X-Received: by 2002:a05:6000:2285:b0:3a3:68c7:e473 with SMTP id ffacd0b85a97d-3a368c7e5ffmr8209955f8f.25.1747719668460;
        Mon, 19 May 2025 22:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuycopOJusc8rTS60UM5x4PeNiP+r3U47qLyI54tDLex8IQxQ5RKBFVz3uxVnyO2oeQQ89pA==
X-Received: by 2002:a05:6000:2285:b0:3a3:68c7:e473 with SMTP id ffacd0b85a97d-3a368c7e5ffmr8209935f8f.25.1747719668104;
        Mon, 19 May 2025 22:41:08 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de. [109.42.49.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88899sm14911875f8f.80.2025.05.19.22.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 22:41:07 -0700 (PDT)
Message-ID: <e5f67090-07a4-4818-b83e-33386313b2af@redhat.com>
Date: Tue, 20 May 2025 07:41:06 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: s390: Always allocate esca_block
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20250519-rm-bsca-v2-0-e3ea53dd0394@linux.ibm.com>
 <20250519-rm-bsca-v2-2-e3ea53dd0394@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250519-rm-bsca-v2-2-e3ea53dd0394@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2025 13.36, Christoph Schlameuss wrote:
> Instead of allocating a BSCA and upgrading it for PV or when adding the
> 65th cpu we can always use the ESCA.
> 
> The only downside of the change is that we will always allocate 4 pages
> for a 248 cpu ESCA instead of a single page for the BSCA per VM.
> In return we can delete a bunch of checks and special handling depending
> on the SCA type as well as the whole BSCA to ESCA conversion.
> 
> As a fallback we can still run without SCA entries when the SIGP
> interpretation facility or ESCA are not available.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/include/asm/kvm_host.h |   1 -
>   arch/s390/kvm/interrupt.c        |  67 ++++-------------
>   arch/s390/kvm/kvm-s390.c         | 159 ++++++---------------------------------
>   arch/s390/kvm/kvm-s390.h         |   4 +-
>   4 files changed, 42 insertions(+), 189 deletions(-)

Could you now also remove struct bsca_block from the kvm_host_types.h header?

...
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 8d3bbb2dd8d27802bbde2a7bd1378033ad614b8e..2c8e177e4af8f2dab07fd42a904cefdea80f6855 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -531,7 +531,7 @@ int kvm_s390_handle_per_event(struct kvm_vcpu *vcpu);
>   /* support for Basic/Extended SCA handling */
>   static inline union ipte_control *kvm_s390_get_ipte_control(struct kvm *kvm)
>   {
> -	struct bsca_block *sca = kvm->arch.sca; /* SCA version doesn't matter */
> +	struct esca_block *sca = kvm->arch.sca; /* SCA version doesn't matter */

You might want to adjust/remove the comment here now.

  Thomas



>   	return &sca->ipte_control;
>   }
> @@ -542,7 +542,7 @@ static inline int kvm_s390_use_sca_entries(void)
>   	 * might use the entries. By not setting the entries and keeping them
>   	 * invalid, hardware will not access them but intercept.
>   	 */
> -	return sclp.has_sigpif;
> +	return sclp.has_sigpif && sclp.has_esca;
>   }
>   void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>   				     struct mcck_volatile_info *mcck_info);
> 


