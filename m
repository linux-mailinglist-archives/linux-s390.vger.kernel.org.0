Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C3A682281
	for <lists+linux-s390@lfdr.de>; Tue, 31 Jan 2023 04:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjAaDGP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Jan 2023 22:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjAaDGO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Jan 2023 22:06:14 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662993029A;
        Mon, 30 Jan 2023 19:06:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VaUqCZz_1675134368;
Received: from 30.221.149.193(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VaUqCZz_1675134368)
          by smtp.aliyun-inc.com;
          Tue, 31 Jan 2023 11:06:10 +0800
Message-ID: <82545b5f-2b9e-61ab-9e67-866e2a492904@linux.alibaba.com>
Date:   Tue, 31 Jan 2023 11:06:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v6 1/7] net/smc: remove locks
 smc_client_lgr_pending and smc_server_lgr_pending
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, jaka@linux.ibm.com,
        kgraul@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1669453422-38152-1-git-send-email-alibuda@linux.alibaba.com>
 <1669453422-38152-2-git-send-email-alibuda@linux.alibaba.com>
 <2ad147d3-b127-b192-c2a5-29fa704cf3a1@linux.alibaba.com>
 <c45960d9-c358-e47b-0a33-1de8c3a8f94c@linux.ibm.com>
 <a0de12ab-dd9a-acfe-4324-78815d6ebc35@linux.alibaba.com>
 <bb50c952-6075-d838-0bc3-4848c12ad920@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <bb50c952-6075-d838-0bc3-4848c12ad920@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/31/23 5:10 AM, Wenjia Zhang wrote:
> 
> 
> On 30.01.23 11:51, D. Wythe wrote:
>>
>>
>> On 1/30/23 4:37 PM, Wenjia Zhang wrote:
>>>
>>>
>>> On 29.01.23 16:11, D. Wythe wrote:
>>>>
>>>>
>>>> On 11/26/22 5:03 PM, D.Wythe wrote:
>>>>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>>>>
>>>>> This patch attempts to remove locks named smc_client_lgr_pending and
>>>>> smc_server_lgr_pending, which aim to serialize the creation of link
>>>>> group. However, once link group existed already, those locks are
>>>>> meaningless, worse still, they make incoming connections have to be
>>>>> queued one after the other.
>>>>>
>>>>> Now, the creation of link group is no longer generated by competition,
>>>>> but allocated through following strategy.
>>>>>
>>>>
>>>>
>>>> Hi, all
>>>>
>>>> I have noticed that there may be some difficulties in the advancement of this series of patches.
>>>> I guess the main problem is to try remove the global lock in this patch, the risks of removing locks
>>>> do harm to SMC-D, at the same time, this patch of removing locks is also a little too complex.
>>>>
>>>> So, I am considering that we can temporarily delay the advancement of this patch. We can works on
>>>> other patches first. Other patches are either simple enough or have no obvious impact on SMC-D.
>>>>
>>>> What do you think?
>>>>
>>>> Best wishes.
>>>> D. Wythe
>>>>
>>>>
>>> Hi D. Wythe,
>>>
>>> that sounds good. Thank you for your consideration about SMC-D!
>>
>> Hi Wenjia,
>>
>> Thanks for your reply.
>>
>>> Removing locks is indeed a big issue, those patches make us difficult to accept without thoroughly testing in every corner.
>>>
>>> Best
>>> Wenjia
>>
>> What do you mean by those patches? My plan is to delete the first patch in this series,
>> that is, 'remove locks smc_client_lgr_pending and smc_server_lgr_pending', while other patches
>> should be retained.
>>
>> They has almost nothing impact on SMC-D or simple enough to be tested. If you agree with this,
>> I can then issue the next version as soon as possible to remove the first patch, and I think
>> we can quickly promote those patches.
>>
>> Thanks.
>> Wenjia
>>
> Except for the removing locks of smc_client_lgr_pending and smc_server_lgr_pending, I'm still not that sure if running SMC_LLC_FLOW_RKEY concurrently could make the communication between our Linux and z/OS broken, that we can not test currently, though I really like this idea.

Hi, Wenjia

This is really a situation that I hadn't considered before, and I'm afraid it can be a problem, if implementation of z/OS do need to process SMC_LLC_FLOW_RKEY
one by one, and i guess it's very possible.


> Sure, you can send the next version, I'll find a way to verify it.

Whatever, I will issue the next patches with first patch removed, and if we cannot pass the compatibility
test with z/OS, I think we have to give up the patch tried to running SMC_LLC_FLOW_RKEY concurrently.

Fortunately, we have discussed the possibility of protocol extension before. If the patch tried to running SMC_LLC_FLOW_RKEY concurrently
cannot be promoted temporarily, we can also promote it again after the protocol extension is completed.

Thanks.
D. Wythe
> 
> 
> 
>>
>>
>>
