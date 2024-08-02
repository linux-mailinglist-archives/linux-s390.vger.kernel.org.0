Return-Path: <linux-s390+bounces-5340-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47237946146
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 18:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6611C2321C
	for <lists+linux-s390@lfdr.de>; Fri,  2 Aug 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD801537D2;
	Fri,  2 Aug 2024 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i9GY9yEm"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA53166F2A;
	Fri,  2 Aug 2024 15:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722614400; cv=none; b=TKJ0BoMVjYboclJoaCsRgrnnFmd+rlpA9guXb7AwuzBJlYx8CnORke7Sjy+i+vnb4aC/btI5XjkvVwr4SjKMSjeTL8RK1AYCw/goEAKrE8ZUCB68+Bu92bUbkvVqGMOxyvgTDl0jZaaSUxbFNHjHJs/1D4ayJ6y7ju8DYkGUHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722614400; c=relaxed/simple;
	bh=O3kpQfYxvjBev/wXwgYpesQTe99dlXwk5U3852ukV6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kyzntsG9FSMwHhptWt1t5RdnU+5P3zYOwCDH7ZfTmF060ftzin603foPCRDpRmmKxRKzVpO0hmf0zGS4t9GilfLmeHcsoJKGa5wCyAoptHodenBsq5PZMYr2g0+RmAidGVjOIjijGQVio4lTQ31sx0gYpkAbOPm/GgZlEClzNug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i9GY9yEm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4729TVXI014306;
	Fri, 2 Aug 2024 15:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=BZdHm4/u7f0JP
	ibHx+fZq3D2WpPr0nkYM9UxVgCUPms=; b=i9GY9yEmVhg2TS4qhekD6vYp/09bl
	L5M0tQ0b8FjeZg+LEYr6JHxYrlpfKzY0cEN760Ykb+lummH4xFD/pBK4awEpEijW
	TR63e5L0UpGTQX640gVjnwCtU9qPIkwTxHXgPwBFAYkFqOFqDQkJOHCDwdWVDYTs
	Kfllcsik3F++7xBm2u4m1ylEghmrskgeiPFjk3BYIZ/7WLLT9emWpWUpdbPR5y5O
	0vLsEQ2kTTP7DoPCmNE0ZB9l4khfqDdOe8tObylR2tLQeoEDiBqvvn78WUxWuJLg
	pc69Q+J/RergfIyV0U2d2oZhfcBfx3oSIQuQuyV25P52Z7jDx+MD9Ku3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rvuw0vdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:49 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472FxmPA016968;
	Fri, 2 Aug 2024 15:59:49 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rvuw0vdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:48 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472Fawgt018863;
	Fri, 2 Aug 2024 15:59:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nc7q7y1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 15:59:47 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472FxfpG34341434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 15:59:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC49A20049;
	Fri,  2 Aug 2024 15:59:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A95420040;
	Fri,  2 Aug 2024 15:59:41 +0000 (GMT)
Received: from darkmoore.ibmuc.com (unknown [9.171.84.102])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 15:59:41 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: [PATCH v4 04/10] selftests: kvm: s390: Add test fixture and simple VM setup tests
Date: Fri,  2 Aug 2024 17:59:07 +0200
Message-ID: <20240802155913.261891-5-schlameuss@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802155913.261891-1-schlameuss@linux.ibm.com>
References: <20240802155913.261891-1-schlameuss@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: U-I33_je81vvmDN7Zp5aHrblqHPd4fjY
X-Proofpoint-ORIG-GUID: Sov1PSXi12o11Ox3_cxSGE8RT3_gDedy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_11,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=411
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020110

Add a uc_kvm fixture to create and destroy a ucontrol VM.

* uc_sie_assertions asserts basic settings in the SIE as setup by the
  kernel.
* uc_attr_mem_limit asserts the memory limit is max value and cannot be
  set (not supported).
* uc_no_dirty_log asserts dirty log is not supported.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 .../selftests/kvm/s390x/ucontrol_test.c       | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
index cd68e7e37d35..d103a92e7495 100644
--- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
+++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
@@ -9,10 +9,14 @@
  */
 #include "kselftest_harness.h"
 #include "kvm_util.h"
+#include "processor.h"
+#include "sie.h"
 
 #include <linux/capability.h>
 #include <linux/sizes.h>
 
+#define VM_MEM_SIZE (4 * SZ_1M)
+
 /* so directly declare capget to check caps without libcap */
 int capget(cap_user_header_t header, cap_user_data_t data);
 
@@ -36,6 +40,133 @@ void require_ucontrol_admin(void)
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_S390_UCONTROL));
 }
 
