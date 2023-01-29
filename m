Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49DC67FFC5
	for <lists+linux-s390@lfdr.de>; Sun, 29 Jan 2023 16:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjA2PL6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 29 Jan 2023 10:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjA2PL5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 29 Jan 2023 10:11:57 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49950193D8;
        Sun, 29 Jan 2023 07:11:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VaKrGYW_1675005108;
Received: from 30.236.57.229(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VaKrGYW_1675005108)
          by smtp.aliyun-inc.com;
          Sun, 29 Jan 2023 23:11:49 +0800
Message-ID: <2ad147d3-b127-b192-c2a5-29fa704cf3a1@linux.alibaba.com>
Date:   Sun, 29 Jan 2023 23:11:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v6 1/7] net/smc: remove locks
 smc_client_lgr_pending and smc_server_lgr_pending
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
References: <1669453422-38152-1-git-send-email-alibuda@linux.alibaba.com>
 <1669453422-38152-2-git-send-email-alibuda@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <1669453422-38152-2-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11/26/22 5:03 PM, D.Wythe wrote:
> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> This patch attempts to remove locks named smc_client_lgr_pending and
> smc_server_lgr_pending, which aim to serialize the creation of link
> group. However, once link group existed already, those locks are
> meaningless, worse still, they make incoming connections have to be
> queued one after the other.
> 
> Now, the creation of link group is no longer generated by competition,
> but allocated through following strategy.
> 


Hi, all

I have noticed that there may be some difficulties in the advancement of this series of patches.
I guess the main problem is to try remove the global lock in this patch, the risks of removing locks
do harm to SMC-D, at the same time, this patch of removing locks is also a little too complex.

So, I am considering that we can temporarily delay the advancement of this patch. We can works on
other patches first. Other patches are either simple enough or have no obvious impact on SMC-D.

What do you think?

Best wishes.
D. Wythe


