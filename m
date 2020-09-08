Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07ECC261777
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 19:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIHRfG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 13:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731437AbgIHQPM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Sep 2020 12:15:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E59C061232
        for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2020 06:26:13 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f142so15156366qke.13
        for <linux-s390@vger.kernel.org>; Tue, 08 Sep 2020 06:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Bd9eUG3DnE6D+neFj9R3QfT/oWxBp+wzdY7i+GsBSw=;
        b=Lf6G5poVVU9DTO5y/Kk8H2Ke1/yuvwq44QRfLlgtzVksH3W4CflZYO6N1CS6Gkgf+O
         36N3+8wD9pObYI1CMdwZYMYRu7HbXVUKEFPJ2AjNcK9X3BID5PsppQaFjSnqxa7JtCNT
         aY2EX4mu669m3AJgX7WT/I/zIn+qpP2LPn3ueNiUgo8NZRJ/0OvY6GqXffz02hp9ASt6
         Kw7kagCQ12/ztkbDpZvauMGFhf/ti5rup7TXyfyR2MZlnoY6C7+c78nhZr2bXok7Z+TB
         z94051jMYxpI6fAzrkfx1CYHrWeWBF5AFFZLbShjEyTsCM8ydvp1pulj0ri7yDSPS5ma
         HXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Bd9eUG3DnE6D+neFj9R3QfT/oWxBp+wzdY7i+GsBSw=;
        b=hghBPpl+cjXr5xL76OJ/EFVTzEaf08I4IxOtWK9kvWzfdVdE0Yki+JLMcWBnqF8RNe
         h9Ezmv7R3pQWJuNmM9EBuOMHRRTVWg4mUFiVTQ17u6eT+9dgjdPeWc3Jfw+2GJ11iOY5
         Bn8YKLKDahKh/cAuSKWfpBmCX4h5v6DuF3dteFTxorGmgTs5eTLlwLd8NGEDc8I0FhQs
         //K6BblWxy6L5WXTJolI4W7tzGqQyMsjdKRmlJbXUXSW8Geqf8Ly+tLTlLWo30C0Ws3u
         3JtOnKHLhfb6ViUEixKcIwdghMWPd1kmElu/T/2sgMMdZHNHDD5kBLXJwcFWmK/EaLLs
         4GLA==
X-Gm-Message-State: AOAM530Woo+NNvjIoIWOC4eyT6SmFxPneeau9VoWLQM6McXI1kEd+3MF
        B0dkyHS6N7MXAo0yOEmq1R45gA==
X-Google-Smtp-Source: ABdhPJytassnqIHgDUzIEWSN+bwEo6szoZotvnjMoppJpA+RAkN2BANjzTq153kTDs5DZf5N4KZr1w==
X-Received: by 2002:a05:620a:6d9:: with SMTP id 25mr18567qky.269.1599571572011;
        Tue, 08 Sep 2020 06:26:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j8sm14658360qth.90.2020.09.08.06.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:26:11 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kFddS-002zaX-9j; Tue, 08 Sep 2020 10:26:10 -0300
Date:   Tue, 8 Sep 2020 10:26:10 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
Message-ID: <20200908132610.GB87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 07, 2020 at 08:00:57PM +0200, Gerald Schaefer wrote:
> From: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Unlike all other page-table abstractions pXd_addr_end() do not take
> into account a particular table entry in which context the functions
> are called. On architectures with dynamic page-tables folding that
> might lead to lack of necessary information that is difficult to
> obtain other than from the table entry itself. That already led to
> a subtle memory corruption issue on s390.
> 
> By letting pXd_addr_end() functions know about the page-table entry
> we allow archs not only make extra checks, but also optimizations.
> 
> As result of this change the pXd_addr_end_folded() functions used
> in gup_fast traversal code become unnecessary and get replaced with
> universal pXd_addr_end() variants.
> 
> The arch-specific updates not only add dereferencing of page-table
> entry pointers, but also small changes to the code flow to make those
> dereferences possible, at least for x86 and powerpc. Also for arm64,
> but in way that should not have any impact.
> 
> So, even though the dereferenced page-table entries are not used on
> archs other than s390, and are optimized out by the compiler, there
> is a small change in kernel size and this is what bloat-o-meter reports:

This looks pretty clean and straightfoward, only
__munlock_pagevec_fill() had any real increased complexity.

Thanks,
Jason
