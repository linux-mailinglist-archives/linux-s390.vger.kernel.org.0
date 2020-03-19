Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD1DD18BE7B
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2020 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgCSRmv (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Mar 2020 13:42:51 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40476 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgCSRmu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Mar 2020 13:42:50 -0400
Received: from zn.tnic (p200300EC2F0A85008DCA7A58643289AE.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:8dca:7a58:6432:89ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F6271EC0CFA;
        Thu, 19 Mar 2020 18:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584639768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=LJgEl6+GWpjWMprHgQdpvOsZPmZ9T4AgJaJ310Sp15A=;
        b=BstyM5FyzXd4gUjzYEKas19giaR3PryEQgqFuimsLBfSog5uMwWV2b0pL/Te/PSiFpUTow
        +JfuNn7O4THbFfI6nYX7gKJnJsqRVfieDh1pygDl8Ash+cUnvz3cwuI8wH5wfd5vmjqxSm
        qSP7WorzYL+KIIwiwVuKclKRo0SUmHk=
Date:   Thu, 19 Mar 2020 18:42:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319174254.GE13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
 <20200319102834.GC13073@zn.tnic>
 <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
 <20200319112054.GD13073@zn.tnic>
 <878sjw5k9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878sjw5k9u.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 19, 2020 at 06:25:49PM +0100, Thomas Gleixner wrote:
> TBH, I don't see how
> 
> 	if (force_dma_decrypted(dev))
> 		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
>
> makes more sense than the above. It's both non-sensical unless there is

9087c37584fb ("dma-direct: Force unencrypted DMA under SME for certain DMA masks")

> a big fat comment explaining what this is about.

ACK to that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
