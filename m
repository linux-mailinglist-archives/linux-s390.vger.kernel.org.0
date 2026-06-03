Return-Path: <linux-s390+bounces-20453-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kPikMWVxIGof3gAAu9opvQ
	(envelope-from <linux-s390+bounces-20453-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:24:37 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6556B63A866
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:24:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=Ic2AIqX9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20453-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20453-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64393302A425
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C9C3E5EFD;
	Wed,  3 Jun 2026 18:24:31 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDE388E63;
	Wed,  3 Jun 2026 18:24:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511071; cv=none; b=iUxwm7JlDxgxMpfJ3/2DiTGR56LoUTmLMiL/RcGGZIPEQeuzOaiYh87HNPAr1gPNQLixWLuNY9h/EnnAu5nGk/nO1gbtGHywtmydwA+vXc+37BwrAsAsCFCCV4w5AH5PjR7xwm6HpkG4/6hF/JP6RAHTVHnmSu/CBlpySbF0jMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511071; c=relaxed/simple;
	bh=DPuQiBFXmj6qUVY/YkNJPHp+MeEXaiSp/X7OtW8VYs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jOPCIk0/9QinofSUxJG5JSMMnqVQXzDIUEbR2yWBMgr4tfLCzaDnF8rVbvHZH7feKjf0SH0UT5Eu2QL19/sqH9aAXeDLp9Z3t+wRgIMEyGTFjEY6TekJX2JVG9v29Piq1fAgaq9qUDKlkujJo9gm/j2fF2Kql142K5UBIeVv6Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ic2AIqX9; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653B9K8u3166613;
	Wed, 3 Jun 2026 18:24:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RGkv2CTMss9f/2VtB
	3Jlrn9K0Sa5hXqXwOD6mlaP8jA=; b=Ic2AIqX9tvgJviz1/RL9Q2vZB8Qu6Flqb
	JxHD1pVRxMSVduO8DOpuzrfyh7KoiQCOAc/RCcSUuzqcN/xftMFtAksSir3nO8ha
	x3G5PUNAkB+ak35I5FKZ5WCYPDaCjsePp2c9/Z97Wv4HUX1xAB5Sv6dLgeLWKlmp
	ZplBDF3epCjogNd5Z0pg2mcbPU1fJTa3QI6HeTeLpXKnORBaeBS3UMoR6D3/KaYt
	x5HmaITCl8qcOOvaqgJkQHl8WKEbyCpyPwHp+5Z1HPl7JYH/rg6YUk30emNdXyZj
	8yNN9tUX04AGL/txIaTHsgPYXPgsPGPqAOc7Vf4621R2dF+0zxBlA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaebva7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:24:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653IO6QB018332;
	Wed, 3 Jun 2026 18:24:24 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qhqp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:24:24 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IOMrA5506012
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:24:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF4A15805D;
	Wed,  3 Jun 2026 18:24:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A221F5805C;
	Wed,  3 Jun 2026 18:24:21 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.14])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 18:24:21 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org
Cc: helgaas@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Wed,  3 Jun 2026 11:24:14 -0700
Message-ID: <20260603182415.2324-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603182415.2324-1-alifm@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a207159 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: kHJbUDrB5tNp2p_MQRebPaqMp4peIWb5
X-Proofpoint-ORIG-GUID: kHJbUDrB5tNp2p_MQRebPaqMp4peIWb5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfX2oax+tHqsyAo
 vGNdOlB6RCzFO6ppr4dyDWE/cOPZRQ1aYMfZsJCQUOIU8OlDXRDLczsjDJTFVOE/9F2f2ChRvll
 1jWyetby9KLO75kiV95ZQQ1vkwiRFfmoCP02N/PHWOxCJec5HHxEj/HQq0qSsCB6GBD8//9vu/J
 646PzPilCRKbgLPvvokvsxyr/OhaXl38s2LVoUKzYShmwf0q2std3nQvbTGkXMn/75DcITTbU6g
 csdrh15R9rRBvCKG4mRAztwIR+2XNViqnH/scJ5vKbPcIgLf9XrMk2xWnKyK+N0Z1Tr25xBSqUZ
 5ihccGBN0Wyi/2bP4UEmtNEgWE1sRgTzxaGZx/8V/O4vAeeLTDZJdBwu+5RVyQxtlPt0HxWFM7U
 hQ6KI46O81/n7hOWPkyQhtkDExYPoFVvGEwUSF8Axih4G1DsiNyK6rUXmXA5Xa19YTmnmMpMWIZ
 LNtoZbOKLIvz/Qf5HaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alex@shazbot.org,m:helgaas@kernel.org,m:alifm@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:julianr@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20453-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6556B63A866

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 27642f10fe97..95af3e827ee0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2290,6 +2290,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (!vdev->pci_saved_state)
+		return;
+
+	pci_load_saved_state(pdev, vdev->pci_saved_state);
+	pci_restore_state(pdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2354,6 +2365,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0


