Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C824C214E1
	for <lists+linux-s390@lfdr.de>; Fri, 17 May 2019 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfEQHyo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 May 2019 03:54:44 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:17218 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfEQHyo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 May 2019 03:54:44 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id x4H7sUrb022599;
        Fri, 17 May 2019 16:54:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com x4H7sUrb022599
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1558079671;
        bh=fI8geIfKcJjtLMBH2kM/GgXVcwN/IVNzAUovAe1UXsc=;
        h=From:To:Cc:Subject:Date:From;
        b=ioE8SuyzTmCa9C8tzMpHQjEddblIpOXlH4wfiJXcpgYfSooooiNArigKBFgHPcSEC
         OekUnE3aXgK6ZEszomjBh49yRuOCqZJ7SaIDoRupSsy6lWclUqiHDOR5J2b09MjsiK
         GpHbz9XicohZi1yqsTvIPlvdr16YvZDFGbpSAYjEiKm7z2cYKL2m4s1PPunv++I/5P
         efq3ktV1at260IjTCyDBt3rJ/c/+oXDBduy/lWmtigPBaNPCAIzH7yaKvPWMdeOwi0
         fx4WGmFpmd9CitA6jto8pwMMN94qBOfakpyv0+/BAKWM0HZ5ivDkZjnko3n2UITRLj
         +XVmGhzbLVQBQ==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] s390: do not pass $(LINUXINCLUDE) to gen_opcode_table.c
Date:   Fri, 17 May 2019 16:54:24 +0900
Message-Id: <20190517075428.13496-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I guess HOSTCFLAGS_gen_opcode_table.o was blindly copied from
HOSTCFLAGS_gen_facilities.o

The reason of adding $(LINUXINCLUDE) to HOSTCFLAGS_gen_facilities.o
is because gen_facilities.c references some CONFIG options. (Kbuild
does not cater to this for host tools automatically.)

On the other hand, gen_opcode_table.c does not reference CONFIG
options at all. So, there is no good reason to pass $(LINUXINCLUDE).

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/tools/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index 2342b84b3386..4ff6a2124522 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -15,7 +15,7 @@ hostprogs-y		    += gen_facilities
 hostprogs-y		    += gen_opcode_table
 
 HOSTCFLAGS_gen_facilities.o += -Wall $(LINUXINCLUDE)
-HOSTCFLAGS_gen_opcode_table.o += -Wall $(LINUXINCLUDE)
+HOSTCFLAGS_gen_opcode_table.o += -Wall
 
 # Ensure output directory exists
 _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
-- 
2.17.1

