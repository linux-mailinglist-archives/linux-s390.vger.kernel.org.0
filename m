Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFF9E24B4A
	for <lists+linux-s390@lfdr.de>; Tue, 21 May 2019 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfEUJOs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 21 May 2019 05:14:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48776 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726692AbfEUJOs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 May 2019 05:14:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4L97w2c143221
        for <linux-s390@vger.kernel.org>; Tue, 21 May 2019 05:14:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2smdy31g76-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 21 May 2019 05:14:46 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Tue, 21 May 2019 10:14:44 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 21 May 2019 10:14:41 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4L9Ed1U32309462
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 09:14:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DDBBA4040;
        Tue, 21 May 2019 09:14:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C65FDA4055;
        Tue, 21 May 2019 09:14:38 +0000 (GMT)
Received: from [9.152.222.56] (unknown [9.152.222.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 May 2019 09:14:38 +0000 (GMT)
Reply-To: pmorel@linux.ibm.com
Subject: Re: [PATCH v2 4/4] vfio: vfio_iommu_type1: implement
 VFIO_IOMMU_INFO_CAPABILITIES
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>, sebott@linux.vnet.ibm.com,
        gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com,
        borntraeger@de.ibm.com, walling@linux.ibm.com,
        linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        robin.murphy@arm.com
References: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
 <1558109810-18683-5-git-send-email-pmorel@linux.ibm.com>
 <20190517104143.240082b5@x1.home>
 <92b6ad4e-9a49-636b-9225-acca0bec4bb7@linux.ibm.com>
 <ed193353-56f0-14b5-f1fb-1835d0a6c603@linux.ibm.com>
 <20190520162737.7560ad7c.cohuck@redhat.com>
 <23f6a739-be4f-7eda-2227-2994fdc2325a@linux.ibm.com>
 <20190520122352.73082e52@x1.home>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 21 May 2019 11:14:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190520122352.73082e52@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19052109-0020-0000-0000-0000033EE13E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052109-0021-0000-0000-00002191BE39
Message-Id: <9dc0a8de-b850-df21-e3b7-21b7c2a373a3@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905210059
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 20/05/2019 20:23, Alex Williamson wrote:
> On Mon, 20 May 2019 18:31:08 +0200
> Pierre Morel <pmorel@linux.ibm.com> wrote:
> 
>> On 20/05/2019 16:27, Cornelia Huck wrote:
>>> On Mon, 20 May 2019 13:19:23 +0200
>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>    
>>>> On 17/05/2019 20:04, Pierre Morel wrote:
>>>>> On 17/05/2019 18:41, Alex Williamson wrote:
>>>>>> On Fri, 17 May 2019 18:16:50 +0200
>>>>>> Pierre Morel <pmorel@linux.ibm.com> wrote:
>>>>>>      
>>>>>>> We implement the capability interface for VFIO_IOMMU_GET_INFO.
>>>>>>>
>>>>>>> When calling the ioctl, the user must specify
>>>>>>> VFIO_IOMMU_INFO_CAPABILITIES to retrieve the capabilities and
>>>>>>> must check in the answer if capabilities are supported.
>>>>>>>
>>>>>>> The iommu get_attr callback will be used to retrieve the specific
>>>>>>> attributes and fill the capabilities.
>>>>>>>
>>>>>>> Currently two Z-PCI specific capabilities will be queried and
>>>>>>> filled by the underlying Z specific s390_iommu:
>>>>>>> VFIO_IOMMU_INFO_CAP_QFN for the PCI query function attributes
>>>>>>> and
>>>>>>> VFIO_IOMMU_INFO_CAP_QGRP for the PCI query function group.
>>>>>>>
>>>>>>> Other architectures may add new capabilities in the same way
>>>>>>> after enhancing the architecture specific IOMMU driver.
>>>>>>>
>>>>>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>>>>>> ---
>>>>>>>     drivers/vfio/vfio_iommu_type1.c | 122
>>>>>>> +++++++++++++++++++++++++++++++++++++++-
>>>>>>>     1 file changed, 121 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c
>>>>>>> b/drivers/vfio/vfio_iommu_type1.c
>>>>>>> index d0f731c..9435647 100644
>>>>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>>>>> @@ -1658,6 +1658,97 @@ static int
>>>>>>> vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>>>>>>>         return ret;
>>>>>>>     }
>>>>>>> +static int vfio_iommu_type1_zpci_fn(struct iommu_domain *domain,
>>>>>>> +                    struct vfio_info_cap *caps, size_t size)
>>>>>>> +{
>>>>>>> +    struct vfio_iommu_type1_info_pcifn *info_fn;
>>>>>>> +    int ret;
>>>>>>> +
>>>>>>> +    info_fn = kzalloc(size, GFP_KERNEL);
>>>>>>> +    if (!info_fn)
>>>>>>> +        return -ENOMEM;
>>>>>>> +
>>>>>>> +    ret = iommu_domain_get_attr(domain, DOMAIN_ATTR_ZPCI_FN,
>>>>>>> +                    &info_fn->response);
>>>>>>
>>>>>> What ensures that the 'struct clp_rsp_query_pci' returned from this
>>>>>> get_attr remains consistent with a 'struct vfio_iommu_pci_function'?
>>>>>> Why does the latter contains so many reserved fields (beyond simply
>>>>>> alignment) for a user API?  What fields of these structures are
>>>>>> actually useful to userspace?  Should any fields not be exposed to the
>>>>>> user?  Aren't BAR sizes redundant to what's available through the vfio
>>>>>> PCI API?  I'm afraid that simply redefining an internal structure as
>>>>>> the API leaves a lot to be desired too.  Thanks,
>>>>>>
>>>>>> Alex
>>>>>>      
>>>>> Hi Alex,
>>>>>
>>>>> I simply used the structure returned by the firmware to be sure to be
>>>>> consistent with future evolutions and facilitate the copy from CLP and
>>>>> to userland.
>>>>>
>>>>> If you prefer, and I understand that this is the case, I can define a
>>>>> specific VFIO_IOMMU structure with only the fields relevant to the user,
>>>>> leaving future enhancement of the user's interface being implemented in
>>>>> another kernel patch when the time has come.
> 
> TBH, I had no idea that CLP is an s390 firmware interface and this is
> just dumping that to userspace.  The cover letter says:
> 
>    Using the PCI VFIO interface allows userland, a.k.a. QEMU, to
>    retrieve ZPCI specific information without knowing Z specific
>    identifiers like the function ID or the function handle of the zPCI
>    function hidden behind the PCI interface.
> 
> But what does this allow userland to do and what specific pieces of
> information do they need?  We do have a case already where Intel
> graphics devices have a table (OpRegion) living in host system memory
> that we expose via a vfio region, so it wouldn't be unprecedented to do
> something like this, but as Connie suggests, if we knew what was being
> consumed here and why, maybe we could generalize it into something
> useful for others.

OK, sorry I try to explain better.

1) A short description, of zPCI functions and groups

IN Z, PCI cards, leave behind an adapter between subchannels and PCI.
We access PCI cards through 2 ways:
- dedicated PCI instructions (pci_load/pci_store/pci/store_block)
- DMA
We receive events through
- Adapter interrupts
- CHSC events

The adapter propose an IOMMU to protect the DMA
and the interrupt handling goes through a MSIX like interface handled by 
the adapter.

The architecture specific PCI do the interface between the standard PCI 
level and the zPCI function (PCI + DMA/IOMMU/Interrupt)

To handle the communication through the "zPCI way" the CLP interface 
provides instructions to retrieve informations from the adapters.

There are different group of functions having same functionalities.

clp_list give us a list from zPCI functions
clp_query_pci_function returns informations specific to a function
clp_query_group returns information on a function group


2) Why do we need it in the guest

