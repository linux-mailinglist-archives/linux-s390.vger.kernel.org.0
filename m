Return-Path: <linux-s390+bounces-5916-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC16D96B946
	for <lists+linux-s390@lfdr.de>; Wed,  4 Sep 2024 12:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0DF1C24FF9
	for <lists+linux-s390@lfdr.de>; Wed,  4 Sep 2024 10:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173241D0DF8;
	Wed,  4 Sep 2024 10:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RO3kLNCP"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309251D04B5
	for <linux-s390@vger.kernel.org>; Wed,  4 Sep 2024 10:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447041; cv=none; b=s5AXrIyhcr+PynyHvPbk7beOLiYsu4Q9Y7y8UFd+qeZso2/GREM7/jDPAXG97u1RUs8VjBryXHh9j+CkMcAJZxMH9eppwwzg17R7BwtqzBxiunIeiG7rW1ksAWYSWbIdWOYIIi2HkSEr30nNWAG8aiLhZIDPB/IhoSKEvPFqT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447041; c=relaxed/simple;
	bh=7hzkqN5SacR2mv1M9DKoCgZ4qLdaG1R157+eusQiaNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5vwSmMdgCoY6WUVdHwXOBkCq+zjZp+4xsd9F6WYcHWY93kjQXK6Z3pmuradMTxNgIl3qhOUJxSKj3kaxJjArXgUY2K8O5bAUCxq5tHdZg2SbSCjEGjbrHilQBYxcn/PQrhrOxggvv0LZReTFlOmg8ajovUgQTUUfLV++XqgF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RO3kLNCP; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725447036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhPTZTrrRJVhwWNoNwQnkN0fKy36Z67lIvpYzPGyDVM=;
	b=RO3kLNCPH9ub5/C7TIsWdlvI31qRyVNSt88Ikuz/ZxkPKwBET31zOiiashgp8zi3AhWaEl
	17PdyUyRD662k+LsmtrG7jc/xv/36HjDlilu6CsvG3YQK+QjjPqykxRz7pH3BeQN+Ipew2
	Gxyg+v90vuXLsWzpqsaLfc7Etkccmpg=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH v2 4/4] riscv: gitlab-ci: Add clang build tests
Date: Wed,  4 Sep 2024 12:50:25 +0200
Message-ID: <20240904105020.1179006-10-andrew.jones@linux.dev>
In-Reply-To: <20240904105020.1179006-6-andrew.jones@linux.dev>
References: <20240904105020.1179006-6-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Test building 32 and 64-bit with clang. Throw a test of in- and out-
of-tree building in too by swapping which is done to which (32-bit
vs. 64-bit) with respect to the gcc build tests.

Acked-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 .gitlab-ci.yml | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 67a9a15733f1..b7ad99870e5a 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -176,6 +176,49 @@ build-riscv64-efi:
       | tee results.txt
  - grep -q PASS results.txt && ! grep -q FAIL results.txt
 
+build-riscv32-clang:
+ extends: .intree_template
+ script:
+ - dnf install -y qemu-system-riscv gcc-riscv64-linux-gnu clang
+ - ./configure --arch=riscv32 --cc=clang --cflags='--target=riscv32' --cross-prefix=riscv64-linux-gnu-
+ - make -j2
+ - printf "FOO=foo\nBAR=bar\nBAZ=baz\nMVENDORID=0\nMARCHID=0\nMIMPID=0\n" >test-env
+ - ACCEL=tcg KVM_UNIT_TESTS_ENV=test-env ./run_tests.sh
+      selftest
+      sbi
+      | tee results.txt
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
+build-riscv64-clang:
+ extends: .outoftree_template
+ script:
+ - dnf install -y qemu-system-riscv gcc-riscv64-linux-gnu clang
+ - mkdir build
+ - cd build
+ - ../configure --arch=riscv64 --cc=clang --cflags='--target=riscv64' --cross-prefix=riscv64-linux-gnu-
+ - make -j2
+ - printf "FOO=foo\nBAR=bar\nBAZ=baz\nMVENDORID=0\nMARCHID=0\nMIMPID=0\n" >test-env
+ - ACCEL=tcg KVM_UNIT_TESTS_ENV=test-env ./run_tests.sh
+      selftest
+      sbi
+      | tee results.txt
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
+build-riscv64-clang-efi:
+ extends: .intree_template
+ script:
+ - dnf install -y edk2-riscv64 qemu-system-riscv gcc-riscv64-linux-gnu clang
+ - cp /usr/share/edk2/riscv/RISCV_VIRT_CODE.fd .
+ - truncate -s 32M RISCV_VIRT_CODE.fd
+ - ./configure --arch=riscv64 --cc=clang --cflags='--target=riscv64' --cross-prefix=riscv64-linux-gnu- --enable-efi
+ - make -j2
+ - printf "FOO=foo\nBAR=bar\nBAZ=baz\nMVENDORID=0\nMARCHID=0\nMIMPID=0\n" >test-env
+ - ACCEL=tcg KVM_UNIT_TESTS_ENV=test-env ./run_tests.sh
+      selftest
+      sbi
+      | tee results.txt
+ - grep -q PASS results.txt && ! grep -q FAIL results.txt
+
 build-s390x:
  extends: .outoftree_template
  script:
-- 
2.46.0


