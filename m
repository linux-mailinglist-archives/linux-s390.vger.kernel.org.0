Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF855652DB
	for <lists+linux-s390@lfdr.de>; Mon,  4 Jul 2022 12:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiGDK5v (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 Jul 2022 06:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiGDK5u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Jul 2022 06:57:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F312B2F9;
        Mon,  4 Jul 2022 03:57:49 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 264ApZM7028898;
        Mon, 4 Jul 2022 10:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/JRU2GlMMJuPHWkVQ9EJtmnLuJ++GgsHr3lOZdHAhOI=;
 b=Cfsi/1SYgtccocPN4PeMSVc5KgInllspCxB17SpP4igVA6AffKd7xgHpzp7ufwpxOvU9
 bm/m5+YaJFg91igPX4MN1Fek13sraF53HdlVGKLbhrXLCInLFZuCt9M+Z6XJD8zqbeWD
 i9Y0VjxBrs+R40qfq3XEmH5L0ZUM2Rvh8Um6tv1bYPn0MX0fzbLVjygdUDDi7/dbguZ9
 EGRgwPeuqXDx/HpgsbK65FgMWEYPYCnmUuattwwZRmKAjn3DJds9RO0RRJJqFiBLL3e8
 4+OWP+SS3ZUWlZElbFEr5xV1mTTpwKHcafXDw5A3o9EGGEmHjhDH5khD1N/WnLHKi0J6 zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3xtw039k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 10:57:49 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 264ArU95005776;
        Mon, 4 Jul 2022 10:57:49 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3xtw038t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 10:57:48 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 264ApgDP013890;
        Mon, 4 Jul 2022 10:57:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3h2d9jakqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 10:57:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 264AvhTI19202438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 10:57:43 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36918A4040;
        Mon,  4 Jul 2022 10:57:43 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FFF9A4053;
        Mon,  4 Jul 2022 10:57:42 +0000 (GMT)
Received: from [9.171.11.185] (unknown [9.171.11.185])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 10:57:42 +0000 (GMT)
Message-ID: <038d7c59-0c9a-7667-cf74-83009e186b42@linux.ibm.com>
Date:   Mon, 4 Jul 2022 13:02:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v11 2/3] KVM: s390: guest support for topology function
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        david@redhat.com, thuth@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, wintera@linux.ibm.com,
        seiden@linux.ibm.com, nrb@linux.ibm.com
References: <20220701162559.158313-1-pmorel@linux.ibm.com>
 <20220701162559.158313-3-pmorel@linux.ibm.com>
 <579337ac-d040-197f-3553-7c8ff202623a@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <579337ac-d040-197f-3553-7c8ff202623a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gRdfwYnR0FSBK8ndMMQvx8Tr8Qqb2y4j
