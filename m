Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68926190211
	for <lists+linux-s390@lfdr.de>; Tue, 24 Mar 2020 00:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbgCWXne (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Mar 2020 19:43:34 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45934 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCWXnc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Mar 2020 19:43:32 -0400
Received: by mail-oi1-f193.google.com with SMTP id l22so5918544oii.12
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2020 16:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEuYlxaghpgWF2p5OUfw9hRKqdJnGRCmq90AXOuejGU=;
        b=JGS9qhFfhzpnjEAVbAAMHJj8in5e/nOn1IICF83YfSbXJY3qg9DEVBEwgVof62szn8
         +wcr6ReeQRfgWIdq3IXB2OeCk9osydynfhtZIMTCNHSyFiVP/P5Caj8dhLtq2BGgXDI9
         z9RWzC11+dTOKTK7uz6IWkRq0sE8ke2sODVks25xtxNeNkP0j/LZ0ZWRVSUO0ISXmDFY
         OXhQuh5V+0FA6tHkTdix9SbRKnBOQB6GwgxG+jXmCWPfN3smHYwjJomfsyJOxbvZNvce
         W9L18k9PNSoTMlcmWM5mVcddQaDKgk7ayZqZ1lqcZwPmZb1GF+ztYj4NfcNcdWQ/KL+9
         +iKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEuYlxaghpgWF2p5OUfw9hRKqdJnGRCmq90AXOuejGU=;
        b=ok7zrO2mtMoiswfWxCRuXcerbEe6LYVv22Lq+8YGuOjexS+NIYfXFVAcpJWVqw7sCu
         +TLe8/VwtOJM+8F3kLOIPBtRKZJzdLoD4q1FvHuby7ifUFBXODdQgBah9R+4OzChQYrF
         XLX7v24+x+ST9vmLIm3MJXwxmXu7adhRIIhkHrLVQmCmEaJ2WPdbdXzTwlu395Oou7wq
         WTAWgr4zZgvaNhxbXsHPD7V5J+EBXtKAju6L0/0fL6kFOl+LqD5oqkRNGGiaOKva8/Tv
         z5UbOJoZBOlOToqlqZmrDZqNZUjZyl42YO1Q9Q35zCUsBrO4lTzMnnRfogV3ia2Vx4i5
         f9Kw==
X-Gm-Message-State: ANhLgQ12V2KFfi+D0+HuRCmRTb10l0dTTgdO8cr5jNpAx0jTOu93EaC0
        uWa65h++ZROvFxEo4mTCtSWASc7tMtgJIkg08+DHcw==
X-Google-Smtp-Source: ADFU+vtBxnTz2QBJIDkSVPYlpKleGGK1ca0DAH/injUpPrVGWi+vIqGYuB7A1hrRam1e7/mwSm5ajjiQswx4Jwdrhqo=
X-Received: by 2002:aca:5d83:: with SMTP id r125mr1504637oib.8.1585007011359;
 Mon, 23 Mar 2020 16:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200318220634.32100-1-mike.kravetz@oracle.com> <20200318220634.32100-2-mike.kravetz@oracle.com>
In-Reply-To: <20200318220634.32100-2-mike.kravetz@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 23 Mar 2020 16:43:19 -0700
Message-ID: <CAHS8izMnxF9e-QDmA1WL4Kjgt=Uu0Xk64WZB1-bbvO4A+2fZiA@mail.gmail.com>
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Mar 18, 2020 at 3:07 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> The architecture independent routine hugetlb_default_setup sets up
> the default huge pages size.  It has no way to verify if the passed
> value is valid, so it accepts it and attempts to validate at a later
> time.  This requires undocumented cooperation between the arch specific
> and arch independent code.
>
> For architectures that support more than one huge page size, provide
> a routine arch_hugetlb_valid_size to validate a huge page size.
> hugetlb_default_setup can use this to validate passed values.
>
> arch_hugetlb_valid_size will also be used in a subsequent patch to
> move processing of the "hugepagesz=" in arch specific code to a common
> routine in arch independent code.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  arch/arm64/include/asm/hugetlb.h   |  2 ++
>  arch/arm64/mm/hugetlbpage.c        | 19 ++++++++++++++-----
>  arch/powerpc/include/asm/hugetlb.h |  3 +++
>  arch/powerpc/mm/hugetlbpage.c      | 20 +++++++++++++-------
>  arch/riscv/include/asm/hugetlb.h   |  3 +++
>  arch/riscv/mm/hugetlbpage.c        | 28 ++++++++++++++++++----------
>  arch/s390/include/asm/hugetlb.h    |  3 +++
>  arch/s390/mm/hugetlbpage.c         | 18 +++++++++++++-----
>  arch/sparc/include/asm/hugetlb.h   |  3 +++
>  arch/sparc/mm/init_64.c            | 23 ++++++++++++++++-------
>  arch/x86/include/asm/hugetlb.h     |  3 +++
>  arch/x86/mm/hugetlbpage.c          | 21 +++++++++++++++------
>  include/linux/hugetlb.h            |  7 +++++++
>  mm/hugetlb.c                       | 16 +++++++++++++---
>  14 files changed, 126 insertions(+), 43 deletions(-)
>

With build fixes:
Acked-by: Mina Almasry <almasrymina@google.com>
