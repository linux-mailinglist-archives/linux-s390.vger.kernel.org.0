Return-Path: <linux-s390+bounces-357-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE495807F36
	for <lists+linux-s390@lfdr.de>; Thu,  7 Dec 2023 04:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795671F21392
	for <lists+linux-s390@lfdr.de>; Thu,  7 Dec 2023 03:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EADEB5229;
	Thu,  7 Dec 2023 03:42:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA3A4;
	Wed,  6 Dec 2023 19:42:24 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Vy-JpWo_1701920540;
Received: from 30.221.129.202(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy-JpWo_1701920540)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 11:42:22 +0800
Message-ID: <7359d629-a5c0-f8ec-6d00-d6b483a2c255@linux.alibaba.com>
Date: Thu, 7 Dec 2023 11:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v3 7/7] net/smc: manage system EID in SMC stack
 instead of ISM driver
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1701343695-122657-1-git-send-email-guwen@linux.alibaba.com>
 <1701343695-122657-8-git-send-email-guwen@linux.alibaba.com>
 <aab0905a-b77f-4504-a510-83c98f79b2b7@linux.ibm.com>
 <8efa4f88-4ab1-bdd9-5705-93d62909bfa9@linux.alibaba.com>
 <f61e8e26-47d7-4970-84b4-a57bd06df235@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <f61e8e26-47d7-4970-84b4-a57bd06df235@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/4 20:57, Alexandra Winter wrote:
> 
> 
> On 04.12.23 13:36, Wen Gu wrote:
>>> Here we only check the first smcd device to determine whether we support v2.
>>> Which is ok, for today's platform firmware ISM devices, as they are always the same version.
>>>
>>> When you add virtual ISM devices (loopback-ism, virtio-ism) then this needs to be changed.
>>> IMO the logic then needs to be "if all smcd devices support v2,
>>> then smc_ism_v2_capable = true;
>>> else smc_ism_v2_capable = false;"
>>>
>>
>> Thank you. I will change this in the loopback-ism patch set.
>>
>> But I am wondering if loopback-ism coexists with s390 ISMv1, why smc_ism_v2_capable shouldn't be set?
>> Is it because the SEID generated in this way is not correct if the s390 ISMv2 does not exist?
> 
> I think you're right: 'At least one IMSv2 device' is sufficient for smc_ism_v2_capable.
> 
> Actually, we could even always do smc_ism_v2_capable=true, and append an empty ISMv2 device list.
> (I am not sure that would be a good idea...)
> 
> Interesting sceanrios to consider for ism-loopback:
> e.g.: 2 ISMv1 device and 1 ism-loopback...

Yes. when virtual ISM is introduced (e.g. loopback-ism), I think logic can be

1) smc_ism_v2_capable is false initially as now;
2) Set smc_ism_v2_capable when ISMv2 or virtual ISM is registered, regardless of
    whether there is already a device in smcd device list.

And I guess the intent of smc_ism_v2_capable is to indicate that this kernel is
capable of using v2 devices rather than indicate that there are v2 smcd devices
available in the list, since right now smc_ism_v2_capable won't be cleared even
ISMv2 devices are unregistered.

