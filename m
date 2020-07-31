Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6438234399
	for <lists+linux-s390@lfdr.de>; Fri, 31 Jul 2020 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732389AbgGaJqh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 31 Jul 2020 05:46:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732399AbgGaJqc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jul 2020 05:46:32 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06V9ZavS110067;
        Fri, 31 Jul 2020 05:46:31 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mecy486w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:46:31 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06V9Ze9w110440;
        Fri, 31 Jul 2020 05:46:30 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mecy486f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 05:46:30 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06V9k81P004807;
        Fri, 31 Jul 2020 09:46:28 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 32gcqk4bdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 09:46:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06V9kPFS45809740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 09:46:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EFA0DAE045;
        Fri, 31 Jul 2020 09:46:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88781AE051;
        Fri, 31 Jul 2020 09:46:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.145.62.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 31 Jul 2020 09:46:24 +0000 (GMT)
From:   Janosch Frank <frankja@linux.ibm.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, frankja@linux.vnet.ibm.com, david@redhat.com,
        thuth@redhat.com, pmorel@linux.ibm.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
Subject: [kvm-unit-tests GIT PULL 10/11] s390x: css: ssch/tsch with sense and interrupt
Date:   Fri, 31 Jul 2020 11:46:06 +0200
Message-Id: <20200731094607.15204-11-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200731094607.15204-1-frankja@linux.ibm.com>
References: <20200731094607.15204-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_03:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=1 adultscore=0
 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310071
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Pierre Morel <pmorel@linux.ibm.com>

After a channel is enabled we start a SENSE_ID command using
the SSCH instruction to recognize the control unit and device.

This tests the success of SSCH, the I/O interruption and the TSCH
instructions.

The SENSE_ID command response is tested to report 0xff inside
its reserved field and to report the same control unit type
as the cu_type kernel argument.

Without the cu_type kernel argument, the test expects a device
with a default control unit type of 0x3832, a.k.a virtio-net-ccw.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1594904645-32499-1-git-send-email-pmorel@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 lib/s390x/asm/arch_def.h |   1 +
 lib/s390x/css.h          |  35 ++++++++
 lib/s390x/css_lib.c      | 177 +++++++++++++++++++++++++++++++++++++++
 s390x/css.c              |  80 ++++++++++++++++++
 4 files changed, 293 insertions(+)

diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
index 022a564..edc06ef 100644
--- a/lib/s390x/asm/arch_def.h
+++ b/lib/s390x/asm/arch_def.h
@@ -16,6 +16,7 @@ struct psw {
 };
 
 #define PSW_MASK_EXT			0x0100000000000000UL
+#define PSW_MASK_IO			0x0200000000000000UL
 #define PSW_MASK_DAT			0x0400000000000000UL
 #define PSW_MASK_WAIT			0x0002000000000000UL
 #define PSW_MASK_PSTATE			0x0001000000000000UL
diff --git a/lib/s390x/css.h b/lib/s390x/css.h
index 63a70f1..221b67c 100644
--- a/lib/s390x/css.h
+++ b/lib/s390x/css.h
@@ -11,6 +11,8 @@
 #ifndef CSS_H
 #define CSS_H
 
+#define lowcore_ptr ((struct lowcore *)0x0)
+
 /* subchannel ID bit 16 must always be one */
 #define SCHID_ONE	0x00010000
 
@@ -62,9 +64,18 @@ struct orb {
 } __attribute__ ((aligned(4)));
 
 struct scsw {
+#define SCSW_SC_PENDING		0x00000001
+#define SCSW_SC_SECONDARY	0x00000002
+#define SCSW_SC_PRIMARY		0x00000004
+#define SCSW_SC_INTERMEDIATE	0x00000008
+#define SCSW_SC_ALERT		0x00000010
 	uint32_t ctrl;
 	uint32_t ccw_addr;
+#define SCSW_DEVS_DEV_END	0x04
+#define SCSW_DEVS_SCH_END	0x08
 	uint8_t  dev_stat;
+#define SCSW_SCHS_PCI	0x80
+#define SCSW_SCHS_IL	0x40
 	uint8_t  sch_stat;
 	uint16_t count;
 };
@@ -102,6 +113,19 @@ struct irb {
 	uint32_t emw[8];
 } __attribute__ ((aligned(4)));
 
+#define CCW_CMD_SENSE_ID	0xe4
+#define CSS_SENSEID_COMMON_LEN	8
+struct senseid {
+	/* common part */
+	uint8_t reserved;        /* always 0x'FF' */
+	uint16_t cu_type;        /* control unit type */
+	uint8_t cu_model;        /* control unit model */
+	uint16_t dev_type;       /* device type */
+	uint8_t dev_model;       /* device model */
+	uint8_t unused;          /* padding byte */
+	uint8_t padding[256 - 8]; /* Extended part */
+} __attribute__ ((aligned(4))) __attribute__ ((packed));
+
 /* CSS low level access functions */
 
 static inline int ssch(unsigned long schid, struct orb *addr)
@@ -256,4 +280,15 @@ int css_enumerate(void);
 
 #define IO_SCH_ISC      3
 int css_enable(int schid, int isc);
