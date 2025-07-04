Return-Path: <linux-s390+bounces-11428-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87842AEF58F
	for <lists+linux-s390@lfdr.de>; Tue,  1 Jul 2025 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C485189ACC5
	for <lists+linux-s390@lfdr.de>; Tue,  1 Jul 2025 10:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F727055F;
	Tue,  1 Jul 2025 10:50:37 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B0D25A33A;
	Tue,  1 Jul 2025 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751367036; cv=none; b=CPBe5/uVt8zRCK4SYVCuzGj487Zri8fkCggW6lmm3X6g2t/3qfblywPpt1smg2/KQbBWyvjJabLYtQru3p9mqCsskpT4zGqKcB9Gf3d13qfISWwh4cWnUQL5ZDlrwgc8iryCuxIGvpQ8HiIoUy6znOfexJrKwqPP0nvthnS+zeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751367036; c=relaxed/simple;
	bh=dC03Wr2epn0tjtzSfWllZBSz+buautvqb5O84U1mUYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZE4ariFBM4nQnEDOuXZtkLTop1Xdf6ats9ScbdsOuoQUFMqKCEHpHfCxgOsQyd8F7WXeyl9cK9sad+78JjNNVE8tPFRRj6RJQ+kF8KeoJpb2t0ltyAOwIQxJ6sTBapMVuJH0C1SPFGcFcWFHvmq+OzgsqLYc2otbi5PNFeGNaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bWfLR38KFz9v2F;
	Tue,  1 Jul 2025 12:25:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z68QA4lT7SRl; Tue,  1 Jul 2025 12:25:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bWfLR2Dvnz9sVS;
	Tue,  1 Jul 2025 12:25:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 45D468B765;
	Tue,  1 Jul 2025 12:25:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id CqjVOU_qZS7L; Tue,  1 Jul 2025 12:25:35 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C5E958B763;
	Tue,  1 Jul 2025 12:25:32 +0200 (CEST)
Message-ID: <0400f0be-6b63-4bc7-846e-8852e1d01485@csgroup.eu>
Date: Tue, 1 Jul 2025 12:25:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] kasan: unify kasan_arch_is_ready with
 kasan_enabled
To: Heiko Carstens <hca@linux.ibm.com>,
 Andrey Konovalov <andreyknvl@gmail.com>
Cc: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, vincenzo.frascino@arm.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 richard@nod.at, anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
 akpm@linux-foundation.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 arnd@arndb.de, rppt@kernel.org, geert@linux-m68k.org, mcgrof@kernel.org,
 guoweikang.kernel@gmail.com, tiwei.btw@antgroup.com, kevin.brodsky@arm.com,
 benjamin.berg@intel.com, kasan-dev@googlegroups.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-um@lists.infradead.org, linux-mm@kvack.org, llvm@lists.linux.dev
References: <20250626153147.145312-1-snovitoll@gmail.com>
 <CA+fCnZfAtKWx=+to=XQBREhou=Snb0Yms4D8GNGaxE+BQUYm4A@mail.gmail.com>
 <CACzwLxgsVkn98VDPpmm7pKcbvu87UBwPgYJmLfKixu4-x+yjSA@mail.gmail.com>
 <CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com>
 <20250701101537.10162Aa0-hca@linux.ibm.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250701101537.10162Aa0-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 01/07/2025 à 12:15, Heiko Carstens a écrit :
