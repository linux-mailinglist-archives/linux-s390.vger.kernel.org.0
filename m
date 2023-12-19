Return-Path: <linux-s390+bounces-667-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1048189F3
	for <lists+linux-s390@lfdr.de>; Tue, 19 Dec 2023 15:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F67F284672
	for <lists+linux-s390@lfdr.de>; Tue, 19 Dec 2023 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF91C298;
	Tue, 19 Dec 2023 14:26:51 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD48358BA;
	Tue, 19 Dec 2023 14:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0Vyr6oSA_1702996003;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vyr6oSA_1702996003)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 22:26:45 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wintera@linux.ibm.com,
	wenjia@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kgraul@linux.ibm.com,
	jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	raspl@linux.ibm.com,
	schnelle@linux.ibm.com,
	guangguan.wang@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 10/10] net/smc: manage system EID in SMC stack instead of ISM driver
Date: Tue, 19 Dec 2023 22:26:16 +0800
Message-ID: <20231219142616.80697-11-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219142616.80697-1-guwen@linux.alibaba.com>
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The System EID (SEID) is an internal EID that is used by the SMCv2
software stack that has a predefined and constant value representing
the s390 physical machine that the OS is executing on. So it should
be managed by SMC stack instead of ISM driver and be consistent for
all ISMv2 device (including virtual ISM devices) on s390 architecture.

Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism.h     |  7 -------
 drivers/s390/net/ism_drv.c | 38 ++++++--------------------------------
 include/linux/ism.h        |  1 -
 include/net/smc.h          |  1 -
 net/smc/smc_ism.c          | 33 ++++++++++++++++++++++++---------
 net/smc/smc_ism.h          |  7 +++++++
 6 files changed, 37 insertions(+), 50 deletions(-)

diff --git a/drivers/s390/net/ism.h b/drivers/s390/net/ism.h
index 70c5bbda0fea..047fa6101555 100644
--- a/drivers/s390/net/ism.h
+++ b/drivers/s390/net/ism.h
@@ -16,7 +16,6 @@
  */
 #define ISM_DMB_WORD_OFFSET	1
 #define ISM_DMB_BIT_OFFSET	(ISM_DMB_WORD_OFFSET * 32)
-#define ISM_IDENT_MASK		0x00FFFF
 
 #define ISM_REG_SBA	0x1
 #define ISM_REG_IEQ	0x2
