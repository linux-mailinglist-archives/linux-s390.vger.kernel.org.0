Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948062C53DC
	for <lists+linux-s390@lfdr.de>; Thu, 26 Nov 2020 13:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgKZMTm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Nov 2020 07:19:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43326 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729257AbgKZMTm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 07:19:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQC1BHq095194
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 07:19:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=rZ1DXz9Sjh83S7ClY1dsfWwp5NU5OrsXILEb7MxuvnE=;
 b=Dwdp3JHgVRQnrUOuMlOVLyYZ+GSwfe/ayItaHn5fy7ya/b/NFO3/EENrnIXh9EG6oi6e
 k3JBVl8A12gXctx/fqCIglZ8SejtZqLQu/VpbUJpg+ZwVFvtcjt6Mznclky2dQvXl+US
 2/3fjmyxJvH7Y5x9ixDdoOb1eOkptupD5pUFArkst9pkiqnu5fn9aDzovyGmFsHxQm/5
 beJOh5LPPwVjULJ6FqL2ed8CpXfPFsKBwInoOWg2TPwiNh6Hv4szoXkwGw4HCjlPL2IY
 /lXydP1EmKVdvi6n3doLuLl6jKFLw4ndLeKnqmsjDJ7RGMvQam1l2mqEmP2HUstlJ9aI bQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352be0sd50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 07:19:41 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQC7Fuf010178
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 12:19:39 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 351vqqrn71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 12:19:39 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQCJaUr42205530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 12:19:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 919C84C059;
        Thu, 26 Nov 2020 12:19:36 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4224C052;
        Thu, 26 Nov 2020 12:19:36 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.159.67])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 12:19:36 +0000 (GMT)
Date:   Thu, 26 Nov 2020 13:19:34 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201126121934.GA514@oc3871087118.ibm.com>
References: <af38d74d-5310-9700-1773-85b8372022d4@linux.ibm.com>
 <20201125142930.GA13435@oc3871087118.ibm.com>
 <31dfedbf-cfe4-09d2-5dc5-ee9fb847d109@linux.ibm.com>
 <8a072525-7915-27c8-40ef-d7c826419a89@linux.ibm.com>
 <10403770-249e-ccbc-a90a-f4ceeb190346@linux.ibm.com>
 <20201125155818.GA16580@oc3871087118.ibm.com>
 <a3be779d-6103-014a-3090-a0ea86c5668a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3be779d-6103-014a-3090-a0ea86c5668a@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_03:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011260070
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The directed MSIs are delivered to CPUs whose address is
written to the MSI message data. The current code assumes
that a CPU logical number (as it is seen by the kernel)
is also that CPU address.

The above assumption is not correct, as the CPU address
is rather the value returned by STAP instruction. That
value is not necessarily matches the kernel logical CPU
number.

Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 743f257cf2cb..1309fd302f58 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
 {
 	struct msi_desc *entry = irq_get_msi_desc(data->irq);
 	struct msi_msg msg = entry->msg;
+	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
 
 	msg.address_lo &= 0xff0000ff;
-	msg.address_lo |= (cpumask_first(dest) << 8);
+	msg.address_lo |= (cpu_addr << 8);
 	pci_write_msi_msg(data->irq, &msg);
 
 	return IRQ_SET_MASK_OK;
@@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned long bit;
 	struct msi_desc *msi;
 	struct msi_msg msg;
+	int cpu_addr;
 	int rc, irq;
 
 	zdev->aisb = -1UL;
@@ -287,9 +289,16 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 					 handle_percpu_irq);
 		msg.data = hwirq - bit;
 		if (irq_delivery == DIRECTED) {
+			if (msi->affinity) {
+				cpu = cpumask_first(&msi->affinity->mask);
+				cpu_addr = smp_cpu_get_cpu_address(cpu);
+			} else {
+				cpu_addr = 0;
+			}
+
 			msg.address_lo = zdev->msi_addr & 0xff0000ff;
-			msg.address_lo |= msi->affinity ?
-				(cpumask_first(&msi->affinity->mask) << 8) : 0;
+			msg.address_lo |= (cpu_addr << 8);
+
 			for_each_possible_cpu(cpu) {
 				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
 			}
-- 
2.26.0

