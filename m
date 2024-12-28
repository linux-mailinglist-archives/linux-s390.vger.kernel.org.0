Return-Path: <linux-s390+bounces-7889-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858FF9FD93B
	for <lists+linux-s390@lfdr.de>; Sat, 28 Dec 2024 07:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE7C162B08
	for <lists+linux-s390@lfdr.de>; Sat, 28 Dec 2024 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0970813;
	Sat, 28 Dec 2024 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c1VsAsQx"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB307524B0
	for <linux-s390@vger.kernel.org>; Sat, 28 Dec 2024 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735367795; cv=none; b=pkX+2Q1o/4HaYvVlI97WfxQpmpBaBPZRGAE9jKpj3Kgr2dDwPKQBe3AFJIo2ibgSljpbmMyRWyTA14F2SY/ZGhWg6u4CP6/OZVdTK7RKiWctO2HSUTgOsv2HPm1DaHtqo84DFEIVqbspCUl9XQku4QAdO2aFJ1Vc6VpOcbm/MFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735367795; c=relaxed/simple;
	bh=AnI+fDx8ege81551sFiwVqsAGZfaOg5IleFmbT3lTrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGHXOfKd1fc3DF3I6U6QKvW06vmPgZ+yHAogigexWiYs9sEZ55yzqkbw2z9qvoPtT6oILXTOPZbrylv12HIq2mIL4k64ecyBupSfCQFRH17wZHfYcKB0w3pPfoN004zgMJo80iiFfN8q36n/ApYH60TRwPC+qfYLId0EiBBokjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c1VsAsQx; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-218c8aca5f1so117097485ad.0
        for <linux-s390@vger.kernel.org>; Fri, 27 Dec 2024 22:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735367791; x=1735972591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9+aZKFL34BZ+QKJapn5mhTQ8zZC8UnFG8XP+zHLMo=;
        b=c1VsAsQxxYafqX4QhvhVwPbFl+C/B/yYf9xtjlaS9oIZVrjGx1a1j/7KXH00dYveH9
         kvNmW7VyvG9Vq3Wb5z7g/mZfsPR3363WfRVfJc69MDc9KSZw4kBp2SOTh9oTWszWY3Sr
         q0EtyVlloi7rjiZpF86BnI0d3jhHHDNHOBFIM1mNY+7nLzkFWjuZnuTlMCT46aCfYHvW
         8XeKY9H6k8pry6ZgrHqFiUDdX7hsgsrxxHU/hOWmYGo4/eFq67OrCGNFOho3nG/PrKDo
         HFdLa0RMlfKxPeD/tena4kjS4MmTV086fr/X8pIoisjj5+bFGx33XvT1FUrUCg7U6jlg
         Vv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735367791; x=1735972591;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9+aZKFL34BZ+QKJapn5mhTQ8zZC8UnFG8XP+zHLMo=;
        b=KFGuPWcw/MCD9c1H4PtfnUEJrshJtd/gIhf/qxDyssd+IHQExbbzlCrkYq2ZZJc4+5
         jgpevu2Xesq22MU0jCbkuZI5ZwS9lNsgvBoE4ulpQI7IdlpaPRqN5nbojjETSWWrBDN0
         lM0wSvoZzwqUvLqbMU0cV0RXTRN8c2/l+1d+NWunm8l503VDpvYNepOyJUzwfquu1PT8
         eqkZeFsWjgQy7JI+vFKFUsUaZ6Jlgz8TdICF5dmb9DzXYPvp7Z2QvJEcOq+b1cZv2NJe
         X/AcunTFLliddFdrL6ximjshyfH9pKaBdvUnBH/xosXt6s3JFAY+HMC089kAkf4tC/qC
         cmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfWbnsdJdog69qdufLNNFpB8c5RCvjNgJIyQZunwG1kmiPFipD+nI14O6j+mNeb0b06JfwI9tkU7iL@vger.kernel.org
X-Gm-Message-State: AOJu0YyM/CcAgoAoYc72DPdDXwxCEj0TIMPDnXIdRzvdLwfafIY8TN/3
	TAZQR906RScrdRGfVoXFrVxOQFIV4EN27C6R7YhZpPZVc1dhCQ2+e59rvdG6sio=
