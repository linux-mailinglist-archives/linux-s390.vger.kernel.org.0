Return-Path: <linux-s390+bounces-20505-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hcXxK4CWIWrRJQEAu9opvQ
	(envelope-from <linux-s390+bounces-20505-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:15:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DF6414F8
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 17:15:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XA4Ry5ci;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20505-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20505-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 484CF312B86A
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 15:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AED53368BF;
	Thu,  4 Jun 2026 15:02:03 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A56329C71
	for <linux-s390@vger.kernel.org>; Thu,  4 Jun 2026 15:02:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780585323; cv=none; b=UYNi/k52bP7GCphV0txeJSjIP5TCvcWcXhejUtlQg/dkHcju4cSnCEYBP6zWNqXzFkQXPT0fkxFADR3/IXtjFekFRibwBRthQCGdgUeWmElfYbsCqux+c+cNnlPHfFGdxywi9ekSM02FgjxpgfXwfD2rnROlgojX7+OkZZTnY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780585323; c=relaxed/simple;
	bh=lmjqe+wz2MLmpS3qsZR8wvfKLvk3gZM+AULrTz1+wsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHV5MDC+bBivrXwxVmeitvZmHlcDFeQ17ZJoQKTnLd35mezpnRFg9SrSZ82iHHtYDgs8F8G4rCz7edJgKk2/kYCDOUfmerUPO+jq+urmd0pkLX9T2MMW/ZwTJuaWmDuVgMVEf4PPZM3ti49ON257w4DO7Fi/02T4ID8UTJTyl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XA4Ry5ci; arc=none smtp.client-ip=209.85.210.178
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so462062b3a.1
        for <linux-s390@vger.kernel.org>; Thu, 04 Jun 2026 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780585321; x=1781190121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=XA4Ry5ciTsxosLc4NggAo2/LVj83bLmwFT8IiJgILcLqY/MMpeQ5QT9BPLFzeJsdzr
         KORDK7r1iMjwe3MF2c8S1TXip5PiWsQN7CpgOpOKkUiEeKLf4S9OzfyqqjJlsN0C4wiq
         qL/AlH5yD1vUBHHCZJrf2wE3J4i0r6G6cUv16bR22y7xJmvmewOyJf3HWxQd6vX0NQoW
         nv2cqM6RQgjKI/fUHAEC15Po1YtKzNff7rjHckN74xDVhVmITG2Mp8MGyE85zFHJUh9b
         4h/Ced+ztJqMc8Qdp0y5TO28L5hTnzrLQc+VONN32yKEez2tQ+SHY/S4WB7JvcyRlAuy
         DPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780585321; x=1781190121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xxHR67fZ2aTWHsPIWuXVLfBkGwXwQ/JLm/nLvvGQPDw=;
        b=dZWbcvtSo4bXROONPtYEXwMOJAZV+R/e5AsfSbx1xaMcbzOZ/IVymia3UYtTcyBVRL
         oJjuxupcspPydZjX3FQA/ZrOQ6lN/Drdl8NoGoECFRbEG66zNIUUdZSa7wpjU/RhLxcm
         YJotevh55fkOMVcW9J+uUjSGztYucyd65genczcd+QVXb+0R24RhnZ9DfeBpiUUQVY6n
         XS8oXVM/crcbN/cN2m4mhufkfhcN8VTY2832szq2g8af6VUnI6VDJ5E/3m2SS5jMEom+
         eDDn0Rbs0QeOrBnTYB3LqQ7kYSuFvD0A0ud2gveLo3xBzLqphxVg2Vtl7HsHpRZgqumt
         nkSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6RusOrhY9R9NQsZDD0CefTicQr62vi7QQbpvaxsV5y2HDXP3r5jY18CioXsR3KN4Se4CjKlbWRtJ2@vger.kernel.org
X-Gm-Message-State: AOJu0YzceN02vOMXqVNFccBmpttvtSKSODG7jD+ap/9C+EKiV+cPZhfI
	hrC0eB+Sswmj9yfZp4XpZCM+xziGOfmdkLFn4KfSQBoYUhYAxcGI02Cp
X-Gm-Gg: Acq92OG1pPJBrYrTvSsJK36tUwU9RYHPrAEIYrAjnn3vrxM8f2Jf2pn33qJGYgdu9zD
	KTMbydTG3JhZ4/yhnTXUOWGrduG9pBzF/0I/bHWVjO93x4A8Cwd3M21dmJs0x0Yg80LVaOMhen4
	JC1yfb/Ae371YWN2kEjSIGGBoRkPpOP4WEPwSGo5x5p2dfEC4SHsA11VzsVcmRLX3GXc1qvvmxO
	zD0Vvl8QjySRIi03lQPBrk8ZkSIhe2trl3gDm6WDDgcB+E9Q/ZwxaAOxHKua86gceVsPGXK+IOW
	cdVDo3ek2PK8fkou0ox2inolLNO41UcKeA8G/YeGNzp/GwHyL3xDl/iad++Jw2cvANLKdQ+zGwi
	PAPtgJK6UptFJKTQK5dDGK5DJUxGCeBRugEbRq5FuOEwc0bLk09ENDXU386We+4bT4G0IFWv/ue
	KLYQCc0nniq1c1AObc4IexAff89TlnbIgGw1oVsg==
X-Received: by 2002:a05:6a00:6c8d:b0:842:47f7:5f1 with SMTP id d2e1a72fcca58-8429b73c68cmr3210028b3a.28.1780585319505;
        Thu, 04 Jun 2026 08:01:59 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:8::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282882156sm6223764b3a.33.2026.06.04.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:01:58 -0700 (PDT)
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
Subject: [RFC 03/12] PCI: Convert pci.h to pci_is_sriov_* helpers
Date: Thu,  4 Jun 2026 08:01:44 -0700
Message-ID: <20260604150153.3619662-4-dimitri.daskalakis1@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20505-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 243DF6414F8

From: Dimitri Daskalakis <daskald@meta.com>

No functional changes.

Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4a14f88e543a..73b913bcb87a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -954,7 +954,7 @@ void pci_iov_resource_set_size(struct pci_dev *dev, int resno, int size);
 bool pci_iov_is_memory_decoding_enabled(struct pci_dev *dev);
 static inline u16 pci_iov_vf_rebar_cap(struct pci_dev *dev)
 {
-	if (!dev->is_physfn)
+	if (!pci_is_sriov_physfn(dev))
 		return 0;
 
 	return dev->sriov->vf_rebar_cap;
-- 
2.52.0


