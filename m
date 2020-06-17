Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9F51FD1C1
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jun 2020 18:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgFQQPC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Jun 2020 12:15:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726511AbgFQQPB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 17 Jun 2020 12:15:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HG2O91113581;
        Wed, 17 Jun 2020 12:15:00 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31qg6p5e5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 12:14:59 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05HG2Jsd113089;
        Wed, 17 Jun 2020 12:14:59 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31qg6p5e4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 12:14:58 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HGBHwi030547;
        Wed, 17 Jun 2020 16:14:56 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 31q6bs9bej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 16:14:56 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HGErQF12714460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 16:14:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3A2142041;
        Wed, 17 Jun 2020 16:14:53 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4787E42042;
        Wed, 17 Jun 2020 16:14:53 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.185.179])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jun 2020 16:14:53 +0000 (GMT)
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com> <20200616163510.GD11838@xz-x1>
 <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
 <20200617160617.GD76766@xz-x1>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 nS4h0HDFPrrp1C2EMVYIQrMokWvlFZbCpsdYbBI=
Message-ID: <8bd8dcf6-f2f0-d44e-9bf8-6fd4fe299aa9@de.ibm.com>
Date:   Wed, 17 Jun 2020 18:14:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617160617.GD76766@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_06:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 cotscore=-2147483648 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170122
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 17.06.20 18:06, Peter Xu wrote:
> Hi, Christian,
> 
> On Wed, Jun 17, 2020 at 08:19:29AM +0200, Christian Borntraeger wrote:
>>
>>
>> On 16.06.20 18:35, Peter Xu wrote:
>>> Hi, Alexander,
>>>
>>> On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
>>>>> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
>>>>>  	if (unlikely(fault & VM_FAULT_ERROR))
>>>>>  		goto out_up;
>>>>>
>>>>> -	/*
>>>>> -	 * Major/minor page fault accounting is only done on the
>>>>> -	 * initial attempt. If we go through a retry, it is extremely
>>>>> -	 * likely that the page will be found in page cache at that point.
>>>>> -	 */
>>>>>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
>>>>> -		if (fault & VM_FAULT_MAJOR) {
>>>>> -			tsk->maj_flt++;
>>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
>>>>> -				      regs, address);
>>>>> -		} else {
>>>>> -			tsk->min_flt++;
>>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
>>>>> -				      regs, address);
>>>>> -		}
>>>>>  		if (fault & VM_FAULT_RETRY) {
>>>>>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
>>>>>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> 
> [1]
> 
>>>>
>>>> Seems like the call to mm_fault_accounting() will be missed if
>>>> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
>>>> jumps to "out_up"...
>>>
>>> This is true as a functional change.  However that also means that we've got a
>>> VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
>>> than handled correctly (for instance, due to some try_lock failed during the
>>> fault process).
>>>
>>> To me, that case should not be counted as a page fault at all?  Or we might get
>>> the same duplicated accounting when the page fault retried from a higher stack.
>>>
>>> Thanks
>>
>> This case below (the one with the gmap) is the KVM case for doing a so called
>> pseudo page fault to our guests. (we notify our guests about major host page
>> faults and let it reschedule to something else instead of halting the vcpu).
>> This is being resolved with either gup or fixup_user_fault asynchronously by
>> KVM code (this can also be sync when the guest does not match some conditions)
>> We do not change the counters in that code as far as I can tell so we should
>> continue to do it here.
>>
>> (see arch/s390/kvm/kvm-s390.c
>> static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>> {
>> [...]
>>         } else if (current->thread.gmap_pfault) {
>>                 trace_kvm_s390_major_guest_pfault(vcpu);
>>                 current->thread.gmap_pfault = 0;
>>                 if (kvm_arch_setup_async_pf(vcpu))
>>                         return 0;
>>                 return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
>>         }
> 
> Please correct me if I'm wrong... but I still think what this patch does is the
> right thing to do.
> 
> Note again that IMHO when reached [1] above it means the page fault is not
> handled correctly so we need to fallback to KVM async page fault, then we
> shouldn't increment the accountings until it's finally handled correctly. That
> final accounting should be done in the async pf path in gup code where the page
> fault is handled:
> 
>   kvm_arch_fault_in_page
>     gmap_fault
>       fixup_user_fault
> 
> Where in fixup_user_fault() we have:
> 
> 	if (tsk) {
> 		if (major)
> 			tsk->maj_flt++;
> 		else
> 			tsk->min_flt++;
> 	}
> 

Right that case does work. Its the case where we do not inject a pseudo pagefault and
instead fall back to synchronous fault-in.
What is about the other case:

kvm_setup_async_pf
	->workqueue
		async_pf_execute
			get_user_pages_remote

Does get_user_pages_remote do the accounting as well? I cant see that.
