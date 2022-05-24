Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D15A532FCD
	for <lists+linux-s390@lfdr.de>; Tue, 24 May 2022 19:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbiEXRqy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 May 2022 13:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiEXRqx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 May 2022 13:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84803E5CD;
        Tue, 24 May 2022 10:46:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 548D86153F;
        Tue, 24 May 2022 17:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04E1C3411A;
        Tue, 24 May 2022 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653414410;
        bh=VFSFcaWnXkTONaZudhJ/D1XM8MP6tTrtdlB6KRbXuTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uym8rpR4E7gO1cx09ieBozk1kFi1hT7iWnaXZACBbLgDLgp76OX8W89CcL9dEJG/k
         /sMoqZXCg5hH5YFie/morYb9svNt95HWsaBokyE9c7BlklzSkV0/7I4UfSsFCnA3GB
         ZcEpBHgwFlEc2Yau7JqXqPFKnNIqS9kxM4NzoBa5Tb9Elva7jINB7JPiaV++YpL5Dw
         iDYDtgCcKxiFKXQZOIzGZyQt1nl/xtzMxeD+vsqE5Jheb/UHN7Q9VJHKA31M1loCxQ
         4mMzp8vIAyId4BDt8tFS8oLjlcmWt7R1oGzQS5ftNkavGmvh/yIcVBKzh2790LJ1qJ
         YBq6qwL6fjPng==
Received: by mail-vs1-f51.google.com with SMTP id j7so6933447vsp.12;
        Tue, 24 May 2022 10:46:50 -0700 (PDT)
X-Gm-Message-State: AOAM532jiAqrusLPPi2MhH9+zPzvdfimqpq+llaaG9PyLN3gH6bTOkUd
        9PQ3Pr5ZCS+BO+5B8ob/nmz/u/s/WmHTrpTMy7c=
X-Google-Smtp-Source: ABdhPJyKkjFolxnfdO9PCIWI8q5rCIqLEUdSJ81qW+0E0j887VJrevxqlepirleburYwnfejm1FO92XudOVHwSujXXg=
X-Received: by 2002:a67:c89c:0:b0:335:d83b:df76 with SMTP id
 v28-20020a67c89c000000b00335d83bdf76mr10323694vsk.51.1653414409588; Tue, 24
 May 2022 10:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220322144003.2357128-1-guoren@kernel.org> <20220322144003.2357128-21-guoren@kernel.org>
 <20220523054550.GA1511899@roeck-us.net> <CAJF2gTQ5RS8wGfSDPoB4JLtPBoM=ainuz_EJ9Tweq0mqPM=ALA@mail.gmail.com>
In-Reply-To: <CAJF2gTQ5RS8wGfSDPoB4JLtPBoM=ainuz_EJ9Tweq0mqPM=ALA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 25 May 2022 01:46:38 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSa=roJOiKFiL8nSQ12E-emz-xrXs=RNAc4zSFaPuRAzw@mail.gmail.com>
Message-ID: <CAJF2gTSa=roJOiKFiL8nSQ12E-emz-xrXs=RNAc4zSFaPuRAzw@mail.gmail.com>
Subject: Re: [PATCH V9 20/20] riscv: compat: Add COMPAT Kbuild skeletal support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, Arnd Bergmann <arnd@arndb.de>,
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
        "the arch/x86 maintainers" <x86@kernel.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 25, 2022 at 1:42 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 1:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Tue, Mar 22, 2022 at 10:40:03PM +0800, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Adds initial skeletal COMPAT Kbuild (Running 32bit U-mode on
> > > 64bit S-mode) support.
> > >  - Setup kconfig & dummy functions for compiling.
> > >  - Implement compat_start_thread by the way.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> >
> > With this patch in linux-next, all my riscv64 emulations crash.
> >
> > [   11.600082] Run /sbin/init as init process
> > [   11.628561] init[1]: unhandled signal 11 code 0x1 at 0x0000000000000000 in libc.so[ffffff8ad39000+a4000]
> > [   11.629398] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
> > [   11.629462] Hardware name: riscv-virtio,qemu (DT)
> > [   11.629546] epc : 00ffffff8ada1100 ra : 00ffffff8ada13c8 sp : 00ffffffc58199f0
> > [   11.629586]  gp : 00ffffff8ad39000 tp : 00ffffff8ade0998 t0 : ffffffffffffffff
> > [   11.629598]  t1 : 00ffffffc5819fd0 t2 : 0000000000000000 s0 : 00ffffff8ade0cc0
> > [   11.629610]  s1 : 00ffffff8ade0cc0 a0 : 0000000000000000 a1 : 00ffffffc5819a00
> > [   11.629622]  a2 : 0000000000000001 a3 : 000000000000001e a4 : 00ffffffc5819b00
> > [   11.629634]  a5 : 00ffffffc5819b00 a6 : 0000000000000000 a7 : 0000000000000000
> > [   11.629645]  s2 : 00ffffff8ade0ac8 s3 : 00ffffff8ade0ec8 s4 : 00ffffff8ade0728
> > [   11.629656]  s5 : 00ffffff8ade0a90 s6 : 0000000000000000 s7 : 00ffffffc5819e40
> > [   11.629667]  s8 : 00ffffff8ade0ca0 s9 : 00ffffff8addba50 s10: 0000000000000000
> > [   11.629678]  s11: 0000000000000000 t3 : 0000000000000002 t4 : 0000000000000001
> > [   11.629688]  t5 : 0000000000020000 t6 : ffffffffffffffff
> > [   11.629699] status: 0000000000004020 badaddr: 0000000000000000 cause: 000000000000000d
> > [   11.633421] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> > [   11.633664] CPU: 0 PID: 1 Comm: init Not tainted 5.18.0-rc7-next-20220520 #1
> > [   11.633784] Hardware name: riscv-virtio,qemu (DT)
> > [   11.633881] Call Trace:
> > [   11.633960] [<ffffffff80005e72>] dump_backtrace+0x1c/0x24
> > [   11.634162] [<ffffffff809aa9ec>] show_stack+0x2c/0x38
> > [   11.634274] [<ffffffff809b8482>] dump_stack_lvl+0x60/0x8e
> > [   11.634386] [<ffffffff809b84c4>] dump_stack+0x14/0x1c
> > [   11.634491] [<ffffffff809aaca0>] panic+0x116/0x2e2
> > [   11.634596] [<ffffffff80015540>] do_exit+0x7ce/0x7d4
> > [   11.634707] [<ffffffff80015666>] do_group_exit+0x24/0x7c
> > [   11.634817] [<ffffffff80022294>] get_signal+0x7ee/0x830
> > [   11.634924] [<ffffffff800051c0>] do_notify_resume+0x6c/0x41c
> > [   11.635037] [<ffffffff80003ad4>] ret_from_exception+0x0/0x10
> The problem is come from "__dls3's vdso decode part in musl's
> ldso/dynlink.c". The ehdr->e_phnum & ehdr->e_phentsize are wrong.
>
> I think the root cause is from musl's implementation with the wrong
> elf parser. I would fix that soon.
Not elf parser, it's "aux vector just past environ[]". I think I could
solve this, but anyone who could help dig in is welcome.

