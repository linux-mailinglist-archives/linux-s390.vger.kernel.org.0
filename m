Return-Path: <linux-s390+bounces-21470-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id USkAHm5FRWpU9woAu9opvQ
	(envelope-from <linux-s390+bounces-21470-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:50:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 114DA6EFFCF
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:50:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=eM7YWTaQ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21470-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-21470-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AA6030A0789
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A81E372665;
	Wed,  1 Jul 2026 16:47:34 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BC03793D5
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 16:47:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924454; cv=none; b=fw8aqW9JdXOUIaxlzTxCjWHITLf4bmXto6yMv+kU1NzqsQG4B7bSA10cQF104mmJSczrZ/z6n+ZsIHBMbZtOL7ENqThxn6rsZI0MwcxhFjIBYYbq5QXsmV23SQgkUIsmsUHkzziQj/GUdGUBhebs1M8uYNrlwDUFQ7ZkQjx+ZsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924454; c=relaxed/simple;
	bh=NLeNWDLgmit4xzCf6zPTCCnW8EIGBAbOuPVsU7Nl+D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xdioit1PTsyro+YDZKVc5dPOd9qT6qDOiYAAp1kFfvYQwyvVXgkl+exjoUGf/zehpRvnVR+hd9dvRypZhW/y+C9a/rN834gt1qjOdNOQ6Vp+UCyILPErlz1EioJLyNqDod38kKgsuPdDIv3qRI+Poui+cF7+pAkbFJPvsX1jC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eM7YWTaQ; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661AIjuY447243;
	Wed, 1 Jul 2026 16:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ze+ofQ249c2bgpyuG
	2nNIbxolu8buY+EOcQgqBE2SmE=; b=eM7YWTaQ4SzeinlLJ4I2wk59V/vfckDIJ
	V/DYTXV8YrcginxXCJYJs3663F/HjCcU0qT7c/A5fynIBfJZj8eKw6hJJYdHrdsH
	0Q7mizn7xDF6+1Mo339J7bUBJBIpX1Iff0TW6rg1wWRhjMHZfDT6gYP7CQKE4hla
	EIKEKIEhvcMn/Il3BBXhXWHo1Iz9wUDcCc82GWVb/WjlL++hVPUEgNz4HQWXn7aM
	HhMF8Vq3EezPcW55eL+mCo4O8lcz6+ljjUCDaeWHNZSAMSwTL/9dUUVTPQKxdDea
	8MjXxaOCvD4Q2YDN50SaxZeJ9x69rwFjbjkpnowcig6wvjWPwlfuQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjwa9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:47:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 661GYcxm018702;
	Wed, 1 Jul 2026 16:46:59 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w894s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Jul 2026 16:46:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 661Gkt8a50004226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Jul 2026 16:46:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C71602004B;
	Wed,  1 Jul 2026 16:46:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91AD12004F;
	Wed,  1 Jul 2026 16:46:55 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.187.249])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Jul 2026 16:46:55 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v9 19/21] target/s390x: Use generic AES helper functions
Date: Wed,  1 Jul 2026 18:46:42 +0200
Message-ID: <20260701164650.95760-20-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701164650.95760-1-freude@linux.ibm.com>
References: <20260701164650.95760-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfX4/3uANnAh/tt
 avVH6CQ3x+QHw/dET4Q1uzHQUj5VdE0ET3TLKCmum0rRY3cEe3XpVSXJ9rP8il9TuuorbIEvGCM
 ZQFD9z+KL84bi9lt/FS23TnI6ZuVptTttWMrbWzGu9WKKTsNQo+8RbqMzYkKG233nF30KD0+Q3y
 tUrSxaeO3E16p9BDH9tcVGo6ctRNd0B0vMpMeDOafNTUh5E235sAiHRUR1iQ9PDPQz30DycYum5
 OZIWJpVzvS06GsdJQfuG/0kR3x5RCYRJ1Cyd00uKz97HP+C1YZr42c+QJ4dcdf4b34ew5coadLN
 e3dw3SuMYgMY1e4pNFjllwTjY0KxOZcBukC5Ho9U5ksv/Wn4HdgfV+Pz++rCQdg/MCyuor6mQjK
 KAcdD0QS+KweteoOrd/Oxn3WpJFW9pUzz089+JtI1thME/R5bGcHdUYs3n2WE7fmLgB2QEVlQK8
 lpJ6cM5GobaW18D6lHA==
X-Proofpoint-GUID: t8qli_MmLLn_LRSY3zeCdIXX_A1d031X
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a454484 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ccJ9v8fwxLVEcBnUSYMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE3MyBTYWx0ZWRfXxFtUqK7B+UwH
 gdR1RfAItyVVTzHZZo1q0zG8K11rbyz/N6SeriRtVnEK6KkY2FNOLDgf0wwBsfTMb48TcR6mn1Z
 BeJO+aPTNIMo24TvEjEEY53L/2rlySE=
