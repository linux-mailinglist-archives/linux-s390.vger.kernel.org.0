Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA6521FC5
	for <lists+linux-s390@lfdr.de>; Tue, 10 May 2022 17:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346531AbiEJPwc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 May 2022 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346775AbiEJPvZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 May 2022 11:51:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DDC15730;
        Tue, 10 May 2022 08:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF2C6614A1;
        Tue, 10 May 2022 15:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442E7C385C2;
        Tue, 10 May 2022 15:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652197554;
        bh=sAbBE4ZK/Gtrs3Du8M9bUK9bxR4OSTLCtTqbA3WnEw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aFZHo18fHP0l3PChKgAzktsYtN0bTbxjaym5ikHwMywd4F6BpMx1UA1+ek3e1lLmX
         EJJe5R/8WQ3Ur2W+adt3KalUp4NqyVC+VDzufDXkK11v4eh1bCUaveALRFLGJV8jpJ
         nlq2rHAhN19Mt5OSYVEW1TKmiMd8jSNke82i/PE1LrP3J/3V+40cBslJClR36XKiVl
         RSK1hEyeMBK08hq9oad8EklI4v957Tr4WPLxV4OYj9yBFR2lrUET4dJhckR0HsyL9r
         vSU4a6ux5Pu9XjWEbiPtsD77Xv3tl6xQyv/pawk6h+e+VfCKSNIhD/ZCShPTqijOuC
         KLwArm40lFEFQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, gor@linux.ibm.com,
        agordeev@linux.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/8] s390: disable -Warray-bounds
Date:   Tue, 10 May 2022 11:45:33 -0400
Message-Id: <20220510154536.154070-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510154536.154070-1-sashal@kernel.org>
References: <20220510154536.154070-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

[ Upstream commit 8b202ee218395319aec1ef44f72043e1fbaccdd6 ]

gcc-12 shows a lot of array bound warnings on s390. This is caused
by the S390_lowcore macro which uses a hardcoded address of 0.

Wrapping that with absolute_pointer() works, but gcc no longer knows
that a 12 bit displacement is sufficient to access lowcore. So it
emits instructions like 'lghi %r1,0; l %rx,xxx(%r1)' instead of a
single load/store instruction. As s390 stores variables often
read/written in lowcore, this is considered problematic. Therefore
disable -Warray-bounds on s390 for gcc-12 for the time being, until
there is a better solution.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Link: https://lore.kernel.org/r/yt9dzgkelelc.fsf@linux.ibm.com
Link: https://lore.kernel.org/r/20220422134308.1613610-1-svens@linux.ibm.com
Link: https://lore.kernel.org/r/20220425121742.3222133-1-svens@linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 2faaf456956a..71e3d7c0b870 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -31,6 +31,16 @@ KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
 KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
 KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
+
+ifdef CONFIG_CC_IS_GCC
+	ifeq ($(call cc-ifversion, -ge, 1200, y), y)
+		ifeq ($(call cc-ifversion, -lt, 1300, y), y)
+			KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
+			KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning, array-bounds)
+		endif
+	endif
+endif
+
 UTS_MACHINE	:= s390x
 STACK_SIZE	:= $(if $(CONFIG_KASAN),65536,16384)
 CHECKFLAGS	+= -D__s390__ -D__s390x__
-- 
2.35.1

