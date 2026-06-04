Return-Path: <linux-s390+bounces-20502-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x9hXKvSXIWo7JgEAu9opvQ
	(envelope-from <linux-s390+bounces-20502-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:21:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4126415E5
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:21:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Yj1an7iZ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20502-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20502-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 522DB314DD43
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD35316189;
	Thu,  4 Jun 2026 15:01:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B758311C2C
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:01:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585318; cv=none; b=mmmFcIN0KnHIUXfe/xvR6vNEieUlulqwdOnCsXfBOWyWcUzLNnIvWDoqpT3rnNO2OM+LgjWWGMb/VJLFc9E9xFHzbYo/4q+zIVpJVn5oo+y+aXI19gfCT1K1wQYOOPG/kE3JBpOetZyWz2ZC6LAvv2truivTAbomng4YPBAJLEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585318; c=relaxed/simple;
	bh=HbyMcDJBxgMyD0bzqWOlRDkmSTFj0tM83CqcfOeBGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rft9WzlciONDv3kxkuwkE7IFQyJn3gMvMyyUuhkNJR87La2FE5c1Hpy0CEC4ny52uDcg3g4HyRyatgfN8wELlFo+rqIjTSimRZr+/XHi6aSgvbTB5B/+0wGLs3MIxOU8+c56tAj6hRe7+fBIc53mVGu9t1zru4XcJ5vzX/4+PPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yj1an7iZ; arc=none smtp.client-ip=209.85.216.51
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36bd175fdbaso570141a91.0
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585316; x=1781190116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=Yj1an7iZbQ0joBr5jket5MeFeS+OhrVXqU4lX/spTT2xwFsiCRxhLFGNduO/EVbZVV
         QoL+crZSitKQWlOJAsxgf5jfuiAaucs/Oif4mSzJu0EuV2uOkuotLlkKWLep2eaKz+2E
         o/lXCKmkzsImUCSyXHu0c2f5PyzEA0uv9Lm4IulM+/c9cUZb7oXXTZJuzKVinCPyg+jc
         DU5BlJW5/lj82NJCUncDq02cv3tuYUu7fUuh2+ehNlMwB4BAX9cgopQBnSseAcAzR4pi
         gnrRUG3AUd5OczvgOWXC8fjD1MWYPi8lX7ClWYmDHwg9j8a7G3Z0k6WExfefdkBqnrj+
         gy/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585316; x=1781190116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u02hzxNTDDgX0UOR1yiCb+UilA+qxlSoulScblTnv2M=;
        b=Wk69LwrHbVlIH+c8h0/aVZvh462OxlJDBi3/Tbb1dORwXjYCQ8KDINnamJVgkPKy1x
         F9Dc45+YQjCC96qSVRa9FFoagbu+xCTAb7cEMasjnmmSKmzSYXEfp+yuyyxpNnAuFO0c
         aH5qdbLsqv6d9xqgDmOq455F+ngPFXvOMSsgAO5Y3H6s2MZc61JmIeUFRDxI4W7GNWWw
         tlItr4wXE74PyjJOCfeU/juCw7ibAeBoVxtaEoAZ1SRP6RgHrw4da5PwWYgqwok6F5wR
         sdmp9rVLJ3LZHSWolJFRhcCCA2RN36ep5zrMHKRYlD/0MteszDzSLMnaAVRma8Wwzmo9
         aT1A==
X-Forwarded-Encrypted: i=1; AFNElJ9EKZHOhQNjiAY/YKpCOgpiBCbIVDCCWyNiBdiZ0EKaeW2/rH9vingeaznEX/cWVpeXIKNT/TpZ1W/X@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj/cUez4FLey+Lx8aT8DgWu5aqnTf3QnSP/CLZ7JDLyt8/c42j
	DN5m+Yytns0XqBFXQnt0gvyMoMZST+j82/qn5OO9evdjoTENUktoaosE
X-Gm-Gg: Acq92OHfzHYeGwTxVUVj8yVHmd/RCS9l+Td5R4N7U1jJ/CrM5eHqaPAgoMQD19nHadH
	F+fNMoMmK5yCWW2YgpTKpPyUmi7wqAGkP38uMubdyMAECfEZleenVM8SQV+wT7+DVQbHwx6xk/6
	S3XiUt3LKqlmSvsQEKU5HivDKBjO1R18LlNksJGDSNVZ5agSzK+g5mpxjbK/fdz3fSwOCYDz41T
	lD9IcKBAtH8aX1kfdbTzB6CKMFxofn/KJxvb2FHJkODxQ3L5ws1+u+82xRg9IP77kN6gmDaehRJ
	UtgA+AV1MTBmgFG/Uk21T6MECCLAr3hGCrd78WqvRo80Ogbil5WF1FFRKnrTn/qnEWTxZX9UPfu
	LRVViMf6Tb0k7+FQBlVXLGl7QFjP0vyFFgYDuWTSZCEfgSzsvGAEAskHLyT71yTRdQzVRfS0pUK
	7kCK5ZW+AYHJlgSfXVP0f6m6XsMaypKcOoVIcmsSaxEpXuxgh0
X-Received: by 2002:a17:90b:2d8d:b0:36b:e8b9:46a4 with SMTP id 98e67ed59e1d1-36e32285cf3mr8241830a91.14.1780585315438;
        Thu, 04 Jun 2026 08:01:55 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4f::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0be0f0sm5020782a12.30.2026.06.04.08.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:54 -0700 (PDT)
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
Subject: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Date: Thu,  4 Jun 2026 08:01:41 -0700
Message-ID: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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
	TAGGED_FROM(0.00)[bounces-20502-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pcisig.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB4126415E5

From: Dimitri Daskalakis <daskald@meta.com>

Scalable I/O Virtualization (SIOV) is the next-generation alternative
to SR-IOV. The goal of SIOV is to support more virtual devices than SR-IOV
can currently support, while relaxing many of the HW requirements of SR-IOV.

SIOV VFs are referred to as Scalable Device Interfaces (SDI). An SDI has
a unique PCIe Routing ID (RID), but has no configuration space, BAR,
or MSI-X table.

An overview can be found here:
https://pcisig.com/PCIExpress/ECN/Base/ScalableIOVirtualization

Since SDIs lack HW support, the complexity will fall on software
(hypervisors, vmms, drivers, and/or firmware) to provide the same isolation
guarantees for SIOV that SR-IOV has today.

This patch series is one step in that direction, allowing the PCI subsystem
to discover the SIOV capability during enumeration. This was the minimum set
of changes needed so I could test the SIOV feature of developmental HW in
emulation. I have not tested a device that supports both SR-IOV and SIOV,
but this combination is allowed per the spec.

SIOV has two ways to assign RIDs, strided (like SR-IOV) or software assigned.
To support software RID assignment, you need to compute the RID allowlist
after all PCI devices have been enumerated. I've deferred this complexity
for now and only implemented strided RID assignment.

Patch 1 adds helpers to identify if a PF/VF is a SR-IOV PF/VF. The PF and
VF bits within struct pci_dev should be agnostic of virtualization type.
The helper uses the current logic which assumes any PF/VF is SR-IOV.

Patch 2-7 uses the new helpers throughout core. I didn't convert certain
device drivers (drivers/net, drivers/gpu) because the devices will not
suddenly start advertising the SIOV capability. These can be updated in
the future if desired.

Patch 8 tightens the helpers introduced in patch 1 with a new is_sriov bit.

Patch 9 is a small refactor for computing VF RID which can be shared
between SR-IOV and SIOV.

Patch 10-12 add SIOV definitions, capability detection, and bus reservation.

With this patchset core enumarates the SIOV capability and can identify
SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
To support device pass through, devices will need to add a vfio-mdev
driver with IOMMUFD support (or something similar).

Dimitri Daskalakis (12):
  PCI: Add helpers to identify SR-IOV PFs/VFs.
  PCI: Convert iov.c to pci_is_sriov_* helpers
  PCI: Convert pci.h to pci_is_sriov_* helpers
  PCI: Convert arch/powerpc to pci_is_sriov_* helpers
  PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
  PCI: Convert vfio_pci_core.c to pci_is_sriov_* helpers
  PCI: Convert xen-pciback and pci-driver to pci_is_sriov_* helpers
  PCI: Add is_sriov bit to struct pci_dev
  PCI: Add helper to compute VF Routing ID to pci.h
  PCI: Add Scalable I/O Virtualization data structure definitions
  PCI: Initialize and release SIOV capability
  PCI: Reserve bus range for SIOV devices

 arch/powerpc/kernel/pci_dn.c                 |   4 +-
 arch/powerpc/platforms/powernv/pci-ioda.c    |   6 +-
 arch/powerpc/platforms/powernv/pci-sriov.c   |  10 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   8 +-
 arch/powerpc/platforms/pseries/setup.c       |   4 +-
 arch/s390/pci/pci.c                          |   2 +-
 arch/s390/pci/pci_iov.c                      |   1 +
 drivers/pci/Kconfig                          |  11 ++
 drivers/pci/Makefile                         |   1 +
 drivers/pci/iov.c                            |  58 ++++----
 drivers/pci/pci-driver.c                     |   4 +-
 drivers/pci/pci.h                            |  43 +++++-
 drivers/pci/probe.c                          |   6 +-
 drivers/pci/siov.c                           | 134 +++++++++++++++++++
 drivers/vfio/pci/vfio_pci_core.c             |  12 +-
 drivers/xen/xen-pciback/pci_stub.c           |   2 +-
 include/linux/pci.h                          |  29 +++-
 include/uapi/linux/pci_regs.h                |  12 +-
 18 files changed, 289 insertions(+), 58 deletions(-)
 create mode 100644 drivers/pci/siov.c

-- 
2.52.0