X-Proofpoint-ORIG-GUID: t8qli_MmLLn_LRSY3zeCdIXX_A1d031X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010173
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-21470-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[freude@linux.ibm.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 114DA6EFFCF

Rewrite the cpacf implementations to use the generic
AES helper functions from crypto/aes-helpers.c

Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
---
 target/s390x/tcg/cpacf_aes.c | 124 ++++++++++-------------------------
 1 file changed, 36 insertions(+), 88 deletions(-)

diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
index 0c3cbb29e3..4298a0eac6 100644
--- a/target/s390x/tcg/cpacf_aes.c
+++ b/target/s390x/tcg/cpacf_aes.c
@@ -111,20 +111,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return !len ? 0 : 3;
 }
 
-static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
-{
-    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
-        dst[i] = src1[i] ^ src2[i];
-    }
-}
-
 int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
@@ -180,19 +173,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
@@ -222,11 +207,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
+    uint8_t ctr[AES_BLOCK_SIZE], key[32];
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -268,12 +252,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* xor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
@@ -354,28 +336,13 @@ int cpacf_aes_pcc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     return 0;
 }
 
-static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
-{
-    uint8_t carry;
-    int i;
-
-    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
-
-    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
-        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
-    }
-
-    tweak[i] = (uint8_t)(tweak[i] << 1);
-    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
-}
-
 int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                   uint64_t param_addr, uint64_t *dst_ptr_reg,
                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
                   uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint64_t addr, len = *src_len_reg, done = 0;
     uint8_t key[32], tweak[AES_BLOCK_SIZE];
@@ -426,23 +393,19 @@ int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in  */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
@@ -638,7 +601,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -706,19 +669,11 @@ int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt in => buf */
-            AES_decrypt(in, buf, &exkey);
-            /* buf xor iv => out */
-            aes_xor(buf, iv, out);
-            /* prep iv for next round */
-            memcpy(iv, in, AES_BLOCK_SIZE);
+            /* decrypt in => out */
+            AES_cbc_decrypt(in, out, iv, &exkey);
         } else {
-            /* in xor iv => buf */
-            aes_xor(in, iv, buf);
-            /* encrypt buf => out */
-            AES_encrypt(buf, out, &exkey);
-            /* prep iv for next round */
-            memcpy(iv, out, AES_BLOCK_SIZE);
+            /* encrypt in => out */
+            AES_cbc_encrypt(in, out, iv, &exkey);
         }
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
@@ -748,11 +703,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
-    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
     uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
+    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
     uint64_t addr, len = *src_len_reg, done = 0;
     int i, keysize, addr_reg_size = 64;
-    uint8_t key[32], wkvp[32];
     AES_KEY exkey;
 
     g_assert(type == S390_FEAT_TYPE_KMCTR);
@@ -806,12 +760,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
         /* read in nonce/ctr => ctr */
         aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
-        /* encrypt ctr => buf */
-        AES_encrypt(ctr, buf, &exkey);
         /* read in one block of input data => in */
         aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
-        /* exor input data with encrypted ctr => out */
-        aes_xor(in, buf, out);
+        /* encrypt ctr and xor with in => out */
+        AES_ctr_encrypt(in, out, ctr, &exkey);
         /* write out the processed block */
         aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
@@ -912,7 +864,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
                    uint32_t type, uint8_t fc, uint8_t mod)
 {
     enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
-    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
+    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
     uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
     uint64_t addr, len = *src_len_reg, done = 0;
@@ -975,23 +927,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
 
     /* process up to MAX_BLOCKS_PER_RUN aes blocks */
     for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
-        /* fetch one AES block into buf1  */
-        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
+        /* fetch one AES block into in */
+        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
         if (mod) {
-            /* decrypt buf2 => buf1 */
-            AES_decrypt(buf2, buf1, &exkey);
+            /* decrypt in => out */
+            AES_xts_decrypt(in, out, tweak, &exkey);
         } else {
-            /* encrypt buf2 => buf1 */
-            AES_encrypt(buf2, buf1, &exkey);
+            /* encrypt in => out */
+            AES_xts_encrypt(in, out, tweak, &exkey);
         }
-        /* buf1 xor tweak => buf2 */
-        aes_xor(buf1, tweak, buf2);
         /* prep tweak for next round */
-        aes_xts_prep_next_tweak(tweak);
-        /* write out this processed block from buf2 */
-        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
+        AES_xts_prep_next_tweak(tweak);
+        /* write out this processed block from out */
+        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
         len -= AES_BLOCK_SIZE;
         done += AES_BLOCK_SIZE;
     }
-- 
2.43.0


