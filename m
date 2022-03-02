Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26F24CA5B4
	for <lists+linux-s390@lfdr.de>; Wed,  2 Mar 2022 14:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242089AbiCBNQ6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Mar 2022 08:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236694AbiCBNQ5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Mar 2022 08:16:57 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36DC3C13;
        Wed,  2 Mar 2022 05:16:12 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V635yRY_1646226968;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0V635yRY_1646226968)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 21:16:09 +0800
From:   "D. Wythe" <alibuda@linux.alibaba.com>
To:     kgraul@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: [PATCH net v2 0/2] fix unexpected SMC_CLC_DECL_ERR_REGRMB error 
Date:   Wed,  2 Mar 2022 21:16:06 +0800
Message-Id: <1646226968-2315-1-git-send-email-alibuda@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: "D. Wythe" <alibuda@linux.alibaba.com>

We can easily trigger the SMC_CLC_DECL_ERR_REGRMB exception within
following script:

server: smc_run nginx
client: smc_run  ./wrk -c 2000 -t 8 -d 20 http://smc-server

And we can clearly see that this error is also divided into two types:

1. 0x09990003
2. 0x05000000/0x09990003

Which has the same root causes, but the immediate causes vary.

The root cause of this issues is that remove connections from link group
is not synchronous with add/delete rtoken entry,  which means that even
the number of connections is less that SMC_RMBS_PER_LGR_MAX, it does not
mean that the connection can register rtoken successfully later. In
other words, the rtoken entry may released, This will cause an
unexpected SMC_CLC_DECL_ERR_REGRMB to be reported, and then this SMC 
connections have to fallback to TCP.

This patch set handles two types of SMC_CLC_DECL_ERR_REGRMB exceptions
from different perspectives.

Patch 1: fix the 0x05000000/0x09990003 error.
Patch 2: fix the 0x09990003 error.

After those patches, there is no SMC_CLC_DECL_ERR_REGRMB exceptions in my
test case any more.

D. Wythe (2):
  net/smc: fix unexpected SMC_CLC_DECL_ERR_REGRMB error generated by
    client
  net/smc: fix unexpected SMC_CLC_DECL_ERR_REGRMB error cause by server

 net/smc/smc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
1.8.3.1

