Return-Path: <linux-s390+bounces-4748-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266CD915475
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2024 18:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DBE1C20B2D
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2024 16:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7181A00DC;
	Mon, 24 Jun 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR9kAiRb"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D4D19DF89;
	Mon, 24 Jun 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247099; cv=none; b=p8qTO3AHq5nkuyQJn7sr9bGEFSe4mGuYNEmOx5Gpc8ElnyUaEweftzO2dFCJ+1KXDjS/TOYXwOhPOUcCKcDxLhc79E3GGdKBflFcZQ8eOch8DfmRlgXYNUVijvy8RKM9ZsejB+MC9DxRHjJQqtz0SgLnWOCUKz3KA9CyIk1XGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247099; c=relaxed/simple;
	bh=YaBYUnqmG+n4LXnma2Z355DDZuqflriGSA+my20kuNc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NbkwEPAyIP12Dc0iWy6tEfhT+UFm/axKeew/etLlb+MaPo1rqNns8nXvHMK8q2yaKap4Mieta9bOX/sR2LpWSPyYCfOrfTS4bPi4tvXg7NuFpBYhX/VXno5wKIWSe+RZ7zkxQNhIhRqKFr8dK05w5qUUqSR3tUyOhuWUWXfHJls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR9kAiRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59C8C32782;
	Mon, 24 Jun 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719247099;
	bh=YaBYUnqmG+n4LXnma2Z355DDZuqflriGSA+my20kuNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hR9kAiRbkPdSRmhr6Eizj3di1WfTP49V/w1YOyPaZim5rmw36OARQQmRPJoJIgcc+
	 S4v6weKyemGxTeHfB6coHy40+7J8WwAqDr2nZbjBKjkhR9pEXksYh4lK6/uVwva9ag
	 DxvpQk7ryDzKF8/l6QScCn61hEnSrMxLQrk7/f3P77LzhPLcr9Y0MRsnu/mYbLIeMl
	 wEA4icKt3bELxbwttXXVIjoQjV4+pH+CiRResb8t2jJV/+LRGOsJqZQCouZxyctCWJ
	 M/pWQWarPBHgrmvXXw9jiSVKx7MmK8dQ9v5SoJljL0czI9ePB0E2yF+juRGV4cW/Wr
	 G9znttjNqjk7A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com,
	stable@vger.kernel.org
Subject: [PATCH v2 09/13] csky, hexagon: fix broken sys_sync_file_range
Date: Mon, 24 Jun 2024 18:37:07 +0200
Message-Id: <20240624163707.299494-10-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240624163707.299494-1-arnd@kernel.org>
References: <20240624163707.299494-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Both of these architectures require u64 function arguments to be
passed in even/odd pairs of registers or stack slots, which in case of
sync_file_range would result in a seven-argument system call that is
not currently possible. The system call is therefore incompatible with
all existing binaries.

While it would be possible to implement support for seven arguments
like on mips, it seems better to use a six-argument version, either
with the normal argument order but misaligned as on most architectures
or with the reordered sync_file_range2() calling conventions as on
arm and powerpc.

Cc: stable@vger.kernel.org
Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/include/uapi/asm/unistd.h    | 1 +
 arch/hexagon/include/uapi/asm/unistd.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 7ff6a2466af1..e0594b6370a6 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -6,6 +6,7 @@
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 #include <asm-generic/unistd.h>
 
 #define __NR_set_thread_area	(__NR_arch_specific_syscall + 0)
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
index 432c4db1b623..21ae22306b5d 100644
--- a/arch/hexagon/include/uapi/asm/unistd.h
+++ b/arch/hexagon/include/uapi/asm/unistd.h
@@ -36,5 +36,6 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_TIME32_SYSCALLS
+#define __ARCH_WANT_SYNC_FILE_RANGE2
 
 #include <asm-generic/unistd.h>
-- 
2.39.2


