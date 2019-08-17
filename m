Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63F910CC
	for <lists+linux-s390@lfdr.de>; Sat, 17 Aug 2019 16:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbfHQOZG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Aug 2019 10:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbfHQOZC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 10:25:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 10CCF189D9EB;
        Sat, 17 Aug 2019 14:25:02 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F28D4E;
        Sat, 17 Aug 2019 14:24:59 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] crypto: sha256_generic - Switch to the generic lib/crypto/sha256.c lib code
Date:   Sat, 17 Aug 2019 16:24:35 +0200
Message-Id: <20190817142435.8532-8-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
References: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Sat, 17 Aug 2019 14:25:02 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Drop the duplicate generic sha256 (and sha224) implementation from
crypto/sha256_generic.c and use the implementation from
lib/crypto/sha256.c instead.

"diff -u lib/crypto/sha256.c sha256_generic.c" shows that the core
sha256_transform function from both implementations is identical and
the other code is functionally identical too.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Not only switch to sha256_transform from lib/crypto/sha256.c but also
  switch to using sha256_init, sha256_update and sha256_final from there
  so that the crypto subsys selftests fully test the lib/crypto/sha256.c
  implementation
---
 crypto/Kconfig          |   1 +
 crypto/sha256_generic.c | 225 ++++------------------------------------
 2 files changed, 19 insertions(+), 207 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3dc3f13dfcad..19bdfa22d60d 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -935,6 +935,7 @@ config CRYPTO_LIB_SHA256
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
+	select CRYPTO_LIB_SHA256
 	help
 	  SHA256 secure hash standard (DFIPS 180-2).
 
diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index dac930ca827d..eafd10f9bf86 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -1,11 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- * Cryptographic API.
- *
- * SHA-256, as specified in
- * http://csrc.nist.gov/groups/STM/cavp/documents/shs/sha256-384-512.pdf
- *
- * SHA-256 code by Jean-Luc Cooke <jlcooke@certainkey.com>.
+ * Crypto API wrapper for the generic SHA256 code from lib/crypto/sha256.c
  *
  * Copyright (c) Jean-Luc Cooke <jlcooke@certainkey.com>
  * Copyright (c) Andrew McDonald <andrew@mcdonald.org.uk>
@@ -18,6 +13,7 @@
 #include <linux/mm.h>
 #include <linux/types.h>
 #include <crypto/sha.h>
+#include <crypto/sha256.h>
 #include <crypto/sha256_base.h>
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
@@ -38,229 +34,44 @@ const u8 sha256_zero_message_hash[SHA256_DIGEST_SIZE] = {
 };
 EXPORT_SYMBOL_GPL(sha256_zero_message_hash);
 
-static inline u32 Ch(u32 x, u32 y, u32 z)
-{
-	return z ^ (x & (y ^ z));
-}
-
-static inline u32 Maj(u32 x, u32 y, u32 z)
+static int crypto_sha256_init(struct shash_desc *desc)
 {
-	return (x & y) | (z & (x | y));
+	return sha256_init(shash_desc_ctx(desc));
 }
 
