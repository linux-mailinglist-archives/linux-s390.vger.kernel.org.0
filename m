Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 833FAD691E
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2019 20:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbfJNSJH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Oct 2019 14:09:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730577AbfJNSJH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 14:09:07 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9EHvhfm083871
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vmwes19b6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2019 14:09:05 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <farman@linux.ibm.com>;
        Mon, 14 Oct 2019 19:09:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Oct 2019 19:09:00 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9EI8xIv46465254
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Oct 2019 18:08:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F6714C059;
        Mon, 14 Oct 2019 18:08:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE93D4C04E;
        Mon, 14 Oct 2019 18:08:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 14 Oct 2019 18:08:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
        id 9D16EE0184; Mon, 14 Oct 2019 20:08:58 +0200 (CEST)
From:   Eric Farman <farman@linux.ibm.com>
To:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Herne <jjherne@linux.ibm.com>,
        Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: [RFC PATCH 1/4] vfio-ccw: Refactor how the traces are built
Date:   Mon, 14 Oct 2019 20:08:52 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191014180855.19400-1-farman@linux.ibm.com>
References: <20191014180855.19400-1-farman@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19101418-0016-0000-0000-000002B7FE9D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101418-0017-0000-0000-000033191992
Message-Id: <20191014180855.19400-2-farman@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910140149
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 3cd90214b70f ("vfio: ccw: add tracepoints for interesting error
paths") added a quick trace point to determine where a channel program
failed while being processed.  It's a great addition, but adding more
traces to vfio-ccw is more cumbersome than it needs to be.

Let's refactor how this is done, so that additional traces are easier
to add and can exist outside of the FSM if we ever desire.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/Makefile         |  4 ++--
 drivers/s390/cio/vfio_ccw_cp.h    |  1 +
 drivers/s390/cio/vfio_ccw_fsm.c   |  3 ---
 drivers/s390/cio/vfio_ccw_trace.c | 12 ++++++++++++
 drivers/s390/cio/vfio_ccw_trace.h |  2 ++
 5 files changed, 17 insertions(+), 5 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.c

diff --git a/drivers/s390/cio/Makefile b/drivers/s390/cio/Makefile
index f6a8db04177c..23eae4188876 100644
--- a/drivers/s390/cio/Makefile
+++ b/drivers/s390/cio/Makefile
@@ -5,7 +5,7 @@
 
 # The following is required for define_trace.h to find ./trace.h
 CFLAGS_trace.o := -I$(src)
-CFLAGS_vfio_ccw_fsm.o := -I$(src)
+CFLAGS_vfio_ccw_trace.o := -I$(src)
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o \
 	fcx.o itcw.o crw.o ccwreq.o trace.o ioasm.o
@@ -21,5 +21,5 @@ qdio-objs := qdio_main.o qdio_thinint.o qdio_debug.o qdio_setup.o
 obj-$(CONFIG_QDIO) += qdio.o
 
 vfio_ccw-objs += vfio_ccw_drv.o vfio_ccw_cp.o vfio_ccw_ops.o vfio_ccw_fsm.o \
-	vfio_ccw_async.o
+	vfio_ccw_async.o vfio_ccw_trace.o
 obj-$(CONFIG_VFIO_CCW) += vfio_ccw.o
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index 7cdc38049033..ba31240ce965 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -15,6 +15,7 @@
 #include <asm/scsw.h>
 
 #include "orb.h"
+#include "vfio_ccw_trace.h"
 
 /*
  * Max length for ccw chain.
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 4a1e727c62d9..d4119e4c4a8c 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -15,9 +15,6 @@
 #include "ioasm.h"
 #include "vfio_ccw_private.h"
 
-#define CREATE_TRACE_POINTS
-#include "vfio_ccw_trace.h"
-
 static int fsm_io_helper(struct vfio_ccw_private *private)
 {
 	struct subchannel *sch;
diff --git a/drivers/s390/cio/vfio_ccw_trace.c b/drivers/s390/cio/vfio_ccw_trace.c
new file mode 100644
index 000000000000..d5cc943c6864
--- /dev/null
+++ b/drivers/s390/cio/vfio_ccw_trace.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tracepoint definitions for vfio_ccw
+ *
+ * Copyright IBM Corp. 2019
+ * Author(s): Eric Farman <farman@linux.ibm.com>
+ */
+
+#define CREATE_TRACE_POINTS
+#include "vfio_ccw_trace.h"
+
+EXPORT_TRACEPOINT_SYMBOL(vfio_ccw_io_fctl);
diff --git a/drivers/s390/cio/vfio_ccw_trace.h b/drivers/s390/cio/vfio_ccw_trace.h
index b1da53ddec1f..2a2937a40124 100644
--- a/drivers/s390/cio/vfio_ccw_trace.h
+++ b/drivers/s390/cio/vfio_ccw_trace.h
@@ -7,6 +7,8 @@
  *            Halil Pasic <pasic@linux.vnet.ibm.com>
  */
 
+#include "cio.h"
+
 #undef TRACE_SYSTEM
 #define TRACE_SYSTEM vfio_ccw
 
-- 
2.17.1

