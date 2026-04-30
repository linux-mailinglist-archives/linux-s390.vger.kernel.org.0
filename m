Return-Path: <linux-s390+bounces-19221-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEc0CeXN8mnOuQEAu9opvQ
	(envelope-from <linux-s390+bounces-19221-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 05:35:01 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA3D49CF97
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 05:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA916305093C
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A838351C1C;
	Thu, 30 Apr 2026 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzTbqLo/"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3697333F5A8;
	Thu, 30 Apr 2026 03:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519574; cv=none; b=dlEUWH9hrnbUWjeTrZV1w/tMtGnUZVMMYKhUdXRal7PbMupKFCZv+hL/UyQBayP7pca03FGv3ZsxRhIAKYP3tQb3SG/r/Bw4+zuwz2K3MmcyUsF68w6CCARw2/mqU5O+DeisSfFHLHNOvbXFTPfgZhdoHin5YNYVzBP/TLw3gkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519574; c=relaxed/simple;
	bh=THrrdSGjgRzaSbCrGespfxo5C/AWLl4KlIEGbaUs1N8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i8IugMoAHLoazn4827waPdWmbGSaPzBCJ0XqoEQ+nBFvhFI33fjkcrKEAHNcfhbGvAbycjT6wHMoCG4nUuYZv7j2+uDESNIixSvnAw/bs6vqSMiLh/ozQG59cxfD2XTQuoeUc34qkSpkn3GEW9TQ9wXJ8YwiWabEc3F9YpOp1z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzTbqLo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB14C2BCB9;
	Thu, 30 Apr 2026 03:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519573;
	bh=THrrdSGjgRzaSbCrGespfxo5C/AWLl4KlIEGbaUs1N8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UzTbqLo/5B2o+wNCv7hc433OYzKq4siikxTyngUKDMF3HAeUjhBhAk77XupcxRUvU
	 8AQeEfOAPdqCa9Uxdu60usplkxVCGl2lAhF6QZOdLWIjERQA7vDLeINPZy/5ERe7Wc
	 ghiINRi89Td2t+djUJI7HVkMnXuK1rdp0d0YYVr2nHuJNC05bQejhStGEvFx6LEv4v
	 Q0foheq2svz+12OFi+UHX6I/M6rycHRVU+nwE7Bew/REJdDDUJFX4jYb42DVn24wgZ
	 Adw0Roiy4+syrE/ThlZQ2sCXbjShOe4cVpKtA73HBp9XxbgCtMQ6+9J8F7NCLPpp9Q
	 EzM7rlb9XVxGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE533809A07;
	Thu, 30 Apr 2026 03:25:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/2] Fix bugs and performance of kstack offset
 randomisation
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751952875.2274119.16398594062786998071.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:28 +0000
References: <20260303150840.3789438-1-ryan.roberts@arm.com>
In-Reply-To: <20260303150840.3789438-1-ryan.roberts@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-riscv@lists.infradead.org, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, kees@kernel.org,
 gustavoars@kernel.org, arnd@arndb.de, mark.rutland@arm.com, Jason@zx2c4.com,
 ardb@kernel.org, jeremy.linton@arm.com, david.laight.linux@gmail.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org
X-Rspamd-Queue-Id: 3CA3D49CF97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19221-lists,linux-s390=lfdr.de,linux-riscv];
	FREEMAIL_CC(0.00)[lists.infradead.org,arm.com,kernel.org,linux.ibm.com,ellerman.id.au,dabbelt.com,eecs.berkeley.edu,linutronix.de,redhat.com,alien8.de,linux.intel.com,arndb.de,zx2c4.com,gmail.com,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to riscv/linux.git (fixes)
by Kees Cook <kees@kernel.org>:

On Tue,  3 Mar 2026 15:08:37 +0000 you wrote:
> [Kees; I'm hoping this is now good-to-go via your hardening tree? It would be
> good to get some linux-next testing.]
> 
> Hi All,
> 
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.
> 
> [...]

Here is the summary with links:
  - [v5,1/2] randomize_kstack: Maintain kstack_offset per task
    https://git.kernel.org/riscv/c/37beb4256016
  - [v5,2/2] randomize_kstack: Unify random source across arches
    https://git.kernel.org/riscv/c/a96ef5848cb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



