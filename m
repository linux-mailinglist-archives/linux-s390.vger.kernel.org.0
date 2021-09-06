Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE54F401449
	for <lists+linux-s390@lfdr.de>; Mon,  6 Sep 2021 03:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241400AbhIFBcs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 5 Sep 2021 21:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:47504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351658AbhIFBaw (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 5 Sep 2021 21:30:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A26D8611F2;
        Mon,  6 Sep 2021 01:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891445;
        bh=xGwExUppbd3H53PxpNT/Y7MZXZdRKAOroOEcEFe8Yis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L4P4f10sXffG85AO2F23jNUwm9r8hUx/dqczhV9KUKe4z+Gkmon1LgW/xqdP3Zzf7
         on9LJER9h8piqQAK3vZUcdOp8YLnbi3BHmTIfAhv6eXT/pe2Zopx3gBQFCpREjAWxd
         InCXPuKLziRF8fVaJNCE8+H/purqcmce7csi9O3oXGoKih5q+qEwQdmmv4+bkqzt5+
         bL590FxlFNbGIcqHaZOHDWb4kW7mJTkWHpxdTDgDC+u4mgIjdnyy5RujXTpQPSpggx
         BlkTEmB4pV3FHw0ix/7sKiQJMiM3UAGslQGAnVQogFqyZatDiVov/Ws2t5Qc6oWTOB
         GNlBCAx0scEAw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/17] s390/cio: add dev_busid sysfs entry for each subchannel
Date:   Sun,  5 Sep 2021 21:23:45 -0400
Message-Id: <20210906012352.930954-10-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012352.930954-1-sashal@kernel.org>
References: <20210906012352.930954-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Vineeth Vijayan <vneethv@linux.ibm.com>

[ Upstream commit d3683c055212bf910d4e318f7944910ce10dbee6 ]

Introduce dev_busid, which exports the device-id associated with the
io-subchannel (and message-subchannel). The dev_busid indicates that of
the device which may be physically installed on the corrosponding
subchannel. The dev_busid value "none" indicates that the subchannel
is not valid, there is no I/O device currently associated with the
subchannel.

The dev_busid information would be helpful to write device-specific
udev-rules associated with the subchannel. The dev_busid interface would
be available even when the sch is not bound to any driver or if there is
no operational device connected on it. Hence this attribute can be used to
write udev-rules which are specific to the device associated with the
subchannel.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/css.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index e2026d54dd37..435e804b6b8b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -330,9 +330,26 @@ static ssize_t pimpampom_show(struct device *dev,
 }
 static DEVICE_ATTR(pimpampom, 0444, pimpampom_show, NULL);
 
+static ssize_t dev_busid_show(struct device *dev,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct subchannel *sch = to_subchannel(dev);
+	struct pmcw *pmcw = &sch->schib.pmcw;
+
+	if ((pmcw->st == SUBCHANNEL_TYPE_IO ||
+	     pmcw->st == SUBCHANNEL_TYPE_MSG) && pmcw->dnv)
+		return sysfs_emit(buf, "0.%x.%04x\n", sch->schid.ssid,
+				  pmcw->dev);
+	else
+		return sysfs_emit(buf, "none\n");
+}
+static DEVICE_ATTR_RO(dev_busid);
+
 static struct attribute *io_subchannel_type_attrs[] = {
 	&dev_attr_chpids.attr,
 	&dev_attr_pimpampom.attr,
+	&dev_attr_dev_busid.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(io_subchannel_type);
-- 
2.30.2

