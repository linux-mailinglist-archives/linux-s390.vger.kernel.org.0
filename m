Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA31FF476
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2020 16:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbgFROOp (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jun 2020 10:14:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6284 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730596AbgFROOo (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jun 2020 10:14:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 00BEE1C7614B9EE3D7A1;
        Thu, 18 Jun 2020 22:14:38 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 18 Jun 2020 22:14:29 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <arnd@arndb.de>, <borntraeger@de.ibm.com>,
        <catalin.marinas@arm.com>, <christian@brauner.io>,
        <cyphar@cyphar.com>, <dhowells@redhat.com>,
        <ebiederm@xmission.com>, <fenghua.yu@intel.com>,
        <geert@linux-m68k.org>, <gor@linux.ibm.com>,
        <heiko.carstens@de.ibm.com>, <ink@jurassic.park.msu.ru>,
        <jolsa@redhat.com>, <linux@armlinux.org.uk>, <lkp@intel.com>,
        <mark.rutland@arm.com>, <mattst88@gmail.com>, <minchan@kernel.org>,
        <mingo@redhat.com>, <monstr@monstr.eu>, <namhyung@kernel.org>,
        <nixiaoming@huawei.com>, <peterz@infradead.org>, <rth@twiddle.net>,
        <sargun@sargun.me>, <sfr@canb.auug.org.au>, <tony.luck@intel.com>,
        <will@kernel.org>, <akpm@linux-foundation.org>
CC:     <alex.huangjianhui@huawei.com>, <zhongjubin@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>, <kbuild-all@lists.01.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v2] s390: fix build error for sys_call_table_emu
Date:   Thu, 18 Jun 2020 22:14:26 +0800
Message-ID: <20200618141426.16884-1-nixiaoming@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Build error on s390:
	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
	>> (.rodata+0x1288): undefined reference to `__s390_'

In commit ("All arch: remove system call sys_sysctl")
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_sysctl			compat_sys_sysctl
+149  common	_sysctl			sys_ni_syscall
 150  common	mlock			sys_mlock			sys_mlock

After the patch is integrated, there is a format error in the generated
arch/s390/include/generated/asm/syscall_table.h:
	SYSCALL(sys_fdatasync, sys_fdatasync)
	SYSCALL(sys_ni_syscall,) /* cause build error */
	SYSCALL(sys_mlock,sys_mlock)

According to the guidance of Heiko Carstens, use "-" to fill the empty system call
 Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.

Fixes: ("All arch: remove system call sys_sysctl")
Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>

changes in v2:
	use "-" to fill the empty system call

v1: https://lore.kernel.org/lkml/20200618110320.104013-1-nixiaoming@huawei.com/
---
 arch/s390/kernel/syscalls/syscall.tbl           | 2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index f17aaf6fe5de..04c34c2ed916 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -138,7 +138,7 @@
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_ni_syscall
+149  common	_sysctl			-				-
 150  common	mlock			sys_mlock			sys_mlock
 151  common	munlock			sys_munlock			sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 0193f9b98753..29144b79a49d 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -138,7 +138,7 @@
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
-149  common	_sysctl			sys_ni_syscall
+149  common	_sysctl			-				-
 150  common	mlock			sys_mlock			compat_sys_mlock
 151  common	munlock			sys_munlock			compat_sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
-- 
2.27.0

