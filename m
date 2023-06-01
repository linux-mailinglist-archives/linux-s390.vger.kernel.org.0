Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B81871F22C
	for <lists+linux-s390@lfdr.de>; Thu,  1 Jun 2023 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjFASiR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 1 Jun 2023 14:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjFASiQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Jun 2023 14:38:16 -0400
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [IPv6:2001:41d0:203:375::3f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392619B
        for <linux-s390@vger.kernel.org>; Thu,  1 Jun 2023 11:38:11 -0700 (PDT)
Date:   Thu, 1 Jun 2023 14:38:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685644690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vE5M38dfe56E8s/vH4SQoCtLt0IZYGAsgOXKDjVTLRk=;
        b=WcebRBX9N7xDfAOhJQCDt0Brku79Lkj1MR87hiRp7qhEDbQiQDjnDqE0iVy5Kc4E8ADGNa
        mXKEmKqKwoHkFh7QINhK9dRhKouPQW/ELmG9UtD3LNTa1N16g/g9fLkjUa8jbnd9gCmrO/
        7957lwgmB5RqAKvocMdeApF9dZOlVqo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "deller@gmx.de" <deller@gmx.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "will@kernel.org" <will@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "song@kernel.org" <song@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 12/13] x86/jitalloc: prepare to allocate exectuatble
 memory as ROX
Message-ID: <ZHjljJfQjhVV/jNS@moria.home.lan>
References: <20230601101257.530867-1-rppt@kernel.org>
 <20230601101257.530867-13-rppt@kernel.org>
 <0f50ac52a5280d924beeb131e6e4717b6ad9fdf7.camel@intel.com>
 <ZHjcr26YskTm+0EF@moria.home.lan>
 <a51c041b61e2916d2b91c990349aabc6cb9836aa.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51c041b61e2916d2b91c990349aabc6cb9836aa.camel@intel.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 01, 2023 at 06:13:44PM +0000, Edgecombe, Rick P wrote:
> > text_poke() _does_ create a separate RW mapping.
> 
> Sorry, I meant a separate RW allocation.

Ah yes, that makes sense


> 
> > 
> > The thing that sucks about text_poke() is that it always does a full
> > TLB
> > flush, and AFAICT that's not remotely needed. What it really wants to
> > be
> > doing is conceptually just
> > 
> > kmap_local()
> > mempcy()
> > kunmap_loca()
> > flush_icache();
> > 
> > ...except that kmap_local() won't actually create a new mapping on
> > non-highmem architectures, so text_poke() open codes it.
> 
> Text poke creates only a local CPU RW mapping. It's more secure because
> other threads can't write to it.

*nod*, same as kmap_local

> It also only needs to flush the local core when it's done since it's
> not using a shared MM.
 
Ahh! Thanks for that; perhaps the comment in text_poke() about IPIs
could be a bit clearer.

What is it (if anything) you don't like about text_poke() then? It looks
like it's doing broadly similar things to kmap_local(), so should be
in the same ballpark from a performance POV?
