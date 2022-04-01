Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742AB4EF180
	for <lists+linux-s390@lfdr.de>; Fri,  1 Apr 2022 16:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347480AbiDAOiy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 1 Apr 2022 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348219AbiDAOdu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 Apr 2022 10:33:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB4E1EB83A;
        Fri,  1 Apr 2022 07:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E88A61CDB;
        Fri,  1 Apr 2022 14:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDC5C36AE3;
        Fri,  1 Apr 2022 14:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823478;
        bh=+4+u9erDwpVd6Q1UKPkE1PiLgFFNYbV7owQ9PVKUNKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bmb7tUFZtVbzxNU8yngZN3TmbALs2ZWP2f1RHFCJGzpd7Tg6X4f3jlO8jx8MpFdw2
         3qcVTjMI3mpnhoWOwJWFFHoqQmbxPqP0tB1gKNI87olaxQt5D3GYKRTO4ies4CbcdJ
         SeFkIATcfGAmuSS63ITUtufrsci4kBTEpeH4qpGFi2NlVo7Q9RP3M0GU2XUNPc7G2N
         MtYMAHEnZepIXNhkQnVwf93BPY8adoCMpUzjoTTORDb7sJZrSDx8VUC3jK05xAaig3
         EoLkfhAXwUsDOWj6V/tGPCET6++V1NMWlbjbjqthAlOEoKosMOw3mlg0yUyYrE0SIP
         MZbq0nVbgbO+A==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dust Li <dust.li@linux.alibaba.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kgraul@linux.ibm.com,
        kuba@kernel.org, pabeni@redhat.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.17 109/149] net/smc: correct settings of RMB window update limit
Date:   Fri,  1 Apr 2022 10:24:56 -0400
Message-Id: <20220401142536.1948161-109-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401142536.1948161-1-sashal@kernel.org>
References: <20220401142536.1948161-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Dust Li <dust.li@linux.alibaba.com>

[ Upstream commit 6bf536eb5c8ca011d1ff57b5c5f7c57ceac06a37 ]

rmbe_update_limit is used to limit announcing receive
window updating too frequently. RFC7609 request a minimal
increase in the window size of 10% of the receive buffer
space. But current implementation used:

  min_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2)

and SOCK_MIN_SNDBUF / 2 == 2304 Bytes, which is almost
always less then 10% of the receive buffer space.

This causes the receiver always sending CDC message to
update its consumer cursor when it consumes more then 2K
of data. And as a result, we may encounter something like
"TCP silly window syndrome" when sending 2.5~8K message.

This patch fixes this using max(rmbe_size / 10, SOCK_MIN_SNDBUF / 2).

With this patch and SMC autocorking enabled, qperf 2K/4K/8K
tcp_bw test shows 45%/75%/40% increase in throughput respectively.

Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index be7d704976ff..f40f6ed0fbdb 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1989,7 +1989,7 @@ static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
  */
 static inline int smc_rmb_wnd_update_limit(int rmbe_size)
 {
-	return min_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2);
+	return max_t(int, rmbe_size / 10, SOCK_MIN_SNDBUF / 2);
 }
 
 /* map an rmb buf to a link */
-- 
2.34.1

