Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A2291EC0
	for <lists+linux-s390@lfdr.de>; Sun, 18 Oct 2020 21:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgJRTUD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 18 Oct 2020 15:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgJRTUC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 18 Oct 2020 15:20:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99444222E7;
        Sun, 18 Oct 2020 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603048801;
        bh=i65f6KhJa6DIrbA9TgWtsr7ZoI6Nwy84jjKs4ka1+Sw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K85dAvlRsUeBwYxh3ac8HmNflnGAIbvMGhvzlWQdaf6fiDq9fXqmsdv5SvRCPF6ZA
         XbXENyFrYSTJ1fCUZEfpl1NmfNLUjVx+ZvQFeIQYPKBzuJintACLA46IZHlB1HSEyA
         RE23Hir3/4UHnYXmH3nhSjODfrh8h8GajsZYkSEM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 094/111] s390/qeth: strictly order bridge address events
Date:   Sun, 18 Oct 2020 15:17:50 -0400
Message-Id: <20201018191807.4052726-94-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018191807.4052726-1-sashal@kernel.org>
References: <20201018191807.4052726-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 9d6a569a4cbab5a8b4c959d4e312daeecb7c9f09 ]

The current code for bridge address events has two shortcomings in its
control sequence:

1. after disabling address events via PNSO, we don't flush the remaining
   events from the event_wq. So if the feature is re-enabled fast
   enough, stale events could leak over.
2. PNSO and the events' arrival via the READ ccw device are unordered.
   So even if we flushed the workqueue, it's difficult to say whether
   the READ device might produce more events onto the workqueue
   afterwards.

Fix this by
1. explicitly fencing off the events when we no longer care, in the
   READ device's event handler. This ensures that once we flush the
   workqueue, it doesn't get additional address events.
2. Flush the workqueue after disabling the events & fencing them off.
   As the code that triggers the flush will typically hold the sbp_lock,
   we need to rework the worker code to avoid a deadlock here in case
   of a 'notifications-stopped' event. In case of lock contention,
   requeue such an event with a delay. We'll eventually aquire the lock,
   or spot that the feature has been disabled and the event can thus be
   discarded.

This leaves the theoretical race that a stale event could arrive
_after_ we re-enabled ourselves to receive events again. Such an event
would be impossible to distinguish from a 'good' event, nothing we can
do about it.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core.h    |  6 ++++
 drivers/s390/net/qeth_l2_main.c | 53 ++++++++++++++++++++++++++++-----
 drivers/s390/net/qeth_l2_sys.c  |  1 +
 3 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index ecfd6d152e862..6b5cf9ba03e5b 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -680,6 +680,11 @@ struct qeth_card_blkt {
 	int inter_packet_jumbo;
 };
 
