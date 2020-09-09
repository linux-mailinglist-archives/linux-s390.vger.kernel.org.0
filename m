Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5D262B92
	for <lists+linux-s390@lfdr.de>; Wed,  9 Sep 2020 11:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgIIJRK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Sep 2020 05:17:10 -0400
Received: from mga18.intel.com ([134.134.136.126]:62578 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJRI (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Sep 2020 05:17:08 -0400
IronPort-SDR: 4UfoviER+163ZOfzvllxRS/M+W5Ldi8Ryv0yri+p+qHvLJVmuHgWLSYY5x76tEdwZa0KKFqs3/
 diG40ofYg8CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="146013094"
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="146013094"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:16:52 -0700
IronPort-SDR: Eu5LFEF7mQvPvjaKgHiNi+EAI6twzANJVXLRWHJjqt2BIA4DKeAAOOzWigLRgh7pJRkcZk2JZB
 paZ/kvhmY5KQ==
X-IronPort-AV: E=Sophos;i="5.76,409,1592895600"; 
   d="scan'208";a="480390735"
Received: from vdc-station-04.ger.corp.intel.com (HELO [10.251.165.91]) ([10.251.165.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2020 02:16:41 -0700
Subject: Re: [Intel-gfx] [PATCH 0/8] Convert the intel iommu driver to the
 dma-iommu api
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     Logan Gunthorpe <logang@deltatee.com>, kvm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-tegra@vger.kernel.org, Julien Grall <julien.grall@arm.com>,
        Will Deacon <will@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        virtualization@lists.linux-foundation.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Kukjin Kim <kgene@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20191221150402.13868-1-murphyt7@tcd.ie>
 <465815ae-9292-f37a-59b9-03949cb68460@deltatee.com>
 <20200529124523.GA11817@infradead.org>
 <CGME20200529190523eucas1p2c086133e707257c0cdc002f502d4f51d@eucas1p2.samsung.com>
 <33137cfb-603c-86e8-1091-f36117ecfaf3@deltatee.com>
 <ef2150d5-7b6a-df25-c10d-e43316fe7812@samsung.com>
 <b9140772-0370-a858-578c-af503a06d8e9@deltatee.com>
 <CALQxJuutRaeX89k2o4ffTKYRMizmMu0XbRnzpFuSSrkQR02jKg@mail.gmail.com>
 <766525c3-4da9-6db7-cd90-fb4b82cd8083@deltatee.com>
 <60a82319-cbee-4cd1-0d5e-3c407cc51330@linux.intel.com>
 <e598fb31-ef7a-c2ee-8a54-bf62d50c480c@deltatee.com>
 <b27cae1f-07ff-bef2-f125-a5f0d968016d@linux.intel.com>
 <CALQxJut5c=cWdi+SVkN3JnbkhPSYmLkOyRUhduL-UJ9gyKn9Ow@mail.gmail.com>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <7106602a-9964-851e-9c4e-d8acf4033b89@linux.intel.com>
Date:   Wed, 9 Sep 2020 10:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALQxJut5c=cWdi+SVkN3JnbkhPSYmLkOyRUhduL-UJ9gyKn9Ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 08/09/2020 23:43, Tom Murphy wrote:
> On Tue, 8 Sep 2020 at 16:56, Tvrtko Ursulin
> <tvrtko.ursulin@linux.intel.com> wrote:
>>
>>
>> On 08/09/2020 16:44, Logan Gunthorpe wrote:
>>> On 2020-09-08 9:28 a.m., Tvrtko Ursulin wrote:
>>>>>
>>>>> diff --git a/drivers/gpu/drm/i915/i915_scatterlist.h
>>>>> b/drivers/gpu/drm/i915/i915
>>>>> index b7b59328cb76..9367ac801f0c 100644
>>>>> --- a/drivers/gpu/drm/i915/i915_scatterlist.h
>>>>> +++ b/drivers/gpu/drm/i915/i915_scatterlist.h
>>>>> @@ -27,13 +27,19 @@ static __always_inline struct sgt_iter {
>>>>>     } __sgt_iter(struct scatterlist *sgl, bool dma) {
>>>>>            struct sgt_iter s = { .sgp = sgl };
>>>>>
>>>>> +       if (sgl && !sg_dma_len(s.sgp))
>>>>
>>>> I'd extend the condition to be, just to be safe:
>>>>       if (dma && sgl && !sg_dma_len(s.sgp))
>>>>
>>>
>>> Right, good catch, that's definitely necessary.
>>>
>>>>> +               s.sgp = NULL;
>>>>> +
>>>>>            if (s.sgp) {
>>>>>                    s.max = s.curr = s.sgp->offset;
>>>>> -               s.max += s.sgp->length;
>>>>> -               if (dma)
>>>>> +
>>>>> +               if (dma) {
>>>>> +                       s.max += sg_dma_len(s.sgp);
>>>>>                            s.dma = sg_dma_address(s.sgp);
>>>>> -               else
>>>>> +               } else {
>>>>> +                       s.max += s.sgp->length;
>>>>>                            s.pfn = page_to_pfn(sg_page(s.sgp));
>>>>> +               }
>>>>
>>>> Otherwise has this been tested or alternatively how to test it? (How to
>>>> repro the issue.)
>>>
>>> It has not been tested. To test it, you need Tom's patch set without the
>>> last "DO NOT MERGE" patch:
>>>
>>> https://lkml.kernel.org/lkml/20200907070035.GA25114@infradead.org/T/
>>
>> Tom, do you have a branch somewhere I could pull from? (Just being lazy
>> about downloading a bunch of messages from the archives.)
> 
> I don't unfortunately. I'm working locally with poor internet.
> 
>>
>> What GPU is in your Lenovo x1 carbon 5th generation and what
>> graphical/desktop setup I need to repro?
> 
> 
> Is this enough info?:
> 
> $ lspci -vnn | grep VGA -A 12
> 00:02.0 VGA compatible controller [0300]: Intel Corporation HD
> Graphics 620 [8086:5916] (rev 02) (prog-if 00 [VGA controller])
>      Subsystem: Lenovo ThinkPad X1 Carbon 5th Gen [17aa:224f]
>      Flags: bus master, fast devsel, latency 0, IRQ 148
>      Memory at eb000000 (64-bit, non-prefetchable) [size=16M]
>      Memory at 60000000 (64-bit, prefetchable) [size=256M]
>      I/O ports at e000 [size=64]
>      [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
>      Capabilities: [40] Vendor Specific Information: Len=0c <?>
>      Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
>      Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
>      Capabilities: [d0] Power Management version 2
>      Capabilities: [100] Process Address Space ID (PASID)
>      Capabilities: [200] Address Translation Service (ATS)

Works for a start. What about the steps to repro? Any desktop 
environment and it is just visual corruption, no hangs/stalls or such?

I've submitted a series consisting of what I understood are the patches 
needed to repro the issue to our automated CI here:

https://patchwork.freedesktop.org/series/81489/

So will see if it will catch something, or more targeted testing will be 
required. Hopefully it does trip over in which case I can add the patch 
suggested by Logan on top and see if that fixes it. Or I'll need to 
write a new test case.

If you could glance over my series to check I identified the patches 
correctly it would be appreciated.

Regards,

Tvrtko
