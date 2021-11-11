Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8435644DB9C
	for <lists+linux-s390@lfdr.de>; Thu, 11 Nov 2021 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbhKKSc2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 11 Nov 2021 13:32:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234001AbhKKSc2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 11 Nov 2021 13:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636655378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x4RdaO9C0fWKiyKfKgHDoJGk0IKqUwuwGJqXNy2InYM=;
        b=aiPZ8IDC5wqYhlJZStY3Gv9tyu8NtyAz0RbiuLw+MwjbA5XFYw/5GHKXgB7ac9vOY7o8WC
        ZwnAMTfCElP6EPjMab7pnT4MLnUkHkWtDsTyAXsc+uQbZ3RRVbjWDlgcFdO196etsMywR9
        ijE6pKNBgM3smx6V/7176wcZt7AAbaI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-e0U_PRWcMRiuAc10vvZZsQ-1; Thu, 11 Nov 2021 13:29:37 -0500
X-MC-Unique: e0U_PRWcMRiuAc10vvZZsQ-1
Received: by mail-wr1-f72.google.com with SMTP id p3-20020a056000018300b00186b195d4ddso1172264wrx.15
        for <linux-s390@vger.kernel.org>; Thu, 11 Nov 2021 10:29:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=x4RdaO9C0fWKiyKfKgHDoJGk0IKqUwuwGJqXNy2InYM=;
        b=I1mV3ZvKkqhJdwjIi84CXNErhdPgTNWBcbq2fIIWFazz3pHYj2zqxVwR9ZDgtGOtwZ
         9B3OaWw3DxR71yBknVHh1W3XPSo6gn8DPh/ut1GpCtSSV3atCGkUGKvP1bTVwxo3jVwA
         9sL1e3sGlSpU6phCQqhiPvbrvsHyuBQbCWZn2DG+Fn/BOfZtSNN3yxTbjKn6bVMKZ/rT
         Q4ewK32ejkVbRLqasWe90fAsp7QHGE5IbSUgF3QIDfnbcBPyx0pUwBghOXMIi+7PA9nw
         BdIRdsHEsoWzbVx/zfOqb4oelzloH/jFkqzrLNYSgB3TqXFqgLoai4cu9uaFKnBIjArq
         HevA==
X-Gm-Message-State: AOAM531rBFp3xy34kkMAZ9FlJkA2PF4Cz+vGRDi4kCwroQ3yP0KGvtFw
        fewprBiFAyG67mynoRc3zsflrTCdEdamYoWEv/knTNfbuQyg/3RmQC31m/Ytr0EmpMBFYabD7z6
        775vT2YT480OH82Z+Hd7WMg==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr26933434wmi.107.1636655376091;
        Thu, 11 Nov 2021 10:29:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1oA07qmf0h+6D+TrmQJRkrvDhEglM2CchjN0NqWqCV/vgvnsQlvhajgVQXi71BDXp0pO64w==
X-Received: by 2002:a7b:c155:: with SMTP id z21mr26933394wmi.107.1636655375766;
        Thu, 11 Nov 2021 10:29:35 -0800 (PST)
Received: from [192.168.3.132] (p4ff23ee8.dip0.t-ipconnect.de. [79.242.62.232])
        by smtp.gmail.com with ESMTPSA id p19sm3957136wmq.4.2021.11.11.10.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 10:29:35 -0800 (PST)
Message-ID: <85ba9fa3-ca25-b598-aecd-5e0c6a0308f2@redhat.com>
Date:   Thu, 11 Nov 2021 19:29:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC PATCH v3 2/2] KVM: s390: Extend the USER_SIGP capability
Content-Language: en-US
To:     Eric Farman <farman@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20211110203322.1374925-1-farman@linux.ibm.com>
 <20211110203322.1374925-3-farman@linux.ibm.com>
 <dd8a8b49-da6d-0ab8-dc47-b24f5604767f@redhat.com>
 <ab82e68051674ea771e2cb5371ca2a204effab40.camel@linux.ibm.com>
 <32836eb5-532f-962d-161a-faa2213a0691@linux.ibm.com>
 <b116e738d8f9b185867ab28395012aaddd58af31.camel@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <b116e738d8f9b185867ab28395012aaddd58af31.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 11.11.21 18:48, Eric Farman wrote:
