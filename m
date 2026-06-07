Return-Path: <linux-s390+bounces-20565-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LICrD3ucJWp6JgIAu9opvQ
	(envelope-from <linux-s390+bounces-20565-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 07 Jun 2026 18:29:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB2650F75
	for <lists+linux-s390@lfdr.de>; Sun, 07 Jun 2026 18:29:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=WeYFMfq0;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20565-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20565-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3420030107E3
	for <lists+linux-s390@lfdr.de>; Sun,  7 Jun 2026 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8BEF2FF15B;
	Sun,  7 Jun 2026 16:29:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF582D949F
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849784; cv=none; b=BgzV5i/+56JjkXyz9uIP0DYxqc630ZVS48gGh3nteyOFvJAh5q1bgmssHlHc5X+g+5mLWOFSsxdA02WKLsns+2wT1VPAdMqvIftIBZ9WxHUxIi22iQ/wcXiJPpAnAlAzwMWLAHqjCL2IzpjYkthkCPgM8fCNBZ2jPz108kqTNz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849784; c=relaxed/simple;
	bh=hlP04H5ZKh5RMz27Q3tmDc0RGZtYUrtIXwQpdbCr92Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lctvj0tJx4xyn/h/mG3818dudfHYarjaINGN1meHm+wuWclPbp2Oh3cZaUEwJAIVVG5PM/OC0l4VA8JbAkHrGRVUOPSUyNTz8eMFl8dq0oTsQDtds9mLiScda88HpW2+Wqx8Deiy5dKoperKEWlZnP16371lN4RIt5lLJ4FB83E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WeYFMfq0; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6571RKrF528624
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DTLFpG7lh9iMOLsfC
	CH5AYZ5c97p/65+NZbl+5O25KI=; b=WeYFMfq0rYJTexyN7elHY1U0Zl3Y+jbpv
	3zKaLcnX8kUERZjhA5nTzrG/1g/NmZpuItwlmGX6f7OFVAEB5xL8IQnsNk5BKZAY
	ERcc2xKqZTYHL12CjCAzz91PmzuQ/QvugjSq1ONDver1EK/bk4U8FVja/86z5m4w
	TNswgFBEOQJM4Zab+HLu9vTvG7A7QK/VbTJfnQO4wmokkTIpxQpMkSZjtqs51Wqp
	MvjOzZfYTqZAiEl/jfy1PmnzpY4POvtEXNjnf7UTgQLZFFF6af/dHJWbWCpXNsyd
	fECMIkXMULeP7WT4tL9vz0aV2D/wspr4qn888nAWkrxmvX0w0PMvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95463n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJZqN018847
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fsv1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTc8Z48628194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 305302004B;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11ABE20043;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 4/8] s390/string: Convert memset() to C
Date: Sun,  7 Jun 2026 18:29:33 +0200
Message-ID: <20260607162937.2927356-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260607162937.2927356-1-hca@linux.ibm.com>
References: <20260607162937.2927356-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WQ5kpAm36ODPKkmjWIAA:9
X-Proofpoint-ORIG-GUID: ih8q9X73C8RXQuGZbAxEBs6FrVDRlYhh
X-Proofpoint-GUID: ih8q9X73C8RXQuGZbAxEBs6FrVDRlYhh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfX1WzSbylIzWQE
 OuD0NS5OxDjSRk3NDtd5/zSPSiTFiOHXYe/5bVj4+MFLVO+Kp81Bo7r8prHC0lI13g4Dw25TXHu
 SbVumjb1o/h60R3xVVwIEx9Y+Rm5DHofAGoeECqVl+NLi7p/YjyVsM4h+gRLEhyWu9KtgCIEbjG
 pmrnKo21wOT96hDKAMA6ZdVtGC6X0hz/vEX74jMsO7C6bHzWpAcnjCQPXIIRsTQzF58YwsGwjSJ
 QYichR4koNeMiFtNM4wccHMZtPeN/zDc0MfqYQ3F/KruV6Eby2+12JU+PqgQzqmPRBfBTkGNic+
 dGX70k8QEDYtXDsQFFoc+m4nuHxYdK+W+acx+CE5ougUHQKhWp+8Y/lpgdjImOBcB7Sbq5pIUcc
 sDe5AJ0IeyO+OIc45CxGWh+V4uwJ3vbzXrYd2CUiIim9xQVRx2fvV6PqTZLkN9ZlZm+9PcNuzbr
 heC837Sh/DOSHChQtpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20565-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:jchrist@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:from_mime,linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A5BB2650F75

