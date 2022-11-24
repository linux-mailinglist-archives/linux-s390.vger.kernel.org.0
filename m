Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222E63747A
	for <lists+linux-s390@lfdr.de>; Thu, 24 Nov 2022 09:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiKXIxl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 24 Nov 2022 03:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiKXIxj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 24 Nov 2022 03:53:39 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CF79A261;
        Thu, 24 Nov 2022 00:53:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VVaPyCe_1669280014;
Received: from 30.221.149.133(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VVaPyCe_1669280014)
          by smtp.aliyun-inc.com;
          Thu, 24 Nov 2022 16:53:35 +0800
Message-ID: <1f87a8c2-7a47-119a-1141-250d05678546@linux.alibaba.com>
Date:   Thu, 24 Nov 2022 16:53:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH net-next v5 00/10] optimize the parallelism of SMC-R
 connections
Content-Language: en-US
To:     Jan Karcher <jaka@linux.ibm.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1669218890-115854-1-git-send-email-alibuda@linux.alibaba.com>
 <c98a8f04-c696-c9e0-4d7e-bc31109a0e04@linux.alibaba.com>
 <352b1e15-3c6d-a398-3fe6-0f438e0e8406@linux.ibm.com>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <352b1e15-3c6d-a398-3fe6-0f438e0e8406@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11/24/22 4:33 PM, Jan Karcher wrote:
> 
> 
> On 24/11/2022 06:55, D. Wythe wrote:
>>
>>
>> On 11/23/22 11:54 PM, D.Wythe wrote:
>>> From: "D.Wythe" <alibuda@linux.alibaba.com>
>>>
>>> This patch set attempts to optimize the parallelism of SMC-R connections,
>>> mainly to reduce unnecessary blocking on locks, and to fix exceptions that
>>> occur after thoses optimization.
>>>
>>
>>> D. Wythe (10):
>>>    net/smc: Fix potential panic dues to unprotected
>>>      smc_llc_srv_add_link()
>>>    net/smc: fix application data exception
>>>    net/smc: fix SMC_CLC_DECL_ERR_REGRMB without smc_server_lgr_pending
>>>    net/smc: remove locks smc_client_lgr_pending and
>>>      smc_server_lgr_pending
>>>    net/smc: allow confirm/delete rkey response deliver multiplex
>>>    net/smc: make SMC_LLC_FLOW_RKEY run concurrently
>>>    net/smc: llc_conf_mutex refactor, replace it with rw_semaphore
>>>    net/smc: use read semaphores to reduce unnecessary blocking in
>>>      smc_buf_create() & smcr_buf_unuse()
>>>    net/smc: reduce unnecessary blocking in smcr_lgr_reg_rmbs()
>>>    net/smc: replace mutex rmbs_lock and sndbufs_lock with rw_semaphore
>>>
>>>   net/smc/af_smc.c   |  74 ++++----
>>>   net/smc/smc_core.c | 541 +++++++++++++++++++++++++++++++++++++++++++++++------
>>>   net/smc/smc_core.h |  53 +++++-
>>>   net/smc/smc_llc.c  | 285 ++++++++++++++++++++--------
>>>   net/smc/smc_llc.h  |   6 +
>>>   net/smc/smc_wr.c   |  10 -
>>>   net/smc/smc_wr.h   |  10 +
>>>   7 files changed, 801 insertions(+), 178 deletions(-)
>>>
>>
>> Hi Jan and Wenjia,
>>
>> I'm wondering whether the bug fix patches need to be put together in this series. I'm considering
>> sending these bug fix patches separately now, which may be better, in case that our patch
>> might have other problems. These bug fix patches are mainly independent, even without my other
>> patches, they may be triggered theoretically.
> 
> Hi D.
> 
> Wenjia and i just talked about that. For us it would be better separating the fixes and the new logic.
> If the fixes are independent feel free to post them to net.


Got it, I will remove those bug fix patches in the next series and send them separately.
And thanks a lot for your test, no matter what the final test results are, I will send a new series
to separate them after your test finished.

Thanks
D. Wythe



