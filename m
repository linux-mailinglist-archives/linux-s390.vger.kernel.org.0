Return-Path: <linux-s390+bounces-11221-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD39AE43BA
	for <lists+linux-s390@lfdr.de>; Mon, 23 Jun 2025 15:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 772E83BFD3C
	for <lists+linux-s390@lfdr.de>; Mon, 23 Jun 2025 13:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF6B2528F7;
	Mon, 23 Jun 2025 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9L0s/dE"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E8F252906;
	Mon, 23 Jun 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750685284; cv=none; b=rzpeWHYN/PhXFfrj794AsGwjQ5++A8BVV9mHiSfjJWGoyMAGuP+xV+WMILzlLPUcKysHn3Lhj8g7qm4wM1hRKLu8sz1roEBwC7dOqdZjEeMFouuYlxMo8HT3V8ppZxkR29GL7BkOowpiszgaSluLUagaJpiwLRLfA7SiMaUX5cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750685284; c=relaxed/simple;
	bh=n6RIUD9DP6GWvJJTEFATOHhJavMzM8tqJ0OKod8X+Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EW9ekpyTYSeUkc94id+shFrhdcMwfw2g2DuGLmyDX1nv2G/37hLTS2HFUa1qn2pLVPk+RexqH5iuw99EBETYU73zhHkc/3npioonu3tPQszf8fHOo9SCT5axFn0OLIRIkDAPJXiZRteFAd9kfv/FQ81YcQPidWV1fxhzsqBoiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9L0s/dE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NBH2b6012616;
	Mon, 23 Jun 2025 13:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z1JaYHuVN8VJQ3/gZ/JUSZxd0LSWUjAPB536MxejH
	HQ=; b=L9L0s/dESWGGqMB+jc1JmssiNOozYOqyqpFLN8YJuVMxdHoa0jky/mHTp
	ibdjeZIlnWfBcBGLzcxXdA/p9aCQN8N19keCDqaBthODVdEjokdEHkfXrx9Cfze/
	qSIC/9rXXQDX0SqYPPZUXzl9Z8EdSASLjHnjvBZ72y3OL0cW1cHMP2Vo3Ymia+hI
	yeJJyY4waYJJFsFN/8Ju5l2B8pGVFAmfh+UjqVcWk4ERDU5O538nW82oO1kHcw62
	cMfbyDeYqh4A39o5Vh9PAueWPrIcY3+3jfSRPNU8fGTurMspE/lMoJSQ+gbKUHL8
	jR/XIlIc1YeEK6h3E+wni+KlVkUjA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme126q3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:27:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NCb9Mt014748;
	Mon, 23 Jun 2025 13:27:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s26jm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 13:27:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55NDRlQM18219504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 13:27:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E30F20043;
	Mon, 23 Jun 2025 13:27:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D926C20040;
	Mon, 23 Jun 2025 13:27:46 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Jun 2025 13:27:46 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, japo@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf list: Add IBM z17 event descriptions
Date: Mon, 23 Jun 2025 15:27:31 +0200
Message-ID: <20250623132731.899525-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=68595659 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=C7w837nsZv_T6zagVp4A:9
X-Proofpoint-GUID: iXm7ZmvswJxCXbmgqm4Tz3RMLFM8tcyk
X-Proofpoint-ORIG-GUID: iXm7ZmvswJxCXbmgqm4Tz3RMLFM8tcyk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA4MCBTYWx0ZWRfXwDxFTgzIfkdD Vcm5IAhjAgCi1zyuMjy+oIOgZ88KkfjqDmORJLOS7/4GWJigbcKwv7q64EPajXeT7nszK7qlKuP wKZ0yK7v59vc6l91LtBHggKiVGoWDdisWv8aSPSz0W7hNHEE+CC+Kd9GnYPTdJ71nS47+xfYQBF
 B1ZlumGbM8lKaCz05XHJiUWc5rDpjdskkodM7X5ivHlSpSS9mcS2o2HvzYPPVtt8OZTo/lddHP0 SCblnp4v+fIz0j/Trf1WW4ZZVtN69mqnJ2lU64DPPSXrEDaYaY/zL83Zy0IUf9zYm9fV2FrcIEB VtY0FX2TiwXBYfVTsJGWT2ebduTX4iHIW9BzMJTFV/m6mmjfUw3DkIy84YLUHi/dNPaFQ75aG3q
 KjCy1SxHKGgYcgBkYy4Z3iB7ML58dCXoqfcdurZ5PmzuLJ5O+HV5+f3OXs8qBn89NvJbQjdE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230080

Update IBM z17 counter description using document SA23-2260-08:
"The Load-Program-Parameter and the CPU-Measurement Facilities"
released in May 2025 to include counter definitions for IBM z17
counter sets:
* Basic counter set
* Problem/user counter set
* Crypto counter set.

Use document SA23-2261-09:
"The CPU-Measurement Facility Extended Counters Definition
 for z10, z196/z114, zEC12/zBC12, z13/z13s, z14, z15, z16 and z17"
released on April 2025 to include counter definitions for IBM z17
* Extended counter set
* MT-Diagnostic counter set.

Use document SA22-7832-14:
"z/Architecture Principles of Operation."
released in April 2025 to include counter definitions for IBM z17
* PAI-Crypto counter set
* PAI-Extention counter set.

Use document
"CPU MF Formulas and Updates April 2025"
released in April 2025 to include metric calculations.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 .../pmu-events/arch/s390/cf_z17/basic.json        |   58 +
 .../pmu-events/arch/s390/cf_z17/crypto6.json      |  142 ++
 .../pmu-events/arch/s390/cf_z17/extended.json     |  541 ++++++++
 .../pmu-events/arch/s390/cf_z17/pai_crypto.json   | 1213 +++++++++++++++++
 .../pmu-events/arch/s390/cf_z17/pai_ext.json      |  261 ++++
 .../pmu-events/arch/s390/cf_z17/transaction.json  |   72 +
 tools/perf/pmu-events/arch/s390/mapfile.csv       |    1 +
 7 files changed, 2288 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/pai_ext.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/transaction.json

diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/basic.json b/tools/perf/pmu-events/arch/s390/cf_z17/basic.json
new file mode 100644
index 000000000000..1023d47028ce
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/basic.json
@@ -0,0 +1,58 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "0",
+		"EventName": "CPU_CYCLES",
+		"BriefDescription": "Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles, excluding the number of cycles while the CPU is in the wait state."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "1",
+		"EventName": "INSTRUCTIONS",
+		"BriefDescription": "Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "2",
+		"EventName": "L1I_DIR_WRITES",
+		"BriefDescription": "Level-1 I-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 instruction-cache or unified-cache directory writes."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "3",
+		"EventName": "L1I_PENALTY_CYCLES",
+		"BriefDescription": "Level-1 I-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 instruction cache or unified cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "4",
+		"EventName": "L1D_DIR_WRITES",
+		"BriefDescription": "Level-1 D-Cache Directory Write Count",
+		"PublicDescription": "This counter counts the total number of level-1 data-cache directory writes."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "5",
+		"EventName": "L1D_PENALTY_CYCLES",
+		"BriefDescription": "Level-1 D-Cache Penalty Cycle Count",
+		"PublicDescription": "This counter counts the total number of cache penalty cycles for level-1 data cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "32",
+		"EventName": "PROBLEM_STATE_CPU_CYCLES",
+		"BriefDescription": "Problem-State Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the CPU is in the problem state, excluding the number of cycles while the CPU is in the wait state."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "33",
+		"EventName": "PROBLEM_STATE_INSTRUCTIONS",
+		"BriefDescription": "Problem-State Instruction Count",
+		"PublicDescription": "This counter counts the total number of instructions executed by the CPU while in the problem state."
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/crypto6.json b/tools/perf/pmu-events/arch/s390/cf_z17/crypto6.json
new file mode 100644
index 000000000000..8b4380b8e489
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/crypto6.json
@@ -0,0 +1,142 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "64",
+		"EventName": "PRNG_FUNCTIONS",
+		"BriefDescription": "PRNG Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "65",
+		"EventName": "PRNG_CYCLES",
+		"BriefDescription": "PRNG Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES/SHA coprocessor is busy performing the pseudorandom- number-generation functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "66",
+		"EventName": "PRNG_BLOCKED_FUNCTIONS",
+		"BriefDescription": "PRNG Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the pseudorandom-number-generation functions that are issued by the CPU and are blocked because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "67",
+		"EventName": "PRNG_BLOCKED_CYCLES",
+		"BriefDescription": "PRNG Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the pseudorandom-number-generation functions issued by the CPU because the DEA/AES/SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "68",
+		"EventName": "SHA_FUNCTIONS",
+		"BriefDescription": "SHA Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "69",
+		"EventName": "SHA_CYCLES",
+		"BriefDescription": "SHA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the SHA coprocessor is busy performing the SHA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "70",
+		"EventName": "SHA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "SHA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the SHA functions that are issued by the CPU and are blocked because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "71",
+		"EventName": "SHA_BLOCKED_CYCLES",
+		"BriefDescription": "SHA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the SHA functions issued by the CPU because the SHA coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "72",
+		"EventName": "DEA_FUNCTIONS",
+		"BriefDescription": "DEA Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "73",
+		"EventName": "DEA_CYCLES",
+		"BriefDescription": "DEA Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the DEA functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "74",
+		"EventName": "DEA_BLOCKED_FUNCTIONS",
+		"BriefDescription": "DEA Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the DEA functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "75",
+		"EventName": "DEA_BLOCKED_CYCLES",
+		"BriefDescription": "DEA Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the DEA functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "76",
+		"EventName": "AES_FUNCTIONS",
+		"BriefDescription": "AES Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "77",
+		"EventName": "AES_CYCLES",
+		"BriefDescription": "AES Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the DEA/AES coprocessor is busy performing the AES functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "78",
+		"EventName": "AES_BLOCKED_FUNCTIONS",
+		"BriefDescription": "AES Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the AES functions that are issued by the CPU and are blocked because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "79",
+		"EventName": "AES_BLOCKED_CYCLES",
+		"BriefDescription": "AES Blocked Cycle Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the AES functions issued by the CPU because the DEA/AES coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "80",
+		"EventName": "ECC_FUNCTION_COUNT",
+		"BriefDescription": "ECC Function Count",
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "81",
+		"EventName": "ECC_CYCLES_COUNT",
+		"BriefDescription": "ECC Cycles Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles when the ECC coprocessor is busy performing the elliptic-curve cryptography (ECC) functions issued by the CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "82",
+		"EventName": "ECC_BLOCKED_FUNCTION_COUNT",
+		"BriefDescription": "Ecc Blocked Function Count",
+		"PublicDescription": "This counter counts the total number of the elliptic-curve cryptography (ECC) functions that are issued by the CPU and are blocked because the ECC coprocessor is busy performing a function issued by another CPU."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "83",
+		"EventName": "ECC_BLOCKED_CYCLES_COUNT",
+		"BriefDescription": "ECC Blocked Cycles Count",
+		"PublicDescription": "This counter counts the total number of CPU cycles blocked for the elliptic-curve cryptography (ECC) functions issued by the CPU because the ECC coprocessor is busy performing a function issued by another CPU."
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/extended.json b/tools/perf/pmu-events/arch/s390/cf_z17/extended.json
new file mode 100644
index 000000000000..e139482e217f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/extended.json
@@ -0,0 +1,541 @@
+[
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "128",
+		"EventName": "L1D_RO_EXCL_WRITES",
+		"BriefDescription": "L1D Read-only Exclusive Writes",
+		"PublicDescription": "A directory write to the Level-1 Data cache where the line was originally in a Read-Only state in the cache but has been updated to be in the Exclusive state that allows stores to the cache line."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "129",
+		"EventName": "DTLB2_WRITES",
+		"BriefDescription": "DTLB2 Writes",
+		"PublicDescription": "A translation has been written into The Translation Lookaside Buffer 2 (TLB2) and the request was made by the Level-1 Data cache. This is a replacement for what was provided for the DTLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "130",
+		"EventName": "DTLB2_MISSES",
+		"BriefDescription": "DTLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the Level-1 Data cache. Incremented by one for every TLB2 miss in progress for the Level-1 Data cache on this cycle. This is a replacement for what was provided for the DTLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "131",
+		"EventName": "CRSTE_1MB_WRITES",
+		"BriefDescription": "One Megabyte CRSTE writes",
+		"PublicDescription": "A translation entry was written into the Combined Region and Segment Table Entry array in the Level-2 TLB for a one-megabyte page."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "132",
+		"EventName": "DTLB2_GPAGE_WRITES",
+		"BriefDescription": "DTLB2 Two-Gigabyte Page Writes",
+		"PublicDescription": "A translation entry for a two-gigabyte page was written into the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "134",
+		"EventName": "ITLB2_WRITES",
+		"BriefDescription": "ITLB2 Writes",
+		"PublicDescription": "A translation entry has been written into the Translation Lookaside Buffer 2 (TLB2) and the request was made by the Level-1 Instruction cache. This is a replacement for what was provided for the ITLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "135",
+		"EventName": "ITLB2_MISSES",
+		"BriefDescription": "ITLB2 Misses",
+		"PublicDescription": "A TLB2 miss is in progress for a request made by the Level-1 Instruction cache. Incremented by one for every TLB2 miss in progress for the Level-1 Instruction cache in a cycle. This is a replacement for what was provided for the ITLB on z13 and prior machines."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "137",
+		"EventName": "TLB2_PTE_WRITES",
+		"BriefDescription": "TLB2 Page Table Entry Writes",
+		"PublicDescription": "A translation entry was written into the Page Table Entry array in the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "138",
+		"EventName": "TLB2_CRSTE_WRITES",
+		"BriefDescription": "TLB2 Combined Region and Segment Entry Writes",
+		"PublicDescription": "Translation entries were written into the Combined Region and Segment Table Entry array and the Page Table Entry array in the Level-2 TLB."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "139",
+		"EventName": "TLB2_ENGINES_BUSY",
+		"BriefDescription": "TLB2 Engines Busy",
+		"PublicDescription": "The number of Level-2 TLB translation engines busy in a cycle."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "140",
+		"EventName": "TX_C_TEND",
+		"BriefDescription": "Completed TEND instructions in constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "141",
+		"EventName": "TX_NC_TEND",
+		"BriefDescription": "Completed TEND instructions in non-constrained TX mode",
+		"PublicDescription": "A TEND instruction has completed in a non-constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "143",
+		"EventName": "L1C_TLB2_MISSES",
+		"BriefDescription": "L1C TLB2 Misses",
+		"PublicDescription": "Increments by one for any cycle where a Level-1 cache or Level-2 TLB miss is in progress."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "145",
+		"EventName": "DCW_REQ",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "146",
+		"EventName": "DCW_REQ_IV",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "147",
+		"EventName": "DCW_REQ_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "148",
+		"EventName": "DCW_REQ_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from L2-Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "149",
+		"EventName": "DCW_ON_CHIP",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "150",
+		"EventName": "DCW_ON_CHIP_IV",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "151",
+		"EventName": "DCW_ON_CHIP_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "152",
+		"EventName": "DCW_ON_CHIP_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Chip L2-Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Chip Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "153",
+		"EventName": "DCW_ON_MODULE",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Module L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "154",
+		"EventName": "DCW_ON_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Data Cache from On-Drawer L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "155",
+		"EventName": "DCW_OFF_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Data Cache from Off-Drawer L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Data cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "156",
+		"EventName": "DCW_ON_CHIP_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Cache from On-Chip Memory",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from On-Chip memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "157",
+		"EventName": "DCW_ON_MODULE_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Cache from On-Module Memory",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from On-Module memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "158",
+		"EventName": "DCW_ON_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Cache from On-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from On-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "159",
+		"EventName": "DCW_OFF_DRAWER_MEMORY",
+		"BriefDescription": "Directory Write Level 1 Cache from Off-Drawer Memory",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from Off-Drawer memory."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "160",
+		"EventName": "IDCW_ON_MODULE_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "161",
+		"EventName": "IDCW_ON_MODULE_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "162",
+		"EventName": "IDCW_ON_MODULE_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Module Memory L2-Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "163",
+		"EventName": "IDCW_ON_DRAWER_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "164",
+		"EventName": "IDCW_ON_DRAWER_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "165",
+		"EventName": "IDCW_ON_DRAWER_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from On-Drawer L2-Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "166",
+		"EventName": "IDCW_OFF_DRAWER_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "167",
+		"EventName": "IDCW_OFF_DRAWER_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Chip Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "168",
+		"EventName": "IDCW_OFF_DRAWER_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction and Data Cache from Off-Drawer L2-Cache with Drawer Hit",
+		"PublicDescription": "A directory write to the Level-1 Data or Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "169",
+		"EventName": "ICW_REQ",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced the requestors Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "170",
+		"EventName": "ICW_REQ_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "171",
+		"EventName": "ICW_REQ_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "172",
+		"EventName": "ICW_REQ_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from L2-Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from the requestors Level-2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "173",
+		"EventName": "ICW_ON_CHIP",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "174",
+		"EventName": "ICW_ON_CHIP_IV",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Intervention",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache with intervention."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "175",
+		"EventName": "ICW_ON_CHIP_CHIP_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Chip HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip Level-2 cache after using chip level horizontal persistence, Chip-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "176",
+		"EventName": "ICW_ON_CHIP_DRAWER_HIT",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Chip L2-Cache with Drawer HP Hit",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Chip level 2 cache after using drawer level horizontal persistence, Drawer-HP hit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "177",
+		"EventName": "ICW_ON_MODULE",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Module L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Module Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "178",
+		"EventName": "ICW_ON_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from On-Drawer L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an On-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "179",
+		"EventName": "ICW_OFF_DRAWER",
+		"BriefDescription": "Directory Write Level 1 Instruction Cache from Off-Drawer L2-Cache",
+		"PublicDescription": "A directory write to the Level-1 Instruction cache directory where the returned cache line was sourced from an Off-Drawer Level-2 cache."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "202",
+		"EventName": "CYCLES_SAMETHRD",
+		"BriefDescription": "CPU is not in wait state and CPU is running by itself",
+		"PublicDescription": "The number of cycles the CPU is not in wait state and the CPU is running by itself on the Core."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "203",
+		"EventName": "CYCLES_DIFFTHRD",
+		"BriefDescription": "CPU is not in wait state and CPU is running by another thread",
+		"PublicDescription": "The number of cycles the CPU is not in wait state and the CPU is running with another thread on the Core."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "204",
+		"EventName": "INST_SAMETHRD",
+		"BriefDescription": "Instructions executed on CPU by itself",
+		"PublicDescription": "The number of instructions executed on the CPU and the CPU is running by itself on the Core."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "205",
+		"EventName": "INST_DIFFTHRD",
+		"BriefDescription": "Instructions executed on CPU by another thread",
+		"PublicDescription": "The number of instructions executed on the CPU and the CPU is running with another thread on the Core."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "206",
+		"EventName": "WRONG_BRANCH_PREDICTION",
+		"BriefDescription": "Incorrect branch prediction on core",
+		"PublicDescription": "A count of the number of branches that were predicted incorrectly by the branch prediction logic in the Core. This includes incorrectly predicted branches that are executed in Firmware. Examples of instructions implemented in Firmware are complicated instructions like MVCL (Move Character Long) and PC (Program Call)."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "225",
+		"EventName": "VX_BCD_EXECUTION_SLOTS",
+		"BriefDescription": "Count finished vector arithmetic Binary Coded Decimal instructions",
+		"PublicDescription": "Count of floating point execution slots used for finished vector arithmetic Binary Coded Decimal instructions. Instructions: VAP, VSP, VMP, VMSP, VDP, VSDP, VRP, VLIP, VSRP, VPSOP, VCP, VTP, VPKZ, VUPKZ, VCVB, VCVBG, VCVD, VCVDG, VSCHP, VSCSHP, VCSPH, VCLZDP, VPKZR, VSRPR, VUPKZH, VUPKZL, VTZ, VUPH, VUPL, VCVBX, VCVDX."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "226",
+		"EventName": "DECIMAL_INSTRUCTIONS",
+		"BriefDescription": "Decimal instruction dispatched",
+		"PublicDescription": "Decimal instruction dispatched. Instructions: CVB, CVD, AP, CP, DP, ED, EDMK, MP, SRP, SP, ZAP, TP."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "232",
+		"EventName": "LAST_HOST_TRANSLATIONS",
+		"BriefDescription": "Last host translation done",
+		"PublicDescription": "Last Host Translation done."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "244",
+		"EventName": "TX_NC_TABORT",
+		"BriefDescription": "Aborted transactions in unconstrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a non-constrained transactional-execution mode."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "245",
+		"EventName": "TX_C_TABORT_NO_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is not using any special logic to allow the transaction to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "246",
+		"EventName": "TX_C_TABORT_SPECIAL",
+		"BriefDescription": "Aborted transactions in constrained TX mode using special completion logic",
+		"PublicDescription": "A transaction abort has occurred in a constrained transactional-execution mode and the CPU is using special logic to allow the transaction to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "248",
+		"EventName": "DFLT_ACCESS",
+		"BriefDescription": "Cycles CPU spent obtaining access to Deflate unit",
+		"PublicDescription": "Cycles CPU spent obtaining access to Deflate unit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "253",
+		"EventName": "DFLT_CYCLES",
+		"BriefDescription": "Cycles CPU is using Deflate unit",
+		"PublicDescription": "Cycles CPU is using Deflate unit."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "256",
+		"EventName": "SORTL",
+		"BriefDescription": "Count SORTL instructions",
+		"PublicDescription": "Increments by one for every SORT LISTS (SORTL) instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "265",
+		"EventName": "DFLT_CC",
+		"BriefDescription": "Increments DEFLATE CONVERSION CALL",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL (DFLTCC) instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "266",
+		"EventName": "DFLT_CCFINISH",
+		"BriefDescription": "Increments completed DEFLATE CONVERSION CALL",
+		"PublicDescription": "Increments by one for every DEFLATE CONVERSION CALL (DFLTCC) instruction executed that ended in Condition Codes 0, 1 or 2."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "267",
+		"EventName": "NNPA_INVOCATIONS",
+		"BriefDescription": "NNPA Total invocations",
+		"PublicDescription": "Increments by one for every NEURAL NETWORK PROCESSING ASSIST (NNPA) instruction executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "268",
+		"EventName": "NNPA_COMPLETIONS",
+		"BriefDescription": "NNPA Total completions",
+		"PublicDescription": "Increments by one for every NEURAL NETWORK PROCESSING ASSIST (NNPA) instruction executed that ended in Condition Code 0."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "269",
+		"EventName": "NNPA_WAIT_LOCK",
+		"BriefDescription": "Cycles spent obtaining NNPA lock",
+		"PublicDescription": "Cycles CPU spent obtaining access to IBM Z Integrated Accelerator for AI."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "270",
+		"EventName": "NNPA_HOLD_LOCK",
+		"BriefDescription": "Cycles spent holding NNPA lock",
+		"PublicDescription": "Cycles CPU is using IBM Z Integrated Accelerator for AI."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "272",
+		"EventName": "NNPA_INST_ONCHIP",
+		"BriefDescription": "NNPA instructions used on-chip Integrated Accelerator",
+		"PublicDescription": "A NEURAL NETWORK PROCESSING ASSIST (NNPA) instruction has used the Local On-Chip IBM Z Integrated Accelerator for AI during its execution"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "273",
+		"EventName": "NNPA_INST_OFFCHIP",
+		"BriefDescription": "NNPA instructions used off-chip Integrated Accelerator",
+		"PublicDescription": "A NEURAL NETWORK PROCESSING ASSIST (NNPA) instruction has used an Off-Chip IBM Z Integrated Accelerator for AI during its execution."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "274",
+		"EventName": "NNPA_INST_DIFF",
+		"BriefDescription": "NNPA instructions used different Integrated Accelerator",
+		"PublicDescription": "A NEURAL NETWORK PROCESSING ASSIST (NNPA) instruction has used a different IBM Z Integrated Accelerator for AI since it was last executed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "276",
+		"EventName": "NNPA_4K_PREFETCH",
+		"BriefDescription": "Number of 4K prefetches for Integated Accelerator",
+		"PublicDescription": "Number of 4K prefetches done for a remote IBM Z Integated Accelerator for AI."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "277",
+		"EventName": "NNPA_COMPL_LOCK",
+		"BriefDescription": "A Perform Locked Operation has completed",
+		"PublicDescription": "A PERFORM LOCKED OPERATION (PLO) has completed."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "278",
+		"EventName": "NNPA_RETRY_LOCK",
+		"BriefDescription": "A Perform Locked Operation has been retried",
+		"PublicDescription": "A PERFORM LOCKED OPERATION (PLO) has been retried and the CPU did not use any special logic to allow the PLO to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "279",
+		"EventName": "NNPA_RETRY_LOCK_WITH_PLO",
+		"BriefDescription": "A Perform Locked Operation has been retried using special logic",
+		"PublicDescription": "A PERFORM LOCKED OPERATION (PLO) has been retried and the CPU is using special logic to allow PLO to complete."
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "448",
+		"EventName": "MT_DIAG_CYCLES_ONE_THR_ACTIVE",
+		"BriefDescription": "Cycle count with one thread active",
+		"PublicDescription": "Cycle count with one thread active"
+	},
+	{
+		"Unit": "CPU-M-CF",
+		"EventCode": "449",
+		"EventName": "MT_DIAG_CYCLES_TWO_THR_ACTIVE",
+		"BriefDescription": "Cycle count with two threads active",
+		"PublicDescription": "Cycle count with two threads active"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
new file mode 100644
index 000000000000..a7176c988b8a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
@@ -0,0 +1,1213 @@
+[
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4096",
+		"EventName": "CRYPTO_ALL",
+		"BriefDescription": "CRYPTO ALL",
+		"PublicDescription": "Sums of all non zero cryptography counters"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4097",
+		"EventName": "KM_DEA",
+		"BriefDescription": "KM DEA",
+		"PublicDescription": "KM-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4098",
+		"EventName": "KM_TDEA_128",
+		"BriefDescription": "KM TDEA 128",
+		"PublicDescription": "KM-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4099",
+		"EventName": "KM_TDEA_192",
+		"BriefDescription": "KM TDEA 192",
+		"PublicDescription": "KM-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4100",
+		"EventName": "KM_ENCRYPTED_DEA",
+		"BriefDescription": "KM ENCRYPTED DEA",
+		"PublicDescription": "KM-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4101",
+		"EventName": "KM_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KM ENCRYPTED TDEA 128",
+		"PublicDescription": "KM-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4102",
+		"EventName": "KM_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KM ENCRYPTED TDEA 192",
+		"PublicDescription": "KM-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4103",
+		"EventName": "KM_AES_128",
+		"BriefDescription": "KM AES 128",
+		"PublicDescription": "KM-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4104",
+		"EventName": "KM_AES_192",
+		"BriefDescription": "KM AES 192",
+		"PublicDescription": "KM-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4105",
+		"EventName": "KM_AES_256",
+		"BriefDescription": "KM AES 256",
+		"PublicDescription": "KM-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4106",
+		"EventName": "KM_ENCRYPTED_AES_128",
+		"BriefDescription": "KM ENCRYPTED AES 128",
+		"PublicDescription": "KM-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4107",
+		"EventName": "KM_ENCRYPTED_AES_192",
+		"BriefDescription": "KM ENCRYPTED AES 192",
+		"PublicDescription": "KM-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4108",
+		"EventName": "KM_ENCRYPTED_AES_256",
+		"BriefDescription": "KM ENCRYPTED AES 256",
+		"PublicDescription": "KM-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4109",
+		"EventName": "KM_XTS_AES_128",
+		"BriefDescription": "KM XTS AES 128",
+		"PublicDescription": "KM-XTS-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4110",
+		"EventName": "KM_XTS_AES_256",
+		"BriefDescription": "KM XTS AES 256",
+		"PublicDescription": "KM-XTS-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4111",
+		"EventName": "KM_XTS_ENCRYPTED_AES_128",
+		"BriefDescription": "KM XTS ENCRYPTED AES 128",
+		"PublicDescription": "KM-XTS-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4112",
+		"EventName": "KM_XTS_ENCRYPTED_AES_256",
+		"BriefDescription": "KM XTS ENCRYPTED AES 256",
+		"PublicDescription": "KM-XTS-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4113",
+		"EventName": "KMC_DEA",
+		"BriefDescription": "KMC DEA",
+		"PublicDescription": "KMC-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4114",
+		"EventName": "KMC_TDEA_128",
+		"BriefDescription": "KMC TDEA 128",
+		"PublicDescription": "KMC-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4115",
+		"EventName": "KMC_TDEA_192",
+		"BriefDescription": "KMC TDEA 192",
+		"PublicDescription": "KMC-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4116",
+		"EventName": "KMC_ENCRYPTED_DEA",
+		"BriefDescription": "KMC ENCRYPTED DEA",
+		"PublicDescription": "KMC-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4117",
+		"EventName": "KMC_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMC ENCRYPTED TDEA 128",
+		"PublicDescription": "KMC-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4118",
+		"EventName": "KMC_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMC ENCRYPTED TDEA 192",
+		"PublicDescription": "KMC-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4119",
+		"EventName": "KMC_AES_128",
+		"BriefDescription": "KMC AES 128",
+		"PublicDescription": "KMC-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4120",
+		"EventName": "KMC_AES_192",
+		"BriefDescription": "KMC AES 192",
+		"PublicDescription": "KMC-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4121",
+		"EventName": "KMC_AES_256",
+		"BriefDescription": "KMC AES 256",
+		"PublicDescription": "KMC-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4122",
+		"EventName": "KMC_ENCRYPTED_AES_128",
+		"BriefDescription": "KMC ENCRYPTED AES 128",
+		"PublicDescription": "KMC-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4123",
+		"EventName": "KMC_ENCRYPTED_AES_192",
+		"BriefDescription": "KMC ENCRYPTED AES 192",
+		"PublicDescription": "KMC-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4124",
+		"EventName": "KMC_ENCRYPTED_AES_256",
+		"BriefDescription": "KMC ENCRYPTED AES 256",
+		"PublicDescription": "KMC-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4125",
+		"EventName": "KMC_PRNG",
+		"BriefDescription": "KMC PRNG",
+		"PublicDescription": "KMC-PRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4126",
+		"EventName": "KMA_GCM_AES_128",
+		"BriefDescription": "KMA GCM AES 128",
+		"PublicDescription": "KMA-GCM-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4127",
+		"EventName": "KMA_GCM_AES_192",
+		"BriefDescription": "KMA GCM AES 192",
+		"PublicDescription": "KMA-GCM-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4128",
+		"EventName": "KMA_GCM_AES_256",
+		"BriefDescription": "KMA GCM AES 256",
+		"PublicDescription": "KMA-GCM-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4129",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_128",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 128",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4130",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_192",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 192",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4131",
+		"EventName": "KMA_GCM_ENCRYPTED_AES_256",
+		"BriefDescription": "KMA GCM ENCRYPTED AES 256",
+		"PublicDescription": "KMA-GCM-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4132",
+		"EventName": "KMF_DEA",
+		"BriefDescription": "KMF DEA",
+		"PublicDescription": "KMF-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4133",
+		"EventName": "KMF_TDEA_128",
+		"BriefDescription": "KMF TDEA 128",
+		"PublicDescription": "KMF-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4134",
+		"EventName": "KMF_TDEA_192",
+		"BriefDescription": "KMF TDEA 192",
+		"PublicDescription": "KMF-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4135",
+		"EventName": "KMF_ENCRYPTED_DEA",
+		"BriefDescription": "KMF ENCRYPTED DEA",
+		"PublicDescription": "KMF-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4136",
+		"EventName": "KMF_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMF ENCRYPTED TDEA 128",
+		"PublicDescription": "KMF-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4137",
+		"EventName": "KMF_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMF ENCRYPTED TDEA 192",
+		"PublicDescription": "KMF-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4138",
+		"EventName": "KMF_AES_128",
+		"BriefDescription": "KMF AES 128",
+		"PublicDescription": "KMF-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4139",
+		"EventName": "KMF_AES_192",
+		"BriefDescription": "KMF AES 192",
+		"PublicDescription": "KMF-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4140",
+		"EventName": "KMF_AES_256",
+		"BriefDescription": "KMF AES 256",
+		"PublicDescription": "KMF-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4141",
+		"EventName": "KMF_ENCRYPTED_AES_128",
+		"BriefDescription": "KMF ENCRYPTED AES 128",
+		"PublicDescription": "KMF-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4142",
+		"EventName": "KMF_ENCRYPTED_AES_192",
+		"BriefDescription": "KMF ENCRYPTED AES 192",
+		"PublicDescription": "KMF-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4143",
+		"EventName": "KMF_ENCRYPTED_AES_256",
+		"BriefDescription": "KMF ENCRYPTED AES 256",
+		"PublicDescription": "KMF-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4144",
+		"EventName": "KMCTR_DEA",
+		"BriefDescription": "KMCTR DEA",
+		"PublicDescription": "KMCTR-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4145",
+		"EventName": "KMCTR_TDEA_128",
+		"BriefDescription": "KMCTR TDEA 128",
+		"PublicDescription": "KMCTR-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4146",
+		"EventName": "KMCTR_TDEA_192",
+		"BriefDescription": "KMCTR TDEA 192",
+		"PublicDescription": "KMCTR-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4147",
+		"EventName": "KMCTR_ENCRYPTED_DEA",
+		"BriefDescription": "KMCTR ENCRYPTED DEA",
+		"PublicDescription": "KMCTR-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4148",
+		"EventName": "KMCTR_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMCTR ENCRYPTED TDEA 128",
+		"PublicDescription": "KMCTR-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4149",
+		"EventName": "KMCTR_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMCTR ENCRYPTED TDEA 192",
+		"PublicDescription": "KMCTR-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4150",
+		"EventName": "KMCTR_AES_128",
+		"BriefDescription": "KMCTR AES 128",
+		"PublicDescription": "KMCTR-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4151",
+		"EventName": "KMCTR_AES_192",
+		"BriefDescription": "KMCTR AES 192",
+		"PublicDescription": "KMCTR-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4152",
+		"EventName": "KMCTR_AES_256",
+		"BriefDescription": "KMCTR AES 256",
+		"PublicDescription": "KMCTR-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4153",
+		"EventName": "KMCTR_ENCRYPTED_AES_128",
+		"BriefDescription": "KMCTR ENCRYPTED AES 128",
+		"PublicDescription": "KMCTR-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4154",
+		"EventName": "KMCTR_ENCRYPTED_AES_192",
+		"BriefDescription": "KMCTR ENCRYPTED AES 192",
+		"PublicDescription": "KMCTR-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4155",
+		"EventName": "KMCTR_ENCRYPTED_AES_256",
+		"BriefDescription": "KMCTR ENCRYPTED AES 256",
+		"PublicDescription": "KMCTR-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4156",
+		"EventName": "KMO_DEA",
+		"BriefDescription": "KMO DEA",
+		"PublicDescription": "KMO-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4157",
+		"EventName": "KMO_TDEA_128",
+		"BriefDescription": "KMO TDEA 128",
+		"PublicDescription": "KMO-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4158",
+		"EventName": "KMO_TDEA_192",
+		"BriefDescription": "KMO TDEA 192",
+		"PublicDescription": "KMO-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4159",
+		"EventName": "KMO_ENCRYPTED_DEA",
+		"BriefDescription": "KMO ENCRYPTED DEA",
+		"PublicDescription": "KMO-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4160",
+		"EventName": "KMO_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMO ENCRYPTED TDEA 128",
+		"PublicDescription": "KMO-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4161",
+		"EventName": "KMO_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMO ENCRYPTED TDEA 192",
+		"PublicDescription": "KMO-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4162",
+		"EventName": "KMO_AES_128",
+		"BriefDescription": "KMO AES 128",
+		"PublicDescription": "KMO-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4163",
+		"EventName": "KMO_AES_192",
+		"BriefDescription": "KMO AES 192",
+		"PublicDescription": "KMO-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4164",
+		"EventName": "KMO_AES_256",
+		"BriefDescription": "KMO AES 256",
+		"PublicDescription": "KMO-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4165",
+		"EventName": "KMO_ENCRYPTED_AES_128",
+		"BriefDescription": "KMO ENCRYPTED AES 128",
+		"PublicDescription": "KMO-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4166",
+		"EventName": "KMO_ENCRYPTED_AES_192",
+		"BriefDescription": "KMO ENCRYPTED AES 192",
+		"PublicDescription": "KMO-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4167",
+		"EventName": "KMO_ENCRYPTED_AES_256",
+		"BriefDescription": "KMO ENCRYPTED AES 256",
+		"PublicDescription": "KMO-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4168",
+		"EventName": "KIMD_SHA_1",
+		"BriefDescription": "KIMD SHA 1",
+		"PublicDescription": "KIMD-SHA-1 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4169",
+		"EventName": "KIMD_SHA_256",
+		"BriefDescription": "KIMD SHA 256",
+		"PublicDescription": "KIMD-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4170",
+		"EventName": "KIMD_SHA_512",
+		"BriefDescription": "KIMD SHA 512",
+		"PublicDescription": "KIMD-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4171",
+		"EventName": "KIMD_SHA3_224",
+		"BriefDescription": "KIMD SHA3 224",
+		"PublicDescription": "KIMD-SHA3-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4172",
+		"EventName": "KIMD_SHA3_256",
+		"BriefDescription": "KIMD SHA3 256",
+		"PublicDescription": "KIMD-SHA3-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4173",
+		"EventName": "KIMD_SHA3_384",
+		"BriefDescription": "KIMD SHA3 384",
+		"PublicDescription": "KIMD-SHA3-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4174",
+		"EventName": "KIMD_SHA3_512",
+		"BriefDescription": "KIMD SHA3 512",
+		"PublicDescription": "KIMD-SHA3-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4175",
+		"EventName": "KIMD_SHAKE_128",
+		"BriefDescription": "KIMD SHAKE 128",
+		"PublicDescription": "KIMD-SHAKE-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4176",
+		"EventName": "KIMD_SHAKE_256",
+		"BriefDescription": "KIMD SHAKE 256",
+		"PublicDescription": "KIMD-SHAKE-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4177",
+		"EventName": "KIMD_GHASH",
+		"BriefDescription": "KIMD GHASH",
+		"PublicDescription": "KIMD-GHASH function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4178",
+		"EventName": "KLMD_SHA_1",
+		"BriefDescription": "KLMD SHA 1",
+		"PublicDescription": "KLMD-SHA-1 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4179",
+		"EventName": "KLMD_SHA_256",
+		"BriefDescription": "KLMD SHA 256",
+		"PublicDescription": "KLMD-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4180",
+		"EventName": "KLMD_SHA_512",
+		"BriefDescription": "KLMD SHA 512",
+		"PublicDescription": "KLMD-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4181",
+		"EventName": "KLMD_SHA3_224",
+		"BriefDescription": "KLMD SHA3 224",
+		"PublicDescription": "KLMD-SHA3-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4182",
+		"EventName": "KLMD_SHA3_256",
+		"BriefDescription": "KLMD SHA3 256",
+		"PublicDescription": "KLMD-SHA3-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4183",
+		"EventName": "KLMD_SHA3_384",
+		"BriefDescription": "KLMD SHA3 384",
+		"PublicDescription": "KLMD-SHA3-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4184",
+		"EventName": "KLMD_SHA3_512",
+		"BriefDescription": "KLMD SHA3 512",
+		"PublicDescription": "KLMD-SHA3-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4185",
+		"EventName": "KLMD_SHAKE_128",
+		"BriefDescription": "KLMD SHAKE 128",
+		"PublicDescription": "KLMD-SHAKE-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4186",
+		"EventName": "KLMD_SHAKE_256",
+		"BriefDescription": "KLMD SHAKE 256",
+		"PublicDescription": "KLMD-SHAKE-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4187",
+		"EventName": "KMAC_DEA",
+		"BriefDescription": "KMAC DEA",
+		"PublicDescription": "KMAC-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4188",
+		"EventName": "KMAC_TDEA_128",
+		"BriefDescription": "KMAC TDEA 128",
+		"PublicDescription": "KMAC-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4189",
+		"EventName": "KMAC_TDEA_192",
+		"BriefDescription": "KMAC TDEA 192",
+		"PublicDescription": "KMAC-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4190",
+		"EventName": "KMAC_ENCRYPTED_DEA",
+		"BriefDescription": "KMAC ENCRYPTED DEA",
+		"PublicDescription": "KMAC-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4191",
+		"EventName": "KMAC_ENCRYPTED_TDEA_128",
+		"BriefDescription": "KMAC ENCRYPTED TDEA 128",
+		"PublicDescription": "KMAC-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4192",
+		"EventName": "KMAC_ENCRYPTED_TDEA_192",
+		"BriefDescription": "KMAC ENCRYPTED TDEA 192",
+		"PublicDescription": "KMAC-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4193",
+		"EventName": "KMAC_AES_128",
+		"BriefDescription": "KMAC AES 128",
+		"PublicDescription": "KMAC-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4194",
+		"EventName": "KMAC_AES_192",
+		"BriefDescription": "KMAC AES 192",
+		"PublicDescription": "KMAC-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4195",
+		"EventName": "KMAC_AES_256",
+		"BriefDescription": "KMAC AES 256",
+		"PublicDescription": "KMAC-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4196",
+		"EventName": "KMAC_ENCRYPTED_AES_128",
+		"BriefDescription": "KMAC ENCRYPTED AES 128",
+		"PublicDescription": "KMAC-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4197",
+		"EventName": "KMAC_ENCRYPTED_AES_192",
+		"BriefDescription": "KMAC ENCRYPTED AES 192",
+		"PublicDescription": "KMAC-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4198",
+		"EventName": "KMAC_ENCRYPTED_AES_256",
+		"BriefDescription": "KMAC ENCRYPTED AES 256",
+		"PublicDescription": "KMAC-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4199",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_DEA",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING DEA",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4200",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING TDEA 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4201",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_TDEA_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING TDEA 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4202",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_DEA",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED DEA",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-DEA function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4203",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4204",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_TDEA_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED TDEA 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-TDEA-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4205",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4206",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4207",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_AES_256",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING AES 256",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4208",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_128",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 128",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4209",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_192",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 192",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-192 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4210",
+		"EventName": "PCC_COMPUTE_LAST_BLOCK_CMAC_USING_ENCRYPTED_AES_256A",
+		"BriefDescription": "PCC COMPUTE LAST BLOCK CMAC USING ENCRYPTED AES 256A",
+		"PublicDescription": "PCC-Compute-Last-Block-CMAC-Using-Encrypted-AES-256A function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4211",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_AES_128",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING AES 128",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4212",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_AES_256",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING AES 256",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4213",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_128",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING ENCRYPTED AES 128",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4214",
+		"EventName": "PCC_COMPUTE_XTS_PARAMETER_USING_ENCRYPTED_AES_256",
+		"BriefDescription": "PCC COMPUTE XTS PARAMETER USING ENCRYPTED AES 256",
+		"PublicDescription": "PCC-Compute-XTS-Parameter-Using-Encrypted-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4215",
+		"EventName": "PCC_SCALAR_MULTIPLY_P256",
+		"BriefDescription": "PCC SCALAR MULTIPLY P256",
+		"PublicDescription": "PCC-Scalar-Multiply-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4216",
+		"EventName": "PCC_SCALAR_MULTIPLY_P384",
+		"BriefDescription": "PCC SCALAR MULTIPLY P384",
+		"PublicDescription": "PCC-Scalar-Multiply-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4217",
+		"EventName": "PCC_SCALAR_MULTIPLY_P521",
+		"BriefDescription": "PCC SCALAR MULTIPLY P521",
+		"PublicDescription": "PCC-Scalar-Multiply-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4218",
+		"EventName": "PCC_SCALAR_MULTIPLY_ED25519",
+		"BriefDescription": "PCC SCALAR MULTIPLY ED25519",
+		"PublicDescription": "PCC-Scalar-Multiply-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4219",
+		"EventName": "PCC_SCALAR_MULTIPLY_ED448",
+		"BriefDescription": "PCC SCALAR MULTIPLY ED448",
+		"PublicDescription": "PCC-Scalar-Multiply-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4220",
+		"EventName": "PCC_SCALAR_MULTIPLY_X25519",
+		"BriefDescription": "PCC SCALAR MULTIPLY X25519",
+		"PublicDescription": "PCC-Scalar-Multiply-X25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4221",
+		"EventName": "PCC_SCALAR_MULTIPLY_X448",
+		"BriefDescription": "PCC SCALAR MULTIPLY X448",
+		"PublicDescription": "PCC-Scalar-Multiply-X448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4222",
+		"EventName": "PRNO_SHA_512_DRNG",
+		"BriefDescription": "PRNO SHA 512 DRNG",
+		"PublicDescription": "PRNO-SHA-512-DRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4223",
+		"EventName": "PRNO_TRNG_QUERY_RAW_TO_CONDITIONED_RATIO",
+		"BriefDescription": "PRNO TRNG QUERY RAW TO CONDITIONED RATIO",
+		"PublicDescription": "PRNO-TRNG-Query-Raw-to-Conditioned-Ratio function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4224",
+		"EventName": "PRNO_TRNG",
+		"BriefDescription": "PRNO TRNG",
+		"PublicDescription": "PRNO-TRNG function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4225",
+		"EventName": "KDSA_ECDSA_VERIFY_P256",
+		"BriefDescription": "KDSA ECDSA VERIFY P256",
+		"PublicDescription": "KDSA-ECDSA-Verify-P256 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4226",
+		"EventName": "KDSA_ECDSA_VERIFY_P384",
+		"BriefDescription": "KDSA ECDSA VERIFY P384",
+		"PublicDescription": "KDSA-ECDSA-Verify-P384 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4227",
+		"EventName": "KDSA_ECDSA_VERIFY_P521",
+		"BriefDescription": "KDSA ECDSA VERIFY P521",
+		"PublicDescription": "KDSA-ECDSA-Verify-P521 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4228",
+		"EventName": "KDSA_ECDSA_SIGN_P256",
+		"BriefDescription": "KDSA ECDSA SIGN P256",
+		"PublicDescription": "KDSA-ECDSA-Sign-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4229",
+		"EventName": "KDSA_ECDSA_SIGN_P384",
+		"BriefDescription": "KDSA ECDSA SIGN P384",
+		"PublicDescription": "KDSA-ECDSA-Sign-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4230",
+		"EventName": "KDSA_ECDSA_SIGN_P521",
+		"BriefDescription": "KDSA ECDSA SIGN P521",
+		"PublicDescription": "KDSA-ECDSA-Sign-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4231",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P256",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P256",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4232",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P384",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P384",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4233",
+		"EventName": "KDSA_ENCRYPTED_ECDSA_SIGN_P521",
+		"BriefDescription": "KDSA ENCRYPTED ECDSA SIGN P521",
+		"PublicDescription": "KDSA-Encrypted-ECDSA-Sign-P521 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4234",
+		"EventName": "KDSA_EDDSA_VERIFY_ED25519",
+		"BriefDescription": "KDSA EDDSA VERIFY ED25519",
+		"PublicDescription": "KDSA-EdDSA-Verify-Ed25519 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4235",
+		"EventName": "KDSA_EDDSA_VERIFY_ED448",
+		"BriefDescription": "KDSA EDDSA VERIFY ED448",
+		"PublicDescription": "KDSA-EdDSA-Verify-Ed448 function ending with CC=0 or CC=2"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4236",
+		"EventName": "KDSA_EDDSA_SIGN_ED25519",
+		"BriefDescription": "KDSA EDDSA SIGN ED25519",
+		"PublicDescription": "KDSA-EdDSA-Sign-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4237",
+		"EventName": "KDSA_EDDSA_SIGN_ED448",
+		"BriefDescription": "KDSA EDDSA SIGN ED448",
+		"PublicDescription": "KDSA-EdDSA-Sign-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4238",
+		"EventName": "KDSA_ENCRYPTED_EDDSA_SIGN_ED25519",
+		"BriefDescription": "KDSA ENCRYPTED EDDSA SIGN ED25519",
+		"PublicDescription": "KDSA-Encrypted-EdDSA-Sign-Ed25519 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4239",
+		"EventName": "KDSA_ENCRYPTED_EDDSA_SIGN_ED448",
+		"BriefDescription": "KDSA ENCRYPTED EDDSA SIGN ED448",
+		"PublicDescription": "KDSA-Encrypted-EdDSA-Sign-Ed448 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4240",
+		"EventName": "PCKMO_ENCRYPT_DEA_KEY",
+		"BriefDescription": "PCKMO ENCRYPT DEA KEY",
+		"PublicDescription": "PCKMO-Encrypt-DEA-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4241",
+		"EventName": "PCKMO_ENCRYPT_TDEA_128_KEY",
+		"BriefDescription": "PCKMO ENCRYPT TDEA 128 KEY",
+		"PublicDescription": "PCKMO-Encrypt-TDEA-128-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4242",
+		"EventName": "PCKMO_ENCRYPT_TDEA_192_KEY",
+		"BriefDescription": "PCKMO ENCRYPT TDEA 192 KEY",
+		"PublicDescription": "PCKMO-Encrypt-TDEA-192-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4243",
+		"EventName": "PCKMO_ENCRYPT_AES_128_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 128 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-128-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4244",
+		"EventName": "PCKMO_ENCRYPT_AES_192_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 192 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-192-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4245",
+		"EventName": "PCKMO_ENCRYPT_AES_256_KEY",
+		"BriefDescription": "PCKMO ENCRYPT AES 256 KEY",
+		"PublicDescription": "PCKMO-Encrypt-AES-256-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4246",
+		"EventName": "PCKMO_ENCRYPT_ECC_P256_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P256 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P256-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4247",
+		"EventName": "PCKMO_ENCRYPT_ECC_P384_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P384 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P384-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4248",
+		"EventName": "PCKMO_ENCRYPT_ECC_P521_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC P521 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-P521-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4249",
+		"EventName": "PCKMO_ENCRYPT_ECC_ED25519_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC ED25519 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-Ed25519-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4250",
+		"EventName": "PCKMO_ENCRYPT_ECC_ED448_KEY",
+		"BriefDescription": "PCKMO ENCRYPT ECC ED448 KEY",
+		"PublicDescription": "PCKMO-Encrypt-ECC-Ed448-key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4251",
+		"EventName": "IBM_RESERVED_155",
+		"BriefDescription": "IBM RESERVED_155",
+		"PublicDescription": "Reserved for IBM use"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4252",
+		"EventName": "IBM_RESERVED_156",
+		"BriefDescription": "IBM RESERVED_156",
+		"PublicDescription": "Reserved for IBM use"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4253",
+		"EventName": "KM_FULL_XTS_AES_128",
+		"BriefDescription": "KM FULL XTS AES 128",
+		"PublicDescription": "KM-Full-XTS-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4254",
+		"EventName": "KM_FULL_XTS_AES_256",
+		"BriefDescription": "KM FULL XTS AES 256",
+		"PublicDescription": "KM-Full-XTS-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4255",
+		"EventName": "KM_FULL_XTS_ENCRYPTED_AES_128",
+		"BriefDescription": "KM FULL XTS ENCRYPTED AES 128",
+		"PublicDescription": "KM-Full-XTS-Encrypted-AES-128 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4256",
+		"EventName": "KM_FULL_XTS_ENCRYPTED_AES_256",
+		"BriefDescription": "KM FULL XTS ENCRYPTED AES 256",
+		"PublicDescription": "KM-FULL-XTS-ENCRYPTED-AES-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4257",
+		"EventName": "KMAC_HMAC_SHA_224",
+		"BriefDescription": "KMAC HMAC SHA 224",
+		"PublicDescription": "KMAC-HMAC-SHA-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4258",
+		"EventName": "KMAC_HMAC_SHA_256",
+		"BriefDescription": "KMAC HMAC SHA 256",
+		"PublicDescription": "KMAC-HMAC-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4259",
+		"EventName": "KMAC_HMAC_SHA_384",
+		"BriefDescription": "KMAC HMAC SHA 384",
+		"PublicDescription": "KMAC-HMAC-SHA-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4260",
+		"EventName": "KMAC_HMAC_SHA_512",
+		"BriefDescription": "KMAC HMAC SHA 512",
+		"PublicDescription": "KMAC-HMAC-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4261",
+		"EventName": "KMAC_HMAC_ENCRYPTED_SHA_224",
+		"BriefDescription": "KMAC HMAC ENCRYPTED SHA 224",
+		"PublicDescription": "KMAC-HMAC-Encrypted-SHA-224 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4262",
+		"EventName": "KMAC_HMAC_ENCRYPTED_SHA_256",
+		"BriefDescription": "KMAC HMAC ENCRYPTED SHA 256",
+		"PublicDescription": "KMAC-HMAC-Encrypted-SHA-256 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4263",
+		"EventName": "KMAC_HMAC_ENCRYPTED_SHA_384",
+		"BriefDescription": "KMAC HMAC ENCRYPTED SHA 384",
+		"PublicDescription": "KMAC-HMAC-Encrypted-SHA-384 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4264",
+		"EventName": "KMAC_HMAC_ENCRYPTED_SHA_512",
+		"BriefDescription": "KMAC HMAC ENCRYPTED SHA 512",
+		"PublicDescription": "KMAC-HMAC-Encrypted-SHA-512 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4265",
+		"EventName": "PCKMO_ENCRYPT_HMAC_512_KEY",
+		"BriefDescription": "PCKMO ENCRYPT HMAC 512 KEY",
+		"PublicDescription": "PCKMO-Encrypt-HMAC-512-Key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4266",
+		"EventName": "PCKMO_ENCRYPT_HMAC_1024_KEY",
+		"BriefDescription": "PCKMO ENCRYPT HMAC 1024 KEY",
+		"PublicDescription": "PCKMO-Encrypt-HMAC-1024-Key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4267",
+		"EventName": "PCKMO_ENCRYPT_AES_XTS_128",
+		"BriefDescription": "PCKMO ENCRYPT AES XTS Double Key 128",
+		"PublicDescription": "PCKMO-ENCRYPT-AES-XTS-128 Double Key function"
+	},
+	{
+		"Unit": "PAI-CRYPTO",
+		"EventCode": "4268",
+		"EventName": "PCKMO_ENCRYPT_AES_XTS_256",
+		"BriefDescription": "PCKMO ENCRYPT AES XTS Double Key 256",
+		"PublicDescription": "PCKMO-ENCRYPT-AES-XTS-256 Double Key function"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/pai_ext.json b/tools/perf/pmu-events/arch/s390/cf_z17/pai_ext.json
new file mode 100644
index 000000000000..935e9f5763b4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/pai_ext.json
@@ -0,0 +1,261 @@
+[
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6144",
+		"EventName": "NNPA_ALL",
+		"BriefDescription": "NNPA ALL",
+		"PublicDescription": "Sums of all non zero NNPA counters"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6145",
+		"EventName": "NNPA_ADD",
+		"BriefDescription": "NNPA ADD function",
+		"PublicDescription": "NNPA-ADD function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6146",
+		"EventName": "NNPA_SUB",
+		"BriefDescription": "NNPA SUB function",
+		"PublicDescription": "NNPA-SUB function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6147",
+		"EventName": "NNPA_MUL",
+		"BriefDescription": "NNPA MUL function",
+		"PublicDescription": "NNPA-MUL function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6148",
+		"EventName": "NNPA_DIV",
+		"BriefDescription": "NNPA_DIV function",
+		"PublicDescription": "NNPA-DIV function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6149",
+		"EventName": "NNPA_MIN",
+		"BriefDescription": "NNPA MIN function",
+		"PublicDescription": "NNPA-MIN function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6150",
+		"EventName": "NNPA_MAX",
+		"BriefDescription": "NNPA MAX function",
+		"PublicDescription": "NNPA-MAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6151",
+		"EventName": "NNPA_LOG",
+		"BriefDescription": "NNPA LOG function",
+		"PublicDescription": "NNPA Log function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6152",
+		"EventName": "NNPA_EXP",
+		"BriefDescription": "NNPA EXP function",
+		"PublicDescription": "NNPA-EXP function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6153",
+		"EventName": "NNPA_IBM_RESERVED_9",
+		"BriefDescription": "Reserved for IBM use",
+		"PublicDescription": "Reserved for IBM use"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6154",
+		"EventName": "NNPA_RELU",
+		"BriefDescription": "NNPA RELU function",
+		"PublicDescription": "NNPA-RELU function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6155",
+		"EventName": "NNPA_TANH",
+		"BriefDescription": "NNPA TANH function",
+		"PublicDescription": "NNPA-TANH function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6156",
+		"EventName": "NNPA_SIGMOID",
+		"BriefDescription": "NNPA SIGMOID function",
+		"PublicDescription": "NNPA-SIGMOID function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6157",
+		"EventName": "NNPA_SOFTMAX",
+		"BriefDescription": "NNPA SOFTMAX function",
+		"PublicDescription": "NNPA-SOFTMAX function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6158",
+		"EventName": "NNPA_BATCHNORM",
+		"BriefDescription": "NNPA BATCHNORM function",
+		"PublicDescription": "NNPA-BATCHNORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6159",
+		"EventName": "NNPA_MAXPOOL2D",
+		"BriefDescription": "NNPA MAXPOOL2D function",
+		"PublicDescription": "NNPA-MAXPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6160",
+		"EventName": "NNPA_AVGPOOL2D",
+		"BriefDescription": "NNPA_AVGPOOL2D function",
+		"PublicDescription": "NNPA-AVGPOOL2D function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6161",
+		"EventName": "NNPA_LSTMACT",
+		"BriefDescription": "NNPA LSTMACT function",
+		"PublicDescription": "NNPA-LSTMACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6162",
+		"EventName": "NNPA_GRUACT",
+		"BriefDescription": "NNPA GRUACT function",
+		"PublicDescription": "NNPA-GRUACT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6163",
+		"EventName": "NNPA_CONVOLUTION",
+		"BriefDescription": "NNPA CONVOLUTION function",
+		"PublicDescription": "NNPA-CONVOLUTION function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6164",
+		"EventName": "NNPA_MATMUL_OP",
+		"BriefDescription": "NNPA MATMUL OP function",
+		"PublicDescription": "NNPA-MATMUL-OP function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6165",
+		"EventName": "NNPA_MATMUL_OP_BCAST23",
+		"BriefDescription": "NNPA MATMUL OP BCAST23 function",
+		"PublicDescription": "NNPA-MATMUL-OP-BCAST23 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6166",
+		"EventName": "NNPA_SMALLBATCH",
+		"BriefDescription": "NNPA Counter 22",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6167",
+		"EventName": "NNPA_LARGEDIM",
+		"BriefDescription": "NNPA Counter 23",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6168",
+		"EventName": "NNPA_SMALLTENSOR",
+		"BriefDescription": "NNPA Counter 24",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6169",
+		"EventName": "NNPA_1MFRAME",
+		"BriefDescription": "NNPA Counter 25",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6170",
+		"EventName": "NNPA_2GFRAME",
+		"BriefDescription": "NNPA Counter 26",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6171",
+		"EventName": "NNPA_ACCESSEXCEPT",
+		"BriefDescription": "NNPA Counter 27",
+		"PublicDescription": "NNPA function with conditions as described in Principles of Operation"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6172",
+		"EventName": "NNPA_TRANSFORM",
+		"BriefDescription": "NNPA-TRANSFORM function",
+		"PublicDescription": "NNPA-TRANSFORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6173",
+		"EventName": "NNPA_GELU",
+		"BriefDescription": "NNPA-GELU function",
+		"PublicDescription": "NNPA-GELU function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6174",
+		"EventName": "NNPA_MOMENTS",
+		"BriefDescription": "NNPA-MOMENTS function",
+		"PublicDescription": "NNPA-MOMENTS function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6175",
+		"EventName": "NNPA_LAYERNORM",
+		"BriefDescription": "NNPA-LAYERNORM function",
+		"PublicDescription": "NNPA-LAYERNORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6176",
+		"EventName": "NNPA_MATMUL_OP_BCAST1",
+		"BriefDescription": "NNPA-MATMUL_OP_BCAST1 function",
+		"PublicDescription": "NNPA-MATMUL-OP-BCAST1 function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6177",
+		"EventName": "NNPA_SQRT",
+		"BriefDescription": "NNPA-SQRT function",
+		"PublicDescription": "NNPA-SQRT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6178",
+		"EventName": "NNPA_INVSQRT",
+		"BriefDescription": "NNPA-INVSQRT function",
+		"PublicDescription": "NNPA-INVSQRT function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6179",
+		"EventName": "NNPA_NORM",
+		"BriefDescription": "NNPA-NORM function",
+		"PublicDescription": "NNPA-NORM function ending with CC=0"
+	},
+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6180",
+		"EventName": "NNPA_REDUCE",
+		"BriefDescription": "NNPA-REDUCE function",
+		"PublicDescription": "NNPA-REDUCE function ending with CC=0"
+	}
+]
diff --git a/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
new file mode 100644
index 000000000000..74df533c8b6f
--- /dev/null
+++ b/tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
@@ -0,0 +1,72 @@
+[
+  {
+    "BriefDescription": "Transaction count",
+    "MetricName": "transaction",
+    "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_SPECIAL + TX_C_TABORT_NO_SPECIAL if has_event(TX_C_TEND) else 0"
+  },
+  {
+    "BriefDescription": "Cycles per Instruction",
+    "MetricName": "cpi",
+    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS if has_event(INSTRUCTIONS) else 0"
+  },
+  {
+    "BriefDescription": "Problem State Instruction Ratio",
+    "MetricName": "prbstate",
+    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+  },
+  {
+    "BriefDescription": "Level One Miss per 100 Instructions",
+    "MetricName": "l1mp",
+    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * 100 if has_event(INSTRUCTIONS) else 0"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 2 cache",
+    "MetricName": "l2p",
+    "MetricExpr": "((DCW_REQ + DCW_REQ_IV + ICW_REQ + ICW_REQ_IV) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ) else 0"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 3 on same chip cache",
+    "MetricName": "l3p",
+    "MetricExpr": "((DCW_REQ_CHIP_HIT + DCW_ON_CHIP + DCW_ON_CHIP_IV + DCW_ON_CHIP_CHIP_HIT + ICW_REQ_CHIP_HIT + ICW_ON_CHIP + ICW_ON_CHIP_IV + ICW_ON_CHIP_CHIP_HIT) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_CHIP_HIT) else 0"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Local cache on same drawer",
+    "MetricName": "l4lp",
+    "MetricExpr": "((DCW_REQ_DRAWER_HIT + DCW_ON_CHIP_DRAWER_HIT + DCW_ON_MODULE + DCW_ON_DRAWER + IDCW_ON_MODULE_IV + IDCW_ON_MODULE_CHIP_HIT + IDCW_ON_MODULE_DRAWER_HIT + IDCW_ON_DRAWER_IV + IDCW_ON_DRAWER_CHIP_HIT + IDCW_ON_DRAWER_DRAWER_HIT + ICW_REQ_DRAWER_HIT + ICW_ON_CHIP_DRAWER_HIT + ICW_ON_MODULE + ICW_ON_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_REQ_DRAWER_HIT) else 0"
+  },
+  {
+    "BriefDescription": "Percentage sourced from Level 4 Remote cache on different book",
+    "MetricName": "l4rp",
+    "MetricExpr": "((DCW_OFF_DRAWER + IDCW_OFF_DRAWER_IV + IDCW_OFF_DRAWER_CHIP_HIT + IDCW_OFF_DRAWER_DRAWER_HIT + ICW_OFF_DRAWER) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_OFF_DRAWER) else 0"
+  },
+  {
+    "BriefDescription": "Percentage sourced from memory",
+    "MetricName": "memp",
+    "MetricExpr": "((DCW_ON_CHIP_MEMORY + DCW_ON_MODULE_MEMORY + DCW_ON_DRAWER_MEMORY + DCW_OFF_DRAWER_MEMORY) / (L1I_DIR_WRITES + L1D_DIR_WRITES)) * 100 if has_event(DCW_ON_CHIP_MEMORY) else 0"
+  },
+  {
+    "BriefDescription": "Cycles per Instructions from Finite cache/memory",
+    "MetricName": "finite_cpi",
+    "MetricExpr": "L1C_TLB2_MISSES / INSTRUCTIONS if has_event(L1C_TLB2_MISSES) else 0"
+  },
+  {
+    "BriefDescription": "Estimated Instruction Complexity CPI infinite Level 1",
+    "MetricName": "est_cpi",
+    "MetricExpr": "(CPU_CYCLES / INSTRUCTIONS) - (L1C_TLB2_MISSES / INSTRUCTIONS) if has_event(INSTRUCTIONS) else 0"
+  },
+  {
+    "BriefDescription": "Estimated Sourcing Cycles per Level 1 Miss",
+    "MetricName": "scpl1m",
+    "MetricExpr": "L1C_TLB2_MISSES / (L1I_DIR_WRITES + L1D_DIR_WRITES) if has_event(L1C_TLB2_MISSES) else 0"
+  },
+  {
+    "BriefDescription": "Estimated TLB CPU percentage of Total CPU",
+    "MetricName": "tlb_percent",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / CPU_CYCLES) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) * 100 if has_event(CPU_CYCLES) else 0"
+  },
+  {
+    "BriefDescription": "Estimated Cycles per TLB Miss",
+    "MetricName": "tlb_miss",
+    "MetricExpr": "((DTLB2_MISSES + ITLB2_MISSES) / (DTLB2_WRITES + ITLB2_WRITES)) * (L1C_TLB2_MISSES / (L1I_PENALTY_CYCLES + L1D_PENALTY_CYCLES)) if has_event(DTLB2_MISSES) else 0"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/s390/mapfile.csv b/tools/perf/pmu-events/arch/s390/mapfile.csv
index b22648d12751..6fdede50e7b2 100644
--- a/tools/perf/pmu-events/arch/s390/mapfile.csv
+++ b/tools/perf/pmu-events/arch/s390/mapfile.csv
@@ -6,3 +6,4 @@ Family-model,Version,Filename,EventType
 ^IBM.390[67].*[13]\.[1-5].[[:xdigit:]]+$,3,cf_z14,core
 ^IBM.856[12].*3\.6.[[:xdigit:]]+$,3,cf_z15,core
 ^IBM.393[12].*$,3,cf_z16,core
+^IBM.917[56].*$,3,cf_z17,core
-- 
2.49.0


