Return-Path: <linux-s390+bounces-22090-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bX1lAUAGVGoBhAMAu9opvQ
	(envelope-from <linux-s390+bounces-22090-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 23:25:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A223745F3C
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 23:25:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iUihrXXV;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22090-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-22090-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8B72300C900
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jul 2026 21:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792BD375F83;
	Sun, 12 Jul 2026 21:25:17 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25717C203;
	Sun, 12 Jul 2026 21:25:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891517; cv=none; b=qhbP0CcdNIHnGP5Bq9iYVNALSKgmQYvvv0AvDBewUymrWVOkhJG+9DaWq73FBvzrwie0cDNgbn942W/QRL3KihVw72n4UFUHjELvPbw/wruDxIC5Z4hLiOCcxKwawd75r4MqK1d+p/pz8a+zn9TAUl8afmPmzjThdu5crMS38Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891517; c=relaxed/simple;
	bh=hP7lte9xARTw3iph1JAkc0pXwM3iIlnPbn4ZU6WTfaM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=RX3B7k2zBTj962d2AVAaCPi38Z0qdDs2kWp23a8dV10yWTYGJQxd63ovaXP7qfJP0FvvK1NNy72VQfqHAN38Z7/DoABiHEH/oRdY6SCtkhhobGT4nzFVw5zy9nb1VKRvD0zMpTOyF17x3PokIUx7pdBW3g968xKs/16koAeQ3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUihrXXV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767DE1F000E9;
	Sun, 12 Jul 2026 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783891516;
	bh=lwBg36/x+UtK8CJqmuUc9WLztI2cbur8/uNJ6nqvy3A=;
	h=Date:From:To:Cc:Subject;
	b=iUihrXXVEGq2SYK9UQGaK/ixJHkvadpYQ4DOH4S/nAejgcD/b7GUWwBZ5jduOfGTp
	 i2GmHCBrjqnQqhqfy4uM2Nm1ZqAGGaYxEbfVavR0WHrnlVlBrqHw8lCXBF+I+H4UYL
	 rp//e3HRjshpQ+bNYw6Guvww3ARF7O7HJsAP1v+ktF8f16Gw0ufg7Kv+IvYnQqmnDd
	 nOouURl3ey8GIdW1RylaSmhjzQZmjZJj0NnC6v8qojx/WotJKtYEUPvgrJhaLKZf29
	 MvSWr2X6GY8DZQ/V7/XPuTag3oQfy5KgCPYjv4bZ3cYiQUKKlTvDFxz1jtaHpcPEp9
	 9manpI38rMBQQ==
Date: Sun, 12 Jul 2026 23:25:12 +0200
Message-ID: <20260712134433.549076055@kernel.org>
User-Agent: quilt/0.69
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org,
 Sven Schnelle <svens@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 x86@kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Jinjie Ruan <ruanjinjie@huawei.com>,
 Magnus Lindholm <linmag7@gmail.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Radu Rendec <radu@rendec.net>
Subject: [patch 0/4] entry: Rework syscall skip logic
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22090-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:msuchanek@suse.de,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:ruanjinjie@huawei.com,m:linmag7@gmail.com,m:mkchauras@gmail.com,m:corbet@lwn.net,m:radu@rendec.net,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.de,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,kernel.org,lists.linux.dev,dabbelt.com,lists.infradead.org,vger.kernel.org,arm.com,huawei.com,gmail.com,lwn.net,rendec.net];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A223745F3C

This are the reworked leftovers of the larger entry logic rework series,
which can be found here:

  https://lore.kernel.org/lkml/20260707181957.433213175@kernel.org

The undisputed part of the series has been merged into:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

After a fruitless discussion about the most resilent approach, I decided to
give up wasting my time and reworked the series so it caters to the desire
of powerpc and s390 to be special.

That results in almost identical behavior except for the case where
tracing/probe/BPF sets the syscall number to -1 (or any other out of range
value) and also sets the syscall return value to something different than
-ENOSYS.

PowerPC and S390 will overwrite that value with -ENOSYS.

Loongarch, RISC-V and x86 will not overwrite it because those architectures
preset the return value to -ENOSYS and skip out of range syscalls
completely. Loongarch and RISC-V always did the out of range skip. X86
gained that in the already applied rework, which means that the final patch
which splits the skip decision from the syscall number does not longer
change x86 behavior for the above case.

Documentation is also updated and describes the two implementation variants
and the subtle difference in the resulting behavior.

The series applies on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/entry

and is also available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git entry/rework

Thanks,

	tglx
---
 Documentation/core-api/entry.rst |   45 +++++++++++++++++++++++-------
 arch/loongarch/kernel/syscall.c  |   14 ++++-----
 arch/powerpc/kernel/syscall.c    |    3 +-
 arch/riscv/kernel/traps.c        |   11 +++----
 arch/s390/kernel/syscall.c       |    7 +++-
 arch/x86/entry/syscall_32.c      |   25 ++++++++--------
 arch/x86/entry/syscall_64.c      |   12 ++++----
 include/linux/entry-common.h     |   58 +++++++++++++++++----------------------
 kernel/entry/syscall-common.c    |   19 ++++++++----
 9 files changed, 110 insertions(+), 84 deletions(-)


