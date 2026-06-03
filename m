Return-Path: <linux-s390+bounces-20450-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aoYoHsxxIGo/3gAAu9opvQ
	(envelope-from <linux-s390+bounces-20450-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:26:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB16863A899
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 20:26:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=F7Nc5nkt;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20450-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20450-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36C16304D73D
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 18:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F3D3E7BB6;
	Wed,  3 Jun 2026 18:24:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6283F1AA1;
	Wed,  3 Jun 2026 18:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780511066; cv=none; b=KK9iK4Ar/iGt+Q+O1/0kl/v48eDhirzm4UgZYxJ953iahQ/DB9njgEVIIWqnkYUgpzySkRpsQ19G2j3WVcY1ao1NxzSdpH3VrV2EuhUfokzTlx7+k7wJnfaWh70/jyxLd/ZFcPFF/k7TXnjlfldxgNhOST590XxVQoYqD1+24EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780511066; c=relaxed/simple;
	bh=TILyMfmxhA8SG3CH/ZdIVVDGZF8milrSPPp0XLuB3jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BeORyw8lQaBI5l17dSnt4H6kURvgcILZVmzgyY4pniDhihvan7KliUpBt4lekv421503dKcVwSLMIwu9/IeDNuF1VbUhae4wwG0ZVc43Uo9E+Ntc7v08uC42PXdcp3Hgy1mHA03y7YKWe0kCm8YcAbTxHTwsVbadmzdS1zIwm40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F7Nc5nkt; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6537BK8K2012063;
	Wed, 3 Jun 2026 18:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=A7TOVReiwFntMcowZFeXdNwOzU2aBxEYcJNPjPFW6
	JQ=; b=F7Nc5nktIK4z7Qtfom+2GVXrWTweFIQ7v5DAF9N6ZesEqRqMaBGI/KbSS
	MgFG9CedKNMXukBgv8Gvr/guieSiUvV7xbnsgzdxdEAufvsFSmCrbo6B7q5FQRq3
	d1IPqEIRVAadHfaR8+sr9pI260wnurFN56T6Zr4I37R3024FGDxjB24c/H8oYwHc
	+ftNM2FwSnMPfFI2PsH/GtQjdxBGOLozpghkwl9xsJGOvJHtoNxwsR9UjJYWm3u0
	iwCZojnpgbUYkdFIK+jzK3jp9NuzYSGUTRjpqefQRoQ30F79f9eRkCthNPS5WQ8v
	VkhxmXhSoS+8gaNRwwLjebyz+fE7g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaebv9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:24:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653IO7x6018345;
	Wed, 3 Jun 2026 18:24:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qhqns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:24:20 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IOJFj33292968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:24:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0208958054;
	Wed,  3 Jun 2026 18:24:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08ACD5805A;
	Wed,  3 Jun 2026 18:24:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.14])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 18:24:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, alex@shazbot.org
Cc: helgaas@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com
Subject: [PATCH v18 0/4] [VFIO] Error recovery for vfio-pci devices on s390x
Date: Wed,  3 Jun 2026 11:24:11 -0700
Message-ID: <20260603182415.2324-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a207154 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=q0gwpn0l6oMsUSZbeGEA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-GUID: WJ7NLNs-N1U1_7mt9H0zZIubHEpaHzfj
X-Proofpoint-ORIG-GUID: WJ7NLNs-N1U1_7mt9H0zZIubHEpaHzfj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfXyBEkpej/cjYD
 bbxuy4rWxKJESX8FJsficZVkcmG8lYzHOyUKs8I4+qlVTjI3pqI4SQtDJp7ri2IVPqyR6HnanxK
 WP5rIgBmPNA/MnxNBYAZvZ1W0AzrQnq0Q9VjdV0eLFCf0qeBgJNFLgZenulcnLz3EkCqTqQeVbq
 AyOnJvvwJqJlhfiW8Msq1S+Qy2qQVB3nn+TS6drvHv17rD91mKRxqTQveGgW/v69IX3muVjoiFa
 O97FhqbzKiTnwmesW3L2YJSwMqElU/VO44SKHljpqWsKS7M6xlU1KfMBJm2/Iskpkz52KQWSbpm
 i3EWENiS2lkVCGlHoj1r6hCZgDrVjMOoHrE9SVORbT/tRmq6rYph/92UTyTermniZsRD/OAspZh
 yXaYHNw79xYXFkcTmfEc1Dg3lXkbjmLGlz6nx10/bpcSH7jRvi8OJY0CCgc9CeF4Pv0xfMqA6e0
 uBK9raYEia0npBtwi7Q==
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
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20450-lists,linux-s390=lfdr.de];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alex@shazbot.org,m:helgaas@kernel.org,m:alifm@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB16863A899

Hi Alex,

This patch set includes only the VFIO patches of the original series for
error recovery for vfio-pci devices on s390x [1]. Breaking up the patch
series into PCI and VFIO only patches to make merging easier based on our
discussion [2].

Thanks
Farhan

[1] https://lore.kernel.org/all/20260520171113.1111-1-alifm@linux.ibm.com/
[2] https://lore.kernel.org/all/20260602163344.1eda12d2@shazbot.org/

ChangeLog
---------
v17 -> v18
 - Print a warn with dev_warn_ratelimited() for copy_to_user failure.
 - Rebase on 7.1-rc6.
 - Break patch series into VFIO patch set.

Farhan Ali (4):
  s390/pci: Store PCI error information for passthrough devices
  vfio-pci/zdev: Add a device feature for error information
  vfio/pci: Add a reset_done callback for vfio-pci driver
  vfio/pci: Remove the pcie check for VFIO_PCI_ERR_IRQ_INDEX

 arch/s390/include/asm/pci.h       |  32 +++++++
 arch/s390/pci/pci.c               |   1 +
 arch/s390/pci/pci_event.c         | 135 +++++++++++++++++++-----------
 drivers/vfio/pci/vfio_pci_core.c  |  22 +++--
 drivers/vfio/pci/vfio_pci_intrs.c |   3 +-
 drivers/vfio/pci/vfio_pci_priv.h  |   9 ++
 drivers/vfio/pci/vfio_pci_zdev.c  |  61 +++++++++++++-
 include/uapi/linux/vfio.h         |  30 +++++++
 8 files changed, 231 insertions(+), 62 deletions(-)

-- 
2.43.0


