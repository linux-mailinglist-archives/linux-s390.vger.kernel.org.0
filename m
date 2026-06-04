Return-Path: <linux-s390+bounces-20507-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9S9sMV2WIWrCJQEAu9opvQ
	(envelope-from <linux-s390+bounces-20507-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:14:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A846414D0
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:14:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=B6zK7eQi;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20507-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20507-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C57373056AD2
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABDC340280;
	Thu,  4 Jun 2026 15:02:07 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC53733ADA9
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585326; cv=none; b=eTyk8f5e5kSrsrsjoT9hQ0Rr4380TqclRaz6zXSdSh0kZA0AShjRYiulqTLUKAb38oGNbfC92DxfnYTO1jT36btu4nQ52ln8u97R31tXa5KJQZ3Iu/+IfsaZNehwBKqKbNIOLpXFcbjrofgmOo3r0A1G+qg7vv2+gzhZCW7CrgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585326; c=relaxed/simple;
	bh=cqs9K7t4GQhb0P+3IHmoEk0x+onZANKdAYdq39+2FfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2q1AeO+Ew0vWNM7j9oWYrx2ssbjA+nCa3TOQu9VG3aLqLm7oTDe57PIN9u1gs3wWf0V5vAGZkh4a4teO+UagtDQ4gD2uwU0IbvxRSJ+Bca9dp3EDry7SsDUMLKdfB+BPQwEt+nrzmy+65p1r0AVmyteSyXp+jpPCGS6OB0NxBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6zK7eQi; arc=none smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so6658465ad.2
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585324; x=1781190124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=B6zK7eQictW3fAUM4jAzEEB+yAH7NNWN2g0hn0aAIitgPDjIVqk/6sTmckthM7D5rb
         vEh/Y88xV8f3o7rFhWfMLeRz1Jaol+CJBZG8707e6rs3OlVkpoeGDOZA8B5lwfPNpDRE
         ahSQbWDU248xGywWirIx1jMp845aaeb+d/hCfq/8W6ihFJJkU/w+QcjVXwabCyaZ8sRe
         TL7I0mpz9z04KTWnfUDwycZF3tj616BHeSETGHdcRGoDkS/R/5+r7xMYa3sxL1fGX1sp
         hUHU7PIXlgk6jXAXyW7A9dQvDKQdRcaG3CcPjRbsKqQiM9G9LYp0W9o6KZ9oP8E26MD2
         3HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585324; x=1781190124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZHMOC3ymQk/hCIs6rXv5bV3psfV3xxIvT+fp4eN0Hg=;
        b=aAcHv6OmV9t1RlzeC/a2kQGZjQoQ1JTf7yubSBt2XfNHR9BkGjw0YHSWc6Fn9tfUvh
         vfFneJKIUrCwN+mdtP0m5l5PVA6XcFaKAWI1rOLuwggzVwtNn63fLBuukSliZLt69nl4
         frgQzve63BeX8lLUuXB6G4JjPOD6Wm/lm0zah40j/H4oP5KQPNAMmEv4BV7yJO4OWwPo
         ig9+sdDcAJFIxvHOZe6dJayS5uTL2oCUxXRWuACD7XfmxQbQOhI2G4bXylRi3EBfpA97
         uH18X/jDGHX90CfiQ4o91fE3cNehT6juIpqAaiUg+dc556zB5DAC+2oMXTKU8Kq7kW79
         Pwlw==
X-Forwarded-Encrypted: i=1; AFNElJ+rlfgdQnIIflSI4kK2GcYwhgJW8Sz5GhXaHuutJYSNzAqmF6WWM4bvM77tz8pnfXV2nhW3jNCMLENe@vger.kernel.org
X-Gm-Message-State: AOJu0YymrXkIcETCzAYLjULzW2gH39OuAhPXOVXll8Gwm8KBUSjdTFFB
	DsqwS22TIfVWilekP6IZjD0+NOPnlYSPo/vagbcIShU6IGv5/VfM2m7B
X-Gm-Gg: Acq92OFf3r8XTWaWkPbmhreDN36vCxnA7ptHNEEm8PckT3Boiu29hVTJ798xdMn0p36
	NIzL7cLG+D3owk+IYt5csX6qmgMK6AJ0b6+2n1pSMvXOglEEhn49ogGYwCxOMJMjCY5ysSCWf2z
	9Mtso9/e1SoLx0Doisw2fw1l+b7uLulAszRLfzGsc7vWbtnVvX8/GguJDGUJ/Z4n+LqBgTWb4ww
	1czvRhoSoHVccL8ICl0ot1kVtFPe1oCvToNLOBkYKkKRJh3JH1ZoMOMCCYyCq/rpwGq/0KmPbKd
	gpSf1bx2Nesgx+C7xHQOpNzMaLchkSUmT9Vf5cwEBcX+i6rg3ejdfBxLC5a3A75WxV+djvseCpB
	rk//0g08bcSq7d0Yh4WfPmO3T9PoMNCbqePGTWebTUY1aFdsIdqMrUBOvMSXCHbIjpVk68KxZoe
	CQFwKjTsFWwR095awHIOwXUvSRQiLzkyl0GCyyOlg=
X-Received: by 2002:a17:902:be03:b0:2bf:13b0:f8ed with SMTP id d9443c01a7336-2c163a28b4dmr55201165ad.3.1780585322733;
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:54::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm64224585ad.82.2026.06.04.08.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
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
Subject: [RFC 05/12] PCI: Convert s390/pci/pci.c to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:46 -0700
Message-ID: <20260604150153.3619662-6-dimitri.daskalakis1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20507-lists,linux-s390=lfdr.de];
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
X-Rspamd-Queue-Id: 60A846414D0

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 arch/s390/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 39bd2adfc240..5e6f600bf60b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -611,7 +611,7 @@ int pcibios_device_add(struct pci_dev *pdev)
 
 	/* The pdev has a reference to the zdev via its bus */
 	zpci_zdev_get(zdev);
-	if (pdev->is_physfn)
+	if (pci_is_sriov_physfn(pdev))
 		pdev->no_vf_scan = 1;
 
 	zpci_map_resources(pdev);
-- 
2.52.0


