Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D03518B152
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2020 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCSK23 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 19 Mar 2020 06:28:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57538 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCSK23 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:29 -0400
Received: from zn.tnic (p200300EC2F0A850035180F69CBC86220.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:3518:f69:cbc8:6220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C77D31EC0CF9;
        Thu, 19 Mar 2020 11:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584613707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iZUZhIBkCAhoEjiFaedPIp77BnKEXPzFG3udsiDWQxc=;
        b=dypae57FKE5rQct1uVw9z0eRqwwakJqg6wApvPGh+7jfpxaIYR9NvqV9dcyEoHaQhwxgS1
        SyvVx/9MAyVls4z0HFyj86rMEjzesgL6031uOQFgJUVuTia2O/DFwyOCcnYoUJCzSSUw5a
        7IXXW0Qn9kLr8AQU+YnSYTs99pl6VAE=
Date:   Thu, 19 Mar 2020 11:28:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319102834.GC13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319102011.GA3617@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Mar 19, 2020 at 11:20:11AM +0100, Christoph Hellwig wrote:
> I thought we agreed that decrypted is absolutely the wrong term.

I don't think we did. At least I don't know where we did that.

> So NAK - if you want to change things it needs to go the other way.

We are already using "decrypted" everywhere in arch/x86/. Changing that
would be a *lot* more churn.

And it is just a term, for chrissakes, to denote memory which is not
encrypted. And it would make our lifes easier if we had only *two* terms
instead of three or more. Especially if the concept we denote with this
is a binary one: encrypted memory and *not* encrypted memory.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
