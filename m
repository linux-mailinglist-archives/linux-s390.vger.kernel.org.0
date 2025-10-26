Return-Path: <linux-s390+bounces-14235-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41861C0A338
	for <lists+linux-s390@lfdr.de>; Sun, 26 Oct 2025 06:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4A513B1085
	for <lists+linux-s390@lfdr.de>; Sun, 26 Oct 2025 05:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D6226FD9A;
	Sun, 26 Oct 2025 05:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLEx9Bce"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C7C26D4C2;
	Sun, 26 Oct 2025 05:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761457985; cv=none; b=RmKsvQlPzXRCjOd2RYhwTf5IdbJVVzW1HnnKJbJBmsaAqULyewDwMK2l9z6+CqguwhYmWYhcY27d5KST7c6Gg5OQ0vGE1De24CM3cQ98IjfQyTvvPoKF2ymTpoyr9ApMRW+h+lNecN5FBR3SXhl7cYO/vwD9DAcbMvESUtSoXeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761457985; c=relaxed/simple;
	bh=m54LInOorH439DfIKKGs+6cnPnALMPj8RJ+jLMC/NN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eak9h3kqK+94Iims6zSzMFdEPWidRhVFCkmHM4dmMCLNduBaPFEnyPJu/O8e4SytNcgo2bmE2ywpPev3vpZ9nEUXJpBcsTxM4+yN9GBISGqfEREePH7Bafk1r92IqfR3lu5GZlQzxprTBhJ58FmimalSJeBvKuXF62L9xVTiL1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLEx9Bce; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24267C16AAE;
	Sun, 26 Oct 2025 05:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761457984;
	bh=m54LInOorH439DfIKKGs+6cnPnALMPj8RJ+jLMC/NN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FLEx9Bce1znOT5HplM0dJsPQI6OhFZz5heWCqC6Y9MlLcMFV8p4lxTcLihYKPe3fA
	 A+jxbnQfC0G1rcEOwqdcEsQ6UDUaJyakK0Fh5x5OFsOnu4xhmH0neW4KPFUNFFGlIc
	 pxgCK/8PT9MZT4pSI5JrF+NxvnLrymvurV1ozUEh6bcd1Rg3P6fPJ/nnxCXvNzZYcS
	 hHBjnB4yehlS7N0VA6+3ZyqX9pePKh/Y1iGdFkF/qjkWRTvxKTX1EQWVzIjH7bFfsv
	 kWNBqQewcy7/oaAgEGINhN+BevCdSTivtJ0xcla20ihtsoShB8qrnvEvPzAonQsDhc
	 rWl8O+dTBg50w==
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
Subject: [PATCH v2 03/15] lib/crypto: sha3: Add SHA-3 support
Date: Sat, 25 Oct 2025 22:50:20 -0700
Message-ID: <20251026055032.1413733-4-ebiggers@kernel.org>
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

From: David Howells <dhowells@redhat.com>

Add SHA-3 support to lib/crypto/.  All six algorithms in the SHA-3
family are supported: four digests (SHA3-224, SHA3-256, SHA3-384, and
SHA3-512) and two extendable-output functions (SHAKE128 and SHAKE256).

The SHAKE algorithms will be required for ML-DSA.

Signed-off-by: David Howells <dhowells@redhat.com>
[EB: simplified the API to use fewer types and functions, fixed bug that
     sometimes caused incorrect SHAKE output, cleaned up the
     documentation, dropped an ad-hoc test that was inconsistent with
     the rest of lib/crypto/, and many other cleanups]
Co-developed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 Documentation/crypto/index.rst |   1 +
 Documentation/crypto/sha3.rst  | 119 +++++++++++
 include/crypto/sha3.h          | 308 +++++++++++++++++++++++++++-
 lib/crypto/Kconfig             |   7 +
 lib/crypto/Makefile            |   5 +
 lib/crypto/sha3.c              | 359 +++++++++++++++++++++++++++++++++
 6 files changed, 796 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/crypto/sha3.rst
 create mode 100644 lib/crypto/sha3.c

diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
index 100b47d049c04..4ee667c446f99 100644
--- a/Documentation/crypto/index.rst
+++ b/Documentation/crypto/index.rst
@@ -25,5 +25,6 @@ for cryptographic use cases, as well as programming examples.
    api
    api-samples
    descore-readme
    device_drivers/index
    krb5
