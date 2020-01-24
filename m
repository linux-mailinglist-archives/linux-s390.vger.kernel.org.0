Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA23A148AB7
	for <lists+linux-s390@lfdr.de>; Fri, 24 Jan 2020 15:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387471AbgAXOzF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 24 Jan 2020 09:55:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729631AbgAXOzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 24 Jan 2020 09:55:04 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00OEla0Z178078
        for <linux-s390@vger.kernel.org>; Fri, 24 Jan 2020 09:55:03 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xkxj2ncat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 24 Jan 2020 09:55:03 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Fri, 24 Jan 2020 14:55:01 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Jan 2020 14:54:59 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00OEswqC53542930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 14:54:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6D30AE045;
        Fri, 24 Jan 2020 14:54:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CE78DAE04D;
        Fri, 24 Jan 2020 14:54:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jan 2020 14:54:57 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
        id 695D1E03C2; Fri, 24 Jan 2020 15:54:57 +0100 (CET)
From:   Eric Farman <farman@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     "Jason J . Herne" <jjherne@linux.ibm.com>,
        Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 1/1] vfio-ccw: Don't free channel programs for unrelated interrupts
Date:   Fri, 24 Jan 2020 15:54:55 +0100
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200124145455.51181-1-farman@linux.ibm.com>
References: <20200124145455.51181-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20012414-0020-0000-0000-000003A3A48A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012414-0021-0000-0000-000021FB4289
Message-Id: <20200124145455.51181-2-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_04:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=2
 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0 mlxlogscore=888
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001240124
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

With the addition of asynchronous channel programs (HALT or CLEAR
SUBCHANNEL instructions), the hardware can receive interrupts that
are not related to any channel program currently active.  An attempt
is made to ensure that only associated resources are freed, but the
host can fail in unpleasant ways:

[ 1051.330289] Unable to handle kernel pointer dereference in virtual kernel address space
[ 1051.330360] Failing address: c880003d16572000 TEID: c880003d16572803
[ 1051.330365] Fault in home space mode while using kernel ASCE.
[ 1051.330372] AS:00000000fde9c007 R3:0000000000000024
...snip...
[ 1051.330539]  [<00000000fccbd33e>] __kmalloc+0xd6/0x3d8
[ 1051.330543] ([<00000000fccbd514>] __kmalloc+0x2ac/0x3d8)
[ 1051.330550]  [<000003ff801452b4>] cp_prefetch+0xc4/0x3b8 [vfio_ccw]
[ 1051.330554]  [<000003ff801471e4>] fsm_io_request+0x2d4/0x7b8 [vfio_ccw]
[ 1051.330559]  [<000003ff80145d9c>] vfio_ccw_mdev_write+0x17c/0x300 [vfio_ccw]
[ 1051.330564]  [<00000000fccf0d20>] vfs_write+0xb0/0x1b8
[ 1051.330568]  [<00000000fccf1236>] ksys_pwrite64+0x7e/0xb8
[ 1051.330574]  [<00000000fd4524c0>] system_call+0xdc/0x2d8

The problem is corruption of the dma-kmalloc-8 slab [1], if an interrupt
occurs for a CLEAR or HALT that is not obviously associated with the
current channel program.  If the channel_program struct is freed AND
another interrupt for that I/O occurs, then this may occur:

583.612967 00          cp_prefetch  NEW SSCH
583.613180 03 vfio_ccw_sch_io_todo  orb.cpa=03012690 irb.cpa=03012698
                                    ccw=2704004203015600 *cda=1955d8fb8
                                    irb: fctl=4 actl=0 stctl=7
587.039292 04          cp_prefetch  NEW SSCH
587.039296 01 vfio_ccw_sch_io_todo  orb.cpa=7fe209f0 irb.cpa=03012698
                                    ccw=3424000c030a4068 *cda=1999e9cf0
                                    irb: fctl=2 actl=0 stctl=1
587.039505 01 vfio_ccw_sch_io_todo  orb.cpa=7fe209f0 irb.cpa=7fe209f8
                                    ccw=3424000c030a4068 *cda=0030a4070
                                    irb: fctl=4 actl=0 stctl=7

Note how the last vfio_ccw_sch_io_todo() call has a ccw.cda that is
right next to its supposed IDAW, compared to the previous one?  That
is the result of the previous one freeing the cp (and its IDAL), and
kfree writing the next available address at the beginning of the
newly released memory.  When the channel goes to store data, it
believes the IDAW is valid and overwrites that pointer and causes
kmalloc to fail some time later.

Since the vfio-ccw interrupt handler walks the list of ccwchain structs
to determine if the guest SCSW needs to be updated, it can be changed
to indicate whether the interrupt points within the channel_program.
If yes, then the channel_program is valid and its resources can be freed.
It not, then another interrupt is expected to do that later.

[1] It could be other dma-kmalloc-xxx slabs; this just happens to be the
one driven most frequently in my testing.

Fixes: f4c9939433bd ("vfio-ccw: Don't call cp_free if we are processing a channel program")
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c  | 11 +++++++++--
 drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
 drivers/s390/cio/vfio_ccw_drv.c |  4 ++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 3645d1720c4b..2d942433baf9 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -803,15 +803,19 @@ union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm)
  *
  * This function updates @scsw->cpa to its coressponding guest physical
  * address.
+ *
+ * Returns true if the channel program address in the irb was found
+ * within the chain of CCWs for this channel program.
  */
-void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
+bool cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 {
 	struct ccwchain *chain;
 	u32 cpa = scsw->cmd.cpa;
 	u32 ccw_head;
+	bool within_chain = false;
 
 	if (!cp->initialized)
-		return;
+		return false;
 
 	/*
 	 * LATER:
@@ -833,11 +837,14 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
 			 * head gets us the guest cpa.
 			 */
 			cpa = chain->ch_iova + (cpa - ccw_head);
+			within_chain = true;
 			break;
 		}
 	}
 
 	scsw->cmd.cpa = cpa;
+
+	return within_chain;
 }
 
 /**
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index ba31240ce965..a4cb6527bd4e 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -47,7 +47,7 @@ extern int cp_init(struct channel_program *cp, struct device *mdev,
 extern void cp_free(struct channel_program *cp);
 extern int cp_prefetch(struct channel_program *cp);
 extern union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm);
-extern void cp_update_scsw(struct channel_program *cp, union scsw *scsw);
+extern bool cp_update_scsw(struct channel_program *cp, union scsw *scsw);
 extern bool cp_iova_pinned(struct channel_program *cp, u64 iova);
 
 #endif
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index e401a3d0aa57..a8ab256a217b 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -90,8 +90,8 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
 	if (scsw_is_solicited(&irb->scsw)) {
-		cp_update_scsw(&private->cp, &irb->scsw);
-		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
+		if (cp_update_scsw(&private->cp, &irb->scsw) &&
+		    is_final && private->state == VFIO_CCW_STATE_CP_PENDING)
 			cp_free(&private->cp);
 	}
 	mutex_lock(&private->io_mutex);
-- 
2.17.1

