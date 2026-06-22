Return-Path: <linux-s390+bounces-21088-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e3HyNZFeOWr0rAcAu9opvQ
	(envelope-from <linux-s390+bounces-21088-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:10:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F36E6B1058
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 18:10:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=eVv3tnb7;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21088-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21088-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 439BF3047BF9
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 16:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED433CBE95;
	Mon, 22 Jun 2026 16:07:49 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0333CB2F6;
	Mon, 22 Jun 2026 16:07:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144469; cv=none; b=crXaEFL0Sh5TllYQMkSQ4Psb7aHX+UHMCa9nR/nB9mrbYA9KE+AiD3RnNaYreTHrYVe5llE8bSun9eNXzm1aLH08qkC0taeX0CX7HucZ1XO19ZOj3PG18oj2499tDwLrW5R/bD8XCBpwQtH49QCWr2wa4REAt8ZHa7ra2887MdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144469; c=relaxed/simple;
	bh=NI9av9RZlpaG0Pfdcx4AH5JSsCKYeu2XKVU79BKcfVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cf2KtAuz+K37IxNxP3Kn8LWkX9PmSvVSS1lENNURHaYQqtGd5Fmrx2fnxubvu8m29dsqUWsly19XgGUGnsmuoielBZQCt4rzVKmDxKUzZTAdlfLE8gB8iKqcLWbeT9Q2buS40MipWbRbdShNzuiIs80M1LCJnD6GXAonTRpqVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eVv3tnb7; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmHTA3447097;
	Mon, 22 Jun 2026 16:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cWerZXEpQNO7n48Oa
	pKV2aPjVrNt9pyLBbZK2gGgDP4=; b=eVv3tnb756OnMJ83CWc60dSj8kijG1mfu
	PnMAdUXm5nZOHDMTf5EttDdVXUgcH5sKuF02DS19AfJy6D45JU0w8uVu98ymhDiD
	6ksLgmOuKlNFTOTG4Uw4qtWmpOXNKo+nE6avNoS8bC9wvxQu1MKcaFanRO74/T32
	eTLMDrlwBIPkSED74iW0J0wmtF7xV1qCkC9pk1axppiGjc+fVTfKAhQa6QytUz5o
	PCBFouHyBeGkIFeOJdMuUr/8iilniHrgXQ2MRFnsAeUBV+yCW9uA5YRaNSXRPx31
	DMjolKvUsj9eF5cnh+FXrO9jSYAHQ7O3zPE59BjrwU3faUK9n0rPQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3a6f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4cxs008749;
	Mon, 22 Jun 2026 16:07:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyep3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7fYK7340490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94C6520040;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 666C62004B;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:41 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 6/9] KVM: s390: Fix locking in kvm_s390_set_mem_control()
Date: Mon, 22 Jun 2026 18:07:36 +0200
Message-ID: <20260622160739.202044-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a395dd2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=n1h0PExJXEhyPeoWzy0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX9ygxXx8khHMx
 paPQSYb2ruRcyXzkPRM49AIuL1qndjl4wRH/qACdkai+0uCifH24S6uRjqT9zwT2b3teeKnqDYQ
 B7ze+Gnth6Iow/UKqwrflxbC3iVv/IU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX2KmssW+egYSm
 ENKeRXCD4Z4hcPN6pLkN0nsqgnQtzOmAe3MKX1kfbl7ehzL63xbYjZ/i0GjiGo2lvKjRq/O5gu0
 VaLJoig95FKFxzjsn8Nh03uCG9LcG6ijJmxQiO4P3myBLPrMFbKNckrdSpUusFNA0665SM166Mg
 VpvK1+7N6ouz8BxkDPObQ9Z5JjEZPb75bJ7fqeWVZcHmz6BAPc9hutZEQXBOo4G20UOpCzV6r5v
 K/U59JWX2fKYcNh2LE6aIRBW3OOvyyKuUiE1LOyUCjZzfzcSSP64TY0UP4hqa86GCAYzshACo5u
 iAop+kWc3XHYIQcz5t9XI+CnCt5XkQ9cAuB2G8Cf791KTgxjzu3z2FJ3h0Mlokft5/ZN0JlfVnd
 g70GPKzNiuVFgH9MK4v8fyueHR6iOWLS3ccHigZHK3tAZaizWHWHy9iLWtxVbDc/7oxs09l+gDS
 dZ34Hxced/kbhjTSQDw==
X-Proofpoint-ORIG-GUID: LElD1X0__cs6wVPoXAJzkNqVi-3h2Cov
X-Proofpoint-GUID: LElD1X0__cs6wVPoXAJzkNqVi-3h2Cov
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-21088-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F36E6B1058

All subfunctions in kvm_s390_set_mem_control() need to take the
kvm->lock, so factor it out of the switch.

Also add the missing locking around dat_reset_cmma().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ffb20a64d328..93141a68e0dd 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -962,6 +962,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 {
 	int ret;
 
+	guard(mutex)(&kvm->lock);
+
 	switch (attr->attr) {
 	case KVM_S390_VM_MEM_ENABLE_CMMA:
 		ret = -ENXIO;
@@ -969,7 +971,6 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			break;
 
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CMMA support");
-		mutex_lock(&kvm->lock);
 		if (kvm->created_vcpus)
 			ret = -EBUSY;
 		else {
@@ -978,7 +979,6 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 			kvm->arch.use_pfmfi = 0;
 			ret = 0;
 		}
-		mutex_unlock(&kvm->lock);
 		break;
 	case KVM_S390_VM_MEM_CLR_CMMA: {
 		gfn_t start_gfn = 0;
@@ -992,7 +992,8 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 
 		VM_EVENT(kvm, 3, "%s", "RESET: CMMA states");
 		do {
-			start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
+			scoped_guard(read_lock, &kvm->mmu_lock)
+				start_gfn = dat_reset_cmma(kvm->arch.gmap->asce, start_gfn);
 			cond_resched();
 		} while (start_gfn);
 		ret = 0;
@@ -1010,8 +1011,6 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
 		if (get_user(new_limit, (u64 __user *)attr->addr))
 			return -EFAULT;
 
-		guard(mutex)(&kvm->lock);
-
 		new_limit = ALIGN(new_limit, HPAGE_SIZE);
 		if (kvm->arch.mem_limit != KVM_S390_NO_MEM_LIMIT &&
 		    new_limit > kvm->arch.mem_limit)
-- 
2.54.0


