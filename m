Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E5489A12
	for <lists+linux-s390@lfdr.de>; Mon, 10 Jan 2022 14:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiAJNge (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 10 Jan 2022 08:36:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34816 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232725AbiAJNg3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Jan 2022 08:36:29 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ADA70I019579;
        Mon, 10 Jan 2022 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k9aUaPhm/SpQCSHna1cZZVJMsvPg6iUqAY4voz2hDo8=;
 b=WSiY15VRl54umRshEwz/Sp40w4KGAC58crRZesaT4pO04+KuMJkAfD68vkTIK8nL1hnV
 s0iHJdeM+1d1NWtRlU3jPFVkfKp8Ytjsyf1EahhCTVd2V4VsKjLGlWjVUxzlmRuXboZp
 L13R4GOKLfq0/jlh2ncz9SC7/mytEa+JUsVUG65M/IASCqC1qdhYN3Dn0gpjSCV339b1
 kRYY4IdcRAOWFQQbVGs3TRsr4ItbSRykXD+T4dQ0UiUMhwz1Km07Vz9DUyhLlszHJB7L
 yXIAHelydph1Gu/t5aYplsLaWaWuBw8sye/Bn4y1axdLWiY6z6RW0eXv7/tFgX/vIbpD Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm04kr2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 13:36:29 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20ADHK9l020676;
        Mon, 10 Jan 2022 13:36:28 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm04kr24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 13:36:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20ADW5c9031752;
        Mon, 10 Jan 2022 13:36:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3df288n9sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 13:36:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20ADaNU841484732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 13:36:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C8E042070;
        Mon, 10 Jan 2022 13:36:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C06BF42107;
        Mon, 10 Jan 2022 13:36:22 +0000 (GMT)
Received: from li-c6ac47cc-293c-11b2-a85c-d421c8e4747b.ibm.com.com (unknown [9.171.85.190])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 10 Jan 2022 13:36:22 +0000 (GMT)
From:   Pierre Morel <pmorel@linux.ibm.com>
To:     linux-s390@vger.kernel.org
Cc:     frankja@linux.ibm.com, thuth@redhat.com, kvm@vger.kernel.org,
        cohuck@redhat.com, imbrenda@linux.ibm.com, david@redhat.com
Subject: [kvm-unit-tests PATCH v3 4/4] s390x: topology: Checking Configuration Topology Information
Date:   Mon, 10 Jan 2022 14:37:55 +0100
Message-Id: <20220110133755.22238-5-pmorel@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220110133755.22238-1-pmorel@linux.ibm.com>
References: <20220110133755.22238-1-pmorel@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VuPg-J4p1rUjM8UZzL1t8RaByzCm_HCM
X-Proofpoint-ORIG-GUID: qNzKRcZ7VV0DjUkgym5hpmHDghIvvu_p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_06,2022-01-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100095
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

STSI with function code 15 is used to store the CPU configuration
topology.

We check :
- if the topology stored is coherent between the QEMU -smp
  parameters and kernel parameters.
- the number of CPUs
- the maximum number of CPUs
- the number of containers of each levels for every STSI(15.1.x)
  instruction allowed by the machine.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 lib/s390x/stsi.h    |  44 +++++++++
 s390x/topology.c    | 231 ++++++++++++++++++++++++++++++++++++++++++++
 s390x/unittests.cfg |   1 +
 3 files changed, 276 insertions(+)

diff --git a/lib/s390x/stsi.h b/lib/s390x/stsi.h
index 02cc94a6..e3fc7ac0 100644
--- a/lib/s390x/stsi.h
+++ b/lib/s390x/stsi.h
@@ -29,4 +29,48 @@ struct sysinfo_3_2_2 {
 	uint8_t ext_names[8][256];
 };
 
+struct topology_core {
+	uint8_t nl;
+	uint8_t reserved1[3];
+	uint8_t reserved4:5;
+	uint8_t d:1;
+	uint8_t pp:2;
+	uint8_t type;
+	uint16_t origin;
+	uint64_t mask;
+};
+
+struct topology_container {
+	uint8_t nl;
+	uint8_t reserved[6];
+	uint8_t id;
+};
+
+union topology_entry {
+	uint8_t nl;
+	struct topology_core cpu;
+	struct topology_container container;
+};
+
+#define CPU_TOPOLOGY_MAX_LEVEL 6
+struct sysinfo_15_1_x {
+	uint8_t reserved0[2];
+	uint16_t length;
+	uint8_t mag[CPU_TOPOLOGY_MAX_LEVEL];
+	uint8_t reserved10;
+	uint8_t mnest;
+	uint8_t reserved12[4];
+	union topology_entry tle[0];
+};
+
+static inline int cpus_in_tle_mask(uint64_t val)
+{
+	int i, n;
+
+	for (i = 0, n = 0; i < 64; i++, val >>= 1)
+		if (val & 0x01)
+			n++;
+	return n;
+}
+
 #endif  /* _S390X_STSI_H_ */
diff --git a/s390x/topology.c b/s390x/topology.c
index a227555e..d06e7c4d 100644
--- a/s390x/topology.c
+++ b/s390x/topology.c
@@ -16,6 +16,15 @@
 #include <smp.h>
 #include <sclp.h>
 #include <s390x/vm.h>
+#include <s390x/stsi.h>
+
+static uint8_t pagebuf[PAGE_SIZE * 2] __attribute__((aligned(PAGE_SIZE * 2)));
+
+static int max_nested_lvl;
+static int number_of_cpus;
+static int max_cpus = 1;
+static int arch_topo_lvl[CPU_TOPOLOGY_MAX_LEVEL];	/* Topology level defined by architecture */
+static int stsi_nested_lvl[CPU_TOPOLOGY_MAX_LEVEL];	/* Topology nested level reported in STSI */
 
 #define PTF_REQ_HORIZONTAL	0
 #define PTF_REQ_VERTICAL	1
@@ -83,11 +92,230 @@ end:
 	report_prefix_pop();
 }
 
