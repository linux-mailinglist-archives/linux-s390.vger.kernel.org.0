Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4955BDA77
	for <lists+linux-s390@lfdr.de>; Tue, 20 Sep 2022 04:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiITCyM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Sep 2022 22:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiITCyK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Sep 2022 22:54:10 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A288F54652;
        Mon, 19 Sep 2022 19:54:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VQGxTZu_1663642435;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VQGxTZu_1663642435)
          by smtp.aliyun-inc.com;
          Tue, 20 Sep 2022 10:54:06 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net/smc: Introduce a specific sysctl for TEST_LINK time
Date:   Tue, 20 Sep 2022 10:53:54 +0800
Message-Id: <1663642434-30035-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1663641907-15852-1-git-send-email-guwen@linux.alibaba.com>
References: <1663641907-15852-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

SMC-R tests the viability of link by sending out TEST_LINK LLC
messages over RoCE fabric when connections on link have been
idle for a time longer than keepalive interval (testlink time).

But using tcp_keepalive_time as testlink time maybe not quite
suitable because it is default no less than two hours[1], which
is too long for single link to find peer dead. The active host
will still use peer-dead link (QP) sending messages, and can't
find out until get IB_WC_RETRY_EXC_ERR error CQEs, which takes
more time than TEST_LINK timeout (SMC_LLC_WAIT_TIME) normally.

So this patch introduces a independent sysctl for SMC-R to set
link keepalive time, in order to detect link down in time. The
default value is 30 seconds.

[1] https://www.rfc-editor.org/rfc/rfc1122#page-101

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 Documentation/networking/smc-sysctl.rst |  7 +++++++
 include/net/netns/smc.h                 |  1 +
 net/smc/smc_llc.c                       |  2 +-
 net/smc/smc_llc.h                       |  1 +
 net/smc/smc_sysctl.c                    | 14 ++++++++++++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
index 742e90e..f8c3d59 100644
--- a/Documentation/networking/smc-sysctl.rst
+++ b/Documentation/networking/smc-sysctl.rst
@@ -34,3 +34,10 @@ smcr_buf_type - INTEGER
         - 1 - Use virtually contiguous buffers
         - 2 - Mixed use of the two types. Try physically contiguous buffers first.
           If not available, use virtually contiguous buffers then.
+
+smcr_testlink_time - INTEGER
+	How frequently SMC-R link sends out TEST_LINK LLC messages to confirm
+	viability, after the last activity of connections on it. The maximum
+	value is (INT_MAX / HZ) seconds, the minimum value is 1 second.
+
+	Default: 30 seconds.
diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
index 2adbe2b..d295e2c 100644
--- a/include/net/netns/smc.h
+++ b/include/net/netns/smc.h
@@ -19,5 +19,6 @@ struct netns_smc {
 #endif
 	unsigned int			sysctl_autocorking_size;
 	unsigned int			sysctl_smcr_buf_type;
+	int				sysctl_smcr_testlink_time;
 };
 #endif
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 175026a..388bd2e 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -2127,7 +2127,7 @@ void smc_llc_lgr_init(struct smc_link_group *lgr, struct smc_sock *smc)
 	init_waitqueue_head(&lgr->llc_flow_waiter);
 	init_waitqueue_head(&lgr->llc_msg_waiter);
 	mutex_init(&lgr->llc_conf_mutex);
-	lgr->llc_testlink_time = READ_ONCE(net->ipv4.sysctl_tcp_keepalive_time);
+	lgr->llc_testlink_time = READ_ONCE(net->smc.sysctl_smcr_testlink_time) * HZ;
 }
 
 /* called after lgr was removed from lgr_list */
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 4404e52..1de9a29 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -19,6 +19,7 @@
 
 #define SMC_LLC_WAIT_FIRST_TIME		(5 * HZ)
 #define SMC_LLC_WAIT_TIME		(2 * HZ)
+#define SMC_LLC_TESTLINK_DEFAULT_TIME	30
 
 enum smc_llc_reqresp {
 	SMC_LLC_REQ,
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index 0613868..7f68520 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -16,8 +16,12 @@
 
 #include "smc.h"
 #include "smc_core.h"
+#include "smc_llc.h"
 #include "smc_sysctl.h"
 
+static int smcr_testlink_time_min = 1;
+static int smcr_testlink_time_max = (INT_MAX / HZ);
+
 static struct ctl_table smc_table[] = {
 	{
 		.procname       = "autocorking_size",
@@ -35,6 +39,15 @@
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
+	{
+		.procname	= "smcr_testlink_time",
+		.data		= &init_net.smc.sysctl_smcr_testlink_time,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= &smcr_testlink_time_min,
+		.extra2		= &smcr_testlink_time_max,
+	},
 	{  }
 };
 
@@ -60,6 +73,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
 
 	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
 	net->smc.sysctl_smcr_buf_type = SMCR_PHYS_CONT_BUFS;
+	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
 
 	return 0;
 
-- 
1.8.3.1

