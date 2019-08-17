Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119FB910D0
	for <lists+linux-s390@lfdr.de>; Sat, 17 Aug 2019 16:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfHQOYr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Aug 2019 10:24:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQOYr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 17 Aug 2019 10:24:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7C67800DEB;
        Sat, 17 Aug 2019 14:24:46 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B01044E;
        Sat, 17 Aug 2019 14:24:43 +0000 (UTC)
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
Subject: [PATCH v2 2/7] crypto: sha256_generic - Fix some coding style issues
Date:   Sat, 17 Aug 2019 16:24:30 +0200
Message-Id: <20190817142435.8532-3-hdegoede@redhat.com>
In-Reply-To: <20190817142435.8532-1-hdegoede@redhat.com>
References: <20190817142435.8532-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Sat, 17 Aug 2019 14:24:46 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add a bunch of missing spaces after commas and arround operators.

Note the main goal of this is to make sha256_transform and its helpers
identical in formatting too the duplcate implementation in lib/sha256.c,
so that "diff -u" can be used to compare them to prove that no functional
changes are made when further patches in this series consolidate the 2
implementations into 1.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 crypto/sha256_generic.c | 268 ++++++++++++++++++++--------------------
 1 file changed, 134 insertions(+), 134 deletions(-)

diff --git a/crypto/sha256_generic.c b/crypto/sha256_generic.c
index b7502a96a0d4..dac930ca827d 100644
--- a/crypto/sha256_generic.c
+++ b/crypto/sha256_generic.c
@@ -48,10 +48,10 @@ static inline u32 Maj(u32 x, u32 y, u32 z)
 	return (x & y) | (z & (x | y));
 }
 
