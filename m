Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB48F1BBE0
	for <lists+linux-s390@lfdr.de>; Mon, 13 May 2019 19:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731646AbfEMR0z (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 13 May 2019 13:26:55 -0400
Received: from utopia.booyaka.com ([74.50.51.50]:50198 "EHLO
        utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfEMR0z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 May 2019 13:26:55 -0400
Received: (qmail 5770 invoked by uid 1019); 13 May 2019 17:20:13 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 May 2019 17:20:13 -0000
Date:   Mon, 13 May 2019 17:20:13 +0000 (UTC)
From:   Paul Walmsley <paul@pwsan.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
cc:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>
Subject: Re: [PATCH] s390: move arch/s390/defconfig to
 arch/s390/configs/defconfig
In-Reply-To: <20190513021116.12191-1-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.21.999.1905131719430.5613@utopia.booyaka.com>
References: <20190513021116.12191-1-yamada.masahiro@socionext.com>
User-Agent: Alpine 2.21.999 (DEB 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 13 May 2019, Masahiro Yamada wrote:

> As of Linux 5.1, alpha and s390 are the last architectures that
> have defconfig in arch/*/ instead of arch/*/configs/.
> 
>   $ find arch -name defconfig | sort
>   arch/alpha/defconfig
>   arch/arm64/configs/defconfig
>   arch/csky/configs/defconfig
>   arch/nds32/configs/defconfig
>   arch/riscv/configs/defconfig
>   arch/s390/defconfig
> 
> The arch/$(ARCH)/defconfig is the hard-coded default in Kconfig,
> and I want to deprecate it after evacuating the remaining defconfig
> into the standard location, arch/*/configs/.
> 
> Define KBUILD_DEFCONFIG like other architectures, and move defconfig
> into the configs/ subdirectory.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Paul Walmsley <paul@pwsan.com>

- Paul