+/*
+ * stsi_check_maxcpus
+ * @info: Pointer to the stsi information
+ *
+ * The product of the numbers of containers per level
+ * is the maximum number of CPU allowed by the machine.
+ */
+static void stsi_check_maxcpus(struct sysinfo_15_1_x *info)
+{
+	int n, i;
+
+	report_prefix_push("maximum cpus");
+
+	for (i = 0, n = 1; i < CPU_TOPOLOGY_MAX_LEVEL; i++) {
+		report_info("Mag%d: %d", CPU_TOPOLOGY_MAX_LEVEL - i, info->mag[i]);
+		n *= info->mag[i] ? info->mag[i] : 1;
+	}
+	report(n == max_cpus, "Maximum CPUs %d expected %d", n, max_cpus);
+
+	report_prefix_pop();
+}
+
+/*
+ * stsi_check_tle_coherency
+ * @info: Pointer to the stsi information
+ * @sel2: Topology level to check.
+ *
+ * We verify that we get the expected number of Topology List Entry
+ * containers for a specific level.
+ */
+static void stsi_check_tle_coherency(struct sysinfo_15_1_x *info, int sel2)
+{
+	struct topology_container *tc, *end;
+	struct topology_core *cpus;
+	int n = 0;
+	int i;
+
+	report_prefix_push("TLE coherency");
+
+	tc = (void *)&info->tle[0];
+	end = (struct topology_container *)((unsigned long)info + info->length);
+
+	for (i = 0; i < CPU_TOPOLOGY_MAX_LEVEL; i++)
+		stsi_nested_lvl[i] = 0;
+
+	while (tc < end) {
+		if (tc->nl > 5) {
+			report_abort("Unexpected TL Entry: tle->nl: %d", tc->nl);
+			return;
+		}
+		if (tc->nl == 0) {
+			cpus = (struct topology_core *)tc;
+			n += cpus_in_tle_mask(cpus->mask);
+			report_info("cpu type %02x  d: %d pp: %d", cpus->type, cpus->d, cpus->pp);
+			report_info("origin : %04x mask %016lx", cpus->origin, cpus->mask);
+		}
+
+		stsi_nested_lvl[tc->nl]++;
+		report_info("level %d: lvl: %d id: %d cnt: %d",
+			    tc->nl, tc->nl, tc->id, stsi_nested_lvl[tc->nl]);
+
+		/* trick: CPU TLEs are twice the size of containers TLE */
+		if (tc->nl == 0)
+			tc++;
+		tc++;
+	}
+	report(n == number_of_cpus, "Number of CPUs  : %d expect %d", n, number_of_cpus);
+	/*
+	 * For KVM we accept
+	 * - only 1 type of CPU
+	 * - only horizontal topology
+	 * - only dedicated CPUs
+	 * This leads to expect the number of entries of level 0 CPU
+	 * Topology Level Entry (TLE) to be:
+	 * 1 + (number_of_cpus - 1)  / arch_topo_lvl[0]
+	 *
+	 * For z/VM or LPAR this number can only be greater if different
+	 * polarity, CPU types because there may be a nested level 0 CPU TLE
+	 * for each of the CPU/polarity/sharing types in a level 1 container TLE.
+	 */
+	n =  (number_of_cpus - 1)  / arch_topo_lvl[0];
+	report(stsi_nested_lvl[0] >=  n + 1,
+	       "CPU Type TLE    : %d expect %d", stsi_nested_lvl[0], n + 1);
+
+	/* For each level found in STSI */
+	for (i = 1; i < CPU_TOPOLOGY_MAX_LEVEL; i++) {
+		/*
+		 * For non QEMU/KVM hypervizor the concatanation of the levels
+		 * above level 1 are architecture dependent.
+		 * Skip these checks.
+		 */
+		if (!vm_is_kvm() && sel2 != 2)
+			continue;
+
+		/* For QEMU/KVM we expect a simple calculation */
+		if (sel2 > i) {
+			report(stsi_nested_lvl[i] ==  n + 1,
+			       "Container TLE  %d: %d expect %d", i, stsi_nested_lvl[i], n + 1);
+			n /= arch_topo_lvl[i];
+		}
+	}
+
+	report_prefix_pop();
+}
+
+/*
+ * check_sysinfo_15_1_x
+ * @info: pointer to the STSI info structure
+ * @sel2: the selector giving the topology level to check
+ *
+ * Check if the validity of the STSI instruction and then
+ * calls specific checks on the information buffer.
+ */
+static void check_sysinfo_15_1_x(struct sysinfo_15_1_x *info, int sel2)
+{
+	int ret;
+
+	report_prefix_pushf("15_1_%d", sel2);
+
+	ret = stsi(pagebuf, 15, 1, sel2);
+	if (max_nested_lvl >= sel2)
+		report(!ret, "Valid stsi instruction");
+	else
+		report(ret, "Invalid stsi instruction");
+	if (ret)
+		goto end;
+
+	stsi_check_maxcpus(info);
+	stsi_check_tle_coherency(info, sel2);
+
+end:
+	report_prefix_pop();
+}
+
+/*
+ * test_stsi
+ *
+ * Retrieves the maximum nested topology level supported by the architecture
+ * and the number of CPUs.
+ * Calls the checking for the STSI instruction in sel2 reverse level order
+ * from 6 (CPU_TOPOLOGY_MAX_LEVEL) to 2 to have the most interesting level,
+ * the one triggering a topology-change-report-pending condition, level 2,
+ * at the end of the report.
+ *
+ */
+static void test_stsi(void)
+{
+	int sel2;
+
+	max_nested_lvl = sclp_get_stsi_parm();
+	/* If the STSI parm is 0, the Maximum Nesting for STSI is 2 */
+	if (!max_nested_lvl)
+		max_nested_lvl = 2;
+	report_info("SCLP maximum nested level : %d", max_nested_lvl);
+
+	number_of_cpus = sclp_get_cpu_num();
+	report_info("SCLP number of CPU: %d", number_of_cpus);
+
+	/* STSI selector 2 can takes values between 2 and 6 */
+	for (sel2 = 6; sel2 >= 2; sel2--)
+		check_sysinfo_15_1_x((struct sysinfo_15_1_x *)pagebuf, sel2);
+}
+
+/*
+ * parse_topology_args
+ * @argc: number of arguments
+ * @argv: argument array
+ *
+ * This function initialize the architecture topology levels
+ * which should be the same as the one provided by the hypervisor.
+ *
+ * We use the current names found in IBM/Z literature, Linux and QEMU:
+ * cores, sockets/packages, books, drawers and nodes to facilitate the
+ * human machine interface but store the result in a machine abstract
+ * array of architecture topology levels.
+ * Note that when QEMU uses socket as a name for the topology level 1
+ * Linux uses package or physical_package.
+ */
+static void parse_topology_args(int argc, char **argv)
+{
+	int i;
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp("-c", argv[i])) {
+			i++;
+			if (i >= argc)
+				report_abort("-c (cores) needs a parameter");
+			arch_topo_lvl[0] = atol(argv[i]);
+		} else if (!strcmp("-s", argv[i])) {
+			i++;
+			if (i >= argc)
+				report_abort("-s (sockets) needs a parameter");
+			arch_topo_lvl[1] = atol(argv[i]);
+		} else if (!strcmp("-b", argv[i])) {
+			i++;
+			if (i >= argc)
+				report_abort("-b (books) needs a parameter");
+			arch_topo_lvl[2] = atol(argv[i]);
+		} else if (!strcmp("-d", argv[i])) {
+			i++;
+			if (i >= argc)
+				report_abort("-d (drawers) needs a parameter");
+			arch_topo_lvl[3] = atol(argv[i]);
+		} else if (!strcmp("-n", argv[i])) {
+			i++;
+			if (i >= argc)
+				report_abort("-n (nodes) needs a parameter");
+			arch_topo_lvl[4] = atol(argv[i]);
+		}
+	}
+
+	for (i = 0; i < CPU_TOPOLOGY_MAX_LEVEL; i++) {
+		if (!arch_topo_lvl[i])
+			arch_topo_lvl[i] = 1;
+		max_cpus *= arch_topo_lvl[i];
+	}
+}
+
 static struct {
 	const char *name;
 	void (*func)(void);
 } tests[] = {
 	{ "PTF", test_ptf},
+	{ "STSI", test_stsi},
 	{ NULL, NULL }
 };
 
@@ -97,6 +325,8 @@ int main(int argc, char *argv[])
 
 	report_prefix_push("CPU Topology");
 
+	parse_topology_args(argc, argv);
+
 	if (!test_facility(11)) {
 		report_skip("Topology facility not present");
 		goto end;
@@ -109,6 +339,7 @@ int main(int argc, char *argv[])
 		tests[i].func();
 		report_prefix_pop();
 	}
+
 end:
 	report_prefix_pop();
 	return report_summary();
diff --git a/s390x/unittests.cfg b/s390x/unittests.cfg
index e2d3e6a5..bc19b5b6 100644
--- a/s390x/unittests.cfg
+++ b/s390x/unittests.cfg
@@ -125,3 +125,4 @@ extra_params = -smp 1,maxcpus=3 -cpu qemu -device qemu-s390x-cpu,core-id=2 -devi
 
 [topology]
 file = topology.elf
+extra_params=-smp 5,drawers=2,books=3,sockets=4,cores=4,maxcpus=16 -append "-d 2 -b 3 -s 4 -c 4"
-- 
2.27.0

