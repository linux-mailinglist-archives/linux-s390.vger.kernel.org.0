Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE07665598
	for <lists+linux-s390@lfdr.de>; Wed, 11 Jan 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjAKIBS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 11 Jan 2023 03:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbjAKIAu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 11 Jan 2023 03:00:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7980F5BB
        for <linux-s390@vger.kernel.org>; Wed, 11 Jan 2023 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673424002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ryKP4Syb0QxMHTHezxVFEI/PQgexEWoWhCwUcUgI3Bs=;
        b=HrRlBA5VKo9MbGx/wbnwz+8S5Lsjq4O5cNeY5TjGi3smoR/RKAIKvM1AAEIdgx8wuK6wy5
        2LTMC+25OtSXVPcJkhO/SX1JzKpGt79hqJqefcgiQN/+s6MlG/TYaij2QCkkumc/s0Mcnn
        ruD9stLpQLAM/mLU29ketCmh88ZQTKQ=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-R7Sy2FPfOqO7AOn9N3Xprw-1; Wed, 11 Jan 2023 03:00:00 -0500
X-MC-Unique: R7Sy2FPfOqO7AOn9N3Xprw-1
Received: by mail-qv1-f70.google.com with SMTP id cx11-20020a056214188b00b00531cacde854so7993010qvb.6
        for <linux-s390@vger.kernel.org>; Wed, 11 Jan 2023 00:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ryKP4Syb0QxMHTHezxVFEI/PQgexEWoWhCwUcUgI3Bs=;
        b=Ja1LUbMMnRfruC5kLZBIUCmoA5iqagAwUhIdN7dTzshY3aAFHykPOLeZquu7drywsV
         Wxs8XaP7QXSdsWn3IeBLWgVi3jBY93PjLVfBzLA9R5R29pFFLMTTVwsWdKB8fItVHzrD
         MWTISZSi1qAqkmeTm8OjHYykSkcdc6vBZbc8+D1/D/fKmbdjhVst2qSadwPSqjO+YgXh
         QTfsrrAaVcZUn0vWnia+tRzwL8i2OOqouJ9Z8m84tvHBeO2Td+wem0d+Av0Wpu1m6UHB
         BrQgimoLIzrosji3GMhNZoMHUKi+DuPLBrGc7wUdbesc4rErEYO6mG1QEqjv0GqFLybE
         KvCA==
X-Gm-Message-State: AFqh2krkKmQqsrWbjGnW82TpTM1mEhpYyeZkhEqOfbCVkNbgAefAXmHz
        4wMmum53eIsumnd0rZNQqfTCI0I/X3iUPm122iTqU97P+gpJvH1d+NhVMygUEnU0bSXCBqpPIUa
        qhZiFx3TmA1UxiCdo0DQNmg==
X-Received: by 2002:ac8:1386:0:b0:3ac:57b4:8af1 with SMTP id h6-20020ac81386000000b003ac57b48af1mr17407493qtj.48.1673424000208;
        Wed, 11 Jan 2023 00:00:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuCxMYAF0XtzpQS+jcWvPGgAusQLEHTTzEMCOqWd8k+VpNsYPzqN2dh6WTpHkbgSTx6FIB2Qw==
X-Received: by 2002:ac8:1386:0:b0:3ac:57b4:8af1 with SMTP id h6-20020ac81386000000b003ac57b48af1mr17407472qtj.48.1673423999824;
        Tue, 10 Jan 2023 23:59:59 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-176-91.web.vodafone.de. [109.43.176.91])
        by smtp.gmail.com with ESMTPSA id hj4-20020a05622a620400b003995f6513b9sm7141809qtb.95.2023.01.10.23.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 23:59:59 -0800 (PST)
