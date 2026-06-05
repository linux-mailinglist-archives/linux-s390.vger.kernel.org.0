Return-Path: <linux-s390+bounces-20544-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m9R2CkBiImoZVwEAu9opvQ
	(envelope-from <linux-s390+bounces-20544-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:44:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A12645395
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 07:44:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RB4HIsSf;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20544-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20544-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E79EF30866E0
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 05:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831ED405C37;
	Fri,  5 Jun 2026 05:41:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA93FFACC;
	Fri,  5 Jun 2026 05:41:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780638112; cv=none; b=CLzxgblntFe+xVrRK5hmSkl6l0w7cyA9gPHZSQu0Evok8yi9dJ+deEmoWEResFer+47bl86ts9+LnBeojgR2sDV+Lw0Vc0xhOzKganIHP2slMFoxF21uI3/RfVaT7EF9H0PyOGe30a9gsn50ZFq3qYvOVhmjgxc9Q1Q+zTFVIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780638112; c=relaxed/simple;
	bh=EEF7M1M56zwwhTGXRepJ6Df3YmQZblYNwV9p/gbKAlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWTjDtDAhyOxOW33pm+IWEBkTNXPMzMRrIkqDcQYjIF8JX2ZNseHwgAh4hnmN8F1tIiQh4Fv8YctrcUs7eHXmS+bYhDlEstZ2167m5swYwkS0Wz5c25HXN2oOGctyByuR6WVMW1Vf4cEXiSq5II20TCdkJLp81Fpx0qTjThYSE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RB4HIsSf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EB01F0089D;
	Fri,  5 Jun 2026 05:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780638111;
	bh=pFJVb0XMzYiDkWRfHTccDmCKdRjygd0kE9XeKrNBbFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RB4HIsSfYEgjWyfr4hUayUE3CmgQAAWCWKfGfS/3XYYPc1AoVRTylpoHSRitlrxF0
	 0UA5hcEeDQfzrqvbFwP9zCZDXSixsQuXoxnl6jGuvhL32KZRWW6Z071BCACB4jA8QT
	 NMP+8lP22A2BTVLlkmbL+x76jIxFeTSqp+74LEzUaMGqXme78IYPLweSoQZrlJmT8k
	 OlheQM/kQZkJAkzBLSzEmTvwiYNzIJx8fn6ejjE/JOmBkAmx6uYVgWt921MF5XHb3E
	 r/IjxNat/FD7YT7rVknXbJdYTSQ+AsNzDTJ+7S7ge4VUqUsi6z7oynAiZoxJVghDd2
	 isHQAKIceV7Rw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0C7FEF40068;
	Fri,  5 Jun 2026 01:41:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Jun 2026 01:41:48 -0400
X-ME-Sender: <xms:m2EiaolB7zlLUj0MVetnv0Lsvm_OuSZabWrSq9osHKs3Qpozp4ceHw>
    <xme:m2Eiag8rRDqyS3A6ucXng57bGi9CfObuemW9vzQAVQqXDWuusIFzqEYAmF6iavR9z
    Nqj2IUgcwQrez3pPte48nhAs9iWsISntCneKtvv8hWeuDtjgs-Dbg>
X-ME-Received: <xmr:m2EiavhBrlXeuK1ihUb4nFGVIdcsodLWXNu7UT1K7f48RcFQ_GnHyFpHcg0>
X-ME-Proxy-Cause: dmFkZTFG0WJa+84B5ZLakFCJusLrHx60u/M2e4tgb8vvSWGQWHXMFZeKktHow9VrFaQhwL
    60vkPLe/GHUXrF9uQjn9EtWhYCiYebO343SXKkauObGNd0gaHEDMGyAUdMEWI3xvV5+MXM
    Y5XIGIH+RCj/YpjPsc3XHQUzqyjdf8JDGbXE7uRDsVlh2adsQWoVoEG+11Li6tmpxBjo+n
    GbGHXxcMsG5BC+v/PWXz65OFiJmnJTn18gjrdwmPsAQA0I/XEj3HJhBv36WGSvCgORqSG4
    pkDfFOinWXk05Px2n3ZYSDFusuNrnah7Cqk2jZsViR99U7a3ccatK3SGLf/zDxH9xSS8Bx
    NJDPeypZR+UT9k/SqltVTKWiw30nGSTGNtoJTZhFEw535tbPvHx+fxLRs5Z4ou1e4WVvr5
    fjYq3d0sE8tdFC8joSEqZ+Uo7JwQns/hPHB/VwsR4PvGZtpea1JqcCyFMlPJgyyx8EE4pv
    jvz4p8DgyUVrtSDfrlYz1plh7KfMMU0jKMO8SRKIOnV1u69YyXD/2yFnyoWy2B1n65QqoC
    B93ANNq/Xa14drwvS5S7v3OdLu8oSVLylHkLZ+VvgmcmCDl4meFSxlGDWOyi5EBtb/cBbE
    fuJpgrv2lvgm+etFqRsdjN9nNR9q729Z/AtVZ6SmDmULleejLzV6BAMpyAjQ
X-ME-Proxy: <xmx:m2EianPaMXuru3-AFtwyCA1Hta101iP2NV1KREiT8MywQg0mx5TlAA>
    <xmx:nGEiauOvl25w-t4m6rWXegZP32t47S6xYr4FPpP0_7KG1WGfqaucWw>
    <xmx:nGEiasiTdyvGC_-w9JyTZWBJF0BrS1MDgnYvGkNaRt2RHk-sKuvE6w>
    <xmx:nGEiapU9w_oFmGCo_I_q8s_KFerlmmVkOTri-Q557e6IBKiKtbhHCQ>
    <xmx:nGEiauelQ92Dl6HxLv5H5F0zH9kWEZXhm5Wsk3L3t5NUMhQi04Zx-7d1>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 01:41:46 -0400 (EDT)
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
Subject: [PATCH v3 09/13] sched: Avoid signed comparison of preempt_count() in __cant_migrate()
Date: Thu,  4 Jun 2026 22:41:24 -0700
Message-ID: <20260605054128.5925-10-boqun@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:boqun@kernel.org,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@goo
 gle.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar.gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-20544-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: D6A12645395

Currently preempt_count() is always a non-negative int on all archs
(PREEMPT_NEED_RESCHED archs will mask out the MSB when return
preempt_count()), hence the checking in __cant_migrate() is in fact just
checking whether preempt_count() is 0 or not. In a future change, we are
going to use all the 32 bits of preempt_count(), which would make
negative int values possible from preempt_count(). Therefore convert the
"> 0" comparison into a zero checking to prepare for the future change.
No functional changes are intended.

Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 75dba7cc09bd..636e6a15f104 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9207,7 +9207,7 @@ void __cant_migrate(const char *file, int line)
 	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
 		return;
 
-	if (preempt_count() > 0)
+	if (preempt_count())
 		return;
 
 	if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
-- 
2.51.0


