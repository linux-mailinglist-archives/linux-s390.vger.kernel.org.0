Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564734D143D
	for <lists+linux-s390@lfdr.de>; Tue,  8 Mar 2022 11:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345656AbiCHKHu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Mar 2022 05:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345633AbiCHKHq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Mar 2022 05:07:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EA642A03;
        Tue,  8 Mar 2022 02:06:49 -0800 (PST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228920Td003295;
        Tue, 8 Mar 2022 10:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=j/N/vhfOg+pIg3L0C07BIR5bJy+MUQ0Q1LwgTkzwZx4=;
 b=ED9gu6UFRdq+Mn1zOMSh0qFO8MJYo4CSQd/AXeQE4eLTJQEy1zg8BBvKGwE6/3/x4IcB
 BnqPyi0KkFTgqsbrIjiNCdvaHTYsoyT7NCfQxiuTuYqcWSxFHSi0uvKhkRAbXRh0q1+S
 DgM3P0/umi9wIbbNuWvSyvfh/42xqel3Lmvme3D0hq2RMfR1ccsG4d5yFbBaxCs8qtpV
 FNQ8XitNzqTpq8or3e44EZm2w+Ay1kCuz1D74DCqX4Y7Ma0BAyT6yOL4fllg6jhucKDE
 XftQBOy26AHQ5ZrY/MuHXvrpjyPMcMsOxUuPgMMtbrye47i64vaAlZYzENfujyUMcp6h 6g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enww78g2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:06:49 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2289G9V4032710;
        Tue, 8 Mar 2022 10:06:49 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enww78g1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:06:48 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228A3vDM031785;
        Tue, 8 Mar 2022 10:06:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg8y3wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 10:06:46 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228A6hBD51511590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 10:06:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 519B011C04A;
        Tue,  8 Mar 2022 10:06:43 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E650D11C052;
        Tue,  8 Mar 2022 10:06:42 +0000 (GMT)
Received: from [9.171.93.186] (unknown [9.171.93.186])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Mar 2022 10:06:42 +0000 (GMT)
Message-ID: <e8b39f16-211b-dc1c-0970-019b8375178c@de.ibm.com>
Date:   Tue, 8 Mar 2022 11:06:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 1/1] KVM: s390x: fix SCK locking
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        thuth@redhat.com, mimu@linux.ibm.com
References: <20220301143340.111129-1-imbrenda@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20220301143340.111129-1-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r59TqA4nLSseMfnDsUXh8w_FaPexOtOV
X-Proofpoint-GUID: fGjyXgU483M8V2sF_jUcp2oQjl5nwGeq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203080053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 01.03.22 um 15:33 schrieb Claudio Imbrenda:
> When handling the SCK instruction, the kvm lock is taken, even though
> the vcpu lock is already being held. The normal locking order is kvm
> lock first and then vcpu lock. This is can (and in some circumstances
> does) lead to deadlocks.
> 
> The function kvm_s390_set_tod_clock is called both by the SCK handler
> and by some IOCTLs to set the clock. The IOCTLs will not hold the vcpu
> lock, so they can safely take the kvm lock. The SCK handler holds the
> vcpu lock, but will also somehow need to acquire the kvm lock without
> relinquishing the vcpu lock.
> 
> The solution is to factor out the code to set the clock, and provide
> two wrappers. One is called like the original function and does the
> locking, the other is called kvm_s390_try_set_tod_clock and uses
> trylock to try to acquire the kvm lock. This new wrapper is then used
> in the SCK handler. If locking fails, -EAGAIN is returned, which is
> eventually propagated to userspace, thus also freeing the vcpu lock and
> allowing for forward progress.
> 
> This is not the most efficient or elegant way to solve this issue, but
> the SCK instruction is deprecated and its performance is not critical.
> 
> The goal of this patch is just to provide a simple but correct way to
> fix the bug.
> 
> Fixes: 6a3f95a6b04c ("KVM: s390: Intercept SCK instruction")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Thanks applied. I will also add cc stable when queueing.


> ---
>   arch/s390/kvm/kvm-s390.c | 19 ++++++++++++++++---
>   arch/s390/kvm/kvm-s390.h |  4 ++--
>   arch/s390/kvm/priv.c     | 14 +++++++++++++-
>   3 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 2296b1ff1e02..4e3db4004bfd 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -3869,14 +3869,12 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
>   	return 0;
>   }
>   
> -void kvm_s390_set_tod_clock(struct kvm *kvm,
> -			    const struct kvm_s390_vm_tod_clock *gtod)
> +static void __kvm_s390_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod)
>   {
>   	struct kvm_vcpu *vcpu;
>   	union tod_clock clk;
>   	unsigned long i;
>   
> -	mutex_lock(&kvm->lock);
>   	preempt_disable();
>   
>   	store_tod_clock_ext(&clk);
> @@ -3897,7 +3895,22 @@ void kvm_s390_set_tod_clock(struct kvm *kvm,
>   
>   	kvm_s390_vcpu_unblock_all(kvm);
>   	preempt_enable();
> +}
> +
> +void kvm_s390_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod)
> +{
> +	mutex_lock(&kvm->lock);
> +	__kvm_s390_set_tod_clock(kvm, gtod);
> +	mutex_unlock(&kvm->lock);
> +}
> +
> +int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod)
> +{
> +	if (!mutex_trylock(&kvm->lock))
> +		return 0;
> +	__kvm_s390_set_tod_clock(kvm, gtod);
>   	mutex_unlock(&kvm->lock);
> +	return 1;
>   }
>   
>   /**
> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
> index 098831e815e6..f2c910763d7f 100644
> --- a/arch/s390/kvm/kvm-s390.h
> +++ b/arch/s390/kvm/kvm-s390.h
> @@ -349,8 +349,8 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu);
>   int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
>   
>   /* implemented in kvm-s390.c */
> -void kvm_s390_set_tod_clock(struct kvm *kvm,
> -			    const struct kvm_s390_vm_tod_clock *gtod);
> +void kvm_s390_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
> +int kvm_s390_try_set_tod_clock(struct kvm *kvm, const struct kvm_s390_vm_tod_clock *gtod);
>   long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
>   int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
>   int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 417154b314a6..7f3e7990ef82 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -102,7 +102,19 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
>   		return kvm_s390_inject_prog_cond(vcpu, rc);
>   
>   	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", gtod.tod);
> -	kvm_s390_set_tod_clock(vcpu->kvm, &gtod);
> +	/*
> +	 * To set the TOD clock we need to take the kvm lock, but we are
> +	 * already holding the vcpu lock, and the usual lock order is the
> +	 * opposite. Therefore we use trylock instead of lock, and if the
> +	 * kvm lock cannot be taken, we retry the instruction and return
> +	 * -EAGAIN to userspace, thus freeing the vcpu lock.
> +	 * The SCK instruction is considered legacy and at this point it's
> +	 * not worth the effort to find a nicer solution.
> +	 */
> +	if (!kvm_s390_try_set_tod_clock(vcpu->kvm, &gtod)) {
> +		kvm_s390_retry_instr(vcpu);
> +		return -EAGAIN;
> +	}
>   
>   	kvm_s390_set_psw_cc(vcpu, 0);
>   	return 0;
