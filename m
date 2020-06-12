Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7151F7760
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2020 13:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgFLLi0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 12 Jun 2020 07:38:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725805AbgFLLi0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jun 2020 07:38:26 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CB586p176109;
        Fri, 12 Jun 2020 07:38:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31kq68ux0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 07:38:23 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05CBULiQ062841;
        Fri, 12 Jun 2020 07:38:23 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31kq68ux0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 07:38:22 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CBVn5j013457;
        Fri, 12 Jun 2020 11:38:21 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 31g2s84mdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 11:38:20 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CBcInX44302566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 11:38:18 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 297FD4204C;
        Fri, 12 Jun 2020 11:38:18 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA7854203F;
        Fri, 12 Jun 2020 11:38:17 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.145.76.70])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jun 2020 11:38:17 +0000 (GMT)
Subject: Re: [PATCH] s390: protvirt: virtio: Refuse device without IOMMU
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Cc:     pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        mst@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <1591794711-5915-1-git-send-email-pmorel@linux.ibm.com>
 <467d5b58-b70c-1c45-4130-76b6e18c05af@redhat.com>
 <f7eb1154-0f52-0f12-129f-2b511f5a4685@linux.ibm.com>
Message-ID: <6356ba7f-afab-75e1-05ff-4a22b88c610e@linux.ibm.com>
Date:   Fri, 12 Jun 2020 13:38:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f7eb1154-0f52-0f12-129f-2b511f5a4685@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 cotscore=-2147483648 impostorscore=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2020-06-12 11:21, Pierre Morel wrote:
> 
> 
> On 2020-06-11 05:10, Jason Wang wrote:
>>
>> On 2020/6/10 下午9:11, Pierre Morel wrote:
>>> Protected Virtualisation protects the memory of the guest and
>>> do not allow a the host to access all of its memory.
>>>
>>> Let's refuse a VIRTIO device which does not use IOMMU
>>> protected access.
>>>
>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>>> ---
>>>   drivers/s390/virtio/virtio_ccw.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/s390/virtio/virtio_ccw.c 
>>> b/drivers/s390/virtio/virtio_ccw.c
>>> index 5730572b52cd..06ffbc96587a 100644
>>> --- a/drivers/s390/virtio/virtio_ccw.c
>>> +++ b/drivers/s390/virtio/virtio_ccw.c
>>> @@ -986,6 +986,11 @@ static void virtio_ccw_set_status(struct 
>>> virtio_device *vdev, u8 status)
>>>       if (!ccw)
>>>           return;
>>> +    /* Protected Virtualisation guest needs IOMMU */
>>> +    if (is_prot_virt_guest() &&
>>> +        !__virtio_test_bit(vdev, VIRTIO_F_IOMMU_PLATFORM))
>>> +            status &= ~VIRTIO_CONFIG_S_FEATURES_OK;
>>> +
>>>       /* Write the status to the host. */
>>>       vcdev->dma_area->status = status;
>>>       ccw->cmd_code = CCW_CMD_WRITE_STATUS;
>>
>>
>> I wonder whether we need move it to virtio core instead of ccw.
>>
>> I think the other memory protection technologies may suffer from this 
>> as well.
>>
>> Thanks
>>
> 
> 
> What would you think of the following, also taking into account Connie's 
> comment on where the test should be done:
> 
> - declare a weak function in virtio.c code, returning that memory 
> protection is not in use.
> 
> - overwrite the function in the arch code
> 
> - call this function inside core virtio_finalize_features() and if 
> required fail if the device don't have VIRTIO_F_IOMMU_PLATFORM.
> 
> Alternative could be to test a global variable that the architecture 
> would overwrite if needed but I find the weak function solution more 
> flexible.
> 
> With a function, we also have the possibility to provide the device as 
> argument and take actions depending it, this may answer Halil's concern.
> 
> Regards,
> Pierre
> 

hum, in between I found another way which seems to me much better:

We already have the force_dma_unencrypted() function available which 
AFAIU is what we want for encrypted memory protection and is already 
used by power and x86 SEV/SME in a way that seems AFAIU compatible with 
our problem.

Even DMA and IOMMU are different things, I think they should be used 
together in our case.

What do you think?

The patch would then be something like:

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a977e32a88f2..53476d5bbe35 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -4,6 +4,7 @@
  #include <linux/virtio_config.h>
  #include <linux/module.h>
  #include <linux/idr.h>
+#include <linux/dma-direct.h>
  #include <uapi/linux/virtio_ids.h>

  /* Unique numbering for virtio devices. */
@@ -179,6 +180,10 @@ int virtio_finalize_features(struct virtio_device *dev)
         if (!virtio_has_feature(dev, VIRTIO_F_VERSION_1))
                 return 0;

+       if (force_dma_unencrypted(&dev->dev) &&
+           !virtio_has_feature(dev, VIRTIO_F_IOMMU_PLATFORM))
+               return -EIO;
+
         virtio_add_status(dev, VIRTIO_CONFIG_S_FEATURES_OK);
         status = dev->config->get_status(dev);
         if (!(status & VIRTIO_CONFIG_S_FEATURES_OK)) {


Regards,
Pierre

-- 
Pierre Morel
IBM Lab Boeblingen
