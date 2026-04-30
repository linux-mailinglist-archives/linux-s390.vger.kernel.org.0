Return-Path: <linux-s390+bounces-19219-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAZ/NB3M8mmWuQEAu9opvQ
	(envelope-from <linux-s390+bounces-19219-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 05:27:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE06349CDA4
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 05:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B571300C3BA
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 03:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8653334C155;
	Thu, 30 Apr 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oK4W1kKQ"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEC134B404;
	Thu, 30 Apr 2026 03:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777519547; cv=none; b=VuuMeyqCgYPPcRpQ6nNWnod1SYwYfBKvIQXakkLOb7R1EXP1wJWFryuSvu/sOkvkSB7gCw4K35l09SC8WFjO/MYQG331kKgmCB9ON6VJiPIJxeK/32qpwlsd65alYR5EgGWh2ANDMX520SSnLW12C/D6Qwqej8FF5oKAux3NwcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777519547; c=relaxed/simple;
	bh=dFN6b0A1gSAjmpxBdfCzLd7sjLkkLRUt90cBNTEzJS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s3zNbQUqbFTWu6vaPiiGlleeRQiQ+Hje4Z6wPUPYFFW/PeZrvrRL3xWjcPkBcvZIdbhBLntPLnupBxn5KrCCEaZe5yQYqX894dht+JqqtCkGfafGzuoGFWYvRMN8qZqBzdsMLCCfxWEMtC0WqnCZoPd0hYSgalpvxsLG8Cgpkdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oK4W1kKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE62C2BCB9;
	Thu, 30 Apr 2026 03:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777519547;
	bh=dFN6b0A1gSAjmpxBdfCzLd7sjLkkLRUt90cBNTEzJS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oK4W1kKQ5frD7xBp2Peo4k+zymjuUiJnLNz1vcnh5EFW4Atm0o1eacKZFX3kxsdMB
	 Z/9Bybkbt3e4DSKls2D0XjOElY/uAFwJmkXI/D33yiz2mgpn1fh1pHq8wwtdcupk2H
	 lxsRxcmcLT6uUAPcxQs3YzTqZheDJf8qP4uhFGhGgLv/DTlHLkFL3nUxAt6MFMm3Wn
	 udAWzPlFVeqX0qf5lNmUGifS42MtZaKyGgO3cIqnJJYyJsJWf51lM0MqpG8QFB2ry2
	 1jlaoCGMchkNV4IFNSmAKO5kJWwGEnpPKMc5ZEWOTjjRj0oKTos1CMGgTRvfcPXQMF
	 j0NI9CkIJOSPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDA63809A07;
	Thu, 30 Apr 2026 03:25:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE and
 cleanup CONFIG_MIGRATION
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <177751950193.2274119.6306882784421764696.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 03:25:01 +0000
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
In-Reply-To: <20260319-config_migration-v1-0-42270124966f@kernel.org>
To: David Hildenbrand (Arm) <david@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
 kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, akpm@linux-foundation.org, ljs@kernel.org,
 Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, ziy@nvidia.com, matthew.brost@intel.com,
 joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
 gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
X-Rspamd-Queue-Id: DE06349CDA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,linux-foundation.org,oracle.com,google.com,suse.com,nvidia.com,intel.com,sk.com,gourry.net,linux.alibaba.com,linutronix.de,goodmis.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-19219-lists,linux-s390=lfdr.de,linux-riscv];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Thu, 19 Mar 2026 09:19:39 +0100 you wrote:
> While working on memory hotplug code cleanups, I realized that
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE is not really required anymore.
> 
> Changing that revealed some rather nasty looking CONFIG_MIGRATION
> handling.
> 
> Let's clean that up by introducing a dedicated CONFIG_NUMA_MIGRATION
> option and reducing the dependencies that CONFIG_MIGRATION has.
> 
> [...]

Here is the summary with links:
  - [1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
    https://git.kernel.org/riscv/c/078f80f909ba
  - [2/2] mm: introduce CONFIG_NUMA_MIGRATION and simplify CONFIG_MIGRATION
    https://git.kernel.org/riscv/c/6ebf98d71f9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



