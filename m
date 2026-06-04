Return-Path: <linux-s390+bounces-20497-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvwpGAh0IWrQGgEAu9opvQ
	(envelope-from <linux-s390+bounces-20497-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 14:48:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBCE640088
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 14:48:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=daq4p9mT;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20497-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20497-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8419E316862B
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 12:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9154779AA;
	Thu,  4 Jun 2026 12:40:44 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9253A5E89;
	Thu,  4 Jun 2026 12:40:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576844; cv=none; b=Skes5YCuElk4Hyu/oNh/5sSalQDzPtpCD6u9XQMoyUffhgAFTH3ijAQutUcqdVAUlivGUVYjJlLQAvJ47ZQk+8/5oL9t64pWR75QvL9gtTRTYgRT71WTMde4ey6NGimEEYRmjL8IHNwzMyHfy5b+5PwcrUAzZPoFV1GfcLlykps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576844; c=relaxed/simple;
	bh=3motd/Kk9tEcEy98c5ncAGr3nNkb1fzwM1uTOGz4Qus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAVGqEsQqFBvIfHaD01KJdfq6MfSaMT+/yB+cloAYXLcZBEqebiSjsuWaaEhLJ7tXXkUliKxyugyGhdgWcZGc4OKCwMF1y1NaL+fFd0oHFvlbGwF6DIkX/7N5uwUxOHC4RVVNMuptmLU2GQjIXMPMdt0bpjxegBHJp8icG41uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daq4p9mT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC31F00899;
	Thu,  4 Jun 2026 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576843;
	bh=GnOm+v7F1LKSbVaBQReSZi8hz25Kzy0nepO4bxrUVcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daq4p9mTxZM6hg5qQa/qHACfQnQNHHJBfDXDZldcF2oHlB3rhT2K9WeXrV8DpICBQ
	 ChETc4cbkLuTEfQQomffF4ZDXoOkbJlShcZp+gaRwsU03Ob6jh4vxRpGgmIybx7MiS
	 0Q6kTXsQaMMkiRlLva0vqHO8zJAZ25fV2lo4Iwm7JCR2aKboyZBL5lVEITHft9qxX0
	 GkQdYzIUJ5P8y31MMiUfphTTGDChzuxN8Hs86+X2QhDQOpjt8UdnXhaxci7Ao2eogs
	 lUnPqgL3gvZxrYqDe7AeVTZYhdiIepM/Oxx/uFb99h7xH99KiZewhfCg5FOfUIFW0e
	 /X2zv2MBvrBtg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id F3A80F40084;
	Thu,  4 Jun 2026 08:40:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 08:40:41 -0400
X-ME-Sender: <xms:SHIhakSnCrdg9gx5m4iHzTicKaK_DQbZUK11E3bhlG_5yYmLh4HVcA>
    <xme:SHIhamrf8l8qqXn5spEz_3zIQSqGxPGzydYKiqYC1Ad9mQIGDEO2BI-tVRzQTjo8L
    N8dPE-jHh3R_hm5kGq61j-lWA9098jHtcxIXHtK6lSOM5b04J8>
X-ME-Received: <xmr:SHIhanvyg3DUTUpzz1Tr6mmNDYVvEMOWhgBEhBREpTYdxxCkkBVJjshxDdQ>
X-ME-Proxy-Cause: dmFkZTF1BaCWatKURocL+NpcgGk8YfcgR1XBShgJesrvsvC2cG3vlDNwoRLKuuKWvI9wgr
    KG4Un6Q8MLsUhJ7qUby0lAaArhUaGksZuyniOIcFRF3jBJfW9luEJSa356GyMvadHeAIUB
    F7Fsk6uIaYS9/XUo/AHbvEW2iTXW7UQHwAiD96JBraglfj5eFgrMXQqkhBFZpo5fmGG/eI
    AQb5l6O4b5u+PthGYCRYvuYPUJXdmWKqj7KOhX79C+va6qRUJSnqWA/slW9fvEtsxZflmn
    cZYxt7SIfaZSY+71gr8mRZqSZhlvD3ofSHh//MmWZCDH7C7YuX5/Ca4yauFP5gCXu8R5e8
    ATuCazD5w14RyGhUDf8kJ2nnJlgWRO3UwgsRWPcouZeOlihQh5D8nnxfIJXtuCyTTW3jlv
    7TsEq+dkGy+hPVqy5gzBhzu74DPvX0twDJI7dlB6ID2+z1ZSG+J1UYSs61b9WIUb4ttyzS
    TjZSEePWTPWlDNq9PoUQQWqdzHgd48jCUCsvE2SpVwPE7xmxBMRNl9jVOmXJglehoDpXd9
    z7WWsk64xF+a6MwNoBsFE/yKMv6OSIpaAByuh/5HYUXC1C2pht/LVhYAvicEDOwXVeAMyN
    6QHhq6XTEBwnqHjw+vWgmxJE8KWrktttFqSpXIHL+Ldl3JEWwh3FcBx1FKuw
X-ME-Proxy: <xmx:SHIhaqeGCWvoTr6Zf4A7VuqQKHMJAl9R7ARuuX7SWO3hikB0EABGqw>
    <xmx:SHIhajm2MNfjagJxh9VKB7kVOB1FHuJFe5pi_tBuhyOPef0APhlWJA>
    <xmx:SHIhauE42o8acVl_EkD0i90rEiqekyJ5wDDuuU7N0Uc-cMcHHEKKFA>
    <xmx:SHIhapIi0Aj_i8f5RMMHTUFMJs_gmylfCV5Mpk-2TVrJhlM3iZONJw>
    <xmx:SHIhaktsp0bNSEQQ_zMYZ1h3aUBSoUkTxD9FkfVknP1rAqe0eaUb8bXA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 08:40:40 -0400 (EDT)
Date: Thu, 4 Jun 2026 05:40:39 -0700
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
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
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
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
 Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
 Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 10/12] preempt: Introduce
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <aiFyR-9rSGx38tWi@tardis-2.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-11-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-11-boqun@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20497-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tardis-2.local:mid,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@u
 mich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:nikunj@amd.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:work@onurozkan.dev,m:daniel.almeida@collabora.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[67];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BBBCE640088

