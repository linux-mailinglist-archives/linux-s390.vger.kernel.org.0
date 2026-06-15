Return-Path: <linux-s390+bounces-20877-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TTNINpNGMGr7QgUAu9opvQ
	(envelope-from <linux-s390+bounces-20877-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:38:11 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E886B6893C1
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:38:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=HLLwfjkP;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20877-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20877-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1FA43008FC7
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A03803DB;
	Mon, 15 Jun 2026 18:36:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333062882B6;
	Mon, 15 Jun 2026 18:36:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548590; cv=none; b=iMPgauWH2vPNqcEIktP/L8LW6S4+Y/sccCOM675nuTi972XOctl6ufX6QUcj12SEPSV72iMxhJ4LG6D/fhMTh7FJkHFduI8vUEeiEq/CiKY8s8Q1OkRMoyb93H2+yP4FY4pNVqu6hH0NvOmP6uF5dyHKu+kdSwsFBeB/jUlxwRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548590; c=relaxed/simple;
	bh=zUd6fej5GCFxkuNCaXZsZjggdjfGaPO0xBaNzkEr3P0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAAd/ZN2aaqFo1sMFUjyH8i7bdXqHwmOMO57tmGR49yIUEgDT9sP+cQA/OC7+CQek/dlmCh7KJ4c6+B7eNtVpWsT9d0s537CEiLZuw7vsWzLYJOmjoH7dMXgmTbJR+2mOD2HZ4WKr0BNM8RpAu1mopC/bYggxpAGIdxQ4zP34Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HLLwfjkP; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmPuj2897259;
	Mon, 15 Jun 2026 18:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FEOuHbUOX609ZCsiy
	pAUQSDkQbJ9TO2OtbTkf0tla/c=; b=HLLwfjkP2rl+aqLFRDXV2qYvWKsaAGb7v
	n1hxoNnpxKcxy3mjwGdcF5Bp/PkDtFyvyPJOlUX5tMqz3nRaQ7aRjLGFT7YPyIqB
	gwGEMO4N1x7u+MXM87G4ckm4NvNHX81JPDKl3TWPqYN5Ml1gyE8JNW2q1yIpGKto
	ZOgMKdZ/tSl5y8dN5iGvojXVonJ4LgfMCfK2oKcQoP0rXg3yinGGtxT04Cx2tykF
	thZCZfcloiwlrN1W5EYZOndJSJN4wSkfFsKg855tjZnITadedePV3poUYHHiMRQn
	mVUn/SxbllkWdkPeKanzgMWzRK5ynHrT6/2vb8I8RX7hPGVUCcZwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h825pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYblL003233;
	Mon, 15 Jun 2026 18:36:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvyydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:36:22 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIaLFA30212800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:36:21 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02C9558059;
	Mon, 15 Jun 2026 18:36:21 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C5CB58043;
	Mon, 15 Jun 2026 18:36:20 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:36:20 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v19 3/3] vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX
Date: Mon, 15 Jun 2026 11:36:16 -0700
Message-ID: <20260615183616.2902-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183616.2902-1-alifm@linux.ibm.com>
References: <20260615183616.2902-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX5OQQOttjCgYt
 rORbYciQvIDNcg4Ki6Y+ncXvRacu7hJY6Bn181VXLS8psjdXUyFKMRedRbve6qr4GPFfwWIuSBP
 +MIbj2DBQ0Yed7XnySZ4QWruwu4b7Ss=
X-Proofpoint-ORIG-GUID: FwJluN3CrNi5yv7kyvW_Y0saAsKolFBw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX7gEjwnHUZkcB
 3ZC2JmmnVSRT+YrZb64Ld2ZlZ4g6lI3p+N6TTjRctZw3eaSyq1HLE05yZCOMZJ8xAQqpHwI+Tvc
 ubnUSuacPI2jI9mfVxISCcAV+aFWPmM6s1kegvAQQlNc4FqEYAdQ621Gfyl67n7bqrL9nsKVIeY
 T93KDbO3FUPAltS6DxenRKkb3z95NeA5MILNtg8dLjTiCUTlRX1msNohVTAdKMDt1DaHEMlchI8
 MI5j//l8IiuTOhtqBgnS/keyyA72IBq5Iwcd6+8Azvm1dYhMdEawO/t6K31oFrNkPtAohQfbpFY
 FKno56WbGppGw49ss+oClcFjUjiVv+JTQgl8AhF2r2L1e3Ko9yOwDDelF8rgc1mdErueBOrTexx
 ukcsWwqYQS9HbZgoUo6Ym/MkHUTz+Ik9JXv5YAEsLGB0XXCPdN3sBwxyA7VbaEgvjEF4DWyRXJW
 WvwXbj7moQb1zrsAkag==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a304627 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=bf5i11FZjm5gBOpVircA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: FwJluN3CrNi5yv7kyvW_Y0saAsKolFBw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150194
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20877-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:alex@shazbot.org,m:alifm@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:julianr@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,shazbot.org:email];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E886B6893C1

The error signaling is configured for the vast majority of devices and it's
extremely rare that it fires anyway. Removing the pcie check will allow
userspace to be notified on errors for legacy PCI devices. The Internal
Shared Memory (ISM) device on s390 is one such device. For PCI devices on
IBM s390 error recovery involves platform firmware and notification to
operating system is done by architecture specific way. So the ISM device
can still be recovered when notified of an error.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c  | 8 ++------
 drivers/vfio/pci/vfio_pci_intrs.c | 3 +--
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 27642f10fe97..cd3ce30d22f5 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -821,8 +821,7 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
 	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
-		if (pci_is_pcie(vdev->pdev))
-			return 1;
+		return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
 		return 1;
 	}
@@ -1198,11 +1197,8 @@ static int vfio_pci_ioctl_get_irq_info(struct vfio_pci_core_device *vdev,
 	switch (info.index) {
 	case VFIO_PCI_INTX_IRQ_INDEX ... VFIO_PCI_MSIX_IRQ_INDEX:
 	case VFIO_PCI_REQ_IRQ_INDEX:
-		break;
 	case VFIO_PCI_ERR_IRQ_INDEX:
-		if (pci_is_pcie(vdev->pdev))
-			break;
-		fallthrough;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 33944d4d9dc4..64f80f64ff57 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -859,8 +859,7 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 	case VFIO_PCI_ERR_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
-			if (pci_is_pcie(vdev->pdev))
-				func = vfio_pci_set_err_trigger;
+			func = vfio_pci_set_err_trigger;
 			break;
 		}
 		break;
-- 
2.43.0


