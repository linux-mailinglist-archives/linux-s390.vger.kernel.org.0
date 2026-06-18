Return-Path: <linux-s390+bounces-20997-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id p/FDFjcFNGoPLQYAu9opvQ
	(envelope-from <linux-s390+bounces-20997-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 16:48:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A57CF6A101D
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 16:48:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=iSKJjA+X;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20997-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20997-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94846304411A
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 14:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462EE31690E;
	Thu, 18 Jun 2026 14:47:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFA61C862D;
	Thu, 18 Jun 2026 14:47:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794063; cv=none; b=W+EG5VCaqlYHZWThALXJgK0VUVa4KSWBKnK6egkBhz1Cl5ylGxmg1q3EOyfjtjplFyGqN92/JN72iNGVPIU1/hI72xCHbFP3H44qtpi7FW8apc7+OC9Fi2pdq//io2wkm0tsWI6Ju1yPSduxkwBixhp9TnUjfh3WjtCOUp6E6gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794063; c=relaxed/simple;
	bh=AJIcykkNHK8IFWDf8N3eMg6vymINa1yH4yd43N06UwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CWip3JqRqzQIIvTbRJtkUT29uTc3ZK48GGbINgsHxC34DLpvmZE3bj2E1SoLOZL2QGp/HdCrhnQM6/fQc2L0uqzpzcGyLlJraRaeqP69apWKckPP5+JKDwDu/njxpa2GRbamznneTJJKmFILaX9af/Np1yKOVYnWdKMq8dqJ3dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iSKJjA+X; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IEIFBi3688625;
	Thu, 18 Jun 2026 14:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nBocLtnNWkEW0LgQ0lTGeERkqajb5IUlQLup1K96h
	70=; b=iSKJjA+Xsu2yHRBTgLyzIrOopuE+ohd4DxhKOUAAyjYQarckRAlHk6kwM
	mQVf8tkBde1llOYtfi88NMY0lHWTSPWJPJBn8cjKgdd46zNRXnp3fg3pxHnPuKZq
	jj+YKVq5e0gRZS0hXp2odWCNj5d6YWRViwyYoSo3rrPB7PuQz3GrLV3cQC4bb4O0
	+R271R3PKyIYxJpDyudjbYw70FHFhIHML+qtc01zXgVaucUPdHQxIbNFUhwGvBTL
	Gr/4xYKmN5ilL5fJY4W5bPE4X+F+XmL4df9ORsOj/hLIfiMkp+JoHOeoqyPhviOU
	c6L/AyS+bPlHch6KYfu8qwynkBnug==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqtrq7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:47:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IEYaum012600;
	Thu, 18 Jun 2026 14:47:32 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17247tf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 14:47:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IElTkO49873332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 14:47:29 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C0722004B;
	Thu, 18 Jun 2026 14:47:29 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2B4E20040;
	Thu, 18 Jun 2026 14:47:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 18 Jun 2026 14:47:28 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id C4B59E074A; Thu, 18 Jun 2026 16:47:28 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH -next v4 0/4] s390/mm: Batch PTE updates in lazy MMU mode
Date: Thu, 18 Jun 2026 16:47:24 +0200
Message-ID: <cover.1781789772.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jVQySmv3zW6sPQjwDmrcsCyhbJDMY7ZC
X-Proofpoint-GUID: jVQySmv3zW6sPQjwDmrcsCyhbJDMY7ZC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfX9SMUhdzZbTnn
 I0Fzmgv4UY3basnvEQ2JRHDhnK4j/KXsCSxjGZgSvdJEoXnnNhc+PcbMlA/N79RSyxerFJfAt3n
 88HQvA/LJ1GrnolnG+fMS+ynuvfDe0jJNch0l453OjGTUTTsZKRiNr2xlwrFo1aKNuecY6zJQWV
 OCpcmEnGaaF6RSMV5594lHVQbb8IyqYu84TWyrKsHm66JgwzuLApjzZxPIMetphlcs06+MeiQ9I
 C3y7nA7U/LQaYpBo0XxUAZJhOf4m73wQacEPAowIiS4DpfOA8poInYMc2sjOr6XpiAFUIToKVLA
 laKxCKaV8+fa30nctttnehVXJPm1TDTvXp0jhVXNzy2wb82KtM4QG2X6RNj77FW6ION+yrekwJj
 Y9h8vLkzJuGC9dH27t+5JlTZjter+tfb9+xB6RLQmEFD+wP/N+4lF0zqtL+OPggXacK0xBJ1VDN
 86kIvkk46LoeDqDVK0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzMyBTYWx0ZWRfX4K5E1EbtiOnl
 TlGGf0gjXYq6bnEIN2wnAQVVokTZ9rSzU+2Q3GJWYLlna+JwSs20eV/OdixaKUz+0mThHo79dN2
 Fa6QszUPoEp3BBXF8o2bTZGEQ6tf+6k=
