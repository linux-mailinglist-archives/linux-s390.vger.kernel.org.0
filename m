Return-Path: <linux-s390+bounces-14237-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E040C0A35F
	for <lists+linux-s390@lfdr.de>; Sun, 26 Oct 2025 06:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CA7A18A3ADA
	for <lists+linux-s390@lfdr.de>; Sun, 26 Oct 2025 05:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A2A277007;
	Sun, 26 Oct 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRVAkIgf"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092FB275AE3;
	Sun, 26 Oct 2025 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457986; cv=none; b=T7KO5pDOnVyx/dcLnTMbWNtHk8gYxkQHAFQv8RyiNwZ6h+/tyAzJdU7zNdNRshGtZMPtHGvDmwflRfH3CplIExSluyNKJwhyopKsqjNecgUkyMuLcwJcm8JnizYK2Nc2yg925at+2buHTQbM9YWqh+iqEij+vPQaxvZeyNx5so8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457986; c=relaxed/simple;
	bh=GCyZqLSJojQX4LemND++76qvdpEf1Eblafr0NXESqYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLIfaCKkAXvKTgR3xqM2QpO91tRszSMEmYOdSKF5UBZODoF1QoLVHXBM+ZNxVMTO/Azei8PzLGWAG89aO83mT/k4zDoP5tlWbmUMLdZbuuki4CARxO74VPCCqII6sTI3rj6wVpP3hOMDrjw72I178mBAS0PqK7ENUxjs4/T1ZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRVAkIgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0EBC4CEF7;
	Sun, 26 Oct 2025 05:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761457985;
	bh=GCyZqLSJojQX4LemND++76qvdpEf1Eblafr0NXESqYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KRVAkIgfwa+dovbgZ/yeDOA7VZ0bi6PGr6wswsdq7ScLz/iDbQ42bjAj8LW+QOnPY
	 EQ0pk487IVPypsHlXF6oLAjTJgz6nr+QNHl7w4DJBjzGmP1HeYttVhiXT3h6RMDy3r
	 k0RnFejMO+p6gne6PjHqiDzci9sV+sybf33ai22PExNaJWRPTNEUc8fW55ZDqDjv7x
	 2NhyEhQbsYBOrh+SQ+K/xQV+N1jm9O+00qCoz5rKRcYq00m9vU8hwAmgpYNWtp+y5W
	 eiFB7ol/cYVmucuu7rLkzRfA9vDDuvP28xTBWcMi/vacIZJsOnLnn7z/9h8mVwPC93
	 uC3OjMr+vIrXw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Holger Dengler <dengler@linux.ibm.com>,
	Harald Freudenberger <freude@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/15] lib/crypto: tests: Add additional SHAKE tests
Date: Sat, 25 Oct 2025 22:50:23 -0700
Message-ID: <20251026055032.1413733-7-ebiggers@kernel.org>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251026055032.1413733-1-ebiggers@kernel.org>
References: <20251026055032.1413733-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the following test cases to cover gaps in the SHAKE testing:

    - test_shake_all_lens_up_to_4096()
    - test_shake_multiple_squeezes()
    - test_shake_with_guarded_bufs()

Remove test_shake256_tiling() and test_shake256_tiling2() since they are
superseded by test_shake_multiple_squeezes().  It provides better test
coverage by using randomized testing.  E.g., it's able to generate a
zero-length squeeze followed by a nonzero-length squeeze, which the
first 7 versions of the SHA-3 patchset handled incorrectly.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/tests/sha3-testvecs.h    |  20 ++-
 lib/crypto/tests/sha3_kunit.c       | 186 ++++++++++++++++++++--------
 scripts/crypto/gen-hash-testvecs.py |  27 +++-
 3 files changed, 174 insertions(+), 59 deletions(-)

