Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6613C306BA
	for <lists+linux-s390@lfdr.de>; Fri, 31 May 2019 04:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEaCsX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 May 2019 22:48:23 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:29589 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfEaCsX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 May 2019 22:48:23 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x4V2mCYt023870;
        Fri, 31 May 2019 11:48:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x4V2mCYt023870
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559270893;
        bh=Ij0pOCzJB2iFfpknlMBVBCn6Obu++o0pWtkbqK6Q+Lc=;
        h=From:To:Cc:Subject:Date:From;
        b=QZWPpLpcnCynH/qmOUqLwQr/SqY7iXXX7KYvC+qXpBvf4/2jP+TRzwHwbNNxCp1Tw
         AMuay50wALlCln34iz8cXuHFWnTND3/bzd3m3oXiuOUjAoa/A1hfMCtmMPu7t50EZ0
         3K3uhgiCrOz0BJLchx1Em3sk1TBia/zyRRHS8HUfWC58p7s6kEQrTfEbPbN5y0V0Hp
         lS6XG3AlbUDDQ2qksaU5esaizy4Oh7y0t7rM+dRZwcXntD+c2PNwrGOB4dJsvKhGZW
         G9jrhOqXRTJ4eyWVkHObrR3byHBcla4d50VWMQvC/dUMkNAXzOoEDiWeJGyfnnP6Zz
         1tS+uXUU/c6DA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390/purgatory: update .gitignore
Date:   Fri, 31 May 2019 11:46:51 +0900
Message-Id: <20190531024651.5925-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since commit 4c0f032d4963 ("s390/purgatory: Omit use of bin2c"),
kexec-purgatory.c is not generated.

purgatory and purgatory.lds are generated files, so should be ignored
by git.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/s390/purgatory/.gitignore | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/purgatory/.gitignore b/arch/s390/purgatory/.gitignore
index e9e66f178a6d..04a03433c720 100644
--- a/arch/s390/purgatory/.gitignore
+++ b/arch/s390/purgatory/.gitignore
@@ -1,2 +1,3 @@
-kexec-purgatory.c
+purgatory
+purgatory.lds
 purgatory.ro
-- 
2.17.1

