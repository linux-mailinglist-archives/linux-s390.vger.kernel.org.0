Return-Path: <linux-s390+bounces-21326-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UCfWHKRnQ2rdXwoAu9opvQ
	(envelope-from <linux-s390+bounces-21326-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 08:52:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B99576E0E5C
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 08:52:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gQbUHPxh;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21326-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21326-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35101301325A
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2026 06:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB1392C4F;
	Tue, 30 Jun 2026 06:48:18 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8926392C25
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 06:48:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802098; cv=none; b=To9rO02+JRIx9QJ4eIORKV1cdXYzL9l9pXmbm/w/ViAja1h8b8PpmHKHia8d3J3wyU24sRP8QbbwLvt6CgBCm5cF463Ii768seVkaaGkA6GKIR/JxArqFLtQkHqnmNUrC6R5HMcbfyfZNzOyvR+xigePMthndR6v6VtRM4VWpR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802098; c=relaxed/simple;
	bh=HH7V0RO+G10+WPRVyC1TrQpVHHN/W20mERyQs529ODk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1AN1VlQFpxEsSfxk7jb/DX4wNvcEvKRM4z1JTumLvDXDo5pVspjHxToMdsCIG+nh1ImMslbj8gJY9BJPxyf90FqBYhm7EWVJiYcrP347Wa1rLFsBbDpRgAUck6vQNHAHHyO2WVN4a34nrnkKy1urMHrYJhWuLkHkbpe+hcG8Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQbUHPxh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AE01F000E9
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782802094;
	bh=GmOeYBnH+pucvx3tPfeJ0XPPeaBlbElUu+Q/ZIKymgM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gQbUHPxhEiH2raHpZIN6oBRl9E+1UD3QUNT2Fw4BPeFQ+WDHDN+zFU6PwALsNMK05
	 2WjNlTS+FoMmA2fr/tFjj4GhPIvIc9cC2METu1pc6GLfvit78DT+DLQV/gs1JE0hbt
	 fgb31zwcDdQo31BoonXIRM6Fq/apx7UcxVtwwsvPyNwkqB88Yh/LevTtxWfRLdoZMZ
	 rGXNGVVtUgJi44UaN8zODBgy2aNOsaQGrrILL7pUJP5D7qUzL9mSiRR3za3IxR1s/f
	 4WmaLujPY3xb+FTws1zpYt90YJaXS77LpBoqsRjCJKuubo6YxPtNvlspKmDadlCY35
	 LSZgNK5KCJ5eg==
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-475881b9a4bso453606f8f.3
        for <linux-s390@vger.kernel.org>; Mon, 29 Jun 2026 23:48:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rok/VVY2UDsb0atD4RwxbmhGys3aLN1jUcfaZ8L1AX1/z8Kea/it19KGIa9qBmwfFNRQW38CMUYz6Qd@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOl7mP3SsdS8h79KTDNYf2Xl8Zju43rnWjBupiXu+1m9C2nFP
	Or8aSrj84d6d2l2RJCqoYLLxQvwA3uBPwRBUnsshz9sF6mXV7vXl6/Qqw4w4gGKTgiwqmghTcgD
	WL81NoI2ATN2uT6FEk8k2hRWYyORcuoU=
X-Received: by 2002:a5d:5d06:0:b0:475:f100:3600 with SMTP id
 ffacd0b85a97d-475f100372fmr683383f8f.61.1782802093102; Mon, 29 Jun 2026
 23:48:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630045531.3939-1-kprateek.nayak@amd.com> <20260630045531.3939-5-kprateek.nayak@amd.com>
In-Reply-To: <20260630045531.3939-5-kprateek.nayak@amd.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 30 Jun 2026 14:47:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTi3EJj7NrOEZ0GF21VxfyUFujnaGbRmLuYy1_YcPkbDw@mail.gmail.com>
X-Gm-Features: AVVi8Cc9p7eoaCe7f58H6IC6apx1iBlYENd1M3Ce4o3oou9E96K3mWDK4f0IxWE
Message-ID: <CAJF2gTTi3EJj7NrOEZ0GF21VxfyUFujnaGbRmLuYy1_YcPkbDw@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] riscv/runtime-const: Replace open-coded
 placeholder with RUNTIME_MAGIC
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Samuel Holland <samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>, 
	Jisheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21326-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kprateek.nayak@amd.com,m:arnd@arndb.de,m:tglx@kernel.org,m:mingo@redhat.com,m:peterz@infradead.org,m:bigeasy@linutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:dvhart@infradead.org,m:dave@stgolabs.net,m:andrealmeid@igalia.com,m:linux-arch@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samuel.holland@sifive.com,m:thecharlesjenkins@gmail.com,m:linux-arm-kernel@lists.infradead.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:alex@ghiti.fr,m:jszhang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[guoren@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,redhat.com,infradead.org,linutronix.de,dabbelt.com,eecs.berkeley.edu,stgolabs.net,igalia.com,vger.kernel.org,sifive.com,gmail.com,lists.infradead.org,ghiti.fr];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guoren@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B99576E0E5C

