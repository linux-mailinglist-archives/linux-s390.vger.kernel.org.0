Return-Path: <linux-s390+bounces-20417-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rqhUOT0YH2oUfgAAu9opvQ
	(envelope-from <linux-s390+bounces-20417-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:57 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67204630DDA
	for <lists+linux-s390@lfdr.de>; Tue, 02 Jun 2026 19:51:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=snIdCoEM;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20417-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20417-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E50B30645F3
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jun 2026 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35135364E84;
	Tue,  2 Jun 2026 17:48:33 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55DD3FE356;
	Tue,  2 Jun 2026 17:48:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422512; cv=none; b=X2ffAbZbNGNxq7wzpyZNwMD5O+O8AZUzIPgTsnJIBeis813IrOJyxCoXsWJsMPHm5Y/X0xdABL2V5EaMhvV4eL8Nq+SsmeLrOMSuFQNfYltZggp9uZ8jNheXhmLUiNESr9C70HSpXU3Z5dxvIce78D0LtXxmbyweWB4+3IAtmEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422512; c=relaxed/simple;
	bh=wfGhd80OUCsmbFWYgG09TpaL9k11qW+2femCQoIMakU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqBtU2sBq9xh8ox4aLPp4jVpJyak1XEwmbaPDG41kbexs9R3/Cj7W1GhBAKOpX86tr933RWw3Hua8cwerVo5DpSvbna8C64SHk3F7THGYzmPQp5lCt7wJgcpuro0erNGGCsYbG3BNRdWqLkXPsNNR7hvO3737cmaJdwaLYOjnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=snIdCoEM; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HDgmu2292402;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5Dj57ICE500jl0kfr
	5MGW51DtNyt2I++QQFprmxD4eY=; b=snIdCoEMEYxlofZmqL/iok1MNSmkkUGHu
	8aOJTA8u6bILokZ+txmlstJO0bVcLlDLcmyXDbeU3MSR50p8883qISR8M5GZPKrA
	vR8KOHWvLAEY6CkajpnV/oJnrmd26COi6H/o3WZiHVakhxLacAG6QvpzgdAjoxQ8
	ykHXdbaFs2VMXcVOHym6lgbMYpsQvKw+NDFQGks863zevd/rLQxyXM1n+p4asVrP
	U1q5s9EbCnzmjRuo3r8XyYasYQE0EbKp+YwfBqHrjVD4gimUnKrhwE6ln8xe79pD
	RRwbYL+bJQBRH1T0B1Nrk5/aUSmRuHeZ6csAnmvtKj3Qc8BpvxpEw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq774m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdWtX027977;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4ek1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKnm48955654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38BF42004B;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B9632004E;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 06/10] KVM: s390: Fix fault-in code
Date: Tue,  2 Jun 2026 19:48:15 +0200
Message-ID: <20260602174819.255785-7-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yIulx8mdwg_Rrzez_TJYJhA5MNcILGA9
X-Proofpoint-GUID: yIulx8mdwg_Rrzez_TJYJhA5MNcILGA9
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1f176b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=p5SjDoQbJD9XZwj20uYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfXxO41uB0s3dMm
 2O9VL8xo8cCsaKc0s6fISxD7Yjx2rdd3o1H+AUkrJEoPB9aSVkIyEEB/FJ8u8AKQD7wK8KvT790
 klVic+u70Qx5zR4mhDQADumJLBWlhwz1Nyt+Pqyxf7Gl3Ot2NwEE3tZlJ4KpfABKiHsZXfkMDEu
 rIMV5Or887KOv3tsPvqlk6AkS3lypWpl3tn5HfR3Vh60t9+cxFJgwOj1MjHbu2j6ZsNkx++4/Dr
 85cwZRL14hcZfqxowNqki5cefWJCGzA1bAMAp8eKjIzqhJP9Ow0EUcYdaycnz20MmA9MbkYkuFc
 1khTvQN5ZWOA/P9tBBUp+YWhpHJHgtTDh9cxa8b0RfXBMdOQ2aNSQDWY9uYay6HngEkOXk6/JnH
 gXVtitekghXfCrOXvkqGwabcPNdK9FjtQtQmyjjjWjO/0eQHmbRVdRLa1IxUd7SdSnYtkbvHcCV
 a5N64xQUJhvMQ5EqNng==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-20417-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pbonzini@redhat.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:frankja@linux.ibm.com,m:borntraeger@de.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67204630DDA

Fix the fault-in code so that it does not return success if a
concurrent unmap event invalidated the fault-in process between the
best-effort lockless check and the proper check with lock.

The new behaviour is to retry, like the best-effort lockless check
already did.

This prevents the fault-in handler from returning success without
having actually faulted in the requested page.

Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-7-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/faultin.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index ddf0ca71f374..cf542b0a7e8e 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -36,7 +36,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 	struct kvm_s390_mmu_cache *mc = NULL;
 	struct kvm_memory_slot *slot;
 	unsigned long inv_seq;
-	int foll, rc = 0;
+	int rc = -EAGAIN;
+	int foll;
 
 	foll = f->write_attempt ? FOLL_WRITE : 0;
 	foll |= f->attempt_pfault ? FOLL_NOWAIT : 0;
@@ -53,7 +54,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return 0;
 	}
 
-	while (1) {
+	while (rc == -EAGAIN) {
 		f->valid = false;
 		inv_seq = kvm->mmu_invalidate_seq;
 		/* Pairs with the smp_wmb() in kvm_mmu_invalidate_end(). */
@@ -110,20 +111,19 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			if (!mmu_invalidate_retry_gfn(kvm, inv_seq, f->gfn)) {
 				f->valid = true;
 				rc = gmap_link(mc, kvm->arch.gmap, f, slot);
-				kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
-				f->page = NULL;
 			}
+			kvm_release_faultin_page(kvm, f->page, !!rc, f->write_attempt);
 		}
-		kvm_release_faultin_page(kvm, f->page, true, false);
 
 		if (rc == -ENOMEM) {
 			rc = kvm_s390_mmu_cache_topup(mc);
 			if (rc)
 				return rc;
-		} else if (rc != -EAGAIN) {
-			return rc;
+			rc = -EAGAIN;
 		}
 	}
+
+	return rc;
 }
 
 int kvm_s390_get_guest_page(struct kvm *kvm, struct guest_fault *f, gfn_t gfn, bool w)
-- 
2.54.0


