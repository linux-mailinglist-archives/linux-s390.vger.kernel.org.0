Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F77F7A670D
	for <lists+linux-s390@lfdr.de>; Tue, 19 Sep 2023 16:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbjISOnM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Sep 2023 10:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjISOnI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Sep 2023 10:43:08 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D383D194;
        Tue, 19 Sep 2023 07:42:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VsRxWAF_1695134571;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsRxWAF_1695134571)
          by smtp.aliyun-inc.com;
          Tue, 19 Sep 2023 22:42:53 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/18] net/smc: introduce SMC-D loopback device
Date:   Tue, 19 Sep 2023 22:41:53 +0800
Message-Id: <1695134522-126655-10-git-send-email-guwen@linux.alibaba.com>
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

This patch introduces a kind of loopback device for SMC-D. The device
is created when SMC module is loaded and destroyed when the SMC module
is unloaded. The loopback device is a kernel device used only by the
SMC module and is not restricted by net namespace, so it can be used
for local inter-process or inter-container communication.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/Makefile       |   2 +-
 net/smc/af_smc.c       |  12 +++-
 net/smc/smc_loopback.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  31 ++++++++++
 4 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 net/smc/smc_loopback.c
 create mode 100644 net/smc/smc_loopback.h

diff --git a/net/smc/Makefile b/net/smc/Makefile
index 875efcd..a8c3711 100644
--- a/net/smc/Makefile
+++ b/net/smc/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_SMC)	+= smc.o
 obj-$(CONFIG_SMC_DIAG)	+= smc_diag.o
 smc-y := af_smc.o smc_pnet.o smc_ib.o smc_clc.o smc_core.o smc_wr.o smc_llc.o
 smc-y += smc_cdc.o smc_tx.o smc_rx.o smc_close.o smc_ism.o smc_netlink.o smc_stats.o
-smc-y += smc_tracepoint.o
+smc-y += smc_tracepoint.o smc_loopback.o
 smc-$(CONFIG_SYSCTL) += smc_sysctl.o
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7eab600..bc4300e 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -53,6 +53,7 @@
 #include "smc_stats.h"
 #include "smc_tracepoint.h"
 #include "smc_sysctl.h"
