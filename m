Return-Path: <linux-s390+bounces-12200-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2022B352AB
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 06:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE3B189D5B2
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 04:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB441F4191;
	Tue, 26 Aug 2025 04:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SNJQUTek"
X-Original-To: linux-s390@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FA41632C8;
	Tue, 26 Aug 2025 04:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181773; cv=fail; b=HzWD7xNWsiTIqX1jpKEbdhORFFo2KQBGk7oeSI6oju439EhIu4YmcFd66as+YHcoP9iATGhpP4b+1Jwj1PbglU/NAf8ytIWCF/pugujTqprMiIxX0gjH/NFeZ+5xkpILD1ODdYCWbMox1s6Xlc+SR6lRfyJAxTwDGG0CdQQEQIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181773; c=relaxed/simple;
	bh=9srcT4JK/5LHVVQzemWovWyGdI1JlFnfVi8uP3EJK2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF08bYqvTTSdgI0TeZmVvEF0xwlQarin9nLvPBMruTQgvkdBO4n7jUWPD8rSOifGh+PGLAzlhBTQJMLB/81SNylRDH6Ko2qAkSekdYvazFHCoea+e1jzlF+zzVTCJoXaWFtHfvT1nyTl+i7Cljc0uAnUZRKc2VpZIs1gmnlKt1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SNJQUTek; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8JHERIGt1G3TzMVJBUGYrmq7wkEwacgamUCmhJbFOMTu0mx/tpuQe2gFKEo7MSIIdBTlWQHSe5ELKF+Y7AZ5vks6xheukryD5ZizERTCmV5U3KPhJVZA4AeKRzgr1IO+FVoYYhz0rPmq+1AG5pYqF/F+cjcQyka3tYBdywkuyURX+6Cyu18hxIHajaUjce663jwJrdBYHnLDfp1q2q45vb9XD0ZXPWgalS6XRJ6pSrwJh1LEFxhlAI5UmJe5M+59BzEt33y0qBybZlvpuUrTpU6qB4kDg9a05Q7xOPfOpC6JW1qM6f6N5TQLgPGhXmWpfFTo4mrtHZnEh7EmH/OsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqmJe6GT1AnaxJWE8EM6lbSaOJZzB7Nk4nj9o5z9dDU=;
 b=PFMDrPiGuG9oJBPJzsrEFPF/sBP7vHmLmI16UC6xHiyjwNYwuqBouJQ2yDjqEUjOtTVu4Dxe93DwxWNtuBNMNr3J0wDGEROrK7zej9fEltabtGZhoN/MOgUdhzCdkH3FVVzV4fJheNoCZ0GODN7KkPjpDRV6EYAElLTmrfsGemHG/zN2H4FkfLmRo1z/bibreY2ezBped2HhUOkyhmXlA1cWCEAvejamlqnwQTfFaOss8yMCjNg94ddKPMpOuhYr7M4ymDid+/FPtFCWwMvdAAP0cSgY3Doc1I8169B5puiEeAK2ZzOH2OWL286CHHmUSsiSCVCQ8tYrsRmEn9BPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqmJe6GT1AnaxJWE8EM6lbSaOJZzB7Nk4nj9o5z9dDU=;
 b=SNJQUTek9i/t9u5r9a3RmeHBNIzztgWRwE4WuudiBbue4tNF0dCs70hrGcvpoobmXB7VbygWGyNAuC0zmLqjn4rGTYeZQh44qxPS1dx/1TbjxYPCnl5OpzytNVfCERcwTFnB+1LpoGL5yZ2Hqxtp5FlxDydCVdhHVt8iGU+vS/0=
