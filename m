Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66F618905A
	for <lists+linux-s390@lfdr.de>; Tue, 17 Mar 2020 22:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCQVbK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 17 Mar 2020 17:31:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40906 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbgCQVbJ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 17 Mar 2020 17:31:09 -0400
Received: from zn.tnic (p200300EC2F0C960029779DE4AAC583E4.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:9600:2977:9de4:aac5:83e4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 58AE31EC0C68;
        Tue, 17 Mar 2020 22:31:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584480668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RMKAealFBjjSPHlKH7zxedK6Vy5tkttV34MQFS3HmiQ=;
        b=LjpQr+GlX3iH9rEkBWb84N4Q1ycXhEIq9TvynjyGe4TTrcJjq+Fn4WVqy1q6xvjSVFjVR5
        QLXkqznZ/G8JHEBkbIojedr2YcdSwmzZdn/FjtptrhJZyyAdnmnnK/8ZMln+7fi4kGNysY
        VZaz4YQQKq3EP6FINuFyeolQaLrbBug=
Date:   Tue, 17 Mar 2020 22:31:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
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
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200317213100.GH15609@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
 <20200317210602.GG15609@zn.tnic>
 <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 17, 2020 at 02:24:59PM -0700, Dave Hansen wrote:
> No, there are just two states.  I just think the "!encrypted" case
> should not be called "decrypted".

Yeah, we suck at naming - news at 11! :-)

I believe we even considered things like "encrypted" vs "clear" but
that sucked too. ;-\

In any case, that ship has sailed now and having two as differently as
possible looking words to denote the two "states" should be good enough
for our purposes...

Oh well.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