On Tue, Jun 30, 2026 at 12:57=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Define the placeholder used for lui + addi[w] patching sequence as
> RUNTIME_MAGIC and use that instead of open coding the constants in the
> inline assembly.
>
> No functional changes intended.
>
> Suggested-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v4..v5:
>
> o Collected tags from Charlie (Thanks a ton!)
> ---
>  arch/riscv/include/asm/runtime-const.h | 38 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/=
asm/runtime-const.h
> index 900db0a103d05..1ce02605d2e43 100644
> --- a/arch/riscv/include/asm/runtime-const.h
> +++ b/arch/riscv/include/asm/runtime-const.h
> @@ -15,21 +15,23 @@
>
>  #include <linux/uaccess.h>
>
> +#define RUNTIME_MAGIC __ASM_STR(0x89ABCDEF)
> +
>  #ifdef CONFIG_32BIT
> -#define runtime_const_ptr(sym)                                 \
> -({                                                             \
> -       typeof(sym) __ret;                                      \
> -       asm_inline(".option push\n\t"                           \
> -               ".option norvc\n\t"                             \
> -               "1:\t"                                          \
> -               "lui    %[__ret],0x89abd\n\t"                   \
> -               "addi   %[__ret],%[__ret],-0x211\n\t"           \
> -               ".option pop\n\t"                               \
> -               ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"   \
> -               ".long 1b - .\n\t"                              \
> -               ".popsection"                                   \
> -               : [__ret] "=3Dr" (__ret));                        \
> -       __ret;                                                  \
> +#define runtime_const_ptr(sym)                                         \
> +({                                                                     \
> +       typeof(sym) __ret;                                              \
> +       asm_inline(".option push\n\t"                                   \
> +               ".option norvc\n\t"                                     \
> +               "1:\t"                                                  \
> +               "lui    %[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +               "addi   %[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t" \
> +               ".option pop\n\t"                                       \
> +               ".pushsection runtime_ptr_" #sym ",\"a\"\n\t"           \
> +               ".long 1b - .\n\t"                                      \
> +               ".popsection"                                           \
> +               : [__ret] "=3Dr" (__ret));                               =
 \
> +       __ret;                                                          \
>  })
>  #else
>  /*
> @@ -46,10 +48,10 @@
>         ".option push\n\t"                                      \
>         ".option norvc\n\t"                                     \
>         "1:\t"                                                  \
> -       "lui    %[__ret],0x89abd\n\t"                           \
> -       "lui    %[__tmp],0x1234\n\t"                            \
> -       "addiw  %[__ret],%[__ret],-0x211\n\t"                   \
> -       "addiw  %[__tmp],%[__tmp],0x567\n\t"                    \
> +       "lui    %[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +       "lui    %[__tmp], %%hi(" RUNTIME_MAGIC ")\n\t"          \
> +       "addiw  %[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t" \
> +       "addiw  %[__tmp],%[__tmp], %%lo(" RUNTIME_MAGIC ")\n\t" \
LGTM!

Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren

