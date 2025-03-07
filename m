Return-Path: <linux-s390+bounces-9393-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263B8A562B3
	for <lists+linux-s390@lfdr.de>; Fri,  7 Mar 2025 09:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B03A6A2C
	for <lists+linux-s390@lfdr.de>; Fri,  7 Mar 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C0F1A5B91;
	Fri,  7 Mar 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uz4wq5ym"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC41A83FB
	for <linux-s390@vger.kernel.org>; Fri,  7 Mar 2025 08:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336803; cv=none; b=deMinU+OxphDWvFnZKSEphZAp84tGU/raJpWrFWro4iAJHf+q0ud1S7lJVT92h7YNEkqUDfzrpyZOKYHpr37AJOj1MU1gsFjdwgI5KCTCdMSJ7oWZdEpPHzy2NsQGyt4eod5CVoS3fNLo5lDaJFecPO169QOg7DOXqHBP6AcauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336803; c=relaxed/simple;
	bh=VBVPoEXhY3EFS1WlcyWPgXNDZTh+XHjlCNpuBFCKFtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7zBAa85F2bTqhKU/tgJLhn2MthNpNlcgn6rhWTyi51myN7tp9jSPtXN+Or2hCF3pbHwaVcLOr3bToLrmL8tBQgaDUnCG5HYAtg7jJKOfsgSgwiWXNCQecHnwlDfJE9nbsU7Px+Wo+oqi0oL6QUiURt1PTVEwIdvePce6G/26zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uz4wq5ym; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741336795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ot48F+Ve1vTrXZ61ljmBh73Pm4QJUyONFwUOGHruh9o=;
	b=uz4wq5yml4bmviCBIVS+qNlIPWdX8G0qk2oBudCA+96zNxBWVX0jW+ZZi+gq6jM9mau98n
	0ZmPooVKJ+98CB4Ir9+/pi/nNi95nj+HS4vXbSqKUlS/hSDdRCoDn/T9S+I1jVnPei45vX
	ksY713N+KzlansYB20ZNEc4DAy7hs74=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	kvm-riscv@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	alexandru.elisei@arm.com,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com
Subject: [kvm-unit-tests PATCH] Makefile: Use CFLAGS in cc-option
Date: Fri,  7 Mar 2025 09:39:53 +0100
Message-ID: <20250307083952.40999-2-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When cross compiling with clang we need to specify the target in
CFLAGS and cc-option will fail to recognize target-specific options
without it. Add CFLAGS to the CC invocation in cc-option.

Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 78352fced9d4..9dc5d2234e2a 100644
--- a/Makefile
+++ b/Makefile
@@ -21,7 +21,7 @@ DESTDIR := $(PREFIX)/share/kvm-unit-tests/
 
 # cc-option
 # Usage: OP_CFLAGS+=$(call cc-option, -falign-functions=0, -malign-functions=0)
-cc-option = $(shell if $(CC) -Werror $(1) -S -o /dev/null -xc /dev/null \
+cc-option = $(shell if $(CC) $(CFLAGS) -Werror $(1) -S -o /dev/null -xc /dev/null \
               > /dev/null 2>&1; then echo "$(1)"; else echo "$(2)"; fi ;)
 
 libcflat := lib/libcflat.a
-- 
2.48.1


