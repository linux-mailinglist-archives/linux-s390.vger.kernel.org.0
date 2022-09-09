Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985735B31D7
	for <lists+linux-s390@lfdr.de>; Fri,  9 Sep 2022 10:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiIIIgT (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 9 Sep 2022 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIIIgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 04:36:18 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB521F3BF0
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 01:36:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k10so1506141lfm.4
        for <linux-s390@vger.kernel.org>; Fri, 09 Sep 2022 01:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=BbZr2IDF5mYuV07dt5XpEzbm+CGWl8GmrLDRuGPtC7E=;
        b=dy2bPFFGYzvTFhSiBzM0TcvYpvsd486uNttfXoBkYHRYX0ZSvSi6As+Ls9jZmxoWNA
         +ItLMlT3OLXdDlumTHfrPuBqZuwqpm0OMtRjkHSpumfd60Fxsz107BbLgruvoQnDMUtf
         jSzlcm4MEjwrxMbIVpUzEYIbfhoiL+LslyTfYLItTAYJEwwHLzwsR/ZUzEzNuyVbMPgf
         Pi1hHJJXer09s60ILhb3JHjZ7TEOLraL3v4DM1R7eObD6GBv7aUQbIPYXt9Iyqou6ex9
         x2du5OYCO124XUT0K7y24O2Ycdi6Lk7N1jXH9FQ63qHSQ6Biudqq/qKCyQr2/rU1PIZl
         bqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=BbZr2IDF5mYuV07dt5XpEzbm+CGWl8GmrLDRuGPtC7E=;
        b=sJX3cN37BnSXpLaEK9RB7B4vfXYZAboBabxxp8AL04GARgrLlbNK+lZ8P1GY0gUYUZ
         k1wxDRTvzcEdsb9jRFcRTygsIrEa8j7hSzphf8hsVQquBHd7XXsQ7kDVpafiKINjxCVh
         Xlqj4Oq/fQijZO6tIgVsg3A1NXQL7m9KGqZIyhpi9QzPZpUK4X28VYzUaQmKNVBaNr2i
         llp8hwABK5OvxnH/vJK3hxZBRdqIxzygQkNbaqH+FIkU0g8kkDzONtHO0VJfO7KuTD9i
         6/JLSaKj8JrC6fPcECi+rV3lDXnw80BpMiWBxbEWAh1QAjhqgq+mJjIOkS5LDPIVM7Ef
         6fJQ==
X-Gm-Message-State: ACgBeo24k96KPZS6DV9u01nFBzxm6NVfA3sHu9ogwms3ysxfQSfOdxDQ
        9Mon2kEs3I1ZsTGWLjcMUCBQ5wmII20EHDIN933GUQ==
X-Google-Smtp-Source: AA6agR45b0zHB/0PVCbyFGItE7H2cGmt2X38+vuxkMh+HTrWXlHOtyQNKUH4gGHyC7HuLNUy7Nulf7UAYBr8CNNVQJU=
X-Received: by 2002:a05:6512:401e:b0:48f:ea0d:1171 with SMTP id
 br30-20020a056512401e00b0048fea0d1171mr4372971lfb.137.1662712574759; Fri, 09
 Sep 2022 01:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073840.45349-1-elver@google.com>
In-Reply-To: <20220909073840.45349-1-elver@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 9 Sep 2022 10:36:00 +0200
Message-ID: <CACT4Y+bY1SkME7343-EZw_C2tORWrJU0MweArrPf2om8R_wfoQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] s390: Always declare __mem functions
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 9 Sept 2022 at 09:38, Marco Elver <elver@google.com> wrote:
>
> Like other architectures, always declare __mem*() functions if the
> architecture defines __HAVE_ARCH_MEM*.
>
> For example, this is required by sanitizer runtimes to unambiguously
> refer to the arch versions of the mem-functions, and the compiler not
> attempting any "optimizations" such as replacing the calls with builtins
> (which may later be inlined etc.).
>
> Signed-off-by: Marco Elver <elver@google.com>

Acked-by: Dmitry Vyukov <dvyukov@google.com>

> ---
> v2:
> * New patch.
> ---
>  arch/s390/include/asm/string.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
> index 3fae93ddb322..2c3c48d526b9 100644
> --- a/arch/s390/include/asm/string.h
> +++ b/arch/s390/include/asm/string.h
> @@ -20,8 +20,11 @@
>  #define __HAVE_ARCH_MEMSET64   /* arch function */
>
>  void *memcpy(void *dest, const void *src, size_t n);
> +void *__memcpy(void *dest, const void *src, size_t n);
>  void *memset(void *s, int c, size_t n);
> +void *__memset(void *s, int c, size_t n);
>  void *memmove(void *dest, const void *src, size_t n);
> +void *__memmove(void *dest, const void *src, size_t n);
>
>  #ifndef CONFIG_KASAN
>  #define __HAVE_ARCH_MEMCHR     /* inline & arch function */
> @@ -55,10 +58,6 @@ char *strstr(const char *s1, const char *s2);
>
>  #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>
> -extern void *__memcpy(void *dest, const void *src, size_t n);
> -extern void *__memset(void *s, int c, size_t n);
> -extern void *__memmove(void *dest, const void *src, size_t n);
> -
>  /*
>   * For files that are not instrumented (e.g. mm/slub.c) we
>   * should use not instrumented version of mem* functions.
> --
> 2.37.2.789.g6183377224-goog
>
