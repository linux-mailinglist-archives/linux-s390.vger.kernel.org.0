Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF03405618
	for <lists+linux-s390@lfdr.de>; Thu,  9 Sep 2021 15:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359383AbhIINR7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Sep 2021 09:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358968AbhIINLk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 9 Sep 2021 09:11:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67578632CB;
        Thu,  9 Sep 2021 12:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631188897;
        bh=26DpxREAUW4RnhxRwr/LD/ekH0ARh3OLBDizhE3yZ2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JUXe3COJN30v67f8Zh5bSDPE3AofFXgnRjYXxi14yJ/+QtAJpTP/wzAwsi+T5SMLM
         qyzitH1hd8UZh+flYlaO2PIowtv4ce3ub1Uu1xtYbjkoOPrZonaZnU88y9YTR55dg0
         eW6Xu2iLArU3CIfD9Gy8OG7YKltEL8AwcdtIaHrvRXOh9s/hmZd015V46x9TkFao/U
         vI245zhzefmAd39j4o0JCDdy6ocOUvj5Xurc9E16TXkJIS/hLcZygvFlF6k7JCR+Gh
         MHeopmUu91u62ZNsumn/JT60fMEjON/c7pbCsbZxl4tT8STUNJCVxPZbcrSY3Ye+UW
         N+dqrEnnLtJow==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 16/35] s390/jump_label: print real address in a case of a jump label bug
Date:   Thu,  9 Sep 2021 08:00:57 -0400
Message-Id: <20210909120116.150912-16-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909120116.150912-1-sashal@kernel.org>
References: <20210909120116.150912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 5492886c14744d239e87f1b0b774b5a341e755cc ]

In case of a jump label print the real address of the piece of code
where a mismatch was detected. This is right before the system panics,
so there is nothing revealed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/jump_label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 083b05f5f5ab..cbc187706648 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -43,7 +43,7 @@ static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
-	pr_emerg("Jump label code mismatch at %pS [%p]\n", ipc, ipc);
+	pr_emerg("Jump label code mismatch at %pS [%px]\n", ipc, ipc);
 	pr_emerg("Found:    %6ph\n", ipc);
 	pr_emerg("Expected: %6ph\n", ipe);
 	pr_emerg("New:      %6ph\n", ipn);
-- 
2.30.2

