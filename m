Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9199A4FDCC0
	for <lists+linux-s390@lfdr.de>; Tue, 12 Apr 2022 13:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241176AbiDLKgj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 12 Apr 2022 06:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353486AbiDLKbu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 12 Apr 2022 06:31:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84F8B17E3F
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649755946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ch3tiPM554danzz85a+2eS8MmIcP8smEeR6PBh5/wBI=;
        b=bp3NyuNW58RG1c0uODB2NDQBpKJxum8aDDcmWQ2bTCCq8gkcjcTWjUS88JTAHpc5c68QHu
        H5S/QeG3y3Mqudoo6UB8iPpQb46mQQicz0WX+Otyvk+t1n3zGKpI4NkmDdHZv3EFib0jcm
        NLPOzIm9ZoPztUlN7fTxzagPn1z4C2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-94-rFk8srF3NA2Un5qOO-638w-1; Tue, 12 Apr 2022 05:32:24 -0400
X-MC-Unique: rFk8srF3NA2Un5qOO-638w-1
Received: by mail-wm1-f70.google.com with SMTP id j6-20020a05600c1c0600b0038e7d07ebcaso5734492wms.0
        for <linux-s390@vger.kernel.org>; Tue, 12 Apr 2022 02:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ch3tiPM554danzz85a+2eS8MmIcP8smEeR6PBh5/wBI=;
        b=LVoZQOzcFtf6Q8kRjt6ppRNNRs07XpEAD4UjVIe9BXmh2WuJw3pnuB1eqds0JynBaM
         R9wvFp/Z0WRIqQoSGVuuF4bT53sBH7gNOVK2FlXOo1w+6zWpZA3DGcDMfN8j1I8hScty
         /bxkK12FcnnyGV+QAWZU4bSZTW5jpHxK8kjXnpRdXuGcduoNN0G+7VIi7pZguaVjjuw7
         fq/X5tcyfrkBxUnGa7lAQyVhp1kSX27V7J+mfdAy6iBaI1Rs3Bbh7BDHyDjPjuB9f/aD
         wl182+dUhQkZwRYqxiqe8/XLKbJhj6dx9QP2HjQxReNaUf4KKoFPukHVwTxf8V+iFSzE
         /Y6w==
X-Gm-Message-State: AOAM532UPkcvi3dR5NLH3Sg5uGU2GkbMiYewviJVq2qMZyaCHLQNqiRs
        h3eeo5ATwNmRUg1qzxAo+cVSXyn5yCplXTfUKmvziDPKcArdILtPPAHE4KvHIdak+I7u0NeDrdt
        AXxMgUzWmq/06MfW1eYg5iA==
X-Received: by 2002:a05:600c:4f43:b0:38c:b270:f9af with SMTP id m3-20020a05600c4f4300b0038cb270f9afmr3280320wmq.36.1649755943563;
        Tue, 12 Apr 2022 02:32:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9Y1Medzb4UJzevKx1boYcDqbdw0pRTMoe6enXKXIWxONClEPYnyduZpEptnXMGPSYs2/ZKw==
X-Received: by 2002:a05:600c:4f43:b0:38c:b270:f9af with SMTP id m3-20020a05600c4f4300b0038cb270f9afmr3280299wmq.36.1649755943308;
        Tue, 12 Apr 2022 02:32:23 -0700 (PDT)
