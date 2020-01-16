Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D115913D3E2
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jan 2020 06:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAPFr0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jan 2020 00:47:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45599 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgAPFr0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jan 2020 00:47:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id l14so8543237qvu.12
        for <linux-s390@vger.kernel.org>; Wed, 15 Jan 2020 21:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wF6ZZgDVBcb52vVymB/toV0bmt4NnNtZaybtThqWt40=;
        b=v1YrVzVa4Zzjsgt637Qe0HM6Xn41Q5W2zqxf4mPJEuTp0l1nAvwlKClLpyb5D/CBcA
         8NCAJE9CN/BSq4o/6otLEVFLNn9Bhn6ahFXO57tw38Yd1Ol85l53AncNwRbWSbKytAC1
         uxVMWaex3MEIE2fTigcGKmU4OdZdIEhQrQYFxj3cpfHIYfGZzYFF3oGMO4+7NPyjoD67
         tu+MSoyCGprhj6/AwDcn7g3/d+efCc70b0hW8KULyvS93wdW+fZMerU5Er5tyg7XKZwi
         n0uTkfRjwjV0ZP9YD0HggMrhXw0By1p7gEzuCBdhjBQK3ulxD5qAqwhjwLq5d4sR1qLt
         L3Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wF6ZZgDVBcb52vVymB/toV0bmt4NnNtZaybtThqWt40=;
        b=tCBE3g99HyQBt7NeIqcWZqXa/OZZNPZBG6vP4oQpHjv0d3zJiVhYfFUP7dqAXyPrbG
         RwyugMfN/eIavBIjPM+47IyUf7q8AxNfqmdXUuLEQRTBJIHvMsP6XocynCcdStXqel5D
         4tt2+vgq4dW1PKXgcoUj7UJQDckD32BLl0YFrBeu3IaVaz3mOjCT//cE+2nrYNZIb3ie
         mCUGairlzJ4kS7frPKub2M6EDN/sSsC/9WYWGohOohelh31brtt/UYNgS3fesPyY3Oyc
         dvqFQPcIFCIKqOT1b8B7UOjrpHB2XCQ48Y6y1HanQTGUXm2IOckzdN0oHf/IE7czEz7e
         3OMw==
X-Gm-Message-State: APjAAAXW9sAWp5/WjRflCKI/logEawCz3YC02yTurutEU/+XayzbDRIp
        qdlK5tGZrXbsebXI094CeU2mbjJ1tWvlAnaFhdwPcw==
X-Google-Smtp-Source: APXvYqxEwEwdGaOISrJ5MbJbhuMgu3oBOqwYp04LFOpjVtmcydWOGxsmFZzklEs59N7lf80jKFMdYKn24xtY22LLf08=
X-Received: by 2002:a0c:c351:: with SMTP id j17mr1025368qvi.80.1579153644733;
 Wed, 15 Jan 2020 21:47:24 -0800 (PST)
MIME-Version: 1.0
References: <20200115063710.15796-1-dja@axtens.net> <20200115063710.15796-3-dja@axtens.net>
 <CACT4Y+bxh1OmV64Z-EZrYk-otW9q_fxiHnvrE_VMYj-=YAk2Bg@mail.gmail.com> <8736cgkndh.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <8736cgkndh.fsf@dja-thinkpad.axtens.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 06:47:13 +0100
Message-ID: <CACT4Y+Z7Fs1tzaECX_oT5VX05vPAehnfsR-m6P2uVtDACm7w8w@mail.gmail.com>
Subject: Re: [PATCH 2/2] string.h: fix incompatibility between FORTIFY_SOURCE
 and KASAN
