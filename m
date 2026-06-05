Return-Path: <linux-s390+bounces-20553-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HZYXAWRyImriXQEAu9opvQ
	(envelope-from <linux-s390+bounces-20553-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:53:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F59645AF3
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 08:53:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dK0zPN9m;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20553-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20553-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C18E3006B5F
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 06:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6954840FDA5;
	Fri,  5 Jun 2026 06:45:39 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75D33368A9;
	Fri,  5 Jun 2026 06:45:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641938; cv=none; b=sQcvGFHEpS3j5Op0iwqSYSd6rom9gtOnhQaX8tlOuzcYxtcwNphOUJ9NsTRozPu8rC1Nxh52jq5XOngwsSC/DOFGGhC9Qbuga+Y+jRgUmKPM3DCCiNTRusz9tQChe9ijEooqZD28nTz6ygFrYEU8vMzyB0sRYslvBmBGClpwll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641938; c=relaxed/simple;
	bh=ht0m413PEIPsvFhOM1o886ZRoLV1gC4nu/drcCsImqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/3Rz8n1eqVSp0U9qbImkqF5AtnP/qbMA44dDOBNbiXn5kI6mqfnkcKV9wuesJmqs5cKTiib9K/K6Zu0WME3nISiCM7bzlOhOIgUVhiWlgrG+Gh0N0PupF/o1wlARpIk3+gOsAfOURQCsypCmEDij+FYKlmYIXzxkSWYxMPPtaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dK0zPN9m; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CEF1F00899;
	Fri,  5 Jun 2026 06:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780641934;
	bh=6AYsKMuIdTg8BFUNDzRsVuHiBD4UL7B2xke/AuEe1z0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dK0zPN9mxzfuHkm4hcM3IAZJDt3m85l7bTjDAVJ/aM9X33cVUMHMAIeUPL4LsDIhp
	 k54xhzFHe2Q4W+KWJrjVRaG8F9zCXkYdJzie2Mh3vjAqFKr8u3F7D83v9wCnJ4oI9Z
	 h6/0N6w+4jquG06meZl9RL8Ss7yCedqPfDMJcji3RR9XOF7gpPigVmQdf0Sk7AA9IN
	 imdEVehSS8rQ+IBsAKH+QIFxrvmOpJukHhGwYYb+FZLJ64JEBQWmHTdTI/7jMPgQIk
	 JpEUrUXdPdRlMb8IGt0nJqhb0gJu+ic0bU1SCxeZ/v03ODFmZRaPNHatt4/BPS7cB2
	 p+W7TNNiZ8Z4g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6A0B5F40069;
	Fri,  5 Jun 2026 02:45:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 05 Jun 2026 02:45:31 -0400
X-ME-Sender: <xms:i3AiasdNhS_KlyqsumDnLI22Nji4lRgCBXcSawziHZ2KFg80dz_r4Q>
    <xme:i3AiakojmIrUnzTRKqDHplwGdcPbZxtOaTFP6K98Vj0YJ24e4Yl6aUGtq9D9Nzmvn
    dcMr-cG4jeurCmamtatymxfRXu8-9msdHJpL6xRRXmXxk5SNBRDTw>
X-ME-Received: <xmr:i3AiamWVTVH3_IAljezw_p-QLVIZaFjSRdoyaHFhFkYxqxmTVE3j8bXmTY4>
X-ME-Proxy-Cause: dmFkZTGlcVUQF+Wer3Y5GEVfzATn/deLTQvoklESl61u/rNXp18gne78kg+hRKjPmN+C95
    +Y+rXOz/wSPynF1ZkSdI0xvnTDk3JzZaYZOwjqPAn5fQPB5z2a4kXq2VN3blLahI0YorC6
    APEiTrZ02zYFXqZnZgAW76LEBfDjgETDW2APCndMnzlyLbZN8mPXZJRcW+BiZy/tT4XTI9
    gorxxmEj99FWScGx0DkJim8WCCu/p+rSQEv5zsCk6uLz2qEy3UOrvzI1IH/P0syZmm1PjK
    z1nsfspXhNfHZz9/FZPcRBYZZsf499hB7WRksmESyQj/3vQnvnMuEcLF8frbXbZ+jh3fYq
    F9er7eAogPZABVgXL6W7BcIowtwwkYDNbmnE3IOgIUgj9NagEvWW20FlTpx1yL6strEj/Z
    WJHbcOzvwEWsv8PV/fayj3VJ6keQBQfgmLk7QDi0JfAjld7LRft2EECvZe2ZYFD4zzOej9
    Nxy8uaR71MAQJHZKEy6xZSdbys0s6JQU1Ij1OY/VhQ/GBrcZf9PmTcsSLHJ/eSfwDSfzbA
    n0lCqO7VCrMBNcd8az+EodvJTqUDsl7rw3cGMPTDoCvxMwUOIZAoAT8nRABxxbcxFTW052
    QhmDCDgRZCK7bhjDhoaTeT5bgah4eMxVV4uUgn9Jy+K/G1Mb+K3JD6lRF7gg
X-ME-Proxy: <xmx:i3Aiak0_yaXo814KKvtjbSJLXyCjEkcH-jAjAUdSEKbjbfUGfoZPMw>
    <xmx:i3AiaoCA73VJ_JuQ_aX7YVQOERTqb8jzs1LYgHeSIzJEnG1wIJS8wg>
    <xmx:i3AiaqMkJXwDRZCfL3DNEZs0PCOCBrBagytlIIa-7N2B1_8f-BTGgQ>
    <xmx:i3Aiahi-nEmDbpxiyOSDZbNGp3rTP8ngb1TRRq9n44dGNgvY0THPRQ>
    <xmx:i3AiapA8TnDWJqClrosWAiqwxgG4UVI_aUwompfqr0Bbc312m9quGLuN>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 02:45:30 -0400 (EDT)
Date: Thu, 4 Jun 2026 23:45:29 -0700
From: Boqun Feng <boqun@kernel.org>
To: bot+bpf-ci@kernel.org
Cc: peterz@infradead.org, catalin.marinas@arm.com, will@kernel.org,
	jonas@southpole.se, stefan.kristiansson@saunalahti.fi,	shorne@gmail.com,
 hca@linux.ibm.com, gor@linux.ibm.com,	agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com,	svens@linux.ibm.com, tglx@kernel.org,
 mingo@redhat.com,	bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org,	hpa@zytor.com, arnd@arndb.de, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, kprateek.nayak@amd.com, longman@redhat.com,
	akpm@linux-foundation.org, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
	jolsa@kernel.org, shuah@kernel.org, ojeda@kernel.org,	gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org,	a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu,	dakr@kernel.org,
 ruanjinjie@huawei.com, lyude@redhat.com,	thuth@redhat.com,
 sohil.mehta@intel.com,	pawan.kumar.gupta@linux.intel.com,
 seanjc@google.com,	nikunj@amd.com, xin@zytor.com, joelagnelf@nvidia.com,
	andriy.shevchenko@linux.intel.com, rdunlap@infradead.org,
	ynorov@nvidia.com, bigeasy@linutronix.de,	linux-kernel@vger.kernel.org,
 linux-openrisc@vger.kernel.org,	linux-s390@vger.kernel.org,
 linux-arch@vger.kernel.org,	bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 boqun.feng@gmail.com,	martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 03/13] preempt: Introduce __preempt_count_{sub,
 add}_return()
