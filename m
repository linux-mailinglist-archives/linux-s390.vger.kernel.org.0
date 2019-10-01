Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AAEF6C4194
	for <lists+linux-s390@lfdr.de>; Tue,  1 Oct 2019 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfJAUI3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 1 Oct 2019 16:08:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbfJAUI2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 1 Oct 2019 16:08:28 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 860652133F;
        Tue,  1 Oct 2019 20:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569960508;
        bh=uYjcTl7drtwxzzmVd3X+UEiDXfBtSzTArbtfWsMZmVI=;
        h=Date:From:To:cc:Subject:From;
        b=i76blzw6W879H/mTIUJvz7MiAfUeMdzqtm79UsbyS8EAArGfR0I8H4l5XVvnXyXsX
         Vr9dAjUAq2p3qk+GdCe7NLU7nsdbfds5OFQO2Zsagkhf1uGzb8AJWLJdmqlJaUAr3g
         TPDqJZLnMRspY9k6MvyiZLcn9fj8Nyg2K746sW60=
Date:   Tue, 1 Oct 2019 22:08:01 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-s390@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5.4-rc1 BUILD FIX] s390: mark __cpacf_query() as
 __always_inline
Message-ID: <nycvar.YFH.7.76.1910012203010.13160@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

arch/s390/kvm/kvm-s390.c calls on several places __cpacf_query() directly, 
which makes it impossible to meet the "i" constraint for the asm operands 
(opcode in this case).

As we are now force-enabling CONFIG_OPTIMIZE_INLINING on all 
architectures, this causes a build failure on s390:

   In file included from arch/s390/kvm/kvm-s390.c:44:
   ./arch/s390/include/asm/cpacf.h: In function '__cpacf_query':
   ./arch/s390/include/asm/cpacf.h:179:2: warning: asm operand 3 probably doesn't match constraints
     179 |  asm volatile(
         |  ^~~
   ./arch/s390/include/asm/cpacf.h:179:2: error: impossible constraint in 'asm'

Mark __cpacf_query() as __always_inline in order to fix that, analogically 
how we fixes __cpacf_check_opcode(), cpacf_query_func() and scpacf_query() 
already.

Reported-and-tested-by: Michal Kubecek <mkubecek@suse.cz>
Fixes: d83623c5eab2 ("s390: mark __cpacf_check_opcode() and cpacf_query_func() as __always_inline")
Fixes: e60fb8bf68d4 ("s390/cpacf: mark scpacf_query() as __always_inline")
Fixes: ac7c3e4ff401 ("compiler: enable CONFIG_OPTIMIZE_INLINING forcibly")
Fixes: 9012d011660e ("compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

I am wondering how is it possible that none of the build-testing 
infrastructure we have running against linux-next caught this? Not enough 
non-x86 coverage?

 arch/s390/include/asm/cpacf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.h
index a092f63aac6a..c0f3bfeddcbe 100644
--- a/arch/s390/include/asm/cpacf.h
+++ b/arch/s390/include/asm/cpacf.h
@@ -171,7 +171,7 @@ typedef struct { unsigned char bytes[16]; } cpacf_mask_t;
  *
  * Returns 1 if @func is available for @opcode, 0 otherwise
  */
-static inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
+static __always_inline void __cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
 {
 	register unsigned long r0 asm("0") = 0;	/* query function */
 	register unsigned long r1 asm("1") = (unsigned long) mask;

-- 
Jiri Kosina
SUSE Labs

