Return-Path: <linux-s390+bounces-18810-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKATH71b3WmadAkAu9opvQ
	(envelope-from <linux-s390+bounces-18810-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 13 Apr 2026 23:10:21 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81EC53F36B6
	for <lists+linux-s390@lfdr.de>; Mon, 13 Apr 2026 23:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A116301A0A9
	for <lists+linux-s390@lfdr.de>; Mon, 13 Apr 2026 21:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF8392823;
	Mon, 13 Apr 2026 21:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2bEXJjX"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6389395256;
	Mon, 13 Apr 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114406; cv=none; b=rm5gRbvOzECq4GccEpbuSECsAmD9ayfvjaGdXdhtqKvrn+U+frvgY+iiuWJJ+fU2+VJI/lPFFMdsHdV5HBrEtmxdmP4luerVKE9OJAqI45EuWy4fJLXACpP2wjPycng2h6v7yKu7lf3HoTCMZuHv8KAuCBWKJIGQ+HE7ZEGCOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114406; c=relaxed/simple;
	bh=/A4i7jVvjy73WaQOU6JOmUh4l/ODHy9wJnwVOUgyG1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JqtydYZxXO4E2x7QEndPYYgjo4CTY11GujY1FD1Qlu4EL//pU/u9oZ/zVb4fnV57tNwpjEIpXTYB83X8CaN9Z/I32E3mrWI71r/5qUdoLnG/ft9JlJ+JMgIhXPoEGyInLSnZnHNGNF6ZGRP024g/TC3GQDzNklvnLID65dfa0dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2bEXJjX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DIPdpv1434207;
	Mon, 13 Apr 2026 21:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Xr+EsZK/+1s603aWr
	/wUgOxtfADRseSmWFfwoV44DZo=; b=U2bEXJjXiQuYSV96yvTjwcVcwy/41cOVK
	gVyLy+lLDMJn5l1IZAtMr/Zj2ABYxdO3KkfwgkQK1qsoo7Qrd1wwfeLzypkk9IZH
	l48Xf8qiasWg4p7EMCxGfym1WY6/ab0mV5YCrM0ej15w/P/RmteYpIw8tlG+xdQq
	kFwUCdcPDuI7LM6EfnTMO0sby5QlopjcTeXGYvq4mjhQSbOg54Rf+reV1Dj4d81N
	Bfb6ozvr6lwyTbW8RYQBmNCts72TxqQNCMo6wfxt+DNC5BSv0Xgkr9/Kqi4j7Alc
	ep7Nk3/l1rmAyI2bovpZe5e2W0L9rbR0KjRMOB+i5d5UyV4h7UCnQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3stq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DHitiJ003581;
	Mon, 13 Apr 2026 21:06:15 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn6uvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DL5nn721955232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 21:05:49 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD9425805C;
	Mon, 13 Apr 2026 21:06:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60F2D5805A;
	Mon, 13 Apr 2026 21:06:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 21:06:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v13 3/7] PCI: Fail FLR when config space is inaccessible
Date: Mon, 13 Apr 2026 14:06:04 -0700
Message-ID: <20260413210608.2912-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413210608.2912-1-alifm@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4zPxh-wgXZo_Nm4reROeeWPQYZrckS9D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX+wFh33SAYx5/
 q+bnS2nraZA7Pec5cKPfP2rGL3n9tkmyKLwy3g4Vf5hYiuZUSaKU5CYxQbNJQ+S4lGAzTl0m38I
 Vj2tGNQsAh/a8j8N0DedUkXWZ1rGWEqtY9QEhzBl31VNYbJfBCdfT1F8/T1ypau0u/ne1wjiSst
 HBOQNv8IwfzOd/wZ73xj2TisUdez60wZUg23PbiH/ElTVgReefCXRO3NNbAyxIYXy8YClxB50G2
 pMVRKiPj5SaFL34x9ypoDAL+MIcVwY7Npkoz0De8l5viNz2f1ahGUUXKY0hZUFxKQyedly36Aa2
 FiWpddV3oWxVM2KnduDKlBOaVT0XIS3I+W145OimIz6OsqIAD8ZOuY7h7fi44B0d8ta3tJwMJre
 jWY/RMVQckSlOyEQYY4BwlQsZ6IKHScIJnvFI27iw8UNfGN2jpdy9cB46alN8XgnUpSi3+HV45i
 Mwce3Ai0S+IZ30WCa5g==
X-Proofpoint-GUID: 4zPxh-wgXZo_Nm4reROeeWPQYZrckS9D
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dd5ac9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130205
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18810-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alifm@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 81EC53F36B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
index e71b81415392..c50418f5e318 100644
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


