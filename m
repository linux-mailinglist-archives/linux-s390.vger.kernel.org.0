Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF43263570
	for <lists+linux-s390@lfdr.de>; Wed,  9 Sep 2020 20:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgIISF2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Sep 2020 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgIISDa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Sep 2020 14:03:30 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0935C061756
        for <linux-s390@vger.kernel.org>; Wed,  9 Sep 2020 11:03:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ef16so1980015qvb.8
        for <linux-s390@vger.kernel.org>; Wed, 09 Sep 2020 11:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UQgQ1jWE5sEaZp188M6nTz8t9kSh4aamz6SSlq8ptfM=;
        b=A1EztTr153mgaOQzg71QrWYh4iR+/GKjXrKqg1rHHwyCQEu/IERkUOuYsKvQkOl1+C
         6eEp+cnjHSrQGtueAOf9pTHLleNwrHI+seHLvaQHFTcxMdSMW5tN7OgJMFx+soMlUkUR
         eYjHVlgNYm626JzDRfys6jbvYB1TI08s8VAfVz2V9RqGqoB/GOGYcY/+rYj5qrggDmLx
         K4fu1a4UZ5Rnlb/xtt4Vdy+434DxWnYfGu+HQ3SBS7LpF1L/tfeGSDCPAfZt0eW1xmOI
         vZmyUl7Hz6/Q8m3UTevIXqwOJHuaAn4ywsKXM3r0kORYKH6pbqnoX/h8gtw1ia3Np5f7
         fmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UQgQ1jWE5sEaZp188M6nTz8t9kSh4aamz6SSlq8ptfM=;
        b=Fk+BsNBowBs7cB5YuDMHZMadBzy/yQYftk0y6WS2lHnPz/V2atgI06YkGBb7ltVjFm
         FY0+imDhXrouI+mHOQTmQzbXUJoupSKmBAmEfKanEijRZf3X86HLISBgvoLnMh0hoSUK
         1weTKubWVbpvufqZ4yO/SxXlMV7LkNGNfZ3exuerWM17w1x5ct2m8TT4BkefDEXbfqVl
         iiQEOFtqUYfEyWZnE9h0uRIwFPzRWRvUALFrL/WMg4ECPOgy50ne++wbDpAaqjYENZF1
         5AFBbLwc2zIC7GAijX8m4PyBCSHfs+eHnokwcmmPmZGIRagSJB9Rz3R6sc+O0YTBBi+X
         VWcw==
X-Gm-Message-State: AOAM532LSg5jXXJt+zLnDM8/ys6fYQu/jntRye3nae9P0Jyyy9EQKhlv
        0WMa5BbNpd0KBL+T7xd0F9ig/Q==
X-Google-Smtp-Source: ABdhPJyORWlaWmB1Nu1DtA3vqJBA49b6LBNYfIyPrYHnjmR0hq08XfufNeF9nCJAP6MnxhYPIeRCPA==
X-Received: by 2002:a05:6214:5c8:: with SMTP id t8mr5410996qvz.67.1599674606034;
        Wed, 09 Sep 2020 11:03:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d16sm4004982qte.19.2020.09.09.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:03:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kG4RI-003r3t-JU; Wed, 09 Sep 2020 15:03:24 -0300
Date:   Wed, 9 Sep 2020 15:03:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
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
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200909180324.GI87483@ziepe.ca>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <0dbc6ec8-45ea-0853-4856-2bc1e661a5a5@intel.com>
 <20200909142904.00b72921@thinkpad>
 <aacad1b7-f121-44a5-f01d-385cb0f6351e@intel.com>
 <20200909192534.442f8984@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909192534.442f8984@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 09, 2020 at 07:25:34PM +0200, Gerald Schaefer wrote:
> I actually had to draw myself a picture to get some hold of
> this, or rather a walk-through with a certain pud-crossing
> range in a folded 3-level scenario. Not sure if I would have
> understood my explanation above w/o that, but I hope you can
> make some sense out of it. Or draw yourself a picture :-)

What I don't understand is how does anything work with S390 today?

If the fix is only to change pxx_addr_end() then than generic code
like mm/pagewalk.c will iterate over a *different list* of page table
entries. 

It's choice of entries to look at is entirely driven by pxx_addr_end().

Which suggest to me that mm/pagewalk.c also doesn't work properly
today on S390 and this issue is not really about stack variables?

Fundamentally if pXX_offset() and pXX_addr_end() must be consistent
together, if pXX_offset() is folded then pXX_addr_end() must cause a
single iteration of that level.

Jason
