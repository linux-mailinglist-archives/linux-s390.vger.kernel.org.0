Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9953F5853
	for <lists+linux-s390@lfdr.de>; Tue, 24 Aug 2021 08:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhHXGiK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Aug 2021 02:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhHXGiJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Aug 2021 02:38:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A6C061575;
        Mon, 23 Aug 2021 23:37:26 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id t9so7862852qtp.2;
        Mon, 23 Aug 2021 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yBLv+zxw+1MYMwwTdl8Xhmqj8kBwlIsFFTjAvREXPk=;
        b=RXQ7Eng0abFKtk5sTq1kmvajPFY5kTRyGGxaWYvhCnAWAAnzjVyyTamh4bpCKDH4Kr
         KOrtIXWPZP8jXMzLo2ZPV55Qf96uQLzhadidAIPpvtjXbiJEvii3enE4xZgERTrhJbNP
         DDhUAZ7EuorVbnAQ1qdCt00r8cntI4ObYqRUZOptefdCEGQkBieTpLBTyfxR1so2DniE
         5KTuLQErZz1Nw3CkY5azQuWOiqBnTxkHl6gtcsXIwXAK/jf3I2oFiFX7OcquANHNw8aO
         pC/OMzJD/emhwnLgoKt49F09f2F+KfRUSEsabD5P0LXQmRwmMA78TDhs/lLwHAWOxkmq
         xurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yBLv+zxw+1MYMwwTdl8Xhmqj8kBwlIsFFTjAvREXPk=;
        b=P3a5vOrQySqH9K10LD32HYvz3rjC64XwiOTH/BTvmYdRE+3R+5eh559vf73z7COq3s
         2DiJ4Wk51yDwQE7lxd1oGF5MkmLw8yIF4E2/pdFmgGtgr8G0dTVJCfgDOzK87Dmfg0Lt
         Oxvy1tZRrvPo32iWT81tzNrEt37Mp+eF0pF5X++bh5YjdTcz3t/+xNIUHchIdziex3KC
         Veq6qkg/7YkOlGZVUtnn9+AinQFzeCKMoIxtXJJGlCKkxWBvfZ0+16EI89ArJ1PYXJft
         2c719HSH8L4RXuWukf6U0LgJ06z3bqsevqjwhb0NbEqHVVuGdKzFy/V6fsY3AoO7eGMt
         LzlQ==
X-Gm-Message-State: AOAM531c2Qv3+L3i0sX1Ndnvq3bbXA5v4P/lYfWBvASU5y7vv91+BwRf
        H40FsDvp+XIiAquI7ek2Xdc=
X-Google-Smtp-Source: ABdhPJwNiIggcyNbo9mjFTwWpXOvEnO1JoMFdeT+0Rlc25zUZp4lbXKPI0muHygvzyUrBqU88815rg==
X-Received: by 2002:ac8:4891:: with SMTP id i17mr32948075qtq.321.1629787045407;
        Mon, 23 Aug 2021 23:37:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e10sm10389363qkg.18.2021.08.23.23.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:37:25 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jing Yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] s390:bitops: fix boolreturn.cocci warnings
Date:   Mon, 23 Aug 2021 23:37:17 -0700
Message-Id: <20210824063717.59862-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Jing Yangyang <jing.yangyang@zte.com.cn>

./arch/s390/include/asm/bitops.h:191:9-10:WARNING:return of 0/1 in
function 'arch_test_and_set_bit_lock' with return type bool

Return statements in functions returning bool should use true/false
instead of 1/0.

Generated by: scripts/coccinelle/misc/boolreturn.cocci

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jing Yangyang <jing.yangyang@zte.com.cn>
---
 arch/s390/include/asm/bitops.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index f7cefdd..1d40630 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -188,7 +188,7 @@ static inline bool arch_test_and_set_bit_lock(unsigned long nr,
 					      volatile unsigned long *ptr)
 {
 	if (arch_test_bit(nr, ptr))
-		return 1;
+		return true;
 	return arch_test_and_set_bit(nr, ptr);
 }
 
-- 
1.8.3.1