>>>> Another thing that needs careful consideration is whether it's
>>>> possible to combine kasan_arch_is_ready() and kasan_enabled() into the
>>>> same check logically at all. There's one issue mentioned in [1]:
>>>
>>> Hello,
>>> I've removed kasan_arch_is_ready() at all in this series:
>>> [PATCH v2 11/11] kasan: replace kasan_arch_is_ready with kasan_enabled
>>>
>>> Is it not what's expected by unification?
>>
>> I guess the issue description diverged a bit from what needs to be
>> done, sorry about that.
>>
>> The core 2 things I wanted to address with the unification are:
>>
>> 1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
>> implementation and move these checks into include/linux/kasan.h (and
>> add __wrappers when required).
>>
>> 2. Avoid architectures redefining the same kasan_enabled global
>> variable/static key.
>>
>> Initially, I thought that s/kasan_arch_is_ready/kasan_enabled + simply
>> moving the calls into affected include/linux/kasan.h functions would
>> be enough. But then, based on [1], turns out it's not that simple.
>>
>> So now, I think we likely still need two separate checks/flags:
>> kasan_enabled() that controls whether KASAN is enabled at all and
>> kasan_arch_is_ready() that gets turned on by kasan_init() when shadow
>> is initialized (should we rename it to kasan_shadow_initialized()?).
>> But then we can still move kasan_arch_is_ready() into
>> include/linux/kasan.h and use the proper combination of checks for
>> each affected function before calling __wrappers. And we can still
>> remove the duplicated flags/keys code from the arch code.
> 
> FWIW, as Alexander Gordeev already mentioned: this series breaks s390,
> since the static_branch_enable() call in kasan_init_generic() is now
> called way too early, and it isn't necessary at all. Which, as far as
> I understand, may be the case for other architectures as well. s390
> sets up the required KASAN mappings in the decompressor and can start
> with KASAN enabled nearly from the beginning.
> 
> So something like below on top of this series would address
> that. Given that this series is about to be reworked this is just for
> illustration :)

I had the same kind of comment on powerpc/32. Allthough this series work 
on powerpc32 as is, it is overkill because it adds code and data for 
static branches for no real benefit.

Your patch below is simpler than what I proposed, but it keeps the 
static branches so the overhead remains.

I also proposed a change, it goes further by removing the static branch 
for architectures that don't need it, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/cover/20250626153147.145312-1-snovitoll@gmail.com/#3537388 
. Feedback welcome.

Christophe

> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 0c16dc443e2f..c2f51ac39a91 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -172,6 +172,7 @@ config S390
>   	select HAVE_ARCH_JUMP_LABEL
>   	select HAVE_ARCH_JUMP_LABEL_RELATIVE
>   	select HAVE_ARCH_KASAN
> +	select HAVE_ARCH_KASAN_EARLY
>   	select HAVE_ARCH_KASAN_VMALLOC
>   	select HAVE_ARCH_KCSAN
>   	select HAVE_ARCH_KMSAN
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 2436eb45cfee..049270a2269f 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -10,7 +10,11 @@
>    * Global runtime flag. Starts ‘false’; switched to ‘true’ by
>    * the appropriate kasan_init_*() once KASAN is fully initialized.
>    */
> +#ifdef CONFIG_HAVE_ARCH_KASAN_EARLY
> +DECLARE_STATIC_KEY_TRUE(kasan_flag_enabled);
> +#else
>   DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +#endif
>   
>   static __always_inline bool kasan_enabled(void)
>   {
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index f82889a830fa..1407374e83b9 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -4,6 +4,13 @@
>   config HAVE_ARCH_KASAN
>   	bool
>   
> +config HAVE_ARCH_KASAN_EARLY
> +	bool
> +	help
> +	  Architectures should select this if KASAN mappings are setup in
> +	  the decompressor and when the kernel can run very early with
> +	  KASAN enabled.
> +
>   config HAVE_ARCH_KASAN_SW_TAGS
>   	bool
>   
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 0f3648335a6b..2aae0ce659b4 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -36,7 +36,11 @@
>    * Definition of the unified static key declared in kasan-enabled.h.
>    * This provides consistent runtime enable/disable across all KASAN modes.
>    */
> +#ifdef CONFIG_HAVE_ARCH_KASAN_EARLY
> +DEFINE_STATIC_KEY_TRUE(kasan_flag_enabled);
> +#else
>   DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +#endif
>   EXPORT_SYMBOL(kasan_flag_enabled);
>   
>   struct slab *kasan_addr_to_slab(const void *addr)
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index a3b112868be7..455376d5f1c3 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -42,7 +42,8 @@
>    */
>   void __init kasan_init_generic(void)
>   {
> -	static_branch_enable(&kasan_flag_enabled);
> +	if (!IS_ENABLED(CONFIG_HAVE_ARCH_KASAN_EARLY))
> +		static_branch_enable(&kasan_flag_enabled);
>   
>   	pr_info("KernelAddressSanitizer initialized (generic)\n");
>   }


