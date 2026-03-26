Return-Path: <linux-s390+bounces-18136-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAM5A/UxxWkn8AQAu9opvQ
	(envelope-from <linux-s390+bounces-18136-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 26 Mar 2026 14:17:41 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CCC335D09
	for <lists+linux-s390@lfdr.de>; Thu, 26 Mar 2026 14:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB289301688F
	for <lists+linux-s390@lfdr.de>; Thu, 26 Mar 2026 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC6D2989A2;
	Thu, 26 Mar 2026 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tnupxy7B"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87C81A5B9D;
	Thu, 26 Mar 2026 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774531056; cv=none; b=PnZIDSKYnO9Cy8OxhB9uGsNZGa32RxSsmA0H8/T0jlDPMAVKCJAy9Bsz6YBMUk9iMA7UbTX1gS8HYSMAidK1w/RHfbvPeDzpi8Es6vNr0Oj0/X/AeQOhb35m78eiphzAyAZSl2P5Ac0R7Pm8aOTf22mqN593OKsGRFdXD9Dc/3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774531056; c=relaxed/simple;
	bh=OJ0YppEpXxWljpnDo2C4R25lit9Ina1zpzH2IgqgCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMp+T9+1PeLDX95oo3858UnQaWVDwcBDRWgtJNkL7QmrXbr3/oVezn07gfup7SYlKeubzB5RJb3L1zn/nv0vtihpNMNR3N9mzh3JoNOxP/nYds07iMuHD4sh4elKih9scBP+Qv7cEAO1o1QzmpiVubxZyYa0OTnjmSvWqGcPMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tnupxy7B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q685V73481709;
	Thu, 26 Mar 2026 13:17:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=oDSu/bQDxMYWLBwio
	nStkeQoi6NLCfGdNBrHSiGUtoI=; b=Tnupxy7Bj1qh9vdTyF0lIwpXDPndQnI87
	JLS6QsCsSHmfa2fSSqNwUzHo8juOiWss0m6wxKwEg/h48l9RYTAOxF695KKCHj6d
	jYXJI83nQ4tDgs4r2reXcK2IuJUMKwVeUUO6m4LsSYhqspSK36jPTgscbMbV85uj
	Pcp1NRJoGrUqQyWD/coPgQsc787ep9jYWM93p1Vul/0mokPzaMgF2oUTrpfq502y
	vs+ctBZYMEZv8/OsHHjF46F6WpHSxt0ddtQGKlZ5hJSeJwVsQWTD/FIEgfOI1p2Y
	Woik7Nr5kH/BdgdG1Zc+adaQgfoNZXOMHDGEM/YHYTGLWbTso9iWg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqnd1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QCYNq0011789;
	Thu, 26 Mar 2026 13:17:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vkavjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 13:17:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QDHNuL10879264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 13:17:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2AA2004B;
	Thu, 26 Mar 2026 13:17:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B5E320043;
	Thu, 26 Mar 2026 13:17:21 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.23.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 13:17:21 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v5 01/10] KVM: s390: vsie: Fix dat_split_ste()
Date: Thu, 26 Mar 2026 14:17:10 +0100
Message-ID: <20260326131719.98229-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326131719.98229-1-imbrenda@linux.ibm.com>
References: <20260326131719.98229-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QG55oLlAZYJ_e-iUJmuGG0axHXMz-eJA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5MyBTYWx0ZWRfXwPdbX2e9Ygcz
 +udyMrpUlHzbn1fjGEubhz7Rp/5qP1gGVO60gsjGN/32kWadXgG+22PzADuX8QJvlSkPGcWshkg
 kiZiT/dFfa1gzbT/yMcHnq8F0fWstSlSVhlBiPW+7S5RHOtkfu0q1ApO5MU8l4P8yjYS2mMcPuk
 ISfRdtGzpniS8gi/s/VkOl7vQKjvhlfMjx7jOEXvU4Z8Lc2x5ThCNREX7ylTn4s5YDxOFCznAN2
 LWaOTQBgzor9w7aUIyyBXSw9L2XBDzMAJ7LGp8GPON72onOkcx+R7q9tosJ29typBDIUEBXpAzn
 1yoU7rYcePjoLct2pRC9WLVmaPMo9mhNoS8KTsaU3ta6kfHrUyoVnvsKYfTU8POOQlphWDc1HQT
 iHT1z8hxqFDsRuzXk83xCPQZY3V0TsMTutUmpAetN4uEYTsRwk96RbyyEJo2IOp19FSdt22VkOR
 qqm5IjNBO1/dWQnuB3Q==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c531e7 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LsQdvuOhCgcXfIND9tsA:9
X-Proofpoint-GUID: QG55oLlAZYJ_e-iUJmuGG0axHXMz-eJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603260093
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18136-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-s390];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: A4CCC335D09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the guest misbehaves and puts the page tables for its nested guest
inside the memory of the nested guest itself, and the guest and nested
guest are being mapped with large pages, the shadow mapping will
lose synchronization with the actual mapping, since this will cause the
large page with the vsie notification bit to be split, but the
vsie notification bit will not be propagated to the resulting small
pages.

Fix this by propagating the vsie_notif bit from large pages to normal
pages when splitting a large page.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 670404d4fa44..48b5f2bcf172 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 				pt->ptes[i].val = init.val | i * PAGE_SIZE;
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
+			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
-- 
2.53.0