Received: from [10.33.192.183] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id o11-20020adf9d4b000000b001f0077ea337sm28843962wre.22.2022.04.12.02.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:32:22 -0700 (PDT)
Message-ID: <f050da01-4d50-5da5-7f08-6da30f5dbbbe@redhat.com>
Date:   Tue, 12 Apr 2022 11:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Test effect of storage keys on
 some instructions
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20220301095059.3026178-1-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20220301095059.3026178-1-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/03/2022 10.50, Janis Schoetterl-Glausch wrote:
> Some instructions are emulated by KVM. Test that KVM correctly emulates
> storage key checking for two of those instructions (STORE CPU ADDRESS,
> SET PREFIX).
> Test success and error conditions, including coverage of storage and
> fetch protection override.
> Also add test for TEST PROTECTION, even if that instruction will not be
> emulated by KVM under normal conditions.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
[...]
>   lib/s390x/asm/arch_def.h |  20 ++---
>   s390x/skey.c             | 171 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 182 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 40626d72..e443a9cd 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -55,15 +55,17 @@ struct psw {
>   #define PSW_MASK_BA			0x0000000080000000UL
>   #define PSW_MASK_64			(PSW_MASK_BA | PSW_MASK_EA)
>   
> -#define CTL0_LOW_ADDR_PROT		(63 - 35)
> -#define CTL0_EDAT			(63 - 40)
> -#define CTL0_IEP			(63 - 43)
> -#define CTL0_AFP			(63 - 45)
> -#define CTL0_VECTOR			(63 - 46)
> -#define CTL0_EMERGENCY_SIGNAL		(63 - 49)
> -#define CTL0_EXTERNAL_CALL		(63 - 50)
> -#define CTL0_CLOCK_COMPARATOR		(63 - 52)
> -#define CTL0_SERVICE_SIGNAL		(63 - 54)
> +#define CTL0_LOW_ADDR_PROT			(63 - 35)
> +#define CTL0_EDAT				(63 - 40)
> +#define CTL0_FETCH_PROTECTION_OVERRIDE		(63 - 38)
> +#define CTL0_STORAGE_PROTECTION_OVERRIDE	(63 - 39)

Just a matter of taste, but IMHO the names are getting a little bit long 
here ... maybe use "PROT" instead of "PROTECTION" to shorten them a little bit?

> +#define CTL0_IEP				(63 - 43)
> +#define CTL0_AFP				(63 - 45)
> +#define CTL0_VECTOR				(63 - 46)
> +#define CTL0_EMERGENCY_SIGNAL			(63 - 49)
> +#define CTL0_EXTERNAL_CALL			(63 - 50)
> +#define CTL0_CLOCK_COMPARATOR			(63 - 52)
> +#define CTL0_SERVICE_SIGNAL			(63 - 54)
>   #define CR0_EXTM_MASK			0x0000000000006200UL /* Combined external masks */
>   
>   #define CTL2_GUARDED_STORAGE		(63 - 59)
> diff --git a/s390x/skey.c b/s390x/skey.c
> index 58a55436..0ab3172e 100644
> --- a/s390x/skey.c
> +++ b/s390x/skey.c
> @@ -10,6 +10,7 @@
>   #include <libcflat.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/interrupt.h>
> +#include <vmalloc.h>
>   #include <asm/page.h>
>   #include <asm/facility.h>
>   #include <asm/mem.h>
> @@ -147,6 +148,171 @@ static void test_invalid_address(void)
>   	report_prefix_pop();
>   }
>   
> +static void test_test_protection(void)
> +{
> +	unsigned long addr = (unsigned long)pagebuf;
> +
> +	report_prefix_push("TPROT");
> +	set_storage_key(pagebuf, 0x10, 0);
> +	report(tprot(addr, 0) == 0, "access key 0 -> no protection");
> +	report(tprot(addr, 1) == 0, "access key matches -> no protection");
> +	report(tprot(addr, 2) == 1, "access key mismatches, no fetch protection -> store protection");
> +	set_storage_key(pagebuf, 0x18, 0);
> +	report(tprot(addr, 2) == 2, "access key mismatches, fetch protection -> fetch & store protection");
> +	report_prefix_pop();

Maybe also check storage protection override here?

> +}
> +

Could you please add a short comment in front of the 
store_cpu_address_key_1() function, saying what it does? ... not everybody 
(at least not me) knows CPU instructions like SPKA by hand, so I had to look 
that up first to understand what this is doing.

