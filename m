Return-Path: <linux-s390+bounces-21941-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/SiBrW8T2oingIAu9opvQ
	(envelope-from <linux-s390+bounces-21941-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:22:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B08732C9F
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 17:22:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=O8PmaVLU;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21941-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-21941-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD63330DBD2E
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 15:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F59366567;
	Thu,  9 Jul 2026 15:15:33 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4A3624CE;
	Thu,  9 Jul 2026 15:15:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783610133; cv=none; b=SfDtQwkFOgTvCoWZOPWj/CyvQK680P8GbWC/Z+GOKiHql6quiEi5iCooypMikTlfr7orsGNGjuiUyjLxIDTCQNgj5yjPQ6GrzWhr6sJMm866t7YXLyniZB2XvPwEvIrBXXuT24W8qBH2sROl4psoLx5VyxK8uHwkfmtippU/QSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783610133; c=relaxed/simple;
	bh=TOlQZt7EVr/qA4BgGrENpGu1NDlhJE5z7zs388qbPCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZTMTxH73vlIsZHY9nAabYJ1a/rKJSfo4FmwEjjGUDN+PZIUQ3i6xLXhgf0A8UW5+I2R25eRJLpi9wjsUN5+igCu/GKM70xOGq/PdxsMod6sIIgPoZsnX/wAVYZ1RMuU88hxkbnHY3XBN5KUnOgNZThnPDj4G2HFiIeThwxyID1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O8PmaVLU; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669EIawH1770266;
	Thu, 9 Jul 2026 15:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BMXWyB
	XwKv1RHvFfCXPr7a/NUKP7F4r3MXv6bQcW7QU=; b=O8PmaVLUlM06LU9UGXooQW
	pk58egD/wTc0BEIshj6X7sLTHW0dvVezV/Twtq/prEPc6bzBzPQP0MPJhD8a7wMp
	EOB68emAkl6k+T8WNHMl21FYZvY6uAxcj1PLnOMN3fx0lZcIkaJ8qmNSipPA1FOn
	tKkdYAE7Qn7RBYJmBm7FJW5i7/VS1QsQ83RnUGZ/OvVOE56PZp6Ydzu4YizCbGFI
	0j7D62q/jQZIeXghQrALPbDtrMNogNWowosIJuwyz7oKSBFqyfFGj4YAUho6dlEq
	kP3VpzE0hGgUYWTkb67HBHYS1RW93CZBgXfehHEquSTfBNlbQaxbX3DSVbxG2Zug
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke2ppt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669F4m9u026959;
	Thu, 9 Jul 2026 15:15:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwdvcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 15:15:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669FFNKm10486250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 15:15:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEDE120040;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B06F2004D;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
Received: from [192.168.88.251] (unknown [9.111.64.199])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 15:15:20 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 09 Jul 2026 17:15:02 +0200
Subject: [PATCH 02/21] KVM: s390: vsie: Remove duplicate assertion
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-vsie-sigpi-v1-2-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Eric Farman <farman@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=767;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=TOlQZt7EVr/qA4BgGrENpGu1NDlhJE5z7zs388qbPCM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDFn+u5m89k5l2l3C99J7t67pvKVTi4TlYq2Ppp5bHzPf5
 +njyQtOdJSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRdAFGhq9r+hsuC0lFev3S
 z99pdmzzEgmd6zafhZg+Vz6wbNML2czw32XnB2ffbatPfqw6zadw6IAsP/ve2zl272/mnzV3m2p
 dzwsA
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4fbb10 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=TUp8s0cp9ye6Ph6o2uoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX8HNgoZhCXFAW
 IOnxxwOmjmd7ZULcTbOUl/IqGtl241iAyp+3MLQ+YbAK28gB6sPIQpts08k77XKdWOfxN0n0lK3
 ViRUMDjZdK953eLSrC9S9/zLuf8vseWqD5MTOrC6+3VOzDC4Wu41j11iqZ+jmYpqBtOtjf94Ygi
 lBLp0+kfHHPzlmlrRsMhWwcq1r2m7p7MMrFkB6v/CsorhOQGlKcqZKYOc4Z4GRqGVFJDuOQbohR
 kYR1rdPC3WnNCuT1oRq37Xkf+nj3NPK6K9kZKZhMoSBsRW6EBUM+Ik77RQWSt+E62GCcmEr2G5A
 n6dbXvVP/VyhOyZknGN0pilDTgOLmo8YbiCqEuTOn4ogH/y/AinZhAjxkLf7AadRhrEjPeTxxv1
 wKMd9TN0XJC6N1wPzwaZZbSuVJMfZaPRN5np9/zGeb+XMkaGnAI6UaBNoZLPibgC6Nskx9QlmWA
 a3OxvCRYOuWH9sd3unw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfX5L8flZBasREk
 ukrzuGsqTvp+rI7ULBj5USyie+xUeBXlzT2QpcmznkYas0YjLNViMxIB5baNrlOiq+cS3z1Wus7
 PTR9l8Flf7rxSTdPI9gVlPv6chL6yRc=
X-Proofpoint-GUID: HfTxm8BdntIgsKrXb2jMN3zGiaDnU17X
X-Proofpoint-ORIG-GUID: HfTxm8BdntIgsKrXb2jMN3zGiaDnU17X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21941-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:david@kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:frankja@linux.ibm.com,m:imbrenda@linux.ibm.com,m:nrb@linux.ibm.com,m:svens@linux.ibm.com,m:pbonzini@redhat.com,m:shuah@kernel.org,m:farman@linux.ibm.com,m:schlameuss@linux.ibm.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER(0.00)[schlameuss@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[schlameuss@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6B08732C9F

This is covered by a static_assert at the struct vsie_page definition.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..3e956c7faa4b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -1565,7 +1565,6 @@ int kvm_s390_handle_vsie(struct kvm_vcpu *vcpu)
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
-	BUILD_BUG_ON(sizeof(struct vsie_page) != PAGE_SIZE);
 	scb_addr = kvm_s390_get_base_disp_s(vcpu, NULL);
 
 	/* 512 byte alignment */

-- 
2.55.0


