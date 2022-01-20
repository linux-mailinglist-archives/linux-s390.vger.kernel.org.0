Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF08494AFE
	for <lists+linux-s390@lfdr.de>; Thu, 20 Jan 2022 10:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359624AbiATJpz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 20 Jan 2022 04:45:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229545AbiATJpz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 Jan 2022 04:45:55 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20K93jMi006002;
        Thu, 20 Jan 2022 09:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=m2UnY34z1fLdUSsd0XKoRjMMXPuxyH2F26o9GksoHmk=;
 b=Bvpn8LdftFfXN9YO1yDdb0ss/PdZ7s1c6anhvrwgENoZmxpl3zvvGa/JtTiFcO+OyWxp
 Mzr9FkNEO3v/pv6b4Rji30Dtih5iGE56pxQUaX8fhge77T5458jYPLSjdxpFRY55jZaL
 bYmaT2VXe3MmcWVTKmwh1FnCXSjw34+mjv4ZZEKKZLxP0q5fL9uCiH6GHass6UPi8BW1
 79jeRrOdis8vJpBt400rqpYmQqVP8uvK018XVJP3OzybCiu5HSyjyYqDlcVXAdHArtY8
 4XdlNeVB3e7HIHVvBjer3XR4kNjaYTSHrwDC3yWiFRxgwTy3F1I2KPfekHFeXbqMFuj4 Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq22h3waq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 09:45:54 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20K968W1013322;
        Thu, 20 Jan 2022 09:45:54 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dq22h3w9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 09:45:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20K9VwW0009737;
        Thu, 20 Jan 2022 09:45:51 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3dknw9nkvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 09:45:51 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20K9jliZ43450842
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 09:45:47 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03D9BAE055;
        Thu, 20 Jan 2022 09:45:47 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EB536AE058;
        Thu, 20 Jan 2022 09:45:45 +0000 (GMT)
Received: from [9.171.87.242] (unknown [9.171.87.242])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jan 2022 09:45:45 +0000 (GMT)
Message-ID: <dcfe1661-0779-6c50-6126-e9d0609e3911@linux.ibm.com>
Date:   Thu, 20 Jan 2022 10:47:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 21/30] KVM: s390: pci: handle refresh of PCI
 translations
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220114203145.242984-1-mjrosato@linux.ibm.com>
 <20220114203145.242984-22-mjrosato@linux.ibm.com>
 <265e3448-2e8e-c38b-e625-1546ae3d408b@linux.ibm.com>
 <3d8c05d7-79ec-dfa8-bfcb-b8888183612a@linux.ibm.com>
 <cebcc3de-e332-6381-f450-a6a26ef88182@linux.ibm.com>
 <bbd5a23e-0f83-cc35-5ea1-79ce015d2105@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <bbd5a23e-0f83-cc35-5ea1-79ce015d2105@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lqGiQmUkD8JYe7c6VMyjEn5V7AEmBjxt
