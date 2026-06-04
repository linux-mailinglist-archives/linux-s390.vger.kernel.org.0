Return-Path: <linux-s390+bounces-20513-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nA9kIHiWIWrMJQEAu9opvQ
	(envelope-from <linux-s390+bounces-20513-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:15:04 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C4D6414EC
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:15:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ZE4L28Je;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20513-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20513-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CAEF3116B4E
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A53446CB;
	Thu,  4 Jun 2026 15:02:19 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81E349CDD
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585339; cv=none; b=f4sRK3XpPfnwQ3mgSaXJ1A1RpRkBdHBZsXBPT1fDhgFbif/Ar6oiaTk2KpT1UkXnSicNsmxUTkrSVpXixJju5GUQ7Dp1xe8G51f9kVd9GL7rctYo0VLSDFmwnpJOG6X+iS2uGUrVFgK6/Yw1C6Y4wOHPPpUDXsMCBqq9BR+BYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585339; c=relaxed/simple;
	bh=kJuxLZf86ZqSbpShflnMOB+ctfigqiv/tAU0BzdYWQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btGkUmvyCzTtBEbGXbKRhGv3d2HrZ39EESI8/lW0cEXLEV68V+KTE7vV85GNfOQSKyLzvU5u6Mb4t3Do1wiE8vP88d0Cd2g0zoaMfUH5Zfi5JlzQgMwAmYYymrDpCBKNrsv+mcEziW0pHu9XepaeU4SzdosaL4ho7tsHGa62j5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZE4L28Je; arc=none smtp.client-ip=209.85.214.174
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf18c30bb2so5866335ad.0
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585336; x=1781190136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=ZE4L28JeEt98ayHhij68xyrTIzSZADSXw1H78H6XACnfN77KfmASyYpxz2i85zv9eH
         K207HApcjkHCgDJxr4+IUBcTIBUhSrdP2W/zkFjUq7dKzoBycAaimboEPaS89J9TdRsa
         pnA9eejyCG4KcNZzvholQGeuf0+E/aNgWeqgOIVW5o3E7H+AVohWONaO3VRSscq3zFh9
         w/MJjXaLU8PpKIi6eFq7oXkrAsvUDrJhyKbvkFt2E+4ndmK0KMye1xAfRD8S5kSZ1tgk
         UYzFW+tYMCIUhP2402jLKirvBZuB5B3RFQ+f9wXQ3smTpAc0Pg4m90m8avyHJk54HAFD
         vBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585336; x=1781190136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PAIcBy7MNrXi3sYH0OZZ5XdCzjkRdcl8LnKIR3KqnsI=;
        b=nd5KgG2GabZW6QHKTGRNaGhVfx+yWTnq0duDOGyWitDuwFp7sO7B+ioGc1sXtjjVGn
         DiqzOJCTMTwf1/7g1GECMXYyxPtxR49W7WLAS2NQ1zzX194zr4jr3VbgzBIhJqqxSo5a
         zQPzrqCTiC91jcCKXKPOOL8wHrVdBHQJ8B6Xcesy9K2FQWD0rz9Mvc5R4hMcBhVK5vKi
         dVxacv2KUT4mZAAUdSN3HzLBNS/FYOB/mBnYjzUTWwth+TskKQVt2miG4rWTN62wilyV
         Sz1wfKCe1SQjbwvIIHlpqCKpOTQC/WB/k/7HdhjEdy5XXmVnvzXyJesZ5iX5OMipB35z
         Nw4A==
X-Forwarded-Encrypted: i=1; AFNElJ9ocoUkuLuxqtoUJ2/53NIiOG/itvcGZNE7FsZKIpaKCgA8/bLJuMg7UaQx842BO1pBdgrJzPnqhme5@vger.kernel.org
X-Gm-Message-State: AOJu0YxtWe8VX0qoaVBRfstT2b/H24hokBzwh4wwHP5XEYFDxVgzPr+V
	5o/MMYvgdhc9gCMQe32ecPGXGCXAxABttOw0uGm3TL+9qYcV2yMh1uT4
X-Gm-Gg: Acq92OG2II1dRQarM7J7Y5xYxIqvj8jE2n8RhlqLk1y6or0Pu2wpHA+19fQaggz1ock
	soCmq/veEv7Tmf7Dx6/7olv9MHHJEMX95PWfoDcvtKJOigxmLcvYHe1oadoMDYa/ieJPeqRW7v3
	RHwHaFL7gofEhaWqbfdAaFFz0dg5eeShW9o++LhTpznL1JDYkQ4rFlMluPOVVpIgTi+sW1W6dlc
	uf48rdHfbny9t/6yaL8IouMJ7ZrjxYCuUUYJIXwwxmyYVxLEtCIPdaRUVOT9lVr1CaGLl/XJJp0
	9oU+nD0os8onqp2b5p4o8P8jw1H9DNpCH5GfSDlypkP+8j7g85pU3k7a61xibB3QQtyoW9UVtrW
	RieDjatdT5SwqFwgm3qEGRxcX2KKLX+ZzyJYsHc1vKn5FwXlHUM1QzgObSGtR5JJLHRTba8jez0
	vZScQMvaacCLNwuBMYcsfbpSqGdlxktPDm5ptDZs0=
X-Received: by 2002:a17:903:3c45:b0:2c0:bb2d:a30b with SMTP id d9443c01a7336-2c1644ae17fmr84740035ad.32.1780585333563;
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4a::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm64303575ad.54.2026.06.04.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:13 -0700 (PDT)
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
Subject: [RFC 11/12] PCI: Initialize and release SIOV capability
Date: Thu,  4 Jun 2026 08:01:52 -0700
Message-ID: <20260604150153.3619662-12-dimitri.daskalakis1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20513-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mahesh@linux.ibm.com,m:oohall@gmail.com,m:schnelle@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:ankita@nvidia.com,m:leon@kernel.org,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:kbusch@kernel.org,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:daskald@meta.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,shazbot.org,ziepe.ca,intel.com,nvidia.com,suse.com,epam.com,fb.com,meta.com,lists.ozlabs.org,lists.xenproject.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dimitridaskalakis1@gmail.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38C4D6414EC

From: Dimitri Daskalakis <daskald@meta.com>

Modify pci_init_capabilities() to discover the SIOV extended capability
(cap ID 0x38). When present, allocate struct pci_siov that records the
capability position, total SDI count, routing ID offset and stride, and
the maximum bus range the SDIs can span.

The init path mirrors sriov_init(): read the capability registers,
compute the worst-case bus consumption from total_SDIs, and stash the
result in the PF's pci_dev. Release frees the structure on teardown.

If is_physfn was already set (by sriov_init), it will not be cleared if
siov_init() fails. This prevents clobbering the flag for devices that
enable both virtualization types.

The SR-IOV code does not unset the is_physfn bit of a pci device
when disabled, and the SIOV code follows that pattern.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/Makefile |   1 +
 drivers/pci/pci.h    |  16 ++++++
 drivers/pci/probe.c  |   2 +
 drivers/pci/siov.c   | 113 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 drivers/pci/siov.c

diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 41ebc3b9a518..a584cd1bf08a 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
+obj-$(CONFIG_PCI_SIOV)		+= siov.o
 obj-$(CONFIG_PCI_BRIDGE_EMUL)	+= pci-bridge-emul.o
 obj-$(CONFIG_PCI_LABEL)		+= pci-label.o
 obj-$(CONFIG_X86_INTEL_MID)	+= pci-mid.o
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd7c04e26c16..a516db996aab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1042,6 +1042,22 @@ static inline u16 pci_virtfn_routing_id(struct pci_dev *pf, u16 offset,
 }
 #endif
 
+#ifdef CONFIG_PCI_SIOV
+int pci_siov_init(struct pci_dev *dev);
+void pci_siov_release(struct pci_dev *dev);
+int pci_siov_bus_range(struct pci_bus *bus);
+#else
+static inline int pci_siov_init(struct pci_dev *dev)
+{
+	return -ENODEV;
+}
+static inline void pci_siov_release(struct pci_dev *dev) { }
+static inline int pci_siov_bus_range(struct pci_bus *bus)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PCIE_TPH
 void pci_restore_tph_state(struct pci_dev *dev);
 void pci_save_tph_state(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index b63cd0c310bc..bebc32c8d374 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2473,6 +2473,7 @@ static void pci_release_capabilities(struct pci_dev *dev)
 	pci_aer_exit(dev);
 	pci_rcec_exit(dev);
 	pci_iov_release(dev);
+	pci_siov_release(dev);
 	pci_free_cap_save_buffers(dev);
 }
 
@@ -2666,6 +2667,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
 	pci_iov_init(dev);		/* Single Root I/O Virtualization */
+	pci_siov_init(dev);		/* Scalable I/O Virtualization */
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
 	pci_pasid_init(dev);		/* Process Address Space ID */
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
new file mode 100644
index 000000000000..7372ce95714b
--- /dev/null
+++ b/drivers/pci/siov.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Express Scalable I/O Virtualization (SIOV) support
+ */
+
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/export.h>
+#include "pci.h"
+
+static int pci_siov_sdi_bus(struct pci_dev *dev, int sdi_id)
+{
+	if (!dev->siov)
+		return -EINVAL;
+	return pci_virtfn_routing_id(dev, dev->siov->offset,
+				  dev->siov->stride, sdi_id) >> 8;
+}
+
+static int compute_max_sdi_buses(struct pci_dev *dev)
+{
+	struct pci_siov *siov = dev->siov;
+
+	if (!siov->offset || (siov->total_SDIs > 1 && !siov->stride))
+		return -EIO;
+
+	siov->max_SDI_buses = pci_siov_sdi_bus(dev, siov->total_SDIs - 1);
+	return 0;
+}
+
+static int siov_init(struct pci_dev *dev, int pos)
+{
+	struct pci_siov *siov;
+	bool was_physfn;
+	u16 total;
+	u8 status;
+	int rc;
+
+	pci_read_config_byte(dev, pos + PCI_SIOV_STATUS, &status);
+	if (status & PCI_SIOV_STATUS_ENABLED)
+		pci_warn(dev, "SIOV: SDIs active at init, FLR may be required\n");
+
+	pci_read_config_word(dev, pos + PCI_SIOV_TOTAL_SDI, &total);
+	if (!total)
+		return 0;
+
+	siov = kzalloc_obj(*siov);
+	if (!siov)
+		return -ENOMEM;
+
+	siov->pos = pos;
+	siov->total_SDIs = total;
+	siov->driver_max_SDIs = total;
+	siov->self = dev;
+	pci_read_config_dword(dev, pos + PCI_SIOV_CAP, &siov->cap);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_OFFSET, &siov->offset);
+	pci_read_config_word(dev, pos + PCI_SIOV_SDI_STRIDE, &siov->stride);
+
+	was_physfn = dev->is_physfn;
+
+	dev->siov = siov;
+	dev->is_physfn = 1;
+	dev->is_siov = 1;
+	rc = compute_max_sdi_buses(dev);
+	if (rc) {
+		dev->siov = NULL;
+		dev->is_siov = 0;
+		if (!was_physfn)
+			dev->is_physfn = 0;
+		kfree(siov);
+		return rc;
+	}
+
+	return 0;
+}
+
+static void siov_release(struct pci_dev *dev)
+{
+	WARN_ON_ONCE(dev->siov->num_SDIs);
+
+	kfree(dev->siov);
+	dev->siov = NULL;
+	dev->is_siov = 0;
+}
+
+/**
+ * pci_siov_init - initialize the Scalable IOV capability
+ * @dev: the PCI device
+ *
+ * Returns 0 on success, or negative on failure.
+ */
+int pci_siov_init(struct pci_dev *dev)
+{
+	int pos;
+
+	if (!pci_is_pcie(dev))
+		return -ENODEV;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_SIOV);
+	if (pos)
+		return siov_init(dev, pos);
+
+	return -ENODEV;
+}
+
+/**
+ * pci_siov_release - release resources used by the SIOV capability
+ * @dev: the PCI device
+ */
+void pci_siov_release(struct pci_dev *dev)
+{
+	if (dev->siov)
+		siov_release(dev);
+}
-- 
2.52.0


