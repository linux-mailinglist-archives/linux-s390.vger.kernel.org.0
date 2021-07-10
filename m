Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC13C2F13
	for <lists+linux-s390@lfdr.de>; Sat, 10 Jul 2021 04:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbhGJCaU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 9 Jul 2021 22:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234481AbhGJC33 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 9 Jul 2021 22:29:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77C506140A;
        Sat, 10 Jul 2021 02:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625883997;
        bh=OU7RHW8RCJ20JtwD/Ek2scsCmITqJZlaW4FZJH/iKEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxhP42UZEwEOIorVKwioIdrnDuOsqgIAwacENiIteebh99XerUg/uh23ZuN9ad7CZ
         pBfM+8NhOwgak0JDPEwxghY1/vHU4YVLg9ACXE0YqyDwLB/uxEh6Yq4bVf9+YzqWeK
         ImbFpRgcDtCqbqVN2v15nMVv0WHzs4LLG2ia9RvGhUtnJgY5r4SBGEE0EKrMl1otP8
         mphxT8WX1QKHLHxPikFIWqT5LQjB8dP+ttsZVDfU/5+HgUZ+QfzZD7zjheVCH+Hbbz
         SNjJ7nbhqSUiqC5EibM/n8DUzb5qqnXONcWk42oCdvuRDFG7qKzreaFZYV2CsXzQVr
         IJUoQEbpNR9Qg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 72/93] s390/mem_detect: fix tprot() program check new psw handling
Date:   Fri,  9 Jul 2021 22:24:06 -0400
Message-Id: <20210710022428.3169839-72-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710022428.3169839-1-sashal@kernel.org>
References: <20210710022428.3169839-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit da9057576785aaab52e706e76c0475c85b77ec14 ]

The tprot() inline asm temporarily changes the program check new psw
to redirect a potential program check on the diag instruction.
Restoring of the program check new psw is done in C code behind the
inline asm.

This can be problematic, especially if the function is inlined, since
the compiler can reorder instructions in such a way that a different
instruction, which may result in a program check, might be executed
before the program check new psw has been restored.

To avoid such a scenario move restoring into the inline asm. For
consistency reasons move also saving of the original program check new
psw into the inline asm.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/boot/mem_detect.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/s390/boot/mem_detect.c b/arch/s390/boot/mem_detect.c
index 032d68165216..85049541c191 100644
--- a/arch/s390/boot/mem_detect.c
+++ b/arch/s390/boot/mem_detect.c
@@ -115,24 +115,30 @@ static int diag260(void)
 
 static int tprot(unsigned long addr)
 {
-	unsigned long pgm_addr;
+	unsigned long reg1, reg2;
 	int rc = -EFAULT;
-	psw_t old = S390_lowcore.program_new_psw;
+	psw_t old;
 
-	S390_lowcore.program_new_psw.mask = __extract_psw();
 	asm volatile(
-		"	larl	%[pgm_addr],1f\n"
-		"	stg	%[pgm_addr],%[psw_pgm_addr]\n"
+		"	mvc	0(16,%[psw_old]),0(%[psw_pgm])\n"
+		"	epsw	%[reg1],%[reg2]\n"
+		"	st	%[reg1],0(%[psw_pgm])\n"
+		"	st	%[reg2],4(%[psw_pgm])\n"
+		"	larl	%[reg1],1f\n"
+		"	stg	%[reg1],8(%[psw_pgm])\n"
 		"	tprot	0(%[addr]),0\n"
 		"	ipm	%[rc]\n"
 		"	srl	%[rc],28\n"
-		"1:\n"
-		: [pgm_addr] "=&d"(pgm_addr),
-		  [psw_pgm_addr] "=Q"(S390_lowcore.program_new_psw.addr),
-		  [rc] "+&d"(rc)
-		: [addr] "a"(addr)
+		"1:	mvc	0(16,%[psw_pgm]),0(%[psw_old])\n"
+		: [reg1] "=&d" (reg1),
+		  [reg2] "=&a" (reg2),
+		  [rc] "+&d" (rc),
+		  "=Q" (S390_lowcore.program_new_psw.addr),
+		  "=Q" (old)
+		: [psw_old] "a" (&old),
+		  [psw_pgm] "a" (&S390_lowcore.program_new_psw),
+		  [addr] "a" (addr)
 		: "cc", "memory");
-	S390_lowcore.program_new_psw = old;
 	return rc;
 }
 
-- 
2.30.2

