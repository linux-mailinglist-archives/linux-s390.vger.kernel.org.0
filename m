Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A853D370C
	for <lists+linux-s390@lfdr.de>; Fri, 23 Jul 2021 10:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGWIKt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 23 Jul 2021 04:10:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59550 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGWIKs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 23 Jul 2021 04:10:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16N8i5mg001690;
        Fri, 23 Jul 2021 04:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=7Mw6M1FfyeA0yW1IvSvFRS8RzC+ijZYO/iYRJdNZ08A=;
 b=bAg5VyZ91PLCbp5A+ZN8ubSMTal/hF/L47uWQw/OxqdyG5IX0aciWgT1xg33g8tibO8V
 2FjxvrsAcRahvEEtgL1RSlq2G9GRFW1CEBGbgxCpZPuk229ew8Wz+MWFLMuQzFPQcbAj
 lT+CgR0FadI1FdGhkBZkh4Gj2S3g9f+ybYo/agWyyRcucuPzYUy6OjdHmey4MNgJoaMg
 rWms5YndmDRgdHXJFms4LBLSH4MbPGzTVIjTt3dBPX2mGRgT2zKtE2oGTLbO9HXq5ee3
 rb+/HQf8eMPCHVD37zcryHAhqtxIKqTWQuRYy5q+0ohnNm6kqt4+6q01RdhSa/rar44u yQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ytgtr55t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 04:51:03 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16N8Ytew004681;
        Fri, 23 Jul 2021 08:51:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 39upu89sds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jul 2021 08:51:01 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16N8ow4g31850904
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jul 2021 08:50:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88E7E11C05C;
        Fri, 23 Jul 2021 08:50:58 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 062FD11C058;
        Fri, 23 Jul 2021 08:50:58 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.25.128])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jul 2021 08:50:57 +0000 (GMT)
Subject: Re: [PATCH v2 0/4] Fix restricted DMA vs swiotlb_exit()
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Claire Chang <tientzu@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20210720133826.9075-1-will@kernel.org>
 <57e37ef9-c055-d6a6-2244-2c7dd243b5c1@de.ibm.com>
 <20210723031252.655d6a83.pasic@linux.ibm.com>
 <b8985c53-a83d-f11f-9fa8-af06d1d4bfd0@de.ibm.com>
 <20210723104701.3f8ac227.pasic@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <ab29cae0-2c1d-354a-5213-9fe4159570e0@de.ibm.com>
Date:   Fri, 23 Jul 2021 10:50:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210723104701.3f8ac227.pasic@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L_9om7czx_EFmzgSP-_5WhNqVECmt3Tj
X-Proofpoint-ORIG-GUID: L_9om7czx_EFmzgSP-_5WhNqVECmt3Tj
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-23_04:2021-07-23,2021-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107230049
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 23.07.21 10:47, Halil Pasic wrote:
> On Fri, 23 Jul 2021 08:14:19 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> Resending with the correct email of Heiko....
>>
>> On 23.07.21 03:12, Halil Pasic wrote:
>>> On Thu, 22 Jul 2021 21:22:58 +0200
>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>    
>>>> On 20.07.21 15:38, Will Deacon wrote:
>>>>> Hi again, folks,
>>>>>
>>>>> This is version two of the patch series I posted yesterday:
>>>>>
>>>>>      https://lore.kernel.org/r/20210719123054.6844-1-will@kernel.org
>>>>>
>>>>> The only changes since v1 are:
>>>>>
>>>>>      * Squash patches 2 and 3, amending the commit message accordingly
>>>>>      * Add Reviewed-by and Tested-by tags from Christoph and Claire (thanks!)
>>>>>
>>>>> I'd usually leave it a bit longer between postings, but since this fixes
>>>>> issues with patches in -next I thought I'd spin a new version immediately.
>>>>>
>>>>> Cheers,
>>>>
>>>> FWIW, I just bisected virtio-errors with secure execution mode
>>>> qemu-system-s390x: virtio-serial-bus: Unexpected port id 4205794771 for device virtio-serial0.0
>>>>
>>>> to
>>>> commit 903cd0f315fe426c6a64c54ed389de0becb663dc
>>>> Author: Claire Chang <tientzu@chromium.org>
>>>> Date:   Thu Jun 24 23:55:20 2021 +0800
>>>>
>>>>         swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
>>>>
>>>> Unfortunately this patch series does NOT fix this issue, so it seems that even more
>>>> things are broken.
>>>>
>>>> Any idea what else might be broken?
>>>
>>> I've done some debugging, and I think I know what is going on. Since
>>> that commit we need to set force_swiotlb before the swiotlb itself is
>>> initialized. So the patch below should fix the problem.
>>>
>>> --------------------8<-------------------------------------
>>>
>>> From: Halil Pasic <pasic@linux.ibm.com>
>>> Date: Fri, 23 Jul 2021 02:57:06 +0200
>>> Subject: [PATCH 1/1] s390/pv: fix the forcing of the swiotlb
>>>
>>> Since commit 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for
>>> swiotlb data bouncing") if code sets swiotlb_force it needs to do so
>>> before the swiotlb is initialised. Otherwise
>>> io_tlb_default_mem->force_bounce will not get set to true, and devices
>>> that use (the default) swiotlb will not bounce  despite switolb_force
>>> having the value of SWIOTLB_FORCE.
>>>
>>> Let us restore swiotlb functionality for PV by fulfilling this new
>>> requirement.
>>>    
>> I would add:
>> Fixes: 903cd0f315fe ("swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing")
>> as this patch breaks things
>> and
>> Fixes: 64e1f0c531d1 ("s390/mm: force swiotlb for protected virtualization")
>>
>> to make the s390 init code more robust in case people start backporting things.
> 
> I agree. Do we want this backported to the stable releases that have
> 64e1f0c531d1  (i.e. do we need a cc stable) or should the fixes tag just
> serve as metadata? My guess is, it's the former. In that sense should I
> add the tags along with an explanation for the second fixes respin with
> cc stable?
> 
> (BTW I don't think this formally qualifies for the stable backports, but
> I hope we can make an exception...)

I think it makes sense for stable as it is cleaner to set the flags before
calling the init function. cc stable would be better and the right way
according to process, but the Fixes tag is mostly enough.

> 
>>
>>> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>>
>> I can confirm that this fixes the problem. This also makes sense codewise.
>>
>> Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Thanks!
> 
> Regards,
> Halil
>>
>> Konrad, Heiko, Vasily, any preference which tree this goes? I think s390
>> would be easiest, but that requires that the patches in the swiotlb tree have
>> fixed commit IDs.
>>
>>> ---
>>>    arch/s390/mm/init.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>> index 8ac710de1ab1..07bbee9b7320 100644
>>> --- a/arch/s390/mm/init.c
>>> +++ b/arch/s390/mm/init.c
>>> @@ -186,9 +186,9 @@ static void pv_init(void)
>>>    		return;
>>>    
>>>    	/* make sure bounce buffers are shared */
>>> +	swiotlb_force = SWIOTLB_FORCE;
>>>    	swiotlb_init(1);
>>>    	swiotlb_update_mem_attributes();
>>> -	swiotlb_force = SWIOTLB_FORCE;
>>>    }
>>>    
>>>    void __init mem_init(void)
>>>    
> 