Message-ID: <d124764c-f221-98d8-a286-79efe176515c@redhat.com>
Date:   Wed, 11 Jan 2023 08:59:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 01/10] KVM: s390: Extend MEM_OP ioctl by storage key
 checked cmpxchg
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
References: <20230110202632.2533978-1-scgl@linux.ibm.com>
 <20230110202632.2533978-2-scgl@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230110202632.2533978-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/01/2023 21.26, Janis Schoetterl-Glausch wrote:
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
>   include/uapi/linux/kvm.h |   7 +++
>   arch/s390/kvm/gaccess.h  |   3 ++
>   arch/s390/kvm/gaccess.c  | 102 +++++++++++++++++++++++++++++++++++++++
>   arch/s390/kvm/kvm-s390.c |  41 +++++++++++++++-
>   4 files changed, 151 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 55155e262646..452f43c1cc34 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -583,6 +583,8 @@ struct kvm_s390_mem_op {
>   		struct {
>   			__u8 ar;	/* the access register number */
>   			__u8 key;	/* access key, ignored if flag unset */
> +			__u8 pad1[6];	/* ignored */
> +			__u64 old_addr;	/* ignored if flag unset */
>   		};
>   		__u32 sida_offset; /* offset into the sida */
>   		__u8 reserved[32]; /* ignored */
> @@ -599,6 +601,11 @@ struct kvm_s390_mem_op {
>   #define KVM_S390_MEMOP_F_CHECK_ONLY		(1ULL << 0)
>   #define KVM_S390_MEMOP_F_INJECT_EXCEPTION	(1ULL << 1)
>   #define KVM_S390_MEMOP_F_SKEY_PROTECTION	(1ULL << 2)
> +#define KVM_S390_MEMOP_F_CMPXCHG		(1ULL << 3)
> +/* flags specifying extension support */
> +#define KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG 0x2
> +/* Non program exception return codes (pgm codes are 16 bit) */
> +#define KVM_S390_MEMOP_R_NO_XCHG		(1 << 16)
>   
>   /* for KVM_INTERRUPT */
>   struct kvm_interrupt {
> diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
> index 9408d6cc8e2c..92a3b9fb31ec 100644
> --- a/arch/s390/kvm/gaccess.h
> +++ b/arch/s390/kvm/gaccess.h
> @@ -206,6 +206,9 @@ int access_guest_with_key(struct kvm_vcpu *vcpu, unsigned long ga, u8 ar,
>   int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   		      void *data, unsigned long len, enum gacc_mode mode);
>   
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old, __uint128_t new, u8 access_key);
> +
>   /**
>    * write_guest_with_key - copy data from kernel space to guest space
>    * @vcpu: virtual cpu
> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 0243b6e38d36..6165e761a637 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -1161,6 +1161,108 @@ int access_guest_real(struct kvm_vcpu *vcpu, unsigned long gra,
>   	return rc;
>   }
>   
> +/**
> + * cmpxchg_guest_abs_with_key() - Perform cmpxchg on guest absolute address.
> + * @kvm: Virtual machine instance.
> + * @gpa: Absolute guest address of the location to be changed.
> + * @len: Operand length of the cmpxchg, required: 1 <= len <= 16. Providing a
> + *       non power of two will result in failure.
> + * @old_addr: Pointer to old value. If the location at @gpa contains this value, the
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

PGM_OPERATION has also the value 1 ... can we be sure that it never happens 
here? ... maybe it would make sense to use KVM_S390_MEMOP_R_NO_XCHG for 
return value here instead of 1, too, just to be on the safe side?

Apart from that, patch looks fine to me.

  Thomas


> + *         * -EINVAL: address misaligned or len not power of two
> + *         * -EAGAIN: transient failure (len 1 or 2)
> + *         * -EOPNOTSUPP: read-only memslot (should never occur)
> + */
> +int cmpxchg_guest_abs_with_key(struct kvm *kvm, gpa_t gpa, int len,
> +			       __uint128_t *old_addr, __uint128_t new,
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
> +	 * Check if it's a read-only memslot, even though that cannot occur
> +	 * since those are unsupported.
> +	 * Don't try to actually handle that case.
> +	 */
> +	if (!writable)
> +		return -EOPNOTSUPP;
> +
> +	hva += offset_in_page(gpa);
> +	switch (len) {
> +	case 1: {
> +		u8 old;
> +
> +		ret = cmpxchg_user_key((u8 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 2: {
> +		u16 old;
> +
> +		ret = cmpxchg_user_key((u16 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 4: {
> +		u32 old;
> +
> +		ret = cmpxchg_user_key((u32 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 8: {
> +		u64 old;
> +
> +		ret = cmpxchg_user_key((u64 *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	case 16: {
> +		__uint128_t old;
> +
> +		ret = cmpxchg_user_key((__uint128_t *)hva, &old, *old_addr, new, access_key);
> +		ret = ret < 0 ? ret : old != *old_addr;
> +		*old_addr = old;
> +		break;
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +	mark_page_dirty_in_slot(kvm, slot, gfn);
> +	/*
> +	 * Assume that the fault is caused by protection, either key protection
> +	 * or user page write protection.
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
> index e4890e04b210..56f4f6ddd5bb 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -584,7 +584,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_VCPU_RESETS:
>   	case KVM_CAP_SET_GUEST_DEBUG:
>   	case KVM_CAP_S390_DIAG318:
> -	case KVM_CAP_S390_MEM_OP_EXTENSION:
>   		r = 1;
>   		break;
>   	case KVM_CAP_SET_GUEST_DEBUG2:
> @@ -598,6 +597,14 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>   	case KVM_CAP_S390_MEM_OP:
>   		r = MEM_OP_MAX_SIZE;
>   		break;
> +	case KVM_CAP_S390_MEM_OP_EXTENSION:
> +		/*
> +		 * Flag bits indicating which extensions are supported.
> +		 * The first extension doesn't use a flag, but pretend it does,
> +		 * this way that can be changed in the future.
> +		 */
> +		r = KVM_S390_MEMOP_EXTENSION_CAP_CMPXCHG | 1;
> +		break;
>   	case KVM_CAP_NR_VCPUS:
>   	case KVM_CAP_MAX_VCPUS:
>   	case KVM_CAP_MAX_VCPU_ID:
> @@ -2772,12 +2779,19 @@ static bool access_key_invalid(u8 access_key)
>   static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   {
>   	void __user *uaddr = (void __user *)mop->buf;
> +	void __user *old_addr = (void __user *)mop->old_addr;
> +	union {
> +		__uint128_t quad;
> +		char raw[sizeof(__uint128_t)];
> +	} old = { .quad = 0}, new = { .quad = 0 };
> +	unsigned int off_in_quad = sizeof(new) - mop->size;
>   	u64 supported_flags;
>   	void *tmpbuf = NULL;
>   	int r, srcu_idx;
>   
>   	supported_flags = KVM_S390_MEMOP_F_SKEY_PROTECTION
> -			  | KVM_S390_MEMOP_F_CHECK_ONLY;
> +			  | KVM_S390_MEMOP_F_CHECK_ONLY
> +			  | KVM_S390_MEMOP_F_CMPXCHG;
>   	if (mop->flags & ~supported_flags || !mop->size)
>   		return -EINVAL;
>   	if (mop->size > MEM_OP_MAX_SIZE)
> @@ -2799,6 +2813,21 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	} else {
>   		mop->key = 0;
>   	}
> +	if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +		/*
> +		 * This validates off_in_quad. Checking that size is a power
> +		 * of two is not necessary, as cmpxchg_guest_abs_with_key
> +		 * takes care of that
> +		 */
> +		if (mop->size > sizeof(new))
> +			return -EINVAL;
> +		if (mop->op != KVM_S390_MEMOP_ABSOLUTE_WRITE)
> +			return -EINVAL;
> +		if (copy_from_user(&new.raw[off_in_quad], uaddr, mop->size))
> +			return -EFAULT;
> +		if (copy_from_user(&old.raw[off_in_quad], old_addr, mop->size))
> +			return -EFAULT;
> +	}
>   	if (!(mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY)) {
>   		tmpbuf = vmalloc(mop->size);
>   		if (!tmpbuf)
> @@ -2829,6 +2858,14 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, struct kvm_s390_mem_op *mop)
>   	case KVM_S390_MEMOP_ABSOLUTE_WRITE: {
>   		if (mop->flags & KVM_S390_MEMOP_F_CHECK_ONLY) {
>   			r = check_gpa_range(kvm, mop->gaddr, mop->size, GACC_STORE, mop->key);
> +		} else if (mop->flags & KVM_S390_MEMOP_F_CMPXCHG) {
> +			r = cmpxchg_guest_abs_with_key(kvm, mop->gaddr, mop->size,
> +						       &old.quad, new.quad, mop->key);
> +			if (r == 1) {
> +				r = KVM_S390_MEMOP_R_NO_XCHG;
> +				if (copy_to_user(old_addr, &old.raw[off_in_quad], mop->size))
> +					r = -EFAULT;
> +			}
>   		} else {
>   			if (copy_from_user(tmpbuf, uaddr, mop->size)) {
>   				r = -EFAULT;