We need to provide the guest with information on the adapters and zPCI 
functions returned by the clp_query instruction so that the guest's 
driver gets the right information on how the way to the zPCI function 
has been built in the host.


When a guest issues the CLP instructions we intercept the clp command in 
QEMU and we need to feed the response with the right values for the guest.
The "right" values are not the raw CLP response values:

- some identifier must be virtualized, like UID and FID,

- some values must match what the host received from the CLP response, 
like the size of the transmited blocks, the DMA Address Space Mask, 
number of interrupt, MSIA

- some other must match what the host handled with the adapter and 
function, the start and end of DMA,

- some what the host IOMMU driver supports (frame size),



3) We have three different way to get This information:

The PCI Linux interface is a standard PCI interface and some Z specific 
information is available in sysfs.
Not all the information needed to be returned inside the CLP response is 
available.
So we can not use the sysfs interface to get all the information.

There is a CLP ioctl interface but this interface is not secure in that 
it returns the information for all adapters in the system.

The VFIO interface offers the advantage to point to a single PCI 
function, so more secure than the clp ioctl interface.
Coupled with the s390_iommu we get access to the zPCI CLP instruction 
and to the values handled by the zPCI driver.


4) Until now we used to fill the CLP response to the guest inside QEMU 
with fixed values corresponding to the only PCI card we supported.
To support new cards we need to get the right values from the kernel out.

