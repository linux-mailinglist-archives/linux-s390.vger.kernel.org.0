Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2271F54CD
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2020 14:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgFJM2V (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 10 Jun 2020 08:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgFJM2V (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 Jun 2020 08:28:21 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CBAC03E96F
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 05:28:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z1so1541047qtn.2
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2020 05:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+g/QNFEcpPiOwSyTtWV6UhK4FMdUVFtGGz85G+f+/28=;
        b=rhC0j4t2YEoK08PnkL2fihhmC5XXVkrYeI4vb3VnKbwE+l9tdbbSmO2UgkqGtnyPlM
         A0GI3PJZEbPKn/4mia3nw1st3f5LEAUJ/4yoKbxTGeg/DRiLE/NmVjmolN4gSsplKLU7
         amPaMjgFwZua3VOnt2Zy7xqvx+XlxhC82VvOKuAPgQ2RbNfnBlItygDqkAdoOT/xWXU9
         Wk0yiDW1EFJ5x7iRkIj1gIZaK8JS1Fvrk9alFm1NrVleNsjzwxK9ULdORw3y+dXJeW5H
         jXzsHtnjfTHJmigC5tqVrgpSEfYqVtdxngTj/gbhYCrOPI1k3ODgCD4pfaNPsIwqt4xX
         7gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+g/QNFEcpPiOwSyTtWV6UhK4FMdUVFtGGz85G+f+/28=;
        b=pX3sYuQKZf0K5pLG1dp+dfv6knaAW9ozENdqk8/LMPFrzI9ZMH90ARS1WJBS8R5sF+
         IaSLkqD+iWq/JIea/UeAPwp9B8jbalx5TVPNG+nxx2BdNEiLvOzZoz9TBMoB/IK4Cqmv
         AVZqXJ/fq2nmzqKAj6P78ISTND8dtuFJPuO+cwefpbwHLLFVFTS0l5YQPDWQ1Waz40tc
         Plax6WzKxVh2W1COxsZA0WwZr+ekHk1CQ/2/zAZdnsMtQjXmFSaUqdbsC7L8LlTC/Jaa
         qikD8RhR/v6TTJUGy3s1t95zkqeWlm/NjBC9ru35cROGky7AL3hYkl9kp3hkQUy5rMYb
         aAlw==
X-Gm-Message-State: AOAM533pi7hr1yaSkZo03bYYZjrrEa7E5fsRZR6cH262pJEPu4yAnc3s
        UEA4zWyB3PwdhkcSjCS4gs9HCw==
X-Google-Smtp-Source: ABdhPJwLAeGPv59jZfZ3qqXM7MmZExkYgusex/dA6RWdkGRe+zbe7XyTijd5FwfQuIcBFIcoyaZGiw==
X-Received: by 2002:ac8:fa7:: with SMTP id b36mr2997242qtk.100.1591792100186;
        Wed, 10 Jun 2020 05:28:20 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id h64sm11681352qkf.46.2020.06.10.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 05:28:19 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:28:17 -0400
From:   Qian Cai <cai@lca.pw>
To:     Alexander Potapenko <glider@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH] mm/page_alloc: silence a KASAN false positive
Message-ID: <20200610122817.GC954@lca.pw>
References: <20200610052154.5180-1-cai@lca.pw>
 <CACT4Y+Ze=cddKcU_bYf4L=GaHuJRUjY=AdFFpM7aKy2+aZrmyQ@mail.gmail.com>
 <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X-da3V0OC-Bzd2rmkNuZ_bVpH_n7Sp5P_hSGXD4ryyBA@mail.gmail.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 10, 2020 at 01:02:04PM +0200, Alexander Potapenko wrote:
> On Wed, Jun 10, 2020 at 7:55 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Jun 10, 2020 at 7:22 AM Qian Cai <cai@lca.pw> wrote:
> > >
> > > kernel_init_free_pages() will use memset() on s390 to clear all pages
> > > from kmalloc_order() which will override KASAN redzones because a
> > > redzone was setup from the end of the allocation size to the end of the
> > > last page. Silence it by not reporting it there. An example of the
> > > report is,
> >
> > Interesting. The reason why we did not hit it on x86_64 is because
> > clear_page is implemented in asm (arch/x86/lib/clear_page_64.S) and
> > thus is not instrumented. Arm64 probably does the same. However, on
> > s390 clear_page is defined to memset.
> 
> Can we define it to __memset() instead?
> __memset() is supposed to be ignored by KASAN, e.g. KASAN runtime uses
> it in the places where we don't care about bugs.

I suppose that could work if s390 maintains perfer this way.