+#include "smc_loopback.h"
 
 static DEFINE_MUTEX(smc_server_lgr_pending);	/* serialize link group
 						 * creation on server
@@ -3552,15 +3553,23 @@ static int __init smc_init(void)
 		goto out_sock;
 	}
 
+	rc = smc_loopback_init();
+	if (rc) {
+		pr_err("%s: smc_loopback_init fails with %d\n", __func__, rc);
+		goto out_ib;
+	}
+
 	rc = tcp_register_ulp(&smc_ulp_ops);
 	if (rc) {
 		pr_err("%s: tcp_ulp_register fails with %d\n", __func__, rc);
-		goto out_ib;
+		goto out_lo;
 	}
 
 	static_branch_enable(&tcp_have_smc);
 	return 0;
 
+out_lo:
+	smc_loopback_exit();
 out_ib:
 	smc_ib_unregister_client();
 out_sock:
@@ -3598,6 +3607,7 @@ static void __exit smc_exit(void)
 	tcp_unregister_ulp(&smc_ulp_ops);
 	sock_unregister(PF_SMC);
 	smc_core_exit();
+	smc_loopback_exit();
 	smc_ib_unregister_client();
 	smc_ism_exit();
 	destroy_workqueue(smc_close_wq);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
new file mode 100644
index 0000000..7d88856
--- /dev/null
+++ b/net/smc/smc_loopback.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Shared Memory Communications Direct over loopback device.
+ *
+ *  Provide a SMC-D loopback dummy device.
+ *
+ *  Copyright (c) 2022, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#include <linux/device.h>
+#include <linux/types.h>
+#include <net/smc.h>
+
+#include "smc_ism.h"
+#include "smc_loopback.h"
+
+static const char smc_lo_dev_name[] = "smc_lo";
+static struct smc_lo_dev *lo_dev;
+
+static const struct smcd_ops lo_ops = {
+	.query_remote_gid	= NULL,
+	.register_dmb		= NULL,
+	.unregister_dmb		= NULL,
+	.add_vlan_id		= NULL,
+	.del_vlan_id		= NULL,
+	.set_vlan_required	= NULL,
+	.reset_vlan_required	= NULL,
+	.signal_event		= NULL,
+	.move_data		= NULL,
+	.supports_v2		= NULL,
+	.get_system_eid		= NULL,
+	.get_local_gid		= NULL,
+	.get_chid		= NULL,
+	.get_dev		= NULL,
+};
+
+static struct smcd_dev *smcd_lo_alloc_dev(const struct smcd_ops *ops,
+					  int max_dmbs)
+{
+	struct smcd_dev *smcd;
+
+	smcd = kzalloc(sizeof(*smcd), GFP_KERNEL);
+	if (!smcd)
+		return NULL;
+
+	smcd->conn = kcalloc(max_dmbs, sizeof(struct smc_connection *),
+			     GFP_KERNEL);
+	if (!smcd->conn)
+		goto out_smcd;
+
+	smcd->ops = ops;
+
+	spin_lock_init(&smcd->lock);
+	spin_lock_init(&smcd->lgr_lock);
+	INIT_LIST_HEAD(&smcd->vlan);
+	INIT_LIST_HEAD(&smcd->lgr_list);
+	init_waitqueue_head(&smcd->lgrs_deleted);
+	return smcd;
+
+out_smcd:
+	kfree(smcd);
+	return NULL;
+}
+
+static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
+{
+	struct smcd_dev *smcd;
+
+	smcd = smcd_lo_alloc_dev(&lo_ops, SMC_LODEV_MAX_DMBS);
+	if (!smcd)
+		return -ENOMEM;
+
+	ldev->smcd = smcd;
+	smcd->priv = ldev;
+
+	/* TODO:
+	 * register smc_lo to smcd_dev list.
+	 */
+	return 0;
+}
+
+static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
+{
+	/* TODO:
+	 * unregister smc_lo from smcd_dev list.
+	 */
+}
+
+static void smc_lo_dev_release(struct device *dev)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	struct smcd_dev *smcd = ldev->smcd;
+
+	kfree(smcd->conn);
+	kfree(smcd);
+	kfree(ldev);
+}
+
+static int smc_lo_dev_init(struct smc_lo_dev *ldev)
+{
+	return smcd_lo_register_dev(ldev);
+}
+
+static int smc_lo_dev_probe(void)
+{
+	struct smc_lo_dev *ldev;
+	int ret;
+
+	ldev = kzalloc(sizeof(*ldev), GFP_KERNEL);
+	if (!ldev)
+		return -ENOMEM;
+
+	ldev->dev.parent = NULL;
+	ldev->dev.release = smc_lo_dev_release;
+	device_initialize(&ldev->dev);
+	dev_set_name(&ldev->dev, smc_lo_dev_name);
+
+	ret = smc_lo_dev_init(ldev);
+	if (ret)
+		goto free_dev;
+
+	lo_dev = ldev; /* global loopback device */
+	return 0;
+
+free_dev:
+	kfree(ldev);
+	return ret;
+}
+
+static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
+{
+	smcd_lo_unregister_dev(ldev);
+}
+
+static void smc_lo_dev_remove(void)
+{
+	if (!lo_dev)
+		return;
+
+	smc_lo_dev_exit(lo_dev);
+	put_device(&lo_dev->dev); /* device_initialize in smc_lo_dev_probe */
+}
+
+int smc_loopback_init(void)
+{
+	return smc_lo_dev_probe();
+}
+
+void smc_loopback_exit(void)
+{
+	smc_lo_dev_remove();
+}
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
new file mode 100644
index 0000000..0f7583c
--- /dev/null
+++ b/net/smc/smc_loopback.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Shared Memory Communications Direct over loopback device.
+ *
+ *  Provide a SMC-D loopback dummy device.
+ *
+ *  Copyright (c) 2022, Alibaba Inc.
+ *
+ *  Author: Wen Gu <guwen@linux.alibaba.com>
+ *          Tony Lu <tonylu@linux.alibaba.com>
+ *
+ */
+
+#ifndef _SMC_LOOPBACK_H
+#define _SMC_LOOPBACK_H
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <net/smc.h>
+
+#define SMC_LODEV_MAX_DMBS 5000
+
+struct smc_lo_dev {
+	struct smcd_dev *smcd;
+	struct device dev;
+};
+
+int smc_loopback_init(void);
+void smc_loopback_exit(void);
+
+#endif /* _SMC_LOOPBACK_H */
-- 
1.8.3.1