X-Proofpoint-ORIG-GUID: trD3fL7zvRswHcyFLTTwFEiIVObUyRMK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_09,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040045
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 7/4/22 11:08, Janis Schoetterl-Glausch wrote:
> On 7/1/22 18:25, Pierre Morel wrote:
>> We report a topology change to the guest for any CPU hotplug.
>>
>> The reporting to the guest is done using the Multiprocessor
>> Topology-Change-Report (MTCR) bit of the utility entry in the guest's
>> SCA which will be cleared during the interpretation of PTF.
>>
>> On every vCPU creation we set the MCTR bit to let the guest know the
>> next time he uses the PTF with command 2 instruction that the> topology changed and that he should use the STSI(15.1.x) instruction
> s/he/it (twice)
>> to get the topology details.
>>
>> STSI(15.1.x) gives information on the CPU configuration topology.
>> Let's accept the interception of STSI with the function code 15 and
>> let the userland part of the hypervisor handle it when userland
>> support the CPU Topology facility.And the user STSI capability.
> Also: supportS.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> Reviewed-by: Nico Boehr <nrb@linux.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h | 18 +++++++++++++---
>>   arch/s390/kvm/kvm-s390.c         | 36 ++++++++++++++++++++++++++++++++
>>   arch/s390/kvm/priv.c             | 16 ++++++++++----
>>   arch/s390/kvm/vsie.c             |  8 +++++++
>>   4 files changed, 71 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>> index 766028d54a3e..ae6bd3d607de 100644
>> --- a/arch/s390/include/asm/kvm_host.h
>> +++ b/arch/s390/include/asm/kvm_host.h
>> @@ -93,19 +93,30 @@ union ipte_control {
>>   	};
>>   };
>>   
> [...]
> 
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 8fcb56141689..ee59b03f2e45 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -1691,6 +1691,31 @@ static int kvm_s390_get_cpu_model(struct kvm *kvm, struct kvm_device_attr *attr)
>>   	return ret;
>>   }
>>   
>> +/**
>> + * kvm_s390_update_topology_change_report - update CPU topology change report
>> + * @kvm: guest KVM description
>> + * @val: set or clear the MTCR bit
>> + *
>> + * Updates the Multiprocessor Topology-Change-Report bit to signal
>> + * the guest with a topology change.
>> + * This is only relevant if the topology facility is present.
>> + *
>> + * The SCA version, bsca or esca, doesn't matter as offset is the same.
>> + */
>> +static void kvm_s390_update_topology_change_report(struct kvm *kvm, bool val)
>> +{
>> +	struct bsca_block *sca = kvm->arch.sca;
>> +	union sca_utility new, old;
>> +
>> +	read_lock(&kvm->arch.sca_lock);
> 
> You forgot to put the assignment of sca under the lock.

Should I really?
What we want to protect here is the content of the sca.
The sca itself does not change during the life of the KVM AFAIK.

> 
>> +	do {
>> +		old = READ_ONCE(sca->utility);
>> +		new = old;
>> +		new.mtcr = val;
>> +	} while (cmpxchg(&sca->utility.val, old.val, new.val) != old.val);
>> +	read_unlock(&kvm->arch.sca_lock);
>> +}
>> +
>>   static int kvm_s390_vm_set_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>>   {
>>   	int ret;
>> @@ -2877,6 +2902,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
>>   	kvm_clear_async_pf_completion_queue(vcpu);
>>   	if (!kvm_is_ucontrol(vcpu->kvm))
>>   		sca_del_vcpu(vcpu);
>> +	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
>>   
>>   	if (kvm_is_ucontrol(vcpu->kvm))
>>   		gmap_remove(vcpu->arch.gmap);
>> @@ -3272,6 +3298,14 @@ static int kvm_s390_vcpu_setup(struct kvm_vcpu *vcpu)
>>   		vcpu->arch.sie_block->ecb |= ECB_HOSTPROTINT;
>>   	if (test_kvm_facility(vcpu->kvm, 9))
>>   		vcpu->arch.sie_block->ecb |= ECB_SRSI;
>> +	/*
>> +	 * CPU Topology
>> +	 * This facility only uses the utility field of the SCA and none
>> +	 * of the cpu entries that are problematic with the other
>> +	 * interpretation facilities so we can pass it through.
>> +	 */
> 
> This is the comment for vsie.c

right

>> +	if (test_kvm_facility(vcpu->kvm, 11))
>> +		vcpu->arch.sie_block->ecb |= ECB_PTF;
>>   	if (test_kvm_facility(vcpu->kvm, 73))
>>   		vcpu->arch.sie_block->ecb |= ECB_TE;
>>   	if (!kvm_is_ucontrol(vcpu->kvm))
>> @@ -3403,6 +3437,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>>   	rc = kvm_s390_vcpu_setup(vcpu);
>>   	if (rc)
>>   		goto out_ucontrol_uninit;
>> +
>> +	kvm_s390_update_topology_change_report(vcpu->kvm, 1);
>>   	return 0;
>>   
>>   out_ucontrol_uninit:
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index 12c464c7cddf..046afee1be94 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -873,10 +873,13 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>   	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
>>   		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
>>   
>> -	if (fc > 3) {
>> -		kvm_s390_set_psw_cc(vcpu, 3);
>> -		return 0;
>> -	}
>> +	/* Bailout forbidden function codes */
>> +	if (fc > 3 && (fc != 15 || kvm_s390_pv_cpu_is_protected(vcpu)))
>> +		goto out_no_data;
>> +
>> +	/* fc 15 is provided with PTF/CPU topology support */
>> +	if (fc == 15 && !test_kvm_facility(vcpu->kvm, 11))
>> +		goto out_no_data;
>>   
>>   	if (vcpu->run->s.regs.gprs[0] & 0x0fffff00
>>   	    || vcpu->run->s.regs.gprs[1] & 0xffff0000)
>> @@ -910,6 +913,11 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
>>   			goto out_no_data;
>>   		handle_stsi_3_2_2(vcpu, (void *) mem);
>>   		break;
>> +	case 15: /* fc 15 is fully handled in userspace */
>> +		if (vcpu->kvm->arch.user_stsi)
>> +			insert_stsi_usr_data(vcpu, operand2, ar, fc, sel1, sel2);
>> +		trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
>> +		return -EREMOTE;
> 
> This doesn't look right to me, you still return -EREMOTE if user_stsi is false.
> The way I read the PoP here is that it is ok to set condition code 3 for the else case

Yes it is what I wanted to do.
I do not understand what I did here is stupid.


-- 
Pierre Morel
IBM Lab Boeblingen
