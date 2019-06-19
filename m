Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA5A4B116
	for <lists+linux-s390@lfdr.de>; Wed, 19 Jun 2019 07:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbfFSFKS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Jun 2019 01:10:18 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59159 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSFKS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 19 Jun 2019 01:10:18 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C1E8920008;
        Wed, 19 Jun 2019 05:10:11 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org,
        Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 1/8] s390: Start fallback of top-down mmap at mm->mmap_base
Date:   Wed, 19 Jun 2019 01:08:37 -0400
Message-Id: <20190619050844.5294-2-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619050844.5294-1-alex@ghiti.fr>
References: <20190619050844.5294-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In case of mmap failure in top-down mode, there is no need to go through
the whole address space again for the bottom-up fallback: the goal of this
fallback is to find, as a last resort, space between the top-down mmap base
and the stack, which is the only place not covered by the top-down mmap.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/s390/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index cbc718ba6d78..4a222969843b 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -166,7 +166,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr & ~PAGE_MASK) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = TASK_UNMAPPED_BASE;
+		info.low_limit = mm->mmap_base;
 		info.high_limit = TASK_SIZE;
 		addr = vm_unmapped_area(&info);
 		if (addr & ~PAGE_MASK)
-- 
2.20.1

