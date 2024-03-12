Return-Path: <linux-s390+bounces-2484-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB069878CA9
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 03:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1681A282610
	for <lists+linux-s390@lfdr.de>; Tue, 12 Mar 2024 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E1C17F7;
	Tue, 12 Mar 2024 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K+ELwexk"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D1C2E
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208908; cv=none; b=TQB1TpqCjqLjVPJJK8pvzMalzuDdhY+drGez0cgbKRLHGoRK9HbupAnH7KHM0Sae7slOn8JMnT2xY2+Oe/F8bM5YndfxVf1eTNf4sM+yc38KP6X6s8ZN1ojV9N9egTS+HcD3R1gEHCRD7NXnHCQ6F6cRv1Kh7q3+A5pJiTvY+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208908; c=relaxed/simple;
	bh=qIQnV/bIS0K3Bxk7jAUmTdn9bktpADBevzDPd5urYgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hsl7ZxEwCs85BZ0zolIC1RFUCrt+DDUGo812756FuBfcDDVPWJQXFWbPewovtacTetwBzPchOBM76suQoamWfUx5PRQ+5zyhKihogxYSe0IgLhx1Voage418sQ8OIYW4zHdBA92Kttzq+WvKjv6GBi7Cq5LSoe4cJiquZdMIiGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K+ELwexk; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29b73427790so3256274a91.3
        for <linux-s390@vger.kernel.org>; Mon, 11 Mar 2024 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1710208905; x=1710813705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04korNn+ptS1gdtp9bjAZOdgzha5IIX0Ncig6I/SdC8=;
        b=K+ELwexktRzT2UrvHjg6Moug/Lxy42rFN4CJd9tC7oT9NYeCpyi2xNFeWnrmxHT0Ds
         tPY8o8tpDNcE0F8EWpc5JnKqRMAOogdZkfZ7mOJOxg5U3HBCYCPULpekk/4IQxVa4NE9
         fdmL6IkIzoFyLeCmkHMNM3t234kbH0C70bpxm9frQnD0dDq5h2rC/cjhTcVFFv3ls6Tz
         XObTbxzW5ZjgBc6aEREei970TVct+4HNpaOr3ntrjpvyT4yQPuVXZrT95ajQLdTcXODX
         jnZn5abVjuvcLRZo/UHT7LGl3kfaRSBtu6G6HNFwOWSgiWLaFKq1uFuUEPirzU87mPbi
         JalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710208905; x=1710813705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04korNn+ptS1gdtp9bjAZOdgzha5IIX0Ncig6I/SdC8=;
        b=O/KPvSyyEf28s9ckKkVR9GMJMAWn2hcaXVXshtgHHBwruHF6VxLnjOKwFy+LHlTABB
         BVJ2bNkteGn5/HGKcAKeujzPvlQ97Pjd3MspHEXBdnvN+fskZOt93To/AMj3lwaRCbpz
         HihGXsXdPngtwB8WuKfaJzfBOEccvdnrCsu6McuXCJaghGdz+t2dgbMFkRO8IoJlo5sE
         AZX2X/HzAfzFUKkRxzUY/eOIG+E39hwU8t+bL5Bgoe2vQn7dLPhU/S4wr40U935pcp8l
         HbazL+6De9/wvNs14XSCdShmxiR1Q2nsqbH/ixy07aZukzg1Rr3cm2NJGFy1JQGbzX8z
         EcGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWp7au8DN4RvTPyne8UBCOLlTY9HgjYI/y1zFg30a6wiNoFwrqUGm+UNsxJYxUEmrrTthxL/7YBqoVUxkd7Pqdud/6M5LfzgtmQag==
X-Gm-Message-State: AOJu0YxJUnptUeWufR29Ibc6HYg/5aDEbUBGFPPR/Yg+ARU2+RXcaXO7
	MeC8C76QY/DlFSBQTIeMcSwlmFm5Df0bcBbUzGYe2NjFR6w+P/2mumBZgDsFRkSQkjfFunMwxfk
	hj/1m1EEpcMcnkc1y0ZEFneNUYfGjcA5vkjDZ2w==
X-Google-Smtp-Source: AGHT+IFU9d58jLiUu+dw8DkQB5XXLOOej/TsY11ssdad2M5fQNKdmpNs98xYJ42I4OgsPLsEE36ekbfce1jUks2RugY=
X-Received: by 2002:a17:90a:df11:b0:29b:b0c1:60cd with SMTP id
 gp17-20020a17090adf1100b0029bb0c160cdmr6423688pjb.23.1710208905551; Mon, 11
 Mar 2024 19:01:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311093526.1010158-1-dongmenglong.8@bytedance.com>
 <20240311093526.1010158-2-dongmenglong.8@bytedance.com> <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
In-Reply-To: <CAADnVQKQPS5NcvEouH4JqZ2fKgQAC+LtcwhX9iXYoiEkF_M94Q@mail.gmail.com>
From: =?UTF-8?B?5qKm6b6Z6JGj?= <dongmenglong.8@bytedance.com>
Date: Tue, 12 Mar 2024 10:01:34 +0800
Message-ID: <CALz3k9i5G5wWi+rtvHPwVLOUAXVMCiU_8QUZs87TEYgR_0wpPA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH bpf-next v2 1/9] bpf: tracing: add support
 to record and check the accessed args
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

