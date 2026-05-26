Return-Path: <linux-s390+bounces-20067-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOiINn7CFWoAagcAu9opvQ
	(envelope-from <linux-s390+bounces-20067-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 17:55:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC05D923C
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 17:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF7030C3007
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2026 15:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B40A34CFC2;
	Tue, 26 May 2026 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iqB9/nHm"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002BC346FAD;
	Tue, 26 May 2026 15:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808933; cv=none; b=cCzK/2ltCMt8eAerkh2hjlxp11T8wfyVOENlC2XM7F/5n+zK7fXYKctIeKAyHzLGmoyPLYQHq8mj0Ft8u4cSB5dxBh5+RskZpnOrz8mBevahngq5K7+qkF5vH6ZzSEU6Q3+1Dz0GQYNNLMx9rZ79i9aQim3Hw63dI1Emw/IkWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808933; c=relaxed/simple;
	bh=bGbp7ZAovMFSYOk12em7HB3rK+s0+f5BMcq+64sn+xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u34kiaiL5MQAU87xjfqzNRhiiD5B0Q2CWFWL+d4fxqZ18Q35faMkwl8w8IFwHMrU4bK4YQ+cLh5rKsS3Kuc4AhxQP3dj/Tv9O87vqMH+kV6ikmF5nJDe1Ac2ttqxaG8/gTybRwgWmehirkMp6sL5naJ8o6U9KVjI6ce0OuG3iFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iqB9/nHm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE051F00A3F;
	Tue, 26 May 2026 15:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808930;
	bh=5OPx7quzXUSGt6ByZC5s4NaWSZlJv3l+K0FTPDFDBPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iqB9/nHmgW0xkjzJQhxSIHqzJ4Y9Of0Va6OYN+H92fs0m5Csec6vU45cahECf5Xh/
	 ULK75CTA6prWVJoRjD0dSyjRVZYT01MtVTMFoH+QQiBa/fsWhYug3w2s8ZlYDezCuu
	 CuaDl8WChi8hJrROgwDqRFaoZldXcD4JUbVp+8BZz+luQE511xfq8SsI0VABfTVryp
	 ztPM+rP7wM4IkoSPN5Jd61JoT202e57YxoPbPV/QEDPzRhNhPEEPYLm0bmsqlGIh8k
	 3EV7crOB1BA03ucWmXkTF7GdBMku+X9630f88nweFOg2ydIvPub2hkxy0i67DMuV7R
	 xDmEIKuvnrF5w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4197EF40076;
	Tue, 26 May 2026 11:22:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 26 May 2026 11:22:08 -0400
X-ME-Sender: <xms:oLoVanAmOxGt84Y3LXgxWw21d7FLdHGblsM5zpjtFNd7y17EsGc6kg>
    <xme:oLoVaiaNar1eBlEKOKyJT3lFRjAzOAlG9l2GECu3kqRivydqWAc8dgV3-gz2sdROB
    fzmMXnBxpLb3l4QkA9No6s8ooN8fxQfC786cQ1lqTemU3ddBtzgMw>
X-ME-Received: <xmr:oLoVaofT3_NzG2x4UFjPNSxJ29_x44yshAV0sQPfzgENLiOHTob0RmZrwNvVqc1PIrQXCAXMRoqd00NWKWsml_n0y_fLJZTt>
X-ME-Proxy-Cause: dmFkZTF4DRy3SVWvFgbrMj6NLZAzcFoz2nQXqxcC29g0cJodSSCq7SigXkNqkKyVKY8Fbo
    tNBxK9l0cvUpEcoUsqlrgnGG6AzHesWFMvhCV6UChh28B/l+B0XcBDFyQ2SWxY98PRXmdP
    ve6x2DuaGBoFqFLd2X7JY1xDLL8Lf/ioMpNOlpSu5ND04mQF0abbcBqGyVfp8F97H4GS64
    01N0I2TPo3FNH+Cuc07t/TxhH401g1cp7tJox+/qtGqhdAiDNrA6UhBiIAP6Db2Lvi6zzp
    xv6mPObw6hMkfIMZb/rc84q9l5Cts9sZTAVAmwRqp1ZV95wmde3E4mdlYb8YI08MmQLdC6
    UMVWujWuYI9VJTFa1fn3cz+5ifau8/fd4x4PowzWfI6dCyqeGqUc0yf2Q8DY9NFirPvOdM
    B/TbF0K9MNU+4mUHwhs8QJMU91fV2q3AnCwhf3hi+J6LAIfxcRdTEaoY7Nd2wm7HgWvKk4
    2sU1VUb/hy/e4Mfx/eFsns6YGveZAx266PJztykP4ZPU+70Eevk+XQooykQccLKF9ANADz
    KwjjY8x+Yfhj5KyhPP9Rl44O9YDxEZvH6oQW/gQIvklvfXD0POubgCXupkwTx3UfuLxozi
    jG83wV4m6fiRet2HZeEyP5xXtigivDdrR1IYgy4RntM8wLhoYWynG3OmDHWw
X-ME-Proxy: <xmx:oLoVasMgacQLSMBrgefpqJpS__kbVXwyLwkQY53eeyGrOBF_pfPCNg>
    <xmx:oLoVaiV8KiOVEiu8X8uIQWWsWB062k3wHoD20XA1efXP1XTiFN2Dcw>
    <xmx:oLoVal2GlW70kcL913beFTFhWMO24jERHgTJB1X_YPnC1iaox1PdIA>
    <xmx:oLoVal6IfRwzMMNyQQYKkbbKB90qFAni4RmXpgCR4eqgtWop8CFGkg>
    <xmx:oLoVaicMATFiKbBEEQR1ovUfjFp8pdxnbJNvRBwHmia-CBTM30BtPa25>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:06 -0400 (EDT)
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
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 06/12] irq: Add KUnit test for refcounted interrupt enable/disable
Date: Tue, 26 May 2026 08:21:42 -0700
Message-ID: <20260526152148.30514-7-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20067-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[68];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 39CC05D923C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lyude Paul <lyude@redhat.com>

