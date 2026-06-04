Return-Path: <linux-s390+bounces-20496-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k0eZMc5yIWpfGgEAu9opvQ
	(envelope-from <linux-s390+bounces-20496-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 14:42:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2BF63FFBA
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 14:42:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cZohoTIV;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20496-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20496-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E773D3086DE9
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E3D63E5EFD;
	Thu,  4 Jun 2026 12:36:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A31197B;
	Thu,  4 Jun 2026 12:36:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576603; cv=none; b=OWDZzva1oFizPIBPhLjbJRk/Huk5gNOwRrGcQuowmFiqalc16nqLgAvgMqeF/DPa0qqjC/W1MuW2AFOogwwpXSlSQSoiaVW+eWcmLfxU0tgj1TQIubvjXvxOynzwglSY0GIPmJk7QJNrTwfIKjwqLi5wuhOGlEe3+I5oANJ6dDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576603; c=relaxed/simple;
	bh=fb/j4RhN61MLa1Qk9TfcPzZk/H+4QghW1asCur8EklE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhAo+v2j5mrB/1Z8zbI71IalJcZHmc3nqICzfwslnSmLMPUPWo2UZGv2iQ9Zf1zAGRo2ulFS87i/TADP+nMzyNRsroNaX7jXicEyqFmz2OKPz1EL7Xv3/1FkpGljs4JbwhW39V7cWCl3UmpAGrS86wx68vk4CbjrhY2EmgXdvfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZohoTIV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F291E1F00893;
	Thu,  4 Jun 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576601;
	bh=G2t4b9T7YKjL70px21BHpISBAJ1CJJ2CGRX8h/3pybQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cZohoTIV4/o8HeJ21SCR2m5HRE+ERD8pFdijkHTlkYZKikCEtfT27nNAOkFPwUhPP
	 DaV1hx0f1PQhM7Ln/ZPPceQHZ7yI8e/KgD5z/sbq1mxzzu/Gb+t85ALF95lHmbK7lU
	 I6dzcbyWXZYzzxed0Lp9dhSRzf8mqefiPfEtOuiqXi0d+rj5W6DINuf4El1yEz1yR8
	 +rLRWkcyQmreMc96WebedQZslJSFd+FYEmcw438qQxHBrPqE0wjyfH1hBdNw42QMy9
	 ficZOBPH3I4uQCcfSrfh9S4IJoV1EA3C3ODu5tvEjsuxBv3YSbgA+uVLSSAvGLBekW
	 YsRfzJTQ+qWAQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 09DD4F4007C;
	Thu,  4 Jun 2026 08:36:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 08:36:39 -0400
X-ME-Sender: <xms:VnEhagZzao9gyXUu93RNckXpTAxkfVObN80Ho1taOPQdYigkCroIBQ>
    <xme:VnEhavbXeglNrO6gWeheBztORlLIBm2SMURYwDXzzM_SL5eI0pk_CA2Gco4nlikhz
    W0Xvo3cVnaMgIWfEKX7osPMd1CxMs1j__MLs3lNlZrg-zVvwuRc>
X-ME-Received: <xmr:VnEhaqAuPs88Zher25i5NkFsA4Hi6Md1NcEbWxn1Llk4vHkGLNy8rw7mwnw>
X-ME-Proxy-Cause: dmFkZTEQFwMtfD0LSxw/EWQ8kkWfNDbO1B39r8wgdzVN7edb5KWhufCaURpXW1jgf2CWrq
    XBWW3gIZcyl0yhjmX9ikFd4Pe/uurQpbuBtyZuFc3PXRL2zv2UA2M3gGkc55jKgRT9qAep
    WLiJtZPvNiYOsRfbJ/9+uNp4HhrZydvVwlIEGJiUspc/R12m8keG0+WcmEwV/bQBeVTM2r
    liekhxajBnCWjhAzVNgbVvojIzxbYqXCK1IdigNF/VMcqZ5YAbhiRFFvYqEjsoEdZ+UuHz
    ZgVQAr4ekHEvTUTFBwnby/fHqxidy/2fM0P9Wo0Gd0s6JapT6jXiJdVohmQHyTkiMdcWEi
    eVv+Y58tefCJqOIOwT9NqYVRgh4gjhLf6m/a8LLzr51MIW2WMhP/1EHC5R5VCf8T/p1S9P
    RmlE9um5TKSyWkyIfftuWVwigR6EuuNk6ekL/pl7XrJwXhJ53ljdQkqZh3N6+j+Qm72vyL
    g+n6IrLdjLnIO13IARat26zoWiOdc/k8JSsseB9HJKBOlvLGqjWe94CgA6dBT8oWfVv/tH
    8q9xwURjC9cGNy2sQX3Vr5GgYyd98cl+sKu19Ppr1eUcnZcsK4z8sqGwg4jESVuYZLE95g
    g6Ng4Iu4pf9wCnl6aD5b0AVVsNRevDZ1RJWlttuWhEaM64BIkluVYxjdjY0w
X-ME-Proxy: <xmx:VnEhasYQwHH8M6tRqmwkHnYMdgRjZziFsaIa09cda3HKlsvutRBK8Q>
    <xmx:VnEhajgh0Is2Pfttoi2bSpCGxHnKrhRkm0t0QDqqiJA9lU4EHLxSKQ>
    <xmx:VnEhasZTKobjv4pnrW4-aHoSRssGNMAqp_SWIZ-7-aLw6ae2OjppkQ>
    <xmx:VnEhal58u1XFkuHD6Z3Ut19o05Fwf1u_t4YWKglkALSHjIA_SdioRQ>
    <xmx:V3EhavVdLobtvhpiE4ac3NxE4XTOHF5WoOBYnFkGgjHSeF0bn8gH_Z5K>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 08:36:37 -0400 (EDT)
Date: Thu, 4 Jun 2026 05:36:36 -0700
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 01/12] preempt: Track NMI nesting to separate per-CPU
 counter