> +static void store_cpu_address_key_1(uint16_t *out)
> +{
> +	asm volatile (
> +		"spka 0x10(0)\n\t"
> +		"stap %0\n\t"
> +		"spka 0(0)\n"
> +	     : "+Q" (*out) /* exception: old value remains in out -> + constraint*/
> +	);
> +}
> +
> +static void test_store_cpu_address(void)
> +{
> +	uint16_t *out = (uint16_t *)pagebuf;
> +	uint16_t cpu_addr;
> +
> +	asm ("stap %0" : "=Q" (cpu_addr));
> +
> +	report_prefix_push("STORE CPU ADDRESS, zero key");

You could also use one report_prefix_push("STORE CPU ADDRESS") prefix for 
the whole function, so you don't have to repeat that string everywhere again.

> +	set_storage_key(pagebuf, 0x20, 0);
> +	*out = 0xbeef;
> +	asm ("stap %0" : "=Q" (*out));

I think it might be better to use +Q here ... otherwise the compiler might 
optimize the "*out = 0xbeef" away, since it sees that the variable is only 
written twice, but never used in between.

> +	report(*out == cpu_addr, "store occurred");
> +	report_prefix_pop();
> +
> +	report_prefix_push("STORE CPU ADDRESS, matching key");
> +	set_storage_key(pagebuf, 0x10, 0);
> +	*out = 0xbeef;
> +	store_cpu_address_key_1(out);
> +	report(*out == cpu_addr, "store occurred");
> +	report_prefix_pop();
> +
> +	report_prefix_push("STORE CPU ADDRESS, mismatching key");
> +	set_storage_key(pagebuf, 0x20, 0);
> +	expect_pgm_int();
> +	*out = 0xbeef;
> +	store_cpu_address_key_1(out);
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report(*out == 0xbeef, "no store occurred");
> +	report_prefix_pop();
> +
> +	ctl_set_bit(0, CTL0_STORAGE_PROTECTION_OVERRIDE);
> +
> +	report_prefix_push("STORE CPU ADDRESS, storage-protection override, invalid key");
> +	set_storage_key(pagebuf, 0x20, 0);
> +	expect_pgm_int();
> +	*out = 0xbeef;
> +	store_cpu_address_key_1(out);
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	report(*out == 0xbeef, "no store occurred");
> +	report_prefix_pop();
> +
> +	report_prefix_push("STORE CPU ADDRESS, storage-protection override, override key");
> +	set_storage_key(pagebuf, 0x90, 0);
> +	*out = 0xbeef;
> +	store_cpu_address_key_1(out);
> +	report(*out == cpu_addr, "override occurred");
> +	report_prefix_pop();
> +
> +	ctl_clear_bit(0, CTL0_STORAGE_PROTECTION_OVERRIDE);

Wow, that protection override stuff was new to me, crazy stuff!

Should we maybe check with set_storage_key(pagebuf, 0x90, 0) but storage 
protection override disabled, too, to see whether this correctly blocks the 
access again?

> +	set_storage_key(pagebuf, 0x00, 0);

The other tests don't clear the storage key at the end, so why here now?

> +}
> +
> +static void set_prefix_key_1(uint32_t *out)
> +{
> +	asm volatile (
> +		"spka 0x10(0)\n\t"
> +		"spx	%0\n\t"
> +		"spka 0(0)\n"
> +	     :: "Q" (*out)
> +	);
> +}
> +
> +/*
> + * We remapped page 0, making the lowcore inaccessible, which breaks the normal
> + * hanlder and breaks skipping the faulting instruction.

s/hanlder/handler/

> + * Just disable dynamic address translation to make things work.
> + */
> +static void dat_fixup_pgm_int(void)
> +{
> +	uint64_t psw_mask = extract_psw_mask();
> +
> +	psw_mask &= ~PSW_MASK_DAT;
> +	load_psw_mask(psw_mask);
> +}
> +
> +static void test_set_prefix(void)
> +{
> +	uint32_t *out = (uint32_t *)pagebuf;
> +	pgd_t *root;
> +
> +	root = (pgd_t *)(stctg(1) & PAGE_MASK);
> +
> +	asm volatile("stpx	%0" : "=Q"(*out));
> +
> +	report_prefix_push("SET PREFIX, zero key");

You could do one report_prefix_push("SET PREFIX") for the whole function again.

> +	set_storage_key(pagebuf, 0x20, 0);
> +	asm volatile("spx	%0" : "=Q" (*out));
> +	report_pass("no exception");
> +	report_prefix_pop();
> +
> +	report_prefix_push("SET PREFIX, matching key");
> +	set_storage_key(pagebuf, 0x10, 0);
> +	set_prefix_key_1(out);
> +	report_pass("no exception");
> +	report_prefix_pop();
> +
> +	report_prefix_push("SET PREFIX, mismatching key, no fetch protection");
> +	set_storage_key(pagebuf, 0x20, 0);
> +	set_prefix_key_1(out);
> +	report_pass("no exception");
> +	report_prefix_pop();
> +
> +	report_prefix_push("SET PREFIX, mismatching key, fetch protection");
> +	set_storage_key(pagebuf, 0x28, 0);
> +	expect_pgm_int();
> +	*out = 0xdeadbeef;
> +	set_prefix_key_1(out);
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	asm volatile("stpx	%0" : "=Q"(*out));
> +	report(*out != 0xdeadbeef, "no fetch occurred");
> +	report_prefix_pop();
> +
> +	register_pgm_cleanup_func(dat_fixup_pgm_int);
> +	ctl_set_bit(0, CTL0_FETCH_PROTECTION_OVERRIDE);
> +
> +	report_prefix_push("SET PREFIX, mismatching key, fetch protection override applies");
> +	set_storage_key(pagebuf, 0x28, 0);
> +	install_page(root, virt_to_pte_phys(root, pagebuf), 0);
> +	set_prefix_key_1(0);
> +	install_page(root, 0, 0);
> +	report_pass("no exception");
> +	report_prefix_pop();

Could we do the same test (with the page remapped via DAT), just without 
fetch protection override, to make sure that it generates an exception there?

> +	report_prefix_push("SET PREFIX, mismatching key, fetch protection override does not apply");
> +	out = (uint32_t *)(pagebuf + 2048);
> +	set_storage_key(pagebuf, 0x28, 0);
> +	expect_pgm_int();
> +	install_page(root, virt_to_pte_phys(root, pagebuf), 0);
> +	WRITE_ONCE(*out, 0xdeadbeef);

Would it make sense to swap the above two lines, i.e. first the WRITE_ONCE, 
then the install_page? ... access to *out between the two intall_page() 
calls requires me to think twice whether that's ok or not ;-)

> +	set_prefix_key_1((uint32_t *)2048);
> +	install_page(root, 0, 0);
> +	check_pgm_int_code(PGM_INT_CODE_PROTECTION);
> +	asm volatile("stpx	%0" : "=Q"(*out));
> +	report(*out != 0xdeadbeef, "no fetch occurred");
> +	report_prefix_pop();
> +
> +	ctl_clear_bit(0, CTL0_FETCH_PROTECTION_OVERRIDE);
> +	set_storage_key(pagebuf, 0x00, 0);

Dito, why clearing the key here, but not in the other functions?

> +	register_pgm_cleanup_func(NULL);
> +}
> +
>   int main(void)
>   {
>   	report_prefix_push("skey");
> @@ -159,6 +325,11 @@ int main(void)
>   	test_set();
>   	test_set_mb();
>   	test_chg();
> +	test_test_protection();
> +	test_store_cpu_address();
> +
> +	setup_vm();
> +	test_set_prefix();
>   done:
>   	report_prefix_pop();
>   	return report_summary();

  Thomas

