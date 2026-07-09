Return-Path: <linux-s390+bounces-21898-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Zxz2Ne1jT2pAfwIAu9opvQ
	(envelope-from <linux-s390+bounces-21898-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 11:03:41 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21F72EA53
	for <lists+linux-s390@lfdr.de>; Thu, 09 Jul 2026 11:03:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21898-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21898-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71EB930B7508
	for <lists+linux-s390@lfdr.de>; Thu,  9 Jul 2026 08:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A873E4C7F;
	Thu,  9 Jul 2026 08:48:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706843E3DAB
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 08:48:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586917; cv=none; b=I6XmFAnsJVnKY4fuRQDBQxyNAT8HFX19VhG8vc3y3hdCDp1KkVFBxhAjBNnaLfrkVEYYYHuzO8dDzyQbf3l4GpfP1bI4O2sLaPdd7hZmGd/zzC/fV0O8jETcGsy/YRlxLLOqE1Z+IP+Vy1p2fohz5lpTcZEXHHTg6+oesE8WRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586917; c=relaxed/simple;
	bh=vcIYcFn8wOu64JToHCd3V3ghUBsco6aWxPDuriYHfZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEVD4SBRjmU11lCJKu4CvFKNvu7Cz/9vQDFcxkNTlcegtGxdzflc3mC8NniF7xNY4zi7+yQFIPHjTq5YiME1M2NeJQRsw8qLm0+dQA/ov0hOi8YmMaR1G3urag0adGCSN1T7CxXIOcz73cR3920V37/GX8etOwLW8uDa+F/8H84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso1361379a91.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 01:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783586916; x=1784191716;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=O3mkBNkViagFAJs3obyg41kBlrTMtmvpPUP/R2gZOPo=;
        b=b0a55rY1v1W6CLUrmnqUrr4M763vfbaT+WyuvORgFlMuztTMs/tgHjgw+3i6zwaSn3
         fvMu5Fla/UcfPQRJUcQ0IlMfZE9koB08k45K4Da0/EqEe1koB0rJnWIabV439Ke4zOmE
         ibtDNOA7op+ayj4YojzxZAy9qSTPlvqTcw4b2rZytnsy/hcJEqhXbqsns9RHjhytkGD3
         Wqg8W4IvtyPhF+8J0XBAM5nQOsQHkwhH6KLRX7GFE8/ZK1xz0nM3ckSURhd/30GEGFWs
         ch2fcKOpci3nRYcufnwyv/tXhLYrWqpr5TnaGHR6Gpw27BDuX9Mr/5GZwwbbyW+F2je9
         h/9A==
X-Forwarded-Encrypted: i=1; AHgh+RoOkO5o6SpzeBEbF4u48dfB8CV+EO1wiPhzjaYZsWBIU0FHSH0/ddhhnfcZds4vwq39HvAwupiCfHfI@vger.kernel.org
X-Gm-Message-State: AOJu0YwuS7BrABVZxYcpNl/PMlKCCqlMUYrbt8zaHlsnJnWC5MCkRTWx
	9AeL/+czF1Ryh0iozi7wsLmXNG5d4i2iRmty+vKUU17KbqFMTPbTjzxvSOfsENqlmBE=
X-Gm-Gg: AfdE7cmixh0GAYON373UO4PJ9WTGRHwi4GI+zL+wupikOiZLefAB4fdRdBEHWDJQmYW
	Z1vK3L5rDmxbhwM0gFxx8TMSpSIHIXvqIGZIOQzmhtuzxo72K40Ynp1n7tTenK9nD2BMArOwrVk
	0/bWuR7LnuYKt2QaVSAIpgco5eLnEkiVKQcTa0Pa8jitGSQ4ImJuptC8CPYmqvPsX6KRv95yiS6
	dOq6o1uOPJBsoDbE9R12HJcDvkx9JJ2WFVMK8jXwT4zv4G2kcZfj8lQZjlIpNhuOvlEKQLRNudQ
	ZInpBOu7FtrCWcK4sSxhoQM/O/TIkp9abQT+zp/4sEc+vaAmCZ5pZDuX7ecBMUqFskLc2nE0kBy
	TOuqQ1tgfm4QH8Bougiq/O+9vxCFMOCQqErcNq0baxM3EyKaNtlvlX7TfE11oLPKUWqg5DNlMhe
	+DEVqEN476M+KikBw5TyquFyKEbcMTwUE7ZdHeuZcko0d4wkfpPECYWg==
X-Received: by 2002:a17:90b:2d0e:b0:37e:2053:348f with SMTP id 98e67ed59e1d1-38941dbcbf8mr6277342a91.25.1783586915743;
        Thu, 09 Jul 2026 01:48:35 -0700 (PDT)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com. [209.85.210.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e40sm40444185ad.75.2026.07.09.01.48.35
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 01:48:35 -0700 (PDT)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-848643382fcso147077b3a.1
        for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 01:48:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpJbElKUfjnqSynkyVKRkdVGEDv9fv4qLtTuD4QhnmIp+k0V0b/WnL3fOPBlZvFzA8G0rnzFB9zRcFo@vger.kernel.org
X-Received: by 2002:a05:6102:6895:b0:738:9dd5:9b03 with SMTP id
 ada2fe7eead31-744e03a337dmr3306957137.20.1783586528282; Thu, 09 Jul 2026
 01:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707181957.433213175@kernel.org> <20260707190254.280015701@kernel.org>
In-Reply-To: <20260707190254.280015701@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 9 Jul 2026 10:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
X-Gm-Features: AUfX_mw8w2Kp5VuAYozzfDNS6gDbdKhQdYzfXsv-G72F3LS58UBytbGwOmplITc
Message-ID: <CAMuHMdWe1D0CZrav5h6EhDDbeJzgJcHvT89jrs6109Bdj-pdTw@mail.gmail.com>
Subject: Re: [patch 12/18] ptrace, treewide: Rename ptrace_report_syscall_entry()
 to ptrace_report_syscall_permit_entry()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>, 
	Richard Henderson <richard.henderson@linaro.org>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Helge Deller <deller@gmx.de>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Chris Zankel <chris@zankel.net>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	Michael Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, Kees Cook <kees@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, x86@kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Jinjie Ruan <ruanjinjie@huawei.com>, 
	Andy Lutomirski <luto@kernel.org>, Richard Weinberger <richard@nod.at>, =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21898-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,infradead.org,arndb.de,redhat.com,linaro.org,kernel.org,armlinux.org.uk,arm.com,monstr.eu,alpha.franken.de,gmx.de,users.sourceforge.jp,davemloft.net,gaisler.com,zankel.net,lists.infradead.org,lists.linux-m68k.org,ellerman.id.au,linux.ibm.com,lists.ozlabs.org,lists.linux.dev,dabbelt.com,huawei.com,nod.at,suse.de,lwn.net];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:linux-kernel@vger.kernel.org,m:peterz@infradead.org,m:arnd@arndb.de,m:oleg@redhat.com,m:richard.henderson@linaro.org,m:vgupta@kernel.org,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:guoren@kernel.org,m:bcain@kernel.org,m:monstr@monstr.eu,m:tsbogend@alpha.franken.de,m:dinguyen@kernel.org,m:deller@gmx.de,m:ysato@users.sourceforge.jp,m:davem@davemloft.net,m:andreas@gaisler.com,m:chris@zankel.net,m:linux-alpha@vger.kernel.org,m:linux-snps-arc@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:linux-csky@vger.kernel.org,m:linux-hexagon@vger.kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linux-mips@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-parisc@vger.kernel.org,m:linux-sh@vger.kernel.org,m:sparclinux@vger.kernel.org,m:linux-um@lists.infradead.org,m:linux-arch@vger.kernel.org,m:mpe@ellerman.id.au,m:sshegde@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:kees@kernel.org,m:chenhuacai@kernel.org,m:l
 oongarch@lists.linux.dev,m:pjw@kernel.org,m:palmer@dabbelt.com,m:linux-riscv@lists.infradead.org,m:svens@linux.ibm.com,m:linux-s390@vger.kernel.org,m:x86@kernel.org,m:mark.rutland@arm.com,m:ruanjinjie@huawei.com,m:luto@kernel.org,m:richard@nod.at,m:msuchanek@suse.de,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[52];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux-m68k.org:from_mime,linux-m68k.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A21F72EA53

On Tue, 7 Jul 2026 at 21:06, Thomas Gleixner <tglx@kernel.org> wrote:
> The return value of that function is boolean and tells the caller whether
> to permit the syscall processing or not.
>
> Rename the function so the purpose is clear and make the return type bool.

>  arch/m68k/kernel/ptrace.c       |    2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

