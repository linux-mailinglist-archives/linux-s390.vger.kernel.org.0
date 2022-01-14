Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789E448F135
	for <lists+linux-s390@lfdr.de>; Fri, 14 Jan 2022 21:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiANUcd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Jan 2022 15:32:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244409AbiANUcP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Jan 2022 15:32:15 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20EJr4qL011920;
        Fri, 14 Jan 2022 20:32:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jPsFedQrPacd/r+HLidOT/VoXk2dC4ZpaK3y7y+yKs0=;
 b=a682mUFFaixKkbnvbIgnlGuUsqHmJ0H68QHGCFVTE58tW/aMDhxj8QVIf1XT2yU85UZ+
 r8Jus0QlqiIdzbKPFj7X48fPDG0gFVhczrjvSgeCX1MI499Z8Vmci08XDu0TPmxtrfM/
 HaE8KwmExpadDE/9xzkkcMLtDcSdpRTrdzwh0R5w+AY96yoBvovSAgVlYnpk+TJNyheR
 QmpmyFXzLGHKxHcS1epxh385vMVfnFXw0UjlbK7+RKOCBX/n/Xzw660bedsU/rmM4tns
 5pmV4Do98iyY2ERSrvVSaad4O6UujFDNGrJvHDV6Lje++dIopIp5BX1SRYgfSuulvK8y KA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dkdncb65g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 20:32:14 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20EKDuvc012226;
        Fri, 14 Jan 2022 20:32:14 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dkdncb651-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 20:32:14 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20EKLZkT021966;
        Fri, 14 Jan 2022 20:32:13 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3df28cqj67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jan 2022 20:32:13 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20EKW5la25559430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jan 2022 20:32:05 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6E2C6067;
        Fri, 14 Jan 2022 20:32:05 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6672DC6069;
        Fri, 14 Jan 2022 20:32:03 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown [9.211.65.142])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 14 Jan 2022 20:32:03 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/30] s390/pci: externalize the SIC operation controls and routine
Date:   Fri, 14 Jan 2022 15:31:22 -0500
Message-Id: <20220114203145.242984-8-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220114203145.242984-1-mjrosato@linux.ibm.com>
References: <20220114203145.242984-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dNb9DgZCs3zYfrqKdZ69OBiYf2H2wMK2
X-Proofpoint-GUID: ggCyy_f6MUb_t5tlP9WJwRVOCQgZJdkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_06,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=823
 impostorscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140120
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A subsequent patch will be issuing SIC from KVM -- export the necessary
routine and make the operation control definitions available from a header.
Because the routine will now be exported, let's rename __zpci_set_irq_ctrl
to zpci_set_irq_ctrl and get rid of the zero'd iib wrapper function of
the same name.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_insn.h | 17 +++++++++--------
 arch/s390/pci/pci_insn.c         |  3 ++-
 arch/s390/pci/pci_irq.c          | 26 ++++++++++++--------------
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_insn.h
index 61cf9531f68f..5331082fa516 100644
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -98,6 +98,14 @@ struct zpci_fib {
 	u32 gd;
 } __packed __aligned(8);
 
+/* Set Interruption Controls Operation Controls  */
+#define	SIC_IRQ_MODE_ALL		0
+#define	SIC_IRQ_MODE_SINGLE		1
+#define	SIC_IRQ_MODE_DIRECT		4
+#define	SIC_IRQ_MODE_D_ALL		16
+#define	SIC_IRQ_MODE_D_SINGLE		17
+#define	SIC_IRQ_MODE_SET_CPU		18
+
 /* directed interruption information block */
 struct zpci_diib {
 	u32 : 1;
@@ -134,13 +142,6 @@ int __zpci_store(u64 data, u64 req, u64 offset);
 int zpci_store(const volatile void __iomem *addr, u64 data, unsigned long len);
 int __zpci_store_block(const u64 *data, u64 req, u64 offset);
 void zpci_barrier(void);
-int __zpci_set_irq_ctrl(u16 ctl, u8 isc, union zpci_sic_iib *iib);
-
-static inline int zpci_set_irq_ctrl(u16 ctl, u8 isc)
-{
-	union zpci_sic_iib iib = {{0}};
-
-	return __zpci_set_irq_ctrl(ctl, isc, &iib);
-}
+int zpci_set_irq_ctrl(u16 ctl, u8 isc, union zpci_sic_iib *iib);
 
 #endif
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 4dd58b196cea..2a47b3936e44 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -97,7 +97,7 @@ int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
 }
 
 /* Set Interruption Controls */
