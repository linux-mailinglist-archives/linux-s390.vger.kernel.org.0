Return-Path: <linux-s390+bounces-20382-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zwUCGKTqHmozZAAAu9opvQ
	(envelope-from <linux-s390+bounces-20382-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:37:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C916362F57C
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:37:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=doCG4nV9;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20382-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20382-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35D130DFA57
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB7C3F1AB9;
	Tue,  2 Jun 2026 14:24:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD53ED3D8;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=OGUr2mTq6w9uEjnjhgVi8oGf44A1S7aIFAwgYKC+VqIQ2HUfAH2MCDCwl6wPnJ7qwUuklA8XBpV87ndsnt1nT+GWjcBvKMmlKF/vOiP+iaTRK3Ci/CbYSjjcmDC0wF0L17GO7gckNor9M5Cly6YeBce7Mbyjgj1ebksZZSgM8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=eh8QShNn5lZ5kvXd+kW/b+EZYzJK91vldTMc69dJ9IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJFnZ9rDwqL4M7DRgosDXgLrR1qMRIMVXvOfqnC6ypFVU/ix30v0PpKcyNkfw/toHJ4fWHTKGm85nrb+x5o/iGabVKeiCeZvOQoAo49ougqMICJ5ORXQxw2vxgXPS/dIw82yQL/sPiM/ABhaqbbA26467W9f/s3FGhzS4L8BsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=doCG4nV9; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652A4XjX510186;
	Tue, 2 Jun 2026 14:24:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cT/QDVl5i3sXiVxnn
	EqfsOzk+Ou4rRD8/+N7jayV5wA=; b=doCG4nV9Fa8ClgCILW1zeIFOiTbHmdgKW
	+OvsRVJ+kuay5NJXTcmxqWTggOWSTmsDRaqrOLJ5sLb5zOBwV+C/mENp1hTB5j7f
	tLxAsStydELmkk1q2pUsOp2aIQ74JVDPs5vWYxTQ4/2hCJh06Z6m/Wp/R5jbjvUR
	k0PN2ywKEH9IVZCfT00BbHl+4cdGJ26bw18iJQIe8NOmQpk7O88Wp57oqtzqDGdG
	2Dy3ugAhYn1n/lTHtRM5FP/oGYCRLDWPuRkKqE6GAzqsqdKygNmjuoRewwJoCPrN
	CFB9HJZ4sUQ8Oj2td9tCg9vS4YDPfcAQuCYAotg52KEZ2bydawQag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae5yyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652DO8AL007309;
	Tue, 2 Jun 2026 14:24:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k3mq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENwIG36962790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E59820040;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75EFF2004B;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 09/10] KVM: s390: Fix possible reference leak in fault-in code
Date: Tue,  2 Jun 2026 16:23:55 +0200
Message-ID: <20260602142356.169458-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1ee785 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=t-RmA2bz9KeGA92bHnoA:9
X-Proofpoint-GUID: N7txxF8CPC1X1z7FEA9fyJv1SIlgK7bh
X-Proofpoint-ORIG-GUID: N7txxF8CPC1X1z7FEA9fyJv1SIlgK7bh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX8ZKYDwftVdJt
 l8IBlmBmC5mSbbrYisVLkKokBR6k60v+cYUOWhRy2mV7dlZMzv6Ul3uWmLTZYvhdX2ZbzZH4rX9
 qaQ3GHNZ/ofxhGFXsfTZKBW2Gdc84GZs22fx7mV7BMDf/GzReRXW9KNAGqZxCWckTR/txzWrGwc
 4U3Gd1Cy86xRXpqJxzuKjc1dOP9DJEDYUMQ65Rjyd8Zi9rUZTQtrXp4pXjEtlP1R4ZWBYC+Uv8w
 QCZjAQYFGm0wZP4hGEdspvH5FRhHyPW9kiC2XLiI/Hw5vDIk0AxjqRFIjYNl9JiC+06SHW/SCkt
 uOArksmQpBd+gJL8zPDG5uj/5oDqI1idjJWMVSwf23vDFKzAiZ3uTF89e7u3ZEUPzsOw9r6/1bw
 iBvURYPuRFCnV2DI5p5JGdStPCUwJ3LqeIFRhPJj8c/Hk95zx4kFNjcG4owRP5/u3zsFu1JXMSU
 XC2n01KISQzDDrI2Mbw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20382-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C916362F57C

If kvm_s390_new_mmu_cache() fails, kvm_s390_faultin_gfn() returns
without releasing the faulted page.

Fix this by moving the allocation of the memory cache outside of the
loop. There is no reason to check at every iteration.

Opportunistically fix a comment.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index cf542b0a7e8e..fee80047bd94 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -54,6 +54,13 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return 0;
 	}
 
+	if (!mc) {
+		local_mc = kvm_s390_new_mmu_cache();
+		if (!local_mc)
+			return -ENOMEM;
+		mc = local_mc;
+	}
+
 	while (rc == -EAGAIN) {
 		f->valid = false;
 		inv_seq = kvm->mmu_invalidate_seq;
@@ -94,14 +101,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 		if (is_error_pfn(f->pfn))
 			return -EFAULT;
 
-		if (!mc) {
-			local_mc = kvm_s390_new_mmu_cache();
-			if (!local_mc)
-				return -ENOMEM;
-			mc = local_mc;
-		}
-
-		/* Loop, will automatically release the faulted page. */
+		/* Loop, release the faulted page. */
 		if (mmu_invalidate_retry_gfn_unsafe(kvm, inv_seq, f->gfn)) {
 			kvm_release_faultin_page(kvm, f->page, true, false);
 			continue;
-- 
2.54.0


