Return-Path: <linux-s390+bounces-19213-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA+LKHl18mkHrgEAu9opvQ
	(envelope-from <linux-s390+bounces-19213-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 23:17:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4449A825
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 23:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1A8F301BF69
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 21:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5736E3A9DAE;
	Wed, 29 Apr 2026 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBceHZMd"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3450F3612D8;
	Wed, 29 Apr 2026 21:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497439; cv=none; b=sEdy33JUKwP9NCqGVJsyFWMExEKPGYZwaGADY2Vfn5oCJksAt/EUmEZcfhjDry9Um7k+tZgKijJaN+4KRf8u6qVgGA4C2h3Cpacsbtcaz/FqXApjftc7NtFkBHYOMzq+Jal/OXwyFnQ16y7YQ1g57AFPO1RjXL6K0gsOncDGJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497439; c=relaxed/simple;
	bh=TdYyRj0HlGviy4I5wZGb57C9BaeXuPqFVgueod/dgKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqJwHFPA9Nzks578K06NIwCjKTrpIeG0KejpQXlS6/KzkwmQhcrmi/shGhqUIIg1DzhaxHaCW2R8QIaKW5E8130Lbj7L38Ia7Te/bFz+D/gHEzfxarRNanipM0VrT+j+ECLLhJDZsUYUfMH5VhvhN3LpbMsWAZSrt/xxNMfIoSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBceHZMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8F0C2BCB4;
	Wed, 29 Apr 2026 21:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777497438;
	bh=TdYyRj0HlGviy4I5wZGb57C9BaeXuPqFVgueod/dgKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LBceHZMd0eb0oRMr6V1OBqPnCT1BWkG0z6IfcxYo9bzwlf7+mPDWP5tkqFu+Skzql
	 /+f6rcxkCKx3MPg533htkjeIxtTGvtwdmnWPTiBN4JIlpMQGUaFvVaEEKgKQlGhzNo
	 vk/OszpRB2EFXTzqrGcYUyrWcBgZnE792RXn+WD47tvMaf3LymBH1mxobWXTDulRBQ
	 RCtPhN6o1fSoEJa9G+tkKFCLdIpbKykC1Q3jThk3z211lx2NgMJgyTVYwWuTJGUlgs
	 n3s0rz7mJOYZUYOi9cLaAaPK1ypxaNLXlavIOCHXZZpqhf/H9m/tETcSNgZahdYAVZ
	 tlEDB+mtdCZEA==
Date: Wed, 29 Apr 2026 14:17:17 -0700
From: Minchan Kim <minchan@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afJ1XUP4udSDyNJs@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
 <ae_dRZ95dCDTTxaQ@google.com>
 <afBbRUaGnE8WZIkY@tiehlicka>
 <afE2xchFRh2xARBn@google.com>
 <afHAi0E11D5sg_9y@tiehlicka>
 <CAJuCfpFxtbSXKabKd0G1i4WXWs2M4c4aDs4xTA0BNJB2e0P7Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFxtbSXKabKd0G1i4WXWs2M4c4aDs4xTA0BNJB2e0P7Lw@mail.gmail.com>
X-Rspamd-Queue-Id: 1FC4449A825
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_MATCH_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19213-lists,linux-s390=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minchan@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 01:01:21PM -0700, Suren Baghdasaryan wrote:
> On Wed, Apr 29, 2026 at 1:25 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 28-04-26 15:37:57, Minchan Kim wrote:
> > [...]
> > > >From be4bd22a100ed6be2d1d2599ddb9da04043143eb Mon Sep 17 00:00:00 2001
> > > From: Minchan Kim <minchan@kernel.org>
> > > Date: Fri, 24 Apr 2026 14:27:08 -0700
> > > Subject: [PATCH] mm: process_mrelease: introduce PROCESS_MRELEASE_REAP_KILL
> > >  flag
> > >
> > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > prior to invocation. This separation introduces a scheduling race window
> > > where the victim task may receive the signal and enter the exit path
> > > before the reaper can invoke process_mrelease().
> > >
> > > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > the mm's reference count drops to zero. In the field (e.g., Android),
> > > arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
> > > remote VM accesses) frequently delay this teardown indefinitely,
> > > defeating the purpose of expedited reclamation.
> > >
> > > In Android's LMKD scenarios, this delay keeps memory pressure high, forcing
> > > the system to unnecessarily kill additional innocent background apps before
> > > the memory from the first victim is recovered.
> > >
> > > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > > an integrated auto-kill mode. When specified, process_mrelease() directly
> > > injects a SIGKILL into the target task after finding its mm.
> > >
> > > To solve the race condition, we grab the mm reference via mmgrab() before
> > > sending the SIGKILL. If the user passed PROCESS_MRELEASE_REAP_KILL, we assume
> > > it will free its memory and proceed with reaping, making the logic as simple
> > > as reap = reap_kill || task_will_free_mem(p).
> > >
> > > To handle shared address spaces safely in the auto-kill mode, we bail out
> > > immediately if the mm is marked with MMF_MULTIPROCESS when
> > > PROCESS_MRELEASE_REAP_KILL is specified. This protects existing users of
> > > process_mrelease() from behavior changes while preventing unsafe reaping of
> > > shared memory.
> >
> > Please explain why this is a different behavior from the global oom
> > killer and how do you intend to deal with those mm shared process
> > groups. I am not saying this is a wrong behavior but it will be hard to
> > change once in place.
> >
> > > Fundamentally, this allows process_mrelease() to trigger targeted memory
> > > reclaim (via oom_reaper infrastructure) quickly, even if the victim is
> > > not yet in the exit path, while reusing existing race handling between
> > > reaper and exit_mmap.
> > >
> > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> >
> > Other than the above looks ok to me.
> 
> Implementation looks good to me. After addressing Michal's comment
> please split this patch from the series and feel free to add:
> 
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

I just posted v2 with your Reviewd-by.
https://lore.kernel.org/linux-mm/20260429211359.3829683-1-minchan@kernel.org/

Thanks, Suren.

