Return-Path: <linux-s390+bounces-21510-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NhuhE7eFRmoyXwsAu9opvQ
	(envelope-from <linux-s390+bounces-21510-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 17:37:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 389826F9800
	for <lists+linux-s390@lfdr.de>; Thu, 02 Jul 2026 17:37:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=pZTJoLgA;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21510-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21510-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74E973059847
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2026 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8693D9546;
	Thu,  2 Jul 2026 15:24:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D394381E92;
	Thu,  2 Jul 2026 15:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005867; cv=none; b=JdjzaR6h7NBQU4gw+56FYUwsmb3e4VDkzWhSjNA4DzecN5kosT5rhu1vnSes1onaA175RtXsdQTMtgS1U4Wkw857esSuNtJstlPiKJpo4cGvdWSSBKekjQTzNyaoG4QhM2fAymJ2bC0JjFA19MyQUzHzhN99uO1CcNprUNZr4kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005867; c=relaxed/simple;
	bh=Sa+oniOnVYb9jKvl1ualRgSlroO6ot99KDOL2X63sIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brEtRIV3ZMIN3wg41AjspjT26smWUewZcnCVZT0vM+MvqaKxhJw+SKB673ExUzPbav4ZUDnVsgyccnBWz6N4d7kBhC4qrq1nagt7KYeMEEuXrnW5g3TGAaXfIF7djEyEyEo/qkibfrozyCDMXjbYY67r85NFBE16M7sTE5ZNWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pZTJoLgA; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIIOV4134433;
	Thu, 2 Jul 2026 15:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kul72ig/8J1rVJTSV
	MJ3I+cFUPD6jJA0uUg9ScMEhT4=; b=pZTJoLgAXXkpQ6ZEH0C9Whz6eytgoXJs5
	D588bdaklIaqc/ZKKDvC0D7td+hPyCtITdES2pyDZ7KjLPlQiTAE4naHjxJRg6bR
	8nv5llf6u8EiSfSjwur0MjzCP7S4WksMCCuEvt+YSEg9IBTwcxqaqdrokEKguxAS
	RWAQ4cRFQ+g+UBnd0lbJAD+zLkNnHqwkAwLKWxs5wR0SDDnlvYWkUiYunBZWCl3M
	H6jED7lj34tmWARqLQM0V25j+zzjV61wQ8woJcFtDcbN42m9EZtvobeBrsi/6ruV
	qI1kOdq7CiLRBKGtJJhLSoo5COC3//jn+ZEvvghaH0Q1dgVfu9pmQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pear4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJdok016325;
	Thu, 2 Jul 2026 15:24:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmgkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FOGMx50594282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 949A520040;
	Thu,  2 Jul 2026 15:24:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0F7B2004B;
	Thu,  2 Jul 2026 15:24:15 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:15 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 8/8] KVM: s390: Improve kvm_s390_vm_stop_migration()
Date: Thu,  2 Jul 2026 17:24:06 +0200
Message-ID: <20260702152406.204782-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3fbdZsggY7XwL2iiQT3BFzdsEAi9jyG7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX6dCClF0whQqr
 hzkN/aGq8bu9O8oZSoq0HTpXlGRNKcratsxL7M9uiRHxI3YcJYjqYh34JOhMV3utHpgUkfvg9j2
 Nq4pTtUSo4YFhLJV54eMK5FNS/j2RJI=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a4682a7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=rYcZ_IOZh9ftmSSm4-EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfXyg4jUqpvyj7l
 G9tYpDRN07NT6QqIBDZN8oqS+juBRNU5ieIk+a7v/DK8ZkcV8YAffc3z6JAr6mAR9itYSRGLRA+
 wKjPgTV5A/hkD+QLn7n7uf0RSAPDoDJyj5HyHVvXgfaTc8VLm60tj1yh4SelVzTO3i6/2loE3+W
 ftlF4AT98B3z1eoG3p8vZNBSswE1dgM3L+Jdp/rmaR1sDp0OBldPLBlKu1Lu8oo70yY3ga7d8jx
 2Qny/UUbuCmXG8JcV5mIGq9CrxUI7U9WWSE6ar5/m+HQh/dYzSyj61e65dAh7KmBaKxVJEy5wnS
 +CKXO2vmFNRsPkValGjgz4mo0wMLUA44ztTibuNy5wYihmzCamMm9KmKo/5yZUSdIr4WMO17XGW
 ENIqgn7gw/t47+51bYK4AdmLjU0CuIaccK5enTYzi6w8y0DmDWX9BFA6KuVPiOJc/JSMX0TunMy
 lDWulFwmCT/6U5lcLEw==
X-Proofpoint-ORIG-GUID: 3fbdZsggY7XwL2iiQT3BFzdsEAi9jyG7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160
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
	TAGGED_FROM(0.00)[bounces-21510-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 389826F9800

There is no need to clear cmma-dirty state if the VM is not using CMMA.

Skip the CMMA-related code if CMMA is not in use.

Fixes: 6cfd47f91f6a ("KVM: s390: Fix cmma dirty tracking")
Fixes: 190df4a212a7 ("KVM: s390: CMMA tracking, ESSA emulation, migration mode")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2ac3a9ac4698..deec673a9206 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1280,8 +1280,10 @@ static int kvm_s390_vm_stop_migration(struct kvm *kvm)
 	 * PGSTEs might have cmma_d set.
 	 */
 	WRITE_ONCE(kvm->arch.migration_mode, 0);
-	if (kvm->arch.use_cmma)
-		kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
+	if (!kvm->arch.use_cmma)
+		return 0;
+
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_STOP_MIGRATION);
 	/* Clear cmma_d on all existing PGSTEs and set cmma_dirty_pages to 0. */
 	gmap_set_cmma_all_clean(kvm->arch.gmap);
 	atomic64_set(&kvm->arch.cmma_dirty_pages, 0);
-- 
2.55.0


