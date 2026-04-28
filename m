Return-Path: <linux-s390+bounces-19102-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDksKEaI8GnuUQEAu9opvQ
	(envelope-from <linux-s390+bounces-19102-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 28 Apr 2026 12:13:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4974825C4
	for <lists+linux-s390@lfdr.de>; Tue, 28 Apr 2026 12:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C7C73151E48
	for <lists+linux-s390@lfdr.de>; Tue, 28 Apr 2026 09:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB23A6416;
	Tue, 28 Apr 2026 09:31:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A983A5E9F
	for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 09:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368702; cv=none; b=P1xOZgM/yV9tHJ8YRwhy5qODVaY/UluDCDIHZ12TkrgzuHcgeqRa1uomzTEnqswz0fT+ixtGxAp+ZvyLKKvWRJI6FgxJ8RtlWfhWzW7g8XpAMyUmyhGO/M7wGsG1ZIaEXUdxlm/66JbxwId35WSs8+nzAnXKF69ADhkhBNanQq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368702; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twCWVm5WQaqztUqLmohuXP9T1yEWsp6vPhpJAT/f0tizQKXSoDjUYAHMulT/lhx5IgT1+q1O/6Zhfjs+bPb5NsYpYzpX4ytxVoDcCOT+oFTe02hXBd11L4pYW6tvJYEKDMTfvFxggPjo5FoqZ0TRkSpf6TgT2bBcSWPJs06F+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so312091266b.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 02:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368700; x=1777973500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=Fu8+AtDRkhU5mxYgZuslWPzv2njMGRTc883/pTx3qPr4tvnG+rWOZxUczDTMJAh8Yp
         7WOSoRoB7PpjFsK8o2d+VjYWc1//tqTzBeJuNZiGvOuR46EVJGeke2YWi5CpONkfbHWn
         iiIjOAbG2Lst79zoqyJ+ZN3KZ5RTq66hRsQTKQ8Ij0LMfwGFbb6mVaItCIoAuoq/z7Pj
         7oZj7ORa2cbbideig0X8BfeNU83Wt3u0H1tPBGACxut/Nh/AlW9/sMW9c6AVuw8i95GN
         IZy+EjG71WfMNn4NvQMmMBVjqUF5AipL9YKCg2APeQTK4qyDUYMYnKPHUwJK5e9d/EoF
         bXxA==
X-Forwarded-Encrypted: i=1; AFNElJ8XpK8t9GG1KiVPgNtBTDC7i1CTPnh3P+QvgyUNpJ8DCSfPjeDeKton/wopX52uagToWemPAGM7BTr5@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhfSvWtzummfeaQcgHVJjPBN6Blroje54KbAk3PtR8wlfr1h6
	aJh6VpuKoo9VXqEdoRzVr7SSeSZyX/K7ldShN9FhSI0G/Y2Z+5s9xxtp1inO+Eqe250=
X-Gm-Gg: AeBDieupZ6CgbpqE2k+u14MHdouuN3eneFIjiDrPqHfbIJtq2CfVR5d4+gjhLQUekQx
	Y8VCcvU3bI9QRBrNOZteeFi+215jPkPhmEIkGeyzPgRjYDjdB2bHZsY+QgrYyy3JGmtDLx/yB8Z
	ko/XGObqkd5gNaaepUm2k4rWT7PSnM+UKXD3KrCs8Cdk96vdK4ER8CEpx2wR5b9qERVzHzZB9nS
	NhT88gIoX09S2/PNtKON52v6RAP4XJBlPiPTvqQZXwmgncacHIyFcNRU6LHfMvHBvfrOn+aBJTu
	mVX3DXX/+b36yKaWqGe+NUglWlJN6dK8RoLNFAs5jlRdDMyPd0wMF8BYzI3VLhf2QXkBM9RW8Xc
	il4PheLBpecwfwcJ8jeemoFyTN8ratPjwls3OSV011SAoGtJMsfjIFe6zv8VSLtdSI0yGBSzGSB
	twWhlFlBFdVxgCnF/kpFvNdKBS6r4GMetBBupn+YxNFyp8/06KPwGkwj/MnR/wE2dw7MIfJI8=
X-Received: by 2002:a17:907:1c0d:b0:bad:f032:fc78 with SMTP id a640c23a62f3a-bb8020c94dcmr121726566b.1.1777368699709;
        Tue, 28 Apr 2026 02:31:39 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67cd14bsm535790a12.3.2026.04.28.02.31.39
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:31:39 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c01854477so766342266b.0
        for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 02:31:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ82XCEL9XKxSN7tJ/SGQYYfu6PUpVgUcS4ammK6kHChNL+P4jA2ZYTE6HUVWshYqWgptvkDEpRcb4Jk@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1A4974825C4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19102-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-s390@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.181];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

