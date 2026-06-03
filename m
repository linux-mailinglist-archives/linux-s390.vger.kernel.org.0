Return-Path: <linux-s390+bounces-20448-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iYB4BiBwIGrV3QAAu9opvQ
	(envelope-from <linux-s390+bounces-20448-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:19:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468C63A7C5
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:19:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=hJJHfpBn;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20448-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20448-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 250CC306FEB2
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49C3F39F5;
	Wed,  3 Jun 2026 18:17:08 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628213F1648;
	Wed,  3 Jun 2026 18:17:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510628; cv=none; b=J+zySMGtQUnBA/MmBVEjKlmNXnD9lq07nc3tzlUvsJPXOsCuvwwQJ+l9LLyE5rDrgUsZF1kGuCbZFauiqONqLDmkdhJdW7mXOj/j57OngplL4WYpqbUMaKu5GxO+Kj5FFNES0d35ERj0DAhK+K12sWCaAeezcFlgwrliu8EN2qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510628; c=relaxed/simple;
	bh=RQ+lhbs/20dpjDWkfLkvzRoH5lgweVzoQtY2ETnzPfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqCOtMmsH9h7ey7MjCMw2KSpOCuA3O985E0jqGB8kvHqLgvJgnE308B34/6u/QV4L54JcNRwNx6utSxeUZqfudI54HdpbfczL3HO42lYqPN85nnSAiFXUyc5FIFeByoW/3orWZqs+OQtifwPkqtuWCHPX7VaGixttnMMAlWYot4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hJJHfpBn; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536wHkB2672300;
	Wed, 3 Jun 2026 18:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cFYGaeCjhi1C6NNXk
	0q/9v/1B4HO6gGEzVR0sxD8XXU=; b=hJJHfpBnUC3b+5892MgEUE0pTvmjwj1s6
	u6W5OJ+4G1qfGP0v3H4SKXXvt67WCfh80Ce5Qz8DS3SmvA3M0+X+a1e448npIWNS
	hwcBERpNEs1eHln63h2qr8cowjueuVvJzNB9+q1L1IQ/k8pYc0y0F59o1dNzI7s4
	5QN0Qrk+x7pms6wJGGYlGVdA+w+Hkb7zWubuedIrDwNBePqYbSQh2I3/Q17AqzkQ
	sfVPCtVmOm6C51QyNwNCWAyJhFD62hMi3UYbqtFiciA1gwuu0azJAGiC0GWNv4VJ
	0iuJ0cDjvPQfgeH+8pZ+2fRbyFpSRQu2l5RBNDklV/ZdiSXKLJO+w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtbr9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653I99Eq004553;
	Wed, 3 Jun 2026 18:16:55 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakw1m48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IGrX614680768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:16:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E534358056;
	Wed,  3 Jun 2026 18:16:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2981F5803F;
	Wed,  3 Jun 2026 18:16:53 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.14])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 18:16:53 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v18 3/3] PCI: Fail FLR when config space is inaccessible
Date: Wed,  3 Jun 2026 11:16:47 -0700
Message-ID: <20260603181647.2215-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603181647.2215-1-alifm@linux.ibm.com>
References: <20260603181647.2215-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J3SIv987uA4c3t_fAr4Yug6tcwrxFfKm
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a206f97 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfX/8lGsEuQDtiE
 IPSSud/2pgF12nhbnp0AeLqDVGBtLYetUQH7QMb1Xmal+J7Yza1z5Eh82y7lfpCvlvWRmwzWEr1
 uhv6EfsczTzqfF+6WSGa6PoMN414oX7IabyfD7I5pWtmRxZitdSKuIvY7c76erS1/9YRyOVNmb1
 d1/QoMo4pHqsuo6JOvSy7NuTEBtq6QB/o5rVhbeSrp54kO1EDPEr7/4GGvpkRAru/8coQJIM7ki
 VL/M6oYVvTtfNDz5jmjHI24f0wVH4n6E+e8QOldWzpSrv1pSUfS0dpg1oFBpq9GeI66lphuqCb6
 7xcuHGF/wQYUb5BIq/pc/I1q0OLdJOwbunhHRqQyAOkgpeLNbvEWeOfgBcZ847rNe5vpBqYVJtx
 UVAWJUT3zsmdGIKsgOmyJQicv9Wk/QGy9SMBgNmtxXS27ePZ9f8x3ycAVtf5n9aCWCX6WSpiFRU
 oU0fkvJFNDcX7lWZR9g==
X-Proofpoint-ORIG-GUID: J3SIv987uA4c3t_fAr4Yug6tcwrxFfKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20448-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:alex@shazbot.org,m:alifm@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:bblock@linux.ibm.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8468C63A7C5

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 973d23e41c48..061dfcd1472e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4396,6 +4396,9 @@ int pcie_reset_flr(struct pci_dev *dev, bool probe)
 	if (!(dev->devcap & PCI_EXP_DEVCAP_FLR))
 		return -ENOTTY;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (probe)
 		return 0;
 
-- 
2.43.0


