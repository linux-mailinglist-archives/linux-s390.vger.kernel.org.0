Return-Path: <linux-s390+bounces-21223-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TcbNLYC9O2o+cAgAu9opvQ
	(envelope-from <linux-s390+bounces-21223-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:20:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D43B56BD9A5
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 13:20:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="SVAV/bqv";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21223-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21223-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07B36302F744
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 11:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22FA39D3FD;
	Wed, 24 Jun 2026 11:19:42 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC953876C6;
	Wed, 24 Jun 2026 11:19:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782299982; cv=none; b=XqujngN52GIm81WpD7eYGXIx/+XhcX8L1VQU31Y3LimFNJ0p4j/28kbAa1wenNqj16XB4hGxb5/7j9EDB1poY2ZKtXO0YYmtp4ux+clmE0Yu0qxZqgo9PgPIaCI57V7UV8lgyInNM3m9YwU33Mpax2hL1tM6Tahvnt9sbK/mQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782299982; c=relaxed/simple;
	bh=53SI4vKMIt0FeBooMrBrZbNZDxagb6pM32QG548Rn4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U78g7t077HrRyUWjwbbmJdoHJCIC4PNYJUMHzDfbmQrOTQyzaAYggqB0DvVRVnAJGO0UiQTe3LVbND/AWUTQfKSP9PiT1rK9I5U9bkIdddEkFGa5aeeeyZ2z4OzD5lRdJ09P/s531G1xeVGa7Y12UL98IvfXQ0UTwgQYmrsj8sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SVAV/bqv; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAn2Sw596518;
	Wed, 24 Jun 2026 11:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sVlDRGefuZJV+FnTQ
	XwZdWQngPdUe4/yXtTQary57vY=; b=SVAV/bqvcxVoy6Ef4lyyT6I1htYzU/t4X
	Wuez0XWzLvs5fEcinIy9Q5kguO+FaToV9fKOgCB4h0xB0kDsGFurG1iAwo3Tqcef
	gtrX5BZZBIu5JQ+PQt8D6QjpMeXBdVuBu6MTIJCLpLx4oTG1S1/8TnFOZHNCYIA3
	araF5uD0OFLIBDTrtxoF7Nm+gVnJBfmZdFiKkHYf8wnThGKlIRd9cpovJyglv7p9
	IYrOY6ka4pmqP6nHRsahKOy3VIlsj2KayuDB4dp7lE+S6YSUW7FidaFGYem/omhu
	2l1RU2YmYu0K3tXG0qlRnspkB8gXIUBsQJgzgcJnO1zT3XJX2XKQQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9huwtj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OB4hxb013452;
	Wed, 24 Jun 2026 11:19:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phg67t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 11:19:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OBJURU42074526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 11:19:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE87420040;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F42E20043;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 11:19:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/12] KVM: s390: Fix typo in UCONTROL documentation
Date: Wed, 24 Jun 2026 13:19:19 +0200
Message-ID: <20260624111928.144283-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260624111928.144283-1-imbrenda@linux.ibm.com>
References: <20260624111928.144283-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Layb6rLZSRqp-YOulZ6GnhVKQAbPYTih
X-Proofpoint-GUID: Layb6rLZSRqp-YOulZ6GnhVKQAbPYTih
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3bbd48 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=yvqMKCNcDOEYtg3BjRgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX3ggmuVfCy2CP
 n8DI553KMKYcH3P3630dXJ8R1vszP/5EbgZCXtO7/hB9+/MmthkBC67afWrJ2qQcjAXtE/HOGNU
 QOv8lT3PdTSBKCFOCuDBIuU7mVtKQv/ArzF/MbkvjCPkv+mTDu6bYGvLogF4N0hZAwtKFah2rLU
 U6nfwShMUoHmVnb6C7ev8khuBtcsssHqUKQ64HeWN/mOsLHN/pqhMyxwp5quX9qBXkXx+UzjbLi
 NcCrIUlbeeK8tx2DpFYoeTOnuff6bHJiZTemkWJL0bRiV6Zn2I85CqrKYeH2Z3tlcj7D/xGOXeP
 pjhdqFe47fWKsJwBd4DLwuEs80trTDNo5g1ohuV62hT6G8oZyEad5hbLb6hsAt/JchLwO6ldVAu
 Rvdbzci6yBR5BHxlIDq3N3+ldG1DGA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA5NCBTYWx0ZWRfX9lTXKY1Y+lCv
 lOI7SB69NF9Yf6XKPhxwAOvAhvlYLQeYBFQmk3xFfMUaitiVnPCztvjGpbHMOtbZnXI6cP81XYU
 WBMDKm4Odpxr5x+el/zuTkeWkz5/au4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0
 phishscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240094
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-21223-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D43B56BD9A5

From: Eric Farman <farman@linux.ibm.com>

Small typo noticed while writing the USER_OPEREXEC selftest.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260507200836.3500368-4-farman@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 52bbbb553ce1..f0eba90602f0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6827,7 +6827,7 @@ s390 specific.
 		} s390_ucontrol;
 
 s390 specific. A page fault has occurred for a user controlled virtual
-machine (KVM_VM_S390_UNCONTROL) on its host page table that cannot be
+machine (KVM_VM_S390_UCONTROL) on its host page table that cannot be
 resolved by the kernel.
 The program code and the translation exception code that were placed
 in the cpu's lowcore are presented here as defined by the z Architecture
-- 
2.54.0