diff --git a/lib/crypto/tests/sha3-testvecs.h b/lib/crypto/tests/sha3-testvecs.h
index 9c4c403cc6e06..8d614a5fa0c37 100644
--- a/lib/crypto/tests/sha3-testvecs.h
+++ b/lib/crypto/tests/sha3-testvecs.h
@@ -1,7 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* This file was generated by: ./scripts/crypto/gen-hash-testvecs.py sha3-256 */
+/* This file was generated by: ./scripts/crypto/gen-hash-testvecs.py sha3 */
+
+/* SHA3-256 test vectors */
 
 static const struct {
 	size_t data_len;
 	u8 digest[SHA3_256_DIGEST_SIZE];
 } hash_testvecs[] = {
@@ -227,5 +229,21 @@ static const u8 hash_testvec_consolidated[SHA3_256_DIGEST_SIZE] = {
 	0x3b, 0x33, 0x67, 0xf8, 0xea, 0x92, 0x78, 0x62,
 	0xdd, 0xbe, 0x72, 0x15, 0xbd, 0x6f, 0xfa, 0xe5,
 	0x5e, 0xab, 0x9f, 0xb1, 0xe4, 0x23, 0x7c, 0x2c,
 	0x80, 0xcf, 0x09, 0x75, 0xf8, 0xe2, 0xfa, 0x30,
 };
+
+/* SHAKE test vectors */
+
+static const u8 shake128_testvec_consolidated[SHA3_256_DIGEST_SIZE] = {
+	0x89, 0x88, 0x3a, 0x44, 0xec, 0xfe, 0x3c, 0xeb,
+	0x2f, 0x1c, 0x1d, 0xda, 0x9e, 0x36, 0x64, 0xf0,
+	0x85, 0x4c, 0x49, 0x12, 0x76, 0x5a, 0x4d, 0xe7,
+	0xa8, 0xfd, 0xcd, 0xbe, 0x45, 0xb4, 0x6f, 0xb0,
+};
+
+static const u8 shake256_testvec_consolidated[SHA3_256_DIGEST_SIZE] = {
+	0x5a, 0xfd, 0x66, 0x62, 0x5c, 0x37, 0x2b, 0x41,
+	0x77, 0x1c, 0x01, 0x5d, 0x64, 0x7c, 0x63, 0x7a,
+	0x7c, 0x76, 0x9e, 0xa8, 0xd1, 0xb0, 0x8e, 0x02,
+	0x16, 0x9b, 0xfe, 0x0e, 0xb5, 0xd8, 0x6a, 0xb5,
+};
diff --git a/lib/crypto/tests/sha3_kunit.c b/lib/crypto/tests/sha3_kunit.c
index c267984c4aff1..ed5fbe80337fe 100644
--- a/lib/crypto/tests/sha3_kunit.c
+++ b/lib/crypto/tests/sha3_kunit.c
@@ -245,76 +245,153 @@ static void test_shake256_nist(struct kunit *test)
 		 out, sizeof(out));
 	KUNIT_ASSERT_MEMEQ_MSG(test, out, test_shake256_nist_1600, sizeof(out),
 			       "SHAKE256 gives wrong output for NIST.1600");
 }
 
-/*
- * Output tiling test of SHAKE256; equal output tiles barring the last.  A
- * series of squeezings of the same context should, if laid end-to-end, match a
- * single squeezing of the combined size.
- */
-static void test_shake256_tiling(struct kunit *test)
+static void shake(int alg, const u8 *in, size_t in_len, u8 *out, size_t out_len)
 {
-	struct shake_ctx ctx;
-	u8 out[8 + SHA3_512_DIGEST_SIZE + 8];
+	if (alg == 0)
+		shake128(in, in_len, out, out_len);
+	else
+		shake256(in, in_len, out, out_len);
+}
 
