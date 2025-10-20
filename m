Return-Path: <linux-s390+bounces-14003-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14650BEEF20
	for <lists+linux-s390@lfdr.de>; Mon, 20 Oct 2025 02:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8654E7296
	for <lists+linux-s390@lfdr.de>; Mon, 20 Oct 2025 00:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475B1F584C;
	Mon, 20 Oct 2025 00:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX5RdWEl"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0433F1F09A3;
	Mon, 20 Oct 2025 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760921615; cv=none; b=KUPao+g9Jc6JgeAg2l+qbp36YjWHArf1dqWdJEThybi4avw8jcMHrRtiqosZ/0S3FM49QsKiS66so/p3OFnZmNZzfOmcQRlovFr9uZ4F2NycJj40rvxwxeGLAmx4ZtXll7N8q+q/f0lDjRC9tWgAwPq8e8FYid+ddsFhz/lulR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760921615; c=relaxed/simple;
	bh=OaQGEhSD9l9BZYpyT3Hv3bwzyb+UiSiWBVKTKVVAllo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg+OzQ5NO/oIClSKJrVS6DfxkA3nbcdXueeIfUznezVdxUkZGZaNfI/8PFXwDMR6KjybEwjyGwemQxbn/ByrUco6dz/1YeChWm6UPdI4QldeJ62sUfgF8ekNc/AKmmfXgANjdw/bmylz40dmI7cPUxYA+61/27O4UxNMZTg2Di8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX5RdWEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D195C116D0;
	Mon, 20 Oct 2025 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760921614;
	bh=OaQGEhSD9l9BZYpyT3Hv3bwzyb+UiSiWBVKTKVVAllo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YX5RdWElee1yHQDh5fsUq6GWg1Nyxlvce5OuFgBg/ky8IQPLykEwhhWoLE5IhtVLg
	 5hLsqTrpveFOqYKjfgsyqajSVX2R/iWNoP7ETZfTawxlkIOYRQEqDeFlE91g8WqR8V
	 FJf9Kkm2JL3ouQz6OUTors7MU11lcrhzYH9QJzGpX5MftLgDDcKm1KD19dbzTMNrBR
	 FED8CKqORxuobkwstChIcHDajbNukiay28cUsmaON2H8ZqaxUQIZY4gn2Mr9Ra4ZAF
	 gVUe+9uzBP1ALLonpQfDnX7eAAZtnz8zsKJwghxufKpKsurRq7j/84rXSrR1QuxX03
	 35s6H2ghg/ytQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 07/17] lib/crypto: sha3: Use appropriate conversions in sha3_keccakf_generic()
Date: Sun, 19 Oct 2025 17:50:28 -0700
Message-ID: <20251020005038.661542-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251020005038.661542-1-ebiggers@kernel.org>
References: <20251020005038.661542-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For converting from little endian to CPU endian, use le64_to_cpus().
For converting from CPU endian to little endian, use cpu_to_le64s().

No functional change, but this makes the code clearer.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/sha3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
index 2c292b0b3db34..8f08e7b8f4521 100644
--- a/lib/crypto/sha3.c
+++ b/lib/crypto/sha3.c
@@ -168,16 +168,16 @@ static void sha3_keccakf_rounds_generic(struct sha3_state *state)
  * loops are no-ops on LE machines and will be optimised away.
  */
 static void sha3_keccakf_generic(struct sha3_state *state)
 {
 	for (int  i = 0; i < ARRAY_SIZE(state->st); i++)
-		cpu_to_le64s(&state->st[i]);
+		le64_to_cpus(&state->st[i]);
 
 	sha3_keccakf_rounds_generic(state);
 
 	for (int  i = 0; i < ARRAY_SIZE(state->st); i++)
-		le64_to_cpus(&state->st[i]);
+		cpu_to_le64s(&state->st[i]);
 }
 
 static void sha3_absorb_block_generic(struct sha3_ctx *ctx, const u8 *data)
 {
 	struct sha3_state *state = &ctx->state;
-- 
2.51.1.dirty


