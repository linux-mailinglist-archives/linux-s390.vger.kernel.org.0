Return-Path: <linux-s390+bounces-5087-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A9939DF2
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jul 2024 11:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59281F22A75
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jul 2024 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF5014D44E;
	Tue, 23 Jul 2024 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V4no4Xxf"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E514E2C1;
	Tue, 23 Jul 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721727134; cv=none; b=K6TQ5LB9KRcngusLkXAciut/8+yNaHl+uhmtF89LXdtBE3E9ArW1h83FYf/jF8qgbfvP5UerCipkJqfr86DC89+7+A2vOT1garg2Pg8XNMsAQrGWOLl8JBFeohM8yq4enfY3feM0zJ6hIgNse6+qQV027OQO7pjLlkJ4Nc2m8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721727134; c=relaxed/simple;
	bh=n2pxeEl9YPHlGV4b0RlXgzuQxaTed/G5v9sUTYAFibo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LH9UTFYIlqHfYWEFSiHdc6Xk/NUPHW6OPerAmtHJ0eq5QWHStb+ae46WBLkl16VOXBUtYrjQgGy7tq2D2F9yAJL2lF6LEvBapaSxkHcYFEmU/gjWshi6/K2j7LL15c/wHILDhCZIiL2KXb+SunXH6IyHfbwrSMmXHtdo19xb70Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V4no4Xxf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9JMZY006852;
	Tue, 23 Jul 2024 09:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=4Ne2PWnqvqSY6
	//GFyKdhyE3zPnWxqJ/ebuSIwelbX0=; b=V4no4XxfiWK9PxbPEiyxT9tTgL2tt
	f5gWVn1UL75cPO9CHfVyIxdEj+a+C+45HS9oDXcuGi5N3Z2jarOLvrVQOFUt/HI/
	uZk+/r+BOz98BABy+JukSY3E2w8UDaIBA3Ob/y2QCypNMGfqOMPvc/jI9XT/rc0w
	Xw9aPeDOorUR/fnHU8l5mWZlehHKNc6Jzo0R5mc5KABlX3QwPV7LQO/T3iuDdZUC
	mOMwZY4wpTXmVyyRqCMosNb1FlLrFBxDiom20wJK5RgQa6Vbrvsmg0znay3x0j3c
	1bSn6uxx6y9tcno0B+9276of+cKV46tBRVaQR5pqpAwRf2OCpfKyoao9A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1e00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:08 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46N9W7F7026034;
	Tue, 23 Jul 2024 09:32:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40hwma1dyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46N94x77004921;
	Tue, 23 Jul 2024 09:32:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn79qyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 09:32:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46N9W1rr54133004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 09:32:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 806C62004F;
	Tue, 23 Jul 2024 09:32:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFB4820040;
	Tue, 23 Jul 2024 09:32:00 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.28.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jul 2024 09:32:00 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v2 07/10] selftests: kvm: s390: Add uc_map_unmap VM test case
Date: Tue, 23 Jul 2024 11:31:23 +0200
Message-ID: <20240723093126.285319-8-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240723093126.285319-1-schlameuss@linux.ibm.com>
References: <20240723093126.285319-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gcsSxYRxE01H22mYTVwA89WAPwY4Y3fk
X-Proofpoint-GUID: Wmb8Xd59OVGWEhtPTrfc3F44PBmLlEyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_18,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=895 adultscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230065

Add a test case verifying basic running and interaction of ucontrol VMs.
Fill the segment and page tables for allocated memory and map memory on
first access.

* uc_map_unmap
  Store and load data to mapped and unmapped memory and use pic segment
  translation handling to map memory on access.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 171 +++++++++++++++++-
 1 file changed, 170 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index c98d5a3a315b..a39c560ba42e 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -18,7 +18,13 @@
 
 #define SYS_ADMIN_CAP 0x200000
 
+#define UC_PIC_SEGMENT_TRANSLATION 0x10
+
 #define VM_MEM_SIZE (4 * SZ_1M)
+#define VM_MEM_EXT_SIZE (2 * SZ_1M)
+#define VM_MEM_MAX (VM_MEM_SIZE + VM_MEM_EXT_SIZE)
+
+#define PAGES_PER_SEGMENT 4
 
 /* so directly declare capget to check caps without libcap */
 int capget(cap_user_header_t header, cap_user_data_t data);
@@ -60,6 +66,23 @@ asm("test_gprs_pgm:\n"
 	"	j	0b\n"
 );
 