+   sha3
diff --git a/Documentation/crypto/sha3.rst b/Documentation/crypto/sha3.rst
new file mode 100644
index 0000000000000..b705e70691d7b
--- /dev/null
+++ b/Documentation/crypto/sha3.rst
@@ -0,0 +1,119 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+==========================
+SHA-3 Algorithm Collection
+==========================
+
+.. contents::
+
+Overview
+========
+
+The SHA-3 family of algorithms, as specified in NIST FIPS-202 [1]_, contains six
+algorithms based on the Keccak sponge function.  The differences between them
+are: the "rate" (how much of the state buffer gets updated with new data between
+invocations of the Keccak function and analogous to the "block size"), what
+domain separation suffix gets appended to the input data, and how much output
+data is extracted at the end.  The Keccak sponge function is designed such that
+arbitrary amounts of output can be obtained for certain algorithms.
+
+Four digest algorithms are provided:
+
+ - SHA3-224
+ - SHA3-256
+ - SHA3-384
+ - SHA3-512
+
+Additionally, two Extendable-Output Functions (XOFs) are provided:
+
+ - SHAKE128
+ - SHAKE256
+
+The SHA-3 library API supports all six of these algorithms.  The four digest
+algorithms are also supported by the crypto_shash and crypto_ahash APIs.
+
+This document describes the SHA-3 library API.
+
+
+Digests
+=======
+
+The following functions compute SHA-3 digests::
+
+	void sha3_224(const u8 *in, size_t in_len, u8 out[SHA3_224_DIGEST_SIZE]);
+	void sha3_256(const u8 *in, size_t in_len, u8 out[SHA3_256_DIGEST_SIZE]);
+	void sha3_384(const u8 *in, size_t in_len, u8 out[SHA3_384_DIGEST_SIZE]);
+	void sha3_512(const u8 *in, size_t in_len, u8 out[SHA3_512_DIGEST_SIZE]);
+
+For users that need to pass in data incrementally, an incremental API is also
+provided.  The incremental API uses the following struct::
+
+	struct sha3_ctx { ... };
+
+Initialization is done with one of::
+
+	void sha3_224_init(struct sha3_ctx *ctx);
+	void sha3_256_init(struct sha3_ctx *ctx);
+	void sha3_384_init(struct sha3_ctx *ctx);
+	void sha3_512_init(struct sha3_ctx *ctx);
+
+Input data is then added with any number of calls to::
+
+	void sha3_update(struct sha3_ctx *ctx, const u8 *in, size_t in_len);
+
+Finally, the digest is generated using::
+
+	void sha3_final(struct sha3_ctx *ctx, u8 *out);
+
+which also zeroizes the context.  The length of the digest is determined by the
+initialization function that was called.
+
+
+Extendable-Output Functions
+===========================
+
+The following functions compute the SHA-3 extendable-output functions (XOFs)::
+
+	void shake128(const u8 *in, size_t in_len, u8 *out, size_t out_len);
+	void shake256(const u8 *in, size_t in_len, u8 *out, size_t out_len);
+
+For users that need to provide the input data incrementally and/or receive the
+output data incrementally, an incremental API is also provided.  The incremental
+API uses the following struct::
+
+	struct shake_ctx { ... };
+
+Initialization is done with one of::
+
+	void shake128_init(struct shake_ctx *ctx);
+	void shake256_init(struct shake_ctx *ctx);
+
+Input data is then added with any number of calls to::
+
+	void shake_update(struct shake_ctx *ctx, const u8 *in, size_t in_len);
+
+Finally, the output data is extracted with any number of calls to::
+
+	void shake_squeeze(struct shake_ctx *ctx, u8 *out, size_t out_len);
+
+and telling it how much data should be extracted.  Note that performing multiple
+squeezes, with the output laid consecutively in a buffer, gets exactly the same
+output as doing a single squeeze for the combined amount over the same buffer.
+
+More input data cannot be added after squeezing has started.
+
+Once all the desired output has been extracted, zeroize the context::
+
+	void shake_zeroize_ctx(struct shake_ctx *ctx);
+
+
+References
+==========
+
+.. [1] https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
+
+
+API Function Reference
+======================
+
+.. kernel-doc:: include/crypto/sha3.h
diff --git a/include/crypto/sha3.h b/include/crypto/sha3.h
index 41e1b83a6d918..a7503dfc1a044 100644
--- a/include/crypto/sha3.h
+++ b/include/crypto/sha3.h
@@ -1,13 +1,16 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Common values for SHA-3 algorithms
+ *
+ * See also Documentation/crypto/sha3.rst
  */
 #ifndef __CRYPTO_SHA3_H__
 #define __CRYPTO_SHA3_H__
 
 #include <linux/types.h>