>
> If you CONFIG_COMPAT=n, the bug would be bypassed.
>
> >
> > Guenter
> >
> > ---
> > # bad: [18ecd30af1a8402c162cca1bd58771c0e5be7815] Add linux-next specific files for 20220520
> > # good: [42226c989789d8da4af1de0c31070c96726d990c] Linux 5.18-rc7
> > git bisect start 'HEAD' 'v5.18-rc7'
> > # bad: [f9b63740b666dd9887eb0282d21b5f65bb0cadd0] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> > git bisect bad f9b63740b666dd9887eb0282d21b5f65bb0cadd0
> > # bad: [7db97132097c5973ff77466d0ee681650af653de] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
> > git bisect bad 7db97132097c5973ff77466d0ee681650af653de
> > # good: [2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb] soc: document merges
> > git bisect good 2b7d17d4b7c1ff40f58b0d32be40fc0bb6c582fb
> > # good: [69c9668f853fdd409bb8abbb37d615785510b29a] Merge branch 'clk-next' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git
> > git bisect good 69c9668f853fdd409bb8abbb37d615785510b29a
> > # bad: [1577f290aa0d4c5b29c03c46ef52e4952a21bfbb] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git
> > git bisect bad 1577f290aa0d4c5b29c03c46ef52e4952a21bfbb
> > # good: [34f0971f8ca73d7e5502b4cf299788a9402120f7] powerpc/powernv/flash: Check OPAL flash calls exist before using
> > git bisect good 34f0971f8ca73d7e5502b4cf299788a9402120f7
> > # good: [0349d7dfc70a26b3facd8ca97de34980d4b60954] Merge branch 'mips-next' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
> > git bisect good 0349d7dfc70a26b3facd8ca97de34980d4b60954
> > # bad: [20bfb54d3b121699674c17a854c5ebc7a8f97d81] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
> > git bisect bad 20bfb54d3b121699674c17a854c5ebc7a8f97d81
> > # bad: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
> > git bisect bad 9be8459298eadb39b9fe9974b890239e9c123107
> > # good: [01abdfeac81b5f56062d0a78f2cdc805db937a75] riscv: compat: Support TASK_SIZE for compat mode
> > git bisect good 01abdfeac81b5f56062d0a78f2cdc805db937a75
> > # good: [f4b395e6f1a588ed6c9a30474e58cf6b27b65783] riscv: compat: Add hw capability check for elf
> > git bisect good f4b395e6f1a588ed6c9a30474e58cf6b27b65783
> > # good: [3092eb45637573c5e435fbf5eaf9516316e5f9c6] riscv: compat: vdso: Add setup additional pages implementation
> > git bisect good 3092eb45637573c5e435fbf5eaf9516316e5f9c6
> > # good: [4608c159594fb40a5101357d4f614fdde9ce1fdb] riscv: compat: ptrace: Add compat_arch_ptrace implement
> > git bisect good 4608c159594fb40a5101357d4f614fdde9ce1fdb
> > # first bad commit: [9be8459298eadb39b9fe9974b890239e9c123107] riscv: compat: Add COMPAT Kbuild skeletal support
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
