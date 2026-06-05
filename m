Return-Path: <linux-s390+bounces-20545-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id I1ouK2BiImoqVwEAu9opvQ
	(envelope-from <linux-s390+bounces-20545-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:45:04 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 586056453AB
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:45:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="gi/kWcPB";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20545-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20545-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06301309376F
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 05:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9883BB10D;
	Fri,  5 Jun 2026 05:41:57 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6486E3FE658;
	Fri,  5 Jun 2026 05:41:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638117; cv=none; b=pJK4EoMUiiPDQhL04rgF4Hh9zsaYO2Dv/O5t2ZZwSwSmv2fb0Aa5uDgbJSmipEZFGRJB47j89BwIbbJIldcm++Q5IwdS6PG9hA2YBxANYY/fqDpzYehvNnV7OLZON6ROjWnZQdFniQue7hWFLCwJN2jYxost9Ivk/9b0hJOgSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638117; c=relaxed/simple;
	bh=1Z0r1dd+5UaBxiJIV7yyJHPW2au7yP4Ki/behDAnWqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ng8yY9RsPixLkjkbm7gOgjEW30HrmjI4PUK10tzqaWaEBwVcykAZ+0U13AmUmcnJn37NGkTdUf7fA0EYeCdfrmUgTECn28/VpHPldGfWVb/HU+rrAeIKHvWnEuu0zsBt/Ml8KsLEWxbJQm74Cp63gBTC4Ue7/6KC9L+N3pye1po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gi/kWcPB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9C41F0089A;
	Fri,  5 Jun 2026 05:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638115;
	bh=5fQe3JBbW1ecnzj9lOjL0hmTD9Wg7GMvup213RdzMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gi/kWcPBW3EaGbMHej9lPJNdHzD0aaT8t6m94Sjb60a27aJe7SiCne06Jsn+qxN96
	 37Y/n1XbOxEYpKdk49Ahtlzy2PwZ0iIpLwdYfYd8psvWHzyR8CEgchyzJPtRZvHS4r
	 tIrYbyabjXurnV9xC63mXw5P0tsIRx+JcoMvwdpsep7j/w9zRYfFMO4AuLsmq2cgvv
	 nBkwod7gMrEG8isIGul3Ofp7t9ajodlfFo/by06YuEXHLen9VPQtepXJiCal9ygT/G
	 8DlzVulejJ3igmv2NIcyt0Gtxy1ms1LGR2LOgAXAHlh3kiDSpks4jlsEamObzqj9xq
	 E7FpkXeg/8QMg==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9C7CF40068;
	Fri,  5 Jun 2026 01:41:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 05 Jun 2026 01:41:52 -0400
X-ME-Sender: <xms:oGEianlN_5rsB1GeTKn6p8es7AKhoEEYWtxLU-mB0Hl5BMwJCG6axg>
    <xme:oGEiaj_gEhoQMawMdeXMc6D9msfX9jUtd-JsByJR3cz5tUJu5KaAwFWC0C9QDVVKo
    W1EqjlJFsP8lh4bJRLcwyoyrOb79KU1DF-oaP01O9sAX4pcU5rIVg>
X-ME-Received: <xmr:oGEiamiHuv84r2AaGggsNvomEYPG4qG4kbH0jRaO3Is7p084U0ZMDKjg49Y>
X-ME-Proxy-Cause: dmFkZTFG0WJa+84B5ZLakFCJusLrHx60u/M2e4tgb8vvSWGQWHXMFZeKktHow9VrFaQhwL
    60vkPLe/GHUXrF9uQjn9EtWhYCiYebO343SXKkauObGNd0gaHEDMGyAUdMEWI3xvV5+MXM
    Y5XIGIH+RCj/YpjPsc3XHQUzqyjdf8JDGbXE7uRDsVlh2adsQWoVoEG+11Li6tmpxBjo+n
    GbGHXxcMsG5BC+v/PWXz65OFiJmnJTn18gjrdwmPsAQA0I/XEj3HJhBv36WGSvCgORqSG4
    pkDfFOinWXk05Px2n3ZYSDFusuNrnah7Cqk2jZsViR99U7a3ccatK3SGLf/zDxH9xSS8rM
    AOeG5ePFZZfA76kOVqoCfj7btvpGgV7BkafEpMDLqRqYQteE3BP+Zkc3tGEg6HKAx5ebSG
    +mfyKbfml1bRlYZdW9QkLLsmbzmqf4KpTRUTEWVFfODasljVxHQMv5gX9K8gy1vxzFXTaU
    cZCZZhuI5rcfutz0yazglWB3rJwiDthh8IdApnGVTsXOrx3v5UsJw77FXSlh9Kv42p15JE
    WawlWP7bZ34qpayMprYpdDmWSqEzyCJKbCu+zWYZNgKoMIsVhnPsVU7hmpSe6Ah/EF1PrW
    mwcS+qw7SgGtRJaM1gozqo5XbhQOYZn73l24WeQ/UR8UYb5mg5SORHHlOdLw
X-ME-Proxy: <xmx:oGEiaiMLDgx_zc02cCydtWl7WMYUSSLaYNW5slQEuBbWP3YaQzrk-g>
    <xmx:oGEiatOKVnKiuxjAhXwiQQ6XEs_Zvx8GEQkgHnfsbqev8tQaH29gkg>
    <xmx:oGEiavhrrjEwhs_FJU3DtSmkKAy5Lal6sw0JPtn9b1MxdwHKa89OzQ>
    <xmx:oGEiagVqmNKa6epK2ezpJDG0mPMWS6bDFcgGpXuHWOKRwKrNQVX1kw>
    <xmx:oGEiapcxNGDbEAt0F2WpSoI8ywrFTOxZe7EyJ0w7eM88nQxH9B5MnxO7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:51 -0400 (EDT)
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
Subject: [PATCH v3 11/13] arm64: sched/preempt: Enable HAS_SEPARATE_PREEMPT_RESCHED_BITS
Date: Thu,  4 Jun 2026 22:41:26 -0700
Message-ID: <20260605054128.5925-12-boqun@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:boqun@kernel.org,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar.gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20545-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 586056453AB

ARM64 already uses 64bit preempt count and the need reschedule bit is
maintained in a separate 32bit than the preempt count. Therefore preempt
count has enough bits to represent 16 level of NMI nesting, hence enable
it for ARM64. This saves a per-CPU variable and additional instructions
in the NMI path.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fe60738e5943..8178cb857115 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -248,6 +248,7 @@ config ARM64
 	select PCI_SYSCALL if PCI
 	select POWER_RESET
 	select POWER_SUPPLY
+	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
 	select SPARSE_IRQ
 	select SWIOTLB
 	select SYSCTL_EXCEPTION_TRACE
-- 
2.51.0


