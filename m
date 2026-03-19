Return-Path: <linux-s390+bounces-17688-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APDSALoHvGkArgIAu9opvQ
	(envelope-from <linux-s390+bounces-17688-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 15:27:06 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2B2CCC77
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 15:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0852303F520
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0C372B49;
	Thu, 19 Mar 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bi6xStSs"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B2371047
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930279; cv=none; b=qRToyhJAd6MsvPBz0NDpab45Bg6AjSc3CXvYmynmqUhP4Y8st/qJ+PkFtWdti76nk3Vv0C7+XT/OTagEfN8Rju58Lyvvo+wre8V1aYVitsH18F9083lnVLBH3FyD8QzobLJlw4gcWuskf0jTXp8Z9Tt2qB/7UX5d00V/IqIOHJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930279; c=relaxed/simple;
	bh=UIpJb5A/dypdfuXnKSbslk+MAu1nk1IiQDatRcbSjcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFMUJ1jgoCR2XoOhbG981+MLkFHCtyBUQRjtF3C4O1sadYoh0oODUxOMnlYf7j5hkMvX60Jl5kCI/ExLO0MYrl5VqVyWjU/lJ9CpwlrZpXq0QVstVEOtht+HI8I3IP+/6gZM7+JksIajrx778Lw0DQPTr2O9RsgEQQOUKPAaLLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bi6xStSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B05C4AF1C
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 14:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773930279;
	bh=UIpJb5A/dypdfuXnKSbslk+MAu1nk1IiQDatRcbSjcA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Bi6xStSsOkVDsKHqWjh2TPNXC9dp++2iSQkF3WQSZOaO/d+6zZKOtkVKfwP/YSe3j
	 x+qtxu+WKZf8vGobXAWvKOLEFOWG5e/SwKSxiTtX0v47iIS+Q0jx/DZ0qQhhkHXVuo
	 P9pbQIX0A5JE+AElliFy+hrpq18xRDr4/1FjDsPlukCW1eptWuiBx88FAs2DGfguT8
	 BH+ENVrt55L4igy6aHshZh4sp6ZxGAAKpfn3erL3QyqvDWY0CNUHwAko/9KMS42y5W
	 Ksh9htSHxo0LkawaPFB8wWim24uB3fCYPrl+69tGj0hvELFVuLVIt3LnLJDS9yQq8b
	 rBfSQvrJ/uMug==
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so1029829d50.3
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 07:24:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWIeHjXUqQoh6wpWWiCL8Kj9a5O4MtmjfpTMoDnOvtXpri18LjHzjZm5FmAx4v5IIRMilaBzsMwFDQy@vger.kernel.org
X-Gm-Message-State: AOJu0YznxIA7zemA7EKuwuBhQLwR4lpxbAVa9jh4F8L5rMQ1EXbtMZgy
	IkkS0Ea726Yn6OKiyP1HwFn8PiwzNcCR/+Xp/W52baCw3W8JR+yreGbzhX/Pyky1t+xFHVuywe9
	XAwidqHGjQ/gF6PFSlxOpK9d2euWCXfc=
X-Received: by 2002:a05:690c:6610:b0:798:2629:85d7 with SMTP id
 00721157ae682-79a7180421fmr66744337b3.9.1773930278111; Thu, 19 Mar 2026
 07:24:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-13-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-13-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 15:24:25 +0100
X-Gmail-Original-Message-ID: <CAD++jL=uLLde2goBVJV-K2Uk1qk27EJv=fUTBnYkzjWdxK7wdg@mail.gmail.com>
X-Gm-Features: AaiRm52z8Tcr54P3ccjUGqebkibONPOzdYt9lc8pcjtyoVeyFlpt1Cz8vWl6hoY
Message-ID: <CAD++jL=uLLde2goBVJV-K2Uk1qk27EJv=fUTBnYkzjWdxK7wdg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 12/14] asm-generic: Move TIF_SINGLESTEP to
 generic TIF bits
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,redhat.com,xen0n.name,linux.ibm.com,alien8.de,linux.intel.com,zytor.com,arndb.de,infradead.org,chromium.org,gmx.de,orcam.me.uk,linux-foundation.org,strace.io,kylinos.cn,disroot.org,uniontech.com,siemens-energy.com,efficios.com,google.com,cock.li,gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17688-lists,linux-s390=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A3D2B2CCC77
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Currently, x86, ARM64, s390, and LoongArch all define and use
> TIF_SINGLESTEP to track single-stepping state.
>
> Since this flag is shared across multiple major architectures and serves
> a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
> into the generic Thread Information Flags (TIF) infrastructure.
>
> This consolidation reduces architecture-specific boilerplate code and
> ensures consistency for generic features that rely on single-step
> state tracking.
>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

This is really neat, thanks for making the extra effort!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