> 
>>>>> In fact, the struct will have all defined fields I used but not the BAR
>>>>> size and address (at least for now because there are special cases we do
>>>>> not support yet with bars).
>>>>> All the reserved fields can go away.
>>>>>
>>>>> Is it more conform to your idea?
>>>>>
>>>>> Also I have 2 interfaces:
>>>>>
>>>>> s390_iommu.get_attr <-I1-> VFIO_IOMMU <-I2-> userland
>>>>>
>>>>> Do you prefer:
>>>>> - 2 different structures, no CLP raw structure
>>>>> - the CLP raw structure for I1 and a VFIO specific structure for I2
>>>
>>> <entering from the sideline>
>>>
>>> IIUC, get_attr extracts various data points via clp, and we then make
>>> it available to userspace. The clp interface needs to be abstracted
>>> away at some point... one question from me: Is there a chance that
>>> someone else may want to make use of the userspace interface (extra
>>> information about a function)? If yes, I'd expect the get_attr to
>>> obtain some kind of portable information already (basically your third
>>> option, below).
> 
> I agree, but I also suspect we're pretty deep into s390
> eccentricities.  An ioctl on the IOMMU container to get information
> about a PCI function (singular) really seems like it can only exist on
> a system where the actual PCI hardware is already being virtualized to
> the host system.  I don't think this excludes us from the conversation
> about what we're actually trying to expose and what it enables in
> userspace though.

I hope I answered these question in this email, above.

>   
>> Yes, seems the most reasonable.
>> In this case I need to share the structure definition between:
>> userspace through vfio.h
>> vfio_iommu (this is obvious)
>> s390_iommu
>>
>> It is this third include which made me doubt.
>> But when you re formulate it it looks the more reasonable because there
>> are much less changes.
> 
> It depends on what we settle on for get_attr.  If there are discrete
> features that vfio_iommu_type1 can query and assemble into the
> userspace response, the s390_iommu doesn't need to know the resulting
> structure.  Even if it's just a CLP structure from the get_attr, why
> would s390_iommu be responsible for formatting that into a user
> structure vs vfio_iommu?  I don't think we want get_attr passing vfio
> specific structures.  Thanks,
> 
> Alex
> 

OK, yes, I can do this and setup one ATTR for each feature and 
reassemble it in VFIO_IOMMU_TYPE1

Thanks,
Pierre

-- 
Pierre Morel
Linux/KVM/QEMU in Böblingen - Germany

