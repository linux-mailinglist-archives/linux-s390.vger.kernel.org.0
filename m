Return-Path: <linux-s390+bounces-12199-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA5B352A8
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 06:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98481A815B6
	for <lists+linux-s390@lfdr.de>; Tue, 26 Aug 2025 04:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D65F19DF62;
	Tue, 26 Aug 2025 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ymaYkxzT"
X-Original-To: linux-s390@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDA02206BB;
	Tue, 26 Aug 2025 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756181747; cv=fail; b=D9eyd6X90aJoZ6XXzpUWnQaAGjg95aBSeQr8PeoImG+AwOwHpCGLX0ATjIWKf2W3uPVcZPxeolRjuLy9lafGfc9hB8i72wPlK+QG2M6qcLEp6uYY5B3mvg0xxz3Oq2kVEJ/NJVJ5FZu+2NYnZyufIJVYjyiZ1n6/CUP1VH6iEGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756181747; c=relaxed/simple;
	bh=JYTRzPa2zEBLJlEOBbdVwkyg0/xN6NjEc6CV72xLp2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVws6ABc5Rm03n+wHUtUbnVb1L4mONAvWFRRutrBJkTHa0YcADjhj91X39fJlEcaUxeYV5IT0+1bZZCm2wzAEU+ma9+sOi3hwgbetLMoVdAWy6c4RGe2kInmbrQ/13zcVKjK8gTnJvtjaXeaLRjQoJM9Vdl022ctN+PPKg1kS/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ymaYkxzT; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUlyzD4beCwKqcejTmZbg5ASPO+B3c/FT0p+5vfRsuHjtWXgMgBL7QOFExY0JlFg6QM56ihu85lU6JrnjGRTKmaaRKXkVgxFaSnlqf91Vd/1gl969l5gXCERaKO4eb6s+oB8mm+9Zs1PEfV50njZYoUUFhRqJzGCjzyzsurEHAuaiSuQoL1stfESLV7+3lL0YPkUTjvHB0auQTHh92YNylDGab+wud2oMiAn7VxQh/rc5J6BJIQYiD3ENhNtIr8d8317y92ke/Z7N0u6uFwakuhQcpNM1XTKNAhPpM/CX4pZq7iP4n3jPPI7lonZOZfLhe/WQJa3yY+IQ74u/9uWFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKsg+I86CkxHRgBiU3ymHIp4C5yWlm0APnpkISRln5k=;
 b=ejSMCxmaqwTW0uhRnnrSlmq4CF8n6GVnrSzqhlatNZG06ysrMsyjs/PaXYcKQuuNNsSXFUuzaKUXj4vG6eJyX0qEiDD6KtO+kU+5kmkczfOZtDEsV5VYcvmmLB6QxQnhfPW9fmm2JT/PfuMAkfVYNesbAgFETTTTF0lNcvZtW6evrAsDcR87zWomOpNN5grgtklcA5p/V1QDr6jo+swoZK3kQ/itPZEXda4E30UAz01EKMipR3a+sFxOrRC2RK+EBNjBkkkqQ5q6DvQ69SgvqcfWhBVEkb0BSpUu2FpJKabX4XEHyDJKtNfdy1I2E0bX0nZYn2CEtt+1JIp38HBmxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKsg+I86CkxHRgBiU3ymHIp4C5yWlm0APnpkISRln5k=;
 b=ymaYkxzToImOnXL/2xdwFTUX22NZ8hgyMAeDYk7AsWiPL9FAeVFtQWMYFLrfWvzXFbc4upaKdvSB0cHoSiyp0HL87paIzDb1Dou9M8xcAIbwKX0nlz7E+EaaorIUiatHA6FBcDn3iD9ZLykOPakdISYGy0PR783BfyVrrVGDbJ8=
