Return-Path: <linux-s390+bounces-6133-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F06497B9F5
	for <lists+linux-s390@lfdr.de>; Wed, 18 Sep 2024 11:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644911C21013
	for <lists+linux-s390@lfdr.de>; Wed, 18 Sep 2024 09:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA94016FF45;
	Wed, 18 Sep 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWwIr0ng"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A9139D09;
	Wed, 18 Sep 2024 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726650274; cv=none; b=EbfLTXr/8b+O0tZYFZxCYZEy4O5i+1CRbkGcYfjwgvacF85EPJI7HhnKITOTLTcFZuOUM2Z3bIdd9DSkGDz5msSSzXQp3R8ZTiUcxsYb0l2HrP7CVJjcFuFz99zN8kJ125Cq+raUd4/nglcK3h46VEdNKNTVP3gTV3k69fB8I7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726650274; c=relaxed/simple;
	bh=CmFZzQI3YutkouFh6JjtCjCs7WLLz/CgKJDtUz9T2nQ=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=CNF/rBXXfLUmd88nDhdHa5JPbM7V7SlgMuue5/g6QyPXG3QfEp6JGYs8eV/HtMeKO/UiwnjHlPvi2li72rRvZB/HEXI84h7aJ8TUW23GmVAWSpCV3DCrOFC0paun/oUyUWTXNb83L/zbOPIRT3WqzLYqhjZUbhhXLjcocphG6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWwIr0ng; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7VhI6030209;
	Wed, 18 Sep 2024 09:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:date:subject:content-type:message-id:to:cc
	:content-transfer-encoding:mime-version; s=pp1; bh=uIZEulEggDzH1
	/wp03fYzxvgOu8tl7wxppWtrY9bPII=; b=IWwIr0ng1wBn7pWRQxUrlZ5eyUAai
	CNnaGlxe9WedaK+d90nBhaAfXs55pKpMIs0l8wRIq+LkCkCYkz3Y6LIpQWZmjg5l
	yQQGhjNRztr5BZx7/GMTMtLbxl32l1K224ZeOmMFvHK9i9mI7yDk5959xgcTCs7A
	52GMxkQMPerKbnBJQsPPC5XxltSm25SkWzD1CE66ylZekRNftJPjVQeSbK7+HAE+
	eC7h+lkuveppsGPym6nNdU+FM9Hgvqhcih3NiObdXd3HV8/J7FmytV0TLEpooaju
	O5HtAPR8eUtTxOOfiv5BMVdNsGFoUEvSYowwaVGpE1qWmrxHReHviyDtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8kym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:04:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48I8vN1N014187;
	Wed, 18 Sep 2024 09:04:28 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41pht8kym1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:04:28 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7YhmS031056;
	Wed, 18 Sep 2024 09:04:28 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41npana02g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Sep 2024 09:04:28 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48I94QBZ25035278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 09:04:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C779E58055;
	Wed, 18 Sep 2024 09:04:26 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03655804E;
	Wed, 18 Sep 2024 09:04:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Sep 2024 09:04:24 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 18 Sep 2024 11:04:22 +0200
Subject: [PATCH v2] PCI: s390: Handle ARI on bus without associated struct
 pci_dev
Content-Type: text/plain; charset="utf-8"
Message-Id: <20240918-ari_no_bus_dev-v2-1-83cfa991082f@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAJWX6mYC/13MywqDMBCF4VeRWTdiRpvQrvoeRcTLpA7URJIaL
 OK7N5WuuvwPnG+DQJ4pwDXbwFPkwM6mwFMG/djaBwkeUgMWWBUaK9F6bqxruiU0A0Vxxg5b1Ka
 slIJ0mj0ZXg/wXqceObycfx9+lN/1R5XFPxWlkEIPJLXSylwM3Z5slzXnbsp7N0G97/sHsiyM6
 bAAAAA=
To: Bjorn Helgaas <bhelgaas@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5602;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=CmFZzQI3YutkouFh6JjtCjCs7WLLz/CgKJDtUz9T2nQ=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJeTZ+hHbGw8NDkj28/3PTccjzi2wWZtXM3f7Zkvc0et
 b93mVXPno5SFgYxLgZZMUWWRV3OfusKppjuCervgJnDygQyhIGLUwAmkiLHyLDub+nxkiojveqL
 f5b8qe9v32QyW53Z7GBh3IVXPRuLLE8w/LNNZLIXmWuo62/07VC3QeaRJj9hWcvW2woZJjMtz7D
 1sQEA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YIhaOUbJKQ8HvUARi3VhisEOVSSuJrkS
X-Proofpoint-ORIG-GUID: b-p4DsvQp9N17SfN841MghWEGaB7FGvA
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_07,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=985 mlxscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409180054

