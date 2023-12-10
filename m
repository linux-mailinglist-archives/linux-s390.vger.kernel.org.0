Return-Path: <linux-s390+bounces-441-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CD80BB02
	for <lists+linux-s390@lfdr.de>; Sun, 10 Dec 2023 14:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9901F21057
	for <lists+linux-s390@lfdr.de>; Sun, 10 Dec 2023 13:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B9CA50;
	Sun, 10 Dec 2023 13:24:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FBE10E7;
	Sun, 10 Dec 2023 05:24:37 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vy8Bbrt_1702214673;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy8Bbrt_1702214673)
          by smtp.aliyun-inc.com;
          Sun, 10 Dec 2023 21:24:35 +0800
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
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH net-next 08/13] net/smc: introduce loopback-ism runtime switch
Date: Sun, 10 Dec 2023 21:24:09 +0800
Message-Id: <1702214654-32069-9-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
References: <1702214654-32069-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

This provides a runtime switch to activate or deactivate loopback-ism
device by echo {1|0} > /sys/devices/virtual/smc/loopback-ism/active. It
will trigger the registration or removal of loopback-ism from the SMC-D
device list.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_loopback.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++
 net/smc/smc_loopback.h |  1 +
 2 files changed, 56 insertions(+)

diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 83bc9a7..04f8612 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -28,6 +28,58 @@
 static struct smc_lo_dev *lo_dev;
 static struct class *smc_class;
 
+static int smcd_lo_register_dev(struct smc_lo_dev *ldev);
+static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev);
+
+static ssize_t active_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+
+	return sysfs_emit(buf, "%d\n", ldev->active);
+}
+
+static ssize_t active_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct smc_lo_dev *ldev =
+		container_of(dev, struct smc_lo_dev, dev);
+	bool active;
+	int ret;
+
+	ret = kstrtobool(buf, &active);
+	if (ret)
+		return ret;
+
+	if (active && !ldev->active) {
+		/* activate loopback-ism */
+		ret = smcd_lo_register_dev(ldev);
+		if (ret)
+			return ret;
+	} else if (!active && ldev->active) {
+		/* deactivate loopback-ism */
+		smcd_lo_unregister_dev(ldev);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(active);
+static struct attribute *smc_lo_attrs[] = {
+	&dev_attr_active.attr,
+	NULL
+};
+
+static struct attribute_group smc_lo_attr_group = {
+	.attrs  = smc_lo_attrs,
+};
+
+static const struct attribute_group *smc_lo_attr_groups[] = {
+	&smc_lo_attr_group,
+	NULL,
+};
+
 static void smc_lo_generate_id(struct smc_lo_dev *ldev)
 {
 	struct smcd_gid *lgid = &ldev->local_gid;
@@ -277,6 +329,7 @@ static int smcd_lo_register_dev(struct smc_lo_dev *ldev)
 	mutex_lock(&smcd_dev_list.mutex);
 	list_add(&smcd->list, &smcd_dev_list.list);
 	mutex_unlock(&smcd_dev_list.mutex);
+	ldev->active = 1;
 	pr_warn_ratelimited("smc: adding smcd device %s\n",
 			    smc_lo_dev_name);
 	return 0;
@@ -288,6 +341,7 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
 
 	pr_warn_ratelimited("smc: removing smcd device %s\n",
 			    smc_lo_dev_name);
+	ldev->active = 0;
 	smcd->going_away = 1;
 	smc_smcd_terminate_all(smcd);
 	mutex_lock(&smcd_dev_list.mutex);
@@ -335,6 +389,7 @@ static int smc_lo_dev_probe(void)
 
 	ldev->dev.parent = NULL;
 	ldev->dev.class = smc_class;
+	ldev->dev.groups = smc_lo_attr_groups;
 	ldev->dev.release = smc_lo_dev_release;
 	device_initialize(&ldev->dev);
 	dev_set_name(&ldev->dev, smc_lo_dev_name);
diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
index 3d5d2f5..0cc2f83 100644
--- a/net/smc/smc_loopback.h
+++ b/net/smc/smc_loopback.h
@@ -35,6 +35,7 @@ struct smc_lo_dmb_node {
 struct smc_lo_dev {
 	struct smcd_dev *smcd;
 	struct device dev;
+	u8 active;
 	u16 chid;
 	struct smcd_gid local_gid;
 	rwlock_t dmb_ht_lock;
-- 
1.8.3.1


