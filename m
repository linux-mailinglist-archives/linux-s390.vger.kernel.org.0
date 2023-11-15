Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41FE27E2AC7
	for <lists+linux-s390@lfdr.de>; Mon,  6 Nov 2023 18:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjKFRN7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Nov 2023 12:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKFRN6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Nov 2023 12:13:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AD2125;
        Mon,  6 Nov 2023 09:13:56 -0800 (PST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6HBIo6025846;
        Mon, 6 Nov 2023 17:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4I1kJQ90XgQ+u640fZsblLTReQIgV8UYfjOvD9ktl9o=;
 b=MSyFRyELq2Mw6P4o/gbxgxe2sO2rY4rQaC9Fz/W6lUTOm3OUT6Lzx98VjN4tDW/AUufk
 rFhGvzYHo50eYKAoPivIpmc5s0XOntFjsakDWuIFoys2bIcXsZA41Z4ONOBfZUgtBBam
 XD35SXgF3B7IQA/ltVAinWElSZbqST4t8xJHNipQoWT+ZGgRrLT3LqTKuWjmsAhGKm8W
 Kf+BI3DUU2Y2BA9HAgjzykDfx7dcOFoSwvnEYfdn+hRZAgRhc4gm15akqpBbpFOpwSxs
 clNObrAhl3kJFG8sCTeyEWixk9g01Vq1iH3pymJp9atTmW0Mhn3YB/RnZxVJJ706+zfK Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4j1q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:13:55 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A6HBMwv026315;
        Mon, 6 Nov 2023 17:13:55 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u73f4j1pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:13:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FX3d1016953;
        Mon, 6 Nov 2023 17:08:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u6301j9e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 17:08:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A6H8p9m51839396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Nov 2023 17:08:51 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0910F20040;
        Mon,  6 Nov 2023 17:08:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D532820043;
        Mon,  6 Nov 2023 17:08:50 +0000 (GMT)
Received: from t35lp63.lnxne.boe (unknown [9.152.108.100])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Nov 2023 17:08:50 +0000 (GMT)
From:   Nico Boehr <nrb@linux.ibm.com>
To:     frankja@linux.ibm.com, imbrenda@linux.ibm.com, thuth@redhat.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [kvm-unit-tests PATCH v2 2/3] s390x: sie: ensure guests are aligned to 2GB
Date:   Mon,  6 Nov 2023 18:08:01 +0100
Message-ID: <20231106170849.1184162-3-nrb@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106170849.1184162-1-nrb@linux.ibm.com>
References: <20231106170849.1184162-1-nrb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iDN3IrbYNs4LwiYG5VOOAcx10em7ejTc
X-Proofpoint-ORIG-GUID: afITd0gwDBSsNB5OEGld-rcIOsHCrYs7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060140
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Until now, kvm-unit-tests has aligned guests to 1 MB in the host virtual
address space. Unfortunately, some s390x environments require guests to
be 2GB aligned in the host virtual address space, preventing
kvm-unit-tests which act as a hypervisor from running there.

We can't easily put guests at address 0, since we want to be able to run
with MSO/MSL without having to maintain separate page tables for the
guest physical memory. 2GB is also not a good choice, since the
alloc_pages allocator will place its metadata there when the host has
more than 2GB of memory. In addition, we also want a bit of space after
the end of the host physical memory to be able to catch accesses beyond
the end of physical memory.

The vmalloc allocator unfortunately allocates memory starting at the
highest virtual address which is not suitable for guest memory either
due to additional constraints of some environments.

The physical page allocator in memalign_pages() is also not a optimal
choice, since every test running SIE would then require at least 4GB+1MB
of physical memory.

This results in a few quite complex allocation requirements, hence add a
new function sie_guest_alloc() which allocates memory for a guest and
then establishes a properly aligned virtual space mapping.

Rework snippet test and sie tests to use the new sie_guest_alloc()
function.

Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
---
 lib/s390x/sie.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/s390x/sie.h     |  2 ++
 lib/s390x/snippet.h |  9 +++------
 s390x/sie.c         |  4 ++--
 4 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
index b44febdeaaac..69466dbf030a 100644
--- a/lib/s390x/sie.c
+++ b/lib/s390x/sie.c
@@ -15,6 +15,8 @@
 #include <asm/page.h>
 #include <libcflat.h>
 #include <alloc_page.h>
+#include <vmalloc.h>
+#include <sclp.h>
 
 void sie_expect_validity(struct vm *vm)
 {
@@ -111,6 +113,46 @@ void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_mem_len)
 	vm->sblk->crycbd = (uint32_t)(uintptr_t)vm->crycb;
 }
 