Message-ID: <aiJwieZoxCBEZ2ji@tardis-2.local>
References: <20260605054128.5925-4-boqun@kernel.org>
 <d3e91d227b0e1b777a85806e54b03d46581e4460f893e5b45baa9168f5319fbf@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3e91d227b0e1b777a85806e54b03d46581e4460f893e5b45baa9168f5319fbf@mail.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,linutronix.de,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS(0.00)[m:bot+bpf-ci@kernel.org,m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryh
 l@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:pawan.kumar.gupta@linux.intel.com,m:seanjc@google.com,m:nikunj@amd.com,m:xin@zytor.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:boqun.feng@gmail.com,m:martin.lau@kernel.org,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20553-lists,linux-s390=lfdr.de];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tardis-2.local:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_GT_50(0.00)[71];
	TAGGED_RCPT(0.00)[linux-s390,bpf-ci];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90F59645AF3

On Fri, Jun 05, 2026 at 06:30:14AM +0000, bot+bpf-ci@kernel.org wrote:
> >     preempt: Introduce __preempt_count_{sub, add}_return()
> >
> >     In order to use preempt_count() to tracking the interrupt disable
> >     nesting level, __preempt_count_{add,sub}_return() are introduced, as
> >     their name suggest, these primitives return the new value of the
> >     preempt_count() after changing it. The following example shows the usage
> >     of it in local_interrupt_disable():
> >
> >             // increase the HARDIRQ_DISABLE bit
> >             new_count = __preempt_count_add_return(HARDIRQ_DISABLE_OFFSET);
> >
> >             // if it's the first-time increment, then disable the interrupt
> >             // at hardware level.
> >             if (new_count & HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET) {
>                                                     ^^
> 
> The operator precedence in this example appears incorrect. In C, the equality
> operator == has higher precedence than the bitwise AND operator &, so this
> evaluates as:
> 
>     new_count & (HARDIRQ_DISABLE_MASK == HARDIRQ_DISABLE_OFFSET)
> 
> Since the mask does not equal the offset, the equality evaluates to 0, making
> the entire condition always false.
> 
> Should this be written with explicit parentheses to prevent readers from
> copying flawed logic into downstream implementations?
> 

Will fix this but this code is in commit log rather than real code.

Regards,
Boqun

>     if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
> 
> This was raised by sashiko-bot@kernel.org in v3 review:
> https://lore.kernel.org/all/20260605055933.EDF3D1F00898@smtp.kernel.org/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26998319662


