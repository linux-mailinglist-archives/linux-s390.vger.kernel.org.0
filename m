Return-Path: <linux-s390+bounces-2497-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5CD878D6B
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 04:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39C02281DCB
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 03:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196BCAD32;
	Tue, 12 Mar 2024 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lMRi1qrI"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3713C944D
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213244; cv=none; b=PZkjun2ej8Pi7TNqgPE0nEd+OF4rsArDV0ZPU8dkJvgVG7QTWklYFG3qYcOesv0IKhGo84s04CjcDwRrxYaU/5XmEo1y+h9XbUmiZJzrYQtx0XQrHxuUGaMydlLS71MPujL7uITzFUGKSJLIPxOxiJcLpmxaUsN2yWfB8stA8nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213244; c=relaxed/simple;
	bh=rT7M/hhiO9hEYBPUu40z7VC7HSNxO+QXlUEwZKhhsYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkHbD8rbm746duGTQu5Wyl2ZvgEOMuIfgqucfcPDuDtG5N81qQPR6NmSRSVgR92x0fcvncpxswkEA++diEYqiQVqEfqLPlGh2jnnTwqe8mZe9GQTQB1jL8RY4FcF6rUMAcoyI46pjPwXztbhLjEpvwZ4A4H5jwy9k50ArFGITL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lMRi1qrI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so2250417a91.2
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 20:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710213241; x=1710818041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXlf8eE/kb9hUjEHRg6KiaZYrPX7zppIuDOk01qdNjA=;
        b=lMRi1qrIRCns0bPtlKM0A/k5itTFpHl1DuVkHVNCT46WSmj7nS4EwljQKQXCbnJEFw
         gTbZxAf6O3KNGvO+R0soX1XV6i71rwXQ2Hvv+yZ9vCbWXfp4voNJjqCUviAF0NW2hjKK
         V4SjhNPWs58kLY/j7A80yZNSbLEUTDT+ZdG7BvvPa+qk746DYrrtup4eybnQy/RMTfdw
         3FdGAcMsJRLSAABGojCYnl09fdXYyzVVoatY9TcNgSikiUNd3ivtCs/SmPTmUOZN3QYj
         OynyxIF+ERdZXYtThelNKm/YnAzPCOFgpVDzcnfZJVAsjRV0rwbDc44PLeGqI0uhQ06e
         1Iqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710213241; x=1710818041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXlf8eE/kb9hUjEHRg6KiaZYrPX7zppIuDOk01qdNjA=;
        b=oPRlAgM5JfOc8liAG4tYiP6WPU5u3p00Gxj+S2gU7LRRBuFQ/G/wiLqQ3YcjBCaYzl
         AYyx5MM+P2aHcqC0gW3rlTqQ+IbIEV+avT+CISAPhRT7q2SoIYl92dsrzuAscbH1mwxb
         uIGGlJCx8EzL7L4ISdRh1vT9bTQB7ieQ6uZZTrQ+Zt4ep7NYPrkjbR3/Pc03+opbL6uw
         0dfIf1/7/aGfxarqM26r+192EtsJQYo68/pk4UQlwIpEAulNcELBCxwlcYiq0IXRW2NI
         hBU+AjAhzDF77ELk39qg22ml1oIVF3XyPozP2gHvJz64wxu0AvT4ZLnIU1EqPoij8szf
         JrmA==
X-Forwarded-Encrypted: i=1; AJvYcCUiwCo/EWPkPiQlitrvFDWVZFlkC9I5GvOL/pEbUVmoN/6Cn1k1s9ATHMtELeiR2ONjmeguuHMcAMkxJ0+jThZzkPFwVzRtMv+y1w==
X-Gm-Message-State: AOJu0YxyDeOWeiECprGNOaapvMihqmDjkBLBKuns9Q6avjiUCxtY5Jyk
	dHMDKcM6FGoNlQdEWJWBPN9FdKV0s/HtqsGNYW7m+GVe7A89WH1pxMRqFE8hAK7mVEayPAvYj3N
	41/k+CxNgp9LI9I21uskjCmjX/BpJTLeOQY5aIA==
