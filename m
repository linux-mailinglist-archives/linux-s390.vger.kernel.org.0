Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35CC3CE48B
	for <lists+linux-s390@lfdr.de>; Mon,  7 Oct 2019 16:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfJGOBK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Oct 2019 10:01:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39140 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728252AbfJGOBD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Oct 2019 10:01:03 -0400
Received: by mail-ed1-f68.google.com with SMTP id a15so12548464edt.6
        for <linux-s390@vger.kernel.org>; Mon, 07 Oct 2019 07:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKL1w3iXknpln9Ux2lFi8nURmFThC0ACAB38j7xMJOw=;
        b=1dC/oO7KYUhQk3Cp+gPvQQFfNUhXo7xBP7fOg6lJXEJoNi4xqoFx/+Z/eteEJO7TfS
         beXRbX34FM5TGrxRC9UtlPyVu0dSHSWxoZtuR+BBMIz3ysIcWEMjUC0trYfvncn0/S1K
         bedaHLGes2jPFyGX3hZIeFJI6nEWOI1RFwcmLQ/j5X/1FPSdYeaocVmbj1FV4QMO0Ct3
         gzIXMAqry05u2l85X3+0Gg6QDGEktesNKTlT1AuPCVLEt0ZvIsj2v9MyWo4Idq82kDyc
         ct/NK1YDtzPjx53EMdfO2f0gZjT1d4J5zb0WVTYkaD/x8lXnVmFKIb86ehHVrjIfm46m
         og+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKL1w3iXknpln9Ux2lFi8nURmFThC0ACAB38j7xMJOw=;
        b=DcVBABfytWLs+Niuda9FHrFhxQ4kPy9e07tzuShJPGMtVBOMCbczZHZBrBGTqAyHCt
         91HJwtgwPdwRxCzPehBBofaRXKESAdJ/EYRoXocYvAPYAt7jLccUJh5eSUw4ZC+qWjnm
         Sy4gHAAKx5qWvMiWVLv9IXHpPQh35rjP/7cUteIVNRDtoSIX4nq+wYC2UKEF1IACOjWw
         90pCv1XE8BOruhnVC5X+9LjLWZ6s1iIF2uf84KiAZ+RR11hrzXTlLu399QLVX8lCCv5p
         mitXlPIuXurDwcNFAaaekv8yq/rXQYu/+aj3MknmfXEQqsP1dxsYgHiJkEKrJM7pcABh
         WEsw==
X-Gm-Message-State: APjAAAUDRSmgXKLILWRxC/rQILNeHhD3WnguKzUq4ubBGSBNiOg1C7hr
        HyIlcMV/eDPuJN5MJikUWzh4yQ==
X-Google-Smtp-Source: APXvYqxuYtPtzk9H5R4kXUotDVtZLwRxmHkom44kwHAzQPnIVU9Dw79/zIRyaunZCbGIUeO/BsAK1g==
X-Received: by 2002:a17:906:4d08:: with SMTP id r8mr10168700eju.283.1570456860258;
        Mon, 07 Oct 2019 07:01:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r18sm3382249edl.6.2019.10.07.07.00.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 07:00:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BDCFF100287; Mon,  7 Oct 2019 17:00:58 +0300 (+03)
Date:   Mon, 7 Oct 2019 17:00:58 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] mm/pgtable/debug: Add test validating
 architecture page table helpers
Message-ID: <20191007140058.um5g44rvxyzyiref@box>
References: <1570427124-21887-1-git-send-email-anshuman.khandual@arm.com>
 <1570427124-21887-3-git-send-email-anshuman.khandual@arm.com>
 <20191007130617.GB56546@gmail.com>
 <20191007132607.4q537nauwfn5thol@box>
 <20191007135158.GA36360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007135158.GA36360@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 07, 2019 at 03:51:58PM +0200, Ingo Molnar wrote:
> 
> * Kirill A. Shutemov <kirill@shutemov.name> wrote:
> 
> > On Mon, Oct 07, 2019 at 03:06:17PM +0200, Ingo Molnar wrote:
> > > 
> > > * Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> > > 
> > > > This adds a test module which will validate architecture page table helpers
> > > > and accessors regarding compliance with generic MM semantics expectations.
> > > > This will help various architectures in validating changes to the existing
> > > > page table helpers or addition of new ones.
> > > > 
> > > > Test page table and memory pages creating it's entries at various level are
> > > > all allocated from system memory with required alignments. If memory pages
> > > > with required size and alignment could not be allocated, then all depending
> > > > individual tests are skipped.
> > > 
> > > > diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> > > > index 52e5f5f2240d..b882792a3999 100644
> > > > --- a/arch/x86/include/asm/pgtable_64_types.h
> > > > +++ b/arch/x86/include/asm/pgtable_64_types.h
> > > > @@ -40,6 +40,8 @@ static inline bool pgtable_l5_enabled(void)
> > > >  #define pgtable_l5_enabled() 0
> > > >  #endif /* CONFIG_X86_5LEVEL */
> > > >  
> > > > +#define mm_p4d_folded(mm) (!pgtable_l5_enabled())
> > > > +
> > > >  extern unsigned int pgdir_shift;
> > > >  extern unsigned int ptrs_per_p4d;
> > > 
> > > Any deep reason this has to be a macro instead of proper C?
> > 
> > It's a way to override the generic mm_p4d_folded(). It can be rewritten
> > as inline function + define. Something like:
> > 
> > #define mm_p4d_folded mm_p4d_folded
> > static inline bool mm_p4d_folded(struct mm_struct *mm)
> > {
> > 	return !pgtable_l5_enabled();
> > }
> > 
> > But I don't see much reason to be more verbose here than needed.
> 
> C type checking? Documentation? Yeah, I know it's just a one-liner, but 
> the principle of the death by a thousand cuts applies here.

Okay, if you think it worth it. Anshuman, could you fix it up for the next
submission?


> BTW., any reason this must be in the low level pgtable_64_types.h type 
> header, instead of one of the API level header files?

I defined it next pgtable_l5_enabled(). What is more appropriate place to
you? pgtable_64.h? Yeah, it makes sense.

-- 
 Kirill A. Shutemov