> On Thu, 2021-11-11 at 17:13 +0100, Janosch Frank wrote:
>> On 11/11/21 16:03, Eric Farman wrote:
>>> On Thu, 2021-11-11 at 10:15 +0100, David Hildenbrand wrote:
>>>> On 10.11.21 21:33, Eric Farman wrote:
>>>>> With commit 2444b352c3ac ("KVM: s390: forward most SIGP orders
>>>>> to
>>>>> user
>>>>> space") we have a capability that allows the "fast" SIGP orders
>>>>> (as
>>>>> defined by the Programming Notes for the SIGNAL PROCESSOR
>>>>> instruction in
>>>>> the Principles of Operation) to be handled in-kernel, while all
>>>>> others are
>>>>> sent to userspace for processing.
>>>>>
>>>>> This works fine but it creates a situation when, for example, a
>>>>> SIGP SENSE
>>>>> might return CC1 (STATUS STORED, and status bits indicating the
>>>>> vcpu is
>>>>> stopped), when in actuality userspace is still processing a
>>>>> SIGP
>>>>> STOP AND
>>>>> STORE STATUS order, and the vcpu is not yet actually stopped.
>>>>> Thus,
>>>>> the
>>>>> SIGP SENSE should actually be returning CC2 (busy) instead of
>>>>> CC1.
>>>>>
>>>>> To fix this, add another CPU capability, dependent on the
>>>>> USER_SIGP
>>>>> one,
>>>>> and two associated IOCTLs. One IOCTL will be used by userspace
>>>>> to
>>>>> mark a
>>>>> vcpu "busy" processing a SIGP order, and cause concurrent
>>>>> orders
>>>>> handled
>>>>> in-kernel to be returned with CC2 (busy). Another IOCTL will be
>>>>> used by
>>>>> userspace to mark the SIGP "finished", and the vcpu free to
>>>>> process
>>>>> additional orders.
>>>>>
>>>>
>>>> This looks much cleaner to me, thanks!
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-
>>>>> s390.h
>>>>> index c07a050d757d..54371cede485 100644
>>>>> --- a/arch/s390/kvm/kvm-s390.h
>>>>> +++ b/arch/s390/kvm/kvm-s390.h
>>>>> @@ -82,6 +82,22 @@ static inline int is_vcpu_idle(struct
>>>>> kvm_vcpu
>>>>> *vcpu)
>>>>>   	return test_bit(vcpu->vcpu_idx, vcpu->kvm-
>>>>>> arch.idle_mask);
>>>>>   }
>>>>>   
>>>>> +static inline bool kvm_s390_vcpu_is_sigp_busy(struct kvm_vcpu
>>>>> *vcpu)
>>>>> +{
>>>>> +	return (atomic_read(&vcpu->arch.sigp_busy) == 1);
>>>>
>>>> You can drop ()
>>>>
>>>>> +}
>>>>> +
>>>>> +static inline bool kvm_s390_vcpu_set_sigp_busy(struct kvm_vcpu
>>>>> *vcpu)
>>>>> +{
>>>>> +	/* Return zero for success, or -EBUSY if another vcpu
>>>>> won */
>>>>> +	return (atomic_cmpxchg(&vcpu->arch.sigp_busy, 0, 1) ==
>>>>> 0) ? 0 :
>>>>> -EBUSY;
>>>>
>>>> You can drop () as well.
>>>>
>>>> We might not need the -EBUSY semantics after all. User space can
>>>> just
>>>> track if it was set, because it's in charge of setting it.
>>>
>>> Hrm, I added this to distinguish a newer kernel with an older QEMU,
>>> but
>>> of course an older QEMU won't know the difference either. I'll
>>> doublecheck that this is works fine in the different permutations.
>>>
>>>>> +}
>>>>> +
>>>>> +static inline void kvm_s390_vcpu_clear_sigp_busy(struct
>>>>> kvm_vcpu
>>>>> *vcpu)
>>>>> +{
>>>>> +	atomic_set(&vcpu->arch.sigp_busy, 0);
>>>>> +}
>>>>> +
>>>>>   static inline int kvm_is_ucontrol(struct kvm *kvm)
>>>>>   {
>>>>>   #ifdef CONFIG_KVM_S390_UCONTROL
>>>>> diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
>>>>> index 5ad3fb4619f1..a37496ea6dfa 100644
>>>>> --- a/arch/s390/kvm/sigp.c
>>>>> +++ b/arch/s390/kvm/sigp.c
>>>>> @@ -276,6 +276,10 @@ static int handle_sigp_dst(struct kvm_vcpu
>>>>> *vcpu, u8 order_code,
>>>>>   	if (!dst_vcpu)
>>>>>   		return SIGP_CC_NOT_OPERATIONAL;
>>>>>   
>>>>> +	if (kvm_s390_vcpu_is_sigp_busy(dst_vcpu)) {
>>>>> +		return SIGP_CC_BUSY;
>>>>> +	}
>>>>
>>>> You can drop {}
>>>
>>> Arg, I had some debug in there which needed the braces, and of
>>> course
>>> it's unnecessary now. Thanks.
>>>
>>>>> +
>>>>>   	switch (order_code) {
>>>>>   	case SIGP_SENSE:
>>>>>   		vcpu->stat.instruction_sigp_sense++;
>>>>> @@ -411,6 +415,12 @@ int kvm_s390_handle_sigp(struct kvm_vcpu
>>>>> *vcpu)
>>>>>   	if (handle_sigp_order_in_user_space(vcpu, order_code,
>>>>> cpu_addr))
>>>>>   		return -EOPNOTSUPP;
>>>>>   
>>>>> +	/* Check the current vcpu, if it was a target from
>>>>> another vcpu
>>>>> */
>>>>> +	if (kvm_s390_vcpu_is_sigp_busy(vcpu)) {
>>>>> +		kvm_s390_set_psw_cc(vcpu, SIGP_CC_BUSY);
>>>>> +		return 0;
>>>>> +	}
>>>>
>>>> I don't think we need this. I think the above (checking the
>>>> target of
>>>> a
>>>> SIGP order) is sufficient. Or which situation do you have in
>>>> mind?
>>>>
>>>
>>> Hrm... I think you're right. I was thinking of this:
>>>
>>> VCPU 1 - SIGP STOP CPU 2
>>> VCPU 2 - SIGP SENSE CPU 1
>>>
>>> But of course either CPU2 is going to be marked "busy" first, and
>>> the
>>> sense doesn't get processed until it's reset, or the sense arrives
>>> first, and the busy/notbusy doesn't matter. Let me doublecheck my
>>> tests
>>> for the non-RFC version.
>>>
>>>>
>>>> I do wonder if we want to make this a kvm_arch_vcpu_ioctl()
>>>> instead,
>>>
>>> In one of my original attempts between v1 and v2, I had put this
>>> there.
>>> This reliably deadlocks my guest, because the caller
>>> (kvm_vcpu_ioctl())
>>> tries to acquire vcpu->mutex, and racing SIGPs (via KVM_RUN) might
>>> already be holding it. Thus, it's an async ioctl. I could fold it
>>> into
>>> the existing interrupt ioctl, but as those are architected structs
>>> it
>>> seems more natural do it this way. Or I have mis-understood
>>> something
>>> along the way?
>>>
>>>> essentially just providing a KVM_S390_SET_SIGP_BUSY *and*
>>>> providing
>>>> the
>>>> order. "order == 0" sets it to !busy.
>>>
>>> I'd tried this too, since it provided some nice debug-ability.
>>> Unfortunately, I have a testcase (which I'll eventually get folded
>>> into
>>> kvm-unit-tests :)) that picks a random order between 0-255, knowing
>>> that there's only a couple handfuls of valid orders, to check the
>>> response. Zero is valid architecturally (POPS figure 4-29), even if
>>> it's unassigned. The likelihood of it becoming assigned is probably
>>> quite low, but I'm not sure that I like special-casing an order of
>>> zero
>>> in this way.
>>>
>>
>> Looking at the API I'd like to avoid having two IOCTLs 
> 
> Since the order is a single byte, we could have the payload of an ioctl
> say "0-255 is an order that we're busy processing, anything higher than
> that resets the busy" or something. That would remove the need for a
> second IOCTL.

Maybe just pass an int and treat a negative (or just -1) value as
clearing the order.

-- 
Thanks,

David / dhildenb

