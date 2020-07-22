Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC1F2297AD
	for <lists+linux-s390@lfdr.de>; Wed, 22 Jul 2020 13:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGVLsk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 Jul 2020 07:48:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13464 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726462AbgGVLsk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 07:48:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MBWM5w052537;
        Wed, 22 Jul 2020 07:48:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vrr308-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:48:31 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06MBWXnx053701;
        Wed, 22 Jul 2020 07:48:30 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1vrr2yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 07:48:30 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06MBeoI8032571;
        Wed, 22 Jul 2020 11:48:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 32brq84yjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 11:48:28 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06MBl2TA66453950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 11:47:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FB71AE045;
        Wed, 22 Jul 2020 11:48:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DA1CAE04D;
        Wed, 22 Jul 2020 11:48:25 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.50.252])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 11:48:25 +0000 (GMT)
Subject: Re: [PATCH v7 2/2] s390: virtio: PV needs VIRTIO I/O device
 protection
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, cohuck@redhat.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
References: <1594801869-13365-1-git-send-email-pmorel@linux.ibm.com>
 <1594801869-13365-3-git-send-email-pmorel@linux.ibm.com>
 <20200715054807-mutt-send-email-mst@kernel.org>
 <bc5e09ad-faaf-8b38-83e0-5f4a4b1daeb0@redhat.com>
 <20200715074917-mutt-send-email-mst@kernel.org>
From:   Pierre Morel <pmorel@linux.ibm.com>
Message-ID: <be992b00-de1d-4499-ee7f-b2b2b5a8879d@linux.ibm.com>
Date:   Wed, 22 Jul 2020 13:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200715074917-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_04:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007220085
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2020-07-15 13:51, Michael S. Tsirkin wrote:
> On Wed, Jul 15, 2020 at 06:16:59PM +0800, Jason Wang wrote:
>>
>> On 2020/7/15 下午5:50, Michael S. Tsirkin wrote:
>>> On Wed, Jul 15, 2020 at 10:31:09AM +0200, Pierre Morel wrote:
>>>> If protected virtualization is active on s390, the virtio queues are
>>>> not accessible to the host, unless VIRTIO_F_IOMMU_PLATFORM has been
>>>> negotiated. Use the new arch_validate_virtio_features() interface to
>>>> fail probe if that's not the case, preventing a host error on access
>>>> attempt.
>>>>
>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>>>> Acked-by: Halil Pasic <pasic@linux.ibm.com>
>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>> ---
>>>>    arch/s390/mm/init.c | 28 ++++++++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>>>> index 6dc7c3b60ef6..d39af6554d4f 100644
>>>> --- a/arch/s390/mm/init.c
>>>> +++ b/arch/s390/mm/init.c
>>>> @@ -45,6 +45,7 @@
>>>>    #include <asm/kasan.h>
>>>>    #include <asm/dma-mapping.h>
>>>>    #include <asm/uv.h>
>>>> +#include <linux/virtio_config.h>
>>>>    pgd_t swapper_pg_dir[PTRS_PER_PGD] __section(.bss..swapper_pg_dir);
>>>> @@ -161,6 +162,33 @@ bool force_dma_unencrypted(struct device *dev)
>>>>    	return is_prot_virt_guest();
>>>>    }
>>>> +/*
>>>> + * arch_validate_virtio_features
>>>> + * @dev: the VIRTIO device being added
>>>> + *
>>>> + * Return an error if required features are missing on a guest running
>>>> + * with protected virtualization.
>>>> + */
>>>> +int arch_validate_virtio_features(struct virtio_device *dev)
>>>> +{
>>>> +	if (!is_prot_virt_guest())
>>>> +		return 0;
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "legacy virtio not supported with protected virtualization\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	if (!virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM)) {
>>>> +		dev_warn(&dev->dev,
>>>> +			 "support for limited memory access required for protected virtualization\n");
>>>> +		return -ENODEV;
>>>> +	}
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>    /* protected virtualization */
>>>>    static void pv_init(void)
>>>>    {
>>> What bothers me here is that arch code depends on virtio now.
>>> It works even with a modular virtio when functions are inline,
>>> but it seems fragile: e.g. it breaks virtio as an out of tree module,
>>> since layout of struct virtio_device can change.
>>
>>
>> The code was only called from virtio.c so it should be fine.
>>
>> And my understanding is that we don't need to care about the kABI issue
>> during upstream development?
>>
>> Thanks
> 
> No, but so far it has been convenient at least for me, for development,
> to just be able to unload all of virtio and load a different version.
> 
> 
>>
>>>
>>> I'm not sure what to do with this yet, will try to think about it
>>> over the weekend. Thanks!
>>>
>>>
>>>> -- 
>>>> 2.25.1
> 

Hi Michael,

I am not sure to understand the problem so I may propose a wrong 
solution but, let's try:

Would a callback registration instead of a weak function solve the problem?
The registrating function in core could test a parameter to check if the 
callback is in sync with the VIRTIO core.

What do you think?

Regards,
Pierre



-- 
Pierre Morel
IBM Lab Boeblingen
