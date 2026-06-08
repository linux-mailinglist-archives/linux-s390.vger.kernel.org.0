Return-Path: <linux-s390+bounces-20574-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VEl1CsNVJmoWVAIAu9opvQ
	(envelope-from <linux-s390+bounces-20574-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 07:40:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F78652DD4
	for <lists+linux-s390@lfdr.de>; Mon, 08 Jun 2026 07:40:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=BwJNS1RA;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20574-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20574-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61FCA3030EA5
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2026 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7730DEB5;
	Mon,  8 Jun 2026 05:38:01 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6060735836A
	for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2026 05:38:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897081; cv=none; b=m1LVatEXHo7nsrQQb/3yyqFM+34j49v/29vVyiGaxBYO39s3052vMRAWJ/3MJuJknVWLaxjoMXM671lfoD9ZQVZHioX7qFyWsx7wQrrUZsezC2oXe8Kov08UQaURstq1czZPLVuAJiTQ5J7QTEt27nKVT3aLjkFHkYPkZy3RtVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897081; c=relaxed/simple;
	bh=kwErJ/BxgqU6fuT4y9xc3KkVzkkZyfeqDJIbSm9UZHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcWDwz7YX345g8Tstl8zFlr5QoGSXBB/CK3rWNFisQlEzlUfLmcSJyAHhe/dMXF8RO0Yh7NJUSE1ZQh7iGKjH0jytkApeZ71NEMiskGMCbtxHRQFS/5KmRvBeI4Tr8H6NFYpcGK4SvBHNPh8AptDPBVyap+FzcXBlEOLx7+rQEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BwJNS1RA; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657NfGAc4023506
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wQ18PaDRVZA6dHLmf
	4f5VpRNCTufoL5PGIbREboayKQ=; b=BwJNS1RAEdOlTKHuwKRerjEaxVOKMFBxJ
	I+AM2FaxxCQPli2fWscQouswez+8yEDbE6ZTq9l4RhwF7uTXSFnJW3RdzPgvnEFn
	8YcNiGIZ64KaZjWPVtaqHUNeFBjhFt6hq+Uku0khA41SC10qy3kIfFCBzbS0fz8Y
	re09hKEJKYELYtUpYDp/z3mNZeuRPYED0rbzAq829iL4Xi7DRZ3q5FuZO3Ss7tMZ
	IS31FD+BdjnsRNjaPa+dLfBV108eR6rGJgtIZ/+UsyqnAYv1n1Hy19vEn4NQNzrz
	NWTIs1/j5IVkmHc4YGqSKswn8wFfpzDWsgVr7zF3rub9fjsjshxbg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6snp58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6585JdEG009906
	for <linux-s390@vger.kernel.org>; Mon, 8 Jun 2026 05:37:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjkxfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2026 05:37:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6585bshf51970422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 05:37:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B465520040;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95F862004B;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 05:37:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH v2 1/8] s390/purgatory: Enforce z10 minimum architecture level
Date: Mon,  8 Jun 2026 07:37:47 +0200
Message-ID: <20260608053754.571282-2-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053754.571282-1-hca@linux.ibm.com>
References: <20260608053754.571282-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZRh5ls2xA0jQRMDGN5Axtqq28wu7FIeV
X-Proofpoint-GUID: ZRh5ls2xA0jQRMDGN5Axtqq28wu7FIeV
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a265537 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=foj3guEW7u1rp_cjtnkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0OSBTYWx0ZWRfX5m/fIQ2siqqU
 wVaedUgq53Gc6Cg2JONDSsFIIU0d8h8r1tnB7HKqnJt4YdwFmrAINXhVcaK+XpBnb/fgyu/TxFL
 HeHilUeuT5hs/3/jVtx/l0EssVCUv1058ulonL1Wp8ZqMYXlBcLQQTuzFRyIkxIqDDo+Gm90kOD
 E6O/86gEJZ9paA0lc5nxyb0xOm1OsF/QjFsIgsCHoizvLMSJBs08kk9adBZKPCtJzBM6og2vcL6
 eKicskLfIfxlLGQeL41BKLy1BRTF1vi5hRhcfCq/gJyQczfS5wyuIGgFtAt3BwzS0EZYMUPnoUx
 c5c9bby/EIgQWFsuGbLku8bmkP3Iu7ACZmW5iDx9q5PxsjhZnbj3vzmcqI55KbIBhBF/qpXsPMg
 wBf54JLDhgwZH2jxzRPZUSU+cw7oMWrymCxmifxban4SqpB8tkq3ssW+L3kLajhUlrXKhMv3D83
 qaJG/gIq2E3TqQq6D2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080049
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
	TAGGED_FROM(0.00)[bounces-20574-lists,linux-s390=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77F78652DD4

The purgatory code is compiled without the -march option. This means the
default architecture level of the compiler is used. This can cause
problems, e.g. if instructions used in inline assemblies are for a higher
architecture level than the default architecture level of the compiler.

Use z10 as minimum architecture level, similar to the boot code, to enforce
a defined architecture level set.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/purgatory/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 95a8ac45b67e..f55764d0c49e 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -13,18 +13,20 @@ CFLAGS_sha256.o := -D__NO_FORTIFY
 $(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S FORCE
 	$(call if_changed_rule,as_o_S)
 
+CC_FLAGS_MARCH_MINIMUM := -march=z10
+
 KBUILD_CFLAGS := $(CC_FLAGS_DIALECT) -fno-strict-aliasing -Wall -Wstrict-prototypes
 KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS += -D__DISABLE_EXPORTS
+KBUILD_CFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_CFLAGS += $(call cc-option, -Wno-default-const-init-unsafe)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
-KBUILD_AFLAGS += -D__DISABLE_EXPORTS
+KBUILD_AFLAGS += $(CC_FLAGS_MARCH_MINIMUM) -D__DISABLE_EXPORTS
 
 # Since we link purgatory with -r unresolved symbols are not checked, so we
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-- 
2.53.0