To:     Daniel Axtens <dja@axtens.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jan 16, 2020 at 5:59 AM Daniel Axtens <dja@axtens.net> wrote:
>
> Dmitry Vyukov <dvyukov@google.com> writes:
>
> > On Wed, Jan 15, 2020 at 7:37 AM Daniel Axtens <dja@axtens.net> wrote:
> >>
> >> The memcmp KASAN self-test fails on a kernel with both KASAN and
> >> FORTIFY_SOURCE.
> >>
> >> When FORTIFY_SOURCE is on, a number of functions are replaced with
> >> fortified versions, which attempt to check the sizes of the operands.
> >> However, these functions often directly invoke __builtin_foo() once they
> >> have performed the fortify check. Using __builtins may bypass KASAN
> >> checks if the compiler decides to inline it's own implementation as
> >> sequence of instructions, rather than emit a function call that goes out
> >> to a KASAN-instrumented implementation.
> >>
> >> Why is only memcmp affected?
> >> ============================
> >>
> >> Of the string and string-like functions that kasan_test tests, only memcmp
> >> is replaced by an inline sequence of instructions in my testing on x86 with
> >> gcc version 9.2.1 20191008 (Ubuntu 9.2.1-9ubuntu2).
> >>
> >> I believe this is due to compiler heuristics. For example, if I annotate
> >> kmalloc calls with the alloc_size annotation (and disable some fortify
> >> compile-time checking!), the compiler will replace every memset except the
> >> one in kmalloc_uaf_memset with inline instructions. (I have some WIP
> >> patches to add this annotation.)
> >>
> >> Does this affect other functions in string.h?
> >> =============================================
> >>
> >> Yes. Anything that uses __builtin_* rather than __real_* could be
> >> affected. This looks like:
> >>
> >>  - strncpy
> >>  - strcat
> >>  - strlen
> >>  - strlcpy maybe, under some circumstances?
> >>  - strncat under some circumstances
> >>  - memset
> >>  - memcpy
> >>  - memmove
> >>  - memcmp (as noted)
> >>  - memchr
> >>  - strcpy
> >>
> >> Whether a function call is emitted always depends on the compiler. Most
> >> bugs should get caught by FORTIFY_SOURCE, but the missed memcmp test shows
> >> that this is not always the case.
> >>
> >> Isn't FORTIFY_SOURCE disabled with KASAN?
> >> ========================================-
> >>
> >> The string headers on all arches supporting KASAN disable fortify with
> >> kasan, but only when address sanitisation is _also_ disabled. For example
> >> from x86:
> >>
> >>  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> >>  /*
> >>   * For files that are not instrumented (e.g. mm/slub.c) we
> >>   * should use not instrumented version of mem* functions.
> >>   */
> >>  #define memcpy(dst, src, len) __memcpy(dst, src, len)
> >>  #define memmove(dst, src, len) __memmove(dst, src, len)
> >>  #define memset(s, c, n) __memset(s, c, n)
> >>
> >>  #ifndef __NO_FORTIFY
> >>  #define __NO_FORTIFY /* FORTIFY_SOURCE uses __builtin_memcpy, etc. */
> >>  #endif
> >>
> >>  #endif
> >>
> >> This comes from commit 6974f0c4555e ("include/linux/string.h: add the
> >> option of fortified string.h functions"), and doesn't work when KASAN is
> >> enabled and the file is supposed to be sanitised - as with test_kasan.c
> >
> > Hi Daniel,
> >
> > Thanks for addressing this. And special kudos for description detail level! :)
> >
> > Phew, this layering of checking tools is a bit messy...
> >
> >> I'm pretty sure this is backwards: we shouldn't be using __builtin_memcpy
> >> when we have a KASAN instrumented file, but we can use __builtin_* - and in
> >> many cases all fortification - in files where we don't have
> >> instrumentation.
> >
> > I think if we use __builtin_* in a non-instrumented file, the compiler
> > can emit a call to normal mem* function which will be intercepted by
> > kasan and we will get instrumentation in a file which should not be
> > instrumented. Moreover this behavior will depend on optimization level
> > and compiler internals.
> > But as far as I see this does not affect any of the following and the
> > code change.
> >
>
> mmm OK - you are right, when I consider this and your other point...
>
> >>  #if !defined(__NO_FORTIFY) && defined(__OPTIMIZE__) && defined(CONFIG_FORTIFY_SOURCE)
> >> +
> >> +#ifdef CONFIG_KASAN
> >> +extern void *__underlying_memchr(const void *p, int c, __kernel_size_t size) __RENAME(memchr);
> >
> >
> > arch headers do:
> >
> > #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
> > #define memcpy(dst, src, len) __memcpy(dst, src, len)
> > ...
> >
> > to disable instrumentation. Does this still work with this change?
> > Previously they disabled fortify. What happens now? Will define of
> > memcpy to __memcpy also affect __RENAME(memcpy), so that
> > __underlying_memcpy will be an alias to __memcpy?
>
> This is a good question. It's a really intricate set of interactions!!
>
> Between these two things, I think I'm going to just drop the removal of
> architecture changes, which means that fortify will continue to be
> disabled for files that disable KASAN sanitisation. It's just too
> complicated to reason through and satisfy myself that we're not going to
> get weird bugs, and the payoff is really small.

