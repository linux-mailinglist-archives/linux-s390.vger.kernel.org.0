Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E724D8CCB
	for <lists+linux-s390@lfdr.de>; Mon, 14 Mar 2022 20:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiCNTrq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Mar 2022 15:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235229AbiCNTro (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 14 Mar 2022 15:47:44 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34463E5D1;
        Mon, 14 Mar 2022 12:46:27 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22EIrRHq006127;
        Mon, 14 Mar 2022 19:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mABYJ/U84DxwmA1qI7uP960sK3LdiJd9FRSuKu7NiZk=;
 b=XafFOKS89bqJbVDBDf/MtoFRLWfv29KN8KXIZD+Vh6v4IYL7JRvlBHuYJN/yVrPo6E50
 x/CDnkzBga55Y/CmQiZ7icGW5dfKQ8wm7PNoEYFN9fEsHXeKi2GEX5TQeglXAvttgtxV
 YoA4t4QMkAqkRJXwP88WKtH8rRQ55CX3WLVrG1sEBLceDETSfIa/YpexhAWXfUHpVmuQ
 bWhtxNdutwyPH/R9zmqfGDkB3FWfGrLxSCaW31xSjFQ9r7u9mNmU1Q9dZ6usELPaIDDb
 uHjTPYTNk+pHlolt37Pft5IlADE3xqoO/H5pLL5FxmXUhhoU1+O9OoXMXEJVNgHlQbiI mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3et6d2rep4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 19:46:19 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22EJSrh8022134;
        Mon, 14 Mar 2022 19:46:18 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3et6d2renv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 19:46:18 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22EJNoKd027368;
        Mon, 14 Mar 2022 19:46:17 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3etaj6gnys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Mar 2022 19:46:17 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22EJkF6v17432984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Mar 2022 19:46:15 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA36F11206B;
        Mon, 14 Mar 2022 19:46:15 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81549112062;
        Mon, 14 Mar 2022 19:46:07 +0000 (GMT)
Received: from li-c92d2ccc-254b-11b2-a85c-a700b5bfb098.ibm.com.com (unknown [9.211.32.184])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 14 Mar 2022 19:46:07 +0000 (GMT)
From:   Matthew Rosato <mjrosato@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, joro@8bytes.org, will@kernel.org,
        pbonzini@redhat.com, corbet@lwn.net, jgg@nvidia.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org
Subject: [PATCH v4 07/32] s390/pci: externalize the SIC operation controls and routine
Date:   Mon, 14 Mar 2022 15:44:26 -0400
Message-Id: <20220314194451.58266-8-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220314194451.58266-1-mjrosato@linux.ibm.com>
References: <20220314194451.58266-1-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -JDxv9ovjtvfezSJTavk3cpVopw8h_7i
X-Proofpoint-ORIG-GUID: Fg3A4Cl-rRUFQ80dajmn7REPIs_1L1jC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-14_13,2022-03-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=680 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203140116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

A subsequent patch will be issuing SIC from KVM -- export the necessary
routine and make the operation control definitions available from a header.
Because the routine will now be exported, let's rename __zpci_set_irq_ctrl
to zpci_set_irq_ctrl and get rid of the zero'd iib wrapper function of
the same name.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
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

