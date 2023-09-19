Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A1C7A6707
	for <lists+linux-s390@lfdr.de>; Tue, 19 Sep 2023 16:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjISOnS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Sep 2023 10:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbjISOnJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Sep 2023 10:43:09 -0400
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15471A8;
        Tue, 19 Sep 2023 07:42:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxWB5_1695134574;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxWB5_1695134574)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:42:56 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 10/18] net/smc: implement ID-related operations of loopback
Date:   Tue, 19 Sep 2023 22:41:54 +0800
Message-Id: <1695134522-126655-11-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
References: <1695134522-126655-1-git-send-email-guwen@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patch implements GID/CHID/SEID related operations of SMC-D loopback
device. In loopback device, GID is generated by UUIDv4 algorithm, CHID is
reserved 0xFFFF, SEID is generated using the same algorithm as ISM device
under s390 architecture, and is 0 and disabled under non-s390 architecture.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/net/smc.h      |  6 ++++
 net/smc/smc_ism.h      |  2 ++
 net/smc/smc_loopback.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++----
 net/smc/smc_loopback.h |  3 ++
 4 files changed, 100 insertions(+), 6 deletions(-)

diff --git a/include/net/smc.h b/include/net/smc.h
index a37fb38..389d26d 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -41,6 +41,12 @@ struct smcd_dmb {
 	dma_addr_t dma_addr;
 };
 
+struct smcd_seid {
+	u8 seid_string[24];
+	u8 serial_number[4];
+	u8 type[4];
+};
+
 #define ISM_EVENT_DMB	0
 #define ISM_EVENT_GID	1
 #define ISM_EVENT_SWR	2
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index e6ea08c..7ab82dd 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -15,6 +15,8 @@
 
 #include "smc.h"
 
+#define S390_ISM_IDENT_MASK		0x00FFFF
+
 #define SMC_VIRT_ISM_CHID_MAX		0xFFFF
 #define SMC_VIRT_ISM_CHID_MIN		0xFF00
 
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 7d88856..6b8ff65 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -18,11 +18,92 @@
 #include "smc_ism.h"
 #include "smc_loopback.h"
 
+#define SMC_LO_SUPPORTS_V2	0x1 /* SMC-D loopback supports SMC-Dv2 */
+
 static const char smc_lo_dev_name[] = "smc_lo";
+static struct smcd_seid SMC_LO_SEID = {
+	.seid_string = "IBM-SYSZ-ISMSEID00000000",
+	.serial_number = "0000",
+	.type = "0000",
+};
+
 static struct smc_lo_dev *lo_dev;
 
+static void smc_lo_create_seid(struct smcd_seid *seid)
+{
+#if IS_ENABLED(CONFIG_S390)
+	struct cpuid id;
+	u16 ident_tail;
+	char tmp[5];
+
+	get_cpu_id(&id);
+	ident_tail = (u16)(id.ident & S390_ISM_IDENT_MASK);
+	snprintf(tmp, 5, "%04X", ident_tail);
+	memcpy(&seid->serial_number, tmp, 4);
+	snprintf(tmp, 5, "%04X", id.machine);
+	memcpy(&seid->type, tmp, 4);
+#else
+	memset(seid, 0, SMC_MAX_EID_LEN);
+#endif
+}
+
+static void smc_lo_generate_id(struct smc_lo_dev *ldev)
+{
+	struct smcd_gid *lgid = &ldev->local_gid;
+	uuid_t uuid;
+
+	uuid_gen(&uuid);
+	memcpy(&lgid->gid, &uuid, sizeof(lgid->gid));
+	memcpy(&lgid->gid_ext, (u8 *)&uuid + sizeof(lgid->gid),
+	       sizeof(lgid->gid_ext));
+
+	ldev->chid = SMC_LO_CHID;
+	smc_lo_create_seid(&SMC_LO_SEID);
+}
+
+static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
+			     u32 vid_valid, u32 vid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	/* rgid should equal to lgid in loopback */
+	if (!ldev || rgid->gid != ldev->local_gid.gid ||
+	    rgid->gid_ext != ldev->local_gid.gid_ext)
+		return -ENETUNREACH;
+	return 0;
+}
+
+static int smc_lo_supports_v2(void)
+{
+	return SMC_LO_SUPPORTS_V2;
+}
+
+static u8 *smc_lo_get_system_eid(void)
+{
+	return SMC_LO_SEID.seid_string;
+}
+
+static void smc_lo_get_local_gid(struct smcd_dev *smcd,
+				 struct smcd_gid *smcd_gid)
+{
+	struct smc_lo_dev *ldev = smcd->priv;
+
+	smcd_gid->gid = ldev->local_gid.gid;
+	smcd_gid->gid_ext = ldev->local_gid.gid_ext;
+}
+
+static u16 smc_lo_get_chid(struct smcd_dev *smcd)
+{
+	return ((struct smc_lo_dev *)smcd->priv)->chid;
+}
+
+static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
+{
+	return &((struct smc_lo_dev *)smcd->priv)->dev;
+}
+
 static const struct smcd_ops lo_ops = {
-	.query_remote_gid	= NULL,
+	.query_remote_gid = smc_lo_query_rgid,
 	.register_dmb		= NULL,
 	.unregister_dmb		= NULL,
 	.add_vlan_id		= NULL,
@@ -31,11 +112,11 @@
 	.reset_vlan_required	= NULL,
 	.signal_event		= NULL,
 	.move_data		= NULL,
-	.supports_v2		= NULL,
-	.get_system_eid		= NULL,
-	.get_local_gid		= NULL,
-	.get_chid		= NULL,
-	.get_dev		= NULL,
+	.supports_v2 = smc_lo_supports_v2,
+	.get_system_eid = smc_lo_get_system_eid,
+	.get_local_gid = smc_lo_get_local_gid,
+	.get_chid = smc_lo_get_chid,
+	.get_dev = smc_lo_get_dev,
 };
 
 static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
@@ -103,6 +184,8 @@ static void smc_lo_dev_release(struct device *dev)
 
 static int smc_lo_dev_init(struct smc_lo_dev *ldev)
 {
+	smc_lo_generate_id(ldev);
+
 	return smcd_lo_register_dev(ldev);
 }
 
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 0f7583c..2156f22 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -18,11 +18,14 @@
 #include <linux/err.h>
 #include <net/smc.h>
 
+#define SMC_LO_CHID 0xFFFF
 #define SMC_LODEV_MAX_DMBS 5000
 
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
+	u16 chid;
+	struct smcd_gid local_gid;
 };
 
 int smc_loopback_init(void);
-- 
1.8.3.1

