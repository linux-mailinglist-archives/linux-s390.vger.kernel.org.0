Return-Path: <linux-s390+bounces-415-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75C780A74E
	for <lists+linux-s390@lfdr.de>; Fri,  8 Dec 2023 16:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F00941C208E3
	for <lists+linux-s390@lfdr.de>; Fri,  8 Dec 2023 15:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D430337;
	Fri,  8 Dec 2023 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aMIRCreY"
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27185FB
	for <linux-s390@vger.kernel.org>; Fri,  8 Dec 2023 07:26:23 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67aa00ea853so12397106d6.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Dec 2023 07:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702049182; x=1702653982; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fmveRht4WTP9VCfRGY2TlBDNiNt4nqiRyGovDc1Drhw=;
        b=aMIRCreY4ebtSeY0kuQfq/myxA8NG1/q9ulVo+sy+stLhCK+0g21pM/oW+mXxiyaPH
         euIZ89cc/WUx5YyxRBoawfCZ860qQ08RYlBZytEYMUudTBY4FNW2/Ju3JUc3/8LybZFX
         PrBUC3ee9CwFbQ78QNKWmeVcA0rt8APAt26Y7oj+IypxMD5yPtAp5+FIQyfCX8Fh2oLq
         f39dD6e1sDbB0g9oaz7QP2jI4f9k6bxEZ8qKLDMRO02qzGJwzlDVTkKvzZoHIFPIKP7m
         mqgl3JrQJ35e3zR9peAkFumSVix0iZepCWZAgcTzrj6zm41jv6cQAZbJVUs6Ct9DhbpY
         JtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702049182; x=1702653982;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmveRht4WTP9VCfRGY2TlBDNiNt4nqiRyGovDc1Drhw=;
        b=chqTF1jnwUZHRXa5S2nHVUOPZj02O3EiUPY6ySjcqSQzCYlNl6rnGiw3q6cC/3rJEl
         WjaVLQz2WDw995bF0M1P8Zst+G12QIG0jvwkxhEz81BqxUm6d7r0vBuSpPODpQ/V072A
         AcJgUUgcOHV+x3eu/0FqWbx//lt1iP452dcFKvoe9o/+uj1lqDC96LDmpz49Ij5M1HI6
         Mu7F4tAfKiH5ihKDnZ4NfH+xByHgRIyCCmb/toDdXKbqP5TXR/TPtEraoCv6fjXiXkYC
         fq3JEt3KSRMn1uXyNCD/e0fkxFZKZOr4MJszHagy3NR9D01NLEGa//qck+Zz9lhBrxIG
         IgeQ==
X-Gm-Message-State: AOJu0YwoCIWozr2YkNOl3L+6YoMOC1aDeA+UTtzACUd0dUJJjaReRm9J
	qwfqSYElcCk+ULf5HUOz4q/Edci6JVnfWmyw6WtgsQ==
X-Google-Smtp-Source: AGHT+IFQWMwRSduRWrugzZXzhW4SP5JgRv6bQmddI9L+WLPciJYPF9LKHJS1ct3eyxJlLmbNonEC+PpCF/NYvyZxUy8=
X-Received: by 2002:ad4:52eb:0:b0:67a:a721:82f8 with SMTP id
 p11-20020ad452eb000000b0067aa72182f8mr105489qvu.82.1702049182002; Fri, 08 Dec
 2023 07:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121220155.1217090-1-iii@linux.ibm.com> <20231121220155.1217090-14-iii@linux.ibm.com>
 <CAG_fn=Vaj3hTRAMxUwofpSMPhFBOizDOWR_An-V9qLNQv-suYw@mail.gmail.com> <69e7bc8e8c8a38c429a793e991e0509cb97a53e1.camel@linux.ibm.com>
In-Reply-To: <69e7bc8e8c8a38c429a793e991e0509cb97a53e1.camel@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 8 Dec 2023 16:25:41 +0100
Message-ID: <CAG_fn=UbJ+z8Gmfjodu-jBQz75HApXADw8Abj38BCLHmY_ZW9w@mail.gmail.com>
Subject: Re: [PATCH v2 13/33] kmsan: Introduce memset_no_sanitize_memory()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

> A problem with __memset() is that, at least for me, it always ends
> up being a call. There is a use case where we need to write only 1
> byte, so I thought that introducing a call there (when compiling
> without KMSAN) would be unacceptable.

Wonder what happens with that use case if we e.g. build with fortify-source.
Calling memset() for a single byte might be indicating the code is not hot.

> > ...
> >
> > > +__no_sanitize_memory
> > > +static inline void *memset_no_sanitize_memory(void *s, int c,
> > > size_t n)
> > > +{
> > > +       return memset(s, c, n);
> > > +}
> >
> > I think depending on the compiler optimizations this might end up
> > being a call to normal memset, that would still change the shadow
> > bytes.
>
> Interesting, do you have some specific scenario in mind? I vaguely
> remember that in the past there were cases when sanitizer annotations
> were lost after inlining, but I thought they were sorted out?

Sanitizer annotations are indeed lost after inlining, and we cannot do
much about that.
They are implemented using function attributes, and if a function
dissolves after inlining, we cannot possibly know which instructions
belonged to it.

Consider the following example (also available at
https://godbolt.org/z/5r7817G8e):

==================================
void *kmalloc(int size);

__attribute__((no_sanitize("kernel-memory")))
__attribute__((always_inline))
static void *memset_nosanitize(void *s, int c, int n) {
  return __builtin_memset(s, c, n);
}

void *do_something_nosanitize(int size) {
  void *ptr = kmalloc(size);
  memset_nosanitize(ptr, 0, size);
  return ptr;
}

void *do_something_sanitize(int size) {
  void *ptr = kmalloc(size);
  __builtin_memset(ptr, 0, size);
  return ptr;
}
==================================

If memset_nosanitize() has __attribute__((always_inline)), the
compiler generates the same LLVM IR calling __msan_memset() for both
do_something_nosanitize() and do_something_sanitize().
If we comment out this attribute, do_something_nosanitize() calls
memset_nosanitize(), which doesn't have the sanitize_memory attribute.

But even now __builtin_memset() is still calling __msan_memset(),
because __attribute__((no_sanitize("kernel-memory"))) somewhat
counterintuitively still preserves some instrumentation (see
include/linux/compiler-clang.h for details).
Replacing __attribute__((no_sanitize("kernel-memory"))) with
__attribute__((disable_sanitizer_instrumentation)) fixes this
situation:

define internal fastcc noundef ptr @memset_nosanitize(void*, int,
int)(ptr noundef returned writeonly %s, i32 noundef %n) unnamed_addr
#2 {
entry:
%conv = sext i32 %n to i64
tail call void @llvm.memset.p0.i64(ptr align 1 %s, i8 0, i64 %conv, i1 false)
ret ptr %s
}

>
> And, in any case, if this were to happen, would not it be considered a
> compiler bug that needs fixing there, and not in the kernel?

As stated above, I don't think this is more or less working as intended.
If we really want the ability to inline __memset(), we could transform
it into memset() in non-sanitizer builds, but perhaps having a call is
also acceptable?