+#include <linux/string.h>
 
 #define SHA3_224_DIGEST_SIZE	(224 / 8)
 #define SHA3_224_BLOCK_SIZE	(200 - 2 * SHA3_224_DIGEST_SIZE)
 #define SHA3_224_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_224_BLOCK_SIZE + 1
 
@@ -21,16 +24,315 @@
 
 #define SHA3_512_DIGEST_SIZE	(512 / 8)
 #define SHA3_512_BLOCK_SIZE	(200 - 2 * SHA3_512_DIGEST_SIZE)
 #define SHA3_512_EXPORT_SIZE	SHA3_STATE_SIZE + SHA3_512_BLOCK_SIZE + 1
 
+/*
+ * SHAKE128 and SHAKE256 actually have variable output size, but this is used to
+ * calculate the block size (rate) analogously to the above.
+ */
+#define SHAKE128_DEFAULT_SIZE	(128 / 8)
+#define SHAKE128_BLOCK_SIZE	(200 - 2 * SHAKE128_DEFAULT_SIZE)
+#define SHAKE256_DEFAULT_SIZE	(256 / 8)
+#define SHAKE256_BLOCK_SIZE	(200 - 2 * SHAKE256_DEFAULT_SIZE)
+
 #define SHA3_STATE_SIZE		200
 
 struct shash_desc;
 
+int crypto_sha3_init(struct shash_desc *desc);
+
+/*
+ * State for the Keccak-f[1600] permutation: 25 64-bit words.
+ *
+ * We usually keep the state words as little-endian, to make absorbing and
+ * squeezing easier.  (It means that absorbing and squeezing can just treat the
+ * state as a byte array.)  The state words are converted to native-endian only
+ * temporarily by implementations of the permutation that need native-endian
+ * words.  Of course, that conversion is a no-op on little-endian machines.
+ */
 struct sha3_state {
-	u64		st[SHA3_STATE_SIZE / 8];
+	union {
+		u64 st[SHA3_STATE_SIZE / 8]; /* temporarily retained for compatibility purposes */
+
+		__le64 words[SHA3_STATE_SIZE / 8];
+		u8 bytes[SHA3_STATE_SIZE];
+
+		u64 native_words[SHA3_STATE_SIZE / 8]; /* see comment above */
+	};
 };
 
