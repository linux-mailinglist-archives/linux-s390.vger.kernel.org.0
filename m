Return-Path: <linux-s390+bounces-20376-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6uQSOlTqHmopZAAAu9opvQ
	(envelope-from <linux-s390+bounces-20376-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:36:04 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E195B62F55F
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 16:36:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=pNkKyB0O;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20376-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20376-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4E81302EB8C
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 14:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9483EFD09;
	Tue,  2 Jun 2026 14:24:09 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5543EB810;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=RerdTyq5gJtm8lhHQy3jzbGaySV8DNySEjTt53x1WfVuamsU7ZDIuPMQhUFCLdzcQCgGFiKKAmJorww2WfVt5BtUtMwfftfXC28NPjKHSVp0M86VBlDuZnTEP4vkH5YmoYpXvVR0xgO+0TEBhKyoLciD5SDZNaE/WooEPnE405E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=q/4VAZUDR9wKIqDbkUpA49JakPieFRHX1ZGX+F9Tlk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGeXxT7BWXMUtOAnnwyga5fRL/dL9NNLmZFMo40ezeD8zzxdKHzWs8/M+Mf4pcyNuy5GcqxA1dt4khuqxMVORFZQVNqvvpJbtXBNFc/nyfjm+lV55EMQpKZqSwR0DN62AspDYuXcurXF7Xxsh0dQN5GtI7/725zRhGBYTixgQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pNkKyB0O; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6525WKCq2667091;
	Tue, 2 Jun 2026 14:24:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q3ON+ZZRcqGRnrLY+
	eHwQpEqFpiLy7qpH+dy3PWXk0Y=; b=pNkKyB0O2QLGgY9lMHABrLlaOzeskZdn8
	bjBQAWCr2z6DbfPySu0tGAPWAXkq8VFETMM2ysTNVQNWQCEwvVEsGTdwjpTkq5KY
	ZG3h3cxkbzABvEa5SIJUFKKrgIr74YBB4EwmwfnxE6C5hG6VD41i5/+dTjWSa4zj
	dZUpJcQx2B6h+XVKoM/8mCVWQmyDiWZiTuvFtBmW9VvhPlTdxSj4RiGBCmP/I8iq
	UGzp2So7qHQd7j+93OwvDUR/YWimZ2QNuvDh+BY4qPkIrY1pO/T1T5Yaj9jOug3/
	28zaerK9riowob+tEA5L93TLG0skVXBT516tKatGM0WdtZgtuLujw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqht5v8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652E95Pu027199;
	Tue, 2 Jun 2026 14:24:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhbgwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENv8E47776022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6A4620040;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D82B20043;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 04/10] KVM: s390: Fix guest / virtual address confusion in _essa_clear_cbrl()
Date: Tue,  2 Jun 2026 16:23:50 +0200
Message-ID: <20260602142356.169458-5-imbrenda@linux.ibm.com>
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
X-Proofpoint-GUID: BYKxJYus6tVGO9OD7OJnLRe4a6WnT_Db
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a1ee784 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfX7Ck8cSZNv6K3
 rrTuKKnqMhwgpFoowKuOP0RgIhDZEklFdfhFZfGahCjBGE0IyFNay0KgN34Y+EmS4IxA+zQq1A8
 Zs0lEMoZBry6HRQ9QmR+ogLih99rLYsuU2y8N1P1nQH8dtivMIEouPcNFmg5gJcwzJlnQVIORB+
 lTuUfWuKV1lJDzEiZOwzmJa5TubobvnyPSGq7nYgKGgUEYBltrY1v5ESlFVovFgO1nMt/MVfive
 dG2507P5f7aT0q7/Pq/B82LDRbPRoyOv8JILTsgchvW4nxJBPzvmvF87oILbcUHEe5+tBOIc+Gg
 6ZPnqTNmkjQd464tLuYO1ClMRKRhOO4W4LEEnzLO/g7RC2bnTTtuR8lAGQ2Sa4YIlQRP1rGjtyo
 Wn8tzmv8PEjEs0s4hknkkajeVyZLf9GKzjIOFY0D7Z+Y8vMXonXDUzTSatOuaHWtgeuKehk8WHx
 hxyRMJSVQfZOz9RAXUg==
X-Proofpoint-ORIG-GUID: BYKxJYus6tVGO9OD7OJnLRe4a6WnT_Db
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20376-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:borntraeger@de.ibm.com,m:frankja@linux.ibm.com,m:david@kernel.org,m:seiden@linux.ibm.com,m:nrb@linux.ibm.com,m:schlameuss@linux.ibm.com,m:gra@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E195B62F55F

Until now, gmap_helper_zap_one_page() was being called with the guest
absolute address, but it expects a userspace virtual address.

This meant that in the best case the requested pages were not being
discarded, and in the worst case that the wrong pages were being
discarded.

Fix this by converting the guest absolute address to host virtual
before passing it to gmap_helper_zap_one_page().

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index cc0553da14cb..447ec7ed423d 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1188,6 +1188,7 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 	union crste *crstep;
 	union pgste pgste;
 	union pte *ptep;
+	hva_t hva;
 	int i;
 
 	lockdep_assert_held(&vcpu->kvm->mmu_lock);
@@ -1199,8 +1200,11 @@ static void _essa_clear_cbrl(struct kvm_vcpu *vcpu, unsigned long *cbrl, int len
 		if (!ptep || ptep->s.pr)
 			continue;
 		pgste = pgste_get_lock(ptep);
-		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero)
-			gmap_helper_zap_one_page(vcpu->kvm->mm, cbrl[i]);
+		if (pgste.usage == PGSTE_GPS_USAGE_UNUSED || pgste.zero) {
+			hva = gpa_to_hva(vcpu->kvm, cbrl[i]);
+			if (!kvm_is_error_hva(hva))
+				gmap_helper_zap_one_page(vcpu->kvm->mm, hva);
+		}
 		pgste_set_unlock(ptep, pgste);
 	}
 }
-- 
2.54.0


