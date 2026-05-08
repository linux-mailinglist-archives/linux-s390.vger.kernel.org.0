Return-Path: <linux-s390+bounces-19414-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HDDMUNl/WksdAAAu9opvQ
	(envelope-from <linux-s390+bounces-19414-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 06:23:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AED84F177E
	for <lists+linux-s390@lfdr.de>; Fri, 08 May 2026 06:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9771302B3B3
	for <lists+linux-s390@lfdr.de>; Fri,  8 May 2026 04:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C37C32E121;
	Fri,  8 May 2026 04:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VntjmHn6"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC0328260;
	Fri,  8 May 2026 04:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214083; cv=none; b=KY441kNlnL4eYYiqCT/g2f/Xr24dKHU2DX8pYiqJym2FJxbC9ahTUP2RFR/n4AJ2hIIt3p9RLhkn++ntdwjxhFhu74E589d15RKV7uEsII9UF093G9jUBLuyEQIWkV6PEGqKyqPs49RR+6XkvsY9Gc+zhubUZturl+Rc10+Ta7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214083; c=relaxed/simple;
	bh=AiyjL2NIptQ6W8E+mKLdfXOmR7xA1WPP84lRH1RZ15k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1QcOOgDzrh+VunqUOltC5Co8+VpT8DYGJjC9PLdAMxLy1/0cFMNl32r80+74q4og93IjdH8XTqVmDten5m3bianALJcA9luJRWPKds7PXF4hfZgmZnfWTcM2PgdBVablQbATF87i1dtoD9Jcs5hYvLvQhevcaVaI50RQece3hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VntjmHn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6C0C2BCB0;
	Fri,  8 May 2026 04:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214082;
	bh=AiyjL2NIptQ6W8E+mKLdfXOmR7xA1WPP84lRH1RZ15k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VntjmHn6uc6wRLtzftO6dhvSesgbVHj8RmQoNTFE3KFKrj4eFu+U8QYFKpE2a0TLu
	 44VdqG5vfj3drjR4EAr1OrL0MG6g10D0ZwtRYpUfkpd2LWdiyC754iCHTVGq+1lIQm
	 Y5dJDJl87p4Llblpj5G7siZ2l0bYQwZ7FRruXO4KGPi4E+TdupYPa1nN9z3djowtBb
	 8zfgHoIAI0FtO+TbqXwQCTz/ErjwG/9y1NVA+UGOpZOWDPNpmT7DpqM21RLDO/o0l8
	 1sq5it6MeydSYpUPVnfqsinOmMjTORnWvZXX02HS8XzQjhT29MiBBa0yuFBTeEzyId
	 LR1Imwbo7SntA==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id D9CDBF40078;
	Fri,  8 May 2026 00:21:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 00:21:20 -0400
X-ME-Sender: <xms:wGT9ab5MngZ6pva643qO45fLpLwFzTmOdt93Kf4cL6Kzio-KFxJhOw>
    <xme:wGT9aWs9pBH24vizj6FUht0VVVaGv0UokTniRTii_Xpt96TZYsDLSb3LghB3nUmMs
    ctJX3A6xJ8xo0XkYNvkH8weQ9I3upLvUURHv7SUY2_x0McNr4Y>
X-ME-Received: <xmr:wGT9aXhb1XyDUjHhXpfmB1CgAIfF74H0eBfPj4em96B9uI3fVi-VfjZjDXNl3wEzGFGatFUPPpUllzw4TEuSTilnq_Qe17Yn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdelfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekieffgeevhefgudffveffheettdfgkeeilefhhfduhedugedvhedtteegvdeugfenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhr
    tghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghsse
    hsohhuthhhphholhgvrdhsvgdprhgtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghn
    shhsohhnsehsrghunhgrlhgrhhhtihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephhgtrgeslhhinhhugidrihgsmhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:wGT9abLIQmfUOZvLhGFyPHg2nTFib74lXNhZ-0pBZ_hOxQeJ1gfVWg>
    <xmx:wGT9aZY2bxt_5xB7emEF_wm9IsHTuKY2yjVJ9OhaLd26bdyF_fXSLQ>
    <xmx:wGT9adCk7piW9TlA6ve7Qs7V1LwLjnpFvQPUu85M-GMAD0jzFWBUow>
    <xmx:wGT9aXv6acSWwyRZDxFWr-0Ch3-Wac5KME5ifVtjibZgX63FmL_N4w>
    <xmx:wGT9abfeLOa3IiyQUVRCWa5xmaSvCzjI0vFanOCoUXhr48ghu92chx0K>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 00:21:20 -0400 (EDT)
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
	Miguel Ojeda <ojeda@kernel.org>,	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>,	Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,	linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org,	rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 03/11] preempt: Introduce __preempt_count_{sub, add}_return()
