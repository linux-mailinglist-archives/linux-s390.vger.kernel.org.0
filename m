Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA82B40D7
	for <lists+linux-s390@lfdr.de>; Mon, 16 Nov 2020 11:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgKPKSb (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbgKPKSa (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:30 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DA7F22314;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=d8G37msgbohmjGjsmEGoarKHiKdZQ4KdwkElQNS8Um8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNdH4Iwssb+JCmswHBNFUpIF43ye8NHrZScJv0NAd1tPAWTo8QThuSzce9h6nUskq
         rFFlUZiyZ526zZ0VEXOWtV0nrUiu4TQEs9MlGVV5pVqOZxm60I4r4UdRaP1WKPeNsU
         3L6C6C8vJhAvmNtgq21q6IqNxaLjDanXvW5RWsMU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebab-00FwDw-Us; Mon, 16 Nov 2020 11:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 04/27] s390: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:00 +0100
Message-Id: <4a9df42dfb68aed6b4a4882f6dccabf00ce932cd.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

fix one typo:
	ccw driver -> ccw_driver

and one function rename.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 arch/s390/include/asm/ccwdev.h | 2 +-
 arch/s390/include/asm/cio.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/ccwdev.h b/arch/s390/include/asm/ccwdev.h
index bf605e1fcf6a..0495ac635ed5 100644
--- a/arch/s390/include/asm/ccwdev.h
+++ b/arch/s390/include/asm/ccwdev.h
@@ -100,41 +100,41 @@ struct ccw_device {
  */
 #define PE_NONE				0x0
 #define PE_PATH_GONE			0x1 /* A path is no longer available. */
 #define PE_PATH_AVAILABLE		0x2 /* A path has become available and
 					       was successfully verified. */
 #define PE_PATHGROUP_ESTABLISHED	0x4 /* A pathgroup was reset and had
 					       to be established again. */
 #define PE_PATH_FCES_EVENT		0x8 /* The FCES Status of a path has
 					     * changed. */
 
 /*
  * Possible CIO actions triggered by the unit check handler.
  */
 enum uc_todo {
 	UC_TODO_RETRY,
 	UC_TODO_RETRY_ON_NEW_PATH,
 	UC_TODO_STOP
 };
 
 /**
- * struct ccw driver - device driver for channel attached devices
+ * struct ccw_driver - device driver for channel attached devices
  * @ids: ids supported by this driver
  * @probe: function called on probe
  * @remove: function called on remove
  * @set_online: called when setting device online
  * @set_offline: called when setting device offline
  * @notify: notify driver of device state changes
  * @path_event: notify driver of channel path events
  * @shutdown: called at device shutdown
  * @prepare: prepare for pm state transition
  * @complete: undo work done in @prepare
  * @freeze: callback for freezing during hibernation snapshotting
  * @thaw: undo work done in @freeze
  * @restore: callback for restoring after hibernation
  * @uc_handler: callback for unit check handler
  * @driver: embedded device driver structure
  * @int_class: interruption class to use for accounting interrupts
  */
 struct ccw_driver {
 	struct ccw_device_id *ids;
 	int (*probe) (struct ccw_device *);
diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index e36cb67d2441..ac02df906cae 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -312,41 +312,41 @@ struct node_descriptor {
 /* Device did not respond in time. */
 #define CIO_BOXED      0x0010
 
 /**
  * struct ccw_dev_id - unique identifier for ccw devices
  * @ssid: subchannel set id
  * @devno: device number
  *
  * This structure is not directly based on any hardware structure. The
  * hardware identifies a device by its device number and its subchannel,
  * which is in turn identified by its id. In order to get a unique identifier
  * for ccw devices across subchannel sets, @struct ccw_dev_id has been
  * introduced.
  */
 struct ccw_dev_id {
 	u8 ssid;
 	u16 devno;
 };
 
 /**
- * ccw_device_id_is_equal() - compare two ccw_dev_ids
+ * ccw_dev_id_is_equal() - compare two ccw_dev_ids
  * @dev_id1: a ccw_dev_id
  * @dev_id2: another ccw_dev_id
  * Returns:
  *  %1 if the two structures are equal field-by-field,
  *  %0 if not.
  * Context:
  *  any
  */
 static inline int ccw_dev_id_is_equal(struct ccw_dev_id *dev_id1,
 				      struct ccw_dev_id *dev_id2)
 {
 	if ((dev_id1->ssid == dev_id2->ssid) &&
 	    (dev_id1->devno == dev_id2->devno))
 		return 1;
 	return 0;
 }
 
 /**
  * pathmask_to_pos() - find the position of the left-most bit in a pathmask
  * @mask: pathmask with at least one bit set
-- 
2.28.0