+/* Test program manipulating memory */
+extern char test_mem_pgm[];
+asm("test_mem_pgm:\n"
+	"xgr	%r0, %r0\n"
+
+	"0:\n"
+	"	ahi	%r0,1\n"
+	"	st	%r1,0(%r5,%r6)\n"
+
+	"	xgr	%r1, %r1\n"
+	"	l	%r1,0(%r5,%r6)\n"
+	"	ahi	%r0,1\n"
+	"	diag	0,0,0x44\n"
+
+	"	j	0b\n"
+);
+
 FIXTURE(uc_kvm)
 {
 	struct kvm_s390_sie_block *sie_block;
@@ -69,6 +92,7 @@ FIXTURE(uc_kvm)
 	uintptr_t base_hva;
 	uintptr_t code_hva;
 	int kvm_run_size;
+	vm_paddr_t pgd;
 	void *vm_mem;
 	int vcpu_fd;
 	int kvm_fd;
@@ -118,7 +142,7 @@ FIXTURE_SETUP(uc_kvm)
 	self->base_gpa = 0;
 	self->code_gpa = self->base_gpa + (3 * SZ_1M);
 
-	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
+	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE + VM_MEM_EXT_SIZE);
 	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
 	self->base_hva = (uintptr_t)self->vm_mem + SZ_1M;
 	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
@@ -222,6 +246,75 @@ TEST(uc_cap_hpage)
 	close(kvm_fd);
 }
 
+/* calculate host virtual addr from guest physical addr */
+static void *gpa2hva(FIXTURE_DATA(uc_kvm) * self, u64 gpa)
+{
+	return (void *)(self->base_hva - self->base_gpa + gpa);
+}
+
+/* initialize segment and page tables for uc_kvm tests */
+static void init_st_pt(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_run *run = self->run;
+	void *se_addr;
+	int si, pi;
+	u64 *phd;
+
+	self->pgd = self->base_gpa + SZ_1M; /* set PASCE addr */
+	phd = gpa2hva(self, self->pgd);
+	memset(phd, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
+
+	for (si = 0; si < ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M); si++) {
+		/* create ste */
+		phd[si] = (self->pgd
+			+ (PAGES_PER_SEGMENT * PAGE_SIZE
+				* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M))
+			+ (PAGES_PER_SEGMENT * PAGE_SIZE * si)) & ~0x7fful;
+		se_addr = gpa2hva(self, phd[si]);
+		memset(se_addr, 0xff, PAGES_PER_SEGMENT * PAGE_SIZE);
+		for (pi = 0; pi < (SZ_1M / PAGE_SIZE); pi++) {
+			/* create pte */
+			((u64 *)se_addr)[pi] = (self->base_gpa
+				+ (si * SZ_1M) + (pi * PAGE_SIZE)) & ~0xffful;
+		}
+	}
+	pr_debug("segment table entry %p (0x%lx) --> %p\n",
+		 phd, phd[0], gpa2hva(self, (phd[0] & ~0x7fful)));
+	print_hex_bytes("st", (u64)phd, 64);
+	print_hex_bytes("pt", (u64)gpa2hva(self, phd[0]), 128);
+	print_hex_bytes("pt+", (u64)
+			gpa2hva(self, phd[0] + (PAGES_PER_SEGMENT * PAGE_SIZE
+			* ((VM_MEM_SIZE + VM_MEM_EXT_SIZE) / SZ_1M)) - 0x64), 128);
+
+	sync_regs->crs[1] = self->pgd | 0x3;	/* PASCE TT=00 for segment table */
+	run->kvm_dirty_regs |= KVM_SYNC_CRS;
+}
+
+static void uc_handle_exit_ucontrol(FIXTURE_DATA(uc_kvm) * self)
+{
+	struct kvm_run *run = self->run;
+
+	TEST_ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	switch (run->s390_ucontrol.pgm_code) {
+	case UC_PIC_SEGMENT_TRANSLATION:
+		pr_info("ucontrol pic segment translation 0x%llx\n",
+			run->s390_ucontrol.trans_exc_code);
+		/* map / make additional memory available */
+		struct kvm_s390_ucas_mapping map2 = {
+			.user_addr = (u64)gpa2hva(self, run->s390_ucontrol.trans_exc_code),
+			.vcpu_addr = run->s390_ucontrol.trans_exc_code,
+			.length = VM_MEM_EXT_SIZE,
+		};
+		pr_info("ucas map %p %p 0x%llx\n",
+			(void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+		TEST_ASSERT_EQ(0, ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2));
+		break;
+	default:
+		TEST_FAIL("UNEXPECTED PGM CODE %d", run->s390_ucontrol.pgm_code);
+	}
+}
+
 /* verify SIEIC exit
  * * reset stop requests
  * * fail on codes not expected in the test cases
@@ -245,7 +338,11 @@ static bool uc_handle_sieic(FIXTURE_DATA(uc_kvm) * self)
 		break;
 	case ICPT_INST:
 		/* end execution in caller on intercepted instruction */
+		pr_info("sie instruction interception\n");
 		return false;
+	case ICPT_OPEREXC:
+		/* operation exception */
+		TEST_FAIL("sie exception on %.4x%.8x", sie_block->ipa, sie_block->ipb);
 	default:
 		TEST_FAIL("UNEXPECTED SIEIC CODE %d", run->s390_sieic.icptcode);
 	}
