Return-Path: <linux-s390+bounces-20567-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7KJxDXycJWp8JgIAu9opvQ
	(envelope-from <linux-s390+bounces-20567-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 07 Jun 2026 18:29:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD283650F83
	for <lists+linux-s390@lfdr.de>; Sun, 07 Jun 2026 18:29:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=q0zjdVIe;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20567-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20567-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 508903011119
	for <lists+linux-s390@lfdr.de>; Sun,  7 Jun 2026 16:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF42D949F;
	Sun,  7 Jun 2026 16:29:45 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8962F7F18
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849784; cv=none; b=BDcMJqikksWKRPC0bag3jvsL1eMS/wATihK2JAWAbCIB8ONYu1yL92KwcSyBRwn+89usr0+y92OO3UNe9yvMdgF6L13dwtxzz/1AI8Nd0zGuP9OK3rfawtOiVzaaZu2gviq9jLym3bMW/K/KbBsM4WtAqGrkOz30oXpHs2d54Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849784; c=relaxed/simple;
	bh=S6xzXVB59kv1HMGLIwNYfNaaS+dlfeYzrI9rGH+8FaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0m0qPUT94AsJHr1TgN6ZVmbXRgUj6PCKSvpuU/joH5/I4MphuwJQsppz7l25HikC8cvoyobDuEAoEunuCThUASc3qyanlbSHT8YGA8InB8HItrnExeW8ax2tEyJ9lVQBtaPC/w2Du6BwUQI73/VMr9WwyIH0lfU7wzWk8Xm1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q0zjdVIe; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6571xnwP1628934
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8r9rV7NqPgBiNKNfa
	7bA6kGSO0hNMvoKXGI6l31UBjk=; b=q0zjdVIe4JHdf48wjBXaJHm4M4sIipLr2
	N8CXb1BmKbLDcLIMbjladr64B1BGGHzHQHjQN9+hi04R+TDk0H0IhEvmnKZQo2qQ
	HkdpZjzYCtCIwzM77op0c534PP7TuuPvACcfVSFWvr46MdPRERY12Iry7Im6kR4K
	R9SePT/YS841nCGCbbDk8bIBsQHTdsqT4asKdiljpoeYZC5Kcd589FznltuSiWKd
	An3I8X2EhJvU2iP/f7HYMWP2YPRJLKoWAFrpEnNPwU8m86KoflSJqIqA1duHH/1N
	iLSbykh6buVz3uDpzl13Zp36+2Rx7Jz/kgfx4i/lKv8hsy3PjmGFw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23m78w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:43 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJfpg018883
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:42 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03fsv1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTcjU48628200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B8C62004B;
	Sun,  7 Jun 2026 16:29:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D1AE20043;
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
Subject: [PATCH 7/8] s390/memmove: Optimize backward copy case
Date: Sun,  7 Jun 2026 18:29:36 +0200
Message-ID: <20260607162937.2927356-8-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a259c77 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=JR0CvQFn8sAsJeSSqqQA:9
X-Proofpoint-ORIG-GUID: IQpnzCcsugCc9jU1kFDM1XhZuuAD9lbD
X-Proofpoint-GUID: IQpnzCcsugCc9jU1kFDM1XhZuuAD9lbD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfX5zWAlJsXW849
 PIR8Y6Eag+yJ7yb+Q2cXG+lGVIg9T5Cgyv0G0/adM33vkpONrIpJU9XFGnUIemI3CntPmjoeUQS
 piPG/Iq3BK6k7aUVT2KGjLiFX69ygfSiP/HnXV9MrOhf089Y7ZwRwYppMCnYwwwGBqOca9W6QPi
 8Le171qGko1PR8HJYBgBd/dfeTzT85DuxACcP5FCWyXEC4RnIpWDomSxetoTexamICT5vYc7Aap
 ROf4FhjuHACkz1OAJpH9b4jwgj2U0GpsMOUbhFaH9zgAFqymLZz00QMs9a7dA525oDCIsxx3YUI
 2fdudtY/grP0SoRAQsRslnxzdzW0cX+jduKqKB5JrlK22xmFj9/1a2QqHkPPIhesaHygWWtNdr3
 7gUdax/7kvfd3qpXxUIw+TgGfpziMCh5OwYft7i7BJ/0l4G+olC8guoLaCoxeJREt+9jKGMfNdj
 t6Ezid09vZof+lFqnLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-20567-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:agordeev@linux.ibm.com,m:svens@linux.ibm.com,m:gor@linux.ibm.com,m:borntraeger@linux.ibm.com,m:jchrist@linux.ibm.com,m:linux-s390@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hca@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:from_mime,linux.ibm.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD283650F83

memmove() copies byte wise for the backward copy case, when the mvc
instruction cannot be used. This is quite slow, but can be optimized
with the mvcrl instruction, which is available since z15.

Some numbers (measured on a shared z16 LPAR) show that the new
implementation is nearly always faster, except for the non realistic
one and two byte cases:

size    old   new
   1    2ns   3ns
   2    4ns   5ns
   4    5ns   5ns
   8    8ns   5ns
  16   12ns   6ns
  32    8ns   7ns
  64   15ns   7ns
 128   31ns   9ns
 256   64ns  10ns
 512  129ns  18ns
1024  250ns  19ns
2048  498ns  38ns

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/lib/string.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/s390/lib/string.c b/arch/s390/lib/string.c
index 120dd2960fee..a188ad3f53b9 100644
--- a/arch/s390/lib/string.c
+++ b/arch/s390/lib/string.c
@@ -15,6 +15,7 @@
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/export.h>
+#include <asm/facility.h>
 #include <asm/asm.h>
 
 #define SYMBOL_FUNCTION_ALIAS(alias, name)		\
@@ -51,8 +52,29 @@ noinstr void *__memmove(void *dest, const void *src, size_t n)
 				: [d] "a" (d), [s] "a" (s), [n] "a" (n - 1)
 				: "memory");
 		}
+		return dest;
+	}
+	/* Backward copy */
+	if (test_facility(61)) {
+		/* Use mvcrl instruction if available */
+		while (n >= 256) {
+			asm volatile(
+				"	lghi	%%r0,255\n"
+				"	.insn	sse,0xe50a00000000,%[d],%[s]\n"
+				: [d] "=Q" (*(d + n - 256))
+				: [s] "Q" (*(s + n - 256))
+				: "0", "memory");
+			n -= 256;
+		}
+		if (n) {
+			asm volatile(
+				"	lgr	%%r0,%[n]\n"
+				"	.insn	sse,0xe50a00000000,%[d],%[s]\n"
+				: [d] "=Q" (*d)
+				: [s] "Q" (*s), [n] "d" (n - 1)
+				: "0", "memory");
+		}
 	} else {
-		/* Backward copy */
 		while (n--)
 			d[n] = s[n];
 	}
-- 
2.53.0