On Tue, May 26, 2026 at 08:21:46AM -0700, Boqun Feng wrote:
[...]
> +#ifdef CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
> +static __always_inline void __preempt_count_nmi_enter(void)
> +{
> +	__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);
> +}
> +
> +static __always_inline void __preempt_count_nmi_exit(void)
> +{
> +	__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);
> +}
> +#else
> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> +
> +#define __preempt_count_nmi_enter()				\
> +	do {							\
> +		unsigned int _o = NMI_MASK + HARDIRQ_OFFSET;	\
> +		/* Maximum NMI nesting is 15. */		\
> +		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
> +		__this_cpu_inc(nmi_nesting);			\
> +		_o -= (preempt_count() & NMI_MASK);		\
> +		__preempt_count_add(_o);			\
> +	} while (0)
> +
> +#define __preempt_count_nmi_exit()				\
> +	do {							\
> +		unsigned int _o = HARDIRQ_OFFSET;		\
> +		if (!__this_cpu_dec_return(nmi_nesting))	\
> +			_o += NMI_MASK;				\
> +		__preempt_count_sub(_o);			\
> +	} while (0)

This needs to be:

#define __preempt_count_nmi_exit()				\
	do {							\
		__preempt_count_sub(HARDIRQ_OFFSET);		\
		if (!__this_cpu_dec_return(nmi_nesting))	\
			preempt_count_set(preempt_count() & ~NMI_MASK); \
	} while (0)

otherwise we would have an underflow issue if an NMI happen between
the "if" being true and __preempt_count_sub(_o);

Regards,
Boqun

> +
> +#endif
> +
> +
[...]

