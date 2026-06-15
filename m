Return-Path: <linux-s390+bounces-20873-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V2PDHXdGMGriQgUAu9opvQ
	(envelope-from <linux-s390+bounces-20873-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:37:43 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E813E6893A3
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:37:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=M1D2v2BK;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20873-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20873-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6924308213B
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E5437E2F4;
	Mon, 15 Jun 2026 18:35:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EDE38228D;
	Mon, 15 Jun 2026 18:35:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548540; cv=none; b=pQMPmO2zaa8EYY7OdgIxmhYpNfmnmTCJb/2K/U1TxrQxLMJslMnd3VpYvaPeD5n/UmQhP8rpOLN/zsngHWHD4Aydz6iJ3b55ZSOjXxFmnIDdMKAZLXYcUhPpZTEt7u0C8Ypu1I3e3HgxOL8mgKVJIWT71OSwUYP7p2pmAuX6Cmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548540; c=relaxed/simple;
	bh=SF0aJdb4XKt2Su/ZE8MnA+HAGq/MNL71DQZz2+dsIGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjnEznfcwCBFI+u7ZijJtwLGB7NTz1b5JP9RbuI5DomsWqImC3NTz70p4u4gcyt3XNxPQu8mTMi0hBk9IjMjW8kSAIzh/nGxv2WAzzrV/Sg/N7fxTnRJTMfXuemvja+HNoMEmDH9o9b8TU8EgdAB/H/Fw68govMlBxmE9hbQUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M1D2v2BK; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmbw12841897;
	Mon, 15 Jun 2026 18:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+ma1bepvazxVn0Vtg
	CpiWy3I3LnFC6L1lGp9YEouK9U=; b=M1D2v2BKPE3PfvZu04NuED3+/0hWw6s39
	df48/ZV654NqqXgGpuwO7wPPWGQz6LeWfGYD6c6r1hIZla1cPjhFzX8Ia0SLHzry
	A7shXt0iguoh0HGXIjKpHFNoJvqssK+yI/0KFl7bRS65Po944m0Nlc5BrIKendJr
	LaqL0DFL2ghfhWUWZDZj9umRrzHkcUcxs6LplVp8dgu4tyPctvE7nnPYlncg/N55
	6gEtkjC16nfa5eetxjo4Bzgsp3aWdvtQLxbt4LJRTvCLmGeHJlb7BrRKaMLFEn9g
	14BkQug7dlc6tAg2dZ+9W+IluBXPprcDeKRcTfPnrJlLJXausKXgw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nj1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYlP4014764;
	Mon, 15 Jun 2026 18:35:33 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg7nu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIZWKi53215682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:35:32 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 220705804E;
	Mon, 15 Jun 2026 18:35:32 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16CA65803F;
	Mon, 15 Jun 2026 18:35:31 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:35:30 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v19 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages
Date: Mon, 15 Jun 2026 11:35:24 -0700
Message-ID: <20260615183524.2880-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183524.2880-1-alifm@linux.ibm.com>
References: <20260615183524.2880-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a3045f6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=23a7fzljUfkOepplKR0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX3Aq7514TpL5M
 hnAJeeSVC3a5ddQj/vJ9le2Mwm2XHyoZB/esw8MmqGmsXMLNlMNYgaNihevYUnA0yJKNTGzZBGb
 /H48xSYTgPhnY0mC82vw8PCSV5FcY+hHJ98rx+vqPglVlb64aOpX8PM0ve82P3hlgnnRk2kQ4j9
 dLmzGGy6NWzndb8MugIov5DhTLOw2WX71rlGzdALg2uecdcKo+Oo597CyyXwOwM9s64tL1gdR23
 vsEhZMnLjn+ABlkz2BS7pEtlveATqAyWEiNSo8bEDtVLFqD7vJap8qcLctr0AkjXc+G2vY3ctfS
 EXFUSYX7ciP43H4iCYyI2BJMdWEmiXJsL2gHxzQOsq075xj1WMOy6tQ4V7bZ0p2z9u4pt6ACf0u
 BWXxFqEIjuSqS2Tid3HZ30RQMr/mr0Gs73qfbEpX4F5vuThfY2sTO75mGMSBYGAIR2g37DXQiGu
 2UTWOxCmDW/p/m6bBPQ==
X-Proofpoint-GUID: 01Lbwelz-06YnI_pH4CPSOQL4NFQQO4l
X-Proofpoint-ORIG-GUID: 01Lbwelz-06YnI_pH4CPSOQL4NFQQO4l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX7P4U9T9kf/ua
 sTvENAz96yWGN/JqldWzqj9VdqpTkyMiXX2vVaA6GfEH76HIH++0JkfPUk+jtj2yPKhYc4XVeNK
 N5jEFGPacq7/Y4FyI1KsEoASE+WETWw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150194
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20873-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:alex@shazbot.org,m:alifm@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E813E6893A3

The current MSI-X restoration path assumes the Command register Memory bit
is enabled when writing MSI-X messages. But its possible the last saved and
restored state of device may not have the Memory bit enabled, even if a
device driver later enables Memory bit and MSI-X. Attempting to access
Memory space without Memory bit enabled can lead to Unsupported Request
(UR) from the device. Fix this by enabling Memory bit if we write MSI-X
messages, and restore it afterwards.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/msi/msi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 81d24a270a79..d8d3c8a911ac 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	bool write_msg;
+	u16 cmd;
 
 	if (!dev->msix_enabled)
 		return;
@@ -884,6 +885,11 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
 	write_msg = arch_restore_msi_irqs(dev);
+	if (write_msg) {
+		pci_read_config_word(dev, PCI_COMMAND, &cmd);
+		pci_write_config_word(dev, PCI_COMMAND,
+				      cmd | PCI_COMMAND_MEMORY);
+	}
 
 	scoped_guard (msi_descs_lock, &dev->dev) {
 		msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
@@ -893,6 +899,9 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 		}
 	}
 
+	if (write_msg)
+		pci_write_config_word(dev, PCI_COMMAND, cmd);
+
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
-- 
2.43.0


