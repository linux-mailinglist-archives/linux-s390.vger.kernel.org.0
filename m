Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275335F3E03
	for <lists+linux-s390@lfdr.de>; Tue,  4 Oct 2022 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJDIPt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 4 Oct 2022 04:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJDIP3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Oct 2022 04:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F159520B3
        for <linux-s390@vger.kernel.org>; Tue,  4 Oct 2022 01:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664871204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SEPz4izziLGyZZQpQAS5WWJH9dzKde6xEWRITwwvro=;
        b=S7lrcr6zkVfRLutUJf5vNPyuI40C/WkiCLmBbRkXi1U9O5/LJNGUhvu3uOISiE+i9Pl23N
        0K5nJYsOwI5baPqf+X8ZTnCuZZxFcq1trkDJm8CVNrbPvYHKxmumdhj5ddYoEnwayqVdVK
        wRGTj5GK11uM3Gky82vu0MPVbklG+GE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-CyBFoh6MOaiekiRKXzGF6w-1; Tue, 04 Oct 2022 04:13:23 -0400
X-MC-Unique: CyBFoh6MOaiekiRKXzGF6w-1
Received: by mail-wm1-f70.google.com with SMTP id 133-20020a1c028b000000b003bd776ce0f3so123628wmc.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Oct 2022 01:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4SEPz4izziLGyZZQpQAS5WWJH9dzKde6xEWRITwwvro=;
        b=C1+6vfVYBcAaHR+7mn1Mkuce/6CW0tL+Bms6+7DsS4DcRfIeSUhD9OB7rTtBUBMwCl
         PPvbWQ6+44vKXiQXCsVbJTeWWc6n8zZ83iMAVw3wrmnAzY/b7447eYfFjsGsgUxhYFzv
         LXMvyuZoi0Nn3dFOfnnJ+n18aUxwTBQhTMGUSx0tiuqkDFoRcez8S3k5VPmus4UCGqGh
         aXxfeX+g+eYk6C90365zzVoIbMDxAEYAD2XwzaDVDSPhMWBZSNfUVgWl3YAEPDjIa6ct
         wi6ySXhXxQQ92xj7eNA8X+rH3mksq/5y9kZscYQfpZN+jX08xlDkJ8HT3YRb/wTrh3QN
         AYBQ==
X-Gm-Message-State: ACrzQf2mzV0eAsmXorRTBMKRToeaPLvHis/ErNrOCnOT9gMdcxujy64I
        Y5S3mW6e8a1EJrfbYcK8Y+gv3eDFX2DXS6VSmUa7bdbGq3QBgs1JgTNPQ3XVGr4YSxLQRu7aIbz
        DL3GALAX76kAzZCeXqbBMjA==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr9326468wmp.201.1664871201963;
        Tue, 04 Oct 2022 01:13:21 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Elcz96X2vnDOISc0Fm0vuaZoMWuBIs/A7V2AFtBPjUPP+3RQq7GKyzaXipTZnmux/ACQIMA==
X-Received: by 2002:a05:600c:a04:b0:3b4:f20e:63f4 with SMTP id z4-20020a05600c0a0400b003b4f20e63f4mr9326456wmp.201.1664871201722;
        Tue, 04 Oct 2022 01:13:21 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-178-246.web.vodafone.de. [109.43.178.246])
        by smtp.gmail.com with ESMTPSA id j2-20020adfd202000000b002285f73f11dsm14819436wrh.81.2022.10.04.01.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 01:13:21 -0700 (PDT)
Message-ID: <ffd5935b-a933-18b8-c6a8-2863bbb3d906@redhat.com>
Date:   Tue, 4 Oct 2022 10:13:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>
References: <20220930210751.225873-1-scgl@linux.ibm.com>
 <20220930210751.225873-3-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v1 2/9] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
