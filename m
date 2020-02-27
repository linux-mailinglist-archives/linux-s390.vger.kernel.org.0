Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07E170D1F
	for <lists+linux-s390@lfdr.de>; Thu, 27 Feb 2020 01:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgB0AXe (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 Feb 2020 19:23:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgB0AXd (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 19:23:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F3BAEB25E;
        Thu, 27 Feb 2020 00:23:28 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/1] perf/s390: Update syscall.tbl
Date:   Thu, 27 Feb 2020 01:23:09 +0100
Message-Id: <20200227002309.18854-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Update changes from commits:

83fa805bcbfc ("Merge tag 'threads-v5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux")
fddb5d430ad9 ("open: introduce openat2(2) syscall")
9a2cef09c801 ("arch: wire up pidfd_getfd syscall")
5518aed82d2a ("s390: wire up clone3 system call")
1a271a68e030 ("arch: mark syscall number 435 reserved for clone3")
7615d9e1780e ("arch: wire-up pidfd_open()")
d8076bdb56af ("uapi: Wire up the mount API syscalls on non-x86 arches [ver #2]")
39036cd27273 ("arch: add pidfd and io_uring syscalls everywhere")
48166e6ea47d ("y2038: add 64-bit time_t syscalls to all 32-bit architectures")
8dabe7245bbc ("y2038: syscalls: rename y2038 compat syscalls")
b41c51c8e194 ("arch: add pkey and rseq syscall numbers everywhere")
0d6040d46817 ("arch: add split IPC system calls where needed")
90856087daca ("s390: remove compat_wrapper.c")
fef747bab3c0 ("s390: use generic UID16 implementation")
9d6d99e3ac8c ("s390: wire up rseq system call")
8bf935501a7e ("s390: wire up io_pgetevents system call")
71406883fd35 ("s390/kexec_file: Add kexec_file_load system call")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

BTW I wonder what's wrong with symlinks? vfat incompatibility?
There are some symlinks in kernel git tree:
git ls-files -s | awk '/120000/{print $4}' | wc -l
36

mksyscalltbl scripts are nice and sooner or later somebody creates it
for all needed archs, but wouldn't be just easier to have symlinks?
Or copy files in Makefile before make call?

Kind regards,
Petr

 .../perf/arch/s390/entry/syscalls/syscall.tbl | 386 ++++++++++--------
 1 file changed, 219 insertions(+), 167 deletions(-)

diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index b38d48464368..bd7bd3581a0f 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -15,86 +15,86 @@
 5    common	open			sys_open			compat_sys_open
 6    common	close			sys_close			sys_close
 7    common	restart_syscall		sys_restart_syscall		sys_restart_syscall
-8    common	creat			sys_creat			compat_sys_creat
-9    common	link			sys_link			compat_sys_link
-10   common	unlink			sys_unlink			compat_sys_unlink
+8    common	creat			sys_creat			sys_creat
+9    common	link			sys_link			sys_link
+10   common	unlink			sys_unlink			sys_unlink
 11   common	execve			sys_execve			compat_sys_execve
-12   common	chdir			sys_chdir			compat_sys_chdir
-13   32		time			-				compat_sys_time
-14   common	mknod			sys_mknod			compat_sys_mknod
-15   common	chmod			sys_chmod			compat_sys_chmod
-16   32		lchown			-				compat_sys_s390_lchown16
+12   common	chdir			sys_chdir			sys_chdir
+13   32		time			-				sys_time32
+14   common	mknod			sys_mknod			sys_mknod
+15   common	chmod			sys_chmod			sys_chmod
+16   32		lchown			-				sys_lchown16
 19   common	lseek			sys_lseek			compat_sys_lseek
 20   common	getpid			sys_getpid			sys_getpid
 21   common	mount			sys_mount			compat_sys_mount
-22   common	umount			sys_oldumount			compat_sys_oldumount
-23   32		setuid			-				compat_sys_s390_setuid16
-24   32		getuid			-				compat_sys_s390_getuid16
-25   32		stime			-				compat_sys_stime
+22   common	umount			sys_oldumount			sys_oldumount
+23   32		setuid			-				sys_setuid16
+24   32		getuid			-				sys_getuid16
+25   32		stime			-				sys_stime32
 26   common	ptrace			sys_ptrace			compat_sys_ptrace
 27   common	alarm			sys_alarm			sys_alarm
 29   common	pause			sys_pause			sys_pause
-30   common	utime			sys_utime			compat_sys_utime
-33   common	access			sys_access			compat_sys_access
+30   common	utime			sys_utime			sys_utime32
+33   common	access			sys_access			sys_access
 34   common	nice			sys_nice			sys_nice
 36   common	sync			sys_sync			sys_sync
 37   common	kill			sys_kill			sys_kill
-38   common	rename			sys_rename			compat_sys_rename
-39   common	mkdir			sys_mkdir			compat_sys_mkdir
-40   common	rmdir			sys_rmdir			compat_sys_rmdir
+38   common	rename			sys_rename			sys_rename
+39   common	mkdir			sys_mkdir			sys_mkdir
+40   common	rmdir			sys_rmdir			sys_rmdir
 41   common	dup			sys_dup				sys_dup
-42   common	pipe			sys_pipe			compat_sys_pipe
+42   common	pipe			sys_pipe			sys_pipe
 43   common	times			sys_times			compat_sys_times
-45   common	brk			sys_brk				compat_sys_brk
-46   32		setgid			-				compat_sys_s390_setgid16
-47   32		getgid			-				compat_sys_s390_getgid16
-48   common	signal			sys_signal			compat_sys_signal
-49   32		geteuid			-				compat_sys_s390_geteuid16
-50   32		getegid			-				compat_sys_s390_getegid16
-51   common	acct			sys_acct			compat_sys_acct
-52   common	umount2			sys_umount			compat_sys_umount
+45   common	brk			sys_brk				sys_brk
+46   32		setgid			-				sys_setgid16
+47   32		getgid			-				sys_getgid16
+48   common	signal			sys_signal			sys_signal
+49   32		geteuid			-				sys_geteuid16
+50   32		getegid			-				sys_getegid16
+51   common	acct			sys_acct			sys_acct
+52   common	umount2			sys_umount			sys_umount
 54   common	ioctl			sys_ioctl			compat_sys_ioctl
 55   common	fcntl			sys_fcntl			compat_sys_fcntl
 57   common	setpgid			sys_setpgid			sys_setpgid
 60   common	umask			sys_umask			sys_umask
-61   common	chroot			sys_chroot			compat_sys_chroot
+61   common	chroot			sys_chroot			sys_chroot
 62   common	ustat			sys_ustat			compat_sys_ustat
 63   common	dup2			sys_dup2			sys_dup2
 64   common	getppid			sys_getppid			sys_getppid
 65   common	getpgrp			sys_getpgrp			sys_getpgrp
 66   common	setsid			sys_setsid			sys_setsid
 67   common	sigaction		sys_sigaction			compat_sys_sigaction
-70   32		setreuid		-				compat_sys_s390_setreuid16
-71   32		setregid		-				compat_sys_s390_setregid16
-72   common	sigsuspend		sys_sigsuspend			compat_sys_sigsuspend
+70   32		setreuid		-				sys_setreuid16
+71   32		setregid		-				sys_setregid16
+72   common	sigsuspend		sys_sigsuspend			sys_sigsuspend
 73   common	sigpending		sys_sigpending			compat_sys_sigpending
-74   common	sethostname		sys_sethostname			compat_sys_sethostname
+74   common	sethostname		sys_sethostname			sys_sethostname
 75   common	setrlimit		sys_setrlimit			compat_sys_setrlimit
 76   32		getrlimit		-				compat_sys_old_getrlimit
 77   common	getrusage		sys_getrusage			compat_sys_getrusage
 78   common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
 79   common	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80   32		getgroups		-				compat_sys_s390_getgroups16
-81   32		setgroups		-				compat_sys_s390_setgroups16
-83   common	symlink			sys_symlink			compat_sys_symlink
-85   common	readlink		sys_readlink			compat_sys_readlink
-86   common	uselib			sys_uselib			compat_sys_uselib
-87   common	swapon			sys_swapon			compat_sys_swapon
-88   common	reboot			sys_reboot			compat_sys_reboot
+80   32		getgroups		-				sys_getgroups16
+81   32		setgroups		-				sys_setgroups16
+83   common	symlink			sys_symlink			sys_symlink
+85   common	readlink		sys_readlink			sys_readlink
+86   common	uselib			sys_uselib			sys_uselib
+87   common	swapon			sys_swapon			sys_swapon
+88   common	reboot			sys_reboot			sys_reboot
 89   common	readdir			-				compat_sys_old_readdir
 90   common	mmap			sys_old_mmap			compat_sys_s390_old_mmap
-91   common	munmap			sys_munmap			compat_sys_munmap
+91   common	munmap			sys_munmap			sys_munmap
 92   common	truncate		sys_truncate			compat_sys_truncate
 93   common	ftruncate		sys_ftruncate			compat_sys_ftruncate
 94   common	fchmod			sys_fchmod			sys_fchmod
-95   32		fchown			-				compat_sys_s390_fchown16
+95   32		fchown			-				sys_fchown16
 96   common	getpriority		sys_getpriority			sys_getpriority
 97   common	setpriority		sys_setpriority			sys_setpriority
 99   common	statfs			sys_statfs			compat_sys_statfs
 100  common	fstatfs			sys_fstatfs			compat_sys_fstatfs
 101  32		ioperm			-				-
 102  common	socketcall		sys_socketcall			compat_sys_socketcall
-103  common	syslog			sys_syslog			compat_sys_syslog
+103  common	syslog			sys_syslog			sys_syslog
 104  common	setitimer		sys_setitimer			compat_sys_setitimer
 105  common	getitimer		sys_getitimer			compat_sys_getitimer
 106  common	stat			sys_newstat			compat_sys_newstat
@@ -104,76 +104,76 @@
 111  common	vhangup			sys_vhangup			sys_vhangup
 112  common	idle			-				-
 114  common	wait4			sys_wait4			compat_sys_wait4
-115  common	swapoff			sys_swapoff			compat_sys_swapoff
+115  common	swapoff			sys_swapoff			sys_swapoff
 116  common	sysinfo			sys_sysinfo			compat_sys_sysinfo
 117  common	ipc			sys_s390_ipc			compat_sys_s390_ipc
 118  common	fsync			sys_fsync			sys_fsync
 119  common	sigreturn		sys_sigreturn			compat_sys_sigreturn
-120  common	clone			sys_clone			compat_sys_clone
-121  common	setdomainname		sys_setdomainname		compat_sys_setdomainname
-122  common	uname			sys_newuname			compat_sys_newuname
-124  common	adjtimex		sys_adjtimex			compat_sys_adjtimex
-125  common	mprotect		sys_mprotect			compat_sys_mprotect
+120  common	clone			sys_clone			sys_clone
+121  common	setdomainname		sys_setdomainname		sys_setdomainname
+122  common	uname			sys_newuname			sys_newuname
+124  common	adjtimex		sys_adjtimex			sys_adjtimex_time32
+125  common	mprotect		sys_mprotect			sys_mprotect
 126  common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 127  common	create_module		-				-
-128  common	init_module		sys_init_module			compat_sys_init_module
-129  common	delete_module		sys_delete_module		compat_sys_delete_module
+128  common	init_module		sys_init_module			sys_init_module
+129  common	delete_module		sys_delete_module		sys_delete_module
 130  common	get_kernel_syms		-				-
-131  common	quotactl		sys_quotactl			compat_sys_quotactl
+131  common	quotactl		sys_quotactl			sys_quotactl
 132  common	getpgid			sys_getpgid			sys_getpgid
 133  common	fchdir			sys_fchdir			sys_fchdir
-134  common	bdflush			sys_bdflush			compat_sys_bdflush
-135  common	sysfs			sys_sysfs			compat_sys_sysfs
+134  common	bdflush			sys_bdflush			sys_bdflush
+135  common	sysfs			sys_sysfs			sys_sysfs
 136  common	personality		sys_s390_personality		sys_s390_personality
 137  common	afs_syscall		-				-
-138  32		setfsuid		-				compat_sys_s390_setfsuid16
-139  32		setfsgid		-				compat_sys_s390_setfsgid16
-140  32		_llseek			-				compat_sys_llseek
+138  32		setfsuid		-				sys_setfsuid16
+139  32		setfsgid		-				sys_setfsgid16
+140  32		_llseek			-				sys_llseek
 141  common	getdents		sys_getdents			compat_sys_getdents
 142  32		_newselect		-				compat_sys_select
 142  64		select			sys_select			-
 143  common	flock			sys_flock			sys_flock
-144  common	msync			sys_msync			compat_sys_msync
+144  common	msync			sys_msync			sys_msync
 145  common	readv			sys_readv			compat_sys_readv
 146  common	writev			sys_writev			compat_sys_writev
 147  common	getsid			sys_getsid			sys_getsid
 148  common	fdatasync		sys_fdatasync			sys_fdatasync
 149  common	_sysctl			sys_sysctl			compat_sys_sysctl
-150  common	mlock			sys_mlock			compat_sys_mlock
-151  common	munlock			sys_munlock			compat_sys_munlock
+150  common	mlock			sys_mlock			sys_mlock
+151  common	munlock			sys_munlock			sys_munlock
 152  common	mlockall		sys_mlockall			sys_mlockall
 153  common	munlockall		sys_munlockall			sys_munlockall
-154  common	sched_setparam		sys_sched_setparam		compat_sys_sched_setparam
-155  common	sched_getparam		sys_sched_getparam		compat_sys_sched_getparam
-156  common	sched_setscheduler	sys_sched_setscheduler		compat_sys_sched_setscheduler
+154  common	sched_setparam		sys_sched_setparam		sys_sched_setparam
+155  common	sched_getparam		sys_sched_getparam		sys_sched_getparam
+156  common	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
 157  common	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
 158  common	sched_yield		sys_sched_yield			sys_sched_yield
 159  common	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
 160  common	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
-161  common	sched_rr_get_interval	sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162  common	nanosleep		sys_nanosleep			compat_sys_nanosleep
-163  common	mremap			sys_mremap			compat_sys_mremap
-164  32		setresuid		-				compat_sys_s390_setresuid16
-165  32		getresuid		-				compat_sys_s390_getresuid16
+161  common	sched_rr_get_interval	sys_sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162  common	nanosleep		sys_nanosleep			sys_nanosleep_time32
+163  common	mremap			sys_mremap			sys_mremap
+164  32		setresuid		-				sys_setresuid16
+165  32		getresuid		-				sys_getresuid16
 167  common	query_module		-				-
-168  common	poll			sys_poll			compat_sys_poll
+168  common	poll			sys_poll			sys_poll
 169  common	nfsservctl		-				-
-170  32		setresgid		-				compat_sys_s390_setresgid16
-171  32		getresgid		-				compat_sys_s390_getresgid16
-172  common	prctl			sys_prctl			compat_sys_prctl
+170  32		setresgid		-				sys_setresgid16
+171  32		getresgid		-				sys_getresgid16
+172  common	prctl			sys_prctl			sys_prctl
 173  common	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
 174  common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
 175  common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
 176  common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
-177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177  common	rt_sigtimedwait		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time32
 178  common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
 179  common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 180  common	pread64			sys_pread64			compat_sys_s390_pread64
 181  common	pwrite64		sys_pwrite64			compat_sys_s390_pwrite64
-182  32		chown			-				compat_sys_s390_chown16
-183  common	getcwd			sys_getcwd			compat_sys_getcwd
-184  common	capget			sys_capget			compat_sys_capget
-185  common	capset			sys_capset			compat_sys_capset
+182  32		chown			-				sys_chown16
+183  common	getcwd			sys_getcwd			sys_getcwd
+184  common	capget			sys_capget			sys_capget
+185  common	capset			sys_capset			sys_capset
 186  common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
 187  common	sendfile		sys_sendfile64			compat_sys_sendfile
 188  common	getpmsg			-				-
@@ -187,7 +187,7 @@
 195  32		stat64			-				compat_sys_s390_stat64
 196  32		lstat64			-				compat_sys_s390_lstat64
 197  32		fstat64			-				compat_sys_s390_fstat64
-198  32		lchown32		-				compat_sys_lchown
+198  32		lchown32		-				sys_lchown
 198  64		lchown			sys_lchown			-
 199  32		getuid32		-				sys_getuid
 199  64		getuid			sys_getuid			-
@@ -201,21 +201,21 @@
 203  64		setreuid		sys_setreuid			-
 204  32		setregid32		-				sys_setregid
 204  64		setregid		sys_setregid			-
-205  32		getgroups32		-				compat_sys_getgroups
+205  32		getgroups32		-				sys_getgroups
 205  64		getgroups		sys_getgroups			-
-206  32		setgroups32		-				compat_sys_setgroups
+206  32		setgroups32		-				sys_setgroups
 206  64		setgroups		sys_setgroups			-
 207  32		fchown32		-				sys_fchown
 207  64		fchown			sys_fchown			-
 208  32		setresuid32		-				sys_setresuid
 208  64		setresuid		sys_setresuid			-
-209  32		getresuid32		-				compat_sys_getresuid
+209  32		getresuid32		-				sys_getresuid
 209  64		getresuid		sys_getresuid			-
 210  32		setresgid32		-				sys_setresgid
 210  64		setresgid		sys_setresgid			-
-211  32		getresgid32		-				compat_sys_getresgid
+211  32		getresgid32		-				sys_getresgid
 211  64		getresgid		sys_getresgid			-
-212  32		chown32			-				compat_sys_chown
+212  32		chown32			-				sys_chown
 212  64		chown			sys_chown			-
 213  32		setuid32		-				sys_setuid
 213  64		setuid			sys_setuid			-
@@ -225,166 +225,218 @@
 215  64		setfsuid		sys_setfsuid			-
 216  32		setfsgid32		-				sys_setfsgid
 216  64		setfsgid		sys_setfsgid			-
-217  common	pivot_root		sys_pivot_root			compat_sys_pivot_root
-218  common	mincore			sys_mincore			compat_sys_mincore
-219  common	madvise			sys_madvise			compat_sys_madvise
-220  common	getdents64		sys_getdents64			compat_sys_getdents64
+217  common	pivot_root		sys_pivot_root			sys_pivot_root
+218  common	mincore			sys_mincore			sys_mincore
+219  common	madvise			sys_madvise			sys_madvise
+220  common	getdents64		sys_getdents64			sys_getdents64
 221  32		fcntl64			-				compat_sys_fcntl64
 222  common	readahead		sys_readahead			compat_sys_s390_readahead
 223  32		sendfile64		-				compat_sys_sendfile64
-224  common	setxattr		sys_setxattr			compat_sys_setxattr
-225  common	lsetxattr		sys_lsetxattr			compat_sys_lsetxattr
-226  common	fsetxattr		sys_fsetxattr			compat_sys_fsetxattr
-227  common	getxattr		sys_getxattr			compat_sys_getxattr
-228  common	lgetxattr		sys_lgetxattr			compat_sys_lgetxattr
-229  common	fgetxattr		sys_fgetxattr			compat_sys_fgetxattr
-230  common	listxattr		sys_listxattr			compat_sys_listxattr
-231  common	llistxattr		sys_llistxattr			compat_sys_llistxattr
-232  common	flistxattr		sys_flistxattr			compat_sys_flistxattr
-233  common	removexattr		sys_removexattr			compat_sys_removexattr
-234  common	lremovexattr		sys_lremovexattr		compat_sys_lremovexattr
-235  common	fremovexattr		sys_fremovexattr		compat_sys_fremovexattr
+224  common	setxattr		sys_setxattr			sys_setxattr
+225  common	lsetxattr		sys_lsetxattr			sys_lsetxattr
+226  common	fsetxattr		sys_fsetxattr			sys_fsetxattr
+227  common	getxattr		sys_getxattr			sys_getxattr
+228  common	lgetxattr		sys_lgetxattr			sys_lgetxattr
+229  common	fgetxattr		sys_fgetxattr			sys_fgetxattr
+230  common	listxattr		sys_listxattr			sys_listxattr
+231  common	llistxattr		sys_llistxattr			sys_llistxattr
+232  common	flistxattr		sys_flistxattr			sys_flistxattr
+233  common	removexattr		sys_removexattr			sys_removexattr
+234  common	lremovexattr		sys_lremovexattr		sys_lremovexattr
+235  common	fremovexattr		sys_fremovexattr		sys_fremovexattr
 236  common	gettid			sys_gettid			sys_gettid
 237  common	tkill			sys_tkill			sys_tkill
-238  common	futex			sys_futex			compat_sys_futex
+238  common	futex			sys_futex			sys_futex_time32
 239  common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
 240  common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
 241  common	tgkill			sys_tgkill			sys_tgkill
 243  common	io_setup		sys_io_setup			compat_sys_io_setup
-244  common	io_destroy		sys_io_destroy			compat_sys_io_destroy
-245  common	io_getevents		sys_io_getevents		compat_sys_io_getevents
+244  common	io_destroy		sys_io_destroy			sys_io_destroy
+245  common	io_getevents		sys_io_getevents		sys_io_getevents_time32
 246  common	io_submit		sys_io_submit			compat_sys_io_submit
-247  common	io_cancel		sys_io_cancel			compat_sys_io_cancel
+247  common	io_cancel		sys_io_cancel			sys_io_cancel
 248  common	exit_group		sys_exit_group			sys_exit_group
 249  common	epoll_create		sys_epoll_create		sys_epoll_create
-250  common	epoll_ctl		sys_epoll_ctl			compat_sys_epoll_ctl
-251  common	epoll_wait		sys_epoll_wait			compat_sys_epoll_wait
-252  common	set_tid_address		sys_set_tid_address		compat_sys_set_tid_address
+250  common	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
+251  common	epoll_wait		sys_epoll_wait			sys_epoll_wait
+252  common	set_tid_address		sys_set_tid_address		sys_set_tid_address
 253  common	fadvise64		sys_fadvise64_64		compat_sys_s390_fadvise64
 254  common	timer_create		sys_timer_create		compat_sys_timer_create
-255  common	timer_settime		sys_timer_settime		compat_sys_timer_settime
-256  common	timer_gettime		sys_timer_gettime		compat_sys_timer_gettime
+255  common	timer_settime		sys_timer_settime		sys_timer_settime32
+256  common	timer_gettime		sys_timer_gettime		sys_timer_gettime32
 257  common	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
 258  common	timer_delete		sys_timer_delete		sys_timer_delete
-259  common	clock_settime		sys_clock_settime		compat_sys_clock_settime
-260  common	clock_gettime		sys_clock_gettime		compat_sys_clock_gettime
-261  common	clock_getres		sys_clock_getres		compat_sys_clock_getres
-262  common	clock_nanosleep		sys_clock_nanosleep		compat_sys_clock_nanosleep
+259  common	clock_settime		sys_clock_settime		sys_clock_settime32
+260  common	clock_gettime		sys_clock_gettime		sys_clock_gettime32
+261  common	clock_getres		sys_clock_getres		sys_clock_getres_time32
+262  common	clock_nanosleep		sys_clock_nanosleep		sys_clock_nanosleep_time32
 264  32		fadvise64_64		-				compat_sys_s390_fadvise64_64
 265  common	statfs64		sys_statfs64			compat_sys_statfs64
 266  common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-267  common	remap_file_pages	sys_remap_file_pages		compat_sys_remap_file_pages
+267  common	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
 268  common	mbind			sys_mbind			compat_sys_mbind
 269  common	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
 270  common	set_mempolicy		sys_set_mempolicy		compat_sys_set_mempolicy
 271  common	mq_open			sys_mq_open			compat_sys_mq_open
-272  common	mq_unlink		sys_mq_unlink			compat_sys_mq_unlink
-273  common	mq_timedsend		sys_mq_timedsend		compat_sys_mq_timedsend
-274  common	mq_timedreceive		sys_mq_timedreceive		compat_sys_mq_timedreceive
+272  common	mq_unlink		sys_mq_unlink			sys_mq_unlink
+273  common	mq_timedsend		sys_mq_timedsend		sys_mq_timedsend_time32
+274  common	mq_timedreceive		sys_mq_timedreceive		sys_mq_timedreceive_time32
 275  common	mq_notify		sys_mq_notify			compat_sys_mq_notify
 276  common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
 277  common	kexec_load		sys_kexec_load			compat_sys_kexec_load
-278  common	add_key			sys_add_key			compat_sys_add_key
-279  common	request_key		sys_request_key			compat_sys_request_key
+278  common	add_key			sys_add_key			sys_add_key
+279  common	request_key		sys_request_key			sys_request_key
 280  common	keyctl			sys_keyctl			compat_sys_keyctl
 281  common	waitid			sys_waitid			compat_sys_waitid
 282  common	ioprio_set		sys_ioprio_set			sys_ioprio_set
 283  common	ioprio_get		sys_ioprio_get			sys_ioprio_get
 284  common	inotify_init		sys_inotify_init		sys_inotify_init
-285  common	inotify_add_watch	sys_inotify_add_watch		compat_sys_inotify_add_watch
+285  common	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
 286  common	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
 287  common	migrate_pages		sys_migrate_pages		compat_sys_migrate_pages
 288  common	openat			sys_openat			compat_sys_openat
-289  common	mkdirat			sys_mkdirat			compat_sys_mkdirat
-290  common	mknodat			sys_mknodat			compat_sys_mknodat
-291  common	fchownat		sys_fchownat			compat_sys_fchownat
-292  common	futimesat		sys_futimesat			compat_sys_futimesat
+289  common	mkdirat			sys_mkdirat			sys_mkdirat
+290  common	mknodat			sys_mknodat			sys_mknodat
+291  common	fchownat		sys_fchownat			sys_fchownat
+292  common	futimesat		sys_futimesat			sys_futimesat_time32
 293  32		fstatat64		-				compat_sys_s390_fstatat64
 293  64		newfstatat		sys_newfstatat			-
-294  common	unlinkat		sys_unlinkat			compat_sys_unlinkat
-295  common	renameat		sys_renameat			compat_sys_renameat
-296  common	linkat			sys_linkat			compat_sys_linkat
-297  common	symlinkat		sys_symlinkat			compat_sys_symlinkat
-298  common	readlinkat		sys_readlinkat			compat_sys_readlinkat
-299  common	fchmodat		sys_fchmodat			compat_sys_fchmodat
-300  common	faccessat		sys_faccessat			compat_sys_faccessat
-301  common	pselect6		sys_pselect6			compat_sys_pselect6
-302  common	ppoll			sys_ppoll			compat_sys_ppoll
-303  common	unshare			sys_unshare			compat_sys_unshare
+294  common	unlinkat		sys_unlinkat			sys_unlinkat
+295  common	renameat		sys_renameat			sys_renameat
+296  common	linkat			sys_linkat			sys_linkat
+297  common	symlinkat		sys_symlinkat			sys_symlinkat
+298  common	readlinkat		sys_readlinkat			sys_readlinkat
+299  common	fchmodat		sys_fchmodat			sys_fchmodat
+300  common	faccessat		sys_faccessat			sys_faccessat
+301  common	pselect6		sys_pselect6			compat_sys_pselect6_time32
+302  common	ppoll			sys_ppoll			compat_sys_ppoll_time32
+303  common	unshare			sys_unshare			sys_unshare
 304  common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 305  common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-306  common	splice			sys_splice			compat_sys_splice
+306  common	splice			sys_splice			sys_splice
 307  common	sync_file_range		sys_sync_file_range		compat_sys_s390_sync_file_range
-308  common	tee			sys_tee				compat_sys_tee
+308  common	tee			sys_tee				sys_tee
 309  common	vmsplice		sys_vmsplice			compat_sys_vmsplice
 310  common	move_pages		sys_move_pages			compat_sys_move_pages
-311  common	getcpu			sys_getcpu			compat_sys_getcpu
+311  common	getcpu			sys_getcpu			sys_getcpu
 312  common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
-313  common	utimes			sys_utimes			compat_sys_utimes
+313  common	utimes			sys_utimes			sys_utimes_time32
 314  common	fallocate		sys_fallocate			compat_sys_s390_fallocate
-315  common	utimensat		sys_utimensat			compat_sys_utimensat
+315  common	utimensat		sys_utimensat			sys_utimensat_time32
 316  common	signalfd		sys_signalfd			compat_sys_signalfd
 317  common	timerfd			-				-
 318  common	eventfd			sys_eventfd			sys_eventfd
 319  common	timerfd_create		sys_timerfd_create		sys_timerfd_create
-320  common	timerfd_settime		sys_timerfd_settime		compat_sys_timerfd_settime
-321  common	timerfd_gettime		sys_timerfd_gettime		compat_sys_timerfd_gettime
+320  common	timerfd_settime		sys_timerfd_settime		sys_timerfd_settime32
+321  common	timerfd_gettime		sys_timerfd_gettime		sys_timerfd_gettime32
 322  common	signalfd4		sys_signalfd4			compat_sys_signalfd4
 323  common	eventfd2		sys_eventfd2			sys_eventfd2
 324  common	inotify_init1		sys_inotify_init1		sys_inotify_init1
-325  common	pipe2			sys_pipe2			compat_sys_pipe2
+325  common	pipe2			sys_pipe2			sys_pipe2
 326  common	dup3			sys_dup3			sys_dup3
 327  common	epoll_create1		sys_epoll_create1		sys_epoll_create1
 328  common	preadv			sys_preadv			compat_sys_preadv
 329  common	pwritev			sys_pwritev			compat_sys_pwritev
 330  common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-331  common	perf_event_open		sys_perf_event_open		compat_sys_perf_event_open
+331  common	perf_event_open		sys_perf_event_open		sys_perf_event_open
 332  common	fanotify_init		sys_fanotify_init		sys_fanotify_init
 333  common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
-334  common	prlimit64		sys_prlimit64			compat_sys_prlimit64
-335  common	name_to_handle_at	sys_name_to_handle_at		compat_sys_name_to_handle_at
+334  common	prlimit64		sys_prlimit64			sys_prlimit64
+335  common	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
 336  common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-337  common	clock_adjtime		sys_clock_adjtime		compat_sys_clock_adjtime
+337  common	clock_adjtime		sys_clock_adjtime		sys_clock_adjtime32
 338  common	syncfs			sys_syncfs			sys_syncfs
 339  common	setns			sys_setns			sys_setns
 340  common	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
 341  common	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
 342  common	s390_runtime_instr	sys_s390_runtime_instr		sys_s390_runtime_instr
-343  common	kcmp			sys_kcmp			compat_sys_kcmp
-344  common	finit_module		sys_finit_module		compat_sys_finit_module
-345  common	sched_setattr		sys_sched_setattr		compat_sys_sched_setattr
-346  common	sched_getattr		sys_sched_getattr		compat_sys_sched_getattr
-347  common	renameat2		sys_renameat2			compat_sys_renameat2
-348  common	seccomp			sys_seccomp			compat_sys_seccomp
-349  common	getrandom		sys_getrandom			compat_sys_getrandom
-350  common	memfd_create		sys_memfd_create		compat_sys_memfd_create
-351  common	bpf			sys_bpf				compat_sys_bpf
-352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		compat_sys_s390_pci_mmio_write
-353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		compat_sys_s390_pci_mmio_read
+343  common	kcmp			sys_kcmp			sys_kcmp
+344  common	finit_module		sys_finit_module		sys_finit_module
+345  common	sched_setattr		sys_sched_setattr		sys_sched_setattr
+346  common	sched_getattr		sys_sched_getattr		sys_sched_getattr
+347  common	renameat2		sys_renameat2			sys_renameat2
+348  common	seccomp			sys_seccomp			sys_seccomp
+349  common	getrandom		sys_getrandom			sys_getrandom
+350  common	memfd_create		sys_memfd_create		sys_memfd_create
+351  common	bpf			sys_bpf				sys_bpf
+352  common	s390_pci_mmio_write	sys_s390_pci_mmio_write		sys_s390_pci_mmio_write
+353  common	s390_pci_mmio_read	sys_s390_pci_mmio_read		sys_s390_pci_mmio_read
 354  common	execveat		sys_execveat			compat_sys_execveat
 355  common	userfaultfd		sys_userfaultfd			sys_userfaultfd
 356  common	membarrier		sys_membarrier			sys_membarrier
-357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg
+357  common	recvmmsg		sys_recvmmsg			compat_sys_recvmmsg_time32
 358  common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
 359  common	socket			sys_socket			sys_socket
-360  common	socketpair		sys_socketpair			compat_sys_socketpair
-361  common	bind			sys_bind			compat_sys_bind
-362  common	connect			sys_connect			compat_sys_connect
+360  common	socketpair		sys_socketpair			sys_socketpair
+361  common	bind			sys_bind			sys_bind
+362  common	connect			sys_connect			sys_connect
 363  common	listen			sys_listen			sys_listen
-364  common	accept4			sys_accept4			compat_sys_accept4
+364  common	accept4			sys_accept4			sys_accept4
 365  common	getsockopt		sys_getsockopt			compat_sys_getsockopt
 366  common	setsockopt		sys_setsockopt			compat_sys_setsockopt
-367  common	getsockname		sys_getsockname			compat_sys_getsockname
-368  common	getpeername		sys_getpeername			compat_sys_getpeername
-369  common	sendto			sys_sendto			compat_sys_sendto
+367  common	getsockname		sys_getsockname			sys_getsockname
+368  common	getpeername		sys_getpeername			sys_getpeername
+369  common	sendto			sys_sendto			sys_sendto
 370  common	sendmsg			sys_sendmsg			compat_sys_sendmsg
 371  common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 372  common	recvmsg			sys_recvmsg			compat_sys_recvmsg
 373  common	shutdown		sys_shutdown			sys_shutdown
-374  common	mlock2			sys_mlock2			compat_sys_mlock2
-375  common	copy_file_range		sys_copy_file_range		compat_sys_copy_file_range
+374  common	mlock2			sys_mlock2			sys_mlock2
+375  common	copy_file_range		sys_copy_file_range		sys_copy_file_range
 376  common	preadv2			sys_preadv2			compat_sys_preadv2
 377  common	pwritev2		sys_pwritev2			compat_sys_pwritev2
-378  common	s390_guarded_storage	sys_s390_guarded_storage	compat_sys_s390_guarded_storage
-379  common	statx			sys_statx			compat_sys_statx
-380  common	s390_sthyi		sys_s390_sthyi			compat_sys_s390_sthyi
+378  common	s390_guarded_storage	sys_s390_guarded_storage	sys_s390_guarded_storage
+379  common	statx			sys_statx			sys_statx
+380  common	s390_sthyi		sys_s390_sthyi			sys_s390_sthyi
+381  common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
+382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+383  common	rseq			sys_rseq			sys_rseq
+384  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
+385  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+386  common	pkey_free		sys_pkey_free			sys_pkey_free
+# room for arch specific syscalls
+392	64	semtimedop		sys_semtimedop			-
+393  common	semget			sys_semget			sys_semget
+394  common	semctl			sys_semctl			compat_sys_semctl
+395  common	shmget			sys_shmget			sys_shmget
+396  common	shmctl			sys_shmctl			compat_sys_shmctl
+397  common	shmat			sys_shmat			compat_sys_shmat
+398  common	shmdt			sys_shmdt 			sys_shmdt
+399  common	msgget			sys_msgget			sys_msgget
+400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402  common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64		-				sys_clock_gettime
+404	32	clock_settime64		-				sys_clock_settime
+405	32	clock_adjtime64		-				sys_clock_adjtime
+406	32	clock_getres_time64	-				sys_clock_getres
+407	32	clock_nanosleep_time64	-				sys_clock_nanosleep
+408	32	timer_gettime64		-				sys_timer_gettime
+409	32	timer_settime64		-				sys_timer_settime
+410	32	timerfd_gettime64	-				sys_timerfd_gettime
+411	32	timerfd_settime64	-				sys_timerfd_settime
+412	32	utimensat_time64	-				sys_utimensat
+413	32	pselect6_time64		-				compat_sys_pselect6_time64
+414	32	ppoll_time64		-				compat_sys_ppoll_time64
+416	32	io_pgetevents_time64	-				sys_io_pgetevents
+417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64	-				sys_mq_timedsend
+419	32	mq_timedreceive_time64	-				sys_mq_timedreceive
+420	32	semtimedop_time64	-				sys_semtimedop
+421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64		-				sys_futex
+423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+424  common	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
+425  common	io_uring_setup		sys_io_uring_setup              sys_io_uring_setup
+426  common	io_uring_enter		sys_io_uring_enter              sys_io_uring_enter
+427  common	io_uring_register	sys_io_uring_register           sys_io_uring_register
+428  common	open_tree		sys_open_tree			sys_open_tree
+429  common	move_mount		sys_move_mount			sys_move_mount
+430  common	fsopen			sys_fsopen			sys_fsopen
+431  common	fsconfig		sys_fsconfig			sys_fsconfig
+432  common	fsmount			sys_fsmount			sys_fsmount
+433  common	fspick			sys_fspick			sys_fspick
+434  common	pidfd_open		sys_pidfd_open			sys_pidfd_open
+435  common	clone3			sys_clone3			sys_clone3
+437  common	openat2			sys_openat2			sys_openat2
+438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
-- 
2.25.1