While making changes to the refcounted interrupt patch series, at some
point on my local branch I broke something and ended up writing some kunit
tests for testing refcounted interrupts as a result. So, let's include
these tests now that we have refcounted interrupts.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-7-lyude@redhat.com
---
 kernel/irq/Makefile                  |   1 +
 kernel/irq/refcount_interrupt_test.c | 109 +++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)
 create mode 100644 kernel/irq/refcount_interrupt_test.c

diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 86a2e5ae08f9..44c4d6fc502a 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_SMP) += affinity.o
 obj-$(CONFIG_GENERIC_IRQ_DEBUGFS) += debugfs.o
 obj-$(CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR) += matrix.o
 obj-$(CONFIG_IRQ_KUNIT_TEST) += irq_test.o
+obj-$(CONFIG_KUNIT) += refcount_interrupt_test.o
diff --git a/kernel/irq/refcount_interrupt_test.c b/kernel/irq/refcount_interrupt_test.c
new file mode 100644
index 000000000000..b4f224595f26
--- /dev/null
+++ b/kernel/irq/refcount_interrupt_test.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for refcounted interrupt enable/disables.
+ */
+
+#include <kunit/test.h>
+#include <linux/interrupt_rc.h>
+
+#define TEST_IRQ_ON() KUNIT_EXPECT_FALSE(test, irqs_disabled())
+#define TEST_IRQ_OFF() KUNIT_EXPECT_TRUE(test, irqs_disabled())
+
+/* ===== Test cases ===== */
+static void test_single_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+}
+
+static void test_nested_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static void test_multiple_irq_change(struct kunit *test)
+{
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static void test_irq_save(struct kunit *test)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	TEST_IRQ_OFF();
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_OFF();
+	local_irq_restore(flags);
+	TEST_IRQ_ON();
+
+	local_interrupt_disable();
+	TEST_IRQ_OFF();
+	local_irq_save(flags);
+	TEST_IRQ_OFF();
+	local_irq_restore(flags);
+	TEST_IRQ_OFF();
+	local_interrupt_enable();
+	TEST_IRQ_ON();
+}
+
+static struct kunit_case test_cases[] = {
+	KUNIT_CASE(test_single_irq_change),
+	KUNIT_CASE(test_nested_irq_change),
+	KUNIT_CASE(test_multiple_irq_change),
+	KUNIT_CASE(test_irq_save),
+	{},
+};
+
+/* (init and exit are the same */
+static int test_init(struct kunit *test)
+{
+	TEST_IRQ_ON();
+
+	return 0;
+}
+
+static void test_exit(struct kunit *test)
+{
+	TEST_IRQ_ON();
+}
+
+static struct kunit_suite refcount_interrupt_test_suite = {
+	.name = "refcount_interrupt",
+	.test_cases = test_cases,
+	.init = test_init,
+	.exit = test_exit,
+};
+
+kunit_test_suite(refcount_interrupt_test_suite);
+MODULE_AUTHOR("Lyude Paul <lyude@redhat.com>");
+MODULE_DESCRIPTION("Refcounted interrupt unit test suite");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)


