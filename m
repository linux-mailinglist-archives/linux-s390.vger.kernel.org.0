Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CB12C2176
	for <lists+linux-s390@lfdr.de>; Tue, 24 Nov 2020 10:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKXJeP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Nov 2020 04:34:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49208 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728517AbgKXJeP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Nov 2020 04:34:15 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9W67m062730
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=wDSiY91Oq9pjLH/yK0+tXMWl8EQXQ5iJCvltDTLzW/s=;
 b=qNeilpFPktH+GM5/Nou8hk9U0hFn7tFNMVmibik7IawfaAHdf3nrLa9XBpTyTWEwsBk3
 PJxarbgptk0Fy2td0NlcLbnlYvRMbJnI+WGAshFYnUHxQrHKGBQR4OxourYqSipasLRb
 hr1mPFMaUBlkbyZTxjgzd2yGuPW52HZmZ6SIjHsuFgiWC1iWSDw5IFP5Gra6LJt0Bfb9
 pUl9BFlgQjC3trLGeizp440bR1t/tRPFBYNzSDQ/sF8vvYzZnA/Ji2Dh9Yn2RA+lMRr7
 vou7NKjQm2g3Z24/Aw4usfeAW2H89JzxsCBmfNk+Uw7wpoOx/g4jGPoL8T/21lHCJW+8 yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350meqbr9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:14 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AO9WOBM063994
        for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2020 04:34:14 -0500
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 350meqbr96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 04:34:13 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AO9Wg7U015795;
        Tue, 24 Nov 2020 09:34:11 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 34y6k4sh0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 09:34:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AO9Y8ed61407646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Nov 2020 09:34:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A3D8AE057;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65DE5AE055;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 24 Nov 2020 09:34:08 +0000 (GMT)
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
To:     cohuck@redhat.com, oberpar@linux.ibm.com
Cc:     linux-s390@vger.kernel.org, farman@linux.ibm.com,
        fiuczy@linux.ibm.com
Subject: [RFC 1/1] s390/cio: Remove uevent-suppress from css driver
Date:   Tue, 24 Nov 2020 10:34:07 +0100
Message-Id: <20201124093407.23189-2-vneethv@linux.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124093407.23189-1-vneethv@linux.ibm.com>
References: <20201124093407.23189-1-vneethv@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_03:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011240056
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

'commit fa1a8c23eb7d ("s390: cio: Delay uevents for subchannels")'
introduced the uevent suppression of subchannels. Even though there
are reasons for wanting to delay the uevent, it also introduces
problems. i.e On some platforms (qemu), where the udev-rule for the
subchannel needs to do driver_override to bind the vfio-ccw driver
instead of io_subchannel driver, but the suppressed uevent is
generated only when the device is found on the subchannel. By the
time it generates the uevent, it makes it difficult for the vfio-ccw
udev-rules to work.
This patch removes the uevent-suppress logic from the css driver.
The ADD uevent will be generated when there is a valid subchannel
and not after binding the valid device. The uevent generates while
device_add() during css_sch_device_register() function.

Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/chsc_sch.c     |  5 -----
 drivers/s390/cio/css.c          | 19 -------------------
 drivers/s390/cio/device.c       | 18 ------------------
 drivers/s390/cio/eadm_sch.c     |  5 -----
 drivers/s390/cio/vfio_ccw_drv.c |  5 -----
 5 files changed, 52 deletions(-)

diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 8f080d3fd380..b4057d781fb1 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -91,11 +91,6 @@ static int chsc_subchannel_probe(struct subchannel *sch)
 			 sch->schid.ssid, sch->schid.sch_no, ret);
 		dev_set_drvdata(&sch->dev, NULL);
 		kfree(private);
-	} else {
-		if (dev_get_uevent_suppress(&sch->dev)) {
-			dev_set_uevent_suppress(&sch->dev, 0);
-			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-		}
 	}
 	return ret;
 }
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index cca1a7c4bb33..6ebc0f7152e9 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -449,16 +449,6 @@ int css_register_subchannel(struct subchannel *sch)
 	if (sch->st == SUBCHANNEL_TYPE_IO)
 		sch->dev.type = &io_subchannel_type;
 
-	/*
-	 * We don't want to generate uevents for I/O subchannels that don't
-	 * have a working ccw device behind them since they will be
-	 * unregistered before they can be used anyway, so we delay the add
-	 * uevent until after device recognition was successful.
-	 * Note that we suppress the uevent for all subchannel types;
-	 * the subchannel driver can decide itself when it wants to inform
-	 * userspace of its existence.
-	 */
-	dev_set_uevent_suppress(&sch->dev, 1);
 	css_update_ssd_info(sch);
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
@@ -467,15 +457,6 @@ int css_register_subchannel(struct subchannel *sch)
 			      sch->schid.ssid, sch->schid.sch_no, ret);
 		return ret;
 	}
-	if (!sch->driver) {
-		/*
-		 * No driver matched. Generate the uevent now so that
-		 * a fitting driver module may be loaded based on the
-		 * modalias.
-		 */
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 	return ret;
 }
 
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index aab13c78db9f..363c9bbc4a24 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -845,14 +845,6 @@ static void io_subchannel_register(struct ccw_device *cdev)
 		adjust_init_count = 0;
 		goto out;
 	}
-	/*
-	 * Now we know this subchannel will stay, we can throw
-	 * our delayed uevent.
-	 */
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 	/* make it known to the system */
 	ret = ccw_device_add(cdev);
 	if (ret) {
@@ -1055,16 +1047,6 @@ static int io_subchannel_probe(struct subchannel *sch)
 				      "attributes for subchannel "
 				      "0.%x.%04x (rc=%d)\n",
 				      sch->schid.ssid, sch->schid.sch_no, rc);
-		/*
-		 * The console subchannel already has an associated ccw_device.
-		 * Throw the delayed uevent for the subchannel, register
-		 * the ccw_device and exit.
-		 */
-		if (dev_get_uevent_suppress(&sch->dev)) {
-			/* should always be the case for the console */
-			dev_set_uevent_suppress(&sch->dev, 0);
-			kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-		}
 		cdev = sch_get_cdev(sch);
 		rc = ccw_device_add(cdev);
 		if (rc) {
diff --git a/drivers/s390/cio/eadm_sch.c b/drivers/s390/cio/eadm_sch.c
index 53468ae64b99..f8b43583b487 100644
--- a/drivers/s390/cio/eadm_sch.c
+++ b/drivers/s390/cio/eadm_sch.c
@@ -243,11 +243,6 @@ static int eadm_subchannel_probe(struct subchannel *sch)
 	spin_lock_irq(&list_lock);
 	list_add(&private->head, &eadm_list);
 	spin_unlock_irq(&list_lock);
-
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
 out:
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 8c625b530035..7ccc5035c8fd 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -206,11 +206,6 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	if (ret)
 		goto out_disable;
 
-	if (dev_get_uevent_suppress(&sch->dev)) {
-		dev_set_uevent_suppress(&sch->dev, 0);
-		kobject_uevent(&sch->dev.kobj, KOBJ_ADD);
-	}
-
 	VFIO_CCW_MSG_EVENT(4, "bound to subchannel %x.%x.%04x\n",
 			   sch->schid.cssid, sch->schid.ssid,
 			   sch->schid.sch_no);
-- 
2.17.1