On s390 PCI busses are virtualized and the downstream ports are
invisible to the OS and struct pci_bus::self is NULL. This associated
struct pci_dev is however relied upon in pci_ari_enabled() to check
whether ARI is enabled for the bus. ARI is therefor always detected as
disabled.

At the same time firmware on s390 always enables and relies upon ARI
thus causing a mismatch. Moreover with per-PCI function pass-through
there may exist busses with no function with devfn 0. For example
a SR-IOV capable device with two PFs may have separate function
dependency link chains for each of the PFs and their child VFs. In this
case the OS may only see the second PF and its child VFs on a bus
without a devfn 0 function. A situation which is also not supported by
the common pci_configure_ari() code.

Dispite simply being a mismatch this causes problems as some PCI devices
present a different SR-IOV topology depending on PCI_SRIOV_CTRL_ARI.

A similar mismatch may occur with SR-IOV when virtfn_add_bus() creates new
busses with no associated struct pci_dev. Here too pci_ari_enabled()
on these busses would return false even if ARI is actually used.

Prevent both mismatches by moving the ari_enabled flag from struct
pci_dev to struct pci_bus making it independent from struct pci_bus::
self. Let the bus inherit the ari_enabled state from its parent bus when
there is no bridge device such that busses added by virtfn_add_bus()
match their parent. For s390 set ari_enabled when the device supports
ARI in the awareness that all PCIe ports on s390 systems are ARI
capable.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
Note: In a comment of the v1 thread I discussed an alternative idea for
a generic solution that would include the Jailhouse hypervisor via
hypervisor_isolated_pci_functions(). As Bjorn correctly pointed out this
more generic solution however lacks a way to indicate that ARI is really
enabled in the hardware. So instead for now I propose to stick with this
patch which only enables this unconditionally on s390x and SR-IOV
virtual busses where the ARI is inherited.
---
Changes in v2:
- Rebased on v6.11
- Link to v1: https://lore.kernel.org/r/20240730-ari_no_bus_dev-v1-1-7de17676f9fe@linux.ibm.com
---
 arch/s390/pci/pci_bus.c | 12 ++++++++++++
 drivers/pci/pci.c       |  4 ++--
 drivers/pci/probe.c     |  1 +
 include/linux/pci.h     |  4 ++--
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index daa5d7450c7d..021319438dad 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -278,6 +278,18 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	/*
+	 * On s390 PCI busses are virtualized and the bridge
+	 * devices are invisible to the OS. Furthermore busses
+	 * may exist without a devfn 0 function. Thus the normal
+	 * ARI detection does not work. At the same time fw/hw
+	 * has always enabled ARI when possible. Reflect the actual
+	 * state by setting ari_enabled whenever a device on the bus
+	 * supports it.
+	 */
+	if (pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ARI))
+		zdev->zbus->bus->ari_enabled = 1;
+
 	/*
 	 * With pdev->no_vf_scan the common PCI probing code does not
 	 * perform PF/VF linking.
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ffaaca0978cb..f94a96a6cb30 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3537,11 +3537,11 @@ void pci_configure_ari(struct pci_dev *dev)
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ARI)) {
 		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
 					 PCI_EXP_DEVCTL2_ARI);
-		bridge->ari_enabled = 1;
+		dev->bus->ari_enabled = 1;
 	} else {
 		pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
 					   PCI_EXP_DEVCTL2_ARI);
-		bridge->ari_enabled = 0;
+		dev->bus->ari_enabled = 0;
 	}
 }
 
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b14b9876c030..c318929438c1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1143,6 +1143,7 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 
 	if (!bridge) {
 		child->dev.parent = parent->bridge;
+		child->ari_enabled = parent->ari_enabled;
 		goto add_dev;
 	}
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..3d1f4a392dd6 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -429,7 +429,6 @@ struct pci_dev {
 	unsigned int	irq_reroute_variant:2;	/* Needs IRQ rerouting variant */
 	unsigned int	msi_enabled:1;
 	unsigned int	msix_enabled:1;
-	unsigned int	ari_enabled:1;		/* ARI forwarding */
 	unsigned int	ats_enabled:1;		/* Address Translation Svc */
 	unsigned int	pasid_enabled:1;	/* Process Address Space ID */
 	unsigned int	pri_enabled:1;		/* Page Request Interface */
@@ -679,6 +678,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
 	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
+	unsigned int		ari_enabled:1;	/* ARI forwarding enabled */
 };
 
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
@@ -2637,7 +2637,7 @@ static inline bool pci_is_dev_assigned(struct pci_dev *pdev)
  */
 static inline bool pci_ari_enabled(struct pci_bus *bus)
 {
-	return bus->self && bus->self->ari_enabled;
+	return bus->ari_enabled;
 }
 
 /**

---
base-commit: 98f7e32f20d28ec452afb208f9cffc08448a2652
change-id: 20240724-ari_no_bus_dev-52b2a27f3466

Best regards,
-- 
Niklas Schnelle


