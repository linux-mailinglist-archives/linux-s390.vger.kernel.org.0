Return-Path: <linux-s390+bounces-21058-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xWMhNVJmNWr3vAYAu9opvQ
	(envelope-from <linux-s390+bounces-21058-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 17:54:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B58D6A6DD7
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 17:54:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=svHBHwu+;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21058-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21058-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AE7A303E11A
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2026 15:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E163BED19;
	Fri, 19 Jun 2026 15:52:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656E33B8BD7;
	Fri, 19 Jun 2026 15:52:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884337; cv=none; b=ajWb9lsrRMk/zuziQc92+unUsS9zoMG7js4u42TSFx9K2mXxS6aQXOdPot9fdSFNuJZHHWXJ7OBUo1A1FdKYMvhRIJRSuLiYseIcCd7ghb05rOj9nVEEX4E0GySny/+ssG4n0u2+y1cJMwBxnJON/tw3V3+Y/CdhJFEu5Y2Mg1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884337; c=relaxed/simple;
	bh=r5LKQpn3oV6KgFjg7htnzKk/39vhk+x9sArLQy+dh+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfYzWPybVkw+PbNq+m1M0vNLZFWiqeai5xg/lloG8IHCjN6tsoTJ2Duj433KSKj41KhZ7xaEirVQzRyd0cNGZMjLv8GHJ4YWSugnFmz7WLUBuH6m0z9bxBw2kZCjE2NUJkVoAabsUKVPIbQvvjR+3GttPe6LqUCPqDMgf5Xxkq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=svHBHwu+; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIDwq2543000;
	Fri, 19 Jun 2026 15:52:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2r1Lm1RJTQkBfYtZy
	B39nu6ARpnH2y+D9KXNzBLZL6w=; b=svHBHwu+e2PWp9fXN3WeJWux4JtMv6TYn
	QxBUfhioZtoqa+aAC8skbo9XaM9r2CG8yFjt91MLgy5w5HFcCLB00vpRLAUmdZOV
	kE32ZzcvZGynEkgKiYO4BT5i5KHavidop7+5YHJxigzo1Xr3fsRoMbY4JBTOKvrm
	HQ1WkKRyVSCcHq5Y6pHZxwA7Uwtufj54P03yIBUR4hGfZkCG7JMalMMrMeoCR9/r
	s+CJ4+TsNZ7n4ly8HBut41reG53WtW020lusRd1cOpfvcyTBbhp/2P+4UWpMY7ru
	ZVegE/Bow1ur7f+RrKyxIhsrnEpsyOcT0LcLWCPAIYeEisin2RgYA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequef02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFnehf026486;
	Fri, 19 Jun 2026 15:52:05 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hh6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFq2P929294854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:52:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 297F12004B;
	Fri, 19 Jun 2026 15:52:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C68420040;
	Fri, 19 Jun 2026 15:52:01 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:52:01 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 5/7] KVM: s390: Fix handle_{sske,pfmf} under memory pressure
Date: Fri, 19 Jun 2026 17:51:52 +0200
Message-ID: <20260619155154.307572-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX19PYrsAm3S8s
 Oj+sIUuCYLa8x9RJefbaYGK9BJef7JLOiD3L7pUkQs+uocVfiBI4hF71MmZpjZ/WG4vhNn9ZSz4
 m1BzH+SMpToz22EknzDCdByZfr/k73w=
X-Proofpoint-ORIG-GUID: LTdnDzftNDFH59LL3ZCjtItF_-EE6Vma
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfXzcQ5rPnWSE34
 IEpOkDZvT/Gg9/MKrsVChknJiARWrqWm/IpnEFDNBumuWjtfJJtm0179IwmmX9fj41RUeMstBWU
 7cgjvnQOFIpngOGF+QjEH5SFI8Gq7nCyTxmT/aCqC9L97ZTPZ3Pgcn2MiKq8IeBxeRURmuRi0RR
 EjA/t0KnCWSNmoo9Wl2Zf8smXg5YheN40oBRFJmKIswnXwKX8qaf73suLLMslrbJ2lwwPJOAqrf
 jJply+NhA5ZYSMQtcY3vYGMnWgU9urlNt47hmb62Lbd/iv80OkeCuuVQBSG+dY08QY220W3hds/
 uJisV4noLY8EyV9hmLh1XVpUg33EYoqV3Hx8W3jzQyjcmii+LKQvBriipqBbh1H+rSVTR0Sgy3s
 w/UTrkP35RfQ/E5U0bHpouvxm+11X0GKUsi+ZiK+DkqIL86PdRopgqLTEyCUw7r9cCRrsBAasWn
 6une4cNBHeR3Q5mcZOA==
X-Proofpoint-GUID: LTdnDzftNDFH59LL3ZCjtItF_-EE6Vma
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3565a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=tAqH__8HQhgemv6Xi3YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-21058-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,m:hca@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B58D6A6DD7

Under heavy memory pressure, handle_sske() and handle_pfmf() might
cause an endless loop if the mmu cache runs empty, the atomic
allocations fail, and the top-up function also fails. While quite
unlikely, that scenario is not impossible.

Fix the issue by not ignoring the return value of
kvm_s390_mmu_cache_topup(), and appropriately returning an error code
in case of failure.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 447ec7ed423d..9bc6fd02ff77 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -366,7 +366,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 		if (rc > 1)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		if (rc == -ENOMEM) {
-			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			if (rc)
+				return rc;
 			continue;
 		}
 		if (rc < 0)
@@ -1122,7 +1124,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc > 1)
 				return kvm_s390_inject_program_int(vcpu, rc);
 			if (rc == -ENOMEM) {
-				kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				if (rc)
+					return rc;
 				continue;
 			}
 			if (rc < 0)
-- 
2.54.0


