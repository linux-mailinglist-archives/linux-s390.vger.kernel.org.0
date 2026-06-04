Return-Path: <linux-s390+bounces-20515-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J5v7ARyWIWqpJQEAu9opvQ
	(envelope-from <linux-s390+bounces-20515-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:13:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735064149D
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:13:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=M17E2NDd;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20515-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20515-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E3EF316D101
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FE3314AC;
	Thu,  4 Jun 2026 15:02:28 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4715433066D
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585348; cv=none; b=rTPR2aKxr6yeZ5bvFGeTBpALKDOnpklBYIVQ9sBCmBJsvKGch53ajx3DMnrcgszHSzSJkHQ1sqtvyjyu99ya0Dk4dJ5NLKKfHZ7SRMrGb1PgltiurXvWro4Uy6IM6LB9smk/Gj7/MnogY03Z8HVEcdEXrGOV3VdBHUfCVl5hXB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585348; c=relaxed/simple;
	bh=ZJl9Mt7FKyzs5qgOjy9m7k+4Cm+afJHGMPi8nILaAoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4CfNGEFFdvzzv12VRkBawC0HsONmskJqOp3P61E2pTF+TZbB1pg2zFSrMb288cN7B0mtmaVLOuH5sNbIxa4n+N0rLo4TtNXsaVUAjlM5u3FEJsvcNK4XF6Fr3B9Q6D0rJEAvqMoW83fYY/IJiECCvl8D5HUinUF7EbPTGqTdF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M17E2NDd; arc=none smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517654b8dc5so7833561cf.3
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585346; x=1781190146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=M17E2NDdHvZZml1HOJXbmvUVxQMevwB/U8d1gNhi5WKW5efuipLuXmbbVbm42Bz8E5
         p8MsL5EmVoLfTfNJGMjrYkPUJAHYDBrddf2agndvs/030rNFZZRBoj2kDotvL0gLsQGr
         +XvlyUSl5mDcSf+NAfFMmCAObNFoJeG8Nmhs31pqSJay5a+wkzaYZWrwXN35cpnzL8G4
         mGce3Q8UlmKfkahq+fBbh0BD1hZVfUiBWeZgdCuTyeIljgXQ/90nUwXFE63k9/XN3lFf
         qE6KjcrLs8HHmtvYyIsjwNHxSdsWP4QCeoJreKHlbxJbRMqfOQ3Mk+xvorNk3uvJCieQ
         KXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585346; x=1781190146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xRdDzAJ66h/qKzlMtNZ7QYJac4Hlkm37yqxsR8KWCKU=;
        b=hnx8hJE4IVE/K6NS04QF3Pu559ZsD5JDnx2bFLZ0ToZWWg1fGVOM9420HeFnToJMgC
         BNjX0aJpPeBiKT/vN/BgdiRfHYwJdxBIb/DobSMpm4JWdwvs69tWaOo7dwTlMERXHutz
         36lWHJWWjUqAWMgpe17r2Vr7jkVyeCadEmKqCbEiolbcYFibSeqcW4DMglGXVhHyX65+
         eR5d9LGYrB2anwO8EbHcYvWzY6FWebP8RSvbgUDHxsKh720+PR7LljBKTcE6DEPlnctI
         yDLgbnpiqRL8suUyK9jf6+0GhFvF9VF13wgEAk4nuEdZbPHcYjl5+X+OdfrptMYbUAty
         l2NQ==
X-Forwarded-Encrypted: i=1; AFNElJ9u7bu1NLeGCytxHFxbbBo8jAjBlBmzZpL7VWoS/iCr864QNHBLlnSWCu3TLBwUFbp7gvMuicQ2paI7@vger.kernel.org
X-Gm-Message-State: AOJu0YxPsQQyulVYfU6Iip/BiNRrWgVtSvRNDCLx1CI45h0tfeUmPP6M
	FaBws+lP41cAJ1uj8IwqFcJraQbyEZnwGBjfQoe6htq6L8DJDoMim2ymclbS8Q==
X-Gm-Gg: Acq92OGCvvVkz5zZkYkAR+y/G14yMyGuZsx4X75gZJJhiscEhbky/C6iHbI39yqFGwV
	wRvENfVkphzxkNHRhIVRwOKf8wFdu00+juQ1rTTLS4sA+Rh6ezxjCThU3xeQ/BwYcjMJuIgGHWe
	+FNYqMk+JhZTyer5b1PME0AqlbLyogB2X4PjQerXXnsa3glHQ/9W0USTbcT9+KbQK2JZ+DpNu/Z
	zu5BTkLvtqhqtx7uX9KkuR0P6UUsR1tPK2n0EC4Vs5gL6rrX0YeVdyC7rfX2UzvoM9BDRXVm+an
	8dI7yMU08kwX6yv0EtpvQ4RE01Yw/NThJfTCxz8VWi1sNN7VUJArqvU+CkBqJzWUi8cDBt2J20i
	TKXpw4jBpFXst/2OefyNeUXFxpD8eY+kNsLLqf10MN86EqZg+ehu/OPAMRF2Q1+H9tBsFFBjWhq
	n1II2AxsN2jVe2g7Dfs45VTzbRohbGcug45b8v//8=
X-Received: by 2002:a05:6a00:218e:b0:842:5ad6:2d3 with SMTP id d2e1a72fcca58-84284ef2c41mr8159937b3a.38.1780585335784;
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:51::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291a837sm6331464b3a.60.2026.06.04.08.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:15 -0700 (PDT)
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
Subject: [RFC 12/12] PCI: Reserve bus range for SIOV devices
Date: Thu,  4 Jun 2026 08:01:53 -0700
Message-ID: <20260604150153.3619662-13-dimitri.daskalakis1@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20515-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mahesh@linux.ibm.com,m:oohall@gmail.com,m:schnelle@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:alex@shazbot.org,m:jgg@ziepe.ca,m:kevin.tian@intel.com,m:ankita@nvidia.com,m:leon@kernel.org,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:kbusch@kernel.org,m:alexanderduyck@fb.com,m:kuba@kernel.org,m:daskald@meta.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:xen-devel@lists.xenproject.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,shazbot.org,ziepe.ca,intel.com,nvidia.com,suse.com,epam.com,fb.com,meta.com,lists.ozlabs.org,lists.xenproject.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[dimitridaskalakis1@gmail.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,meta.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9735064149D

From: Dimitri Daskalakis <daskald@meta.com>

SDI routing IDs are computed from the PF's devfn plus an offset and
stride, exactly like SR-IOV VFs. When the stride pushes routing IDs
past the current bus number, additional bus numbers must be reserved
during PCI bus scanning to ensure the SDIs can be enumerated.

Add pci_siov_bus_range(), which walks all SIOV-capable PFs on a bus
and returns the maximum number of additional buses required. This
parallels pci_iov_bus_range() for SR-IOV.

The bus range is pre-computed during siov_init() by computing the bus
number of the last valid SDI.

Note: The PCIe 7.0 spec outlines an alternative RID assignment
algorithm for SDIs. The spec states a Virtualization Intermediary
(likely a hypervisor) after boot can compute the set of RIDs that are
valid for SDIs. There is a six step algorithm to compute this
RID allowlist. To keep things simple, we are only adding support for
strided RID assignments.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/probe.c |  4 ++--
 drivers/pci/siov.c  | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bebc32c8d374..9ef6827ab345 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3100,8 +3100,8 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	for (devnr = 0; devnr < PCI_MAX_NR_DEVS; devnr++)
 		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
 
-	/* Reserve buses for SR-IOV capability */
-	used_buses = pci_iov_bus_range(bus);
+	/* Reserve buses for SR-IOV and SIOV capability */
+	used_buses = max(pci_iov_bus_range(bus), pci_siov_bus_range(bus));
 	max += used_buses;
 
 	/*
diff --git a/drivers/pci/siov.c b/drivers/pci/siov.c
index 7372ce95714b..6405a8830052 100644
--- a/drivers/pci/siov.c
+++ b/drivers/pci/siov.c
@@ -111,3 +111,24 @@ void pci_siov_release(struct pci_dev *dev)
 	if (dev->siov)
 		siov_release(dev);
 }
+
+/**
+ * pci_siov_bus_range - find the max bus number consumed by SDIs
+ * @bus: the PCI bus
+ *
+ * Returns max additional buses consumed across all SIOV PFs on this bus.
+ */
+int pci_siov_bus_range(struct pci_bus *bus)
+{
+	int max = 0;
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (!dev->siov)
+			continue;
+		if (dev->siov->max_SDI_buses > max)
+			max = dev->siov->max_SDI_buses;
+	}
+
+	return max ? max - bus->number : 0;
+}
-- 
2.52.0