Message-ID: <aiFxVG3epMKAva76@tardis-2.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-2-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-2-boqun@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	TAGGED_FROM(0.00)[bounces-20496-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:email,tardis-2.local:mid,msgid.link:url];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@u
 mich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:nikunj@amd.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:work@onurozkan.dev,m:daniel.almeida@collabora.com,m:boqun.feng@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[68];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A2BF63FFBA

On Tue, May 26, 2026 at 08:21:37AM -0700, Boqun Feng wrote:
> From: Joel Fernandes <joelagnelf@nvidia.com>
> 
> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
> allowing those bits to be repurposed for other uses.
> 
> Reduce NMI_BITS from 4 to 1, using it only to detect if we're in an NMI.
> The per-CPU counter currently caps nesting at 15.
> 
> [boqun: Solve Steven Rostedt's comment on the BUG_ON() condition]
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
> ---
>  include/linux/hardirq.h                        | 17 +++++++++++++----
>  include/linux/preempt.h                        |  9 +++++++--
>  kernel/softirq.c                               |  2 ++
>  tools/testing/selftests/bpf/bpf_experimental.h |  2 +-
>  4 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> index d57cab4d4c06..1a0360a1000f 100644
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -10,6 +10,8 @@
>  #include <linux/vtime.h>
>  #include <asm/hardirq.h>
>  
> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> +
>  extern void synchronize_irq(unsigned int irq);
>  extern bool synchronize_hardirq(unsigned int irq);
>  
> @@ -102,14 +104,17 @@ void irq_exit_rcu(void);
>   */
>  
>  /*
> - * nmi_enter() can nest up to 15 times; see NMI_BITS.
> + * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
>   */
>  #define __nmi_enter()						\
>  	do {							\
>  		lockdep_off();					\
>  		arch_nmi_enter();				\
> -		BUG_ON(in_nmi() == NMI_MASK);			\
> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		/* Maximum NMI nesting is 15. */		\
> +		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
> +		__this_cpu_inc(nmi_nesting);			\
> +		__preempt_count_add(HARDIRQ_OFFSET);		\
> +		preempt_count_set(preempt_count() | NMI_MASK);	\
>  	} while (0)
>  
>  #define nmi_enter()						\
> @@ -124,8 +129,12 @@ void irq_exit_rcu(void);
>  
>  #define __nmi_exit()						\
>  	do {							\
> +		unsigned int nesting;				\
>  		BUG_ON(!in_nmi());				\
> -		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
> +		__preempt_count_sub(HARDIRQ_OFFSET);		\
> +		nesting = __this_cpu_dec_return(nmi_nesting);	\
> +		if (!nesting)					\
> +			__preempt_count_sub(NMI_OFFSET);	\

We have an issue here in the following case:

  // nmi_nesting == 1
  __nmi_exit():
    ..
    nesting = __this_cpu_dec_return(nmi_nesting); // <- nesting == 0
    <another NMI comes>
      __nmi_enter()
      // nmi_nesting becomes 1
      __nmi_exit():
        nesting = __this_cpu_dec_return(nmi_nesting); // <- nesting == 0
        if (!nesting)
	  __preempt_count_sub(NMI_OFFSET);
	// NMI_OFFSET bit is 0
    if (!nesting)
       __preempt_count_sub(NMI_OFFSET); // underflow!

I think we need to do:
      
#define __nmi_exit()						\
	do {							\
		unsigned int nesting;				\
		BUG_ON(!in_nmi());				\
		__preempt_count_sub(HARDIRQ_OFFSET);		\
		nesting = __this_cpu_dec_return(nmi_nesting);	\
		if (!nesting)					\
			preempt_count_set(preempt_count() & ~NMI_MASK);	\
		arch_nmi_exit();				\
  		lockdep_on();					\
	} while (0)

@Joel, thoughts?

Similarly, we have this issue in patch #10 as well.

Regards,
Boqun

>  		arch_nmi_exit();				\
>  		lockdep_on();					\
>  	} while (0)
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index d964f965c8ff..586f96688325 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -17,6 +17,8 @@
>   *
>   * - bits 0-7 are the preemption count (max preemption depth: 256)
>   * - bits 8-15 are the softirq count (max # of softirqs: 256)
> + * - bits 16-19 are the hardirq count (max # of hardirqs: 16)
> + * - bit 20 is the NMI flag (no nesting count, tracked separately)
>   *
>   * The hardirq count could in theory be the same as the number of
>   * interrupts in the system, but we run all interrupt handlers with
> @@ -24,16 +26,19 @@
>   * there are a few palaeontologic drivers which reenable interrupts in
>   * the handler, so we need more than one bit here.
>   *
> + * NMI nesting depth is tracked in a separate per-CPU variable
> + * (nmi_nesting) to save bits in preempt_count.
> + *
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
>   *         HARDIRQ_MASK:	0x000f0000
> - *             NMI_MASK:	0x00f00000
> + *             NMI_MASK:	0x00100000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
>  #define HARDIRQ_BITS	4
> -#define NMI_BITS	4
> +#define NMI_BITS	1
>  
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 4425d8dce44b..10af5ed859e7 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -88,6 +88,8 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
>  EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
>  #endif
>  
> +DEFINE_PER_CPU(unsigned int, nmi_nesting);
> +
>  /*
>   * SOFTIRQ_OFFSET usage:
>   *
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
> index 2234bd6bc9d3..2d4256ff471f 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -449,7 +449,7 @@ extern int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
>  #define HARDIRQ_BITS	4
> -#define NMI_BITS	4
> +#define NMI_BITS	1
>  
>  #define PREEMPT_SHIFT	0
>  #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
> -- 
> 2.50.1 (Apple Git-155)
> 

