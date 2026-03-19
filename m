Return-Path: <linux-s390+bounces-17674-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOeaAQUBvGmurAIAu9opvQ
	(envelope-from <linux-s390+bounces-17674-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:58:29 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172F2CC49A
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 14:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 257E6301025B
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8820E2DA749;
	Thu, 19 Mar 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nquVz4we"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB12C1780
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928706; cv=none; b=ZiNd7Fgf+/hS8c4CSAI6Q9YamAFXTAEV4M5bsV7IHlSkj3oMIOxNbSbeVeaaRA4t8TxtqsoCE98HN8JNZsacvD+MRzoiY/qrlnr5okQGRg5OygA5HyFCPn4/vAavu5JJcP5YXgaMaRrGPsCfRAfSdaeutauwnh8SL++hIEaj6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928706; c=relaxed/simple;
	bh=vVMhOhWZVSxPZj7h/gXJPr3MbzsLXumfcz/WsvzXiiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vu+LrbgnEiwuN+Hnky8KgKCROgolggmdvRAgzuq0OXYrFlu/kj7AXcgH9yUpteo1FG1a16WhkdG1QgWlSTtvlz+ajfHg8m38fGZbhDC5nwJ7NsLvz8W7S0uTCaCzOSTwRsuwk6EJ8E/hg2sQvFbEofdAsg5Oj1+JMh3rb1lzsuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nquVz4we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01614C2BCB7
	for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 13:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773928706;
	bh=vVMhOhWZVSxPZj7h/gXJPr3MbzsLXumfcz/WsvzXiiw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nquVz4wePYQWwp++fkGjsQ/zzhCXcFg1E5jkD/ap2qU6BcDWf2G7O9/h3Xjc3KqoR
	 xZOoxAU/EYR1SbobsB2b1KL10UFdLSBPMUWn+2ubwG9QrJWzb8iUOawUPp++lB32az
	 wxcKCXi1YYaSK+e6pU6zFQ1paLVB5TBs7XNOiM/v2VtkgxQdF5XCI+Fg6AWnkCzCRW
	 3/XDtYwAFF48icMzoqOzYzLukR0VGddABOWBecgCNp1fCf/BIHX/sI+dJPaPUXfKzZ
	 UVN6yWHPxvDB+0E61av3DphnUilQvG4gn1XF6SgykuUPRqci/ei+ewvrOBKQK1aCdY
	 qLBdT43iQpCJw==
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a7109f568so11060557b3.1
        for <linux-s390@vger.kernel.org>; Thu, 19 Mar 2026 06:58:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgBmLoY+MvFMGkDWVBqa8ZbSaNZVl4asrQt6ecpXvtVCteGcAz3Z/6KB5Ur9rex3rf4MLgBQCHUpQ3@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7b2SsRTiC3O09OCT/x63md4rfWfq/m095bnoPXw6VkSLMJS09
	qCSiuOCllFfenm2NgfqeagUqoM0+Tk6qjvwX7jLXkGU0Ie4LPHMLFdiMKuF+7Z+bS6G2PJ/yAvZ
	yXYo6HumJSgVhCsM58rn6l4axz+LuVqQ=
X-Received: by 2002:a05:690c:8e07:b0:79a:3d7f:e8f6 with SMTP id
 00721157ae682-79a7183077emr59279997b3.5.1773928705112; Thu, 19 Mar 2026
 06:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260317082020.737779-1-ruanjinjie@huawei.com> <20260317082020.737779-4-ruanjinjie@huawei.com>
In-Reply-To: <20260317082020.737779-4-ruanjinjie@huawei.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Mar 2026 14:58:12 +0100
X-Gmail-Original-Message-ID: <CAD++jLm3We3Bx4s0BQ4vSX==YKsBw81mtzDV4vnP+cK3ZFp5rg@mail.gmail.com>
X-Gm-Features: AaiRm52iu4yIzLq9nfoEu1nkVquuu7rND0JnY3PWtoDRG8G2aTchcsb5vToiAw8
Message-ID: <CAD++jLm3We3Bx4s0BQ4vSX==YKsBw81mtzDV4vnP+cK3ZFp5rg@mail.gmail.com>
Subject: Re: [PATCH v13 RESEND 03/14] arm64/ptrace: Expand secure_computing()
 in place
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-17674-lists,linux-s390=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[54];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,arm.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7172F2CC49A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 9:20=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:

> Refactor syscall_trace_enter() by open-coding the seccomp check
> to align with the generic entry framework.
>
> [Background]
> The generic entry implementation expands the seccomp check in-place
> instead of using the secure_computing() wrapper. It directly tests
> SYSCALL_WORK_SECCOMP and calls the underlying __secure_computing()
> function to handle syscall filtering.
>
> [Changes]
> 1. Open-code seccomp check:
>    - Instead of calling the secure_computing() wrapper, explicitly check
>      the 'flags' parameter for _TIF_SECCOMP.
>    - Call __secure_computing() directly if the flag is set.
>
> 2. Refine return value handling:
>    - Use 'return ret ? : syscall' to propagate the return value.
>    - Ensures any unexpected non-zero return from __secure_computing()
>      is properly propagated is properly propagated.
>    - This matches the logic in the generic entry code.
>
> [Why this matters]
> - Aligns the arm64 syscall path with the generic entry implementation,
>   simplifying future migration to the generic entry framework.
> - No functional changes are intended; seccomp behavior remains identical.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

