Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2EB25B416
	for <lists+linux-s390@lfdr.de>; Wed,  2 Sep 2020 20:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBSum (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Sep 2020 14:50:42 -0400
Received: from foss.arm.com ([217.140.110.172]:44750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIBSul (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 2 Sep 2020 14:50:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BB1CD6E;
        Wed,  2 Sep 2020 11:50:41 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.242])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89A6F3F71F;
        Wed,  2 Sep 2020 11:50:37 -0700 (PDT)
Date:   Wed, 2 Sep 2020 19:50:27 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Miroslav Benes <mbenes@suse.cz>, Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Message-ID: <20200902184935.GA5875@C02TD0UTHF1T.local>
References: <20200819124913.37261-1-broonie@kernel.org>
 <20200819124913.37261-4-broonie@kernel.org>
 <alpine.LSU.2.21.2009021128500.23200@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2009021128500.23200@pobox.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 02, 2020 at 11:32:13AM +0200, Miroslav Benes wrote:
> Hi,
> 
> it could be a silly question, but better to ask...
> 
> > +	if (regs)
> > +		start_backtrace(&frame, regs->regs[29], regs->pc);
> > +	else
> > +		start_backtrace(&frame, thread_saved_fp(task),
> > +				thread_saved_pc(task));
> 
> Would this also work for task == current? Given that the original code had
> 
> > -		start_backtrace(&frame,
> > -				(unsigned long)__builtin_frame_address(0),
> > -				(unsigned long)__save_stack_trace);

Oh whoops; I'm annoyed I didn't spot that.

With that gone this cannot work for (task == current && regs == NULL), as
we'll erroneously use stale values from the task struct.

It looks like the LKDTM tests only trigger cases with non-NULL regs, but
IIUC this should show up with show_stack(NULL, NULL, KERN_INFO), as
drivers/tty/sysrq.c does for other cpus.

Thanks,
Mark.
