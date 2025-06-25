Return-Path: <linux-s390+bounces-11290-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FE8AE88BA
	for <lists+linux-s390@lfdr.de>; Wed, 25 Jun 2025 17:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A084189475C
	for <lists+linux-s390@lfdr.de>; Wed, 25 Jun 2025 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DF013A3F7;
	Wed, 25 Jun 2025 15:49:06 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4946227FD74;
	Wed, 25 Jun 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750866546; cv=none; b=ub2uLEXZK+jqGNXxdnXMlmSQiuJsmNbsNImhkVqIjQqISqID1OMFglLDbNzmGzclNGwr7tDMiE4/sb0Jyv9ZBCvcbCGCeT52V+KiJCmzl7ru3zNcz81QFo2HdKb90wmENAHpbQR2DgPziC+ho++mWqtw5YrdEjgEDD97LnbKvBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750866546; c=relaxed/simple;
	bh=7LbtewrOOI50XlgudbKjxH78JXTvWrptwbllFl5Flu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7AbQW17UNAVc1WZVlKgVtr+6KOqRMvLz+EdeIFLDGNuSjNOgv2CjWkAt8ZAcE7REtcNGVnlGJUcFBKh8XRNYo9+2fFkM2VXWOSqBEzgw30m0NnMqIK7tRSDhXAMXK/rLF6Ro+XGyQZ34Mp1e2R7R02ulj0jejDdcVpyxstca5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77FA5204C;
	Wed, 25 Jun 2025 08:48:46 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 479623F58B;
	Wed, 25 Jun 2025 08:49:00 -0700 (PDT)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: andrew.jones@linux.dev,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	thuth@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com
Cc: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	will@kernel.org,
	julien.thierry.kdev@gmail.com,
	maz@kernel.org,
	oliver.upton@linux.dev,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	joey.gouly@arm.com,
	andre.przywara@arm.com,
	shahuang@redhat.com
Subject: [kvm-unit-tests PATCH v4 08/13] scripts: Add KVMTOOL environment variable for kvmtool binary path
Date: Wed, 25 Jun 2025 16:48:08 +0100
Message-ID: <20250625154813.27254-9-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625154813.27254-1-alexandru.elisei@arm.com>
References: <20250625154813.27254-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kvmtool is often used for prototyping new features, and a developer might
not want to install it system-wide. Add a KVMTOOL environment variable to
make it easier for tests to use a binary not in $PATH.

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 run_tests.sh          | 1 +
 scripts/arch-run.bash | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/run_tests.sh b/run_tests.sh
index dd9d27377905..150a06a91064 100755
--- a/run_tests.sh
+++ b/run_tests.sh
@@ -36,6 +36,7 @@ The following environment variables are used:
     TIMEOUT         Timeout duration for the timeout(1) command
     CHECK           Overwrites the 'check' unit test parameter (see
                     docs/unittests.txt)
+    KVMTOOL         Path to kvmtool binary for ARCH-run
 EOF
 }
 
diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
index 354ce80fe3fa..c440f2162bac 100644
--- a/scripts/arch-run.bash
+++ b/scripts/arch-run.bash
@@ -369,7 +369,7 @@ search_kvmtool_binary ()
 {
 	local kvmtoolcmd kvmtool
 
-	for kvmtoolcmd in lkvm vm lkvm-static; do
+	for kvmtoolcmd in ${KVMTOOL:-lkvm vm lkvm-static}; do
 		if "$kvmtoolcmd" --help 2>/dev/null| grep -q 'The most commonly used'; then
 			kvmtool="$kvmtoolcmd"
 			break
@@ -378,6 +378,7 @@ search_kvmtool_binary ()
 
 	if [ -z "$kvmtool" ]; then
 		echo "A kvmtool binary was not found." >&2
+		echo "You can set a custom location by using the KVMTOOL=<path> environment variable." >&2
 		return 2
 	fi
 
-- 
2.50.0


