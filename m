Return-Path: <linux-s390+bounces-20624-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0H0+MU7GJ2qn1wIAu9opvQ
	(envelope-from <linux-s390+bounces-20624-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 09:52:46 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D0E65D616
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 09:52:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=oc+aPLbe;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20624-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20624-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42B96302FA0A
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 07:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F8E3DD503;
	Tue,  9 Jun 2026 07:52:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC00383C66;
	Tue,  9 Jun 2026 07:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991563; cv=none; b=Gv3BZggimZljkP8nJKnmieIV6mYHUvzswV0kgdmE3E6CPVDnDiM+cfDfh5aLGvU04n6GoLDxPHtfwfNtAZsdNwrAH/Y9dsoF9HrwdaVJx+Ons57X0gIR9NPUtXQvh/IZ+bFPE3kvi5I6Hpa5y5AOtTHC6a0xAI9eH8EuJpW1AhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991563; c=relaxed/simple;
	bh=FKtk9vkWFHIy5Oc7pySJJLOWBxMG1gh6JwD6BrSRssA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RV3bVQDVJr/GooBfp3xBR721N5SE/nsr/8BbskHGSKJGwUKf9sChf1P1MZ/XxYHjRCrc6A3i5Ug5wzur7U//0iZG8usZvFFzeZqZA69xC2XpVa50eQicbhh7/Xrv0VmjXVQzQ6bCExkG/qoBqnRDHvHJswAGIRic/hXHNjW+wa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oc+aPLbe; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659439LD4191465;
	Tue, 9 Jun 2026 07:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OwhIdjORy5BGBf1Dg
	cPIOnWOImCHjcrT2Pne/Ce6pRs=; b=oc+aPLber5jrN08taLVv+oLsyKEzdS0dg
	qVkLac3bCRmmEM7V/Vbe0odXyyqOcRF0mKRYc65Hc4inw2saqMeWc8ZXbq1eKcXO
	eiis5VWj3Ukx/0THIdgbzu7lvkflgE7kr2DVF5gBlmReROOH6ewwCRg2fiDi2i00
	hVZJEcRLif8G941L8l2NHvu5Nkwz1lJ7N7ktJAgYf84IEwm1B1k0z/I6YRv2zisD
	D+Lw5qmsRYNWWAOkLTIA1HvjzXUbhSxf0BQSKN0jI8hfG0Kjt/r5YWOpPRe73+eE
	a6w59/lbFbwXLRVsJKcc3fFCSWTIQI7VgqLxjljoWdxu8ovAN8iRQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhu3jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597ncbt022402;
	Tue, 9 Jun 2026 07:52:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w13c7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qVlW44892496
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B286620040;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76B5D2004B;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from lenovo-pc.ehn-de.ibm.com (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>
Cc: Mete Durlu <meted@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/5] s390: Enable TIF_POLLING_NRFLAG
Date: Tue,  9 Jun 2026 09:52:11 +0200
Message-ID: <20260609075213.31094-4-meted@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609075213.31094-1-meted@linux.ibm.com>
References: <20260609075213.31094-1-meted@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX9I3zj/sX8DHa
 l0EQb7Bgy9txxIWsl1RbcR1dd1mKpuOtmMz+TJzhRsc6wo71e//d87wtMY9x6iZjlq8QMFgTS4p
 BmCLYLdxMi6Bpedv4JxqV5Vfsc1o/qseX8MHl4bQNI4HGlxuRzeZMQo7k5HGIupwEopqEgXEyGE
 C6sIy08grC2zmWvT/f/abrFGIp9NOFm8fY7lXTQGOTT05ns0b6uiDiJiacmzWOKH78riLSWSoya
 MlFXbcsuhS5wm5WF4YNMOLaIYiedpk/rTXCiScB8qUK/PXlQomz+dfKc/8OKPnH9Y9cZ1Adyvxf
 aPjwipfrzsf8+ivKe3Xok96jKg6I+oMubnqBzxXFbn4xEVlYGNE3h+8LIhVW08CApMPgrgowtje
 +cDD36edfIVB0fHp3/W494sx2QVMGj3vxovlAiqMfFgz7/HYDMXf0lsMPvUJ4NkPcz+fl3UGtj3
 gIfIPp/Yn+TAxpRiEnQ==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27c644 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=c5jR2BqudvT-Uhvel0MA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: fv1EL5m4V-kEMzziiBd-rGQMzbJ65c7a
X-Proofpoint-GUID: fv1EL5m4V-kEMzziiBd-rGQMzbJ65c7a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20624-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:rafael@kernel.org,m:daniel.lezcano@kernel.org,m:christian.loehle@arm.com,m:anna-maria@linutronix.de,m:frederic@kernel.org,m:mingo@kernel.org,m:tglx@kernel.org,m:meted@linux.ibm.com,m:iii@linux.ibm.com,m:borntraeger@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[meted@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[meted@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38D0E65D616

Enable TIF_POLLING_NRFLAG to support idle polling state in the
upcoming cpuidle driver.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/include/asm/thread_info.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 6a548a819400..2554cef3a6a5 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
  */
 #define HAVE_TIF_NEED_RESCHED_LAZY
 #define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_POLLING_NRFLAG
 
 #include <asm-generic/thread_info_tif.h>
 
-- 
2.54.0


