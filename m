Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96441D33AD
	for <lists+linux-s390@lfdr.de>; Thu, 10 Oct 2019 23:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfJJVx1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Oct 2019 17:53:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35008 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfJJVx1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Oct 2019 17:53:27 -0400
Received: by mail-pl1-f194.google.com with SMTP id c3so3456014plo.2
        for <linux-s390@vger.kernel.org>; Thu, 10 Oct 2019 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eZ5a1UrQhKc0eFrayHNWPPaPzIDNm8Pl4fc7UtzEcwI=;
        b=C2jVvEnjI3cDO6vB/Rft3tcJex85MLNmn0DKywgUaA+JqHl5XVj8PXi/cisN6F6y3c
         jEyND9KgFacuQi0DUApP9FWNA9RdjSaH2p6/y3f9VUjJTyU7C7G4tqBJKEoaMJdm2xc7
         cC3Xwkvz83wYVon/M1YaWoXbhEZ1L27sCVrzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eZ5a1UrQhKc0eFrayHNWPPaPzIDNm8Pl4fc7UtzEcwI=;
        b=h9L21go4s1K5UPFrPrtHpN8MA6XXcEgUK5wsS9VQrdVwzQsqpnQN6WvqTPT/LcT5Gs
         1WeLnhJ9HZqYpU43X0AaonICyZtNthmkYoAr3lmA76KfsGIbpRFPvHR+5vCptD6oC4RH
         uc0oZNOVnaFfyG1h0YtEUEEiIrHnnq409qkQg30r/kVi33Q5dIXe4nLgda5TptU4YhBl
         RuYvkU6mtZ/KTDwW/TiXZFuK4DM+yu0Q1xos9AMhbKZiq4Rawif75Ph1IvfUSvs6YkLQ
         E1B+fQnQxIYssAoB6JRwJic73764tODe5lhcs6GDuXFAsCRltxsh+OK0/bh7xLSIFDOH
         P0fQ==
X-Gm-Message-State: APjAAAWwJYdYRZWZWP8VRTjdNYq8clg09qPN3Yecbn5e3j6mdV8eJfoB
        e9678fQ5j2+gb1qa/acGiZUttA==
X-Google-Smtp-Source: APXvYqzvP9DPNQm4eEFwpmDjtjMePiabTkC2OLVsNO4cce1OJAtguBuNxerHNmLTKublc5lHaVGkBg==
X-Received: by 2002:a17:902:8bc4:: with SMTP id r4mr11153280plo.341.1570744406496;
        Thu, 10 Oct 2019 14:53:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y4sm23629pfr.118.2019.10.10.14.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 14:53:25 -0700 (PDT)
Date:   Thu, 10 Oct 2019 14:53:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, luto@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, wad@chromium.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v1] seccomp: simplify secure_computing()
Message-ID: <201910101450.0B13B7F@keescook>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190924064420.6353-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924064420.6353-1-christian.brauner@ubuntu.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 24, 2019 at 08:44:20AM +0200, Christian Brauner wrote:
> Afaict, the struct seccomp_data argument to secure_computing() is unused
> by all current callers. So let's remove it.
> The argument was added in [1]. It was added because having the arch
> supply the syscall arguments used to be faster than having it done by
> secure_computing() (cf. Andy's comment in [2]). This is not true anymore
> though.

Yes; thanks for cleaning this up!

> diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
> index ad71132374f0..ed80bdfbf5fe 100644
> --- a/arch/s390/kernel/ptrace.c
> +++ b/arch/s390/kernel/ptrace.c
> @@ -439,7 +439,7 @@ static int poke_user(struct task_struct *child, addr_t addr, addr_t data)
>  long arch_ptrace(struct task_struct *child, long request,
>  		 unsigned long addr, unsigned long data)
>  {
> -	ptrace_area parea; 
> +	ptrace_area parea;
>  	int copied, ret;
>  
>  	switch (request) {

If this were whitespace cleanup in kernel/seccomp.c, I'd take it without
flinching. As this is only tangentially related and in an arch
directory, I've dropped this hunk out of a cowardly fear of causing
(a likely very unlikely) merge conflict.

I'd rather we globally clean up trailing whitespace at the end of -rc1
and ask Linus to run some crazy script. :)

So, with that hunk removed, I've applied this to for-next/seccomp. :)

Thanks!

-- 
Kees Cook
