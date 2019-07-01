Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4099341CD
	for <lists+linux-s390@lfdr.de>; Tue,  4 Jun 2019 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfFDI37 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 4 Jun 2019 04:29:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:57331 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFDI37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Jun 2019 04:29:59 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id x548TsXm016165;
        Tue, 4 Jun 2019 17:29:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com x548TsXm016165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559636994;
        bh=wgPN+vEMC9yLs8VRlcnC/BEteIcw2sS7DW+DFAzIrnw=;
        h=From:To:Cc:Subject:Date:From;
        b=Lsu3ucxmcI56axCWBnGH1GAVLRjnf2cYY2dVKvHvwZ2Yng20JRUEDX0u4KuBItlEb
         /56vFgqvVDnLuDIFa/cGtaE90vX+4/ECuTGXybjnWsO5LoFiRLQS4QGRFIxC7lJRyR
         LJ0YEFknuivGha9fvxRYwmzGWNFwTgGvSMSC2/4024Ynmc/wZY3r+t0eR444t7e5BM
         wJRT7ZYog/AGyOXkQ8uchHcDGaiFwVuUt0w4zKPf/0Qg8ZV7dL9RzPheSRoQdS6AqK
         t0lt7/Ba/aQahCr7NLvw1+8lSEPmCtlPxPaghg14hUdb1VJDxRqQ+Wukkq9OQRZxxU
         igyid8NLlS6mw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: fix unrecognized __aligned() in uapi header
Date:   Tue,  4 Jun 2019 17:29:47 +0900
Message-Id: <20190604082947.26328-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

__aligned() is a shorthand that is only available in the kernel space
because it is defined in include/linux/compiler_attributes.h, which is
not exported to the user space.

Detected by compile-testing exported headers.

./usr/include/asm/runtime_instr.h:60:37: error: expected declaration specifiers or ‘...’ before numeric constant
 } __attribute__((packed)) __aligned(8);
                                     ^

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/include/uapi/asm/runtime_instr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/uapi/asm/runtime_instr.h b/arch/s390/include/uapi/asm/runtime_instr.h
index 45c9ec984e6b..455da46e3193 100644
--- a/arch/s390/include/uapi/asm/runtime_instr.h
+++ b/arch/s390/include/uapi/asm/runtime_instr.h
@@ -57,7 +57,7 @@ struct runtime_instr_cb {
 	__u64 sf;
 	__u64 rsic;
 	__u64 reserved8;
-} __packed __aligned(8);
+} __attribute__((__packed__, __aligned__(8)));
 
 static inline void load_runtime_instr_cb(struct runtime_instr_cb *cb)
 {
-- 
2.17.1