-int crypto_sha3_init(struct shash_desc *desc);
+/* Internal context, shared by the digests (SHA3-*) and the XOFs (SHAKE*) */
+struct __sha3_ctx {
+	struct sha3_state state;
+	u8 digest_size;		/* Digests only: the digest size in bytes */
+	u8 block_size;		/* Block size in bytes */
+	u8 absorb_offset;	/* Index of next state byte to absorb into */
+	u8 squeeze_offset;	/* XOFs only: index of next state byte to extract */
+};
+
+void __sha3_update(struct __sha3_ctx *ctx, const u8 *in, size_t in_len);
+
+/** Context for SHA3-224, SHA3-256, SHA3-384, or SHA3-512 */
+struct sha3_ctx {
+	struct __sha3_ctx ctx;
+};
+
+/**
+ * Zeroize a sha3_ctx.  This is already called by sha3_final().  Call this
+ * explicitly when abandoning a context without calling sha3_final().
+ */
+static inline void sha3_zeroize_ctx(struct sha3_ctx *ctx)
+{
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+
+/** Context for SHAKE128 or SHAKE256 */
+struct shake_ctx {
+	struct __sha3_ctx ctx;
+};
+
+/** Zeroize a shake_ctx.  Call this after the last squeeze. */
+static inline void shake_zeroize_ctx(struct shake_ctx *ctx)
+{
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+
+/**
+ * sha3_224_init() - Initialize a context for SHA3-224
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-224 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_224_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_224_DIGEST_SIZE,
+		.ctx.block_size = SHA3_224_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_256_init() - Initialize a context for SHA3-256
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-256 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_256_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_256_DIGEST_SIZE,
+		.ctx.block_size = SHA3_256_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_384_init() - Initialize a context for SHA3-384
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-384 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_384_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_384_DIGEST_SIZE,
+		.ctx.block_size = SHA3_384_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_512_init() - Initialize a context for SHA3-512
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHA3-512 message digest computation.
+ *
+ * Context: Any context.
+ */
+static inline void sha3_512_init(struct sha3_ctx *ctx)
+{
+	*ctx = (struct sha3_ctx){
+		.ctx.digest_size = SHA3_512_DIGEST_SIZE,
+		.ctx.block_size = SHA3_512_BLOCK_SIZE,
+	};
+}
+
+/**
+ * sha3_update() - Update a SHA-3 digest context with input data
+ * @ctx: The context to update; must have been initialized
+ * @in: The input data
+ * @in_len: Length of the input data in bytes
+ *
+ * This can be called any number of times to add data to a SHA3-224, SHA3-256,
+ * SHA3-384, or SHA3-512 digest (depending on which init function was called).
+ *
+ * Context: Any context.
+ */
+static inline void sha3_update(struct sha3_ctx *ctx,
+			       const u8 *in, size_t in_len)
+{
+	__sha3_update(&ctx->ctx, in, in_len);
+}
+
+/**
+ * sha3_final() - Finish computing a SHA-3 message digest
+ * @ctx: The context to finalize; must have been initialized
+ * @out: (output) The resulting SHA3-224, SHA3-256, SHA3-384, or SHA3-512
+ *	 message digest, matching the init function that was called.  Note that
+ *	 the size differs for each one; see SHA3_*_DIGEST_SIZE.
+ *
+ * After finishing, this zeroizes @ctx.  So the caller does not need to do it.
+ *
+ * Context: Any context.
+ */
+void sha3_final(struct sha3_ctx *ctx, u8 *out);
+
+/**
+ * shake128_init() - Initialize a context for SHAKE128
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHAKE128 extendable-output function (XOF) computation.
+ *
+ * Context: Any context.
+ */
+static inline void shake128_init(struct shake_ctx *ctx)
+{
+	*ctx = (struct shake_ctx){
+		.ctx.block_size = SHAKE128_BLOCK_SIZE,
+	};
+}
+
+/**
+ * shake256_init() - Initialize a context for SHAKE256
+ * @ctx: The context to initialize
+ *
+ * This begins a new SHAKE256 extendable-output function (XOF) computation.
+ *
+ * Context: Any context.
+ */
+static inline void shake256_init(struct shake_ctx *ctx)
+{
+	*ctx = (struct shake_ctx){
+		.ctx.block_size = SHAKE256_BLOCK_SIZE,
+	};
+}
+
+/**
+ * shake_update() - Update a SHAKE context with input data
+ * @ctx: The context to update; must have been initialized
+ * @in: The input data
+ * @in_len: Length of the input data in bytes
+ *
+ * This can be called any number of times to add more input data to SHAKE128 or
+ * SHAKE256.  This cannot be called after squeezing has begun.
+ *
+ * Context: Any context.
+ */
+static inline void shake_update(struct shake_ctx *ctx,
+				const u8 *in, size_t in_len)
+{
+	__sha3_update(&ctx->ctx, in, in_len);
+}
+
+/**
+ * shake_squeeze() - Generate output from SHAKE128 or SHAKE256
+ * @ctx: The context to squeeze; must have been initialized
+ * @out: Where to write the resulting output data
+ * @out_len: The amount of data to extract to @out in bytes
+ *
+ * This may be called multiple times.  A number of consecutive squeezes laid
+ * end-to-end will yield the same output as one big squeeze generating the same
+ * total amount of output.  More input cannot be provided after squeezing has
+ * begun.  After the last squeeze, call shake_zeroize_ctx().
+ *
+ * Context: Any context.
+ */
+void shake_squeeze(struct shake_ctx *ctx, u8 *out, size_t out_len);
+
+/**
+ * sha3_224() - Compute SHA3-224 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-224 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_224(const u8 *in, size_t in_len, u8 out[SHA3_224_DIGEST_SIZE]);
+
+/**
+ * sha3_256() - Compute SHA3-256 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-256 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_256(const u8 *in, size_t in_len, u8 out[SHA3_256_DIGEST_SIZE]);
+
+/**
+ * sha3_384() - Compute SHA3-384 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-384 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_384(const u8 *in, size_t in_len, u8 out[SHA3_384_DIGEST_SIZE]);
+
+/**
+ * sha3_512() - Compute SHA3-512 digest in one shot
+ * @in: The input data to be digested
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the digest will be stored
+ *
+ * Convenience function that computes a SHA3-512 digest.  Use this instead of
+ * the incremental API if you're able to provide all the input at once.
+ *
+ * Context: Any context.
+ */
+void sha3_512(const u8 *in, size_t in_len, u8 out[SHA3_512_DIGEST_SIZE]);
+
+/**
+ * shake128() - Compute SHAKE128 in one shot
+ * @in: The input data to be used
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the output will be stored
+ * @out_len: Length of the output to produce in bytes
+ *
+ * Convenience function that computes SHAKE128 in one shot.  Use this instead of
+ * the incremental API if you're able to provide all the input at once as well
+ * as receive all the output at once.  All output lengths are supported.
+ *
+ * Context: Any context.
+ */
+void shake128(const u8 *in, size_t in_len, u8 *out, size_t out_len);
+
+/**
+ * shake256() - Compute SHAKE256 in one shot
+ * @in: The input data to be used
+ * @in_len: Length of the input data in bytes
+ * @out: The buffer into which the output will be stored
+ * @out_len: Length of the output to produce in bytes
+ *
+ * Convenience function that computes SHAKE256 in one shot.  Use this instead of
+ * the incremental API if you're able to provide all the input at once as well
+ * as receive all the output at once.  All output lengths are supported.
+ *
+ * Context: Any context.
+ */
+void shake256(const u8 *in, size_t in_len, u8 *out, size_t out_len);
 
-#endif
+#endif /* __CRYPTO_SHA3_H__ */
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 280b888153bf0..a05f5a349cd8c 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -193,10 +193,17 @@ config CRYPTO_LIB_SHA512_ARCH
 	default y if RISCV && 64BIT && RISCV_ISA_V && TOOLCHAIN_HAS_VECTOR_CRYPTO
 	default y if S390
 	default y if SPARC64
 	default y if X86_64
 
+config CRYPTO_LIB_SHA3
+	tristate
+	select CRYPTO_LIB_UTILS
+	help
+	  The SHA3 library functions.  Select this if your module uses any of
+	  the functions from <crypto/sha3.h>.
+
 config CRYPTO_LIB_SM3
 	tristate
 
 source "lib/crypto/tests/Kconfig"
 
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index bc26777d08e97..0cfdb511f32b6 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -276,10 +276,15 @@ libsha512-$(CONFIG_X86) += x86/sha512-ssse3-asm.o \
 			   x86/sha512-avx2-asm.o
 endif # CONFIG_CRYPTO_LIB_SHA512_ARCH
 
 ################################################################################
 
+obj-$(CONFIG_CRYPTO_LIB_SHA3) += libsha3.o
+libsha3-y := sha3.o
+
+################################################################################
+
 obj-$(CONFIG_MPILIB) += mpi/
 
 obj-$(CONFIG_CRYPTO_SELFTESTS_FULL)		+= simd.o
 
 obj-$(CONFIG_CRYPTO_LIB_SM3)			+= libsm3.o
diff --git a/lib/crypto/sha3.c b/lib/crypto/sha3.c
new file mode 100644
index 0000000000000..049be8414de26
--- /dev/null
+++ b/lib/crypto/sha3.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SHA-3, as specified in
+ * https://nvlpubs.nist.gov/nistpubs/FIPS/NIST.FIPS.202.pdf
+ *
+ * SHA-3 code by Jeff Garzik <jeff@garzik.org>
+ *               Ard Biesheuvel <ard.biesheuvel@linaro.org>
+ *               David Howells <dhowells@redhat.com>
+ *
+ * See also Documentation/crypto/sha3.rst
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <crypto/sha3.h>
+#include <crypto/utils.h>
+#include <linux/export.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/unaligned.h>
+
+/*
+ * On some 32-bit architectures, such as h8300, GCC ends up using over 1 KB of
+ * stack if the round calculation gets inlined into the loop in
+ * sha3_keccakf_generic().  On the other hand, on 64-bit architectures with
+ * plenty of [64-bit wide] general purpose registers, not inlining it severely
+ * hurts performance.  So let's use 64-bitness as a heuristic to decide whether
+ * to inline or not.
+ */
+#ifdef CONFIG_64BIT
+#define SHA3_INLINE inline
+#else
+#define SHA3_INLINE noinline
+#endif
+
+#define SHA3_KECCAK_ROUNDS 24
+
+static const u64 sha3_keccakf_rndc[SHA3_KECCAK_ROUNDS] = {
+	0x0000000000000001ULL, 0x0000000000008082ULL, 0x800000000000808aULL,
+	0x8000000080008000ULL, 0x000000000000808bULL, 0x0000000080000001ULL,
+	0x8000000080008081ULL, 0x8000000000008009ULL, 0x000000000000008aULL,
+	0x0000000000000088ULL, 0x0000000080008009ULL, 0x000000008000000aULL,
+	0x000000008000808bULL, 0x800000000000008bULL, 0x8000000000008089ULL,
+	0x8000000000008003ULL, 0x8000000000008002ULL, 0x8000000000000080ULL,
+	0x000000000000800aULL, 0x800000008000000aULL, 0x8000000080008081ULL,
+	0x8000000000008080ULL, 0x0000000080000001ULL, 0x8000000080008008ULL
+};
+
+/*
+ * Perform a single round of Keccak mixing.
+ */
+static SHA3_INLINE void sha3_keccakf_one_round_generic(u64 st[25])
+{
+	u64 t[5], tt, bc[5];
+
+	/* Theta */
+	bc[0] = st[0] ^ st[5] ^ st[10] ^ st[15] ^ st[20];
+	bc[1] = st[1] ^ st[6] ^ st[11] ^ st[16] ^ st[21];
+	bc[2] = st[2] ^ st[7] ^ st[12] ^ st[17] ^ st[22];
+	bc[3] = st[3] ^ st[8] ^ st[13] ^ st[18] ^ st[23];
+	bc[4] = st[4] ^ st[9] ^ st[14] ^ st[19] ^ st[24];
+
+	t[0] = bc[4] ^ rol64(bc[1], 1);
+	t[1] = bc[0] ^ rol64(bc[2], 1);
+	t[2] = bc[1] ^ rol64(bc[3], 1);
+	t[3] = bc[2] ^ rol64(bc[4], 1);
+	t[4] = bc[3] ^ rol64(bc[0], 1);
+
+	st[0] ^= t[0];
+
+	/* Rho Pi */
+	tt = st[1];
+	st[ 1] = rol64(st[ 6] ^ t[1], 44);
+	st[ 6] = rol64(st[ 9] ^ t[4], 20);
+	st[ 9] = rol64(st[22] ^ t[2], 61);
+	st[22] = rol64(st[14] ^ t[4], 39);
+	st[14] = rol64(st[20] ^ t[0], 18);
+	st[20] = rol64(st[ 2] ^ t[2], 62);
+	st[ 2] = rol64(st[12] ^ t[2], 43);
+	st[12] = rol64(st[13] ^ t[3], 25);
+	st[13] = rol64(st[19] ^ t[4],  8);
+	st[19] = rol64(st[23] ^ t[3], 56);
+	st[23] = rol64(st[15] ^ t[0], 41);
+	st[15] = rol64(st[ 4] ^ t[4], 27);
+	st[ 4] = rol64(st[24] ^ t[4], 14);
+	st[24] = rol64(st[21] ^ t[1],  2);
+	st[21] = rol64(st[ 8] ^ t[3], 55);
+	st[ 8] = rol64(st[16] ^ t[1], 45);
+	st[16] = rol64(st[ 5] ^ t[0], 36);
+	st[ 5] = rol64(st[ 3] ^ t[3], 28);
+	st[ 3] = rol64(st[18] ^ t[3], 21);
+	st[18] = rol64(st[17] ^ t[2], 15);
+	st[17] = rol64(st[11] ^ t[1], 10);
+	st[11] = rol64(st[ 7] ^ t[2],  6);
+	st[ 7] = rol64(st[10] ^ t[0],  3);
+	st[10] = rol64(    tt ^ t[1],  1);
+
+	/* Chi */
+	bc[ 0] = ~st[ 1] & st[ 2];
+	bc[ 1] = ~st[ 2] & st[ 3];
+	bc[ 2] = ~st[ 3] & st[ 4];
+	bc[ 3] = ~st[ 4] & st[ 0];
+	bc[ 4] = ~st[ 0] & st[ 1];
+	st[ 0] ^= bc[ 0];
+	st[ 1] ^= bc[ 1];
+	st[ 2] ^= bc[ 2];
+	st[ 3] ^= bc[ 3];
+	st[ 4] ^= bc[ 4];
+
+	bc[ 0] = ~st[ 6] & st[ 7];
+	bc[ 1] = ~st[ 7] & st[ 8];
+	bc[ 2] = ~st[ 8] & st[ 9];
+	bc[ 3] = ~st[ 9] & st[ 5];
+	bc[ 4] = ~st[ 5] & st[ 6];
+	st[ 5] ^= bc[ 0];
+	st[ 6] ^= bc[ 1];
+	st[ 7] ^= bc[ 2];
+	st[ 8] ^= bc[ 3];
+	st[ 9] ^= bc[ 4];
+
+	bc[ 0] = ~st[11] & st[12];
+	bc[ 1] = ~st[12] & st[13];
+	bc[ 2] = ~st[13] & st[14];
+	bc[ 3] = ~st[14] & st[10];
+	bc[ 4] = ~st[10] & st[11];
+	st[10] ^= bc[ 0];
+	st[11] ^= bc[ 1];
+	st[12] ^= bc[ 2];
+	st[13] ^= bc[ 3];
+	st[14] ^= bc[ 4];
+
+	bc[ 0] = ~st[16] & st[17];
+	bc[ 1] = ~st[17] & st[18];
+	bc[ 2] = ~st[18] & st[19];
+	bc[ 3] = ~st[19] & st[15];
+	bc[ 4] = ~st[15] & st[16];
+	st[15] ^= bc[ 0];
+	st[16] ^= bc[ 1];
+	st[17] ^= bc[ 2];
+	st[18] ^= bc[ 3];
+	st[19] ^= bc[ 4];
+
+	bc[ 0] = ~st[21] & st[22];
+	bc[ 1] = ~st[22] & st[23];
+	bc[ 2] = ~st[23] & st[24];
+	bc[ 3] = ~st[24] & st[20];
+	bc[ 4] = ~st[20] & st[21];
+	st[20] ^= bc[ 0];
+	st[21] ^= bc[ 1];
+	st[22] ^= bc[ 2];
+	st[23] ^= bc[ 3];
+	st[24] ^= bc[ 4];
+}
+
+/* Generic implementation of the Keccak-f[1600] permutation */
+static void sha3_keccakf_generic(struct sha3_state *state)
+{
+	/*
+	 * Temporarily convert the state words from little-endian to native-
+	 * endian so that they can be operated on.  Note that on little-endian
+	 * machines this conversion is a no-op and is optimized out.
+	 */
+
+	for (int i = 0; i < ARRAY_SIZE(state->words); i++)
+		state->native_words[i] = le64_to_cpu(state->words[i]);
+
+	for (int round = 0; round < SHA3_KECCAK_ROUNDS; round++) {
+		sha3_keccakf_one_round_generic(state->native_words);
+		/* Iota */
+		state->native_words[0] ^= sha3_keccakf_rndc[round];
+	}
+
+	for (int i = 0; i < ARRAY_SIZE(state->words); i++)
+		state->words[i] = cpu_to_le64(state->native_words[i]);
+}
+
+/*
+ * Generic implementation of absorbing the given nonzero number of full blocks
+ * into the sponge function Keccak[r=8*block_size, c=1600-8*block_size].
+ */
+static void __maybe_unused
+sha3_absorb_blocks_generic(struct sha3_state *state, const u8 *data,
+			   size_t nblocks, size_t block_size)
+{
+	do {
+		for (size_t i = 0; i < block_size; i += 8)
+			state->words[i / 8] ^= get_unaligned((__le64 *)&data[i]);
+		sha3_keccakf_generic(state);
+		data += block_size;
+	} while (--nblocks);
+}
+
+#ifdef CONFIG_CRYPTO_LIB_SHA3_ARCH
+#include "sha3.h" /* $(SRCARCH)/sha3.h */
+#else
+#define sha3_keccakf		sha3_keccakf_generic
+#define sha3_absorb_blocks	sha3_absorb_blocks_generic
+#endif
+
+void __sha3_update(struct __sha3_ctx *ctx, const u8 *in, size_t in_len)
+{
+	const size_t block_size = ctx->block_size;
+	size_t absorb_offset = ctx->absorb_offset;
+
+	/* Warn if squeezing has already begun. */
+	WARN_ON_ONCE(absorb_offset >= block_size);
+
+	if (absorb_offset && absorb_offset + in_len >= block_size) {
+		crypto_xor(&ctx->state.bytes[absorb_offset], in,
+			   block_size - absorb_offset);
+		in += block_size - absorb_offset;
+		in_len -= block_size - absorb_offset;
+		sha3_keccakf(&ctx->state);
+		absorb_offset = 0;
+	}
+
+	if (in_len >= block_size) {
+		size_t nblocks = in_len / block_size;
+
+		sha3_absorb_blocks(&ctx->state, in, nblocks, block_size);
+		in += nblocks * block_size;
+		in_len -= nblocks * block_size;
+	}
+
+	if (in_len) {
+		crypto_xor(&ctx->state.bytes[absorb_offset], in, in_len);
+		absorb_offset += in_len;
+	}
+	ctx->absorb_offset = absorb_offset;
+}
+EXPORT_SYMBOL_GPL(__sha3_update);
+
+void sha3_final(struct sha3_ctx *sha3_ctx, u8 *out)
+{
+	struct __sha3_ctx *ctx = &sha3_ctx->ctx;
+
+	ctx->state.bytes[ctx->absorb_offset] ^= 0x06;
+	ctx->state.bytes[ctx->block_size - 1] ^= 0x80;
+	sha3_keccakf(&ctx->state);
+	memcpy(out, ctx->state.bytes, ctx->digest_size);
+	sha3_zeroize_ctx(sha3_ctx);
+}
+EXPORT_SYMBOL_GPL(sha3_final);
+
+void shake_squeeze(struct shake_ctx *shake_ctx, u8 *out, size_t out_len)
+{
+	struct __sha3_ctx *ctx = &shake_ctx->ctx;
+	const size_t block_size = ctx->block_size;
+	size_t squeeze_offset = ctx->squeeze_offset;
+
+	if (ctx->absorb_offset < block_size) {
+		/* First squeeze: */
+
+		/* Add the domain separation suffix and padding. */
+		ctx->state.bytes[ctx->absorb_offset] ^= 0x1f;
+		ctx->state.bytes[block_size - 1] ^= 0x80;
+
+		/* Indicate that squeezing has begun. */
+		ctx->absorb_offset = block_size;
+
+		/*
+		 * Indicate that no output is pending yet, i.e. sha3_keccakf()
+		 * will need to be called before the first copy.
+		 */
+		squeeze_offset = block_size;
+	}
+	while (out_len) {
+		if (squeeze_offset == block_size) {
+			sha3_keccakf(&ctx->state);
+			squeeze_offset = 0;
+		}
+		size_t copy = min(out_len, block_size - squeeze_offset);
+
+		memcpy(out, &ctx->state.bytes[squeeze_offset], copy);
+		out += copy;
+		out_len -= copy;
+		squeeze_offset += copy;
+	}
+	ctx->squeeze_offset = squeeze_offset;
+}
+EXPORT_SYMBOL_GPL(shake_squeeze);
+
+void sha3_224(const u8 *in, size_t in_len, u8 out[SHA3_224_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	sha3_224_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+EXPORT_SYMBOL_GPL(sha3_224);
+
+void sha3_256(const u8 *in, size_t in_len, u8 out[SHA3_256_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	sha3_256_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+EXPORT_SYMBOL_GPL(sha3_256);
+
+void sha3_384(const u8 *in, size_t in_len, u8 out[SHA3_384_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	sha3_384_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+EXPORT_SYMBOL_GPL(sha3_384);
+
+void sha3_512(const u8 *in, size_t in_len, u8 out[SHA3_512_DIGEST_SIZE])
+{
+	struct sha3_ctx ctx;
+
+	sha3_512_init(&ctx);
+	sha3_update(&ctx, in, in_len);
+	sha3_final(&ctx, out);
+}
+EXPORT_SYMBOL_GPL(sha3_512);
+
+void shake128(const u8 *in, size_t in_len, u8 *out, size_t out_len)
+{
+	struct shake_ctx ctx;
+
+	shake128_init(&ctx);
+	shake_update(&ctx, in, in_len);
+	shake_squeeze(&ctx, out, out_len);
+	shake_zeroize_ctx(&ctx);
+}
+EXPORT_SYMBOL_GPL(shake128);
+
+void shake256(const u8 *in, size_t in_len, u8 *out, size_t out_len)
+{
+	struct shake_ctx ctx;
+
+	shake256_init(&ctx);
+	shake_update(&ctx, in, in_len);
+	shake_squeeze(&ctx, out, out_len);
+	shake_zeroize_ctx(&ctx);
+}
+EXPORT_SYMBOL_GPL(shake256);
+
+#ifdef sha3_mod_init_arch
+static int __init sha3_mod_init(void)
+{
+	sha3_mod_init_arch();
+	return 0;
+}
+subsys_initcall(sha3_mod_init);
+
+static void __exit sha3_mod_exit(void)
+{
+}
+module_exit(sha3_mod_exit);
+#endif
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("SHA-3 library functions");
-- 
2.51.1.dirty