In-Reply-To: <20220930210751.225873-3-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 30/09/2022 23.07, Janis Schoetterl-Glausch wrote:
> User space can use the MEM_OP ioctl to make storage key checked reads
> and writes to the guest, however, it has no way of performing atomic,
> key checked, accesses to the guest.
> Extend the MEM_OP ioctl in order to allow for this, by adding a cmpxchg
> mode. For now, support this mode for absolute accesses only.
> 
> This mode can be use, for example, to set the device-state-change
> indicator and the adapter-local-summary indicator atomically.
> 
> Signed-off-by: Janis Schoetterl-Glausch <scgl@linux.ibm.com>
> ---
...
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index eed0315a77a6..b856705f3f6b 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -580,7 +580,9 @@ struct kvm_translation {
>   struct kvm_s390_mem_op {
>   	/* in */
>   	__u64 gaddr;		/* the guest address */
> +	/* in & out */
>   	__u64 flags;		/* flags */
> +	/* in */
>   	__u32 size;		/* amount of bytes */
>   	__u32 op;		/* type of operation */
>   	__u64 buf;		/* buffer in userspace */
> @@ -588,6 +590,8 @@ struct kvm_s390_mem_op {
>   		struct {
>   			__u8 ar;	/* the access register number */
>   			__u8 key;	/* access key, ignored if flag unset */
> +			/* in & out */
> +			__u64 old[2];	/* ignored if flag unset */

The alignment looks very unfortunate now ... could you please add a "__u8 
pad[6]" or "__u8 pad[14]" in front of the new field?

>   		};
>   		__u32 sida_offset; /* offset into the sida */
>   		__u8 reserved[32]; /* ignored */
> @@ -604,6 +608,7 @@ struct kvm_s390_mem_op {
>   #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>   #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>   #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
>   
>   /* for KVM_INTERRUPT */
>   struct kvm_interrupt {
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 9408d6cc8e2c..a1cb66ae0995 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -206,6 +206,10 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   		      void *data, unsigned long len, enum gacc_mode mode);
>   
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       unsigned __int128 *old,
> +			       unsigned __int128 new, u8 access_key);
> +
>   /**
>    * write_guest_with_key - copy data from kernel space to guest space
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0243b6e38d36..c0e490ecc372 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1161,6 +1161,62 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   	return rc;
>   }
>   
> +/**
> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
> + * @kvm: Virtual machine instance.
> + * @gpa: Absolute guest address of the location to be changed.
> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
> + *       non power of two will result in failure.
> + * @old_p: Pointer to old value. If the location at @gpa contains this value, the
> + *         exchange will succeed. After calling cmpxchg_guest_abs_with_key() *@old
> + *         contains the value at @gpa before the attempt to exchange the value.
> + * @new: The value to place at @gpa.
> + * @access_key: The access key to use for the guest access.
> + *
> + * Atomically exchange the value at @gpa by @new, if it contains *@old.
> + * Honors storage keys.
> + *
> + * Return: * 0: successful exchange
> + *         * 1: exchange unsuccessful
> + *         * a program interruption code indicating the reason cmpxchg could
> + *           not be attempted
> + *         * -EINVAL: address misaligned or len not power of two
> + */
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       unsigned __int128 *old_p, unsigned __int128 new,
> +			       u8 access_key)
> +{
> +	gfn_t gfn = gpa >> PAGE_SHIFT;
> +	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
> +	bool writable;
> +	hva_t hva;
> +	int ret;
> +
> +	if (!IS_ALIGNED(gpa, len))
> +		return -EINVAL;
> +
> +	hva = gfn_to_hva_memslot_prot(slot, gfn, &writable);
> +	if (kvm_is_error_hva(hva))
> +		return PGM_ADDRESSING;
> +	/*
> +	 * Check if it's a ro memslot, even tho that can't occur (they're unsupported).

Not everybody is used to read such abbreviated English ... I'd recommend to 
spell it rather properly (ro ==> read-only, tho ==> though)

> +	 * Don't try to actually handle that case.
> +	 */
> +	if (!writable)
> +		return -EOPNOTSUPP;
> +
> +	hva += offset_in_page(gpa);
> +	ret = cmpxchg_user_key_size(len, (void __user *)hva, old_p, new, access_key);
> +	mark_page_dirty_in_slot(kvm, slot, gfn);
> +	/*
> +	 * Assume that the fault is caused by key protection, the alternative
> +	 * is that the user page is write protected.
> +	 */
> +	if (ret == -EFAULT)
> +		ret = PGM_PROTECTION;
> +	return ret;
> +}
> +
>   /**
>    * guest_translate_address_with_key - translate guest logical into guest absolute address
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index b7ef0b71014d..d594d1318d2a 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -576,7 +576,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_VCPU_RESETS:
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_S390_DIAG318:
> -	case KVM_CAP_S390_MEM_OP_EXTENSION:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> @@ -590,6 +589,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_MEM_OP:
>   		r = MEM_OP_MAX_SIZE;
>   		break;
> +	case KVM_CAP_S390_MEM_OP_EXTENSION:
> +		r = 0x3;

Add a comment to explain that magic value 0x3 ?

> +		break;
>   	case KVM_CAP_NR_VCPUS:
>   	case KVM_CAP_MAX_VCPUS:
>   	case KVM_CAP_MAX_VCPU_ID:

  Thomas

