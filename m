Return-Path: <linux-s390+bounces-20456-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vTSgM7R+IGpG4QAAu9opvQ
	(envelope-from <linux-s390+bounces-20456-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:21:24 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EF463ACE2
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:21:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n4tkTAJG;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20456-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20456-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52E9F3022DFF
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9C3DB62B;
	Wed,  3 Jun 2026 19:20:52 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72079481248;
	Wed,  3 Jun 2026 19:20:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514452; cv=none; b=JOi8HdYPtQClfxI3QuvJyTzcapwsGUl8Ue/6K4pa3h5WVftyL/uNW6iss7ctuD5BVfr3iKYaoyrFuskS5GVXz56Ho8nr0esYTNztdcXAg83cvFRYuK3ZjYQ/5Z+G4rRLzS3874Zqs4UwbHX4LX/6Z9My4ylyeUswEbmm1KfbOzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514452; c=relaxed/simple;
	bh=fcF2L2qJqR2J21wKlux/XhaLbrXjW+w0lA8W8N2pVNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6m91Mh+fdOXMNuJvM7M21HM3W5we/lUwnxcYLSlv/5a3zSSHqOdujBergbvg0Iw2aTz+8QdUOdAbrprPYEn6RLX6o5uVSUQnLFLMw7zL8WUSpH5uVI9uoGR4gRe/5vzKfqZ9y7Vzgmlhy9miMjeaZEtsN8r3YcBtuQubDw12OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4tkTAJG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE081F00899;
	Wed,  3 Jun 2026 19:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780514451;
	bh=MtjugWZzUUxCR/pWyiEIyzLKQZNA0zi91c/pvTORnJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n4tkTAJGgZ6s5gDvzmK9MOYw3MqPI4f18Sex8ajVXmg2YtTwCMoCuXTWuIP0cnVZJ
	 w1uXaaHIhSnQT3VXlreWlgWbXXLrUeWN8QiyOjkcuUglwwmNsBZCduMQe6cnBhsTLE
	 9obdGmV87ombD+3fk8xOlDcA1+nuxx+AJGFYk1hflKntP2wUlzdfY+M8mDNlbQ1riB
	 T5WuoO/EHX8zValSfJKMlVECtxsg4e85Ovz0oiJ62ylkoe/TQ900vWzddS0EABNV8V
	 RYJ5X/n3/iOUX0um0NxqUujEmzS0SPxoqmhrHmMt/yD3nr1CqEmnABb22y7aLvwiLe
	 vHqcrA9WrT5aQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id E6188F4007A;
	Wed,  3 Jun 2026 15:20:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 15:20:47 -0400
X-ME-Sender: <xms:j34gasQL4-Fd_zCg6zoUAew_Xfe2Tu-mM6kWak4fuCYZc3XEzysW7w>
    <xme:j34gauqpYK4MaASRZNRD9-LBvokpRFzAb6LBOCO8_ij3q6-cr8jFq843CT5kVkd-H
    k2PmHl7k3-Ro20QQJL02aoNQHj6QKq9oYoTdzV8veLpxIIv9zgsZw>
X-ME-Received: <xmr:j34gavsqMidDdxLXOSYcHEO-efGdp0Ke1g-VX-JKmRjf8VIBCJtTCh19I_4>
X-ME-Proxy-Cause: dmFkZTEeKZPKaxEW7sI+Y0OjRzaTROUW6RyGxvT1JY5zke8k7MdMeqjg5c3T8fCY/y7cWI
    j189K4S4lRXCvuW5BKdmiZ9flLa/Fp/BwLhxLdkpITLAAAHtEOChqQHhh39QPW0zEpiW9X
    qSGozLU6iDQyostAWt5KJUHnZDit/hu8dIn86X3JZQxg6wdJb1GrQzxuTLCyK3oUG6IAr4
    pA05MXi4+NjX2ZoyYefPheB+TPrymPSqGDOr+CgAAJddhHa49XUIPsiByV7vq4hOEKWskK
    Yu1enfoCKCyoPA3E/cV9cQEoN32DMeCrsN4HMNtD5WETRMRYCdN8ifZkJu5o7GJtbGgwQA
    tzd1q0CuKP6VWNIojSIWR4qkzbondVmNLu9zoDeAf8jlTdEJqku1mjELUs+derQnRNqtRP
    G78II45sF1gi4xAlp7aBtJ3SVdwV+LorBCq8nvlmWQ/sK9LCoOTIEujTVRB0uRGERSdBC8
    vEVKF7o7adHUQwV4aUQBOxDiyzeuua9nvw4uR+EfnO5xqSBuI730Yxy027VJgnvdgGGZ/h
    9gm5IpclBU9LqeZmDprL8aXAGLDlT4H1k9mU3F9PdsbfBm1FAFUUDg/Y5dtUWXVnunMtvX
    9StD62X568WMdQZLz4Zpldz1ousET1wIueR9kkQrmHyNHEFM68Y+n9mEBM8w
X-ME-Proxy: <xmx:j34gaieV-s9jS_1suoBu0diQkBqqRwVQeqAAHqS43hPkBW89eLo2LQ>
    <xmx:j34garni2sI6kdIt9hQV7XYrTaJ2-GeC83C2HsfJD7FNc2KMlnMEZw>
    <xmx:j34gamErStH6IlZpYki_qtN2QbRf3DZBWZ00VyuCwywqtc_mljYZ_A>
    <xmx:j34gahJjWQdzRQzwPLdR6Wtko0SDyFKaNy8IWYNEtTRhDWnJ2cnxGg>
    <xmx:j34gasviCm1UhxSR58jaTzzwL_2XMGhoX23niAhA_l4jblw_HAK9tiH_>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 15:20:46 -0400 (EDT)
Date: Wed, 3 Jun 2026 12:20:45 -0700
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
Subject: Re: [PATCH v2 00/12] Refcounted interrupt disable and SpinLockIrq
 for rust (Part 1)
Message-ID: <aiB-jQqWRmKqqH_7@tardis-2.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260527161844.GG3102624@noisy.programming.kicks-ass.net>
 <ahcc8Tudh4TJI5UM@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcc8Tudh4TJI5UM@tardis.local>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20456-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,tardis-2.local:mid];
	FORGED_RECIPIENTS(0.00)[m:peterz@infradead.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:jonas@southpole.se,m:stefan.kristiansson@saunalahti.fi,m:shorne@gmail.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:arnd@arndb.de,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:kprateek.nayak@amd.com,m:longman@redhat.com,m:akpm@linux-foundation.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:shuah@kernel.org,m:ojeda@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@u
 mich.edu,m:dakr@kernel.org,m:ruanjinjie@huawei.com,m:lyude@redhat.com,m:thuth@redhat.com,m:sohil.mehta@intel.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:nikunj@amd.com,m:joelagnelf@nvidia.com,m:andriy.shevchenko@linux.intel.com,m:rdunlap@infradead.org,m:ynorov@nvidia.com,m:bigeasy@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-openrisc@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-arch@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:work@onurozkan.dev,m:daniel.almeida@collabora.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 88EF463ACE2

On Wed, May 27, 2026 at 09:33:53AM -0700, Boqun Feng wrote:
> On Wed, May 27, 2026 at 06:18:44PM +0200, Peter Zijlstra wrote:
> > On Tue, May 26, 2026 at 08:21:36AM -0700, Boqun Feng wrote:
> > > Hi Peter,
> > > 
> > > This is a follow-up for Lyude's work [1]. After learning the current
> > > preempt_count() usage and how ARM64 handle this, I came up with this
> > > series that could resolve your feedback [2]. The basic idea is based on:
> > > 
> > > 1) preempt_count() previously already masks our NEED_RESCHED bit, so the
> > >    effective bits is 31bits
> > > 2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
> > >    proposal), the effective bits that record "whether we CAN preempt or
> > >    not" still fit in 32bit (i.e. an int)
> > > 
> > > as a result, I don't think we need to change the existing
> > > preempt_count() API, but rather keep "32bit vs 64bit" as an
> > > implementation detail. This saves us the need to change the printk code
> > > for preempt_count().
> > 
> > > 
> > > v1: https://lore.kernel.org/rust-for-linux/20260508042111.24358-1-boqun@kernel.org/
> > > 
> > > Changes since v1:
> > > 
> > > * Rename PREEMPT_COUNT_64BIT to HAS_SEPARATE_PREEMPT_RESCHED_BITS per
> > >   Mark Rutland.
> > 
> > Blergh, so I really don't like that new name. It isn't that
> > PREEMPT_RESCHED is separate, it really is a 64bit preempt count.
> > 
> > Shashiko has a few fits, but its mostly being stupid. Although I think
> > it might be useful to perhaps put a WARN_ON_ONCE(in_nmi()) in
> > local_interrupt_disable().
> 
> Yes, that's also what I'm thinking of, and also we need to check
> local_softirq_pending() in local_interrupt_enable() I think, because now
> HARDIRQ_DISABLE bits being non-zero means deferring softirq. (Shashiko
> also reported this as well).
> 

After some thoughts on this, I will postpone the idea of checking of
local_softirq_pending() in local_interrupt_enable(), because that
essientially makes every interrupt enabling a point to trigger softirq,
and that's different from the current local_irq_{enable,restore}().

Regards,
Boqun

> > 
> > Anyway, I'll re-read things again tomorrow, but I suppose this will do.
> > 
> 
> Thank you!
> 
> Regards,
> Boqun