X-Google-Smtp-Source: AGHT+IFrJd1b6cRe3N1bdjRPMDm6UQYIWuBJWFP813OtCjwvKtB/NBwZvIOHJ5+UKRNsfrlwra9CEE8kwZK9x+jxh4c=
X-Received: by 2002:a17:90a:c684:b0:299:5b95:cd7d with SMTP id
 n4-20020a17090ac68400b002995b95cd7dmr5190887pjt.45.1710213241618; Mon, 11 Mar
 2024 20:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-6-dongmenglong.8@bytedance.com> <CAADnVQKw4HUbwvivysVBQPpA2MC2e56MwrvJy89qs8rx_ixOnw@mail.gmail.com>
In-Reply-To: <CAADnVQKw4HUbwvivysVBQPpA2MC2e56MwrvJy89qs8rx_ixOnw@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 11:13:50 +0800
Message-ID: <CALz3k9iiP5msNtL5c0ZhwRoYyEZtxZoWGbFiPrVcL3To6hj4wQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 5/9] bpf: verifier: add btf to
 the function args of bpf_check_attach_target
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	X86 ML <x86@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Quentin Monnet <quentin@isovalent.com>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-riscv <linux-riscv@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, linux-trace-kernel@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 9:51=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:35=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > Add target btf to the function args of bpf_check_attach_target(), then
> > the caller can specify the btf to check.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  include/linux/bpf_verifier.h | 1 +
> >  kernel/bpf/syscall.c         | 6 ++++--
> >  kernel/bpf/trampoline.c      | 1 +
> >  kernel/bpf/verifier.c        | 8 +++++---
> >  4 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index 4b0f6600e499..6cb20efcfac3 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
> > @@ -811,6 +811,7 @@ static inline void bpf_trampoline_unpack_key(u64 ke=
y, u32 *obj_id, u32 *btf_id)
> >  int bpf_check_attach_target(struct bpf_verifier_log *log,
> >                             const struct bpf_prog *prog,
> >                             const struct bpf_prog *tgt_prog,
> > +                           struct btf *btf,
> >                             u32 btf_id,
> >                             struct bpf_attach_target_info *tgt_info);
> >  void bpf_free_kfunc_btf_tab(struct bpf_kfunc_btf_tab *tab);
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index d1cd645ef9ac..6128c3131141 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -3401,9 +3401,11 @@ static int bpf_tracing_prog_attach(struct bpf_pr=
og *prog,
> >                  * need a new trampoline and a check for compatibility
> >                  */
> >                 struct bpf_attach_target_info tgt_info =3D {};
> > +               struct btf *btf;
> >
> > -               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, b=
tf_id,
> > -                                             &tgt_info);
> > +               btf =3D tgt_prog ? tgt_prog->aux->btf : prog->aux->atta=
ch_btf;
>
> I think it's better to keep this bit inside bpf_check_attach_target(),
> since a lot of other code in there is working with if (tgt_prog) ...
> so if the caller messes up passing tgt_prog->aux->btf with tgt_prog
> the bug will be difficult to debug.

In the previous version, I pass the attach_btf with the following
way:

+            origin_btf =3D prog->aux->attach_btf;
+             /* use the new attach_btf to check the target */
+             prog->aux->attach_btf =3D attach_btf;
              err =3D bpf_check_attach_target(NULL, prog, tgt_prog, btf_id,
                                            &tgt_info);
+             prog->aux->attach_btf =3D origin_btf;

And Jiri suggested to add the attach_btf to the function args
of bpf_check_attach_target().

Ennn....Should I convert to the old way?

Thanks!
Menglong Dong

>
> > +               err =3D bpf_check_attach_target(NULL, prog, tgt_prog, b=
tf,
> > +                                             btf_id, &tgt_info);