-int __zpci_set_irq_ctrl(u16 ctl, u8 isc, union zpci_sic_iib *iib)
+int zpci_set_irq_ctrl(u16 ctl, u8 isc, union zpci_sic_iib *iib)
 {
 	if (!test_facility(72))
 		return -EIO;
@@ -108,6 +108,7 @@ int __zpci_set_irq_ctrl(u16 ctl, u8 isc, union zpci_sic_iib *iib)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(zpci_set_irq_ctrl);
 
 /* PCI Load */
 static inline int ____pcilg(u64 *data, u64 req, u64 offset, u8 *status)
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 0d0a02a9fbbf..2f675355fd0c 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -15,13 +15,6 @@
 
 static enum {FLOATING, DIRECTED} irq_delivery;
 
-#define	SIC_IRQ_MODE_ALL		0
-#define	SIC_IRQ_MODE_SINGLE		1
-#define	SIC_IRQ_MODE_DIRECT		4
-#define	SIC_IRQ_MODE_D_ALL		16
-#define	SIC_IRQ_MODE_D_SINGLE		17
-#define	SIC_IRQ_MODE_SET_CPU		18
-
 /*
  * summary bit vector
  * FLOATING - summary bit per function
@@ -154,6 +147,7 @@ static struct irq_chip zpci_irq_chip = {
 static void zpci_handle_cpu_local_irq(bool rescan)
 {
 	struct airq_iv *dibv = zpci_ibv[smp_processor_id()];
+	union zpci_sic_iib iib = {{0}};
 	unsigned long bit;
 	int irqs_on = 0;
 
@@ -165,7 +159,7 @@ static void zpci_handle_cpu_local_irq(bool rescan)
 				/* End of second scan with interrupts on. */
 				break;
 			/* First scan complete, reenable interrupts. */
-			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC))
+			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC, &iib))
 				break;
 			bit = 0;
 			continue;
@@ -193,6 +187,7 @@ static void zpci_handle_remote_irq(void *data)
 static void zpci_handle_fallback_irq(void)
 {
 	struct cpu_irq_data *cpu_data;
+	union zpci_sic_iib iib = {{0}};
 	unsigned long cpu;
 	int irqs_on = 0;
 
@@ -203,7 +198,7 @@ static void zpci_handle_fallback_irq(void)
 				/* End of second scan with interrupts on. */
 				break;
 			/* First scan complete, reenable interrupts. */
-			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC))
+			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC, &iib))
 				break;
 			cpu = 0;
 			continue;
@@ -234,6 +229,7 @@ static void zpci_directed_irq_handler(struct airq_struct *airq,
 static void zpci_floating_irq_handler(struct airq_struct *airq,
 				      struct tpi_info *tpi_info)
 {
+	union zpci_sic_iib iib = {{0}};
 	unsigned long si, ai;
 	struct airq_iv *aibv;
 	int irqs_on = 0;
@@ -247,7 +243,7 @@ static void zpci_floating_irq_handler(struct airq_struct *airq,
 				/* End of second scan with interrupts on. */
 				break;
 			/* First scan complete, reenable interrupts. */
-			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC))
+			if (zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC, &iib))
 				break;
 			si = 0;
 			continue;
@@ -407,11 +403,12 @@ static struct airq_struct zpci_airq = {
 static void __init cpu_enable_directed_irq(void *unused)
 {
 	union zpci_sic_iib iib = {{0}};
+	union zpci_sic_iib ziib = {{0}};
 
 	iib.cdiib.dibv_addr = (u64) zpci_ibv[smp_processor_id()]->vector;
 
-	__zpci_set_irq_ctrl(SIC_IRQ_MODE_SET_CPU, 0, &iib);
-	zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_SET_CPU, 0, &iib);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_D_SINGLE, PCI_ISC, &ziib);
 }
 
 static int __init zpci_directed_irq_init(void)
@@ -426,7 +423,7 @@ static int __init zpci_directed_irq_init(void)
 	iib.diib.isc = PCI_ISC;
 	iib.diib.nr_cpus = num_possible_cpus();
 	iib.diib.disb_addr = virt_to_phys(zpci_sbv->vector);
-	__zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_DIRECT, 0, &iib);
 
 	zpci_ibv = kcalloc(num_possible_cpus(), sizeof(*zpci_ibv),
 			   GFP_KERNEL);
@@ -471,6 +468,7 @@ static int __init zpci_floating_irq_init(void)
 
 int __init zpci_irq_init(void)
 {
+	union zpci_sic_iib iib = {{0}};
 	int rc;
 
 	irq_delivery = sclp.has_dirq ? DIRECTED : FLOATING;
@@ -502,7 +500,7 @@ int __init zpci_irq_init(void)
 	 * Enable floating IRQs (with suppression after one IRQ). When using
 	 * directed IRQs this enables the fallback path.
 	 */
-	zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC);
+	zpci_set_irq_ctrl(SIC_IRQ_MODE_SINGLE, PCI_ISC, &iib);
 
 	return 0;
 out_airq:
-- 
2.27.0

