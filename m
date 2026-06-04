Return-Path: <linux-s390+bounces-20506-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3JH/DJqYIWpsJgEAu9opvQ
	(envelope-from <linux-s390+bounces-20506-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:24:10 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1A3641634
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:24:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lPHEkOIW;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20506-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20506-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AFC8315C246
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2D320CD3;
	Thu,  4 Jun 2026 15:02:06 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B323339861
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585326; cv=none; b=W6b9vlwc6CX2Kw4OxBjIS+foNXrS666MrSAEdaU+3Ci32rcU8Hgk6lOEnEDgkiMMrsFHhzppm5eguRga/bM3dCYzzrvmbhPKl1rW9defAeBl9iiUR+QRGHfSlw/Vdhy/ldKOxGXY7gT9GJo6CyXWN1+OYGy7EuFL3GJUYg/RAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585326; c=relaxed/simple;
	bh=ugi8jDRcPzL1WqkEZW8QFJz3JbQ/n6QVLYj9qIogyFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9AbbgXAdi83/pvdsFhXGg8pw+W8/f3mLnqiZ4XmrUOd6dTwllNb4sAxxgYlWHm0qn3Uz8rqei3V1PQUa2z5t7QaHT4mlCQZo0bvAW2ctzzJmJBOs1LCfsBSnyoj1KYw28Nacu62bIyb+WzSoVMYvlbpAl32wz4+LEdVz5NeNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPHEkOIW; arc=none smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c0c2a68d01so5878955ad.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585323; x=1781190123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=lPHEkOIW5hlW6SbDgMhgKcnPvi4uI0XJc518fKkQtgJ8VDEIItLNGrgyqls/0kzXu1
         5YATaZc+JkppgDCj+waETqqnZYPzLhjveQRAizGMbmDteVTmfp4TKKRvVZ1jZ9Mes4Zp
         mn3hEOhs/UgSC76GpURx08S3wsW48nEgeH1Zea31dPXQ0BBBtgrQ6ixvnHi5iPQu7Z4S
         JS+/cGke7Jhv1fqwxETkmjejVkhcBckK9tpjEqF5OpjdLHu5vS9MmjiFcArynMJAQBMJ
         IrO84AHjnA3HQSJV1xgdMCTJrLf89ipCFa+8+lWh/22r5W8epIi/WgBHqayT9ObkEFjx
         Tezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585323; x=1781190123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4avmxi/DteAkFA5/0YsT4Z/7bVnyoihvSIvhh9yQxIo=;
        b=UfTbqhyPMl/40qF/KHPGbp51BhXXeP1kTjFd0vnTJx2JFHshIHtn95G0cS3S+8vHzX
         OGDUv/vCo1wp1PDWcwE0CMhmmbXr7lOMVp5Y7oEKJGzsUZmARIsMPvlt8C+mrHFqOuIu
         UlA8uZBEzXbaVtWxBh6W4tUFAvKq2bRlVrl38s5XoHrRzvLo3I8S5doOKEq02PD4RHal
         dZIUrdFABGqCbiehk7sg2ceHcD2MoQe/YXhaT6d/FPG/dYbYERJkSYRCSdRz5rpEjeFe
         oB1k5KEvBGpzsufFlXIlPJOKyAqnSMqXSPaG2MAdn2Bz16DITvmi0SUp6jvokcsNAAXL
         7PQg==
X-Forwarded-Encrypted: i=1; AFNElJ/dhKLa4Tb493XBxTh13SjTHwENCv6xYtcpTHDfQyOjzZ2auHrAVi1hb/4PYp9SMj+BzbNRy7s2pQ0m@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+laWsNZREV6lRS0Ibq2HP7sox1sY5Gsx1kAXsFyD4ZEQn+cPU
	7I01cPoo/UEWu+s9gHTdbF7q4GRbOkabCoH5qAy76TzEiyrDu19BhD7g
X-Gm-Gg: Acq92OGK4osRawTviZ16fDmPNpmt7KqXxni8RRvqhB8hZ7Ov5hX1zNcJpJtHG4jRGeP
	GafNg+wP48Sj8K0n9uv6ytTwvBiXEEWC2tpMjU6wXNnjx2yCpo44nNBeBP6p9IrKmH71YjU2vhs
	AdLj8JzMUp4xEm2/GlG5dBr2mGmtxL48SQOGNVf7uTfd3decT0vUBF8WrjUdZIt00NB1SIkLiJX
	14Rzt3D3rRUTV/6d9fiFpfCmNvsBOcwRvmHpIMsvlKuYX3yHIzv8EW43saiD3yUybx5OCUO3e8+
	dPM/C+ZmdCNAyCJG4IwODvV88Qt/j4qv0BTr/yfj9aIICRi7IdUnxNP2J+OYq7RevOn0yVVHcHb
	MiXpWGiKKSwVNUAp3Xq/tf3WdWuPrv0h0z4iiQcU2Htoh4bOBG8wL/MIh5f5MMfnArkeT1eOuI0
	G9eiu9d58JOXLc5mUjZOJa+2N2Sdp/GwfvSNZ3Bqs=
X-Received: by 2002:a17:903:37c4:b0:2b4:59bf:5728 with SMTP id d9443c01a7336-2c1644ca7bfmr89624145ad.25.1780585321320;
        Thu, 04 Jun 2026 08:02:01 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:55::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6e2adsm67111415ad.5.2026.06.04.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:00 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Subject: [RFC 04/12] PCI: Convert arch/powerpc to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:45 -0700
Message-ID: <20260604150153.3619662-5-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20506-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mahesh@linux.ibm.com,m:oohall@gmail.com,m:schnelle@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:ankita@nvidia.com,m:leon@kernel.org,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:kbusch@kernel.org,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:daskald@meta.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,shazbot.org,ziepe.ca,intel.com,nvidia.com,suse.com,epam.com,fb.com,meta.com,lists.ozlabs.org,lists.xenproject.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dimitridaskalakis1@gmail.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA1A3641634

From: Dimitri Daskalakis <daskald@meta.com>

Convert SR-IOV-specific is_physfn / is_virtfn reads in the PowerPC
PCI code to use pci_is_sriov_physfn() / pci_is_sriov_virtfn(). These
call sites are all SR-IOV-specific: they guard SR-IOV state
dereferences, VF PE management, or sit inside #ifdef CONFIG_PCI_IOV
blocks. Converting them keeps SR-IOV semantics intact once is_physfn
and is_virtfn widen to cover any virtualization type.

Files touched:
  arch/powerpc/kernel/pci_dn.c
  arch/powerpc/platforms/powernv/pci-ioda.c
  arch/powerpc/platforms/powernv/pci-sriov.c
  arch/powerpc/platforms/pseries/eeh_pseries.c
  arch/powerpc/platforms/pseries/setup.c

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/powerpc/kernel/pci_dn.c                 |  4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c    |  6 +++---
 arch/powerpc/platforms/powernv/pci-sriov.c   | 10 +++++-----
 arch/powerpc/platforms/pseries/eeh_pseries.c |  8 ++++----
 arch/powerpc/platforms/pseries/setup.c       |  4 ++--
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index a7b664befed2..cf44ec368a36 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -176,7 +176,7 @@ struct pci_dn *add_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return NULL;
 
 	/* Check if VFs have been populated */
@@ -221,7 +221,7 @@ void remove_sriov_vf_pdns(struct pci_dev *pdev)
 	int i;
 
 	/* Only support IOV PF for now */
-	if (WARN_ON(!pdev->is_physfn))
+	if (WARN_ON(!pci_is_sriov_physfn(pdev)))
 		return;
 
 	/* Check if VFs have been populated */
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 32ecbc46e74b..63eacc8001fe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -987,7 +987,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pci_dev *pdev)
 	pe = pnv_pci_bdfn_to_pe(phb, pci_dev_id(pdev));
 	if (!pe) {
 		/* VF PEs should be pre-configured in pnv_pci_sriov_enable() */
-		if (WARN_ON(pdev->is_virtfn))
+		if (WARN_ON(pci_is_sriov_virtfn(pdev)))
 			return;
 
 		pnv_pci_configure_bus(pdev->bus);
@@ -2379,7 +2379,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	struct pnv_ioda_pe *pe;
 
 	/* The VF PE state is torn down when sriov_disable() is called */
-	if (pdev->is_virtfn)
+	if (pci_is_sriov_virtfn(pdev))
 		return;
 
 	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
@@ -2391,7 +2391,7 @@ static void pnv_pci_release_device(struct pci_dev *pdev)
 	 * the iov state at probe time since we need to fiddle with the IOV
 	 * resources.
 	 */
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		kfree(pdev->dev.archdata.iov_data);
 #endif
 
diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
index 7105a573aec4..1113488f4372 100644
--- a/arch/powerpc/platforms/powernv/pci-sriov.c
+++ b/arch/powerpc/platforms/powernv/pci-sriov.c
@@ -225,7 +225,7 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 
 void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 {
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
 
 		/*
@@ -235,7 +235,7 @@ void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
 		 */
 		pe->pdev = pdev;
 		WARN_ON(!(pe->flags & PNV_IODA_PE_VF));
-	} else if (pdev->is_physfn) {
+	} else if (pci_is_sriov_physfn(pdev)) {
 		/*
 		 * For PFs adjust their allocated IOV resources to match what
 		 * the PHB can support using its M64 BAR table.
@@ -479,7 +479,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	/* FIXME: Use pnv_ioda_release_pe()? */
@@ -508,7 +508,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
 	u16 num_vfs;
 	int i;
 
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return -EINVAL;
 	iov = pnv_iov_get(dev);
 
@@ -620,7 +620,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 	struct pnv_iov_data   *iov;
 	struct pci_dn         *pdn;
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 
 	phb = pci_bus_to_pnvhb(pdev->bus);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index b12ef382fec7..32030ac9be51 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -54,7 +54,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 
 	dev_dbg(&pdev->dev, "EEH: Setting up device\n");
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		pdn->device_id  =  pdev->device;
 		pdn->vendor_id  =  pdev->vendor;
 		pdn->class_code =  pdev->class;
@@ -68,7 +68,7 @@ static void pseries_pcibios_bus_add_device(struct pci_dev *pdev)
 #endif
 	pseries_eeh_init_edev(pdn);
 #ifdef CONFIG_PCI_IOV
-	if (pdev->is_virtfn) {
+	if (pci_is_sriov_virtfn(pdev)) {
 		/*
 		 * FIXME: This really should be handled by choosing the right
 		 *        parent PE in pseries_eeh_init_edev().
@@ -731,7 +731,7 @@ static int pseries_call_allow_unfreeze(struct eeh_dev *edev)
 	if (!vf_pe_array)
 		return -ENOMEM;
 	if (pci_num_vf(edev->physfn ? edev->physfn : edev->pdev)) {
-		if (edev->pdev->is_physfn) {
+		if (pci_is_sriov_physfn(edev->pdev)) {
 			cur_vfs = pci_num_vf(edev->pdev);
 			pdn = eeh_dev_to_pdn(edev);
 			parent = pdn->parent;
@@ -779,7 +779,7 @@ static int pseries_notify_resume(struct eeh_dev *edev)
 	if (rtas_function_token(RTAS_FN_IBM_OPEN_SRIOV_ALLOW_UNFREEZE) == RTAS_UNKNOWN_SERVICE)
 		return -EINVAL;
 
-	if (edev->pdev->is_physfn || edev->pdev->is_virtfn)
+	if (pci_is_sriov_physfn(edev->pdev) || pci_is_sriov_virtfn(edev->pdev))
 		return pseries_call_allow_unfreeze(edev);
 
 	return 0;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 50b26ed8432d..8165ae9adbd6 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -778,7 +778,7 @@ static void pseries_pci_fixup_iov_resources(struct pci_dev *pdev)
 	const int *indexes;
 	struct device_node *dn = pci_device_to_OF_node(pdev);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return;
 	/*Firmware must support open sriov otherwise don't configure*/
 	indexes = of_get_property(dn, "ibm,open-sriov-vf-bar-info", NULL);
@@ -799,7 +799,7 @@ static resource_size_t pseries_pci_iov_resource_alignment(struct pci_dev *pdev,
 	if (!reg)
 		return pci_iov_resource_size(pdev, resno);
 
-	if (!pdev->is_physfn)
+	if (!pci_is_sriov_physfn(pdev))
 		return 0;
 	return pseries_get_iov_fw_value(pdev,
 					resno - PCI_IOV_RESOURCES,
-- 
2.52.0