+/**
+ * sie_guest_alloc - Allocate memory for a guest and map it in virtual address
+ * space such that it is properly aligned.
+ * @guest_size the desired size of the guest in bytes.
+ */
+uint8_t *sie_guest_alloc(uint64_t guest_size)
+{
+	static unsigned long guest_counter = 1;
+	u8 *guest_phys, *guest_virt;
+	unsigned long i;
+	pgd_t *root;
+
+	setup_vm();
+	root = (pgd_t *)(stctg(1) & PAGE_MASK);
+
+	/*
+	 * Start of guest memory in host virtual space needs to be aligned to
+	 * 2GB for some environments. It also can't be at 2GB since the memory
+	 * allocator stores its page_states metadata there.
+	 * Thus we use the next multiple of 4GB after the end of physical
+	 * mapping. This also leaves space after end of physical memory so the
+	 * page immediately after physical memory is guaranteed not to be
+	 * present.
+	 */
+	guest_virt = (uint8_t *)ALIGN(get_ram_size() + guest_counter * 4UL * SZ_1G, SZ_2G);
+	guest_counter++;
+
+	guest_phys = alloc_pages(get_order(guest_size) - 12);
+	/*
+	 * Establish a new mapping of the guest memory so it can be 2GB aligned
+	 * without actually requiring 2GB physical memory.
+	 */
+	for (i = 0; i < guest_size; i += PAGE_SIZE) {
+		install_page(root, __pa(guest_phys + i), guest_virt + i);
+	}
+	memset(guest_virt, 0, guest_size);
+
+	return guest_virt;
+}
+
 /* Frees the memory that was gathered on initialization */
 void sie_guest_destroy(struct vm *vm)
 {
diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
index 147cb0f2a556..c1724cf2f67e 100644
--- a/lib/s390x/sie.h
+++ b/lib/s390x/sie.h
@@ -285,4 +285,6 @@ void sie_guest_sca_create(struct vm *vm);
 void sie_guest_create(struct vm *vm, uint64_t guest_mem, uint64_t guest_mem_len);
 void sie_guest_destroy(struct vm *vm);
 
+uint8_t *sie_guest_alloc(uint64_t guest_size);
+
 #endif /* _S390X_SIE_H_ */
diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
index 11ec54c379e9..910849aa186c 100644
--- a/lib/s390x/snippet.h
+++ b/lib/s390x/snippet.h
@@ -125,14 +125,11 @@ static inline void snippet_pv_init(struct vm *vm, const char *gbin,
 /* Allocates and sets up a snippet based guest */
 static inline void snippet_setup_guest(struct vm *vm, bool is_pv)
 {
-	u8 *guest;
-
-	/* Allocate 1MB as guest memory */
-	guest = alloc_pages(8);
-	memset(guest, 0, HPAGE_SIZE);
+	const unsigned long guest_size = SZ_1M;
+	uint8_t *guest_start = sie_guest_alloc(guest_size);
 
 	/* Initialize the vm struct and allocate control blocks */
-	sie_guest_create(vm, (uint64_t)guest, HPAGE_SIZE);
+	sie_guest_create(vm, (uint64_t)guest_start, guest_size);
 
 	if (is_pv) {
 		/* FMT4 needs a ESCA */
diff --git a/s390x/sie.c b/s390x/sie.c
index cd3cea10d100..ce5b6069bf0b 100644
--- a/s390x/sie.c
+++ b/s390x/sie.c
@@ -89,8 +89,8 @@ static void setup_guest(void)
 {
 	setup_vm();
 
-	/* Allocate 1MB as guest memory */
-	guest = alloc_pages(8);
+	guest = sie_guest_alloc(SZ_1M);
+
 	/* The first two pages are the lowcore */
 	guest_instr = guest + PAGE_SIZE * 2;
 
-- 
2.41.0

