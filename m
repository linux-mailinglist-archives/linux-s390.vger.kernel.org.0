Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2A82237A8
	for <lists+linux-s390@lfdr.de>; Fri, 17 Jul 2020 11:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgGQJEy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Jul 2020 05:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:55306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgGQJEy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 17 Jul 2020 05:04:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F71CB132;
        Fri, 17 Jul 2020 09:04:57 +0000 (UTC)
Date:   Fri, 17 Jul 2020 11:04:52 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Mark Brown <broonie@kernel.org>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] stacktrace: Remove reliable argument from
 arch_stack_walk() callback
In-Reply-To: <20200715202821.12220-2-broonie@kernel.org>
Message-ID: <alpine.LSU.2.21.2007171103070.21694@pobox.suse.cz>
References: <20200715202821.12220-1-broonie@kernel.org> <20200715202821.12220-2-broonie@kernel.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 15 Jul 2020, Mark Brown wrote:

> Currently the callback passed to arch_stack_walk() has an argument called
> reliable passed to it to indicate if the stack entry is reliable, a comment
> says that this is used by some printk() consumers. However in the current
> kernel none of the arch_stack_walk() implementations ever set this flag to
> true and the only callback implementation we have is in the generic
> stacktrace code which ignores the flag. It therefore appears that this
> flag is redundant so we can simplify and clarify things by removing it.

Correct. I dug around and it seems it was the case even when it was 
introduced. So I wonder about the comment. I don't remember the details, 
maybe Thomas or someone else does. But the patch looks correct.

Miroslav
