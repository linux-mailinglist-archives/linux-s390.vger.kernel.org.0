Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDCB7C9F52
	for <lists+linux-s390@lfdr.de>; Mon, 16 Oct 2023 08:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjJPGME (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Oct 2023 02:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPGMD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 16 Oct 2023 02:12:03 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36572D9;
        Sun, 15 Oct 2023 23:11:58 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R971e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VuBTOLS_1697436713;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VuBTOLS_1697436713)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 14:11:54 +0800
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     tonylu@linux.alibaba.com, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: correct the reason code in smc_listen_find_device when fallback
Date:   Mon, 16 Oct 2023 14:11:53 +0800
Message-Id: <20231016061153.40057-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The function smc_find_ism_store_rc is not only used for ism, so it is
reasonable to change the function name to smc_find_device_store_rc.

The ini->rc is used to store the last error happened when finding usable
ism or rdma device in smc_listen_find_device, and is set by calling smc_
find_device_store_rc. Once the ini->rc is assigned to an none-zero value,
the value can not be overwritten anymore. So the ini-rc should be set to
the error reason only when an error actually occurs.

When finding ISM/RDMA devices, device not found is not a real error, as
not all machine have ISM/RDMA devices. Failures after device found, when
initializing device or when initializing connection, is real errors, and
should be store in ini->rc.

SMC_CLC_DECL_DIFFPREFIX also is not a real error, as for SMC-RV2, it is
not require same prefix.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
---
 net/smc/af_smc.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index bacdd971615e..15d8ad7af75d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2121,7 +2121,7 @@ static void smc_check_ism_v2_match(struct smc_init_info *ini,
 	}
 }
 
-static void smc_find_ism_store_rc(u32 rc, struct smc_init_info *ini)
+static void smc_find_device_store_rc(u32 rc, struct smc_init_info *ini)
 {
 	if (!ini->rc)
 		ini->rc = rc;
@@ -2162,10 +2162,8 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 	}
 	mutex_unlock(&smcd_dev_list.mutex);
 
-	if (!ini->ism_dev[0]) {
-		smc_find_ism_store_rc(SMC_CLC_DECL_NOSMCD2DEV, ini);
+	if (!ini->ism_dev[0])
 		goto not_found;
-	}
 
 	smc_ism_get_system_eid(&eid);
 	if (!smc_clc_match_eid(ini->negotiated_eid, smc_v2_ext,
@@ -2180,7 +2178,7 @@ static void smc_find_ism_v2_device_serv(struct smc_sock *new_smc,
 		ini->ism_selected = i;
 		rc = smc_listen_ism_init(new_smc, ini);
 		if (rc) {
-			smc_find_ism_store_rc(rc, ini);
+			smc_find_device_store_rc(rc, ini);
 			/* try next active ISM device */
 			continue;
 		}
@@ -2213,11 +2211,12 @@ static void smc_find_ism_v1_device_serv(struct smc_sock *new_smc,
 		goto not_found;
 	ini->ism_selected = 0;
 	rc = smc_listen_ism_init(new_smc, ini);
-	if (!rc)
+	if (!rc) {
+		smc_find_device_store_rc(rc, ini);
 		return;		/* V1 ISM device found */
+	}
 
 not_found:
-	smc_find_ism_store_rc(rc, ini);
 	ini->smcd_version &= ~SMC_V1;
 	ini->ism_dev[0] = NULL;
 	ini->is_smcd = false;
@@ -2266,10 +2265,8 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	ini->smcrv2.saddr = new_smc->clcsock->sk->sk_rcv_saddr;
 	ini->smcrv2.daddr = smc_ib_gid_to_ipv4(smc_v2_ext->roce);
 	rc = smc_find_rdma_device(new_smc, ini);
-	if (rc) {
-		smc_find_ism_store_rc(rc, ini);
+	if (rc)
 		goto not_found;
-	}
 	if (!ini->smcrv2.uses_gateway)
 		memcpy(ini->smcrv2.nexthop_mac, pclc->lcl.mac, ETH_ALEN);
 
@@ -2284,7 +2281,7 @@ static void smc_find_rdma_v2_device_serv(struct smc_sock *new_smc,
 	if (!rc)
 		return;
 	ini->smcr_version = smcr_version;
-	smc_find_ism_store_rc(rc, ini);
+	smc_find_device_store_rc(rc, ini);
 
 not_found:
 	ini->smcr_version &= ~SMC_V2;
@@ -2330,8 +2327,6 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 
 	/* check for matching IP prefix and subnet length (V1) */
 	prfx_rc = smc_listen_prfx_check(new_smc, pclc);
-	if (prfx_rc)
-		smc_find_ism_store_rc(prfx_rc, ini);
 
 	/* get vlan id from IP device */
 	if (smc_vlan_by_tcpsk(new_smc->clcsock, ini))
@@ -2358,7 +2353,7 @@ static int smc_listen_find_device(struct smc_sock *new_smc,
 		int rc;
 
 		rc = smc_find_rdma_v1_device_serv(new_smc, pclc, ini);
-		smc_find_ism_store_rc(rc, ini);
+		smc_find_device_store_rc(rc, ini);
 		return (!rc) ? 0 : ini->rc;
 	}
 	return SMC_CLC_DECL_NOSMCDEV;
-- 
2.24.3 (Apple Git-128)

