Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E75E6B0AB1
	for <lists+linux-s390@lfdr.de>; Wed,  8 Mar 2023 15:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjCHOND (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Mar 2023 09:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjCHOM1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Mar 2023 09:12:27 -0500
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C814989F;
        Wed,  8 Mar 2023 06:11:39 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VdPs2pr_1678284694;
Received: from 192.168.50.70(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VdPs2pr_1678284694)
          by smtp.aliyun-inc.com;
          Wed, 08 Mar 2023 22:11:35 +0800
Message-ID: <b83577e6-8b0f-f8d0-150a-cfbb061adeb2@linux.alibaba.com>
Date:   Wed, 8 Mar 2023 22:11:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH net v2] net/smc: fix application data exception
Content-Language: en-US
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <1676529545-32741-1-git-send-email-alibuda@linux.alibaba.com>
 <Y/5J30kmv1cPc7nE@osiris>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <Y/5J30kmv1cPc7nE@osiris>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 3/1/23 2:37 AM, Heiko Carstens wrote:
> On Thu, Feb 16, 2023 at 02:39:05PM +0800, D. Wythe wrote:
>> From: "D. Wythe" <alibuda@linux.alibaba.com>
>>
>> There is a certain probability that following
>> exceptions will occur in the wrk benchmark test:
>>
>> Running 10s test @ http://11.213.45.6:80
>>    8 threads and 64 connections
>>    Thread Stats   Avg      Stdev     Max   +/- Stdev
>>      Latency     3.72ms   13.94ms 245.33ms   94.17%
>>      Req/Sec     1.96k   713.67     5.41k    75.16%
>>    155262 requests in 10.10s, 23.10MB read
>> Non-2xx or 3xx responses: 3
>>
>> We will find that the error is HTTP 400 error, which is a serious
>> exception in our test, which means the application data was
>> corrupted.
>>
>> Consider the following scenarios:
>>
>> CPU0                            CPU1
>>
>> buf_desc->used = 0;
>>                                  cmpxchg(buf_desc->used, 0, 1)
>>                                  deal_with(buf_desc)
>>
>> memset(buf_desc->cpu_addr,0);
>>
>> This will cause the data received by a victim connection to be cleared,
>> thus triggering an HTTP 400 error in the server.
>>
>> This patch exchange the order between clear used and memset, add
>> barrier to ensure memory consistency.
>>
>> Fixes: 1c5526968e27 ("net/smc: Clear memory when release and reuse buffer")
>> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
>> ---
>> v2: rebase it with latest net tree.
>>
>>   net/smc/smc_core.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>> index c305d8d..c19d4b7 100644
>> --- a/net/smc/smc_core.c
>> +++ b/net/smc/smc_core.c
>> @@ -1120,8 +1120,9 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
>>   
>>   		smc_buf_free(lgr, is_rmb, buf_desc);
>>   	} else {
>> -		buf_desc->used = 0;
>> -		memset(buf_desc->cpu_addr, 0, buf_desc->len);
>> +		/* memzero_explicit provides potential memory barrier semantics */
>> +		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
>> +		WRITE_ONCE(buf_desc->used, 0);
> This looks odd to me. memzero_explicit() is only sort of a compiler
> barrier, since it is a function call, but not a real memory barrier.
>
> You may want to check Documentation/memory-barriers.txt and
> Documentation/atomic_t.txt.
>
> To me the proper solution looks like buf_desc->used should be converted to
> an atomic_t, and then you could do:
>
> 	memset(buf_desc->cpu_addr, 0, buf_desc->len);
> 	smp_mb__before_atomic();
> 	atomic_set(&buf_desc->used, 0);
>
> and in a similar way use atomic_cmpxchg() instead of the now used cmpxchg()
> for the part that sets buf_desc->used to 1.
>
> Adding experts to cc, since s390 has such strong memory ordering semantics
> that you can basically do whatever you want without breaking anything. So I
> don't consider myself an expert here at all. :)
>
> But given that this is common code, let's make sure this is really correct.

Hi  Heiko,

I realize that you are completely right, and I will repair this problem 
according to your ideas.

Thank you very much!!!

Best wishes.

D. Wythe