@@ -258,6 +355,11 @@ static bool uc_handle_exit(FIXTURE_DATA(uc_kvm) * self)
 	struct kvm_run *run = self->run;
 
 	switch (run->exit_reason) {
+	case KVM_EXIT_S390_UCONTROL:
+		/* check program interruption code */
+		/* handle page fault --> ucas map */
+		uc_handle_exit_ucontrol(self);
+		break;
 	case KVM_EXIT_S390_SIEIC:
 		return uc_handle_sieic(self);
 	default:
@@ -289,6 +391,73 @@ static void uc_assert_diag44(FIXTURE_DATA(uc_kvm) * self)
 	TEST_ASSERT_EQ(0x440000, sie_block->ipb);
 }
 
+TEST_F(uc_kvm, uc_map_unmap)
+{
+	struct kvm_sync_regs *sync_regs = &self->run->s.regs;
+	struct kvm_s390_sie_block *sie_block = self->sie_block;
+	struct kvm_run *run = self->run;
+	int rc;
+
+	init_st_pt(self);
+
+	/* copy test_mem_pgm to code_hva / code_gpa */
+	TH_LOG("copy code %p to vm mapped memory %p / %p",
+	       &test_mem_pgm, (void *)self->code_hva, (void *)self->code_gpa);
+	memcpy((void *)self->code_hva, &test_mem_pgm, PAGE_SIZE);
+
+	run->psw_mask = 0x0400000180000000ULL;  /* DAT enabled + 64 bit mode */
+	run->psw_addr = self->code_gpa;
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(0, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_SIEIC, run->exit_reason);
+	ASSERT_EQ(ICPT_STOP, sie_block->icptcode);
+	ASSERT_EQ(true, uc_handle_exit(self));
+
+	/* set register content for test_mem_pgm to access not mapped memory*/
+	sync_regs->gprs[1] = 0x55;
+	sync_regs->gprs[5] = self->base_gpa;
+	sync_regs->gprs[6] = VM_MEM_SIZE;
+	run->kvm_dirty_regs |= KVM_SYNC_GPRS;
+
+	/* run and expect to fail witch ucontrol pic segment translation */
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(1, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+
+	ASSERT_EQ(UC_PIC_SEGMENT_TRANSLATION, run->s390_ucontrol.pgm_code);
+	ASSERT_EQ(self->base_gpa + VM_MEM_SIZE, run->s390_ucontrol.trans_exc_code);
+	/* map / make additional memory available */
+	struct kvm_s390_ucas_mapping map2 = {
+		.user_addr = (u64)gpa2hva(self, self->base_gpa + VM_MEM_SIZE),
+		.vcpu_addr = self->base_gpa + VM_MEM_SIZE,
+		.length = VM_MEM_EXT_SIZE,
+	};
+	TH_LOG("ucas map %p %p 0x%llx",
+	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map2);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(false, uc_handle_exit(self));
+	uc_assert_diag44(self);
+
+	/* assert registers and memory are in expected state */
+	ASSERT_EQ(2, sync_regs->gprs[0]);
+	ASSERT_EQ(0x55, sync_regs->gprs[1]);
+	ASSERT_EQ(0x55, *(u32 *)gpa2hva(self, self->base_gpa + VM_MEM_SIZE));
+
+	/* unmap and run loop again */
+	TH_LOG("ucas unmap %p %p 0x%llx",
+	       (void *)map2.user_addr, (void *)map2.vcpu_addr, map2.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_UNMAP, &map2);
+	ASSERT_EQ(0, rc)
+		TH_LOG("ucas map result %d not expected, %s", rc, strerror(errno));
+	ASSERT_EQ(0, uc_run_once(self));
+	ASSERT_EQ(3, sync_regs->gprs[0]);
+	ASSERT_EQ(KVM_EXIT_S390_UCONTROL, run->exit_reason);
+	ASSERT_EQ(true, uc_handle_exit(self));
+}
+
 TEST_F(uc_kvm, uc_gprs)
 {
 	struct kvm_s390_sie_block *sie_block = self->sie_block;
-- 
2.45.2


