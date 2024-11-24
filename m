Return-Path: <linux-s390+bounces-7246-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F409D6E1B
	for <lists+linux-s390@lfdr.de>; Sun, 24 Nov 2024 13:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B58161A85
	for <lists+linux-s390@lfdr.de>; Sun, 24 Nov 2024 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDCE18C018;
	Sun, 24 Nov 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmdvMiGZ"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746BC186E40;
	Sun, 24 Nov 2024 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732451961; cv=none; b=Fp+u8r/6AsJPVQJ/GvOUryA/p1gkMoY7bLSGn2tnLvvEiYHFBWR9ModhtNhu/zojkWMrTk61QJx7dJj+5z9PU1IZKKacsnz5gqNQgFpyXLZpgBJ3MxC3etc3itZW5kjoh80zcXSYCdCmxSBzysfp/NxWkE+CP0c7Km+UEuckHRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732451961; c=relaxed/simple;
	bh=ILfQxLplx0gttSHiUKBM/enqqqlbXydmez9xfVHfr/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPtEwdvMjzMY0eRat3Jl2SZKaoiYpdVXwveVyCG0zfPzuSbmcE/KiPBECiSnxZVnQPYqXmObucMrFLoTWiRrpOAWiW7XHb3zHlsl9z8a1yYcc0jAd1XL4qaXA2QJW527wduvY9vdJqiTQfTgf86xANGaEWBCECeRaHZ9SPW+jXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmdvMiGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB46C4CECC;
	Sun, 24 Nov 2024 12:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732451961;
	bh=ILfQxLplx0gttSHiUKBM/enqqqlbXydmez9xfVHfr/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LmdvMiGZiRc2kcivkFiDGVhyUAN+UJaV8zaOH6W5Wi+hquS/ySu0QgU017fMeMbWb
	 JBoNMASWxax8jw+4oCAq7NAdgIB2VcJyfAkdVIknloLg//nF8tu1uCLVJQHIGk3Fgv
	 Rfbj2Ruwm4SbkmGPcio+rIyvVp/w7q/6jzrJP0ByLmdOfWCPPy6/lYEMPHwGpzHROe
	 OhmNb2eWrqXcloodXE7TvK++5YILEdN2tUeJbWOICSJY1JilKQE4PQKUMQQjAsfdVO
	 ROyoa5hi3430UO/J466IljlWQRq6FQqif6QGRgwUGLhi5rfi9ahqRx1aYJ1cMr0Hqd
	 ddYcK/AeYkkSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 03/19] s390/pci: Ignore RID for isolated VFs
Date: Sun, 24 Nov 2024 07:38:38 -0500
Message-ID: <20241124123912.3335344-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124123912.3335344-1-sashal@kernel.org>
References: <20241124123912.3335344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Niklas Schnelle <schnelle@linux.ibm.com>

[ Upstream commit 25f39d3dcb48bbc824a77d16b3d977f0f3713cfe ]

Ensure that VFs used in isolation, that is with their parent PF not
visible to the configuration but with their RID exposed, are treated
compatibly with existing isolated VF use cases without exposed RID
including RoCE Express VFs. This allows creating configurations where
one LPAR manages PFs while their child VFs are used by other LPARs. This
gives the LPAR managing the PFs a role analogous to that of the
hypervisor in a typical use case of passing child VFs to guests.

Instead of creating a multifunction struct zpci_bus whenever a PCI
function with RID exposed is discovered only create such a bus for
configured physical functions and only consider multifunction busses
when searching for an existing bus. Additionally only set zdev->devfn to
the devfn part of the RID once the function is added to a multifunction
bus.

This also fixes probing of more than 7 such isolated VFs from the same
physical bus. This is because common PCI code in pci_scan_slot() only
looks for more functions when pdev->multifunction is set which somewhat
counter intutively is not the case for VFs.

Note that PFs are looked at before their child VFs is guaranteed because
we sort the zpci_list by RID ascending.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/pci/pci_bus.c | 33 ++++++++++++++++++++-------------
 arch/s390/pci/pci_clp.c |  2 --
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 54879e773e4a3..1b74a000ff645 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -168,9 +168,16 @@ void zpci_bus_scan_busses(void)
 	mutex_unlock(&zbus_list_lock);
 }
 
