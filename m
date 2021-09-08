Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE591403A21
	for <lists+linux-s390@lfdr.de>; Wed,  8 Sep 2021 14:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbhIHMxT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Sep 2021 08:53:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62912 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346153AbhIHMxT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Sep 2021 08:53:19 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 188CXKWc168550;
        Wed, 8 Sep 2021 08:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=S18rahtjgCFUjUFwVEitjwK8LiYm/yk+g1sXfgfi+do=;
 b=sxDByZxeUuV9lMC47wTOZGoHAO8xWdpDYCPmJBuZkmKOzpJMPMDArTW8XstAh8LG6O7m
 29PoDUzzSzMuvP6uvWGp4UjPBmTglLcpDPLl0qdQvOTkohro832Y7y2+YhwbmLZCiWwc
 E7wdj6/96sZ+rAyOVs13WJAiVRCNdWdgD2BFnAr+X7r/j3U35vc1COyLSaLkpC0bQhXm
 IDM4++IbyW+5SwigUbTt0cubyFHLSz2yZRdWw6/DAUTAagAP/yy9l7/JNVfh3JqSXFgj
 I+h8v2AbSG8SmOV1zvU9jJzeub0XbxibtZ6s1oh5XemOG5QXOieGp/QZJ80rj3yHmviA 2Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axrd4gbjk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 08:52:10 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 188CY5DY172108;
        Wed, 8 Sep 2021 08:52:10 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3axrd4gbj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 08:52:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 188ClMas010831;
        Wed, 8 Sep 2021 12:52:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3axcnp8vam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 12:52:08 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 188ClkI951970530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 12:47:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7D4EA405C;
        Wed,  8 Sep 2021 12:52:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B2B1A4066;
        Wed,  8 Sep 2021 12:52:04 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.52.8])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Sep 2021 12:52:04 +0000 (GMT)
Subject: Re: [PATCH v3 2/3] s390x: KVM: Implementation of Multiprocessor
 Topology-Change-Report
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        frankja@linux.ibm.com, cohuck@redhat.com, thuth@redhat.com,
        imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <1627979206-32663-1-git-send-email-pmorel@linux.ibm.com>
 <1627979206-32663-3-git-send-email-pmorel@linux.ibm.com>
 <d85a6998-0f86-44d9-4eae-3051b65c2b4e@redhat.com>
 <59ff09e8-6975-20c2-78de-282585e2953d@linux.ibm.com>
 <66754109-4b35-f6e5-3db7-654d8b67392e@de.ibm.com>
 <d76697e5-d7fb-4210-234a-7b3482e7babc@linux.ibm.com>
 <461c895b-d25a-7dba-4c06-235235e18f1b@de.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <316097be-81f6-4667-0245-a32d62b19a25@linux.ibm.com>
Date:   Wed, 8 Sep 2021 14:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <461c895b-d25a-7dba-4c06-235235e18f1b@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7-h6HByKwyzx1FcdA5_buRt5u8g2kC8O
X-Proofpoint-ORIG-GUID: f6ybdRWYhytpRKzz-NmKsqXNel4GlzHh
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-08_06:2021-09-07,2021-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 clxscore=1011 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080080
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 9/8/21 2:01 PM, Christian Borntraeger wrote:
> 
> 
> On 08.09.21 14:00, Pierre Morel wrote:
>>
>>
>> On 9/8/21 9:04 AM, Christian Borntraeger wrote:
>>>
>>>
>>> On 07.09.21 12:24, Pierre Morel wrote:
>>>>
>>>>
>>>> On 9/6/21 8:37 PM, David Hildenbrand wrote:
>>>>> On 03.08.21 10:26, Pierre Morel wrote:
>>>>>> We let the userland hypervisor know if the machine support the CPU
>>>>>> topology facility using a new KVM capability: 
>>>>>> KVM_CAP_S390_CPU_TOPOLOGY.
>>>>>>
>>>>>> The PTF instruction will report a topology change if there is any 
>>>>>> change
>>>>>> with a previous STSI_15_2 SYSIB.
>>>>>> Changes inside a STSI_15_2 SYSIB occur if CPU bits are set or clear
>>>>>> inside the CPU Topology List Entry CPU mask field, which happens with
>>>>>> changes in CPU polarization, dedication, CPU types and adding or
>>>>>> removing CPUs in a socket.
>>>>>>
>>>>>> The reporting to the guest is done using the Multiprocessor
>>>>>> Topology-Change-Report (MTCR) bit of the utility entry of the guest's
>>>>>> SCA which will be cleared during the interpretation of PTF.
>>>>>>
>>>>>> To check if the topology has been modified we use a new field of the
>>>>>> arch vCPU to save the previous real CPU ID at the end of a schedule
>>>>>> and verify on next schedule that the CPU used is in the same socket.
>>>>>>
>>>>>> We deliberatly ignore:
>>>>>> - polarization: only horizontal polarization is currently used in 
>>>>>> linux.
>>>>>> - CPU Type: only IFL Type are supported in Linux
>>>>>> - Dedication: we consider that only a complete dedicated CPU stack 
>>>>>> can
>>>>>>    take benefit of the CPU Topology.
>>>>>>
>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>
>>>>>
>>>>>> @@ -228,7 +232,7 @@ struct kvm_s390_sie_block {
>>>>>>       __u8    icptcode;        /* 0x0050 */
>>>>>>       __u8    icptstatus;        /* 0x0051 */
>>>>>>       __u16    ihcpu;            /* 0x0052 */
>>>>>> -    __u8    reserved54;        /* 0x0054 */
>>>>>> +    __u8    mtcr;            /* 0x0054 */
>>>>>>   #define IICTL_CODE_NONE         0x00
>>>>>>   #define IICTL_CODE_MCHK         0x01
>>>>>>   #define IICTL_CODE_EXT         0x02
>>>>>> @@ -246,6 +250,7 @@ struct kvm_s390_sie_block {
>>>>>>   #define ECB_TE        0x10
>>>>>>   #define ECB_SRSI    0x04
>>>>>>   #define ECB_HOSTPROTINT    0x02
>>>>>> +#define ECB_PTF        0x01
>>>>>
>>>>>  From below I understand, that ECB_PTF can be used with stfl(11) in 
>>>>> the hypervisor.
>>>>>
>>>>> What is to happen if the hypervisor doesn't support stfl(11) and we 
>>>>> consequently cannot use ECB_PTF? Will QEMU be able to emulate PTF 
>>>>> fully?
>>>>
>>>> Yes.
>>>
>>> Do we want that? I do not think so. Other OSes (like zOS) do use PTF 
>>> in there low level interrupt handler, so PTF must be really fast.
>>> I think I would prefer that in that case the guest will simply not 
>>> see stfle(11).
>>> So the user can still specify the topology but the guest will have no 
>>> interface to query it.
>>
>> I do not understand.
>> If the host support stfle(11) we interpret PTF.
>>
>> The proposition was to emulate only in the case it is not supported, 
>> what you propose is to not advertise stfl(11) if the host does not 
>> support it, and consequently to never emulate is it right?
> 
> Yes, exactly. My idea is to provide it to guests if we can do it fast, 
> but do not provide it if it would add a performance issue.

OK, understood, I will update this and the QEMU part too as we do not 
need emulation there anymore.

Thanks,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
