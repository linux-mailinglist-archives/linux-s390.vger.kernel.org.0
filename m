Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8BD68E66B
	for <lists+linux-s390@lfdr.de>; Wed,  8 Feb 2023 04:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBHDEM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Feb 2023 22:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjBHDEL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Feb 2023 22:04:11 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B389A42BD0;
        Tue,  7 Feb 2023 19:04:09 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Vb9nhR4_1675825446;
Received: from 30.221.145.160(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0Vb9nhR4_1675825446)
          by smtp.aliyun-inc.com;
          Wed, 08 Feb 2023 11:04:07 +0800
Message-ID: <04e65f58-3ef3-6f5a-6f95-35d5b1555c7e@linux.alibaba.com>
Date:   Wed, 8 Feb 2023 11:04:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [net-next 0/2] Deliver confirm/delete rkey message in parallel
Content-Language: en-US
To:     Wenjia Zhang <wenjia@linux.ibm.com>, kgraul@linux.ibm.com,
        jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1675755374-107598-1-git-send-email-alibuda@linux.alibaba.com>
 <fe0d2dae-1a3e-e32f-e8b3-285a33d29422@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <fe0d2dae-1a3e-e32f-e8b3-285a33d29422@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2/8/23 7:29 AM, Wenjia Zhang wrote:
> 
> 
> On 07.02.23 08:36, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> According to the SMC protocol specification, we know that all flows except
>> confirm_rkey adn delete_rkey are exclusive, confirm/delete rkey flows
>> can run concurrently (local and remote).
>>
>> However, although the protocol allows, all flows are actually mutually
>> exclusive in implementation, deus to we are waiting for LLC message
>> in serial.
>>
>> On the one hand, this implementation does not conform to the protocol
>> specification, on the other hand, this implementation aggravates the
>> time for establishing or destroying a SMC-R connection, connection
>> have to be queued in smc_llc_wait.
>>
>> This patch will improve the performance of the short link scenario
>> by about 5%. In fact, we all know that the performance bottleneck
>> of the short link scenario is not here.
>>
>> This patch try use rtokens or rkey to correlate a confirm/delete
>> rkey message with its response.
>>
>> This patch contains two parts.
>>
>> At first, we have added the process
>> of asynchronously waiting for the response of confirm/delete rkey
>> messages, using rtokens or rkey to be correlate with.
>>
>> And then, we try to send confirm/delete rkey message in parallel,
>> allowing parallel execution of start (remote) or initialization (local)
>> SMC_LLC_FLOW_RKEY flows.
>>
>> D. Wythe (2):
>>    net/smc: allow confirm/delete rkey response deliver multiplex
>>    net/smc: make SMC_LLC_FLOW_RKEY run concurrently
>>
>>   net/smc/smc_core.h |   1 +
>>   net/smc/smc_llc.c  | 263 +++++++++++++++++++++++++++++++++++++++++------------
>>   net/smc/smc_llc.h  |   6 ++
>>   net/smc/smc_wr.c   |  10 --
>>   net/smc/smc_wr.h   |  10 ++
>>   5 files changed, 220 insertions(+), 70 deletions(-)
>>
> 
> As we already discussed, on this changes we need to test them carefully so that we have to be sure that the communicating with z/OS should not be broken. We'll let you know as soon as the testing is finished.


Hi, Wenjia

Thanks again for your test.

Considering that we have reached an agreement on protocol extension,
we can temporarily postpone this modification until we introduce the protocol extension
into the Linux community version. Then we can avoid the compatibility with z/OS.


Best wishes.
D. Wythe