+FIXTURE(uc_kvm)
+{
+	struct kvm_s390_sie_block *sie_block;
+	struct kvm_run *run;
+	uintptr_t base_gpa;
+	uintptr_t code_gpa;
+	uintptr_t base_hva;
+	uintptr_t code_hva;
+	int kvm_run_size;
+	void *vm_mem;
+	int vcpu_fd;
+	int kvm_fd;
+	int vm_fd;
+};
+
+/**
+ * create VM with single vcpu, map kvm_run and SIE control block for easy access
+ */
+FIXTURE_SETUP(uc_kvm)
+{
+	struct kvm_s390_vm_cpu_processor info;
+	int rc;
+
+	require_ucontrol_admin();
+
+	self->kvm_fd = open_kvm_dev_path_or_exit();
+	self->vm_fd = ioctl(self->kvm_fd, KVM_CREATE_VM, KVM_VM_S390_UCONTROL);
+	ASSERT_GE(self->vm_fd, 0);
+
+	kvm_device_attr_get(self->vm_fd, KVM_S390_VM_CPU_MODEL,
+			    KVM_S390_VM_CPU_PROCESSOR, &info);
+	TH_LOG("create VM 0x%llx", info.cpuid);
+
+	self->vcpu_fd = ioctl(self->vm_fd, KVM_CREATE_VCPU, 0);
+	ASSERT_GE(self->vcpu_fd, 0);
+
+	self->kvm_run_size = ioctl(self->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	ASSERT_GE(self->kvm_run_size, sizeof(struct kvm_run))
+		  TH_LOG(KVM_IOCTL_ERROR(KVM_GET_VCPU_MMAP_SIZE, self->kvm_run_size));
+	self->run = (struct kvm_run *)mmap(NULL, self->kvm_run_size,
+		    PROT_READ | PROT_WRITE, MAP_SHARED, self->vcpu_fd, 0);
+	ASSERT_NE(self->run, MAP_FAILED);
+	/**
+	 * For virtual cpus that have been created with S390 user controlled
+	 * virtual machines, the resulting vcpu fd can be memory mapped at page
+	 * offset KVM_S390_SIE_PAGE_OFFSET in order to obtain a memory map of
+	 * the virtual cpu's hardware control block.
+	 */
+	self->sie_block = (struct kvm_s390_sie_block *)mmap(NULL, PAGE_SIZE,
+			  PROT_READ | PROT_WRITE, MAP_SHARED,
+			  self->vcpu_fd, KVM_S390_SIE_PAGE_OFFSET << PAGE_SHIFT);
+	ASSERT_NE(self->sie_block, MAP_FAILED);
+
+	TH_LOG("VM created %p %p", self->run, self->sie_block);
+
+	self->base_gpa = 0;
+	self->code_gpa = self->base_gpa + (3 * SZ_1M);
+
+	self->vm_mem = aligned_alloc(SZ_1M, VM_MEM_SIZE);
+	ASSERT_NE(NULL, self->vm_mem) TH_LOG("malloc failed %u", errno);
+	self->base_hva = (uintptr_t)self->vm_mem;
+	self->code_hva = self->base_hva - self->base_gpa + self->code_gpa;
+	struct kvm_s390_ucas_mapping map = {
+		.user_addr = self->base_hva,
+		.vcpu_addr = self->base_gpa,
+		.length = VM_MEM_SIZE,
+	};
+	TH_LOG("ucas map %p %p 0x%llx",
+	       (void *)map.user_addr, (void *)map.vcpu_addr, map.length);
+	rc = ioctl(self->vcpu_fd, KVM_S390_UCAS_MAP, &map);
+	ASSERT_EQ(0, rc) TH_LOG("ucas map result %d not expected, %s",
+				rc, strerror(errno));
+
+	TH_LOG("page in %p", (void *)self->base_gpa);
+	rc = ioctl(self->vcpu_fd, KVM_S390_VCPU_FAULT, self->base_gpa);
+	ASSERT_EQ(0, rc) TH_LOG("vcpu fault (%p) result %d not expected, %s",
+				(void *)self->base_hva, rc, strerror(errno));
+
+	self->sie_block->cpuflags &= ~CPUSTAT_STOPPED;
+}
+
+FIXTURE_TEARDOWN(uc_kvm)
+{
+	munmap(self->sie_block, PAGE_SIZE);
+	munmap(self->run, self->kvm_run_size);
+	close(self->vcpu_fd);
+	close(self->vm_fd);
+	close(self->kvm_fd);
+	free(self->vm_mem);
+}
+
+TEST_F(uc_kvm, uc_sie_assertions)
+{
+	/* assert interception of Code 08 (Program Interruption) is set */
+	EXPECT_EQ(0, self->sie_block->ecb & ECB_SPECI);
+}
+
+TEST_F(uc_kvm, uc_attr_mem_limit)
+{
+	u64 limit;
+	struct kvm_device_attr attr = {
+		.group = KVM_S390_VM_MEM_CTRL,
+		.attr = KVM_S390_VM_MEM_LIMIT_SIZE,
+		.addr = (unsigned long)&limit,
+	};
+	int rc;
+
+	rc = ioctl(self->vm_fd, KVM_GET_DEVICE_ATTR, &attr);
+	EXPECT_EQ(0, rc);
+	EXPECT_EQ(~0UL, limit);
+
+	/* assert set not supported */
+	rc = ioctl(self->vm_fd, KVM_SET_DEVICE_ATTR, &attr);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
+
+TEST_F(uc_kvm, uc_no_dirty_log)
+{
+	struct kvm_dirty_log dlog;
+	int rc;
+
+	rc = ioctl(self->vm_fd, KVM_GET_DIRTY_LOG, &dlog);
+	EXPECT_EQ(-1, rc);
+	EXPECT_EQ(EINVAL, errno);
+}
+
 /**
  * Assert HPAGE CAP cannot be enabled on UCONTROL VM
  */
-- 
2.45.2