Date: Thu,  7 May 2026 21:21:03 -0700
Message-ID: <20260508042111.24358-4-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508042111.24358-1-boqun@kernel.org>
References: <20260508042111.24358-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6AED84F177E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19414-lists,linux-s390=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_GT_50(0.00)[57];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Boqun Feng <boqun.feng@gmail.com>

In order to use preempt_count() to tracking the interrupt disable
nesting level, __preempt_count_{add,sub}_return() are introduced, as
their name suggest, these primitives return the new value of the
preempt_count() after changing it. The following example shows the usage
of it in local_interrupt_disable():

	// increase the HARDIRQ_DISABLE bit
	new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);

	// if it's the first-time increment, then disable the interrupt
	// at hardware level.
	if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
		local_irq_save(flags);
		raw_cpu_write(local_interrupt_disable_state.flags, flags);
	}

Having these primitives will avoid a read of preempt_count() after
changing preempt_count() on certain architectures.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-4-lyude@redhat.com
---
 arch/arm64/include/asm/preempt.h | 18 ++++++++++++++++++
 arch/s390/include/asm/preempt.h  | 10 ++++++++++
 arch/x86/include/asm/preempt.h   | 10 ++++++++++
 include/asm-generic/preempt.h    | 14 ++++++++++++++
 4 files changed, 52 insertions(+)

diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
index 932ea4b62042..0dd8221d1bef 100644
--- a/arch/arm64/include/asm/preempt.h
+++ b/arch/arm64/include/asm/preempt.h
@@ -55,6 +55,24 @@ static inline void __preempt_count_sub(int val)
 	WRITE_ONCE(current_thread_info()->preempt.count, pc);
 }
 
+static inline int __preempt_count_add_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc += val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
+static inline int __preempt_count_sub_return(int val)
+{
+	u32 pc = READ_ONCE(current_thread_info()->preempt.count);
+	pc -= val;
+	WRITE_ONCE(current_thread_info()->preempt.count, pc);
+
+	return pc;
+}
+
 static inline bool __preempt_count_dec_and_test(void)
 {
 	struct thread_info *ti = current_thread_info();
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index 6e5821bb047e..0a25d4648b4c 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -139,6 +139,16 @@ static __always_inline bool should_resched(int preempt_offset)
 	return unlikely(READ_ONCE(get_lowcore()->preempt_count) == preempt_offset);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return val + __atomic_add(val, &get_lowcore()->preempt_count);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return __preempt_count_add_return(-val);
+}
+
 #define init_task_preempt_count(p)	do { } while (0)
 /* Deferred to CPU bringup time */
 #define init_idle_preempt_count(p, cpu)	do { } while (0)
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 578441db09f0..1220656f3370 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -85,6 +85,16 @@ static __always_inline void __preempt_count_sub(int val)
 	raw_cpu_add_4(__preempt_count, -val);
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, val);
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	return raw_cpu_add_return_4(__preempt_count, -val);
+}
+
 /*
  * Because we keep PREEMPT_NEED_RESCHED set when we do _not_ need to reschedule
  * a decrement which hits zero means we have no preempt_count and should
diff --git a/include/asm-generic/preempt.h b/include/asm-generic/preempt.h
index 51f8f3881523..c8683c046615 100644
--- a/include/asm-generic/preempt.h
+++ b/include/asm-generic/preempt.h
@@ -59,6 +59,20 @@ static __always_inline void __preempt_count_sub(int val)
 	*preempt_count_ptr() -= val;
 }
 
+static __always_inline int __preempt_count_add_return(int val)
+{
+	*preempt_count_ptr() += val;
+
+	return *preempt_count_ptr();
+}
+
+static __always_inline int __preempt_count_sub_return(int val)
+{
+	*preempt_count_ptr() -= val;
+
+	return *preempt_count_ptr();
+}
+
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
 	/*
-- 
2.50.1 (Apple Git-155)