Received: from DM6PR06CA0073.namprd06.prod.outlook.com (2603:10b6:5:336::6) by
 SA1PR12MB7104.namprd12.prod.outlook.com (2603:10b6:806:29e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 26 Aug 2025 04:16:06 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::c4) by DM6PR06CA0073.outlook.office365.com
 (2603:10b6:5:336::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 04:16:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 04:16:06 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 23:15:49 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, <thomas.weissschuh@linutronix.de>, Li Chen
	<chenl311@chinatelecom.cn>, Bibo Mao <maobibo@loongson.cn>, Mete Durlu
	<meted@linux.ibm.com>, Tobias Huschle <huschle@linux.ibm.com>, "Easwar
 Hariharan" <easwar.hariharan@linux.microsoft.com>, Guo Weikang
	<guoweikang.kernel@gmail.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Brian Gerst <brgerst@gmail.com>, Patryk Wlazlyn
	<patryk.wlazlyn@linux.intel.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
	"Yury Norov [NVIDIA]" <yury.norov@gmail.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andrea Righi <arighi@nvidia.com>, Yicong Yang <yangyicong@hisilicon.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard MC scheduling bits
Date: Tue, 26 Aug 2025 04:13:15 +0000
Message-ID: <20250826041319.1284-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250826041319.1284-1-kprateek.nayak@amd.com>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SA1PR12MB7104:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d7a198c-1697-4cb4-3d34-08dde457474b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NdtIlMHSzwOBmmhffCf61ohFaxM5LX+dKM41cwynFCsLOLvnkkuDfa//T7gA?=
 =?us-ascii?Q?juiyRrtCfxodoed4t1C4yJ3KeknmfD8e+9AzEeQ3BF0EzBlszW5P7WKqr+LC?=
 =?us-ascii?Q?J7ixdiBzeDeprsdOGVD31AwlBdnYCzNxGF8QFNVTXur2PTqVu7+6dFdTT7hR?=
 =?us-ascii?Q?pD8B1ab7EhgCl81XDax8Jzqx7gUHZX0B+BsMfeTVL7C+tUCkmVR4mGbjMXmw?=
 =?us-ascii?Q?B21q+U3Hlw8IHugx00jFes+6FiCljAfnt8RaDqKg8MhpmHWOyC4fm45b5vZb?=
 =?us-ascii?Q?yxOendC+z5iyrOyIf0sgPnQWYNFc6lizZUJn8uqtKqwCt31PNbRnuc1kEDlD?=
 =?us-ascii?Q?pa0PQu83vWmDE59F0RZQu86etGYM2EO/yXwNZH44DesGXR58e2bgJNM+QvS6?=
 =?us-ascii?Q?NxOtAaRbvm8fmp2zeP3Ke4SZxXe1VzpA/TWodpHXR5iQNfR2C5xzmfm6wIUS?=
 =?us-ascii?Q?7c6OrWDAGRLNGL9zaQhxYIX7KJELjCrjXN29O9c9qTNFTTmoftm2AZgxgI0B?=
 =?us-ascii?Q?um8Oo1XGmFKuXu6diH30P1o1MyH0py1XrFL8nv7sLyP7Yd4ZBGoMcPFFX3tx?=
 =?us-ascii?Q?tJzRKTHylDd6aPnf37mhJQ2HMrna2D85QHFzUbsmBHoow5BACgcLTXGriKhz?=
 =?us-ascii?Q?I5miK3M14sDCXUaELgV41JYedxatugAsgJYCqgupx82j+0LjAT8CCTk7CB2Y?=
 =?us-ascii?Q?SPDK1iy3hQ7Sem2jhpx2mNDk2zisGj2S3a5ojAl6N/C0kKAhYlUIxxxrrxDV?=
 =?us-ascii?Q?77kgczjMQK/ql/MERdkfWHK6HEKAG7oMgxY25MYax8bGduIj231qhF8KCqjY?=
 =?us-ascii?Q?H19Vl238btP54Qt6u20H6wBNJ0TZa4XzgyV68qLf8wwKjDg7SZJDBgV4iU80?=
 =?us-ascii?Q?PU1nTWdoAQSfYNFzp6krWu53lmBClApZ+eiUuBwVam/gvOcrzN99NOA+IdZl?=
 =?us-ascii?Q?2syk2o4dzCtZD+awNdKtRxjYsITccgP9JWXic/qtSqc8cCh3bphV5+NSQKQA?=
 =?us-ascii?Q?EMNgIhxM8tZ3o1nI/OnERaBMSbbs9wtgiCDX+l+6Pmrm+pQK2JeYvJ3Mf5Af?=
 =?us-ascii?Q?/yqSPesNsHXM/kzqj0SH8yhYxJG0pg/INJ/Ugj2zDpIQ24yeAtweSfjLUSho?=
 =?us-ascii?Q?AFaBvx0EC3XH7bdkixB48QJfpFKxjAvPaAubU87C8UGB8EaUX67dQBxTDoTU?=
 =?us-ascii?Q?zgViP45Y7amItCgmHdJdYWIywxJ+4IlKpFWt3SZZ0XdjHdw7aV9aYVr9qpUR?=
 =?us-ascii?Q?IgR2GWahY65ICqJZdRNyPWztRCUGUc47s7BstFAHtgBwDcKoHUul1GuCJg29?=
 =?us-ascii?Q?6Yulj97Hxsf7mlcEdwpdur26/0ny8WJ7VFRS3wWReTIHy2VFLSe8R7k7V4gh?=
 =?us-ascii?Q?4jfIACKvZBJHmNLckSHyR0iEfjZxH1HvQWm0nTDoEm5syztkDdKl+7nZUk/s?=
 =?us-ascii?Q?AgsL3QluXpP7S3X8UN+wFRq9BiXvvEmlZIzwT7uvnoCn8o6HEqVTy4hze4IF?=
 =?us-ascii?Q?fIqIoVSH+kAfch/Yl0QT25XUEL5loMwLSdII1b9pxOEZ5TMMoRKzXOJgpg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 04:16:06.5080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d7a198c-1697-4cb4-3d34-08dde457474b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7104

PowerPC enables the MC scheduling domain by default on systems with
coregroup support without having a SCHED_MC config in Kconfig.

The scheduler uses CONFIG_SCHED_MC to introduce the MC domain in the
default topology (core) and to optimize the default CPU selection
routine (sched-ext).

Introduce CONFIG_SCHED_MC for powerpc and note that it should be
preferably enabled given the current default behavior. This also ensures
PowerPC is tested during future developments that come to depend on
CONFIG_SCHED_MC.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/powerpc/Kconfig           | 9 +++++++++
 arch/powerpc/include/asm/smp.h | 2 ++
 arch/powerpc/kernel/smp.c      | 4 ++++
 3 files changed, 15 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1d9c9f..e954ab3f635f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -971,6 +971,15 @@ config SCHED_SMT
 	  when dealing with POWER5 cpus at a cost of slightly increased
 	  overhead in some places. If unsure say N here.
 
+config SCHED_MC
+	bool "Multi-Core Cache (MC) scheduler support"
+	depends on PPC64 && SMP
+	default y
+	help
+	  MC scheduler support improves the CPU scheduler's decision making
+	  when dealing with POWER systems that contain multiple Last Level
+	  Cache instances on the same socket. If unsure say Y here.
+
 config PPC_DENORMALISATION
 	bool "PowerPC denormalisation exception handling"
 	depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 86de4d0dd0aa..9a320d96e891 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -148,7 +148,9 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif /* CONFIG_SCHED_SMT */
 
+#ifdef CONFIG_SCHED_MC
 extern const struct cpumask *cpu_coregroup_mask(int cpu);
+#endif
 
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e623f2864dc4..7f79b853b221 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1059,6 +1059,7 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
 
+#ifdef CONFIG_SCHED_MC
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	if (has_coregroup_support())
@@ -1071,6 +1072,7 @@ static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl,
 {
 	return cpu_corgrp_mask(cpu);
 }
+#endif
 
 static const struct cpumask *cpu_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
 {
@@ -1729,10 +1731,12 @@ static void __init build_sched_topology(void)
 			SDTL_INIT(shared_cache_mask, powerpc_shared_cache_flags, CACHE);
 	}
 
+#ifdef CONFIG_SCHED_MC
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =
 			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
 	}
+#endif
 
 	powerpc_topology[i++] = SDTL_INIT(cpu_pkg_mask, powerpc_shared_proc_flags, PKG);
 
-- 
2.34.1