+
+/* Library functions */
+int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw);
+int start_single_ccw(unsigned int sid, int code, void *data, int count,
+		     unsigned char flags);
+void css_irq_io(void);
+int css_residual_count(unsigned int schid);
+
+void enable_io_isc(uint8_t isc);
+int wait_and_check_io_completion(int schid);
+
 #endif
diff --git a/lib/s390x/css_lib.c b/lib/s390x/css_lib.c
index e47a945..8e02371 100644
--- a/lib/s390x/css_lib.c
+++ b/lib/s390x/css_lib.c
@@ -16,6 +16,7 @@
 #include <interrupt.h>
 #include <asm/arch_def.h>
 #include <asm/time.h>
+#include <asm/arch_def.h>
 
 #include <css.h>
 
@@ -141,3 +142,179 @@ retry:
 		    schid, retry_count, pmcw->flags);
 	return -1;
 }
+
+static struct irb irb;
+
+void css_irq_io(void)
+{
+	int ret = 0;
+	char *flags;
+	int sid;
+
+	report_prefix_push("Interrupt");
+	sid = lowcore_ptr->subsys_id_word;
+	/* Lowlevel set the SID as interrupt parameter. */
+	if (lowcore_ptr->io_int_param != sid) {
+		report(0,
+		       "io_int_param: %x differs from subsys_id_word: %x",
+		       lowcore_ptr->io_int_param, sid);
+		goto pop;
+	}
+	report_info("subsys_id_word: %08x io_int_param %08x io_int_word %08x",
+			lowcore_ptr->subsys_id_word,
+			lowcore_ptr->io_int_param,
+			lowcore_ptr->io_int_word);
+	report_prefix_pop();
+
+	report_prefix_push("tsch");
+	ret = tsch(sid, &irb);
+	switch (ret) {
+	case 1:
+		dump_irb(&irb);
+		flags = dump_scsw_flags(irb.scsw.ctrl);
+		report(0,
+		       "I/O interrupt, but tsch returns CC 1 for subchannel %08x. SCSW flags: %s",
+		       sid, flags);
+		break;
+	case 2:
+		report(0, "tsch returns unexpected CC 2");
+		break;
+	case 3:
+		report(0, "tsch reporting sch %08x as not operational", sid);
+		break;
+	case 0:
+		/* Stay humble on success */
+		break;
+	}
+pop:
+	report_prefix_pop();
+	lowcore_ptr->io_old_psw.mask &= ~PSW_MASK_WAIT;
+}
+
+int start_ccw1_chain(unsigned int sid, struct ccw1 *ccw)
+{
+	struct orb orb = {
+		.intparm = sid,
+		.ctrl = ORB_CTRL_ISIC|ORB_CTRL_FMT|ORB_LPM_DFLT,
+		.cpa = (unsigned int) (unsigned long)ccw,
+	};
+
+	return ssch(sid, &orb);
+}
+
+/*
+ * In the future, we want to implement support for CCW chains;
+ * for that, we will need to work with ccw1 pointers.
+ */
+static struct ccw1 unique_ccw;
+
+int start_single_ccw(unsigned int sid, int code, void *data, int count,
+		     unsigned char flags)
+{
+	int cc;
+	struct ccw1 *ccw = &unique_ccw;
+
+	report_prefix_push("start_subchannel");
+	/* Build the CCW chain with a single CCW */
+	ccw->code = code;
+	ccw->flags = flags;
+	ccw->count = count;
+	ccw->data_address = (int)(unsigned long)data;
+
+	cc = start_ccw1_chain(sid, ccw);
+	if (cc) {
+		report(0, "cc = %d", cc);
+		report_prefix_pop();
+		return cc;
+	}
+	report_prefix_pop();
+	return 0;
+}
+
+/* wait_and_check_io_completion:
+ * @schid: the subchannel ID
+ *
+ * Makes the most common check to validate a successful I/O
+ * completion.
+ * Only report failures.
+ */
+int wait_and_check_io_completion(int schid)
+{
+	int ret = 0;
+
+	wait_for_interrupt(PSW_MASK_IO);
+
+	report_prefix_push("check I/O completion");
+
+	if (lowcore_ptr->io_int_param != schid) {
+		report(0, "interrupt parameter: expected %08x got %08x",
+		       schid, lowcore_ptr->io_int_param);
+		ret = -1;
+		goto end;
+	}
+
+	/* Verify that device status is valid */
+	if (!(irb.scsw.ctrl & SCSW_SC_PENDING)) {
+		report(0, "No status pending after interrupt. Subch Ctrl: %08x",
+		       irb.scsw.ctrl);
+		ret = -1;
+		goto end;
+	}
+
+	if (!(irb.scsw.ctrl & (SCSW_SC_SECONDARY | SCSW_SC_PRIMARY))) {
+		report(0, "Primary or secondary status missing. Subch Ctrl: %08x",
+		       irb.scsw.ctrl);
+		ret = -1;
+		goto end;
+	}
+
+	if (!(irb.scsw.dev_stat & (SCSW_DEVS_DEV_END | SCSW_DEVS_SCH_END))) {
+		report(0, "No device end or sch end. Dev. status: %02x",
+		       irb.scsw.dev_stat);
+		ret = -1;
+		goto end;
+	}
+
+	if (irb.scsw.sch_stat & ~SCSW_SCHS_IL) {
+		report_info("Unexpected Subch. status %02x", irb.scsw.sch_stat);
+		ret = -1;
+		goto end;
+	}
+
+end:
+	report_prefix_pop();
+	return ret;
+}
+
+/*
+ * css_residual_count
+ * Return the residual count, if it is valid.
+ *
+ * Return value:
+ * Success: the residual count
+ * Not meaningful: -1 (-1 can not be a valid count)
+ */
+int css_residual_count(unsigned int schid)
+{
+
+	if (!(irb.scsw.ctrl & (SCSW_SC_PENDING | SCSW_SC_PRIMARY)))
+		return -1;
+
+	if (irb.scsw.dev_stat)
+		if (irb.scsw.sch_stat & ~(SCSW_SCHS_PCI | SCSW_SCHS_IL))
+			return -1;
+
+	return irb.scsw.count;
+}
+
+/*
+ * enable_io_isc: setup ISC in Control Register 6
+ * @isc: The interruption Sub Class as a bitfield
+ */
+void enable_io_isc(uint8_t isc)
+{
+	uint64_t value;
+
+	value = (uint64_t)isc << 24;
+	lctlg(6, value);
+}
diff --git a/s390x/css.c b/s390x/css.c
index f314a0c..ee3bc83 100644
--- a/s390x/css.c
+++ b/s390x/css.c
@@ -19,7 +19,11 @@
 
 #include <css.h>
 
