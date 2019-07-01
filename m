Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E07441AECA
	for <lists+linux-s390@lfdr.de>; Mon, 13 May 2019 04:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbfEMCMY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 12 May 2019 22:12:24 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:24241 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfEMCMY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 12 May 2019 22:12:24 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x4D2BJwo025732;
        Mon, 13 May 2019 11:11:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x4D2BJwo025732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557713482;
        bh=Ki33WvIZU3LaqBjqYiKvhfq/zDFbB4ISi/hM3l/rztg=;
        h=From:To:Cc:Subject:Date:From;
        b=k/5Reo06TUdR1kj56Zht7D154bedNwvBghzFabexspXt8JTRklu+oWGrEEBg9dne8
         zhOqKbE6Wl3RRYbFv7zEi1LVPpS2pFArvYXb4M+1grNhrxZGF+U8VsPxRQFQGvoyOR
         INejwQ4yo8ZSVeD58tQp3yMjN+hTZwl8XLPbLb22lv1SfeMsDA+VhVKQWDv5yYW54j
         nJep+VnOy6HM84BR8GWXDczQ3zVZgINsEFIdM1a8APWZGhQFURizRqbe3snYFtV9oQ
         WHDB1x1LeLXLgFbJdyfTSrtkOAF4QhQ1yMlNV3KaODW9UUYDPqL532kZY/bPAZwrxJ
         cJ5DC/+IqbXMA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greentime Hu <green.hu@gmail.com>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Vincent Chen <deanbo422@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH] s390: move arch/s390/defconfig to arch/s390/configs/defconfig
Date:   Mon, 13 May 2019 11:11:16 +0900
Message-Id: <20190513021116.12191-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

As of Linux 5.1, alpha and s390 are the last architectures that
have defconfig in arch/*/ instead of arch/*/configs/.

  $ find arch -name defconfig | sort
  arch/alpha/defconfig
  arch/arm64/configs/defconfig
  arch/csky/configs/defconfig
  arch/nds32/configs/defconfig
  arch/riscv/configs/defconfig
  arch/s390/defconfig

The arch/$(ARCH)/defconfig is the hard-coded default in Kconfig,
and I want to deprecate it after evacuating the remaining defconfig
into the standard location, arch/*/configs/.

Define KBUILD_DEFCONFIG like other architectures, and move defconfig
into the configs/ subdirectory.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/Makefile                | 2 ++
 arch/s390/{ => configs}/defconfig | 0
 2 files changed, 2 insertions(+)
 rename arch/s390/{ => configs}/defconfig (100%)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index df1d6a150f30..de8521fc9de5 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -10,6 +10,8 @@
 # Copyright (C) 1994 by Linus Torvalds
 #
 
+KBUILD_DEFCONFIG := defconfig
+
 LD_BFD		:= elf64-s390
 KBUILD_LDFLAGS	:= -m elf64_s390
 KBUILD_AFLAGS_MODULE += -fPIC
diff --git a/arch/s390/defconfig b/arch/s390/configs/defconfig
similarity index 100%
rename from arch/s390/defconfig
rename to arch/s390/configs/defconfig
-- 
2.17.1

