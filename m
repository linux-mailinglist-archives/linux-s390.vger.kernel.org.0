Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4AE413F87B
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2020 20:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgAPTSu (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jan 2020 14:18:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731893AbgAPQy3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 11:54:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4E821D56;
        Thu, 16 Jan 2020 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193668;
        bh=PuZ70AYYOu/useq/c4s2JEvfWw9ZUjqsgdyexgbeSfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aB0oV3MLp1mJgpa5NmGkET3yBxvcaFUHfe1r2Q7XWxlSC2H5S4QFfqBvKtshsrhrD
         47ZkiEJ+jT+Lj++TcSTY33eXnhdcQnLVsBCOh+2Yxz9ZZrPxZ4Y6QNQIkRg516JPe/
         0Z9QDjBsSyMGUbkk6LRl615uchrZuUbtf4KX9CxA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 194/205] s390/qeth: fix dangling IO buffers after halt/clear
Date:   Thu, 16 Jan 2020 11:42:49 -0500
Message-Id: <20200116164300.6705-194-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit f9e50b02a99c3ebbaa30690e8d5be28a5c2624eb ]

The cio layer's intparm logic does not align itself well with how qeth
manages cmd IOs. When an active IO gets terminated via halt/clear, the
corresponding IRQ's intparm does not reflect the cmd buffer but rather
the intparm that was passed to ccw_device_halt() / ccw_device_clear().
This behaviour was recently clarified in
commit b91d9e67e50b ("s390/cio: fix intparm documentation").

As a result, qeth_irq() currently doesn't cancel a cmd that was
terminated via halt/clear. This primarily causes us to leak
card->read_cmd after the qeth device is removed, since our IO path still
holds a refcount for this cmd.

For qeth this means that we need to keep track of which IO is pending on
a device ('active_cmd'), and use this as the intparm when calling
halt/clear. Otherwise qeth_irq() can't match the subsequent IRQ to its
cmd buffer.
Since we now keep track of the _expected_ intparm, we can also detect
any mismatch; this would constitute a bug somewhere in the lower layers.
In this case cancel the active cmd - we effectively "lost" the IRQ and
should not expect any further notification for this IO.

Fixes: 405548959cc7 ("s390/qeth: add support for dynamically allocated cmds")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h      |  3 ++
 drivers/s390/net/qeth_core_main.c | 71 ++++++++++++++++++++++---------
 drivers/s390/net/qeth_core_mpc.h  | 14 ------
 drivers/s390/net/qeth_l2_main.c   | 12 +++---
 drivers/s390/net/qeth_l3_main.c   | 13 +++---
 5 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 65e31df37b1f..820f2c29376c 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -620,6 +620,7 @@ struct qeth_ipato {
 
 struct qeth_channel {
 	struct ccw_device *ccwdev;
+	struct qeth_cmd_buffer *active_cmd;
 	enum qeth_channel_states state;
 	atomic_t irq_pending;
 };
@@ -1024,6 +1025,8 @@ int qeth_do_run_thread(struct qeth_card *, unsigned long);
 void qeth_clear_thread_start_bit(struct qeth_card *, unsigned long);
 void qeth_clear_thread_running_bit(struct qeth_card *, unsigned long);
 int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok);