Convert memset() from assembler to C, which should make it easier to
read and change, if required. And it allows the compiler to optimize
the code, and use different instructions, except for the used inline
assemblies.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/mem.S    | 63 ------------------------------------------
 arch/s390/lib/string.c | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 63 deletions(-)

diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index 712b955ea9b4..a27b103d7450 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -11,69 +11,6 @@
 
 	GEN_BR_THUNK %r14
 
-/*
- * memset implementation
- *
- * This code corresponds to the C construct below. We do distinguish
- * between clearing (c == 0) and setting a memory array (c != 0) simply
- * because nearly all memset invocations in the kernel clear memory and
- * the xc instruction is preferred in such cases.
- *
- * void *memset(void *s, int c, size_t n)
- * {
- *	if (likely(c == 0))
- *		return __builtin_memset(s, 0, n);
- *	return __builtin_memset(s, c, n);
- * }
- */
-SYM_FUNC_START(__memset)
-	ltgr	%r4,%r4
-	jz	.Lmemset_exit
-	ltgr	%r3,%r3
-	jnz	.Lmemset_fill
-	aghi	%r4,-1
-	srlg	%r3,%r4,8
-	ltgr	%r3,%r3
-	lgr	%r1,%r2
-	jz	.Lmemset_clear_remainder
-.Lmemset_clear_loop:
-	xc	0(256,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r3,.Lmemset_clear_loop
-.Lmemset_clear_remainder:
-	exrl	%r4,.Lmemset_xc
-.Lmemset_exit:
-	BR_EX	%r14
-.Lmemset_fill:
-	cghi	%r4,1
-	lgr	%r1,%r2
-	je	.Lmemset_fill_exit
-	aghi	%r4,-2
-	srlg	%r5,%r4,8
-	ltgr	%r5,%r5
-	jz	.Lmemset_fill_remainder
-.Lmemset_fill_loop:
-	stc	%r3,0(%r1)
-	mvc	1(255,%r1),0(%r1)
-	la	%r1,256(%r1)
-	brctg	%r5,.Lmemset_fill_loop
-.Lmemset_fill_remainder:
-	stc	%r3,0(%r1)
-	exrl	%r4,.Lmemset_mvc
-	BR_EX	%r14
-.Lmemset_fill_exit:
-	stc	%r3,0(%r1)
-	BR_EX	%r14
-.Lmemset_xc:
-	xc	0(1,%r1),0(%r1)
-.Lmemset_mvc:
-	mvc	1(1,%r1),0(%r1)
-SYM_FUNC_END(__memset)
-EXPORT_SYMBOL(__memset)
-
-SYM_FUNC_ALIAS(memset, __memset)
-EXPORT_SYMBOL(memset)
-
 /*
  * memcpy implementation
  *
diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index c4fa71a341a7..557ef2e5a16f 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -63,6 +63,67 @@ EXPORT_SYMBOL(__memmove);
 EXPORT_SYMBOL(memmove);
 #endif
 
+#ifdef __HAVE_ARCH_MEMMOVE
+noinstr void *__memset(void *s, int c, size_t n)
+{
+	char *xs = s;
+
+	if (!n)
+		return s;
+	if (!c) {
+		/* Clear memory */
+		while (n >= 256) {
+			asm volatile(
+				"	xc	 0(256,%[xs]),0(%[xs])"
+				:
+				: [xs] "a" (xs)
+				: "cc", "memory");
+			xs += 256;
+			n -= 256;
+		}
+		if (!n)
+			return s;
+		asm volatile(
+			"	exrl	%[n],0f\n"
+			"	j	1f\n"
+			"0:	xc	0(1,%[xs]),0(%[xs])\n"
+			"1:"
+			:
+			: [xs] "a" (xs), [n] "a" (n - 1)
+			: "cc", "memory");
+	} else {
+		/* Fill memory */
+		while (n >= 256) {
+			*xs = c;
+			asm volatile(
+				"	mvc	1(255,%[xs]),0(%[xs])"
+				:
+				: [xs] "a" (xs)
+				: "memory");
+			xs += 256;
+			n -= 256;
+		}
+		if (!n)
+			return s;
+		*xs = c;
+		if (n == 1)
+			return s;
+		asm volatile(
+			"	exrl	%[n],0f\n"
+			"	j	1f\n"
+			"0:	mvc	1(1,%[xs]),0(%[xs])\n"
+			"1:"
+			:
+			: [xs] "a" (xs), [n] "a" (n - 2)
+			: "memory");
+	}
+	return s;
+}
+SYMBOL_FUNCTION_ALIAS(memset, __memset);
+EXPORT_SYMBOL(__memset);
+EXPORT_SYMBOL(memset);
+#endif
+
 /*
  * Helper functions to find the end of a string
  */
-- 
2.53.0