X-Proofpoint-ORIG-GUID: 5gRLWhVQka7NcHIaY2SFt87d6112DZTM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_03,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200048
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/19/22 21:02, Matthew Rosato wrote:
> On 1/19/22 1:25 PM, Pierre Morel wrote:
>>
>>
>> On 1/19/22 17:39, Matthew Rosato wrote:
>>> On 1/19/22 4:29 AM, Pierre Morel wrote:
>>>>
>>>>
>>>> On 1/14/22 21:31, Matthew Rosato wrote:
>>> ...
>>>>> +static int dma_table_shadow(struct kvm_vcpu *vcpu, struct zpci_dev 
>>>>> *zdev,
>>>>> +                dma_addr_t dma_addr, size_t size)
>>>>> +{
>>>>> +    unsigned int nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>>>>> +    struct kvm_zdev *kzdev = zdev->kzdev;
>>>>> +    unsigned long *entry, *gentry;
>>>>> +    int i, rc = 0, rc2;
>>>>> +
>>>>> +    if (!nr_pages || !kzdev)
>>>>> +        return -EINVAL;
>>>>> +
>>>>> +    mutex_lock(&kzdev->ioat.lock);
>>>>> +    if (!zdev->dma_table || !kzdev->ioat.head[0]) {
>>>>> +        rc = -EINVAL;
>>>>> +        goto out_unlock;
>>>>> +    }
>>>>> +
>>>>> +    for (i = 0; i < nr_pages; i++) {
>>>>> +        gentry = dma_walk_guest_cpu_trans(vcpu, &kzdev->ioat, 
>>>>> dma_addr);
>>>>> +        if (!gentry)
>>>>> +            continue;
>>>>> +        entry = dma_walk_cpu_trans(zdev->dma_table, dma_addr);
>>>>> +
>>>>> +        if (!entry) {
>>>>> +            rc = -ENOMEM;
>>>>> +            goto out_unlock;
>>>>> +        }
>>>>> +
>>>>> +        rc2 = dma_shadow_cpu_trans(vcpu, entry, gentry);
>>>>> +        if (rc2 < 0) {
>>>>> +            rc = -EIO;
>>>>> +            goto out_unlock;
>>>>> +        }
>>>>> +        dma_addr += PAGE_SIZE;
>>>>> +        rc += rc2;
>>>>> +    }
>>>>> +
>>>>
>>>> In case of error, shouldn't we invalidate the shadow tables entries 
>>>> we did validate until the error?
>>>
>>> Hmm, I don't think this is strictly necessary - the status returned 
>>> should indicate the specified DMA range is now in an indeterminate 
>>> state (putting the onus on the guest to take corrective action via a 
>>> global refresh).
>>>
>>> In fact I think I screwed that up below in 
>>> kvm_s390_pci_refresh_trans, the fabricated status should always be 
>>> KVM_S390_RPCIT_INS_RES.
>>
>> OK
>>
>>>
>>>>
>>>>> +out_unlock:
>>>>> +    mutex_unlock(&kzdev->ioat.lock);
>>>>> +    return rc;
>>>>> +}
>>>>> +
>>>>> +int kvm_s390_pci_refresh_trans(struct kvm_vcpu *vcpu, unsigned 
>>>>> long req,
>>>>> +                   unsigned long start, unsigned long size,
>>>>> +                   u8 *status)
>>>>> +{
>>>>> +    struct zpci_dev *zdev;
>>>>> +    u32 fh = req >> 32;
>>>>> +    int rc;
>>>>> +
>>>>> +    /* Make sure this is a valid device associated with this guest */
>>>>> +    zdev = get_zdev_by_fh(fh);
>>>>> +    if (!zdev || !zdev->kzdev || zdev->kzdev->kvm != vcpu->kvm) {
>>>>> +        *status = 0;
>>>>
>>>> Wouldn't it be interesting to add some debug information here.
>>>> When would this appear?
>>>
>>> Yes, I agree -- One of the follow-ons I'd like to add after this 
>>> series is s390dbf entries; this seems like a good spot for one.
>>>
>>> As to when this could happen; it should not under normal 
>>> circumstances, but consider something like arbitrary function handles 
>>> coming from the intercepted guest instruction.  We need to ensure 
>>> that the specified function 1) exists and 2) is associated with the 
>>> guest issuing the refresh.
>>>
>>>>
>>>> Also if we have this error this looks like we have a VM problem, 
>>>> shouldn't we treat this in QEMU and return -EOPNOTSUPP ?
>>>>
>>>
>>> Well, I'm not sure if we can really tell where the problem is (it 
>>> could for example indicate a misbehaving guest, or a bug in our KVM 
>>> tracking of hostdevs).
>>>
>>> The guest chose the function handle, and if we got here then that 
>>> means it doesn't indicate that it's an emulated device, which means 
>>> either we are using the assist and KVM should handle the intercept or 
>>> we are not and userspace should handle it.  But in both of those 
>>> cases, there should be a host device and it should be associated with 
>>> the guest.
>>
>> That is right if we can not find an associated zdev = F(fh)
>> but the two other errors are KVM or QEMU errors AFAIU.
> 
> I don't think we know for sure for any of the cases...  For a 
> well-behaved guest I agree with your assessment.  However, the guest 
> decides what fh to put into its refresh instruction and so a misbehaving 
> guest could just pick arbitrary numbers for fh and circumstantially 
> match some other host device.  What if the guest just decided to try 
> every single possible fh number in a loop with a refresh instruction? 
> That's neither KVM nor QEMU's fault but can trip each of these cases.
> 
> Consider the different cases:
> 
> !zdev - Either the guest provided a bogus fh, KVM provided a bad fh via 
> the VFIO ioctl which then QEMU fed into CLP or KVM provided the right fh 
> via ioctl but QEMU clobbered it when providing it to the guest via CLP.
> 
> !zdev->kzdev - Either the guest provided a bogus fh that just so 
> happened to match a host fh that has no KVM association, or KVM or QEMU 
> screwed up somewhere (as above or because we failed to make the KVM 
> assocation somehow)
> 
> kzdev->kvm != vcpu->kvm - Pretty much the same as above, but the 
> matching device is actually in use by some other guest.  Again it's 
> possible the a misbehaving guest 'got lucky' with an arbitrary fh that 
> happened to match a host fh with an existing KVM association -- or more 
> likely that KVM or QEMU screwed up somewhere.

OK, I understand and you are right, my error was to consider that 
get_zdev_by_fh() returns a zdev associated with a valid FH for the guest 
while it returns a zdev associated with a valid FH for the host.

If the comment would have been after the get_zdev_by_fh() and before the 
test I may be wouldn't have done this mistake.

> 
>>
>>>
>>> I think if we decide to throw this to userspace in this event, QEMU 
>>> needs some extra code to handle it (basically, if QEMU receives the 
>>> intercept and the device is neither emulated nor using intercept mode 
>>> then we must treat as an invalid handle as this intercept should have 
>>> been handled by KVM)
>>
>> I do not want to start a discussion on this, I think we can let it 
>> like this at first and come back to it when we have a good idea on how 
>> to handle this.
>> May be just add a /* TODO */
> 
> OK, sure.  In any of the above cases, we are certainly done in KVM 
> anyway.  Whether there's value in passing it onto userspace vs 
> immediately giving an error, let's think about it.

No, I do not think we should anymore.
Sorry for this wrong idea.

-- 
Pierre Morel
IBM Lab Boeblingen