-#define e0(x)       (ror32(x, 2) ^ ror32(x, 13) ^ ror32(x, 22))
-#define e1(x)       (ror32(x, 6) ^ ror32(x, 11) ^ ror32(x, 25))
-#define s0(x)       (ror32(x, 7) ^ ror32(x, 18) ^ (x >> 3))
-#define s1(x)       (ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10))
-
-static inline void LOAD_OP(int I, u32 *W, const u8 *input)
+static int crypto_sha224_init(struct shash_desc *desc)
 {
-	W[I] = get_unaligned_be32((__u32 *)input + I);
-}
-
-static inline void BLEND_OP(int I, u32 *W)
-{
-	W[I] = s1(W[I-2]) + W[I-7] + s0(W[I-15]) + W[I-16];
-}
-
-static void sha256_transform(u32 *state, const u8 *input)
-{
-	u32 a, b, c, d, e, f, g, h, t1, t2;
-	u32 W[64];
-	int i;
-
-	/* load the input */
-	for (i = 0; i < 16; i++)
-		LOAD_OP(i, W, input);
-
-	/* now blend */
-	for (i = 16; i < 64; i++)
-		BLEND_OP(i, W);
-
-	/* load the state into our registers */
-	a = state[0];  b = state[1];  c = state[2];  d = state[3];
-	e = state[4];  f = state[5];  g = state[6];  h = state[7];
-
-	/* now iterate */
-	t1 = h + e1(e) + Ch(e, f, g) + 0x428a2f98 + W[0];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x71374491 + W[1];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xb5c0fbcf + W[2];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xe9b5dba5 + W[3];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x3956c25b + W[4];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x59f111f1 + W[5];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x923f82a4 + W[6];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xab1c5ed5 + W[7];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xd807aa98 + W[8];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x12835b01 + W[9];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x243185be + W[10];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x550c7dc3 + W[11];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x72be5d74 + W[12];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x80deb1fe + W[13];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x9bdc06a7 + W[14];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xc19bf174 + W[15];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xe49b69c1 + W[16];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xefbe4786 + W[17];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x0fc19dc6 + W[18];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x240ca1cc + W[19];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x2de92c6f + W[20];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x4a7484aa + W[21];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x5cb0a9dc + W[22];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x76f988da + W[23];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x983e5152 + W[24];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xa831c66d + W[25];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xb00327c8 + W[26];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xbf597fc7 + W[27];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0xc6e00bf3 + W[28];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xd5a79147 + W[29];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x06ca6351 + W[30];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x14292967 + W[31];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x27b70a85 + W[32];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x2e1b2138 + W[33];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x4d2c6dfc + W[34];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x53380d13 + W[35];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x650a7354 + W[36];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x766a0abb + W[37];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x81c2c92e + W[38];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x92722c85 + W[39];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0xa2bfe8a1 + W[40];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0xa81a664b + W[41];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0xc24b8b70 + W[42];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0xc76c51a3 + W[43];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0xd192e819 + W[44];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xd6990624 + W[45];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0xf40e3585 + W[46];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x106aa070 + W[47];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x19a4c116 + W[48];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x1e376c08 + W[49];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x2748774c + W[50];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x34b0bcb5 + W[51];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x391c0cb3 + W[52];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0x4ed8aa4a + W[53];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0x5b9cca4f + W[54];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0x682e6ff3 + W[55];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	t1 = h + e1(e) + Ch(e, f, g) + 0x748f82ee + W[56];
-	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
-	t1 = g + e1(d) + Ch(d, e, f) + 0x78a5636f + W[57];
-	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
-	t1 = f + e1(c) + Ch(c, d, e) + 0x84c87814 + W[58];
-	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
-	t1 = e + e1(b) + Ch(b, c, d) + 0x8cc70208 + W[59];
-	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
-	t1 = d + e1(a) + Ch(a, b, c) + 0x90befffa + W[60];
-	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
-	t1 = c + e1(h) + Ch(h, a, b) + 0xa4506ceb + W[61];
-	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
-	t1 = b + e1(g) + Ch(g, h, a) + 0xbef9a3f7 + W[62];
-	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
-	t1 = a + e1(f) + Ch(f, g, h) + 0xc67178f2 + W[63];
-	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
-
-	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
-	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
-
-	/* clear any sensitive info... */
-	a = b = c = d = e = f = g = h = t1 = t2 = 0;
-	memzero_explicit(W, 64 * sizeof(u32));
-}
-
-static void sha256_generic_block_fn(struct sha256_state *sst, u8 const *src,
-				    int blocks)
-{
-	while (blocks--) {
-		sha256_transform(sst->state, src);
-		src += SHA256_BLOCK_SIZE;
-	}
+	return sha224_init(shash_desc_ctx(desc));
 }
 
 int crypto_sha256_update(struct shash_desc *desc, const u8 *data,
 			  unsigned int len)
 {
-	return sha256_base_do_update(desc, data, len, sha256_generic_block_fn);
+	return sha256_update(shash_desc_ctx(desc), data, len);
 }
 EXPORT_SYMBOL(crypto_sha256_update);
 
-static int sha256_final(struct shash_desc *desc, u8 *out)
+static int crypto_sha256_final(struct shash_desc *desc, u8 *out)
 {
-	sha256_base_do_finalize(desc, sha256_generic_block_fn);
-	return sha256_base_finish(desc, out);
+	if (crypto_shash_digestsize(desc->tfm) == SHA224_DIGEST_SIZE)
+		return sha224_final(shash_desc_ctx(desc), out);
+	else
+		return sha256_final(shash_desc_ctx(desc), out);
 }
 
 int crypto_sha256_finup(struct shash_desc *desc, const u8 *data,
 			unsigned int len, u8 *hash)
 {
-	sha256_base_do_update(desc, data, len, sha256_generic_block_fn);
-	return sha256_final(desc, hash);
+	sha256_update(shash_desc_ctx(desc), data, len);
+	return crypto_sha256_final(desc, hash);
 }
 EXPORT_SYMBOL(crypto_sha256_finup);
 
 static struct shash_alg sha256_algs[2] = { {
 	.digestsize	=	SHA256_DIGEST_SIZE,
-	.init		=	sha256_base_init,
+	.init		=	crypto_sha256_init,
 	.update		=	crypto_sha256_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_final,
 	.finup		=	crypto_sha256_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
@@ -272,9 +83,9 @@ static struct shash_alg sha256_algs[2] = { {
 	}
 }, {
 	.digestsize	=	SHA224_DIGEST_SIZE,
-	.init		=	sha224_base_init,
+	.init		=	crypto_sha224_init,
 	.update		=	crypto_sha256_update,
-	.final		=	sha256_final,
+	.final		=	crypto_sha256_final,
 	.finup		=	crypto_sha256_finup,
 	.descsize	=	sizeof(struct sha256_state),
 	.base		=	{
-- 
2.23.0.rc2