+enum qeth_pnso_mode {
+	QETH_PNSO_NONE,
+	QETH_PNSO_BRIDGEPORT,
+};
+
 #define QETH_BROADCAST_WITH_ECHO    0x01
 #define QETH_BROADCAST_WITHOUT_ECHO 0x02
 struct qeth_card_info {
@@ -696,6 +701,7 @@ struct qeth_card_info {
 	/* no bitfield, we take a pointer on these two: */
 	u8 has_lp2lp_cso_v6;
 	u8 has_lp2lp_cso_v4;
+	enum qeth_pnso_mode pnso_mode;
 	enum qeth_card_types type;
 	enum qeth_link_types link_type;
 	int broadcast_capable;
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 6384f7adba660..9866d01b40fe7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -273,6 +273,17 @@ static int qeth_l2_vlan_rx_kill_vid(struct net_device *dev,
 	return qeth_l2_send_setdelvlan(card, vid, IPA_CMD_DELVLAN);
 }
 
+static void qeth_l2_set_pnso_mode(struct qeth_card *card,
+				  enum qeth_pnso_mode mode)
+{
+	spin_lock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+	WRITE_ONCE(card->info.pnso_mode, mode);
+	spin_unlock_irq(get_ccwdev_lock(CARD_RDEV(card)));
+
+	if (mode == QETH_PNSO_NONE)
+		drain_workqueue(card->event_wq);
+}
+
 static void qeth_l2_stop_card(struct qeth_card *card)
 {
 	QETH_CARD_TEXT(card, 2, "stopcard");
@@ -290,7 +301,7 @@ static void qeth_l2_stop_card(struct qeth_card *card)
 	qeth_qdio_clear_card(card, 0);
 	qeth_drain_output_queues(card);
 	qeth_clear_working_pool_list(card);
-	flush_workqueue(card->event_wq);
+	qeth_l2_set_pnso_mode(card, QETH_PNSO_NONE);
 	qeth_flush_local_addrs(card);
 	card->info.promisc_mode = 0;
 }
@@ -1163,19 +1174,34 @@ static void qeth_bridge_state_change(struct qeth_card *card,
 }
 
 struct qeth_addr_change_data {
-	struct work_struct worker;
+	struct delayed_work dwork;
 	struct qeth_card *card;
 	struct qeth_ipacmd_addr_change ac_event;
 };
 
 static void qeth_addr_change_event_worker(struct work_struct *work)
 {
-	struct qeth_addr_change_data *data =
-		container_of(work, struct qeth_addr_change_data, worker);
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct qeth_addr_change_data *data;
+	struct qeth_card *card;
 	int i;
 
+	data = container_of(dwork, struct qeth_addr_change_data, dwork);
+	card = data->card;
+
 	QETH_CARD_TEXT(data->card, 4, "adrchgew");
+
+	if (READ_ONCE(card->info.pnso_mode) == QETH_PNSO_NONE)
+		goto free;
+
 	if (data->ac_event.lost_event_mask) {
+		/* Potential re-config in progress, try again later: */
+		if (!mutex_trylock(&card->sbp_lock)) {
+			queue_delayed_work(card->event_wq, dwork,
+					   msecs_to_jiffies(100));
+			return;
+		}
+
 		dev_info(&data->card->gdev->dev,
 			 "Address change notification stopped on %s (%s)\n",
 			 data->card->dev->name,
@@ -1184,8 +1210,9 @@ static void qeth_addr_change_event_worker(struct work_struct *work)
 			: (data->ac_event.lost_event_mask == 0x02)
 			? "Bridge port state change"
 			: "Unknown reason");
-		mutex_lock(&data->card->sbp_lock);
+
 		data->card->options.sbp.hostnotification = 0;
+		card->info.pnso_mode = QETH_PNSO_NONE;
 		mutex_unlock(&data->card->sbp_lock);
 		qeth_bridge_emit_host_event(data->card, anev_abort,
 					    0, NULL, NULL);
@@ -1199,6 +1226,8 @@ static void qeth_addr_change_event_worker(struct work_struct *work)
 						    &entry->token,
 						    &entry->addr_lnid);
 		}
+
+free:
 	kfree(data);
 }
 
@@ -1210,6 +1239,9 @@ static void qeth_addr_change_event(struct qeth_card *card,
 	struct qeth_addr_change_data *data;
 	int extrasize;
 
+	if (card->info.pnso_mode == QETH_PNSO_NONE)
+		return;
+
 	QETH_CARD_TEXT(card, 4, "adrchgev");
 	if (cmd->hdr.return_code != 0x0000) {
 		if (cmd->hdr.return_code == 0x0010) {
@@ -1229,11 +1261,11 @@ static void qeth_addr_change_event(struct qeth_card *card,
 		QETH_CARD_TEXT(card, 2, "ACNalloc");
 		return;
 	}
-	INIT_WORK(&data->worker, qeth_addr_change_event_worker);
+	INIT_DELAYED_WORK(&data->dwork, qeth_addr_change_event_worker);
 	data->card = card;
 	memcpy(&data->ac_event, hostevs,
 			sizeof(struct qeth_ipacmd_addr_change) + extrasize);
-	queue_work(card->event_wq, &data->worker);
+	queue_delayed_work(card->event_wq, &data->dwork, 0);
 }
 
 /* SETBRIDGEPORT support; sending commands */
@@ -1554,9 +1586,14 @@ int qeth_bridgeport_an_set(struct qeth_card *card, int enable)
 
 	if (enable) {
 		qeth_bridge_emit_host_event(card, anev_reset, 0, NULL, NULL);
+		qeth_l2_set_pnso_mode(card, QETH_PNSO_BRIDGEPORT);
 		rc = qeth_l2_pnso(card, 1, qeth_bridgeport_an_set_cb, card);
-	} else
+		if (rc)
+			qeth_l2_set_pnso_mode(card, QETH_PNSO_NONE);
+	} else {
 		rc = qeth_l2_pnso(card, 0, NULL, NULL);
+		qeth_l2_set_pnso_mode(card, QETH_PNSO_NONE);
+	}
 	return rc;
 }
 
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 86bcae992f725..4695d25e54f24 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -157,6 +157,7 @@ static ssize_t qeth_bridgeport_hostnotification_store(struct device *dev,
 		rc = -EBUSY;
 	else if (qeth_card_hw_is_reachable(card)) {
 		rc = qeth_bridgeport_an_set(card, enable);
+		/* sbp_lock ensures ordering vs notifications-stopped events */
 		if (!rc)
 			card->options.sbp.hostnotification = enable;
 	} else
-- 
2.25.1

