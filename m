Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB514B752E
	for <lists+linux-s390@lfdr.de>; Tue, 15 Feb 2022 21:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiBOR3A (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Feb 2022 12:29:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237354AbiBOR27 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Feb 2022 12:28:59 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315BDA865;
        Tue, 15 Feb 2022 09:28:49 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21FGb7Ib026587;
        Tue, 15 Feb 2022 17:28:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=opXGb8J086hkWI2leIrsD0GFmHKCtGTaFCQKZyjNoyA=;
 b=ZWAS02WBVBiQdxDLZV9v/eOdQhSJZwCn7ydEBkp9L/qLRZNFml9Y15PF0ZWOvhL+oY/0
 +p3njYKA6ts/r9uDSASjyuvaAuAZ3Vfr+ROOtmT4OvK+flD1UdroMqv6UAJU5pzI2Euj
 oX00yfG457e61h5pFlMOs96ERZw8/NZamcW7kNhHP7yyCPARsg5Hqn1+v63s5Mi10oDW
 urV7efVNQg1nV4rcOxde2Kfy51RXAU1XRY/WPhjK7go7a0dZqksZgFd8JFsDy9q1u3yn
 AnIvLjNCX7ocS0nzFEAuvM9FgYUfWb+Ku2EdzTZ2+eXJx03FXMpl7RAF1iXMHaREJnXY zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8f1s2hgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:28:48 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21FGoRAC021399;
        Tue, 15 Feb 2022 17:28:48 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e8f1s2hfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:28:48 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21FH82TU032142;
        Tue, 15 Feb 2022 17:28:45 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 3e64h9g84s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 17:28:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21FHSeiU42926482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Feb 2022 17:28:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FFA9A405C;
        Tue, 15 Feb 2022 17:28:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1A29A4054;
        Tue, 15 Feb 2022 17:28:39 +0000 (GMT)
Received: from [9.171.31.140] (unknown [9.171.31.140])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Feb 2022 17:28:39 +0000 (GMT)
Message-ID: <211983e2-5e03-70d6-c5e2-db702ebfb0a4@linux.ibm.com>
Date:   Tue, 15 Feb 2022 18:30:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [kvm-unit-tests PATCH 1/1] s390x: stsi: Define vm_is_kvm to be
 used in different tests
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, thuth@redhat.com, kvm@vger.kernel.org,
        cohuck@redhat.com, david@redhat.com, nrb@linux.ibm.com
References: <20220215104632.47796-1-pmorel@linux.ibm.com>
 <20220215104632.47796-2-pmorel@linux.ibm.com>
 <20220215130606.2d4f2ebb@p-imbrenda>
 <f7d7423b-c0fb-4184-6d3a-fa1d855e0f19@linux.ibm.com>
 <20220215162154.6ebd2567@p-imbrenda>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220215162154.6ebd2567@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rjMgw3k6Exu78-Jbnnls8tF19pH-QH5_
X-Proofpoint-GUID: S2HwG9Z9cb2rHL_Pyv0IdWCx-_qCbJmO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_04,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 impostorscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202150100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2/15/22 16:21, Claudio Imbrenda wrote:
> On Tue, 15 Feb 2022 16:08:16 +0100
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 2/15/22 13:06, Claudio Imbrenda wrote:
>>> On Tue, 15 Feb 2022 11:46:32 +0100
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> Several tests are in need of a way to check on which hypervisor
>>>> and virtualization level they are running on to be able to fence
>>>> certain tests. This patch adds functions that return true if a
>>>> vm is running under KVM, LPAR or generally as a level 2 guest.
>>>>
>>>> To check if we're running under KVM we use the STSI 3.2.2
>>>> instruction, let's define it's response structure in a central
>>>> header.
>>>>   
>>>
>>> sorry, I had replied to the old series, let me reply here too
>>>
>>>
>>> I think it would look cleaner if there was only one
>>> "detect_environment" function, that would call stsi once and detect the
>>> environment, then the various vm_is_* would become something like
>>>
>>> bool vm_is_*(void)
>>> {
>>> 	return detect_environment() == VM_IS_*;
>>> }
>>>
>>> of course detect_environment would also cache the result with static
>>> variables.
>>>
>>> bonus, we could make that function public, so a testcase could just
>>> switch over the type of hypervisor it's being run on, instead of having
>>> to use a series of ifs.
>>>
>>> and then maybe the various vm_is_* could become static inlines to be put
>>> in the header.
>>>
>>> please note that "detect_environment" is just the first thing that came
>>> to my mind, I have no preference regarding the name.
>>
>> I'd like to keep this patch as simple as possible because there are
>> multiple patch sets which are gated by it.
>>
>> The vm.h code and the skey.c z/VM 6 check is a thorn in my side anyway
>> and I'd rather have it fixed properly which will likely result in a lot
>> of opinions being voiced.
>>
>> So I'd propose to rename vm_is_vm() to vm_is_guest2() and pick this patch.
> 
> ok for me
> 
> I'll rename the function and queue the patch
> 

Not OK for me, in the POP PTF do not do any difference between guest 2 
and guest 3.

Or do you want to implement a VSIE specificity ?


>>
>>>    
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> ---
>>>>    lib/s390x/stsi.h | 32 ++++++++++++++++++++++++++++
>>>>    lib/s390x/vm.c   | 55 ++++++++++++++++++++++++++++++++++++++++++++++--
>>>>    lib/s390x/vm.h   |  3 +++
>>>>    s390x/stsi.c     | 23 ++------------------
>>>>    4 files changed, 90 insertions(+), 23 deletions(-)
>>>>    create mode 100644 lib/s390x/stsi.h
>>>>
>>>> diff --git a/lib/s390x/stsi.h b/lib/s390x/stsi.h
>>>> new file mode 100644
>>>> index 00000000..bebc492d
>>>> --- /dev/null
>>>> +++ b/lib/s390x/stsi.h
>>>> @@ -0,0 +1,32 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +/*
>>>> + * Structures used to Store System Information
>>>> + *
>>>> + * Copyright IBM Corp. 2022
>>>> + */
>>>> +
>>>> +#ifndef _S390X_STSI_H_
>>>> +#define _S390X_STSI_H_
>>>> +
>>>> +struct sysinfo_3_2_2 {
>>>> +	uint8_t reserved[31];
>>>> +	uint8_t count;
>>>> +	struct {
>>>> +		uint8_t reserved2[4];
>>>> +		uint16_t total_cpus;
>>>> +		uint16_t conf_cpus;
>>>> +		uint16_t standby_cpus;
>>>> +		uint16_t reserved_cpus;
>>>> +		uint8_t name[8];
>>>> +		uint32_t caf;
>>>> +		uint8_t cpi[16];
>>>> +		uint8_t reserved5[3];
>>>> +		uint8_t ext_name_encoding;
>>>> +		uint32_t reserved3;
>>>> +		uint8_t uuid[16];
>>>> +	} vm[8];
>>>> +	uint8_t reserved4[1504];
>>>> +	uint8_t ext_names[8][256];
>>>> +};
>>>> +
>>>> +#endif  /* _S390X_STSI_H_ */
>>>> diff --git a/lib/s390x/vm.c b/lib/s390x/vm.c
>>>> index a5b92863..91acd05b 100644
>>>> --- a/lib/s390x/vm.c
>>>> +++ b/lib/s390x/vm.c
>>>> @@ -12,6 +12,7 @@
>>>>    #include <alloc_page.h>
>>>>    #include <asm/arch_def.h>
>>>>    #include "vm.h"
>>>> +#include "stsi.h"
>>>>    
>>>>    /**
>>>>     * Detect whether we are running with TCG (instead of KVM)
>>>> @@ -26,9 +27,13 @@ bool vm_is_tcg(void)
>>>>    	if (initialized)
>>>>    		return is_tcg;
>>>>    
>>>> +	if (!vm_is_vm()) {
>>>> +		initialized = true;
>>>> +		return is_tcg;
>>>> +	}
>>>> +
>>>>    	buf = alloc_page();
>>>> -	if (!buf)
>>>> -		return false;
>>>> +	assert(buf);
>>>>    
>>>>    	if (stsi(buf, 1, 1, 1))
>>>>    		goto out;
>>>> @@ -43,3 +48,49 @@ out:
>>>>    	free_page(buf);
>>>>    	return is_tcg;
>>>>    }
>>>> +
>>>> +/**
>>>> + * Detect whether we are running with KVM
>>>> + */
>>>> +bool vm_is_kvm(void)
>>>> +{
>>>> +	/* EBCDIC for "KVM/" */
>>>> +	const uint8_t kvm_ebcdic[] = { 0xd2, 0xe5, 0xd4, 0x61 };
>>>> +	static bool initialized;
>>>> +	static bool is_kvm;
>>>> +	struct sysinfo_3_2_2 *stsi_322;
>>>> +
>>>> +	if (initialized)
>>>> +		return is_kvm;
>>>> +
>>>> +	if (!vm_is_vm() || vm_is_tcg()) {
>>>> +		initialized = true;
>>>> +		return is_kvm;
>>>> +	}
>>>> +
>>>> +	stsi_322 = alloc_page();
>>>> +	assert(stsi_322);
>>>> +
>>>> +	if (stsi(stsi_322, 3, 2, 2))
>>>> +		goto out;
>>>> +
>>>> +	/*
>>>> +	 * If the manufacturer string is "KVM/" in EBCDIC, then we
>>>> +	 * are on KVM.
>>>> +	 */
>>>> +	is_kvm = !memcmp(&stsi_322->vm[0].cpi, kvm_ebcdic, sizeof(kvm_ebcdic));
>>>> +	initialized = true;
>>>> +out:
>>>> +	free_page(stsi_322);
>>>> +	return is_kvm;
>>>> +}
>>>> +
>>>> +bool vm_is_lpar(void)
>>>> +{
>>>> +	return stsi_get_fc() == 2;
>>>> +}
>>>> +
>>>> +bool vm_is_vm(void)
>>>> +{
>>>> +	return stsi_get_fc() == 3;
>>>> +}
>>>> diff --git a/lib/s390x/vm.h b/lib/s390x/vm.h
>>>> index 7abba0cc..3aaf76af 100644
>>>> --- a/lib/s390x/vm.h
>>>> +++ b/lib/s390x/vm.h
>>>> @@ -9,5 +9,8 @@
>>>>    #define _S390X_VM_H_
>>>>    
>>>>    bool vm_is_tcg(void);
>>>> +bool vm_is_kvm(void);
>>>> +bool vm_is_vm(void);
>>>> +bool vm_is_lpar(void);
>>>>    
>>>>    #endif  /* _S390X_VM_H_ */
>>>> diff --git a/s390x/stsi.c b/s390x/stsi.c
>>>> index 391f8849..dccc53e7 100644
>>>> --- a/s390x/stsi.c
>>>> +++ b/s390x/stsi.c
>>>> @@ -13,27 +13,8 @@
>>>>    #include <asm/asm-offsets.h>
>>>>    #include <asm/interrupt.h>
>>>>    #include <smp.h>
>>>> +#include <stsi.h>
>>>>    
>>>> -struct stsi_322 {
>>>> -	uint8_t reserved[31];
>>>> -	uint8_t count;
>>>> -	struct {
>>>> -		uint8_t reserved2[4];
>>>> -		uint16_t total_cpus;
>>>> -		uint16_t conf_cpus;
>>>> -		uint16_t standby_cpus;
>>>> -		uint16_t reserved_cpus;
>>>> -		uint8_t name[8];
>>>> -		uint32_t caf;
>>>> -		uint8_t cpi[16];
>>>> -		uint8_t reserved5[3];
>>>> -		uint8_t ext_name_encoding;
>>>> -		uint32_t reserved3;
>>>> -		uint8_t uuid[16];
>>>> -	} vm[8];
>>>> -	uint8_t reserved4[1504];
>>>> -	uint8_t ext_names[8][256];
>>>> -};
>>>>    static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
>>>>    
>>>>    static void test_specs(void)
>>>> @@ -91,7 +72,7 @@ static void test_3_2_2(void)
>>>>    	/* EBCDIC for "KVM/" */
>>>>    	const uint8_t cpi_kvm[] = { 0xd2, 0xe5, 0xd4, 0x61 };
>>>>    	const char vm_name_ext[] = "kvm-unit-test";
>>>> -	struct stsi_322 *data = (void *)pagebuf;
>>>> +	struct sysinfo_3_2_2 *data = (void *)pagebuf;
>>>>    
>>>>    	report_prefix_push("3.2.2");
>>>>      
>>>    
>>
> 

-- 
Pierre Morel
IBM Lab Boeblingen
