Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F642117E9
	for <lists+linux-s390@lfdr.de>; Thu,  2 Jul 2020 03:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgGBBXj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 1 Jul 2020 21:23:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728411AbgGBBXj (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04B422083E;
        Thu,  2 Jul 2020 01:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653018;
        bh=ONj7aKbHlOlgWW2rGPQ0J/OhBHcYbrSt/+Ss/muTSBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uwEfIuxQEe4d1vHrxOJ7TvJO8s4QfgyLUvmknhf9xO39+/33f7kmmXxJWjRgemUt
         koLb4gpJE1u/Yf2WoGT1oFuyt5d1G3Nri3hO/XMuuaIV0fUJEydem0gjhOvbVVe59V
         MqCFeog9hWAj8kIins1AwporA2vikWe0FB6mf1wM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 35/53] s390/kasan: fix early pgm check handler execution
Date:   Wed,  1 Jul 2020 21:21:44 -0400
Message-Id: <20200702012202.2700645-35-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

[ Upstream commit 998f5bbe3dbdab81c1cfb1aef7c3892f5d24f6c7 ]

Currently if early_pgm_check_handler is called it ends up in pgm check
loop. The problem is that early_pgm_check_handler is instrumented by
KASAN but executed without DAT flag enabled which leads to addressing
exception when KASAN checks try to access shadow memory.

Fix that by executing early handlers with DAT flag on under KASAN as
expected.

Reported-and-tested-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/early.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index cd241ee66eff4..0782772318580 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -170,6 +170,8 @@ static noinline __init void setup_lowcore_early(void)
 	psw_t psw;
 
 	psw.mask = PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA;
+	if (IS_ENABLED(CONFIG_KASAN))
+		psw.mask |= PSW_MASK_DAT;
 	psw.addr = (unsigned long) s390_base_ext_handler;
 	S390_lowcore.external_new_psw = psw;
 	psw.addr = (unsigned long) s390_base_pgm_handler;
-- 
2.25.1

