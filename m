Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA4739A79C
	for <lists+linux-s390@lfdr.de>; Thu,  3 Jun 2021 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFCRMB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Jun 2021 13:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232402AbhFCRLO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 3 Jun 2021 13:11:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B5D4561402;
        Thu,  3 Jun 2021 17:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622740168;
        bh=3xtDotbavrRCbvGAjb8l1mvLytPd4v7OS/uUZsg0sAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gG1N/sck136zsAdwAIFcRSlcEcOgY7J/YXKnHbRUsv+O1heH6Pk0evMla0cVALaFe
         QShDUqL8frC7Un3c3u7cQDvXVR0L0vntaEfJemDTtZN6Xab+voz1mImYerPvAowiV9
         lFjlhGt1kHddb9Ht6bSiLueXEM/UZPwTDFDUkj5Im9+d2R4hv6nwljBTlXajRY/+GY
         5bAViO9U4JpvVJyo/SJu3rbml8blrFyTxPHh0JGr9iez5gfUsZoCec3gAdpHmjI44L
         s4DrwmjuU61Z3ywQId5mFiH/2KSiQ7FaGQCLpMD7k/O6N/8SJ44BisV9VtOnwkORxi
         vSd4CSDkc7jNg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 07/31] vfio-ccw: Serialize FSM IDLE state with I/O completion
Date:   Thu,  3 Jun 2021 13:08:55 -0400
Message-Id: <20210603170919.3169112-7-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170919.3169112-1-sashal@kernel.org>
References: <20210603170919.3169112-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 2af7a834a435460d546f0cf0a8b8e4d259f1d910 ]

Today, the stacked call to vfio_ccw_sch_io_todo() does three things:

  1) Update a solicited IRB with CP information, and release the CP
     if the interrupt was the end of a START operation.
  2) Copy the IRB data into the io_region, under the protection of
     the io_mutex
  3) Reset the vfio-ccw FSM state to IDLE to acknowledge that
     vfio-ccw can accept more work.

The trouble is that step 3 is (A) invoked for both solicited and
unsolicited interrupts, and (B) sitting after the mutex for step 2.
This second piece becomes a problem if it processes an interrupt
for a CLEAR SUBCHANNEL while another thread initiates a START,
thus allowing the CP and FSM states to get out of sync. That is:

    CPU 1                           CPU 2
    fsm_do_clear()
    fsm_irq()
                                    fsm_io_request()
    vfio_ccw_sch_io_todo()
                                    fsm_io_helper()

Since the FSM state and CP should be kept in sync, let's make a
note when the CP is released, and rely on that as an indication
that the FSM should also be reset at the end of this routine and
open up the device for more work.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20210511195631.3995081-4-farman@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_drv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 339a6bc0339b..fd590d1cffc1 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -83,6 +83,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	struct vfio_ccw_private *private;
 	struct irb *irb;
 	bool is_final;
+	bool cp_is_finished = false;
 
 	private = container_of(work, struct vfio_ccw_private, io_work);
 	irb = &private->irb;
@@ -91,14 +92,21 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
+		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
 			cp_free(&private->cp);
+			cp_is_finished = true;
+		}
 	}
 	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
 	mutex_unlock(&private->io_mutex);
 
-	if (private->mdev && is_final)
+	/*
+	 * Reset to IDLE only if processing of a channel program
+	 * has finished. Do not overwrite a possible processing
+	 * state if the final interrupt was for HSCH or CSCH.
+	 */
+	if (private->mdev && cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
 
 	if (private->io_trigger)
-- 
2.30.2