-#define e0(x)       (ror32(x, 2) ^ ror32(x,13) ^ ror32(x,22))
-#define e1(x)       (ror32(x, 6) ^ ror32(x,11) ^ ror32(x,25))
-#define s0(x)       (ror32(x, 7) ^ ror32(x,18) ^ (x >> 3))
-#define s1(x)       (ror32(x,17) ^ ror32(x,19) ^ (x >> 10))
+#define e0(x)       (ror32(x, 2) ^ ror32(x, 13) ^ ror32(x, 22))
+#define e1(x)       (ror32(x, 6) ^ ror32(x, 11) ^ ror32(x, 25))
+#define s0(x)       (ror32(x, 7) ^ ror32(x, 18) ^ (x >> 3))
+#define s1(x)       (ror32(x, 17) ^ ror32(x, 19) ^ (x >> 10))
 
 static inline void LOAD_OP(int I, u32 *W, const u8 *input)
 {
@@ -78,145 +78,145 @@ static void sha256_transform(u32 *state, const u8 *input)
 		BLEND_OP(i, W);
 
 	/* load the state into our registers */
-	a=state[0];  b=state[1];  c=state[2];  d=state[3];
-	e=state[4];  f=state[5];  g=state[6];  h=state[7];
+	a = state[0];  b = state[1];  c = state[2];  d = state[3];
+	e = state[4];  f = state[5];  g = state[6];  h = state[7];
 
 	/* now iterate */
-	t1 = h + e1(e) + Ch(e,f,g) + 0x428a2f98 + W[ 0];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0x71374491 + W[ 1];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0xb5c0fbcf + W[ 2];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0xe9b5dba5 + W[ 3];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x3956c25b + W[ 4];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0x59f111f1 + W[ 5];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x923f82a4 + W[ 6];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0xab1c5ed5 + W[ 7];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0x428a2f98 + W[0];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0x71374491 + W[1];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0xb5c0fbcf + W[2];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0xe9b5dba5 + W[3];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x3956c25b + W[4];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0x59f111f1 + W[5];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x923f82a4 + W[6];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0xab1c5ed5 + W[7];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0xd807aa98 + W[ 8];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0x12835b01 + W[ 9];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0x243185be + W[10];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0x550c7dc3 + W[11];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x72be5d74 + W[12];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0x80deb1fe + W[13];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x9bdc06a7 + W[14];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0xc19bf174 + W[15];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0xd807aa98 + W[8];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0x12835b01 + W[9];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0x243185be + W[10];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0x550c7dc3 + W[11];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x72be5d74 + W[12];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0x80deb1fe + W[13];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x9bdc06a7 + W[14];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0xc19bf174 + W[15];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0xe49b69c1 + W[16];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0xefbe4786 + W[17];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0x0fc19dc6 + W[18];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0x240ca1cc + W[19];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x2de92c6f + W[20];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0x4a7484aa + W[21];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x5cb0a9dc + W[22];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0x76f988da + W[23];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0xe49b69c1 + W[16];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0xefbe4786 + W[17];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0x0fc19dc6 + W[18];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0x240ca1cc + W[19];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x2de92c6f + W[20];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0x4a7484aa + W[21];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x5cb0a9dc + W[22];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0x76f988da + W[23];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0x983e5152 + W[24];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0xa831c66d + W[25];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0xb00327c8 + W[26];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0xbf597fc7 + W[27];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0xc6e00bf3 + W[28];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0xd5a79147 + W[29];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x06ca6351 + W[30];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0x14292967 + W[31];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0x983e5152 + W[24];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0xa831c66d + W[25];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0xb00327c8 + W[26];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0xbf597fc7 + W[27];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0xc6e00bf3 + W[28];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0xd5a79147 + W[29];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x06ca6351 + W[30];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0x14292967 + W[31];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0x27b70a85 + W[32];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0x2e1b2138 + W[33];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0x4d2c6dfc + W[34];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0x53380d13 + W[35];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x650a7354 + W[36];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0x766a0abb + W[37];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x81c2c92e + W[38];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0x92722c85 + W[39];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0x27b70a85 + W[32];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0x2e1b2138 + W[33];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0x4d2c6dfc + W[34];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0x53380d13 + W[35];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x650a7354 + W[36];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0x766a0abb + W[37];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x81c2c92e + W[38];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0x92722c85 + W[39];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0xa2bfe8a1 + W[40];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0xa81a664b + W[41];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0xc24b8b70 + W[42];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0xc76c51a3 + W[43];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0xd192e819 + W[44];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0xd6990624 + W[45];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0xf40e3585 + W[46];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0x106aa070 + W[47];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0xa2bfe8a1 + W[40];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0xa81a664b + W[41];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0xc24b8b70 + W[42];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0xc76c51a3 + W[43];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0xd192e819 + W[44];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0xd6990624 + W[45];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0xf40e3585 + W[46];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0x106aa070 + W[47];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0x19a4c116 + W[48];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0x1e376c08 + W[49];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0x2748774c + W[50];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0x34b0bcb5 + W[51];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x391c0cb3 + W[52];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0x4ed8aa4a + W[53];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0x5b9cca4f + W[54];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0x682e6ff3 + W[55];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0x19a4c116 + W[48];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0x1e376c08 + W[49];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0x2748774c + W[50];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0x34b0bcb5 + W[51];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x391c0cb3 + W[52];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0x4ed8aa4a + W[53];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0x5b9cca4f + W[54];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0x682e6ff3 + W[55];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
-	t1 = h + e1(e) + Ch(e,f,g) + 0x748f82ee + W[56];
-	t2 = e0(a) + Maj(a,b,c);    d+=t1;    h=t1+t2;
-	t1 = g + e1(d) + Ch(d,e,f) + 0x78a5636f + W[57];
-	t2 = e0(h) + Maj(h,a,b);    c+=t1;    g=t1+t2;
-	t1 = f + e1(c) + Ch(c,d,e) + 0x84c87814 + W[58];
-	t2 = e0(g) + Maj(g,h,a);    b+=t1;    f=t1+t2;
-	t1 = e + e1(b) + Ch(b,c,d) + 0x8cc70208 + W[59];
-	t2 = e0(f) + Maj(f,g,h);    a+=t1;    e=t1+t2;
-	t1 = d + e1(a) + Ch(a,b,c) + 0x90befffa + W[60];
-	t2 = e0(e) + Maj(e,f,g);    h+=t1;    d=t1+t2;
-	t1 = c + e1(h) + Ch(h,a,b) + 0xa4506ceb + W[61];
-	t2 = e0(d) + Maj(d,e,f);    g+=t1;    c=t1+t2;
-	t1 = b + e1(g) + Ch(g,h,a) + 0xbef9a3f7 + W[62];
-	t2 = e0(c) + Maj(c,d,e);    f+=t1;    b=t1+t2;
-	t1 = a + e1(f) + Ch(f,g,h) + 0xc67178f2 + W[63];
-	t2 = e0(b) + Maj(b,c,d);    e+=t1;    a=t1+t2;
+	t1 = h + e1(e) + Ch(e, f, g) + 0x748f82ee + W[56];
+	t2 = e0(a) + Maj(a, b, c);    d += t1;    h = t1 + t2;
+	t1 = g + e1(d) + Ch(d, e, f) + 0x78a5636f + W[57];
+	t2 = e0(h) + Maj(h, a, b);    c += t1;    g = t1 + t2;
+	t1 = f + e1(c) + Ch(c, d, e) + 0x84c87814 + W[58];
+	t2 = e0(g) + Maj(g, h, a);    b += t1;    f = t1 + t2;
+	t1 = e + e1(b) + Ch(b, c, d) + 0x8cc70208 + W[59];
+	t2 = e0(f) + Maj(f, g, h);    a += t1;    e = t1 + t2;
+	t1 = d + e1(a) + Ch(a, b, c) + 0x90befffa + W[60];
+	t2 = e0(e) + Maj(e, f, g);    h += t1;    d = t1 + t2;
+	t1 = c + e1(h) + Ch(h, a, b) + 0xa4506ceb + W[61];
+	t2 = e0(d) + Maj(d, e, f);    g += t1;    c = t1 + t2;
+	t1 = b + e1(g) + Ch(g, h, a) + 0xbef9a3f7 + W[62];
+	t2 = e0(c) + Maj(c, d, e);    f += t1;    b = t1 + t2;
+	t1 = a + e1(f) + Ch(f, g, h) + 0xc67178f2 + W[63];
+	t2 = e0(b) + Maj(b, c, d);    e += t1;    a = t1 + t2;
 
 	state[0] += a; state[1] += b; state[2] += c; state[3] += d;
 	state[4] += e; state[5] += f; state[6] += g; state[7] += h;
-- 
2.23.0.rc2

