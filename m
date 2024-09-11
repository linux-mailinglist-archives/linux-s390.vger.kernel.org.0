Return-Path: <linux-s390+bounces-6008-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D6974E48
	for <lists+linux-s390@lfdr.de>; Wed, 11 Sep 2024 11:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9D01C26A68
	for <lists+linux-s390@lfdr.de>; Wed, 11 Sep 2024 09:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84117E918;
	Wed, 11 Sep 2024 09:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ukkq+j7D"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582E0183CBC
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046062; cv=none; b=uwfLVi4IZj0v2l2ONB5CUkImZWckmwNR9yle2uWWV3UlKvAIC8GjSpLFVCr9+H7CbEWUi3M8aHXHeEXE3wUXPfgI4H/9XaIlwOLSLAvxJV1g3faYWnCtzVdpR33fO821ZdpCtVFPL3ESPmglFqfqgbucLw3m/p2+RA3ZuGLbASg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046062; c=relaxed/simple;
	bh=fxWazOowneATN/NMms7JegZApQ3fmiARD6aivGAAY18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ayNAxqvQZpLXHOuz6KI2AShOeYAlORT2oD+SiFQG8sjS25f/aKOKxgFk6M5tondX2FTMzGeDTIEfFV4kj287/9e5mdPeKx5z8mB4ECCa88zQ1OjlS0k/LLPbBbmSe7xiUD52W57rVqtQtE3cCGQLd3sM063OyJ/4rUUH24o0cRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ukkq+j7D; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1726046058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PG2DAax+JlcWtQamyINUSDmt+za3swHNY4VA8lUVONc=;
	b=ukkq+j7DSgzu99+s4/Sj7crBGzDfShHZKTFs2u72WegAsbbYuORO7jgNfgze3vogvP3D6k
	3vpzTR+AZ1TXwx5pqiziUb+WHgS55/sAqA3h9+fYA90AAidxkqm/fOe0VJ64UegmgY/FWJ
	+I4h4bD34o4s0knIOFV/gn/cq7bPnfs=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH v3 1/5] riscv: Drop mstrict-align
Date: Wed, 11 Sep 2024 11:14:08 +0200
Message-ID: <20240911091406.134240-8-andrew.jones@linux.dev>
In-Reply-To: <20240911091406.134240-7-andrew.jones@linux.dev>
References: <20240911091406.134240-7-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The spec says unaligned accesses are supported, so this isn't required
and clang doesn't support it. A platform might have slow unaligned
accesses, but kvm-unit-tests isn't about speed anyway.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 riscv/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/riscv/Makefile b/riscv/Makefile
index 179a373dbacf..22fd273acac3 100644
--- a/riscv/Makefile
+++ b/riscv/Makefile
@@ -76,7 +76,9 @@ LDFLAGS += -melf32lriscv
 endif
 CFLAGS += -DCONFIG_RELOC
 CFLAGS += -mcmodel=medany
-CFLAGS += -mstrict-align
+# Unaligned accesses are allowed, but may be emulated by M-mode.
+# Enable -mstrict-align if that's troublesome (only supported by gcc).
+#CFLAGS += -mstrict-align
 CFLAGS += -std=gnu99
 CFLAGS += -ffreestanding
 CFLAGS += -O2
-- 
2.46.0


