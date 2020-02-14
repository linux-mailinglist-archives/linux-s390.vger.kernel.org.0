Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E262015D79A
	for <lists+linux-s390@lfdr.de>; Fri, 14 Feb 2020 13:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgBNMqE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Feb 2020 07:46:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37605 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNMqE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Feb 2020 07:46:04 -0500
Received: by mail-pf1-f195.google.com with SMTP id p14so4863868pfn.4
        for <linux-s390@vger.kernel.org>; Fri, 14 Feb 2020 04:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=n4TRMpAO/IgNYedyvjYFfgAIiu7xaIUSxc2HmKf4i4w=;
        b=s+oF3KGzQgjtg4l8JiR2IWl+86h1G0cL/0oGf2ASMBkZc4HPMEGCMoj1/lkQO5Vptv
         5ydWY10yDW5Z2A3T4iug4MBE5My22agf1vwvWCz+OfDI/lEqUr+qJ5Jzl3QPTexpW2LR
         JCZPcpeND9n58PYW0G9vHTKCCXpoOM5GUu+gpI+3VnNagTxu9mluTJwvw03o9xoOB5S3
         oSKiV/wZkYYebM/lJmyar9hoLFwAbxUhsH8feIW3oSrWXctM37cKkyXZAz260W41rOmX
         A57CDAGO1Y9+YaFvqqnkdJyZjmbqEZgwmgYVRDb3fYP2aryJHyF2gyhwEe/EBwx4rab2
         UYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n4TRMpAO/IgNYedyvjYFfgAIiu7xaIUSxc2HmKf4i4w=;
        b=npR5ENZhzdR/CEbmM3UZbz8VE5fy6/YdfIp+rw6W7zkpLGhIe4nn2Vmr0Qse3BXWFI
         vYGfSg54QUruRo5EpiuCyhgZ7493QbGxQhwed0uUWXqUc6yB0uk1eL6o4FKAkk8GUdP1
         ka589SSHFKvFxRbrt2HbAWu0P8GsKCd20eOlV9UWBKIB2O6RsSuG+9ieZ8kUiEM9PeQB
         wI82fkVg8DH0VM2be+07mD9eBVSHRr23ibDqMkly3pASA4RQyPmRcvHxvce2LtDhTEi9
         DjF7OVReZjSxVk3sOLitgD6ex5pi93iiBguGFD5qCHS9oSt7m3kNHOEObhhTJ7dbZx2Y
         kw/w==
X-Gm-Message-State: APjAAAWvzNh2aXn1PZ/KKn7ckSZckSKYy1pd660VFZ1hrfdM3hVHAp51
        A5cndwVLBtCnamyk0WIKYTSyXhrK
X-Google-Smtp-Source: APXvYqy9PGeMeXWvGfyXI3d3kBfpi/niWP1Je8+bUCNCSGn7XQwIMqcrH9YKVaXLHgsx04INELDMOw==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr3301158pgh.96.1581684362207;
        Fri, 14 Feb 2020 04:46:02 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q17sm7036869pfg.123.2020.02.14.04.46.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 14 Feb 2020 04:46:01 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] s390/cio: use kobj_to_dev() API
Date:   Fri, 14 Feb 2020 20:45:57 +0800
Message-Id: <1581684357-24992-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use kobj_to_dev() API instead of container_of().

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/s390/cio/chp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index 51038ec..dfcbe54 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -135,7 +135,7 @@ static ssize_t chp_measurement_chars_read(struct file *filp,
 	struct channel_path *chp;
 	struct device *device;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	if (chp->cmg == -1)
 		return 0;
@@ -184,7 +184,7 @@ static ssize_t chp_measurement_read(struct file *filp, struct kobject *kobj,
 	struct device *device;
 	unsigned int size;
 
-	device = container_of(kobj, struct device, kobj);
+	device = kobj_to_dev(kobj);
 	chp = to_channelpath(device);
 	css = to_css(chp->dev.parent);
 
-- 
1.9.1