+int qeth_stop_channel(struct qeth_channel *channel);
+
 void qeth_print_status_message(struct qeth_card *);
 int qeth_init_qdio_queues(struct qeth_card *);
 int qeth_send_ipa_cmd(struct qeth_card *, struct qeth_cmd_buffer *,
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9df47421d69c..a43265c5343b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -515,7 +515,9 @@ static int __qeth_issue_next_read(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 6, "noirqpnd");
 	rc = ccw_device_start(channel->ccwdev, ccw, (addr_t) iob, 0, 0);
-	if (rc) {
+	if (!rc) {
+		channel->active_cmd = iob;
+	} else {
 		QETH_DBF_MESSAGE(2, "error %i on device %x when starting next read ccw!\n",
 				 rc, CARD_DEVID(card));
 		atomic_set(&channel->irq_pending, 0);
@@ -986,8 +988,21 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		QETH_CARD_TEXT(card, 5, "data");
 	}
 
-	if (qeth_intparm_is_iob(intparm))
-		iob = (struct qeth_cmd_buffer *) __va((addr_t)intparm);
+	if (intparm == 0) {
+		QETH_CARD_TEXT(card, 5, "irqunsol");
+	} else if ((addr_t)intparm != (addr_t)channel->active_cmd) {
+		QETH_CARD_TEXT(card, 5, "irqunexp");
+
+		dev_err(&cdev->dev,
+			"Received IRQ with intparm %lx, expected %px\n",
+			intparm, channel->active_cmd);
+		if (channel->active_cmd)
+			qeth_cancel_cmd(channel->active_cmd, -EIO);
+	} else {
+		iob = (struct qeth_cmd_buffer *) (addr_t)intparm;
+	}
+
+	channel->active_cmd = NULL;
 
 	rc = qeth_check_irb_error(card, cdev, irb);
 	if (rc) {
@@ -1007,15 +1022,10 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 	if (irb->scsw.cmd.fctl & (SCSW_FCTL_HALT_FUNC))
 		channel->state = CH_STATE_HALTED;
 
-	if (intparm == QETH_CLEAR_CHANNEL_PARM) {
-		QETH_CARD_TEXT(card, 6, "clrchpar");
-		/* we don't have to handle this further */
-		intparm = 0;
-	}
-	if (intparm == QETH_HALT_CHANNEL_PARM) {
-		QETH_CARD_TEXT(card, 6, "hltchpar");
-		/* we don't have to handle this further */
-		intparm = 0;
+	if (iob && (irb->scsw.cmd.fctl & (SCSW_FCTL_CLEAR_FUNC |
+					  SCSW_FCTL_HALT_FUNC))) {
+		qeth_cancel_cmd(iob, -ECANCELED);
+		iob = NULL;
 	}
 
 	cstat = irb->scsw.cmd.cstat;
@@ -1408,7 +1418,7 @@ static int qeth_clear_channel(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 3, "clearch");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
-	rc = ccw_device_clear(channel->ccwdev, QETH_CLEAR_CHANNEL_PARM);
+	rc = ccw_device_clear(channel->ccwdev, (addr_t)channel->active_cmd);
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc)
@@ -1430,7 +1440,7 @@ static int qeth_halt_channel(struct qeth_card *card,
 
 	QETH_CARD_TEXT(card, 3, "haltch");
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
-	rc = ccw_device_halt(channel->ccwdev, QETH_HALT_CHANNEL_PARM);
+	rc = ccw_device_halt(channel->ccwdev, (addr_t)channel->active_cmd);
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 
 	if (rc)
@@ -1444,6 +1454,25 @@ static int qeth_halt_channel(struct qeth_card *card,
 	return 0;
 }
 
+int qeth_stop_channel(struct qeth_channel *channel)
+{
+	struct ccw_device *cdev = channel->ccwdev;
+	int rc;
+
+	rc = ccw_device_set_offline(cdev);
+
+	spin_lock_irq(get_ccwdev_lock(cdev));
+	if (channel->active_cmd) {
+		dev_err(&cdev->dev, "Stopped channel while cmd %px was still active\n",
+			channel->active_cmd);
+		channel->active_cmd = NULL;
+	}
+	spin_unlock_irq(get_ccwdev_lock(cdev));
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qeth_stop_channel);
+
 static int qeth_halt_channels(struct qeth_card *card)
 {
 	int rc1 = 0, rc2 = 0, rc3 = 0;
@@ -1747,6 +1776,8 @@ static int qeth_send_control_data(struct qeth_card *card,
 	spin_lock_irq(get_ccwdev_lock(channel->ccwdev));
 	rc = ccw_device_start_timeout(channel->ccwdev, __ccw_from_cmd(iob),
 				      (addr_t) iob, 0, 0, timeout);
+	if (!rc)
+		channel->active_cmd = iob;
 	spin_unlock_irq(get_ccwdev_lock(channel->ccwdev));
 	if (rc) {
 		QETH_DBF_MESSAGE(2, "qeth_send_control_data on device %x: ccw_device_start rc = %i\n",
@@ -4634,12 +4665,12 @@ EXPORT_SYMBOL_GPL(qeth_vm_request_mac);
 
 static void qeth_determine_capabilities(struct qeth_card *card)
 {
+	struct qeth_channel *channel = &card->data;
+	struct ccw_device *ddev = channel->ccwdev;
 	int rc;
-	struct ccw_device *ddev;
 	int ddev_offline = 0;
 
 	QETH_CARD_TEXT(card, 2, "detcapab");
-	ddev = CARD_DDEV(card);
 	if (!ddev->online) {
 		ddev_offline = 1;
 		rc = ccw_device_set_online(ddev);
@@ -4678,7 +4709,7 @@ static void qeth_determine_capabilities(struct qeth_card *card)
 
 out_offline:
 	if (ddev_offline == 1)
-		ccw_device_set_offline(ddev);
+		qeth_stop_channel(channel);
 out:
 	return;
 }
@@ -4879,9 +4910,9 @@ int qeth_core_hardsetup_card(struct qeth_card *card, bool *carrier_ok)
 		QETH_DBF_MESSAGE(2, "Retrying to do IDX activates on device %x.\n",
 				 CARD_DEVID(card));
 	rc = qeth_qdio_clear_card(card, !IS_IQD(card));
-	ccw_device_set_offline(CARD_DDEV(card));
-	ccw_device_set_offline(CARD_WDEV(card));
-	ccw_device_set_offline(CARD_RDEV(card));
+	qeth_stop_channel(&card->data);
+	qeth_stop_channel(&card->write);
+	qeth_stop_channel(&card->read);
 	qdio_free(CARD_DDEV(card));
 	rc = ccw_device_set_online(CARD_RDEV(card));
 	if (rc)
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index b7c17b5c823b..65038539b324 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -28,20 +28,6 @@ extern unsigned char IPA_PDU_HEADER[];
 #define QETH_TIMEOUT		(10 * HZ)
 #define QETH_IPA_TIMEOUT	(45 * HZ)
 
-#define QETH_CLEAR_CHANNEL_PARM	-10
-#define QETH_HALT_CHANNEL_PARM	-11
-
-static inline bool qeth_intparm_is_iob(unsigned long intparm)
-{
-	switch (intparm) {
-	case QETH_CLEAR_CHANNEL_PARM:
-	case QETH_HALT_CHANNEL_PARM:
-	case 0:
-		return false;
-	}
-	return true;
-}
-
 /*****************************************************************************/
 /* IP Assist related definitions                                             */
 /*****************************************************************************/
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8b7d911dccd8..b4348d4009d7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -877,9 +877,9 @@ static int qeth_l2_set_online(struct ccwgroup_device *gdev)
 
 out_remove:
 	qeth_l2_stop_card(card);
-	ccw_device_set_offline(CARD_DDEV(card));
-	ccw_device_set_offline(CARD_WDEV(card));
-	ccw_device_set_offline(CARD_RDEV(card));
+	qeth_stop_channel(&card->data);
+	qeth_stop_channel(&card->write);
+	qeth_stop_channel(&card->read);
 	qdio_free(CARD_DDEV(card));
 
 	mutex_unlock(&card->conf_mutex);
@@ -910,9 +910,9 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	rtnl_unlock();
 
 	qeth_l2_stop_card(card);
-	rc  = ccw_device_set_offline(CARD_DDEV(card));
-	rc2 = ccw_device_set_offline(CARD_WDEV(card));
-	rc3 = ccw_device_set_offline(CARD_RDEV(card));
+	rc  = qeth_stop_channel(&card->data);
+	rc2 = qeth_stop_channel(&card->write);
+	rc3 = qeth_stop_channel(&card->read);
 	if (!rc)
 		rc = (rc2) ? rc2 : rc3;
 	if (rc)
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 32385327539b..8d452311d223 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2383,9 +2383,9 @@ static int qeth_l3_set_online(struct ccwgroup_device *gdev)
 	return 0;
 out_remove:
 	qeth_l3_stop_card(card);
-	ccw_device_set_offline(CARD_DDEV(card));
-	ccw_device_set_offline(CARD_WDEV(card));
-	ccw_device_set_offline(CARD_RDEV(card));
+	qeth_stop_channel(&card->data);
+	qeth_stop_channel(&card->write);
+	qeth_stop_channel(&card->read);
 	qdio_free(CARD_DDEV(card));
 
 	mutex_unlock(&card->conf_mutex);
@@ -2421,9 +2421,10 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 		call_netdevice_notifiers(NETDEV_REBOOT, card->dev);
 		rtnl_unlock();
 	}
-	rc  = ccw_device_set_offline(CARD_DDEV(card));
-	rc2 = ccw_device_set_offline(CARD_WDEV(card));
-	rc3 = ccw_device_set_offline(CARD_RDEV(card));
+
+	rc  = qeth_stop_channel(&card->data);
+	rc2 = qeth_stop_channel(&card->write);
+	rc3 = qeth_stop_channel(&card->read);
 	if (!rc)
 		rc = (rc2) ? rc2 : rc3;
 	if (rc)
-- 
2.20.1

