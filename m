Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1F81C279D
	for <lists+linux-s390@lfdr.de>; Sat,  2 May 2020 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgEBS2X (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 2 May 2020 14:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728415AbgEBS2J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 2 May 2020 14:28:09 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8C0420787;
        Sat,  2 May 2020 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588444089;
        bh=WfFnJyyVvTbC5duAB2SWXJeXFXDlbdH44rT7owjbQd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6u/eW3PBh6bh+Boi3Hq0Ay0D78P8KIpEKUgjeQA9obELrC8Kz9mERrOXFAnxDMNI
         YuRCrSceOZWEVnU+mqj3KF/FR6AyD0e7ycUQ7x2rMp1J3lSQY3T5dButP55aPRQn1b
         8i82nhrsIheS3o/B00a8y0N1X8NRXrUDa2ZGcFJ0=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-s390@vger.kernel.org
Subject: [PATCH 4/7] crypto: s390/sha1 - prefix the "sha1_" functions
Date:   Sat,  2 May 2020 11:24:24 -0700
Message-Id: <20200502182427.104383-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200502182427.104383-1-ebiggers@kernel.org>
References: <20200502182427.104383-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Prefix the s390 SHA-1 functions with "s390_sha1_" rather than "sha1_".
This allows us to rename the library function sha_init() to sha1_init()
without causing a naming collision.

Cc: linux-s390@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/s390/crypto/sha1_s390.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/crypto/sha1_s390.c b/arch/s390/crypto/sha1_s390.c
index 7c15542d368547..698b1e6d3c14d1 100644
--- a/arch/s390/crypto/sha1_s390.c
+++ b/arch/s390/crypto/sha1_s390.c
@@ -27,7 +27,7 @@
 
 #include "sha.h"
 
-static int sha1_init(struct shash_desc *desc)
+static int s390_sha1_init(struct shash_desc *desc)
 {
 	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
 
@@ -42,7 +42,7 @@ static int sha1_init(struct shash_desc *desc)
 	return 0;
 }
 
-static int sha1_export(struct shash_desc *desc, void *out)
+static int s390_sha1_export(struct shash_desc *desc, void *out)
 {
 	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
 	struct sha1_state *octx = out;
@@ -53,7 +53,7 @@ static int sha1_export(struct shash_desc *desc, void *out)
 	return 0;
 }
 
-static int sha1_import(struct shash_desc *desc, const void *in)
+static int s390_sha1_import(struct shash_desc *desc, const void *in)
 {
 	struct s390_sha_ctx *sctx = shash_desc_ctx(desc);
 	const struct sha1_state *ictx = in;
@@ -67,11 +67,11 @@ static int sha1_import(struct shash_desc *desc, const void *in)
 
 static struct shash_alg alg = {
 	.digestsize	=	SHA1_DIGEST_SIZE,
-	.init		=	sha1_init,
+	.init		=	s390_sha1_init,
 	.update		=	s390_sha_update,
 	.final		=	s390_sha_final,
-	.export		=	sha1_export,
-	.import		=	sha1_import,
+	.export		=	s390_sha1_export,
+	.import		=	s390_sha1_import,
 	.descsize	=	sizeof(struct s390_sha_ctx),
 	.statesize	=	sizeof(struct sha1_state),
 	.base		=	{
-- 
2.26.2