X-Gm-Gg: ASbGncv7O2qT3bEdjN73KF+0Ew4yUPmu3FbBDY/2st1Wxy2CFLnc0behBXtjNLdPcUS
	xl5tZpmSmENDNdVw4vJHguQpeSrFcmnX8xwoUjtruYjiUo3hUIQSMeUZXrA8bPgG+C8kbaXBYgy
	AleEiYWEC5v3mwwG6lU9qXqXs0yTlU72SnFQaaxEGsHxLaaRUVrehdn0vKhFUBkACI7tNEVEhvu
	60lcebwpgboov2Ezz2nqFIK50jaYmrJ7bszKr0RpE1ws2+qJ1oLswdZ3qbfO/TlKArL1GmzYVJs
	exASIg2aZPyF2uSgegF/Lgy1vx3kHzeFVKrIgtV+r7ktnPouVHR3daE=
X-Google-Smtp-Source: AGHT+IHJr5/cBm7VE4sKmfeyqyU+nR3KXMBrwpgTBQUiz/94ds3IGaVh/bhouU9p0WQ7mj1Jxu9Qtg==
X-Received: by 2002:a17:902:f682:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-219e6f1480cmr399252455ad.41.1735367791634;
        Fri, 27 Dec 2024 22:36:31 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d7c4:e49d:ee0a:5f86:d7bd? ([2409:8a28:f44:d7c4:e49d:ee0a:5f86:d7bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc97182dsm144536075ad.82.2024.12.27.22.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 22:36:31 -0800 (PST)
Message-ID: <2434dfdf-d4a0-4f81-9b65-51be86487fd2@bytedance.com>
Date: Sat, 28 Dec 2024 14:36:06 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/17] riscv: mm: Skip pgtable level check in
 {pud,p4d}_alloc_one
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
From: Qi Zheng <zhengqi.arch@bytedance.com>
Content-Language: en-US
In-Reply-To: <mhng-3d6d3e65-b264-4033-b985-fa7763cacf9e@palmer-ri-x1c9a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Palmer,

On 2024/12/28 00:40, Palmer Dabbelt wrote:
> On Mon, 23 Dec 2024 01:40:48 PST (-0800), zhengqi.arch@bytedance.com wrote:
>> From: Kevin Brodsky <kevin.brodsky@arm.com>
>>
>> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
>> table level is folded, as {pmd,pud,p4d}_alloc() already does the
>> required check. We can therefore remove the runtime page table level
>> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
>> the generic version, so we remove it altogether.
>>
>> This is consistent with the way arm64 and x86 handle this situation
>> (runtime check in p4d_free() only).
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>  arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>>  1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgalloc.h 
>> b/arch/riscv/include/asm/pgalloc.h
>> index f52264304f772..8ad0bbe838a24 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -12,7 +12,6 @@
>>  #include <asm/tlb.h>
>>
>>  #ifdef CONFIG_MMU
>> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>>  #define __HAVE_ARCH_PUD_FREE
>>  #include <asm-generic/pgalloc.h>
>>
>> @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct 
>> mm_struct *mm, pgd_t *pgd,
>>      }
>>  }
>>
>> -#define pud_alloc_one pud_alloc_one
>> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned 
>> long addr)
>> -{
>> -    if (pgtable_l4_enabled)
>> -        return __pud_alloc_one(mm, addr);
>> -
>> -    return NULL;
>> -}
>> -
>>  #define pud_free pud_free
>>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>>  {
>> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct 
>> mmu_gather *tlb, pud_t *pud,
>>  #define p4d_alloc_one p4d_alloc_one
>>  static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned 
>> long addr)
>>  {
>> -    if (pgtable_l5_enabled) {
>> -        gfp_t gfp = GFP_PGTABLE_USER;
>> -
>> -        if (mm == &init_mm)
>> -            gfp = GFP_PGTABLE_KERNEL;
>> -        return (p4d_t *)get_zeroed_page(gfp);
>> -    }
>> +    gfp_t gfp = GFP_PGTABLE_USER;
>>
>> -    return NULL;
>> +    if (mm == &init_mm)
>> +        gfp = GFP_PGTABLE_KERNEL;
>> +    return (p4d_t *)get_zeroed_page(gfp);
>>  }
>>
>>  static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

Thank you for reviewing the patch!

> 
> Are you trying to keep these together, or do you want me to try and pick 
> up the RISC-V bits on their own?

I prefer to keep them together because later patches depend on this one.
And this patch series has been merged into mm-unstable branch.

Thanks!


