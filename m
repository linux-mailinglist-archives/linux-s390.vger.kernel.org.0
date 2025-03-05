Return-Path: <linux-s390+bounces-9355-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0565CA50059
	for <lists+linux-s390@lfdr.de>; Wed,  5 Mar 2025 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B05B3AFC22
	for <lists+linux-s390@lfdr.de>; Wed,  5 Mar 2025 13:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9424BC05;
	Wed,  5 Mar 2025 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bQnGzWp1"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E224BC18
	for <linux-s390@vger.kernel.org>; Wed,  5 Mar 2025 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180361; cv=none; b=tSFM4G2fzTH25V2Ft+PmS0isjOzBO5F/GmvNR7JvjST/cWDwxVOEb5yIKSLzdm/QhwajfNRNcUY9DQwoqauFBzrmBGma6Ta7YDMHp7U29VIeotO5Qwu4IMkquuMNo/y/WQeszP3tmf3WKhBgKSjBiCmU2znp5TtxFQUkiLVCGFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180361; c=relaxed/simple;
	bh=niOkZ3yknjy6O15SgZEu1bTRkBCDN86QkzY45J5nUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPY9N4XtNzh7UgsHN/NLgFG0EVRX8ZG6KaSUCdpkLLL8D/eiGUmvFm5gl6jUblTuEyxOxGqqPA+TgvyndugQRX9e6/PV1FboC4O8gBYeoAwwizyZ4Tw+6+xzC5WHwXeu6Rm9p3tLmUXnTyaQDNi+aXO8XhPdLDCGgAj80nfXrvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bQnGzWp1; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-474e1b8c935so265581cf.0
        for <linux-s390@vger.kernel.org>; Wed, 05 Mar 2025 05:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741180358; x=1741785158; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iOdrgfnKDo0adnIeWCzGbGdt+czcdG3OGWY151PLQj4=;
        b=bQnGzWp1S5Lnz9b7S+X9iWyT1enphmYxyeyJwj5VVMYJnObuLGzhvMkG9uBL3XQ78b
         Zo3JrmBI4ko2x+OO+iOQpQBqfBgjcS472wlJfVY900sBa3almRwnfbIdcWBcdXKwsieo
         7k0oWhWF732whbIyH4GNsIMNo9o7b80aqltg+jU0O65LkiOSm3+oSVpH3YoRptaQnRij
         NWBaZfEqos2npnT6v52bnbTpKCy19r6KPYKzleLdok7ZrEkR9SnnqDT5T6ABVfKQ+2Iz
         NKN7Fajx9PPEYnKJdu5XQV9dDUNkJGUpIwD5ACAowRHjrTqUH64V59DpzL+Y1S7JzlY8
         4rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741180358; x=1741785158;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOdrgfnKDo0adnIeWCzGbGdt+czcdG3OGWY151PLQj4=;
        b=GyEpnhAl0Iv9KOEhK+yEqsrykmpl1GI3pfday/4aL1KL6ccTj51uk8+ASBuCcJdQ1r
         Dry9xaYrXAplJXoA7ZwfpnI6+YSGYarTXdHfR4qKxjA+Ia1VC6gHXPblxvjeFahwbhrz
         2Sgav69F/8bKl5vsJe/8rP1J0RChgI+TxcPVayafCqFk4HCEPS/0MJKt2Ac+1xNy8dKj
         NMMqOaSnOYyE3kuAInJtobGPufOpu+zmUn31CMFaYZADsGIlVue7nPGcB6UfvfDD8s/G
         oLaI1LiVHHL/Oil7uVTOPVSspFVcS3f3zb86OMY1WNaleG9KnIG0KcJC7mWnowMZD3/s
         8pSA==
X-Forwarded-Encrypted: i=1; AJvYcCV7lOXVi0+Bc2aFFwXHITdVpjStyvh8vApQdvTtoLTkykZ3Nwxkxqg/kUw5VddVCN8gmGC4FQQOFxMM@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6OzgFrL+/BIw2h5UNpVrFZTpPd0dvXaUyMqeF7GcjEizPKzgP
	Ap9X/XQTzCoyEj1+YUzxAR+L+FMtCEBtiNSBGaVeqBLoK7sI+k+pNSvhFq4+4hsVIhbZxcBcnrv
	Sx+MqqjYdQnw8fhybZ0GVQXy6U7DO5QiDKyzR
X-Gm-Gg: ASbGncsdpXC4fFm3yznKIhroybTtH92ibdKGUw5b5p1cNHddZWhFfsjAP9R+CtO4eyj
	x2OXcVw9ph182pnbuMmXX76/LSByb6t8y44UV1pRLgwY4qPtwStGnxvPI7nzybixEHAkK2CRG8s
	15jSK9DAxIupvhVOUDYLugEEDgiTHRvbNZkZyPyHxvCkyVxP8zBTyROl4Q
