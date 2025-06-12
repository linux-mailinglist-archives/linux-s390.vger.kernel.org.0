Return-Path: <linux-s390+bounces-11040-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78987AD6AB4
	for <lists+linux-s390@lfdr.de>; Thu, 12 Jun 2025 10:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4A0D188AA4F
	for <lists+linux-s390@lfdr.de>; Thu, 12 Jun 2025 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D5F229B12;
	Thu, 12 Jun 2025 08:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lC689Via"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071402288C6
	for <linux-s390@vger.kernel.org>; Thu, 12 Jun 2025 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749716890; cv=none; b=Fn+L1/Hg3v+VA0L0kB3k6BItZUUEqZl71CXUHcFFluBUb2/3J1AH/wdY2Cfu4aB/kp5m6tELow87EbINGEzXA7K177ud6ersFOwAlHPnOGz3MbLkXnvOvqOdcAqeTzZUKaZTGss62EYlMJg7oO6ETI9TxiEQOcJfdbSYS7hiOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749716890; c=relaxed/simple;
	bh=wa3NJsPEjZo2b/QKbicW0EiI4fSq+OLPcvk7PO4wrSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aKmPWakYaOMGt5Ju5XqIf5hvOufK1LEW6isV1G+K/vopLxqgSmMoWt/IbDAIyORJkXTLKG4GQUvGMKWNwhwLslFnOSVkaK4fppG/jCsDEchsLM4Egjsr4EVy0r7E0NL4lPANXZV6iXzx+Kp64xopw3NTNx7ZudBdM7G/9zWq4P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lC689Via; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749716885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+SMqaJRr2gw7tiajb6Lxu2Z2z8tbEjCcRQA4pFVOF8=;
	b=lC689Viaz/2NV57fIl0BJ1lVZVPTi4rseVn5hKRgU9tieWXVdp4iqPcGcsbWmAFMS9wQK8
	3feriPh5QlfbgT6OtRljSbkKI2MtbpLkU1WYvKdb/9nvHpz6olrwacdtPA3wZRdvvQxB1S
	evIAzeIU/aX82uOb2THJm4a/3/IAThU=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH 2/5] alpha: Modify the definition logic of WEAK_PER_CPU
Date: Thu, 12 Jun 2025 16:27:27 +0800
Message-Id: <4d78498def57e0df4c768ad9eb672cac68fb51dc.1749715979.git.gehao@kylinos.cn>
In-Reply-To: <cover.1749715979.git.gehao@kylinos.cn>
References: <cover.1749715979.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

As stated in the first patch of this patch series,
we make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option,
and replace all instances of ARCH_NEEDS_WEAK_PER_CPU
in the kernel code with MODULE_NEEDS_WEAK_PER_CPU,
gated by #ifdef CONFIG_ARCH_NEEDS_WEAK_PER_CPU.

We'll make corresponding changes for the alpha
architecture.

Suggested-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 109a4cddcd13..ce9bc842e384 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -7,6 +7,7 @@ config ALPHA
 	select ARCH_HAS_DMA_OPS if PCI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_NEEDS_WEAK_PER_CPU
 	select ARCH_NO_PREEMPT
 	select ARCH_NO_SG_CHAIN
 	select ARCH_USE_CMPXCHG_LOCKREF
diff --git a/arch/alpha/include/asm/percpu.h b/arch/alpha/include/asm/percpu.h
index 6923249f2d49..5d8b75ec3bf2 100644
--- a/arch/alpha/include/asm/percpu.h
+++ b/arch/alpha/include/asm/percpu.h
@@ -10,8 +10,8 @@
  *
  * Always use weak definitions for percpu variables in modules.
  */
-#if defined(MODULE) && defined(CONFIG_SMP)
-#define ARCH_NEEDS_WEAK_PER_CPU
+#if defined(MODULE) && defined(CONFIG_SMP) && defined(CONFIG_ARCH_NEEDS_WEAK_PER_CPU)
+#define MODULE_NEEDS_WEAK_PER_CPU
 #endif
 
 #include <asm-generic/percpu.h>
-- 
2.25.1