Sounds good to me. We don't need to solve all of the world 's problems
at once :)

> >> +extern int __underlying_memcmp(const void *p, const void *q, __kernel_size_t size) __RENAME(memcmp);
> >
> > All of these macros are leaking from the header file. Tomorrow we will
> > discover __underlying_memcpy uses somewhere in the wild, which will
> > not making understanding what actually happens simpler :)
> > Perhaps undef all of them at the bottom?
>
> I can't stop the function definitions from leaking, but I can stop the
> defines from leaking, which means we will catch any uses outside this
> block in a FORITY_SOURCE && !KASAN build. I've fixed this for v2.

I think it's good enough and a good practice to undef local macros.

> Regards,
> Daniel
>
> >> +extern void *__underlying_memcpy(void *p, const void *q, __kernel_size_t size) __RENAME(memcpy);
> >> +extern void *__underlying_memmove(void *p, const void *q, __kernel_size_t size) __RENAME(memmove);
> >> +extern void *__underlying_memset(void *p, int c, __kernel_size_t size) __RENAME(memset);
> >> +extern char *__underlying_strcat(char *p, const char *q) __RENAME(strcat);
> >> +extern char *__underlying_strcpy(char *p, const char *q) __RENAME(strcpy);
> >> +extern __kernel_size_t __underlying_strlen(const char *p) __RENAME(strlen);
> >> +extern char *__underlying_strncat(char *p, const char *q, __kernel_size_t count) __RENAME(strncat);
> >> +extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size) __RENAME(strncpy);
> >> +#else
> >> +#define __underlying_memchr    __builtin_memchr
> >> +#define __underlying_memcmp    __builtin_memcmp
> >> +#define __underlying_memcpy    __builtin_memcpy
> >> +#define __underlying_memmove   __builtin_memmove
> >> +#define __underlying_memset    __builtin_memset
> >> +#define __underlying_strcat    __builtin_strcat
> >> +#define __underlying_strcpy    __builtin_strcpy
> >> +#define __underlying_strlen    __builtin_strlen
> >> +#define __underlying_strncat   __builtin_strncat
> >> +#define __underlying_strncpy   __builtin_strncpy
> >> +#endif
> >> +
> >>  __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
> >>  {
> >>         size_t p_size = __builtin_object_size(p, 0);
> >> @@ -324,14 +349,14 @@ __FORTIFY_INLINE char *strncpy(char *p, const char *q, __kernel_size_t size)
> >>                 __write_overflow();
> >>         if (p_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_strncpy(p, q, size);
> >> +       return __underlying_strncpy(p, q, size);
> >>  }
> >>
> >>  __FORTIFY_INLINE char *strcat(char *p, const char *q)
> >>  {
> >>         size_t p_size = __builtin_object_size(p, 0);
> >>         if (p_size == (size_t)-1)
> >> -               return __builtin_strcat(p, q);
> >> +               return __underlying_strcat(p, q);
> >>         if (strlcat(p, q, p_size) >= p_size)
> >>                 fortify_panic(__func__);
> >>         return p;
> >> @@ -345,7 +370,7 @@ __FORTIFY_INLINE __kernel_size_t strlen(const char *p)
> >>         /* Work around gcc excess stack consumption issue */
> >>         if (p_size == (size_t)-1 ||
> >>             (__builtin_constant_p(p[p_size - 1]) && p[p_size - 1] == '\0'))
> >> -               return __builtin_strlen(p);
> >> +               return __underlying_strlen(p);
> >>         ret = strnlen(p, p_size);
> >>         if (p_size <= ret)
> >>                 fortify_panic(__func__);
> >> @@ -378,7 +403,7 @@ __FORTIFY_INLINE size_t strlcpy(char *p, const char *q, size_t size)
> >>                         __write_overflow();
> >>                 if (len >= p_size)
> >>                         fortify_panic(__func__);
> >> -               __builtin_memcpy(p, q, len);
> >> +               __underlying_memcpy(p, q, len);
> >>                 p[len] = '\0';
> >>         }
> >>         return ret;
> >> @@ -391,12 +416,12 @@ __FORTIFY_INLINE char *strncat(char *p, const char *q, __kernel_size_t count)
> >>         size_t p_size = __builtin_object_size(p, 0);
> >>         size_t q_size = __builtin_object_size(q, 0);
> >>         if (p_size == (size_t)-1 && q_size == (size_t)-1)
> >> -               return __builtin_strncat(p, q, count);
> >> +               return __underlying_strncat(p, q, count);
> >>         p_len = strlen(p);
> >>         copy_len = strnlen(q, count);
> >>         if (p_size < p_len + copy_len + 1)
> >>                 fortify_panic(__func__);
> >> -       __builtin_memcpy(p + p_len, q, copy_len);
> >> +       __underlying_memcpy(p + p_len, q, copy_len);
> >>         p[p_len + copy_len] = '\0';
> >>         return p;
> >>  }
> >> @@ -408,7 +433,7 @@ __FORTIFY_INLINE void *memset(void *p, int c, __kernel_size_t size)
> >>                 __write_overflow();
> >>         if (p_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_memset(p, c, size);
> >> +       return __underlying_memset(p, c, size);
> >>  }
> >>
> >>  __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
> >> @@ -423,7 +448,7 @@ __FORTIFY_INLINE void *memcpy(void *p, const void *q, __kernel_size_t size)
> >>         }
> >>         if (p_size < size || q_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_memcpy(p, q, size);
> >> +       return __underlying_memcpy(p, q, size);
> >>  }
> >>
> >>  __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
> >> @@ -438,7 +463,7 @@ __FORTIFY_INLINE void *memmove(void *p, const void *q, __kernel_size_t size)
> >>         }
> >>         if (p_size < size || q_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_memmove(p, q, size);
> >> +       return __underlying_memmove(p, q, size);
> >>  }
> >>
> >>  extern void *__real_memscan(void *, int, __kernel_size_t) __RENAME(memscan);
> >> @@ -464,7 +489,7 @@ __FORTIFY_INLINE int memcmp(const void *p, const void *q, __kernel_size_t size)
> >>         }
> >>         if (p_size < size || q_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_memcmp(p, q, size);
> >> +       return __underlying_memcmp(p, q, size);
> >>  }
> >>
> >>  __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
> >> @@ -474,7 +499,7 @@ __FORTIFY_INLINE void *memchr(const void *p, int c, __kernel_size_t size)
> >>                 __read_overflow();
> >>         if (p_size < size)
> >>                 fortify_panic(__func__);
> >> -       return __builtin_memchr(p, c, size);
> >> +       return __underlying_memchr(p, c, size);
> >>  }
> >>
> >>  void *__real_memchr_inv(const void *s, int c, size_t n) __RENAME(memchr_inv);
> >> @@ -505,7 +530,7 @@ __FORTIFY_INLINE char *strcpy(char *p, const char *q)
> >>         size_t p_size = __builtin_object_size(p, 0);
> >>         size_t q_size = __builtin_object_size(q, 0);
> >>         if (p_size == (size_t)-1 && q_size == (size_t)-1)
> >> -               return __builtin_strcpy(p, q);
> >> +               return __underlying_strcpy(p, q);
> >>         memcpy(p, q, strlen(q) + 1);
> >>         return p;
> >>  }
> >> --
> >> 2.20.1
> >>
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/8736cgkndh.fsf%40dja-thinkpad.axtens.net.
