Return-Path: <linux-s390+bounces-20443-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ll/vFt5WIGrr1QAAu9opvQ
	(envelope-from <linux-s390+bounces-20443-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 18:31:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE789639BFD
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 18:31:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=VUbDvQ4W;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20443-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20443-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C9A231FADD5
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 15:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CCB3D6688;
	Wed,  3 Jun 2026 15:48:10 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C234EF15;
	Wed,  3 Jun 2026 15:48:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501690; cv=none; b=qsP85K3BB2I7kxYBcKfMiKHUzHP2ATwpfveZXWtkK/N7dqPgShpEkNyOmIELs7qYZzrVIHa4TctwbYF9XUzUz0VFTWPlv6a9MRbLHjb3IVey5ooh2Bq4vfJsPYscg5GqSYjbQtJiIuLr+gE+S2UHE1lDp8MQgEQ3NUmd02EgiXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501690; c=relaxed/simple;
	bh=r77QS4jK0VZPgcrQWh9fAzu6RW1naLyvFwiv7PPscyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VswgLH8O+BXUuJifYPInO7ijVsc+Yi/kviO3qRiA87wPC6IxOxrvDjHUj06kkQ4526dphJZsh5SMVyfLODXII+LDyXKbmo+4GY858i8+abgIRNrYkO4rEOAEnP0VajpqMX4j11a3adgo5Kga8x3bIcT8BiIeDTLtbQMi+SpJeEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VUbDvQ4W; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535ZU9D3017986;
	Wed, 3 Jun 2026 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pnUpzJCIg/jBbRGD/
	J9U/RIeGN8zwCDqqF0z3vrqgzk=; b=VUbDvQ4WE8LOvfIqwjI3Ie+vtM6k5ccUd
	UoCX/uopckOtuc49h92tzoQnPW9rjjjNftk2JrXpzSgSsRp/qaogKz41fEP1UTZl
	/kjeygndMCz95V0ZwlW+Te1i1zjzKzAnSFm2IRGuXkvW03M8MdFSqWATW3Q9aaEE
	vSuPXk8P7xyoTjgBzerQBxHWWftrjN7bOZUP525KxSIc6dr5lAGWgb8bTsMpEjOH
	EarXe8UmYHuPa57gNwtdKFdeEInnLCbiUH7LfU4Yygxa5tbR5TglbSwlWfCL6c0s
	GZcpdonACPnTa3DsozQF4DGHCh3Kq5DkMSvgiQo7fDocstWzVdEdQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtb4q4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653FdLYw032717;
	Wed, 3 Jun 2026 15:48:05 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhgtc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 15:48:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653FlxQj51183900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 15:47:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 284812004B;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 044382004D;
	Wed,  3 Jun 2026 15:47:59 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 15:47:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 1/3] KVM: s390: Add module parameter to fence 2G hugepages
Date: Wed,  3 Jun 2026 17:47:56 +0200
Message-ID: <20260603154758.234768-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603154758.234768-1-imbrenda@linux.ibm.com>
References: <20260603154758.234768-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_yKTI8r78Slz98IBj2HnNmwbVTkTM3B
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a204cb6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-5nL1enD9Bub2BjMfYYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE1MSBTYWx0ZWRfX2TJtDFuh/roT
 6k2Lv1269D+FnADCh9EPnPEpd9vj5kRG1Z5z7XWzHVn2viF3xljh9BDNiqFYL/8s18Z9zBPVhSK
 Ty9sfJFEY1QlJ7/iAVvrK9l65WUxhe6B9nkLc2fRUk1u7eTUVYyD6YejGQskyYufQpOTGpcHjRM
 YQ+GvvkDUWLAS5mahUiYvgWWhymDmyWCiFx677Y9Wtu9WTytjETpKdINJlVSug/85fITltPZU3/
 qcbkmOMsBgOt8j9M+4fNdtE7n08jLC2SFeEuHG7v/YNuF6OPpcGcCORdlZMYYKiGucv8v7B7krQ
 nmM3p1dHPQVRy7x/Ibva5++gKXY0fT+4E/1OzCEEU84Kpxc9pPNlrfjqx0OSCi1ZXp0H8dugoI/
 302YzFervVVuf+EUOhn/t59LoRLBFkogY+QDy51Yj6bShPgcETU+EuPbORobQxBLxJgBkiiLf3o
 oN6fU/RlwcCnDdorLHw==
X-Proofpoint-ORIG-GUID: o_yKTI8r78Slz98IBj2HnNmwbVTkTM3B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030151
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20443-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE789639BFD

Add the hpage_2g module parameter to KVM to allow enabling or disabling
2G hugepages in KVM.

If hpage_2g is enabled but hpage is not enabled, print a message and
disable hpage_2g.

Opportunistically fix the comment for the hpage module parameter.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..801a622691b6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -204,11 +204,16 @@ static int nested;
 module_param(nested, int, S_IRUGO);
 MODULE_PARM_DESC(nested, "Nested virtualization support");
 
-/* allow 1m huge page guest backing, if !nested */
+/* allow 1m huge page guest backing */
 static int hpage;
 module_param(hpage, int, 0444);
 MODULE_PARM_DESC(hpage, "1m huge page backing support");
 
+/* allow 2g huge page guest backing */
+static int hpage_2g;
+module_param(hpage_2g, int, 0444);
+MODULE_PARM_DESC(hpage_2g, "2g huge page backing support");
+
 /* maximum percentage of steal time for polling.  >100 is treated like 100 */
 static u8 halt_poll_max_steal = 10;
 module_param(halt_poll_max_steal, byte, 0644);
@@ -5820,6 +5825,11 @@ static int __init kvm_s390_init(void)
 		return -ENODEV;
 	}
 
+	if (hpage_2g && !hpage) {
+		hpage_2g = 0;
+		pr_info("Disabling 2G hugepage support, since 1M hugepage support is not enabled.\n");
+	}
+
 	for (i = 0; i < 16; i++)
 		kvm_s390_fac_base[i] |=
 			stfle_fac_list[i] & nonhyp_mask(i);
-- 
2.54.0


