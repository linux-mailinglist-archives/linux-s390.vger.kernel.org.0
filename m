Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58080117F14
	for <lists+linux-s390@lfdr.de>; Tue, 10 Dec 2019 05:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfLJErX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 9 Dec 2019 23:47:23 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40884 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJErX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 23:47:23 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so6758288plp.7
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 20:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8tQSVFZXpglTzCwnCQJ/H8jDbSquTv0j0/ujEPlW6k=;
        b=Q5ohWjCIeOzukO5LCkWh2UDZUjzpG6Dg+k5QibSsNEXqnEUsNI3eOHJLFy8voZYt1D
         zWAwzTdpWafUiM/2V3jWWisOZsqR4bWCl+3Si1gmC/LlI61VQXqM8pt6m9UAyMGHCMQR
         a4aAP4oUxg9Iibn2yn+JTh0K/J6050DPkyO3I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y8tQSVFZXpglTzCwnCQJ/H8jDbSquTv0j0/ujEPlW6k=;
        b=YE6TZxopzkt3zv1I5GWSIv5HHuBWAUN32R0jUJwKaRG6U3vnFDZKC3uX73JUq/9ro/
         D31rJuvdu1S2jU4eeD42UW1bP9hKhyO/WuOB66qAzNtrx0XEd4jxJIcr3Fsw2q9ZWAX6
         oiW0M1moiEt6YIQMTKQq5fJBtp/1X0i6OvhO3qS3efBxZt/0/3PkoJQF6pKHLn5ChUhU
         cS7y0OfIIo7ComdX40u4JOtSkDqLOxmA1S5nuPT7YGmI0PNiqNnwG32fceCAzJnIL1Fz
         QgFlh+q4/8p0DQtXscLvD7QnjDf+yyablNorBACr/VODE0M2Cvk1RmRM/ECfYBMEL/lE
         d5iw==
X-Gm-Message-State: APjAAAVtwvJ3idi8S1fjSx70UJRHMT4TvHs8swr0kcozEzt87+JKBkBJ
        NYdEQocdnRRGLUlCf0PkikOPsZCF8z8=
X-Google-Smtp-Source: APXvYqzZzlhFQwpykUHNZoV4iqQbstcouL0rgALlQzDURKcSExHxCCWi3YgmjP5uPHJuX5j1JCnLyA==
X-Received: by 2002:a17:902:9f83:: with SMTP id g3mr30957647plq.234.1575953242726;
        Mon, 09 Dec 2019 20:47:22 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-e460-0b66-7007-c654.static.ipv6.internode.on.net. [2001:44b8:1113:6700:e460:b66:7007:c654])
        by smtp.gmail.com with ESMTPSA id e16sm1159270pgk.77.2019.12.09.20.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 20:47:21 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/4] KASAN for powerpc64 radix, plus generic mm change
Date:   Tue, 10 Dec 2019 15:47:10 +1100
Message-Id: <20191210044714.27265-1-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This provides full inline instrumentation on radix, but does require
that you be able to specify the amount of physically contiguous memory
on the system at compile time. More details in patch 4.

The big change from v1 is the introduction of tree-wide(ish)
MAX_PTRS_PER_{PTE,PMD,PUD} macros in preference to the previous
approach, which was for the arch to override the page table array
definitions with their own. (And I squashed the annoying intermittent
crash!)

Apart from that there's just a lot of cleanup. Christophe, I've
addressed most of what you asked for and I will reply to your v1
emails to clarify what remains unchanged.

Regards,
Daniel

Daniel Axtens (4):
  mm: define MAX_PTRS_PER_{PTE,PMD,PUD}
  kasan: use MAX_PTRS_PER_* for early shadow
  kasan: Document support on 32-bit powerpc
  powerpc: Book3S 64-bit "heavyweight" KASAN support

 Documentation/dev-tools/kasan.rst             |   7 +-
 Documentation/powerpc/kasan.txt               | 112 ++++++++++++++++++
 arch/arm64/include/asm/pgtable-hwdef.h        |   3 +
 arch/powerpc/Kconfig                          |   3 +
 arch/powerpc/Kconfig.debug                    |  21 ++++
 arch/powerpc/Makefile                         |  11 ++
 arch/powerpc/include/asm/book3s/64/hash.h     |   4 +
 arch/powerpc/include/asm/book3s/64/pgtable.h  |   7 ++
 arch/powerpc/include/asm/book3s/64/radix.h    |   5 +
 arch/powerpc/include/asm/kasan.h              |  20 +++-
 arch/powerpc/kernel/process.c                 |   8 ++
 arch/powerpc/kernel/prom.c                    |  59 ++++++++-
 arch/powerpc/mm/kasan/Makefile                |   3 +-
 .../mm/kasan/{kasan_init_32.c => init_32.c}   |   0
 arch/powerpc/mm/kasan/init_book3s_64.c        |  67 +++++++++++
 arch/s390/include/asm/pgtable.h               |   3 +
 arch/x86/include/asm/pgtable_types.h          |   5 +
 arch/xtensa/include/asm/pgtable.h             |   1 +
 include/asm-generic/pgtable-nop4d-hack.h      |   9 +-
 include/asm-generic/pgtable-nopmd.h           |   9 +-
 include/asm-generic/pgtable-nopud.h           |   9 +-
 include/linux/kasan.h                         |   6 +-
 mm/kasan/init.c                               |   6 +-
 23 files changed, 353 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)
 create mode 100644 arch/powerpc/mm/kasan/init_book3s_64.c

-- 
2.20.1