@@ -192,12 +191,6 @@ struct ism_sba {
 #define ISM_CREATE_REQ(dmb, idx, sf, offset)		\
 	((dmb) | (idx) << 24 | (sf) << 23 | (offset))
 
-struct ism_systemeid {
-	u8	seid_string[24];
-	u8	serial_number[4];
-	u8	type[4];
-};
-
 static inline void __ism_read_cmd(struct ism_dev *ism, void *data,
 				  unsigned long offset, unsigned long len)
 {
diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 34dd06324e38..2c8e964425dc 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -36,6 +36,7 @@ static struct ism_client *clients[MAX_CLIENTS];	/* use an array rather than */
 						/* a list for fast mapping  */
 static u8 max_client;
 static DEFINE_MUTEX(clients_lock);
+static bool ism_v2_capable;
 struct ism_dev_list {
 	struct list_head list;
 	struct mutex mutex; /* protects ism device list */
@@ -443,32 +444,6 @@ int ism_move(struct ism_dev *ism, u64 dmb_tok, unsigned int idx, bool sf,
 }
 EXPORT_SYMBOL_GPL(ism_move);
 
-static struct ism_systemeid SYSTEM_EID = {
-	.seid_string = "IBM-SYSZ-ISMSEID00000000",
-	.serial_number = "0000",
-	.type = "0000",
-};
-
-static void ism_create_system_eid(void)
-{
-	struct cpuid id;
-	u16 ident_tail;
-	char tmp[5];
-
-	get_cpu_id(&id);
-	ident_tail = (u16)(id.ident & ISM_IDENT_MASK);
-	snprintf(tmp, 5, "%04X", ident_tail);
-	memcpy(&SYSTEM_EID.serial_number, tmp, 4);
-	snprintf(tmp, 5, "%04X", id.machine);
-	memcpy(&SYSTEM_EID.type, tmp, 4);
-}
-
-u8 *ism_get_seid(void)
-{
-	return SYSTEM_EID.seid_string;
-}
-EXPORT_SYMBOL_GPL(ism_get_seid);
-
 static void ism_handle_event(struct ism_dev *ism)
 {
 	struct ism_event *entry;
@@ -560,7 +535,9 @@ static int ism_dev_init(struct ism_dev *ism)
 
 	if (!ism_add_vlan_id(ism, ISM_RESERVED_VLANID))
 		/* hardware is V2 capable */
-		ism_create_system_eid();
+		ism_v2_capable = true;
+	else
+		ism_v2_capable = false;
 
 	mutex_lock(&ism_dev_list.mutex);
 	mutex_lock(&clients_lock);
@@ -665,8 +642,7 @@ static void ism_dev_exit(struct ism_dev *ism)
 	}
 	mutex_unlock(&clients_lock);
 
-	if (SYSTEM_EID.serial_number[0] != '0' ||
-	    SYSTEM_EID.type[0] != '0')
+	if (ism_v2_capable)
 		ism_del_vlan_id(ism, ISM_RESERVED_VLANID);
 	unregister_ieq(ism);
 	unregister_sba(ism);
@@ -813,8 +789,7 @@ static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
 
 static int smcd_supports_v2(void)
 {
-	return SYSTEM_EID.serial_number[0] != '0' ||
-		SYSTEM_EID.type[0] != '0';
+	return ism_v2_capable;
 }
 
 static u64 ism_get_local_gid(struct ism_dev *ism)
@@ -860,7 +835,6 @@ static const struct smcd_ops ism_ops = {
 	.signal_event = smcd_signal_ieq,
 	.move_data = smcd_move,
 	.supports_v2 = smcd_supports_v2,
-	.get_system_eid = ism_get_seid,
 	.get_local_gid = smcd_get_local_gid,
 	.get_chid = smcd_get_chid,
 	.get_dev = smcd_get_dev,
diff --git a/include/linux/ism.h b/include/linux/ism.h
index 9a4c204df3da..5428edd90982 100644
--- a/include/linux/ism.h
+++ b/include/linux/ism.h
@@ -86,7 +86,6 @@ int  ism_register_dmb(struct ism_dev *dev, struct ism_dmb *dmb,
 int  ism_unregister_dmb(struct ism_dev *dev, struct ism_dmb *dmb);
 int  ism_move(struct ism_dev *dev, u64 dmb_tok, unsigned int idx, bool sf,
 	      unsigned int offset, void *data, unsigned int size);
-u8  *ism_get_seid(void);
 
 const struct smcd_ops *ism_get_smcd_ops(void);
 
diff --git a/include/net/smc.h b/include/net/smc.h
index a0dc1187e96e..c9dcb30e3fd9 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -73,7 +73,6 @@ struct smcd_ops {
 			 bool sf, unsigned int offset, void *data,
 			 unsigned int size);
 	int (*supports_v2)(void);
-	u8* (*get_system_eid)(void);
 	void (*get_local_gid)(struct smcd_dev *dev, struct smcd_gid *gid);
 	u16 (*get_chid)(struct smcd_dev *dev);
 	struct device* (*get_dev)(struct smcd_dev *dev);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index a33f861cf7c1..ac88de2a06a0 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -43,6 +43,27 @@ static struct ism_client smc_ism_client = {
 };
 #endif
 
+static void smc_ism_create_system_eid(void)
+{
+	struct smc_ism_seid *seid =
+		(struct smc_ism_seid *)smc_ism_v2_system_eid;
+#if IS_ENABLED(CONFIG_S390)
+	struct cpuid id;
+	u16 ident_tail;
+	char tmp[5];
+
+	memcpy(seid->seid_string, "IBM-SYSZ-ISMSEID00000000", 24);
+	get_cpu_id(&id);
+	ident_tail = (u16)(id.ident & SMC_ISM_IDENT_MASK);
+	snprintf(tmp, 5, "%04X", ident_tail);
+	memcpy(seid->serial_number, tmp, 4);
+	snprintf(tmp, 5, "%04X", id.machine);
+	memcpy(seid->type, tmp, 4);
+#else
+	memset(seid, 0, SMC_MAX_EID_LEN);
+#endif
+}
+
 /* Test if an ISM communication is possible - same CPC */
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
 		    struct smcd_dev *smcd)
@@ -431,14 +452,8 @@ static void smcd_register_dev(struct ism_dev *ism)
 
 	mutex_lock(&smcd_dev_list.mutex);
 	if (list_empty(&smcd_dev_list.list)) {
-		u8 *system_eid = NULL;
-
-		system_eid = smcd->ops->get_system_eid();
-		if (smcd->ops->supports_v2()) {
+		if (smcd->ops->supports_v2())
 			smc_ism_v2_capable = true;
-			memcpy(smc_ism_v2_system_eid, system_eid,
-			       SMC_MAX_EID_LEN);
-		}
 	}
 	/* sort list: devices without pnetid before devices with pnetid */
 	if (smcd->pnetid[0])
@@ -542,10 +557,10 @@ int smc_ism_init(void)
 {
 	int rc = 0;
 
-#if IS_ENABLED(CONFIG_ISM)
 	smc_ism_v2_capable = false;
-	memset(smc_ism_v2_system_eid, 0, SMC_MAX_EID_LEN);
+	smc_ism_create_system_eid();
 
+#if IS_ENABLED(CONFIG_ISM)
 	rc = ism_register_client(&smc_ism_client);
 #endif
 	return rc;
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 0e5e563099ec..ffff40c30a06 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -16,6 +16,7 @@
 #include "smc.h"
 
 #define SMC_VIRTUAL_ISM_CHID_MASK	0xFF00
+#define SMC_ISM_IDENT_MASK		0x00FFFF
 
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
@@ -30,6 +31,12 @@ struct smc_ism_vlanid {			/* VLAN id set on ISM device */
 	refcount_t refcnt;		/* Reference count */
 };
 
+struct smc_ism_seid {
+	u8 seid_string[24];
+	u8 serial_number[4];
+	u8 type[4];
+};
+
 struct smcd_dev;
 
 int smc_ism_cantalk(struct smcd_gid *peer_gid, unsigned short vlan_id,
-- 
2.43.0


