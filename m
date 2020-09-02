Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EF25A7BE
	for <lists+linux-s390@lfdr.de>; Wed,  2 Sep 2020 10:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIBI3E (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Sep 2020 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBI3D (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 04:29:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39721C061244;
        Wed,  2 Sep 2020 01:29:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599035341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pi/cQi80UUB8ig04fsQZMzpFt4TllRwrei28HJurdzY=;
        b=Jy6VilApm+/5kg1/8qC3/cxjHXxLnMUSLK2ESKKHeoZy1CWmbzPTx3c/L0AOe9hbirGyy/
        tru25u1yH8wSagSZkI6AxxEbR+PrS4wcuj5KEmoKqAWHO40I+cWyP3ePMrGp63AxwrIJU2
        PTwDvnon88SCijyTN/jFO/AiEO9IO+z8V9eeO8v4tu476FZicCoOrRZY/MnCO72M3N91iw
        M1ZF3qAUcFrRBVowVWqHlMsZ++XOpD2Fb/kn68cqK75zaoj3i++QZHeHs5F8OzSass/ytT
        oUzD1GwYmIOjbfHNVuf4Xs3AVr30BowVtqHCL25SZqE42vmIL/8FqugE4L4zYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599035341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pi/cQi80UUB8ig04fsQZMzpFt4TllRwrei28HJurdzY=;
        b=b4g7VLAAu2ar8HGlrayM8NFrozfoT4EyQk1L4Xiol0A4phjijM1Rgl8jj4g2KzZNm5YdwK
        M6UgDyiZq1wym/BA==
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: ptrace_syscall_32 is failing
In-Reply-To: <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com> <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com> <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com> <87k0xdjbtt.fsf@nanos.tec.linutronix.de> <CALCETrUpjUPPvnPuS9fP4jgid7U_qdU_yTKSq9PjJ=z2w9HvHg@mail.gmail.com>
Date:   Wed, 02 Sep 2020 10:29:00 +0200
Message-ID: <87blioinub.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 01 2020 at 17:09, Andy Lutomirski wrote:
> On Tue, Sep 1, 2020 at 4:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> > I think that they almost work for x86, but not quite as
>> > indicated by this bug.  Even if we imagine we can somehow hack around
>> > this bug, I imagine we're going to find other problems with this
>> > model, e.g. the potential upcoming exit problem I noted in my review.
>>
>> What's the upcoming problem?
>
> If we ever want to get single-stepping fully correct across syscalls,
> we might need to inject SIGTRAP on syscall return. This would be more
> awkward if we can't run instrumentable code after the syscall part of
> the syscall is done.

We run a lot of instrumentable code after sys_foo() returns. Otherwise
all the TIF work would not be possible at all.

But you might tell me where exactly you want to inject the SIGTRAP in
the syscall exit code flow.

>> I don't think we want that in general. The current variant is perfectly
>> fine for everything except the 32bit fast syscall nonsense. Also
>> irqentry_entry/exit is not equivalent to the syscall_enter/exit
>> counterparts.
>
> If there are any architectures in which actual work is needed to
> figure out whether something is a syscall in the first place, they'll
> want to do the usual kernel entry work before the syscall entry work.

That's low level entry code which does not require RCU, lockdep, tracing
or whatever muck we setup before actual work can be done.

arch_asm_entry()
  ...
  arch_c_entry(cause) {
    switch(cause) {
      case EXCEPTION: arch_c_exception(...);
      case SYSCALL: arch_c_syscall(...);
      ...
    }

You really want to differentiate between exception and syscall
entry/exit.

The splitting of syscall_enter_from_user_mode() is only necessary for
that 32bit fast syscall thing on x86 and there is no point to open code
it with two calls for e.g. do_syscall_64().

> Maybe your patch actually makes this possible -- I haven't digested
> all the details yet.
>
> Who advised you to drop the arch parameter?

Kees, IIRC, but I would have to search through the gazillions of mail
threads to be sure.

>> +       syscall_enter_from_user_mode_prepare(regs);
>
> I'm getting lost in all these "enter" functions...

It's not that hard.

     syscall_enter_from_user_mode_prepare()
+    syscall_enter_from_user_mode_work()
=    syscall_enter_from_user_mode()

That's exactly what you suggested just with the difference that it is
explicit for syscalls and not using irqentry_enter/exit().

If we would do that then instead of having a single call for sane
syscall pathes:

  arch_c_entry()
     nr = syscall_enter_from_user_mode();

or for that 32bit fast syscall nonsense the split variant:

  arch_c_entry()
     syscall_enter_from_user_mode_prepare();
     do_fast_syscall_muck();
     nr = syscall_enter_from_user_mode_work();

we'd have:

  arch_c_entry()
     irqentry_enter();
     local_irq_enble();
     nr = syscall_enter_from_user_mode_work();
     ...

which enforces two calls for sane entries and more code in arch/....

Thanks,

        tglx
