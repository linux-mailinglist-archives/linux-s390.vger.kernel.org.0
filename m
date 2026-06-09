Return-Path: <linux-s390+bounces-20625-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +N97AVDGJ2qo1wIAu9opvQ
	(envelope-from <linux-s390+bounces-20625-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 09:52:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C1F65D619
	for <lists+linux-s390@lfdr.de>; Tue, 09 Jun 2026 09:52:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=DzTDLl39;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20625-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20625-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAFD6302D0F7
	for <lists+linux-s390@lfdr.de>; Tue,  9 Jun 2026 07:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0473E315A;
	Tue,  9 Jun 2026 07:52:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDDB389106;
	Tue,  9 Jun 2026 07:52:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991563; cv=none; b=EIw9gOmjnUjhmSNQB+0MaVfIXPWclF73+tU4eRwHrckrahvrXQorLuzlSovBQoxlCyMh+Wd8HWmfbazMgBGlBQY8nDjbsdv4/j5rERoScQXRPu+6IdpLvWKJ5oOd8KSB1z/AOwUQ162sDdQ+gIzA9naTsgdjDze4k34KSn2i690=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991563; c=relaxed/simple;
	bh=NrCRAOqJzAS0lDQoIdEva/tX3/WwKJEgGQ2ZOu8CWW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqiFKwVddbREY4O2xbcU7a0h8ioNkOqwSzOwVNErN83hLjRw9fX1wGxHazFhvxgVQ4CpLuBcrK7nX3deFr10mN1HTmUBH9go+PM+VgbJjf+5+qcgW2yiNqXhm6iJIvNDjycoQmf/xkjmOKYtjfn2JMLoQNt5yIlKJVIQxhQuIGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DzTDLl39; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65941s8r089638;
	Tue, 9 Jun 2026 07:52:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DYc3cGgBBezt3mSFI
	rbF/XfM/fkT1sZM6jzieYztkZI=; b=DzTDLl39g5Pcb4Lp2E/sRqhyjsFj9aXI0
	ieu+g52/aPsdkYUY9K/cIEg3wDug63NMpSQGtkS2NqRiPM61mJmqL1fDxRihZC+c
	1NShuVWYBr7eaO46coYj/3NVmnTsYhAOszNIpZ9ZweK0gpjcIx1w5bn12M4frcem
	IEJU2mIPWiFk6KhrWZBDvVtGddFSGlHPXLsUtFT/tBmyCRn0PWsHrCxZXwf43OOk
	D7Dxi5zbX/77EkTYL6xG88/KeDgW8kp9qD5sBR9tbyrHW2muDNMETvAt3gv/KLbH
	pD6RXnVUWcu8NnMSwio7oSbXgm8GgjajNxxQS6jGPZEF1UVJfZ+Lg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhu3jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6597ndAc005931;
	Tue, 9 Jun 2026 07:52:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g0t2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 07:52:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6597qV5H52625732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 07:52:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7143620040;
	Tue,  9 Jun 2026 07:52:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402132004D;
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
Subject: [PATCH 2/5] tick: Remove arch_needs_cpu
Date: Tue,  9 Jun 2026 09:52:10 +0200
Message-ID: <20260609075213.31094-3-meted@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MSBTYWx0ZWRfX8EvPRUMBmhqI
 oilUvsTQNUPQw+6svnhFLM+Ai+VbrsVDcOXSsM6kJ2fNfTFcFQna1hm4zY3Jb2yen7VSS+lPbmz
 /efkDLp9JWagaijHWkFOwf/EozqxTIYdTG3QCCOsFG268/oasCHeNqbShnbvRZWu0jky7Gm2jZE
 CqFOh8fIrqb4NKWLFh0TOOCnU0Zipf1dqOCUoCNXZQyqic+C51/VGY+Pre57hqG1JPh/rmJfgi5
 UxSR1ucKiRJq1ps/YUzt58egd1cwWKlDj4LnLV33MA/JITis5A0F1MHmjGoidc9a1A8zzX6Abbz
 gzo5qryOv789RO0cxT068Kdrz56qkk91J/oTvc7n1b4PRzJqdZ4SuVDuGrPI42RzqCNiGE7nupO
 SOXy7cv4frFaXq2TH5koD3saKcTv0IBHh70jLnPMvIAPQnXRUXubBaGVxvOSPaem7zeuMEVVwdb
 04NVE7UdiZoS15rJGGw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a27c643 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=-_MXh9RRoCZl6R2akIQA:9
X-Proofpoint-ORIG-GUID: IjqpRPbAfpAAYsXlXUWEogK2Ie6ODL1O
X-Proofpoint-GUID: IjqpRPbAfpAAYsXlXUWEogK2Ie6ODL1O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-20625-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90C1F65D619

Remove unused arch_needs_cpu() hook. No architectures use it after
s390 removed its use case.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 include/linux/tick.h     | 3 ---
 kernel/time/tick-sched.c | 7 +++----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 738007d6f577..0f6757f81839 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -44,9 +44,6 @@ static inline void tick_unfreeze(void) { }
 
 #ifdef CONFIG_TICK_ONESHOT
 extern void tick_irq_enter(void);
-#  ifndef arch_needs_cpu
-#   define arch_needs_cpu() (0)
-#  endif
 # else
 static inline void tick_irq_enter(void) { }
 #endif
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index cbbb87a0c6e7..cee18999d818 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -943,8 +943,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	ts->timer_expires_base = basemono;
 
 	/*
-	 * Keep the periodic tick, when RCU, architecture or irq_work
-	 * requests it.
+	 * Keep the periodic tick, when RCU or irq_work requests it.
 	 * Aside of that, check whether the local timer softirq is
 	 * pending. If so, its a bad idea to call get_next_timer_interrupt(),
 	 * because there is an already expired timer, so it will request
@@ -952,8 +951,8 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * minimal delta, which brings us back to this place
 	 * immediately. Lather, rinse and repeat...
 	 */
-	if (rcu_needs_cpu() || arch_needs_cpu() ||
-	    irq_work_needs_cpu() || local_timer_softirq_pending()) {
+	if (rcu_needs_cpu() || irq_work_needs_cpu() ||
+	    local_timer_softirq_pending()) {
 		next_tick = basemono + TICK_NSEC;
 	} else {
 		/*
-- 
2.54.0