X-Authority-Analysis: v=2.4 cv=B4KJFutM c=1 sm=1 tr=0 ts=6a340505 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8
 a=TRBNZcfPePrm8P-CY9YA:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180133
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20997-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:borntraeger@linux.ibm.com,m:gor@linux.ibm.com,m:imbrenda@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kevin.brodsky@arm.com,m:david@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[agordeev@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[agordeev@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,linux.ibm.com:mid,linux.ibm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A57CF6A101D

Hi All!

This is v4 of the batched PTE updates in lazy MMU mode rework.

The presented implementation sets up per-cpu caches in the s390-specific
hotplug callbacks as opposed to CPUHP_BP_PREPARE_DYN hooks. I like this
approach better, since it locates the SMP-related lowcore initialization
in one place. But that is up for discussion.

Changes since v3:
- all prerequisite patches are landed in -next and removed from the serie=
s

Changes since v2:
- lazy_mmu_mode_enable_for_pte_range() renamed to lazy_mmu_mode_enable_wi=
th_ptes()
  (David Hildenbrand)
- patch "mm/pgtable: Fix bogus comment to clear_not_present_full_ptes()"
  is dropped (David Hildenbrand)
- direct PTE dereferencing KASAN sanitizer added (Heiko Carstens)
- CONFIG_IPTE_BATCH option is dropped (Heiko Carstens)
- PTE_POISON changed from zero to 0x800 (Heiko Carstens)
- allocate per-cpu caches on CPU hot-plug (Heiko Carstens)
- introduced a lowcore field for fast lazy mode checking (Heiko Carstens)
- few minor code changes (Heiko Carstens)

Changes since v1:
- lazy_mmu_mode_enable_pte() renamed to lazy_mmu_mode_enable_for_pte_rang=
e()
- lazy_mmu_mode_enable_for_pte_range() semantics clarified
- some sashiko comments addressed [1] including one bug fix [1]
- patches 2-4 added

1. https://sashiko.dev/#/patchset/cover.1774420056.git.agordeev%40linux.i=
bm.com

This series addresses an s390-specific aspect of how page table entries
are modified. In many cases, changing a valid PTE (for example, setting
or clearing a hardware bit) requires issuing an Invalidate Page Table
Entry (IPTE) instruction beforehand.

A disadvantage of the IPTE instruction is that it may initiate a
machine-wide quiesce state. This state acts as an expensive global
hardware lock and should be avoided whenever possible.

Currently, IPTE is invoked for each individual PTE update in most code
paths. However, the instruction itself supports invalidating multiple
PTEs at once, covering up to 256 entries. Using this capability can
significantly reduce the number of quiesce events, with a positive
impact on overall system performance. At present, this feature is not
utilized.

An effort was therefore made to identify kernel code paths that update
large numbers of consecutive PTEs. Such updates can be batched and
handled by a single IPTE invocation, leveraging the hardware support
described above.

A natural candidate for this optimization is page-table walkers that
change attributes of memory ranges and thus modify contiguous ranges
of PTEs. Many memory-management system calls enter lazy MMU mode while
updating such ranges.

This lazy MMU mode can be leveraged to build on the already existing
infrastructure and implement a software-level lazy MMU mechanism,
allowing expensive PTE invalidations on s390 to be batched.

Alexander Gordeev (4):
  mm: Make lazy MMU mode context-aware
  s390/mm: Batch PTE updates in lazy MMU mode
  mm/kasan: Introduce helpers for lazy MMU mode sanitizer
  s390/mm: Lazy MMU mode sanitizer

 arch/s390/Kconfig                |   1 +
 arch/s390/include/asm/lazy_mmu.h |   9 +
 arch/s390/include/asm/lowcore.h  |   2 +-
 arch/s390/include/asm/pgtable.h  | 163 +++++++++++--
 arch/s390/kernel/setup.c         |   2 +
 arch/s390/kernel/smp.c           |   7 +
 arch/s390/mm/Makefile            |   2 +-
 arch/s390/mm/lazy_mmu.c          | 401 +++++++++++++++++++++++++++++++
 arch/s390/mm/pgtable.c           |   8 +-
 fs/proc/task_mmu.c               |   2 +-
 include/linux/kasan.h            |  16 ++
 include/linux/pgtable.h          |  46 ++++
 mm/kasan/common.c                |  10 +
 mm/kasan/kasan.h                 |   2 +
 mm/madvise.c                     |   8 +-
 mm/memory.c                      |   8 +-
 mm/mprotect.c                    |   2 +-
 mm/mremap.c                      |   2 +-
 mm/vmalloc.c                     |   6 +-
 19 files changed, 659 insertions(+), 38 deletions(-)
 create mode 100644 arch/s390/include/asm/lazy_mmu.h
 create mode 100644 arch/s390/mm/lazy_mmu.c

--=20
2.53.0