Received: from DM6PR06CA0092.namprd06.prod.outlook.com (2603:10b6:5:336::25)
 by SJ5PPFCB5E1B8F5.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Tue, 26 Aug
 2025 04:15:36 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::40) by DM6PR06CA0092.outlook.office365.com
 (2603:10b6:5:336::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 04:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 04:15:36 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 23:15:21 -0500
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
Subject: [PATCH v7 3/8] powerpc/smp: Export cpu_coregroup_mask()
Date: Tue, 26 Aug 2025 04:13:14 +0000
Message-ID: <20250826041319.1284-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|SJ5PPFCB5E1B8F5:EE_
X-MS-Office365-Filtering-Correlation-Id: afc2ab7b-ef99-484b-2daf-08dde457354d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QPguovntAajLH1ZgokUJmbOYVNMvQ2thwwI7RxowU29FKx2Od3PMDdLprHi?=
 =?us-ascii?Q?Z0ru8Y0Og0njg0fXLaHBzcW6bdpUPBWlRmo/DAOf51zMowVgna8ExId/UL1I?=
 =?us-ascii?Q?O5GHzD/a9h5Y3xtKEH5fKIjxuQR1KSuytKwQLsKh5pCHnqQeoKAtBJ5lkJ6w?=
 =?us-ascii?Q?T8Vokc7vgXl5wgZXHsCC3WgqZALpwMrSUdFlHErT50A/znxbHN3sh+xk8jfD?=
 =?us-ascii?Q?AbAWDGzbd0DCr8YfEwIp91y8kSS1IfDkQX7N10sQetubu4Wa0ExQgRpSQD2U?=
 =?us-ascii?Q?wjTbtQLlq5DSJoNl8uur9c/ayCtgmjG249A+sHe3zo9ZFo9coAZ8xobOyp2P?=
 =?us-ascii?Q?FkXYiQlb7X7DUfpu+q+9/4umqOlNn/32APUJnfbIqFrzVkX9IC1Zjim4XhTx?=
 =?us-ascii?Q?QfDq+PBH9ydduR9j4Ml5T05LvSYeX84hPHUoc3HbbQHtnGTEZVO3F7AG+OHi?=
 =?us-ascii?Q?Nhx8wpblHEjKI7V3mvTTa3mi77ZjaG8RZfpmbbdk2EPmyQG5EnSdQjhhhago?=
 =?us-ascii?Q?xKHEw0rSvdGEQcegWwf4U5XWM4MOYckXpYKECa9veh9Lz74LrSuqQH0Nfm+j?=
 =?us-ascii?Q?v44TUl7T3vDWvRDBiY+o0OVVXsp+iIA6EtzRsl2q3DrbkoO9JUWDfywDP/8P?=
 =?us-ascii?Q?n/zD1ZjbCQ3QMwGFiowASYM0zlBJfoG33TR/QlVmuSSlFKw/pLRLCP0RMWEG?=
 =?us-ascii?Q?CQDNImVGsJ20qi8JxNfYgl5egV4TR/YvUgYlICXdDwHxfC4BidNaaTjMUyUG?=
 =?us-ascii?Q?hcbetLlW3T7lVOCQbKbrirwm805nrIKcZmto4aN2aICfYV9G68xXKj2J4O75?=
 =?us-ascii?Q?9aNMxc/y7FIzfRHUevAxJCInYDxjl30787/E1rHGVfY13VVSUBgaM+p1A7u+?=
 =?us-ascii?Q?1THMUIgQiuMjnRmKbeBDW+1vZf3GDWP5fbm/yKIqD74DPGMlL449XSETdrNA?=
 =?us-ascii?Q?IcH6GshoX66HE7KMIm9OJBaLNlCHh8zTG4qIhudO9Nvl41XCDDspxdAVUGqJ?=
 =?us-ascii?Q?kXj4z8if3WMWPj988oleMXKrG+Sy814QRO+Ci6xUwgFqfbGeqrGiqkew0k6L?=
 =?us-ascii?Q?0bwz3RnMbrRIC4gmJum/TELDe5d3uUUjs7o6UZ6yU6bg0kEdg0OGcwnS8HHm?=
 =?us-ascii?Q?jruiPvAnkRVVoIlxTe9VrH7I7xuyEeWcT2dQfZb1pcXMix0bmz9kuwkWLIld?=
 =?us-ascii?Q?w3oF6OZtdrXfXX5J9bI6BuuYZAOJzN5gceRNjzxYgjTMdFNVuqy1gG809qCp?=
 =?us-ascii?Q?ZqTGJqrC1UexK6M/RBmlNd7W5bxp2m5q2Xkp2yGK7aPrElPPSJy93QIxgnh5?=
 =?us-ascii?Q?pikJMqRrRr8auTAaF3bC8gC+qSQcLSxAKKWO1lnUcH8MGJPHnch9MSiP7scO?=
 =?us-ascii?Q?FOhFDXDMqw87U6dvQt7BqZs1WZpqURORe/BT+iFDt4nL1uY7TJo4VL6jnW57?=
 =?us-ascii?Q?qy0qXnLTQDLY+zeru8nhuq3CTzG0AdYyh294hvrb2JWyCQd8qg/5SdDyiAbr?=
 =?us-ascii?Q?IIydnKVEG9nReQzEARzFIIKCnE+rhkbZMz9K6OGqqy7sjP2r+cM7kCmA/A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 04:15:36.3210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc2ab7b-ef99-484b-2daf-08dde457354d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFCB5E1B8F5

Deine cpu_coregroup_mask() to export the per-cpu cpu_corgrp_map when
coregroups are supported(). When has_coregroup_support() returns false,
cpu_coregroup_mask() returns the mask used by the PKG domain.

Since this will only be used after CONFIG_SCHED_MC is added for PowerPC,
no functional changes are intended at this point.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/powerpc/include/asm/smp.h | 2 ++
 arch/powerpc/kernel/smp.c      | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index b77927ccb0ab..86de4d0dd0aa 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -148,6 +148,8 @@ static inline const struct cpumask *cpu_smt_mask(int cpu)
 }
 #endif /* CONFIG_SCHED_SMT */
 
+extern const struct cpumask *cpu_coregroup_mask(int cpu);
+
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4f48262658cc..e623f2864dc4 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1059,6 +1059,14 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
 
+const struct cpumask *cpu_coregroup_mask(int cpu)
+{
+	if (has_coregroup_support())
+		return per_cpu(cpu_corgrp_map, cpu);
+
+	return cpu_node_mask(cpu);
+}
+
 static const struct cpumask *cpu_mc_mask(struct sched_domain_topology_level *tl, int cpu)
 {
 	return cpu_corgrp_mask(cpu);
-- 
2.34.1