+#define DEFAULT_CU_TYPE		0x3832 /* virtio-ccw */
+static unsigned long cu_type = DEFAULT_CU_TYPE;
+
 static int test_device_sid;
+static struct senseid senseid;
 
 static void test_enumerate(void)
 {
@@ -45,12 +49,87 @@ static void test_enable(void)
 	report(cc == 0, "Enable subchannel %08x", test_device_sid);
 }
 
+/*
+ * test_sense
+ * Pre-requisites:
+ * - We need the test device as the first recognized
+ *   device by the enumeration.
+ */
+static void test_sense(void)
+{
+	int ret;
+	int len;
+
+	if (!test_device_sid) {
+		report_skip("No device");
+		return;
+	}
+
+	ret = css_enable(test_device_sid, IO_SCH_ISC);
+	if (ret) {
+		report(0, "Could not enable the subchannel: %08x",
+		       test_device_sid);
+		return;
+	}
+
+	ret = register_io_int_func(css_irq_io);
+	if (ret) {
+		report(0, "Could not register IRQ handler");
+		return;
+	}
+
+	lowcore_ptr->io_int_param = 0;
+
+	memset(&senseid, 0, sizeof(senseid));
+	ret = start_single_ccw(test_device_sid, CCW_CMD_SENSE_ID,
+			       &senseid, sizeof(senseid), CCW_F_SLI);
+	if (ret)
+		goto error;
+
+	if (wait_and_check_io_completion(test_device_sid) < 0)
+		goto error;
+
+	/* Test transfer completion */
+	report_prefix_push("ssch transfer completion");
+
+	ret = css_residual_count(test_device_sid);
+
+	if (ret < 0) {
+		report_info("no valid residual count");
+	} else if (ret != 0) {
+		len = sizeof(senseid) - ret;
+		if (ret && len < CSS_SENSEID_COMMON_LEN) {
+			report(0, "transferred a too short length: %d", ret);
+			goto error;
+		} else if (ret && len)
+			report_info("transferred a shorter length: %d", len);
+	}
+
+	if (senseid.reserved != 0xff) {
+		report(0, "transferred garbage: 0x%02x", senseid.reserved);
+		goto error;
+	}
+
+	report_prefix_pop();
+
+	report_info("reserved 0x%02x cu_type 0x%04x cu_model 0x%02x dev_type 0x%04x dev_model 0x%02x",
+		    senseid.reserved, senseid.cu_type, senseid.cu_model,
+		    senseid.dev_type, senseid.dev_model);
+
+	report(senseid.cu_type == cu_type, "cu_type expected 0x%04x got 0x%04x",
+	       (uint16_t) cu_type, senseid.cu_type);
+
+error:
+	unregister_io_int_func(css_irq_io);
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
 } tests[] = {
 	{ "enumerate (stsch)", test_enumerate },
 	{ "enable (msch)", test_enable },
+	{ "sense (ssch/tsch)", test_sense },
 	{ NULL, NULL }
 };
 
@@ -59,6 +138,7 @@ int main(int argc, char *argv[])
 	int i;
 
 	report_prefix_push("Channel Subsystem");
+	enable_io_isc(0x80 >> IO_SCH_ISC);
 	for (i = 0; tests[i].name; i++) {
 		report_prefix_push(tests[i].name);
 		tests[i].func();
-- 
2.25.4

