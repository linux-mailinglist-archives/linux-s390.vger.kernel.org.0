Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05E9205A0E
	for <lists+linux-s390@lfdr.de>; Tue, 23 Jun 2020 20:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733138AbgFWSAG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 23 Jun 2020 14:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgFWSAF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 14:00:05 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B869C061755
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2020 11:00:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so2152792wmj.2
        for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2020 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wcyp7xJ9VH6Ce5YmoH+01qglUFlPRs0bPBHrFHPBGrU=;
        b=b0gWdjg9shIjXDAXSuaxcUf0kvXH4yOK4YqHK+9dT9MEpAkVd6umkpXAERDfyobiWl
         iXYdhTzGdCZyETgQEnsKBMRw2uD1/6EG+a2gNOJxd+k6D/sDEhaX6N+anOTYiE5UTlEW
         9guLzwsJbj9ourTGn7rQyP3RVBIwQBwAZ/LZZzmAPQobTh1G7a54oM7BKIaUVWVU7sYR
         92sTnOH08HPqyhu7XVR11xnX2duZHFm8vCQNLqhX6EcurG9VD3S0w6GR/Cq7XgDKoDq9
         1VJ29HZZZHA+0Um8K2+yTGYbKt5FDsWkltk1RndhkdGr1x6j4EAOX4DINZmI1bfl6Cvx
         oAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wcyp7xJ9VH6Ce5YmoH+01qglUFlPRs0bPBHrFHPBGrU=;
        b=p8vl31o/DuKR/m/9n47nJ2gd6jCXyxbklnXPZjsptT5telTPeYFWb1eu47f68N4ltB
         2QYsn9ni6qNUcTN0+0I59Sl2cKjWmwfs6BLfDounsJs9xh0xOLadAhLSUcYXSrjndrQY
         AITd0qYnYjWfX9ACY8+ozIuteSNmUuBEax+duLEQOOTFHn82mRaFdTbfgpEin3EISmud
         npDB1mV9l8hdMIzMZMS2hAwGFlBJke8Is4LwyCeswOogP+xf9fCJWBoCAZw8Wk/6sEFX
         gCpcc0u3iMeRT3xj50myGhZdI1pvxBDfKLxGdTI5wPod2uSGojpJKwB8jQ3+hBmYLQcG
         DTpg==
X-Gm-Message-State: AOAM531P8EwMqqxaikqZHD0UQdwSmZDtlPY0JfUSdApo/kANN3QC5GXP
        /aWHDbR2oennfjHmvfQM/RdPfA==
X-Google-Smtp-Source: ABdhPJyBS+rhzsc1deZ1Ay1FOdoRDXOTCxrPOjQRzUCugXkZeGKEC8Ks241Yw7kTMxlqgYm+GZsCyQ==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr25343911wmj.84.1592935203860;
        Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id r1sm22986260wrn.29.2020.06.23.11.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 11:00:03 -0700 (PDT)
Date:   Tue, 23 Jun 2020 19:59:57 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org,
        will@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bigeasy@linutronix.de, davem@davemloft.net,
        sparclinux@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com,
        linux-s390@vger.kernel.org, linux@armlinux.org.uk
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623175957.GA106514@elver.google.com>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623163730.GA4800@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 23, 2020 at 06:37PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 06:13:21PM +0200, Ahmed S. Darwish wrote:
> > Well, freshly merged code is using it. For example, KCSAN:
> > 
> >     => f1bc96210c6a ("kcsan: Make KCSAN compatible with lockdep")
> >     => kernel/kcsan/report.c:
> > 
> >     void kcsan_report(...)
> >     {
> > 	...
> >         /*
> >          * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
> >          * we do not turn off lockdep here; this could happen due to recursion
> >          * into lockdep via KCSAN if we detect a race in utilities used by
> >          * lockdep.
> >          */
> >         lockdep_off();
> > 	...
> >     }
> 
> Marco, do you remember what exactly happened there? Because I'm about to
> wreck that. That is, I'm going to make TRACE_IRQFLAGS ignore
> lockdep_off().

Yeah, I was trying to squash any kind of recursion:

	lockdep -> other libs ->
		-> KCSAN
		-> print report
		-> dump stack, printk and friends
		-> lockdep -> other libs
			-> KCSAN ...

Some history:

* Initial patch to fix:
	https://lore.kernel.org/lkml/20200115162512.70807-1-elver@google.com/

* KCSAN+lockdep+ftrace:
	https://lore.kernel.org/lkml/20200214211035.209972-1-elver@google.com/

lockdep now has KCSAN_SANITIZE := n, but we still need to ensure that
there are no paths out of lockdep, or the IRQ flags tracing code, that
might lead through other libs, through KCSAN, libs used to generate a
report, and back to lockdep.

I never quite figured out the exact trace that led to corruption, but
avoiding any kind of potential for recursion was the only thing that
would avoid the check_flags() warnings.

Thanks,
-- Marco
