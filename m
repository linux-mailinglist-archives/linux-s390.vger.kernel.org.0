Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7550269071A
	for <lists+linux-s390@lfdr.de>; Thu,  9 Feb 2023 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBILYE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Feb 2023 06:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjBILXV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 06:23:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726B45C4A6;
        Thu,  9 Feb 2023 03:18:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2F89619E8;
        Thu,  9 Feb 2023 11:18:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF85C433D2;
        Thu,  9 Feb 2023 11:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675941504;
        bh=UjbjQ8Yer2dYefk720z6z+rFveRSZQ0hi4knrXkKSYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYj3nlPEdpBag0m3QQ9fzBHm+Pf3kZcHXQrLfrOwx0/xtlUtVG+q/snXPNjCkBSwl
         WaShmhr6mgXGZge9sI/bdJysf+bBKwlsbAoTlFT0ejzr2lKbNbfNIuzQelULv4wyep
         rB73Q915jlJKgXna0kuWpDmYl2CppSssuXE67WPRJ9cV2IkFE4xgOidB19a4m9nuD1
         Hfc2cuBxayyfkaV9+hz32y+tnlUG7pGMGzk5ykfxkFuc+LTVkG09bdwgUmDr9pEGcg
         un8B+Uiard6tC70sebbw42okR6NNwL0Thof4m9qKXjpXErPseTFV7ssdUd59AsPT5q
         EQzru5QrZ5skw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, agordeev@linux.ibm.com,
        terrelln@fb.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/17] s390/decompressor: specify __decompress() buf len to avoid overflow
Date:   Thu,  9 Feb 2023 06:17:26 -0500
Message-Id: <20230209111731.1892569-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209111731.1892569-1-sashal@kernel.org>
References: <20230209111731.1892569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 7ab41c2c08a32132ba8c14624910e2fe8ce4ba4b ]

Historically calls to __decompress() didn't specify "out_len" parameter
on many architectures including s390, expecting that no writes beyond
uncompressed kernel image are performed. This has changed since commit
2aa14b1ab2c4 ("zstd: import usptream v1.5.2") which includes zstd library
commit 6a7ede3dfccb ("Reduce size of dctx by reutilizing dst buffer
(#2751)"). Now zstd decompression code might store literal buffer in
the unwritten portion of the destination buffer. Since "out_len" is
not set, it is considered to be unlimited and hence free to use for
optimization needs. On s390 this might corrupt initrd or ipl report
which are often placed right after the decompressor buffer. Luckily the
size of uncompressed kernel image is already known to the decompressor,
so to avoid the problem simply specify it in the "out_len" parameter.

Link: https://github.com/facebook/zstd/commit/6a7ede3dfccb
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Link: https://lore.kernel.org/r/patch-1.thread-41c676.git-41c676c2d153.your-ad-here.call-01675030179-ext-9637@work.hours
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/compressed/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/compressed/decompressor.c b/arch/s390/boot/compressed/decompressor.c
index e27c2140d6206..623f6775d01d7 100644
--- a/arch/s390/boot/compressed/decompressor.c
+++ b/arch/s390/boot/compressed/decompressor.c
@@ -80,6 +80,6 @@ void *decompress_kernel(void)
 	void *output = (void *)decompress_offset;
 
 	__decompress(_compressed_start, _compressed_end - _compressed_start,
-		     NULL, NULL, output, 0, NULL, error);
+		     NULL, NULL, output, vmlinux.image_size, NULL, error);
 	return output;
 }
-- 
2.39.0

