Return-Path: <linux-s390+bounces-20539-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fKpIB+5iImp7VwEAu9opvQ
	(envelope-from <linux-s390+bounces-20539-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:47:26 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B9C645428
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H4o6W8mD;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20539-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20539-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EC8A307CD38
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 05:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548D54014B1;
	Fri,  5 Jun 2026 05:41:46 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C37E3F411E
	for <linux-s390@vger.kernel.org>; Fri,  5 Jun 2026 05:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638106; cv=none; b=jSXV+2dGWvdJzYexUPb+1actObSAvZwE7ZXn+z0Z8wIJdwxT5sm3AHJ4tIkwl9tk+soTe8CkQdKGM/lRJ96vCgkzw/JjR92AAJYosMjSQQv9+nyBFjeIrI+BlfvRmDk/iyAFso9yUmuVVzEY8aAQlNybTkZq9zycTdJSq97xx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638106; c=relaxed/simple;
	bh=VxbsBjHdRvXTR0KV6QwpQV6PvkcezsCcgEhIoL++T/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGW7HFZwMWwn+X4JxXeb7YdPWREffxHq0jrlrJNQ6QjlmqQLp1bc7RguB8FuLgNQOuYuGZ3n45ttC4+1tcrFYZzrneXpz3iZDvQ93Q3tr1+6saM+veci063n/j7520Kx6wJiwkwKcSGOkm08Y4rbkBmc2XyVFVpCr2EiOjOCfHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H4o6W8mD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E13F1F008A4;
	Fri,  5 Jun 2026 05:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638104;
	bh=rQENKqT9pyTIBLJdn4Wt5SoRtkTc7Vr1VCzymuIIqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H4o6W8mDH+lyp47obeZup9tDtWjCkHfHpNPIbQScK/JR9ykMnaVHTyVGFEcLwM7R1
	 MZIkApDHhYEQgbvYMdmmmxI45Jy/cutam+IYnQw2T8CUtCHA08l5bYvViGcPDxAu5Q
	 B9waOL5obx9U+ZM7On8lh09Dv+MlWaLX6m+CYl9H6xxaZmSchYM3N/H4Zz+2MXApv9
	 JU2Qs3b+wr9qnmWT49sS2sbur8zbRDkuKiFEyRb6bicANv8y4sXydiSqIye1N0nmbH
	 4+5pFNITC4FRdGCzbaI1DtAShK4Cg2nFjb3jMKZt34xP7OB32X6wbav+iLhbdx2Vw9
	 1d60d69FGxXOA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 641FEF40072;
	Fri,  5 Jun 2026 01:41:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 05 Jun 2026 01:41:42 -0400
X-ME-Sender: <xms:lmEias6sa1xX0LQqxf935Czyn7HwVyr0VYxk2s3kWeKzUM3PHJJF6A>
    <xme:lmEianDVOWtbD32caQYbgZRmOJNHT6PdKQK_jw36J_8hTt94Hd30NCO9R3M_lAzph
    o-YdoLU7N9RMP_5l9MrYBQQSGll0sVc-QsJgXhDtKpI1PkvXKnI0w>
X-ME-Received: <xmr:lmEiakXzxhTvNMKrKVwCDPLzWMKGN94jNWmKYn02qDgDfFqEyanuPKgcM0I>
X-ME-Proxy-Cause: dmFkZTFCwYGExB8+n21rrRlgZz2BZEPfw3mIE0bRNe76RMQAdH8f2KDaPLT52qZo7gxyWp
    0wXQACdPWdspv4jN5UYFCpihH+vrJtJ5nM33JJDnQyPnqbA42Pv6gENFpmiA7vDUbZDCAC
    N+ZmE7MklGAiGBNJA045y18Z9khhPwbxKZPuahNIwIz69+nOH0m/THs5eb4pu9rOFYQQI9
    b1h3voWmc5QUasjwQpRDRo+W3jNrB4TeCrmSTmM73SZRB0LYstjQaA4JitE82TBWNXKOy5
    NeQugQn5+UA17tSJ+MYIgsz9Sw+H8LaFdylvI7Cq2OhiaEqC4YLyUJJOJm9vOjE+2O1NIb
    ifGBvOfA1bRvdD1rzC6dalPswwrstFlyf7Pap/tukclD4RSnOep05M0BoiV6vs7Bgu2EkN
    p72ke8BUte3XkipOs/+CKWn/TsXg6p4p138xCLDsao5vi8Ksw7pMG7tzPlOYBuOqdg6z8c
    MidLD+dCzBqmfkLMsHdOHLfs1Pt53AU/mth+xQxJ6Wnq5W1rjhMKkcb5wW6tQdd0P7matz
    OCENDIVnfvIMJ8TC4oMgg+jtzeGeX2yW4wFkT7CuUw7nTNzjxH9wZghvZaZUbOwF7xfC59
    Af1ZSoVdz9AYOcDTSgfAw9IS9LKJ+IE4V38tIidtjIBck5rDsCz/vk+vM9iQ
X-ME-Proxy: <xmx:lmEiajyG_ECODsknMZaiWeI6lB4RM-vHCwzS-PLCp6k5bCe6EXIhlA>
    <xmx:lmEianhqhWew4_M-RbHKXbUo9j7BJ6hB77uaIa51Ix-nkG3kmlephA>
    <xmx:lmEiajnjrfVmMD59vAD_hOpEb1wCKtBMQwa4E2GJxkCuwW2EC6mW1Q>
    <xmx:lmEiarKWbhlo4-3nQzXarPfEw3SXJQgaSWdfTsOLyo6L81tykc9_ww>
    <xmx:lmEiakClBCsQNUnsD-35n_uhF0mJr-eTEXof0sHzFm3oZii2Z8rIPQfZ>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:41 -0400 (EDT)
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
Subject: [PATCH v3 06/13] irq: Add KUnit test for refcounted interrupt enable/disable
Date: Thu,  4 Jun 2026 22:41:21 -0700
Message-ID: <20260605054128.5925-7-boqun@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:boqun@kernel.org,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar.gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20539-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 50B9C645428

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
2.51.0


