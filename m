Return-Path: <linux-s390+bounces-20536-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H33IBxdiImoKVwEAu9opvQ
	(envelope-from <linux-s390+bounces-20536-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:43:51 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71008645387
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:43:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=F7Wo3U8m;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20536-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20536-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53CD23022AA0
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 05:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF33E171C;
	Fri,  5 Jun 2026 05:41:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7733BB10D;
	Fri,  5 Jun 2026 05:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638098; cv=none; b=NLsPlFGHIUDkLXgfgyBEGx/RY2rRqpOBPtRO9gdQr79HD2TSlpWUcRwC4PBsVH4gtQL47g8ophrpm9rspM99sJvKID0JEeO5mmFslrTrPhK4XqzFH9sVCVCuxyQcqMmiK1UACHXYMSdBaF1O2ZDkTEK0kXDfGsUzcf3ToiLx434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638098; c=relaxed/simple;
	bh=hv8O/bheqVgn2baSbMciHGKRLF94QTuSTMuFCgVRSts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTsih/Ycw/Sw/R3VwD1n1ptdLJGXB7YhdbryFdQxLsYuDWdUQSuMevp5jbNUR4sTTkPnaG+oVii5SaaYNccwLziO1Om8ywgFSNiTLlkS1dlLU2n38LD18uRBYF7F8MyGyO2naATirZDU8uC2/X5qW0WJUNsvsm/QZbvvYeHlwz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7Wo3U8m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACAA1F0089C;
	Fri,  5 Jun 2026 05:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638097;
	bh=72tLoFmAzAI2R/LaKi/6YHpBql7AKiP21W7mrcDmmM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F7Wo3U8mbQbAb2VgYKv8NfIMTkg2sVlyyqwyeJMOcRnP+u8Ml3sOQRZH+KfC61G/4
	 WdQGxzAapDOEmCBgXNJd4bm6SN7ZDF49KF4Zx+nEKykIuIdQxS26WbwMZbfXI5acAb
	 C6l7IW4SVnXslcPCXHipKS8EoOXqBogEgfteDRX79wsbYvv50Llt5p6CZi7wb+ZJX0
	 yK+yuQXqAuOGKGRSic5hIDMNb94UBIkfmI8PMthfSQaHjzbMHZoKPC/uQ7BrqPW15v
	 gQxJsCgQxCwxNqxcpg5EsiEF0rckoStAWkxQWzg1HcBRbOu5EJ2rGNcjqC7JoplU0H
	 3PL3gN0vlff1w==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9F3FDF40077;
	Fri,  5 Jun 2026 01:41:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 01:41:34 -0400
X-ME-Sender: <xms:jmEiahJTwmP5GaeS6AF8NjUfakowMBDvmFlPlTyoATwN968yHyiVFw>
    <xme:jmEiamS4L6OJAQKoaNM3WjZHlNyExLFTO_2M2raiBGiKCJg1DM2uwPGaiYXStNBDe
    FcoIYHtAYzMuheEaT_P4Xv0Q88vaJIC87ZQsbD5vxRNq0nYyUU3vQ>
X-ME-Received: <xmr:jmEiainNT6PPdlhEI9EGebc5Wjem6IClgyxAT9a8uuePPsx1PDkXmhg9-2w>
X-ME-Proxy-Cause: dmFkZTGNdErcnsY9nz6zZJNqzBGcFpZ3oCsZyVSAsXPEfKD6fiAd7MM8RW3ErpHOKO8vqP
    y7FRxpXUBU5yb8Y73fmewycTgcYRdiPbEiXJpQaKxk1+aC6Vj3AAV2l/TRkhTd+1u+mIGl
    dQfEAWycnSLZO+qO217j/GTm+GQxoHWyRwvdph+wtnOrnU/D7PvfaSdl50PQ+1o9QW7RYj
    snzJFBhgLjSJ/jkZdib8Dc9ob5AHsrvEPqt2vef8Hmx2uDf0JqmoZZ+HexXrtwk5r0bry3
    HVu0i63lg3nGwPLJ2r8Np94WJ6jG6+OWNN7TpxDaYMxO59AtKcBppdJ6IoJJH6Zm9jQmI9
    U6emNrDYfEZR39DkwfoH5zt8f1YwHkfFANtNrvoAJ+dQH683V2Zc1PEA6Xfy/fajTfBKsD
    92l7UsiWE1X5zsUDrj2NKzMx7UIkcvaiiHXGB2ozO0l8nG93rYi8LHQ1qbXrJSHLFkuTBU
    rY/mHdNJlpmXihaP5e0zxLrQ+nh490MaJ+wMxD1vJNso6UCG/elc68EmRimsFXaP8Hsm6g
    3Xq0Cks0oNLsHDN148PLantNxbD9r12jBpgRmASx1ZYLAw4I52PMMNa0Qo/kewkN31ZVPe
    D3Wjzgpzgspdnw2A0l6YnOJrChVUBNktW4lQrBYrgqMqd1TLBPp/xuzpo0WA
X-ME-Proxy: <xmx:jmEialAkNHtAAuo33UGUjzT7HlAIYV4RIEJfu0uSXHoAdvKgjXCjQA>
    <xmx:jmEiavywqTtOsjMP5PkLSQ3Jnfe6OkfrrendxfvlTxKXTzpIWsPiVg>
    <xmx:jmEiam2BKlrVLcckjNdzdZ-7Sqww31X27wfEM2JwYCl7i_5ZvdOysw>
    <xmx:jmEiataqkMgKnu_I1Toqlkrd0jEGgomgGf0ihlSl8R0TYK8rBbYl3A>
    <xmx:jmEiapSQzyPIxswYQ2qnC3lxnbNYr0MPlmN4LYae_TmJjJmOkdxJFgXy>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:33 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v3 01/13] preempt: Track NMI nesting to separate per-CPU counter
