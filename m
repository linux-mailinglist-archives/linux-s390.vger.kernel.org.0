Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03C547B8A
	for <lists+linux-s390@lfdr.de>; Sun, 12 Jun 2022 20:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiFLSpS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 12 Jun 2022 14:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234220AbiFLSoY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 Jun 2022 14:44:24 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 171455C84E
        for <linux-s390@vger.kernel.org>; Sun, 12 Jun 2022 11:44:23 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id x190so1741934vkc.9
        for <linux-s390@vger.kernel.org>; Sun, 12 Jun 2022 11:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QCktWd+n5KgBQynLnBWE6RqZZ6FNqdKAToR40bXnybk=;
        b=rE4ZKOj9G5jD2nQ2CRonznQYOzu8A5GJ78TYm6TMyjo/YSz1Ke2AwnEVVmeUxKnSOs
         VU/PnveGAuCXod1sYTPGF4SYY8Kayhou1MRw9NRbhAp0Vs8rJ40+iNxr80I3A/bPOSSB
         XoFDipXokhUzLcWqJF7Zu8Uwr9IsUndy2MMK73MNeo15l2oLqBbu+vxpxNojHhWOTb8Z
         3ZZ38lETVABRQispRTHE7nDOwCPrm7B0YGH0RBwW3xdOdgnfhWn91GJMKXDPxvEMusZa
         CghG+0ks70Y5Xz1TD3ibb9iy2EdpA9EEKYosomjlT7bknvtajQYIP5zCK183nPtzrdiS
         jC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QCktWd+n5KgBQynLnBWE6RqZZ6FNqdKAToR40bXnybk=;
        b=WqYafraOSS1BIM4MtrpZMH0UPboD/eVCSZius9AZePEP+Nx41ygSWqi/XoEKT+eW6K
         gqDhqxTYpmvKJ2RylSYBJHPQ5apgqZ4wjkg1NCX8JmQb87t/1DxtyCk+91cUc/GjWFz9
         Pn0guJnFVxO9SbNKujOrqvT2fBBp7CAo/BZDcW7Hr2Et0CiTsKt/L1AYbJWKoveA0mc6
         SAYNqdFSEbh6J8MYxSShi2Blu+h6eUuISMDlGAUSpIONr4xNP6r0r8PohpU2i63V/2fw
         bJk6v0Sm267diuuO1AU4uDSKEfLJ/HkRzEVtiuwbkWvaz2m0dtOd8+L45d9/BgsjSRM5
         Ntqw==
X-Gm-Message-State: AOAM532h8GXJaumAEFRF1mkezGa4xv1kgPCSInrV8eFBIQvzqPDreYNQ
        4owBDDGIUzsHHcDxwk1EgUOayxIfE0OfGBoe5UL8mWeG8lUbgg==
X-Google-Smtp-Source: ABdhPJzZ/47s2snJvZ7uwTxgvT6BhXeoHrhBRaplai/C7kYtFaFHZUC6p8rFmt5CyUlbVZ4GknNgi/R9kqTEL6R3Zxk=
X-Received: by 2002:a1f:a504:0:b0:35e:4fd4:d3bf with SMTP id
 o4-20020a1fa504000000b0035e4fd4d3bfmr12696376vke.7.1655059462057; Sun, 12 Jun
 2022 11:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <bug-216073-27@https.bugzilla.kernel.org/> <20220606151312.6a9d098c85ed060d36519600@linux-foundation.org>
 <Yp9pHV14OqvH0n02@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220608021922.n2izu7n4yoadknkx@zlang-mailbox> <YqD0yAELzHxdRBU6@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220612044230.murerhsa765akogj@zlang-mailbox> <YqXU+oU7wayOcmCe@casper.infradead.org>
 <YqXkGMY9xtUvPR5D@pc638.lan> <YqYh0xyJvoNsSOpy@casper.infradead.org>
 <CAOUHufbBkcjChkMfF8exh3=6=JM09-GCU71KXhUGmz4UdOhUmg@mail.gmail.com> <YqYq846zFUInllTw@casper.infradead.org>
In-Reply-To: <YqYq846zFUInllTw@casper.infradead.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 12 Jun 2022 12:43:45 -0600
Message-ID: <CAOUHufan8+uombVMSSrKra-8Cu5pSJj80LVa6QrGbFzBmUQHxg@mail.gmail.com>
Subject: Re: [Bug 216073] New: [s390x] kernel BUG at mm/usercopy.c:101!
 usercopy: Kernel memory exposure attempt detected from vmalloc 'n o area'
 (offset 0, size 1)!
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, Zorro Lang <zlang@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        bugzilla-daemon@kernel.org, linux-s390@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Jun 12, 2022 at 12:05 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jun 12, 2022 at 11:59:58AM -0600, Yu Zhao wrote:
> > Please let me know if there is something we want to test -- I can
> > reproduce the problem reliably:
> >
> > ------------[ cut here ]------------
> > kernel BUG at mm/usercopy.c:101!
>
> The line right before cut here would have been nice ;-)

Right.

$ grep usercopy:
usercopy: Kernel memory exposure attempt detected from vmalloc (offset
2882303761517129920, size 11)!
usercopy: Kernel memory exposure attempt detected from vmalloc (offset
8574853690513436864, size 11)!
usercopy: Kernel memory exposure attempt detected from vmalloc (offset
7998392938210013376, size 11)!
...

> https://lore.kernel.org/linux-mm/YqXU+oU7wayOcmCe@casper.infradead.org/
>
> might fix your problem, but I can't be sure without that line.

Thanks, it worked!
