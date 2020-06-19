Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8E7201A9C
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2020 20:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbgFSSqV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Jun 2020 14:46:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61672 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731358AbgFSSqV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 14:46:21 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05JIW8wF094575;
        Fri, 19 Jun 2020 14:46:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31s2p4gcav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 14:46:19 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05JIWjMR097170;
        Fri, 19 Jun 2020 14:46:19 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31s2p4gcaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 14:46:19 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05JIZdQH010617;
        Fri, 19 Jun 2020 18:46:18 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 31rdtffng4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jun 2020 18:46:18 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05JIkGgv46137838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 18:46:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B4542805A;
        Fri, 19 Jun 2020 18:46:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0BF72805E;
        Fri, 19 Jun 2020 18:46:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.172.102])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 19 Jun 2020 18:46:15 +0000 (GMT)
Subject: Re: [PATCH v8 2/2] s390/kvm: diagnose 0x318 sync and reset
To:     David Hildenbrand <david@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        cohuck@redhat.com, imbrenda@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com
References: <91933f00-476b-7e94-29e6-99f96abd5fc3@linux.ibm.com>
 <3CD269AF-2179-4380-96D0-9A9C551A6153@redhat.com>
From:   Collin Walling <walling@linux.ibm.com>
Message-ID: <b0d05a70-862d-a2f7-c13c-6c99090f849a@linux.ibm.com>
Date:   Fri, 19 Jun 2020 14:46:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3CD269AF-2179-4380-96D0-9A9C551A6153@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-19_20:2020-06-19,2020-06-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 cotscore=-2147483648 bulkscore=0 phishscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190133
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 6/19/20 2:13 PM, David Hildenbrand wrote:
> 
> 
>> Am 19.06.2020 um 19:56 schrieb Collin Walling <walling@linux.ibm.com>:
>>
>> ﻿On 6/19/20 1:17 PM, David Hildenbrand wrote:
>>>> On 19.06.20 17:47, Collin Walling wrote:
>>>> On 6/19/20 10:52 AM, David Hildenbrand wrote:
>>>>> On 19.06.20 00:22, Collin Walling wrote:
>>>>>> DIAGNOSE 0x318 (diag318) sets information regarding the environment
>>>>>> the VM is running in (Linux, z/VM, etc) and is observed via
>>>>>> firmware/service events.
>>>>>>
>>>>>> This is a privileged s390x instruction that must be intercepted by
>>>>>> SIE. Userspace handles the instruction as well as migration. Data
>>>>>> is communicated via VCPU register synchronization.
>>>>>>
>>>>>> The Control Program Name Code (CPNC) is stored in the SIE block. The
>>>>>> CPNC along with the Control Program Version Code (CPVC) are stored
>>>>>> in the kvm_vcpu_arch struct.
>>>>>>
>>>>>> The CPNC is shadowed/unshadowed in VSIE.
>>>>>>
>>>>>
>>>>> [...]
>>>>>
>>>>>>
>>>>>> int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
>>>>>> @@ -4194,6 +4198,10 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>>>>        if (vcpu->arch.pfault_token == KVM_S390_PFAULT_TOKEN_INVALID)
>>>>>>            kvm_clear_async_pf_completion_queue(vcpu);
>>>>>>    }
>>>>>> +    if (kvm_run->kvm_dirty_regs & KVM_SYNC_DIAG318) {
>>>>>> +        vcpu->arch.diag318_info.val = kvm_run->s.regs.diag318;
>>>>>> +        vcpu->arch.sie_block->cpnc = vcpu->arch.diag318_info.cpnc;
>>>>>> +    }
>>>>>>    /*
>>>>>>     * If userspace sets the riccb (e.g. after migration) to a valid state,
>>>>>>     * we should enable RI here instead of doing the lazy enablement.
>>>>>> @@ -4295,6 +4303,7 @@ static void store_regs_fmt2(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
>>>>>>    kvm_run->s.regs.pp = vcpu->arch.sie_block->pp;
>>>>>>    kvm_run->s.regs.gbea = vcpu->arch.sie_block->gbea;
>>>>>>    kvm_run->s.regs.bpbc = (vcpu->arch.sie_block->fpf & FPF_BPBC) == FPF_BPBC;
>>>>>> +    kvm_run->s.regs.diag318 = vcpu->arch.diag318_info.val;
>>>>>>    if (MACHINE_HAS_GS) {
>>>>>>        __ctl_set_bit(2, 4);
>>>>>>        if (vcpu->arch.gs_enabled)
>>>>>> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
>>>>>> index 9e9056cebfcf..ba83d0568bc7 100644
>>>>>> --- a/arch/s390/kvm/vsie.c
>>>>>> +++ b/arch/s390/kvm/vsie.c
>>>>>> @@ -423,6 +423,8 @@ static void unshadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
>>>>>>        break;
>>>>>>    }
>>>>>>
>>>>>> +    scb_o->cpnc = scb_s->cpnc;
>>>>>
>>>>> "This is a privileged s390x instruction that must be intercepted", how
>>>>> can the cpnc change, then, while in SIE?
>>>>>
>>>>> Apart from that LGTM.
>>>>>
>>>>
>>>> I thought shadow/unshadow was a load/store (respectively) when executing
>>>> in SIE for a level 3+ guest (where LPAR is level 1)?
>>>>
>>>> * Shadow SCB (load shadow VSIE page; originally CPNC is 0)
>>>
>>> 1. Here, you copy the cpnc from the pinned (original) SCB to the shadow SCB.
>>>
>>>>
>>>> * Execute diag318 (under SIE)
>>>
>>> 2. Here the SIE runs using the shadow SCB.
>>>
>>>>
>>>> * Unshadow SCB (store in original VSIE page; CPNC is whatever code the
>>>> guest decided to set)
>>>
>>> 3. Here you copy back the cpnc from the shadow SCB to the pinned
>>> (original) SCB.
>>>
>>>
>>> If 2. cannot modify the cpnc residing in the shadow SCB, 3. can be
>>> dropped, because the values will always match.
>>>
>>>
>>> If guest3 tries to modify the cpnc (via diag 318), we exit the SIE
>>> (intercept) in 2., return to our guest 2. guest 2 will perform the
>>> change and adapt the original SCB.
>>>
>>> (yep, it's confusing)
>>>
>>> Or did I miss anything?
>>>
>>
>> Ah, I see. So the shadowing isn't necessarily for SIE block values, but
>> for storing the register / PSW / clock states, as well as facility bits
>> for the level 3+ guests? Looking at what the
> 
> We have to forward all values the SIE has to see and copy back only what could have been changed by the SIE.
> 
>> vsie code does, that seems
>> to make sense.
>>
>> So we don't need to shadow OR unshadow the CPNC, then?
> 
> I think you have to shadow (forward the value) but not unshadow (value cannot change).
> 
> Cheers!
> 

Gotcha. Very tricky. I'll have to study on it some more. Thanks for the
info!

Take care.

>>
>> -- 
>> Regards,
>> Collin
>>
>> Stay safe and stay healthy
>>
> 


-- 
Regards,
Collin

Stay safe and stay healthy