-	for (int tile_size = 1; tile_size < SHAKE256_DEFAULT_SIZE; tile_size++) {
-		int left = SHAKE256_DEFAULT_SIZE;
-		u8 *p = out + 8;
+static void shake_init(struct shake_ctx *ctx, int alg)
+{
+	if (alg == 0)
+		shake128_init(ctx);
+	else
+		shake256_init(ctx);
+}
 
-		memset(out, 0, sizeof(out));
-		shake256_init(&ctx);
-		shake_update(&ctx, test_sha3_sample,
-			     sizeof(test_sha3_sample) - 1);
-		while (left > 0) {
-			int part = umin(tile_size, left);
+/*
+ * Test each of SHAKE128 and SHAKE256 with all input lengths 0 through 4096, for
+ * both input and output.  The input and output lengths cycle through the values
+ * together, so we do 4096 tests total.  To verify all the SHAKE outputs,
+ * compute and verify the SHA3-256 digest of all of them concatenated together.
+ */
+static void test_shake_all_lens_up_to_4096(struct kunit *test)
+{
+	struct sha3_ctx main_ctx;
+	const size_t max_len = 4096;
+	u8 *const in = test_buf;
+	u8 *const out = &test_buf[TEST_BUF_LEN - max_len];
+	u8 main_hash[SHA3_256_DIGEST_SIZE];
+
+	KUNIT_ASSERT_LE(test, 2 * max_len, TEST_BUF_LEN);
+
+	rand_bytes_seeded_from_len(in, max_len);
+	for (int alg = 0; alg < 2; alg++) {
+		sha3_256_init(&main_ctx);
+		for (size_t in_len = 0; in_len <= max_len; in_len++) {
+			size_t out_len = (in_len * 293) % (max_len + 1);
+
+			shake(alg, in, in_len, out, out_len);
+			sha3_update(&main_ctx, out, out_len);
+		}
+		sha3_final(&main_ctx, main_hash);
+		if (alg == 0)
+			KUNIT_ASSERT_MEMEQ_MSG(test, main_hash,
+					       shake128_testvec_consolidated,
+					       sizeof(main_hash),
+					       "shake128() gives wrong output");
+		else
+			KUNIT_ASSERT_MEMEQ_MSG(test, main_hash,
+					       shake256_testvec_consolidated,
+					       sizeof(main_hash),
+					       "shake256() gives wrong output");
+	}
+}
 
-			shake_squeeze(&ctx, p, part);
-			p += part;
-			left -= part;
+/*
+ * Test that a sequence of SHAKE squeezes gives the same output as a single
+ * squeeze of the same total length.
+ */
+static void test_shake_multiple_squeezes(struct kunit *test)
+{
+	const size_t max_len = 512;
+	u8 *ref_out;
+
+	KUNIT_ASSERT_GE(test, TEST_BUF_LEN, 2 * max_len);
+
+	ref_out = kunit_kzalloc(test, max_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ref_out);
+
+	for (int i = 0; i < 2000; i++) {
+		const int alg = rand32() % 2;
+		const size_t in_len = rand_length(max_len);
+		const size_t out_len = rand_length(max_len);
+		const size_t in_offs = rand_offset(max_len - in_len);
+		const size_t out_offs = rand_offset(max_len - out_len);
+		u8 *const in = &test_buf[in_offs];
+		u8 *const out = &test_buf[out_offs];
+		struct shake_ctx ctx;
+		size_t remaining_len, j, num_parts;
+
+		rand_bytes(in, in_len);
+		rand_bytes(out, out_len);
+
+		/* Compute the output using the one-shot function. */
+		shake(alg, in, in_len, ref_out, out_len);
+
+		/* Compute the output using a random sequence of squeezes. */
+		shake_init(&ctx, alg);
+		shake_update(&ctx, in, in_len);
+		remaining_len = out_len;
+		j = 0;
+		num_parts = 0;
+		while (rand_bool()) {
+			size_t part_len = rand_length(remaining_len);
+
+			shake_squeeze(&ctx, &out[j], part_len);
+			num_parts++;
+			j += part_len;
+			remaining_len -= part_len;
+		}
+		if (remaining_len != 0 || rand_bool()) {
+			shake_squeeze(&ctx, &out[j], remaining_len);
+			num_parts++;
 		}
 
-		KUNIT_ASSERT_MEMEQ_MSG(test, out, test_shake256, sizeof(test_shake256),
-				       "SHAKE tile %u gives wrong output", tile_size);
+		/* Verify that the outputs are the same. */
+		KUNIT_ASSERT_MEMEQ_MSG(
+			test, out, ref_out, out_len,
+			"Multi-squeeze test failed with in_len=%zu in_offs=%zu out_len=%zu out_offs=%zu num_parts=%zu alg=%d",
+			in_len, in_offs, out_len, out_offs, num_parts, alg);
 	}
 }
 
 /*
- * Output tiling test of SHAKE256; output tiles getting gradually smaller and
- * then cycling round to medium sized ones.  A series of squeezings of the same
- * context should, if laid end-to-end, match a single squeezing of the combined
- * size.
+ * Test that SHAKE operations on buffers immediately followed by an unmapped
+ * page work as expected.  This catches out-of-bounds memory accesses even if
+ * they occur in assembly code.
  */
-static void test_shake256_tiling2(struct kunit *test)
+static void test_shake_with_guarded_bufs(struct kunit *test)
 {
-	struct shake_ctx ctx;
-	u8 out[8 + SHA3_512_DIGEST_SIZE + 8];
+	const size_t max_len = 512;
+	u8 *reg_buf;
 
-	for (int first_tile_size = 3;
-	     first_tile_size < SHAKE256_DEFAULT_SIZE;
-	     first_tile_size++) {
-		int tile_size = first_tile_size;
-		int left = SHAKE256_DEFAULT_SIZE;
-		u8 *p = out + 8;
-
-		memset(out, 0, sizeof(out));
-		shake256_init(&ctx);
-		shake_update(&ctx, test_sha3_sample,
-			     sizeof(test_sha3_sample) - 1);
-		while (left > 0) {
-			int part = umin(tile_size, left);
-
-			shake_squeeze(&ctx, p, part);
-			p += part;
-			left -= part;
-			tile_size--;
-			if (tile_size < 1)
-				tile_size = 5;
-		}
+	KUNIT_ASSERT_GE(test, TEST_BUF_LEN, max_len);
 
-		KUNIT_ASSERT_MEMEQ_MSG(test, out, test_shake256, sizeof(test_shake256),
-				       "SHAKE tile %u gives wrong output", tile_size);
+	reg_buf = kunit_kzalloc(test, max_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, reg_buf);
+
+	for (int alg = 0; alg < 2; alg++) {
+		for (size_t len = 0; len <= max_len; len++) {
+			u8 *guarded_buf = &test_buf[TEST_BUF_LEN - len];
+
+			rand_bytes(reg_buf, len);
+			memcpy(guarded_buf, reg_buf, len);
+
+			shake(alg, reg_buf, len, reg_buf, len);
+			shake(alg, guarded_buf, len, guarded_buf, len);
+
+			KUNIT_ASSERT_MEMEQ_MSG(
+				test, reg_buf, guarded_buf, len,
+				"Guard page test failed with len=%zu alg=%d",
+				len, alg);
+		}
 	}
 }
 
 static struct kunit_case sha3_test_cases[] = {
 	HASH_KUNIT_CASES,
@@ -324,12 +401,13 @@ static struct kunit_case sha3_test_cases[] = {
 	KUNIT_CASE(test_sha3_512_basic),
 	KUNIT_CASE(test_shake128_basic),
 	KUNIT_CASE(test_shake256_basic),
 	KUNIT_CASE(test_shake128_nist),
 	KUNIT_CASE(test_shake256_nist),
-	KUNIT_CASE(test_shake256_tiling),
-	KUNIT_CASE(test_shake256_tiling2),
+	KUNIT_CASE(test_shake_all_lens_up_to_4096),
+	KUNIT_CASE(test_shake_multiple_squeezes),
+	KUNIT_CASE(test_shake_with_guarded_bufs),
 	KUNIT_CASE(benchmark_hash),
 	{},
 };
 
 static struct kunit_suite sha3_test_suite = {
diff --git a/scripts/crypto/gen-hash-testvecs.py b/scripts/crypto/gen-hash-testvecs.py
index 47f79602e2903..ae2682882cd18 100755
--- a/scripts/crypto/gen-hash-testvecs.py
+++ b/scripts/crypto/gen-hash-testvecs.py
@@ -109,10 +109,22 @@ def gen_unkeyed_testvecs(alg):
         hash_update(ctx, compute_hash(alg, data[:data_len]))
     print_static_u8_array_definition(
             f'hash_testvec_consolidated[{alg_digest_size_const(alg)}]',
             hash_final(ctx))
 
+def gen_additional_sha3_testvecs():
+    max_len = 4096
+    in_data = rand_bytes(max_len)
+    for alg in ['shake128', 'shake256']:
+        ctx = hashlib.new('sha3-256')
+        for in_len in range(max_len + 1):
+            out_len = (in_len * 293) % (max_len + 1)
+            out = hashlib.new(alg, data=in_data[:in_len]).digest(out_len)
+            ctx.update(out)
+        print_static_u8_array_definition(f'{alg}_testvec_consolidated[SHA3_256_DIGEST_SIZE]',
+                                         ctx.digest())
+
 def gen_hmac_testvecs(alg):
     ctx = hmac.new(rand_bytes(32), digestmod=alg)
     data = rand_bytes(4096)
     for data_len in range(len(data) + 1):
         ctx.update(data[:data_len])
@@ -153,21 +165,28 @@ def gen_additional_poly1305_testvecs():
             'poly1305_allones_macofmacs[POLY1305_DIGEST_SIZE]',
             Poly1305(key).update(data).digest())
 
 if len(sys.argv) != 2:
     sys.stderr.write('Usage: gen-hash-testvecs.py ALGORITHM\n')
-    sys.stderr.write('ALGORITHM may be any supported by Python hashlib, or poly1305.\n')
+    sys.stderr.write('ALGORITHM may be any supported by Python hashlib, or poly1305 or sha3.\n')
     sys.stderr.write('Example: gen-hash-testvecs.py sha512\n')
     sys.exit(1)
 
 alg = sys.argv[1]
 print('/* SPDX-License-Identifier: GPL-2.0-or-later */')
 print(f'/* This file was generated by: {sys.argv[0]} {" ".join(sys.argv[1:])} */')
-gen_unkeyed_testvecs(alg)
 if alg.startswith('blake2'):
+    gen_unkeyed_testvecs(alg)
     gen_additional_blake2_testvecs(alg)
 elif alg == 'poly1305':
+    gen_unkeyed_testvecs(alg)
     gen_additional_poly1305_testvecs()
-elif alg.startswith('sha3-'):
-    pass # no HMAC
+elif alg == 'sha3':
+    print()
+    print('/* SHA3-256 test vectors */')
+    gen_unkeyed_testvecs('sha3-256')
+    print()
+    print('/* SHAKE test vectors */')
+    gen_additional_sha3_testvecs()
 else:
+    gen_unkeyed_testvecs(alg)
     gen_hmac_testvecs(alg)
-- 
2.51.1.dirty