On Tue, Mar 12, 2024 at 9:46=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2024 at 2:34=E2=80=AFAM Menglong Dong
> <dongmenglong.8@bytedance.com> wrote:
> >
> > In this commit, we add the 'accessed_args' field to struct bpf_prog_aux=
,
> > which is used to record the accessed index of the function args in
> > btf_ctx_access().
> >
> > Meanwhile, we add the function btf_check_func_part_match() to compare t=
he
> > accessed function args of two function prototype. This function will be
> > used in the following commit.
> >
> > Signed-off-by: Menglong Dong <dongmenglong.8@bytedance.com>
> > ---
> >  include/linux/bpf.h |   4 ++
> >  kernel/bpf/btf.c    | 108 +++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 110 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 95e07673cdc1..0f677fdcfcc7 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1461,6 +1461,7 @@ struct bpf_prog_aux {
> >         const struct btf_type *attach_func_proto;
> >         /* function name for valid attach_btf_id */
> >         const char *attach_func_name;
> > +       u64 accessed_args;
> >         struct bpf_prog **func;
> >         void *jit_data; /* JIT specific data. arch dependent */
> >         struct bpf_jit_poke_descriptor *poke_tab;
> > @@ -2565,6 +2566,9 @@ struct bpf_reg_state;
> >  int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog);
> >  int btf_check_type_match(struct bpf_verifier_log *log, const struct bp=
f_prog *prog,
> >                          struct btf *btf, const struct btf_type *t);
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*t1,
> > +                             struct btf *btf2, const struct btf_type *=
t2,
> > +                             u64 func_args);
> >  const char *btf_find_decl_tag_value(const struct btf *btf, const struc=
t btf_type *pt,
> >                                     int comp_idx, const char *tag_key);
> >  int btf_find_next_decl_tag(const struct btf *btf, const struct btf_typ=
e *pt,
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 170d017e8e4a..c2a0299d4358 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -6125,19 +6125,24 @@ static bool is_int_ptr(struct btf *btf, const s=
truct btf_type *t)
> >  }
> >
> >  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *fun=
c_proto,
> > -                          int off)
> > +                          int off, int *aligned_idx)
> >  {
> >         const struct btf_param *args;
> >         const struct btf_type *t;
> >         u32 offset =3D 0, nr_args;
> >         int i;
> >
> > +       if (aligned_idx)
> > +               *aligned_idx =3D -ENOENT;
> > +
> >         if (!func_proto)
> >                 return off / 8;
> >
> >         nr_args =3D btf_type_vlen(func_proto);
> >         args =3D (const struct btf_param *)(func_proto + 1);
> >         for (i =3D 0; i < nr_args; i++) {
> > +               if (aligned_idx && offset =3D=3D off)
> > +                       *aligned_idx =3D i;
> >                 t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> >                 offset +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8=
);
> >                 if (off < offset)
> > @@ -6207,7 +6212,7 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                         tname, off);
> >                 return false;
> >         }
> > -       arg =3D get_ctx_arg_idx(btf, t, off);
> > +       arg =3D get_ctx_arg_idx(btf, t, off, NULL);
> >         args =3D (const struct btf_param *)(t + 1);
> >         /* if (t =3D=3D NULL) Fall back to default BPF prog with
> >          * MAX_BPF_FUNC_REG_ARGS u64 arguments.
> > @@ -6217,6 +6222,9 @@ bool btf_ctx_access(int off, int size, enum bpf_a=
ccess_type type,
> >                 /* skip first 'void *__data' argument in btf_trace_##na=
me typedef */
> >                 args++;
> >                 nr_args--;
> > +               prog->aux->accessed_args |=3D (1 << (arg + 1));
> > +       } else {
> > +               prog->aux->accessed_args |=3D (1 << arg);
>
> What do you need this aligned_idx for ?
> I'd expect that above "accessed_args |=3D (1 << arg);" is enough.
>

Which aligned_idx? No aligned_idx in the btf_ctx_access(), and
aligned_idx is only used in the btf_check_func_part_match().

In the btf_check_func_part_match(), I need to compare the
t1->args[i] and t2->args[j], which have the same offset. And
the aligned_idx is to find the "j" according to the offset of
t1->args[i].

> >         }
> >
> >         if (arg > nr_args) {
> > @@ -7024,6 +7032,102 @@ int btf_check_type_match(struct bpf_verifier_lo=
g *log, const struct bpf_prog *pr
> >         return btf_check_func_type_match(log, btf1, t1, btf2, t2);
> >  }
> >
> > +static u32 get_ctx_arg_total_size(struct btf *btf, const struct btf_ty=
pe *t)
> > +{
> > +       const struct btf_param *args;
> > +       u32 size =3D 0, nr_args;
> > +       int i;
> > +
> > +       nr_args =3D btf_type_vlen(t);
> > +       args =3D (const struct btf_param *)(t + 1);
> > +       for (i =3D 0; i < nr_args; i++) {
> > +               t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > +               size +=3D btf_type_is_ptr(t) ? 8 : roundup(t->size, 8);
> > +       }
> > +
> > +       return size;
> > +}
> > +
> > +/* This function is similar to btf_check_func_type_match(), except tha=
t it
> > + * only compare some function args of the function prototype t1 and t2=
.
> > + */
> > +int btf_check_func_part_match(struct btf *btf1, const struct btf_type =
*func1,
> > +                             struct btf *btf2, const struct btf_type *=
func2,
> > +                             u64 func_args)
>
> This is way too much copy paste.
> Please share the code with btf_check_func_type_match.

Okay!

Thanks!
Menglong Dong

