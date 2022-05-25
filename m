Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967A553445A
	for <lists+linux-s390@lfdr.de>; Wed, 25 May 2022 21:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiEYTiD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-s390@lfdr.de>); Wed, 25 May 2022 15:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344355AbiEYTiA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 May 2022 15:38:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A89A66C84;
        Wed, 25 May 2022 12:37:47 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1ntwp4-0007pS-Ng; Wed, 25 May 2022 21:37:34 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal support
Date:   Wed, 25 May 2022 21:37:33 +0200
Message-ID: <1766627.8hzESeGDPO@diego>
In-Reply-To: <CAJF2gTTkpHLZf-+VXZE_gCn=5ZJ5FS3jOxKLVoMyL4i=baPd7Q@mail.gmail.com>
References: <20220322144003.2357128-1-guoren@kernel.org> <3418219.V25eIC5XRa@diego> <CAJF2gTTkpHLZf-+VXZE_gCn=5ZJ5FS3jOxKLVoMyL4i=baPd7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Am Mittwoch, 25. Mai 2022, 18:08:22 CEST schrieb Guo Ren:
> Thx Heiko & Guenter,
> 
> On Wed, May 25, 2022 at 7:10 PM Heiko St�bner <heiko@sntech.de> wrote:
> >
> > Am Mittwoch, 25. Mai 2022, 12:57:30 CEST schrieb Heiko St�bner:
> > > Am Mittwoch, 25. Mai 2022, 00:06:46 CEST schrieb Guenter Roeck:
> > > > On Wed, May 25, 2022 at 01:46:38AM +0800, Guo Ren wrote:
> > > > [ ... ]
> > > >
> > > > > > The problem is come from "__dls3's vdso decode part in musl's
> > > > > > ldso/dynlink.c". The ehdr->e_phnum & ehdr->e_phentsize are wrong.
> > > > > >
> > > > > > I think the root cause is from musl's implementation with the wrong
> > > > > > elf parser. I would fix that soon.
> > > > > Not elf parser, it's "aux vector just past environ[]". I think I could
> > > > > solve this, but anyone who could help dig in is welcome.
> > > > >
> > > >
> > > > I am not sure I understand what you are saying here. Point is that my
> > > > root file system, generated with musl a year or so ago, crashes with
> > > > your patch set applied. That is a regression, even if there is a bug
> > > > in musl.
> Thx for the report, it's a valuable regression for riscv-compat.
> 
> > >
> > > Also as I said in the other part of the thread, the rootfs seems innocent,
> > > as my completely-standard Debian riscv64 rootfs is also affected.
> > >
> > > The merged version seems to be v12 [0] - not sure how we this discussion
> > > ended up in v9, but I just tested this revision in two variants:
> > >
> > > - v5.17 + this v9 -> works nicely
> >
> > I take that back ... now going back to that build I somehow also run into
> > that issue here ... will investigate more.
> Yeah, it's my fault. I've fixed up it, please have a try:
> 
> https://lore.kernel.org/linux-riscv/20220525160404.2930984-1-guoren@kernel.org/T/#u

very cool that you found the issue.
I've tested your patch and it seems to fix the issue for me.

Thanks for figuring out the cause
Heiko


> > > - v5.18-rc6 + this v9 (rebased onto it) -> breaks the boot
> > >   The only rebase-conflict was with the introduction of restartable
> > >   sequences and removal of the tracehook include, but turning CONFIG_RSEQ
> > >   off doesn't seem to affect the breakage.
> > >
> > > So it looks like something changed between 5.17 and 5.18 that causes the issue.
> > >
> > >
> > > Heiko
> > >
> > >
> > > [0] https://lore.kernel.org/all/20220405071314.3225832-1-guoren@kernel.org/
> > >
> >
> >
> >
> >
> 
> 
> 




