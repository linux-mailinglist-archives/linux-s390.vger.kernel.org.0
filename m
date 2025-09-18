Return-Path: <linux-s390+bounces-12975-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB238B52DAE
	for <lists+linux-s390@lfdr.de>; Thu, 11 Sep 2025 11:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FF71C24C8E
	for <lists+linux-s390@lfdr.de>; Thu, 11 Sep 2025 09:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D32EAB72;
	Thu, 11 Sep 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Nqtp9a2k"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2FC2E36F4
	for <linux-s390@vger.kernel.org>; Thu, 11 Sep 2025 09:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584373; cv=none; b=eZjBpuIUrmqEolC/YdaFmaA0XIk0SmOB1+TC1MG8X/OpVM4mKw7YqZm653MuUK1YwG3Kc43g4PO3yifhDEnBH1V3kZOnIlgabhta0BLDY0nVqVGJDVEJbdO1O8zJSO6nziQFa5+nYHh+NsD1OKd5OP7aUMo3A/M/eDD84QJrmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584373; c=relaxed/simple;
	bh=H5PjxiEXFteUg1G8n03MiT+kg/nXlWwwMu+uFRY6ov0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PwJ/ZeW3AV8Envt1F5/+Fc88D+PR+jps2lQD3oToaD4xYqeF/kCf43refgwYTNjAkq8LfRIZICU6351bb8xlOrgk9Vw3DzSfAFus9L7I1BfpKJhsJ/87oJjHP1W/a33bCdNcpgLdvcuXYDJOQYBya1RzeTF5wuJFUYgj2vWs+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Nqtp9a2k; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757584359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7uqwWKKMvk6LwfNxoryFEjMPkkBENIJWBU06q5sP3oU=;
	b=Nqtp9a2kCrIDik6vI34QaGCofRDtjnzgBaPZwHzZAeLH6NMd52a5NoEaQ7egyOlTxNbcDK
	72j2tIoMW86CNdaPjyDhS2o/3LZbVDV9ciSp5wCrESsCPg3uiPkXhm7XxF5wL9kkgldYM0
	7LERG2r2g8Lp30xF0+3gkcakpnsJkHw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] initrd: Fix unused variable warning in rd_load_image() on s390
Date: Thu, 11 Sep 2025 11:49:08 +0200
Message-ID: <20250911094908.1308767-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variables 'rotator' and 'rotate' (used for the progress
indicator) aren't used on s390. Building the kernel with W=1 generates
the following warning:

init/do_mounts_rd.c:192:17: warning: variable 'rotate' set but not used [-Wunused-but-set-variable]
 192 |         unsigned short rotate = 0;
     |                        ^
1 warning generated.

Remove the preprocessor directives and use the IS_ENABLED(CONFIG_S390)
macro instead, allowing the compiler to optimize away unused variables
and avoid the warning on s390.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use IS_ENABLED(CONFIG_S390) instead of the preprocessor directives as
  suggested by Heiko Carstens <hca@linux.ibm.com>
- Link to v1: https://lore.kernel.org/lkml/20250908121303.180886-2-thorsten.blum@linux.dev/
---
 init/do_mounts_rd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/do_mounts_rd.c b/init/do_mounts_rd.c
index ac021ae6e6fa..3cbdf43a42df 100644
--- a/init/do_mounts_rd.c
+++ b/init/do_mounts_rd.c
@@ -191,9 +191,7 @@ int __init rd_load_image(char *from)
 	char *buf = NULL;
 	unsigned short rotate = 0;
 	decompress_fn decompressor = NULL;
-#if !defined(CONFIG_S390)
 	char rotator[4] = { '|' , '/' , '-' , '\\' };
-#endif
 
 	out_file = filp_open("/dev/ram", O_RDWR, 0);
 	if (IS_ERR(out_file))
@@ -255,12 +253,10 @@ int __init rd_load_image(char *from)
 		}
 		kernel_read(in_file, buf, BLOCK_SIZE, &in_pos);
 		kernel_write(out_file, buf, BLOCK_SIZE, &out_pos);
-#if !defined(CONFIG_S390)
-		if (!(i % 16)) {
+		if (!IS_ENABLED(CONFIG_S390) && !(i % 16)) {
 			pr_cont("%c\b", rotator[rotate & 0x3]);
 			rotate++;
 		}
-#endif
 	}
 	pr_cont("done.\n");
 
-- 
2.51.0