Date: Thu,  4 Jun 2026 22:41:16 -0700
Message-ID: <20260605054128.5925-2-boqun@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260605054128.5925-1-boqun@kernel.org>
References: <20260605054128.5925-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:boqun@kernel.org,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar.gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20536-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[67];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71008645387

From: Joel Fernandes <joelagnelf@nvidia.com>

Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
allowing those bits to be repurposed for other uses.

Reduce NMI_BITS from 4 to 1, using it only to detect if we're in an NMI.
The per-CPU counter currently caps nesting at 15.

[boqun: Solve Steven Rostedt's comment on the BUG_ON() condition]
[boqun: Use preempt_count_set() in __nmi_exit() to avoid underflow]

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
---
 include/linux/hardirq.h                        | 17 +++++++++++++----
 include/linux/preempt.h                        |  9 +++++++--
 kernel/softirq.c                               |  2 ++
 tools/testing/selftests/bpf/bpf_experimental.h |  2 +-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06..8d4895531a45 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -10,6 +10,8 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
+DECLARE_PER_CPU(unsigned int, nmi_nesting);
+
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
@@ -102,14 +104,17 @@ void irq_exit_rcu(void);
  */
 
 /*
- * nmi_enter() can nest up to 15 times; see NMI_BITS.
+ * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
  */
 #define __nmi_enter()						\
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		BUG_ON(in_nmi() == NMI_MASK);			\
-		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		/* Maximum NMI nesting is 15. */		\
+		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
+		__this_cpu_inc(nmi_nesting);			\
+		__preempt_count_add(HARDIRQ_OFFSET);		\
+		preempt_count_set(preempt_count() | NMI_MASK);	\
 	} while (0)
 
 #define nmi_enter()						\
@@ -124,8 +129,12 @@ void irq_exit_rcu(void);
 
 #define __nmi_exit()						\
 	do {							\
+		unsigned int nesting;				\
 		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
+		__preempt_count_sub(HARDIRQ_OFFSET);		\
+		nesting = __this_cpu_dec_return(nmi_nesting);	\
+		if (!nesting)					\
+			preempt_count_set(preempt_count() & ~NMI_MASK);	\
 		arch_nmi_exit();				\
 		lockdep_on();					\
 	} while (0)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index d964f965c8ff..586f96688325 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -17,6 +17,8 @@
  *
  * - bits 0-7 are the preemption count (max preemption depth: 256)
  * - bits 8-15 are the softirq count (max # of softirqs: 256)
+ * - bits 16-19 are the hardirq count (max # of hardirqs: 16)
+ * - bit 20 is the NMI flag (no nesting count, tracked separately)
  *
  * The hardirq count could in theory be the same as the number of
  * interrupts in the system, but we run all interrupt handlers with
@@ -24,16 +26,19 @@
  * there are a few palaeontologic drivers which reenable interrupts in
  * the handler, so we need more than one bit here.
  *
+ * NMI nesting depth is tracked in a separate per-CPU variable
+ * (nmi_nesting) to save bits in preempt_count.
+ *
  *         PREEMPT_MASK:	0x000000ff
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
- *             NMI_MASK:	0x00f00000
+ *             NMI_MASK:	0x00100000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	4
+#define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4425d8dce44b..10af5ed859e7 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(unsigned int, nmi_nesting);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *
diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index 2234bd6bc9d3..2d4256ff471f 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -449,7 +449,7 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	4
+#define NMI_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-- 
2.51.0


