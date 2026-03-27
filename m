Return-Path: <linux-s390+bounces-18247-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GQSB9KixmnrMQUAu9opvQ
	(envelope-from <linux-s390+bounces-18247-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 16:31:30 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D48346C6B
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 16:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8EE630F577D
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A529330B2D;
	Fri, 27 Mar 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SFq9FRk0"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CF32E121;
	Fri, 27 Mar 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625049; cv=none; b=cqfX3DEtW/MCgzWUgpSb8+WGDWG21ukdQA3Vx/xV8Ng7xU3ULc8ddUSUW+3XxEwzxvyT9vimQRBH11mX07gHsh7SyjZeMKu1KXzj7V16VMlu4FZzRrp/i1NqEwBsSomesErBqC3otsvBKNGssv/CPjtZSMQFrBwB4B0UHq8oJFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625049; c=relaxed/simple;
	bh=ti0htlWK33Jbc8brUj8Zndqm4bKthhnU7+/6u71a/DU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwxjW95lsfxjnV7Xqddr2/bop85VUcdHfnpChGIvjHcYMS0lnwTvZJiLCRciYNkQRyR0wy5prAUQF423gdQ/7kU9tHrQT4gvChS+PG7iC4HHiogsrhQvwkPbJ2KScaf8s43LVkcOT1QRgahqWPaWEWjALqGFdwdz/qSTf3vvNyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SFq9FRk0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R5P9am1455972;
	Fri, 27 Mar 2026 15:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KU53aohDc1DIaJDPs
	hcavd0t9XI41ejgGK2ppbGNluE=; b=SFq9FRk0IKvvaKZ9jYJYeP+qRso1zlxV5
	l+VoL+8agUc1OJg29fsn84ApWcZVyqbnB5ZhTGFx5rNijgiq8tlm2LkifZoHQkww
	vUga7obBOER3D8tpb8wW+rusW0GD7VmcFcCIMjpxaCbR6SWGc6/2CErHvhuLKhZL
	gdZS+PlO+OII1cOf1Q5fZErYByp9lqWOiiROPfFmdQnTq+qhYiYPbr6gL/H5AA62
	mBqEDw278+gS4iMRvEu1djXjB0M1tKU377FQG8+jnnrkCD38YvK/hAzChQ2QHoHS
	9DRxEHgZw5OeUh96lHzTzy9vWwTuOlHwvA6XQKmD9JZGnXtlxOKvA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwaatxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:05 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB0tSE026685;
	Fri, 27 Mar 2026 15:24:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m7wsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:24:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFNwcI39387468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:23:58 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78E232004B;
	Fri, 27 Mar 2026 15:23:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E125820040;
	Fri, 27 Mar 2026 15:23:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.84.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:23:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 01/10] KVM: s390: vsie: Fix dat_split_ste()
Date: Fri, 27 Mar 2026 16:23:47 +0100
Message-ID: <20260327152356.250625-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327152356.250625-1-imbrenda@linux.ibm.com>
References: <20260327152356.250625-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: L1jxYgoj-p846fZSlJJLXtdEsYpmTCXt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX5mTGhhUKfoTA
 tuvh6u+wMCGFoOHw7Hv8DapPBIWfLTOJ/lX4iGJCeqHOTrXlYOvv12niC+muRWnSdAUVlgcBPDo
 kT/VM044L/zlr64ntsOWLqgwgW11bcGaSKTCEtwzoDL8KJw8nWXe22RfOepc3zKTx7cs6LY5u/q
 DE2xkL/o207u3DC6hXgvuy/CCaVOQ2Uj9edzBqop/GxDIi3R9cJUBVwnKxYRJ/ZGvmchmNMXT20
 ZT+z7PcqghWKvpv69BGFcmt8eMOmv3XElZurT1byESpliHPlvInykp5mTO1fJMILPqYL0Up3wZi
 SnhgYxW+eE76jWB3R58L5AnKC+PYE6nBHSN4yqDJM741o60ow6GdojZ2e7nfknZmjTR5SaUeQtG
 ULtGULebVY8fbZVAVsqUT2T2/Gm+HReBVgkvGIhpWsGuPUulNmV9pjrTA5eH5evDpAHBqyVpVyn
 QVywaLBk4mqNxWd25ng==
X-Proofpoint-GUID: L1jxYgoj-p846fZSlJJLXtdEsYpmTCXt
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c6a115 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LsQdvuOhCgcXfIND9tsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105
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
	TAGGED_FROM(0.00)[bounces-18247-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imbrenda@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 93D48346C6B
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
Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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


