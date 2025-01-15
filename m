Return-Path: <linux-s390+bounces-8317-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58331A12923
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jan 2025 17:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61AF18818F7
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jan 2025 16:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F618C939;
	Wed, 15 Jan 2025 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l7R1Z7YN"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E415688C
	for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2025 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959631; cv=none; b=nqwr/FzBPkNsZF7H6CRgQP/f9dmP6n5QUAiK7NVH8W5ycr75lLhJgY60VQNQUQXyKBS5DSopRYBkZt/+KTx71Ou5qxWrJNBKHwYHB+GreHU8OsOp1rbiJDWW+f5pYyzB30c4NWR3CeNsXHx52ZrTWxKstOB+L59RGpRTGO5NyQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959631; c=relaxed/simple;
	bh=+dFP6gqvRl0Q5C9fGP7aNGiidrnGPK3rxYBBvzIbToc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cD91O9TyDVgr2Ems05Ts0c7DjM8gqpVE1ICeO8NW+x59E4/txh4w+WDjAq3qRTkDrK8bAWFSF5rzbWDMx+kNLSg/0tWjwWr0v5cT6N5KRY/2P62O0bnAmbp/T8qTOpoKEzkAExq2NalyafN7WC1FnMLa7srGSzHzVtB1vsIMwSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l7R1Z7YN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50FGYWt0025296;
	Wed, 15 Jan 2025 16:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=/xEjZ5QLk+cHDnkEwe/214w2jybYrqmhihr7C+9/O
	Z4=; b=l7R1Z7YNky+rsYT97uXkdz1a8EFQA7oOnWrh6pXqlR4pBbNaGl2Y4KO1R
	RLOxhwDwGfx1ug/tZlgSIhwWktCs4in1bNOPe5xtqVWrpKRXENMmCBIuLYe4YG9N
	RRnuSscp7tg/wFIaJIqBl+rqc81vxLffhcfxgBRDxK24tA5+L6wATgvlprRW/W8y
	33+k5Jxu/5p0kADBwHI7qYMeXdTJ0t7F3hnWw/+30xhfYSKJt1HznEEarmiJsSXz
	LTZpQh9pKlGTENelPlWi5avAA06GSSuPfc5iPaTcKob3wIKB1tNXQh+p7NIuz9Hi
	W3DnExC1aMxy6ecJdbxI3hAetz+Uw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44622hv4bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 16:47:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50FF6uis000875;
	Wed, 15 Jan 2025 16:47:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44456k13nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 16:47:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50FGkwPS39649756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 16:46:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E85742004B;
	Wed, 15 Jan 2025 16:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D47320043;
	Wed, 15 Jan 2025 16:46:57 +0000 (GMT)
Received: from funtu2.fritz.box?044ibm.com (unknown [9.171.28.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 16:46:57 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, dm-devel@lists.linux.dev,
        herbert@gondor.apana.org.au, dengler@linux.ibm.com
Subject: [PATCH v1 0/1] dm-integrity: Implement asynch digest support
Date: Wed, 15 Jan 2025 17:46:56 +0100
Message-ID: <20250115164657.84650-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PRvaO_0ljhca45ql-m1naLPs7NTDnjkV
X-Proofpoint-ORIG-GUID: PRvaO_0ljhca45ql-m1naLPs7NTDnjkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_07,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150122

Use the async digest in-kernel crypto API instead of the
synchronous digest API. This has the advantage of being able
to use synchronous as well as asynchronous digest implementations
as the in-kernel API has an automatic wrapping mechanism
to provide all synchronous digests via the asynch API.

Please note this code is elementary tested but needs some more
test coverage before integration. I can't do that as I only have
a s390 platform but I assume someone from dmcrypt/dmintegrity will
run a more sophisticated test suite on this.

Changelog:

v1: First implementation. Tested with crc32, sha256, hmac-sha256 and
    the s390 specific implementations for hmac-sha256 and protected
    key phmac-sha256. Also ran with some instrumented code (in the digest
    implementation) to verify that in fact now the code runs asynchronous.

Harald Freudenberger (1):
  dm-integrity: Implement asynch digest support

 drivers/md/dm-integrity.c | 220 ++++++++++++++++++++++++--------------
 1 file changed, 138 insertions(+), 82 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
--
2.43.0


