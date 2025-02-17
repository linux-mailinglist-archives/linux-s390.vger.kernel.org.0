Return-Path: <linux-s390+bounces-8934-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F64A336A1
	for <lists+linux-s390@lfdr.de>; Thu, 13 Feb 2025 05:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48ACA16862A
	for <lists+linux-s390@lfdr.de>; Thu, 13 Feb 2025 04:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E34205AD2;
	Thu, 13 Feb 2025 04:09:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF8C1EA84;
	Thu, 13 Feb 2025 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419786; cv=none; b=VKW4C1W98darRZTsUCkBEeNs+xvDxUJ07iJqkkaYSIFWRE5v9+mBT/Tad6Ah5XZ+mRBR6+clJOOxUoPJhsN1VHRL9MuzkI+9aDF0H+cbzGqMxXk+C8jd1APsr8JBP8FxmfFLN/TPKQuKISgVCxzRX7QMz5ACbO2gVvaZ1WRITn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419786; c=relaxed/simple;
	bh=fF+scaVAOJHnnPShBVJxF77OBbMjiz4BhCYJq1eD+dc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EGPgvNH5tSBYCz6YLSQEjSXCRNS1LD2ceD4YhMqMNvz55739v+Z3NuV3TJwVnPM4yGTYxoB202rASjneMyckNKpVYaOeJvfvXVbg+mO8DyyjjNwMcQEsgRuA4kRhV6DDRBG3BzeCupUiuW6NlJixE7ALkYx9tljI+zL2bR7SEp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8488D1756;
	Wed, 12 Feb 2025 20:10:03 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.16.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E87813F58B;
	Wed, 12 Feb 2025 20:09:38 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: steven.price@arm.com,
	christophe.leroy@csgroup.eu,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 0/4] mm: Rework generic PTDUMP configs
Date: Thu, 13 Feb 2025 09:39:30 +0530
Message-Id: <20250213040934.3245750-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series reworks generic PTDUMP configs before eventually renaming them
after some basic clean ups first. This is derived after splitting changes
from the following patch.

https://lore.kernel.org/all/20250205050039.1506377-1-anshuman.khandual@arm.com/

This series applies on v6.14-rc2 and has been tested on arm64. Although it
also builds on other platforms as well.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-s390@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (4):
  configs: Drop GENERIC_PTDUMP from debug.config
  mm: Make DEBUG_WX depdendent on GENERIC_PTDUMP
  mm: Make GENERIC_PTDUMP dependent on MMU
  mm: Rename GENERIC_PTDUMP and PTDUMP_CORE

 Documentation/arch/arm64/ptdump.rst       |  4 ++--
 arch/arm64/Kconfig                        |  2 +-
 arch/arm64/include/asm/ptdump.h           |  4 ++--
 arch/arm64/kvm/Kconfig                    |  4 ++--
 arch/arm64/mm/Makefile                    |  2 +-
 arch/powerpc/Kconfig                      |  2 +-
 arch/powerpc/configs/mpc885_ads_defconfig |  2 +-
 arch/powerpc/mm/Makefile                  |  2 +-
 arch/riscv/Kconfig                        |  2 +-
 arch/riscv/mm/Makefile                    |  2 +-
 arch/s390/Kconfig                         |  2 +-
 arch/s390/mm/Makefile                     |  2 +-
 arch/x86/Kconfig                          |  2 +-
 arch/x86/Kconfig.debug                    |  2 +-
 arch/x86/mm/Makefile                      |  2 +-
 kernel/configs/debug.config               |  1 -
 mm/Kconfig.debug                          | 12 +++++++-----
 mm/Makefile                               |  2 +-
 18 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.25.1