+static bool zpci_bus_is_multifunction_root(struct zpci_dev *zdev)
+{
+	return !s390_pci_no_rid && zdev->rid_available &&
+		zpci_is_device_configured(zdev) &&
+		!zdev->vfn;
+}
+
 /* zpci_bus_create_pci_bus - Create the PCI bus associated with this zbus
  * @zbus: the zbus holding the zdevices
- * @fr: PCI root function that will determine the bus's domain, and bus speeed
+ * @fr: PCI root function that will determine the bus's domain, and bus speed
  * @ops: the pci operations
  *
  * The PCI function @fr determines the domain (its UID), multifunction property
@@ -188,7 +195,7 @@ static int zpci_bus_create_pci_bus(struct zpci_bus *zbus, struct zpci_dev *fr, s
 		return domain;
 
 	zbus->domain_nr = domain;
-	zbus->multifunction = fr->rid_available;
+	zbus->multifunction = zpci_bus_is_multifunction_root(fr);
 	zbus->max_bus_speed = fr->max_bus_speed;
 
 	/*
@@ -238,6 +245,8 @@ static struct zpci_bus *zpci_bus_get(int topo, bool topo_is_tid)
 
 	mutex_lock(&zbus_list_lock);
 	list_for_each_entry(zbus, &zbus_list, bus_next) {
+		if (!zbus->multifunction)
+			continue;
 		if (topo_is_tid == zbus->topo_is_tid && topo == zbus->topo) {
 			kref_get(&zbus->kref);
 			goto out_unlock;
@@ -293,19 +302,22 @@ static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 {
 	int rc = -EINVAL;
 
+	if (zbus->multifunction) {
+		if (!zdev->rid_available) {
+			WARN_ONCE(1, "rid_available not set for multifunction\n");
+			return rc;
+		}
+		zdev->devfn = zdev->rid & ZPCI_RID_MASK_DEVFN;
+	}
+
 	if (zbus->function[zdev->devfn]) {
 		pr_err("devfn %04x is already assigned\n", zdev->devfn);
 		return rc;
 	}
-
 	zdev->zbus = zbus;
 	zbus->function[zdev->devfn] = zdev;
 	zpci_nb_devices++;
 
-	if (zbus->multifunction && !zdev->rid_available) {
-		WARN_ONCE(1, "rid_available not set for multifunction\n");
-		goto error;
-	}
 	rc = zpci_init_slot(zdev);
 	if (rc)
 		goto error;
@@ -332,13 +344,8 @@ int zpci_bus_device_register(struct zpci_dev *zdev, struct pci_ops *ops)
 		return -ENOSPC;
 	}
 
-	if (zdev->devfn >= ZPCI_FUNCTIONS_PER_BUS)
-		return -EINVAL;
-
 	topo = topo_is_tid ? zdev->tid : zdev->pchid;
-	if (!s390_pci_no_rid && zdev->rid_available)
-		zbus = zpci_bus_get(topo, topo_is_tid);
-
+	zbus = zpci_bus_get(topo, topo_is_tid);
 	if (!zbus) {
 		zbus = zpci_bus_alloc(topo, topo_is_tid);
 		if (!zbus)
diff --git a/arch/s390/pci/pci_clp.c b/arch/s390/pci/pci_clp.c
index e222036874e51..74dac6da03d5b 100644
--- a/arch/s390/pci/pci_clp.c
+++ b/arch/s390/pci/pci_clp.c
@@ -168,8 +168,6 @@ static int clp_store_query_pci_fn(struct zpci_dev *zdev,
 	zdev->rid_available = response->rid_avail;
 	if (zdev->rid_available)
 		zdev->rid = response->rid;
-	if (!s390_pci_no_rid && zdev->rid_available)
-		zdev->devfn = response->rid & ZPCI_RID_MASK_DEVFN;
 	zdev->tid_avail = response->tid_avail;
 	if (zdev->tid_avail)
 		zdev->tid = response->tid;
-- 
2.43.0