X-Google-Smtp-Source: AGHT+IFIn6b7M1PNu9NZZ9KBzOuRO4deZPOixhL9M73rMvQkDHUtfUtYPha+8DdwHlmaLHcT+urAybKKpNAnQK1YFdU=
X-Received: by 2002:a05:622a:110b:b0:471:f560:27dc with SMTP id
 d75a77b69052e-4750cae2127mr2406081cf.27.1741180357471; Wed, 05 Mar 2025
 05:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
 <20250110-asi-rfc-v2-v2-2-8419288bc805@google.com> <Z8K2B3WJoICVbDj3@kernel.org>
In-Reply-To: <Z8K2B3WJoICVbDj3@kernel.org>
From: Brendan Jackman <jackmanb@google.com>
Date: Wed, 5 Mar 2025 14:12:25 +0100
X-Gm-Features: AQ5f1JrEWoe__i5J-gwzMxiuWZ9pJYk4XLPMWAQuPYUSu5vOhjZQNejm22RSyYE
Message-ID: <CA+i-1C06Sunj0BmFON=MbWBK6ZDt_=K4P3BHChRBYyxXqEkQ2g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 02/29] x86: Create CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
To: Mike Rapoport <rppt@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Junaid Shahid <junaids@google.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, Mar 01, 2025 at 09:23:51AM +0200, Mike Rapoport wrote:
> Hi Brendan,
>
> On Fri, Jan 10, 2025 at 06:40:28PM +0000, Brendan Jackman wrote:
> > Currently a nop config. Keeping as a separate commit for easy review of
> > the boring bits. Later commits will use and enable this new config.
> >
> > This config is only added for non-UML x86_64 as other architectures do
> > not yet have pending implementations. It also has somewhat artificial
> > dependencies on !PARAVIRT and !KASAN which are explained in the Kconfig
> > file.
> >
> > Co-developed-by: Junaid Shahid <junaids@google.com>
> > Signed-off-by: Junaid Shahid <junaids@google.com>
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> > ---
> >  arch/alpha/include/asm/Kbuild      |  1 +
> >  arch/arc/include/asm/Kbuild        |  1 +
> >  arch/arm/include/asm/Kbuild        |  1 +
> >  arch/arm64/include/asm/Kbuild      |  1 +
> >  arch/csky/include/asm/Kbuild       |  1 +
> >  arch/hexagon/include/asm/Kbuild    |  1 +
> >  arch/loongarch/include/asm/Kbuild  |  3 +++
> >  arch/m68k/include/asm/Kbuild       |  1 +
> >  arch/microblaze/include/asm/Kbuild |  1 +
> >  arch/mips/include/asm/Kbuild       |  1 +
> >  arch/nios2/include/asm/Kbuild      |  1 +
> >  arch/openrisc/include/asm/Kbuild   |  1 +
> >  arch/parisc/include/asm/Kbuild     |  1 +
> >  arch/powerpc/include/asm/Kbuild    |  1 +
> >  arch/riscv/include/asm/Kbuild      |  1 +
> >  arch/s390/include/asm/Kbuild       |  1 +
> >  arch/sh/include/asm/Kbuild         |  1 +
> >  arch/sparc/include/asm/Kbuild      |  1 +
> >  arch/um/include/asm/Kbuild         |  2 +-
> >  arch/x86/Kconfig                   | 14 ++++++++++++++
> >  arch/xtensa/include/asm/Kbuild     |  1 +
> >  include/asm-generic/asi.h          |  5 +++++
> >  22 files changed, 41 insertions(+), 1 deletion(-)
>
> I don't think this all is needed. You can put asi.h with stubs used outside
> of arch/x86 in include/linux and save you the hassle of updating every
> architecture.

...

> If you expect other architectures might implement ASI the config would better
> fit into init/Kconfig or mm/Kconfig and in arch/x86/Kconfig will define
> ARCH_HAS_MITIGATION_ADDRESS_SPACE_ISOLATION.

...

> > +++ b/include/asm-generic/asi.h
> > @@ -0,0 +1,5 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ASM_GENERIC_ASI_H
> > +#define __ASM_GENERIC_ASI_H
> > +
> > +#endif
>
> IMHO it should be include/linux/asi.h, with something like
>
> #infdef __LINUX_ASI_H
> #define __LINUX_ASI_H
>
> #ifdef CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION
>
> #include <asm/asi.h>
>
> #else /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
>
> /* stubs for functions used outside arch/ */
>
> #endif /* CONFIG_MITIGATION_ADDRESS_SPACE_ISOLATION */
>
> #endif /* __LINUX_ASI_H */

Thanks Mike! That does indeed look way tidier. I'll try to adopt it.

