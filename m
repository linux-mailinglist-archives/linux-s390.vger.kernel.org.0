Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E705270A9
	for <lists+linux-s390@lfdr.de>; Sat, 14 May 2022 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiENK17 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 14 May 2022 06:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiENK16 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 14 May 2022 06:27:58 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0117A39144;
        Sat, 14 May 2022 03:27:55 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VD6nQiA_1652524072;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VD6nQiA_1652524072)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 14 May 2022 18:27:53 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     kgraul@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, leon@kernel.org
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] net/smc: send and write inline optimization for smc
Date:   Sat, 14 May 2022 18:27:37 +0800
Message-Id: <20220514102739.41252-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Send cdc msgs and write data inline if qp has sufficent inline
space, helps latency reducing. 

In my test environment, which are 2 VMs running on the same
physical host and whose NICs(ConnectX-4Lx) are working on
SR-IOV mode, qperf shows 0.4us-1.3us improvement in latency.

Test command:
server: smc_run taskset -c 1 qperf
client: smc_run taskset -c 1 qperf <server ip> -oo \
		msg_size:1:2K:*2 -t 30 -vu tcp_lat

The results shown below:
msgsize     before       after
1B          11.9 us      10.6 us (-1.3 us)
2B          11.7 us      10.7 us (-1.0 us)
4B          11.7 us      10.7 us (-1.0 us)
8B          11.6 us      10.6 us (-1.0 us)
16B         11.7 us      10.7 us (-1.0 us)
32B         11.7 us      10.6 us (-1.1 us)
64B         11.7 us      11.2 us (-0.5 us)
128B        11.6 us      11.2 us (-0.4 us)
256B        11.8 us      11.2 us (-0.6 us)
512B        11.8 us      11.3 us (-0.5 us)
1KB         11.9 us      11.5 us (-0.4 us)
2KB         12.1 us      11.5 us (-0.6 us)

Guangguan Wang (2):
  net/smc: send cdc msg inline if qp has sufficient inline space
  net/smc: rdma write inline if qp has sufficient inline space

 net/smc/smc_ib.c |  1 +
 net/smc/smc_tx.c | 17 ++++++++++++-----
 net/smc/smc_wr.c |  5 ++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

-- 
2.24.3 (Apple Git-128)

