Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1EB0843
	for <lists+linux-s390@lfdr.de>; Thu, 12 Sep 2019 07:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfILF1N (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 12 Sep 2019 01:27:13 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:54825 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfILF1N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 12 Sep 2019 01:27:13 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-08.nifty.com with ESMTP id x8C5OIEp028141
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2019 14:24:18 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x8C5Nti6026272;
        Thu, 12 Sep 2019 14:23:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x8C5Nti6026272
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1568265836;
        bh=JYvxGIDdbHIrCH6vXGu0q1ENkAtg1uD8iiUS3RqpBP8=;
        h=From:To:Cc:Subject:Date:From;
        b=CiiNwjz9Px6G3Z6B062d7R59gGovBQLOYazKoATOz0dzPKkvSphYTtkyPjXf7hvX4
         TODxaGWsU9En17KyEVtadbujJAMgiSTZ7Il6UmL4ZM1K4AO/HcgmH1U3IfrUdEev/Q
         JRVGPJJ5PwMSSBz7pkvqMT4Sj+K9/myYFanCnVDSGkshiwNYR1js72Bv1JWLpaWjvt
         6gzNcc3pP6yiIPs2/du+86Vb8BKXmo2hj4a+6tI6wrBUXRe0sN2JLx8H7eN5HDMVUy
         uPqMtsUqz8rbGm4yihlP7ZwRf4JTNLJIQ2zq4mz/sQ5uip03H5cY6oBvPV/BA4nVDs
         X+KuUSzcBZ4AA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] s390: remove pointless drivers-y in drivers/s390/Makefile
Date:   Thu, 12 Sep 2019 14:23:54 +0900
Message-Id: <20190912052354.24829-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is unused.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/s390/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/Makefile b/drivers/s390/Makefile
index a863b0462b43..cde73b6a9afb 100644
--- a/drivers/s390/Makefile
+++ b/drivers/s390/Makefile
@@ -4,6 +4,3 @@
 #
 
 obj-y += cio/ block/ char/ crypto/ net/ scsi/ virtio/
-
-drivers-y += drivers/s390/built-in.a
-
-- 
2.17.1

