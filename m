Return-Path: <linux-s390+bounces-17671-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG4XEKP+u2mzqwIAu9opvQ
	(envelope-from <linux-s390+bounces-17671-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:48:19 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB82CC2C9
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 579923013FD8
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358DD2848AA;
	Thu, 19 Mar 2026 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJfBrRJ8"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3EB2DB799
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928085; cv=none; b=Y6kwIo8KsqHW1Pk5+E0rhIGscaPu+QznQX2ZCDVeX6H5wfrMa3SPjLMvylS0I32ImiuODWd3JFWrTr/onn1kH9re4ecpfHOo63SjlSVNRxXjQPlIWgL4LUo3z9ifqkV4asbgHEcyFekVAOu8VA8/ohU1/TVbiuYvbgfLU5SPIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928085; c=relaxed/simple;
	bh=QOJle0HAErcuAk1B1GgrI2OCaaOFq04voQ/vijiMH9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUeWODHNVLT1kfdO1c7rms+2pF0LK7fO3aj5tp7SwWxYPURZJYsfolp+aFF2o5uiCjJ7QRpOyWpNRZlCcNiRuI9Ci5YBSwDiCTut9ZfT2Y3Nsj+dygArfltCMYUI43/kMLIew6QlVFUiKR+qF72EyRNrezSxK+K0peQnRlBWGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJfBrRJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840CEC2BCFA
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928085;
	bh=QOJle0HAErcuAk1B1GgrI2OCaaOFq04voQ/vijiMH9Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KJfBrRJ8sbFD3zMucjkhepLRMBdph3OktdEDcyFOVTXeM4G8ZT2NnK0Q3aOvuVzYa
	 EohsHAGYO61CRJXeh1yVgHA3aLrHZBs0Bcixk+IUqO+mwrT+1iyxQqZ2z66egbbLMU
	 P8hKWXA2iSqbRAZBe1hXdAI5cQ1yMZQ4cgP4Pt4rcrtg77ugCe4yyeo3/UKC1JfeF/
	 cxxndBaoFJoKXbaD5srTgfCVfzvhMSDeJkBzgC56sLuDx+fBr8yNVn4SdEtBQCIcaU
	 tEj+w/85QKFFNswve+Wp5aDVg+k0RGA1pcNxcNVfv3TBe5XZnC1hNcdaGiebRDFCmI
	 TUF3sXcB1e9ZQ==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-797ab169454so11269847b3.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 06:48:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+969qPMQXldhv8QcTmfAxDweYnhKFWNg9JGgrSOQQYoYXZZx4jWM0Sy6AHje6QtXRrHzJ9SQQXf/F@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3MlyPUqPO/02HbKNHWBDf43m/dRdIs5H/Ml/ADQYB81a6fCb7
	4kWzuMbx2lhyRqBLr07+Hg/PZRipMdn9PFpmRSluydKF5okN/2+xUKBFPWJyKTr5BdRxmho9Doc
	nn5yR/1pamkJJvbptIgM4XZeGiuvbHQM=
X-Received: by 2002:a05:690c:ed6:b0:79a:47b4:397b with SMTP id
 00721157ae682-79a71c9679dmr78182707b3.57.1773928084138; Thu, 19 Mar 2026
 06:48:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-2-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-2-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:47:53 +0100
X-Gmail-Original-Message-ID: <CAD++jLnBpKm7Q0hjgkRMmivpYdzY8r1-FuQS=H3Km1G=mE1fTg@mail.gmail.com>
X-Gm-Features: AaiRm50KZNLEM2TEBH0s8s1elOG_LwkGWTvhDRRNnuvJQ3BSSvTT7GXQ8nkJRwA
Message-ID: <CAD++jLnBpKm7Q0hjgkRMmivpYdzY8r1-FuQS=H3Km1G=mE1fTg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 01/14] arm64/ptrace: Refactor
 syscall_trace_enter/exit() to accept flags parameter
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com, 
	svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, arnd@arndb.de, 
	peterz@infradead.org, luto@kernel.org, shuah@kernel.org, kees@kernel.org, 
	wad@chromium.org, kevin.brodsky@arm.com, deller@gmx.de, macro@orcam.me.uk, 
	akpm@linux-foundation.org, ldv@strace.io, anshuman.khandual@arm.com, 
	ryan.roberts@arm.com, mark.rutland@arm.com, thuth@redhat.com, song@kernel.org, 
	ada.coupriediaz@arm.com, broonie@kernel.org, pengcan@kylinos.cn, 
	liqiang01@kylinos.cn, ziyao@disroot.org, guanwentao@uniontech.com, 
	guoren@kernel.org, schuster.simon@siemens-energy.com, jremus@linux.ibm.com, 
	david@kernel.org, mathieu.desnoyers@efficios.com, edumazet@google.com, 
	kmal@cock.li, dvyukov@google.com, reddybalavignesh9979@gmail.com, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,redhat.com,xen0n.name,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,infradead.org,chromium.org,gmx.de,orcam.me.uk,linux-foundation.org,strace.io,kylinos.cn,disroot.org,uniontech.com,siemens-energy.com,efficios.com,google.com,cock.li,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-17671-lists,linux-s390=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 60FB82CC2C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Refactor syscall_trace_enter() and syscall_trace_exit() to move thread
> flag reading to the caller. This aligns arm64's syscall trace enter/exit
> function signature with generic entry framework.
>
> [Changes]
> 1. Function signature changes:
>    - syscall_trace_enter(regs) =E2=86=92 syscall_trace_enter(regs, flags)
>    - syscall_trace_exit(regs) =E2=86=92 syscall_trace_exit(regs, flags)
>
> 2. Move flags reading to caller:
>    - Previously: read_thread_flags() called inside each function.
>    - Now: caller (like el0_svc_common) passes flags as parameter.
>
> 3. Update syscall.c:
>    - el0_svc_common() now passes flags to tracing functions and
>      re-fetches flags before exit to handle potential TIF updates.
>
> [Why this matters]
> - Aligns arm64 with the generic entry interface.
> - Makes future migration to generic entry framework.
>
> No functional changes intended.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

