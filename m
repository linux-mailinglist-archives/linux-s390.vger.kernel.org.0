Return-Path: <linux-s390+bounces-9064-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A7BA3A838
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 21:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBECF3A4C39
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2025 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF091EB5FD;
	Tue, 18 Feb 2025 19:59:59 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93921E835C;
	Tue, 18 Feb 2025 19:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908799; cv=none; b=YpdzocyP63jmT/b9oMMzTA95+QJxhuujUssvDMyuTucuqgK2BxPKocjiBQ1l5ZPHGgR6rdLJdzoChiNHGnnFVOQXjWe2FaCzLZXmQgdvk8guB+hzoVVTjQidXoGsjq7XAHmQhmw0189T4e0sX0K7eyDx+CE3RxG7tDvbgpZLXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908799; c=relaxed/simple;
	bh=L97Rxhcckn9npUQ6KwMiTkzEcTM9q1EIrEsNYDNgkvk=;
	h=Message-ID:Date:From:To:Cc:Subject; b=sDNt/3tOMmIwbhvUy7wnHxrfi2WWWGCYY1ZKcDiywdYWZtFK82OsrFEciQxq20sr1mTbpbf6qfVxdaoyQutCLCJFX4wRPgf63ULUpGqyTgdXqFKtS36jhK1y4s9px7LCJ0Wbx+qtL8YwUcCfN3Uzimg0bCfL0M8+PFS/oXmK2bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC1EC4CEE2;
	Tue, 18 Feb 2025 19:59:59 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tkTlW-00000004Aon-1RHX;
	Tue, 18 Feb 2025 15:00:22 -0500
Message-ID: <20250218195918.255228630@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 18 Feb 2025 14:59:18 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 bpf <bpf@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas@fjasle.eu>,
 Zheng Yejian <zhengyejian1@huawei.com>,
 Martin  Kelly <martin.kelly@crowdstrike.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v5 0/6] scripts/sorttable: ftrace: Remove place holders for weak functions in available_filter_functions
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

This series removes the place holder __ftrace_invalid_address___ from
the available_filter_functions file.

The rewriting of the sorttable.c code to make it more manageable
has already been merged:

  https://git.kernel.org/torvalds/c/c0e75905caf368e19aab585d20151500e750de89

Now this is only for getting rid of the ftrace invalid function place holders.

The first patch adds arm64 sorting, which requires copying the Elf_Rela into
a separate array and sorting that.

There's a slight fix patch that adds using a compare function that checks the
direct values without swapping bytes as the current method will swap bytes,
but the copying into the array already did the necessary swapping.

The third patch makes it always copy the section into an array, sort that,
then copy it back. This allows updates to the values in one place.

The forth patch adds the option "-s <file>" to sorttable.c. Now this code
is called by:

  ${NM} -S vmlinux > .tmp_vmlinux.nm-sort
  ${objtree}/scripts/sorttable -s .tmp_vmlinux.nm-sort ${1}

Where the file created by "nm -S" is read, recording the address and the
associated sizes of each function. It then is sorted, and before sorting the
mcount_loc table, it is scanned to make sure all symbols in the mcount_loc are
within the boundaries of the functions defined by nm. If they are not, they
are zeroed out, as they are most likely weak functions (I don't know what else
they would be).

Since the KASLR address can be added to the values in this section, when the
section is read to populate the ftrace records, if the value is zero or equal
to kaslr_offset() it is skipped and not added.

Before:
    
 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 551

After:

 ~# grep __ftrace_invalid_address___ /sys/kernel/tracing/available_filter_functions | wc -l
 0

The last patches are fixes to ftrace accounting to handle the fact that it
will likely always have skipped values (at least for x86), and to modify the
code to verify that the amount of skipped and saved records do match the
calculated allocations necessary.

And finally, to change the reporting of how much was allocated to reflect the
freed pages that were allocated but not used due to the skipped entries.

Changes since v4: https://lore.kernel.org/all/20250217153401.022858448@goodmis.org/

- My tests found that the variable "remaining" was used uninitialized

Changes since v3: https://lore.kernel.org/all/20250213162047.306074881@goodmis.org/

- Do not remove 'W' weak functions that are still used.

Changes since v2: https://lore.kernel.org/linux-trace-kernel/20250102232609.529842248@goodmis.org/

- Rebased on mainline that has the rewriting of sorttable.c

- Added the code to handle the sections being stored in Elf_Rela sections as
  arm64 uses.

- No longer use the "ftrace_skip_sym" variable to skip over the zeroed out
  functions and instead just compare with kalsr_offset.

- Sort via an array and not directly in the file's section.

- Update the verification code to make sure the skipped value is correct.

- Update the output to correctly reflect what was allocated.


Changes since v1: https://lore.kernel.org/all/20250102185845.928488650@goodmis.org/

- Replaced the last patch with 3 patches.

  The first of the 3 patches removed the hack of reading System.map
  with properly reading the Elf symbol table to find start_mcount_loc
  and stop_mcount_loc.

  The second patch adds the call to "nm -S vmlinux" to get the sizes
  of each function.

  The previous last patch would just check the zeroed out values and compare
  them to kaslr_offset(). Instead, this time, the last patch adds a new
  ftrace_mcount_skip that is used to simply skip over the first entries
  that the sorttable.c moved to the beginning, as they were the weak functions
  that were found.


Steven Rostedt (6):
      arm64: scripts/sorttable: Implement sorting mcount_loc at boot for arm64
      scripts/sorttable: Have mcount rela sort use direct values
      scripts/sorttable: Always use an array for the mcount_loc sorting
      scripts/sorttable: Zero out weak functions in mcount_loc table
      ftrace: Update the mcount_loc check of skipped entries
      ftrace: Have ftrace pages output reflect freed pages

----
 arch/arm64/Kconfig      |   1 +
 kernel/trace/ftrace.c   |  44 +++++-
 scripts/link-vmlinux.sh |   4 +-
 scripts/sorttable.c     | 401 +++++++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 436 insertions(+), 14 deletions(-)

