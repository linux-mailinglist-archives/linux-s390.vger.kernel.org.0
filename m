Return-Path: <linux-s390+bounces-20165-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGZIBkhSGGqwiwgAu9opvQ
	(envelope-from <linux-s390+bounces-20165-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 16:33:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42A5F3BE5
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 16:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5CEC3078BC8
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 14:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4AE3E7BDD;
	Thu, 28 May 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5GKoPBe"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42443F0745;
	Thu, 28 May 2026 14:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978718; cv=none; b=AVTrTT6JWmfJT0OgqLSuLxgmkx9LKyh2XkPEqlqIk+8avok1+XohaMoglx9vawmqpJ63gY9AGqAem9KnUVxYw+dZtZ2ty0EdSctbJHXeVEyu/gqJNoKGIOlIf0n1RCQlgjA2BpD9bMxux+fuPMvRu4Ks8k2bblig2QMGj4ENyNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978718; c=relaxed/simple;
	bh=DiSgb0xzS1Cb+1jztqkW0jzIomJtlcBZU/VVJkOi+fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=imgcA9t5PpRgW75WGN/NJsE9toFT4P45dohWJGJJUMKwhmnOnqVBiGg5DpAJXNFezMSFDWI5kh2/yqYstwyl/uNincFh/veuG/UAeC/0pwy1aODzJ52q9Fyi+qWfp9SlAh3WcAshEApUK+xbQxic5+TX1gW7SWl/WuPkW7q0KaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5GKoPBe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA671F000E9;
	Thu, 28 May 2026 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978716;
	bh=r8sGBUPFq+B088npM59l8i3bvZ+rfoLE32WJ5Kqd+TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m5GKoPBeuvhbuCVPHmRg7w0G4TFEMPZce49PVRyAc5XdczhluPfbc6oXll6CRYfR9
	 v6D9p9o2XLUR1FxQ5KCEl6bTPjs7oeEwM41TbCf7/ECmt0HlscIBhQGCJaTDvPROhD
	 iMQVv8iXIX5PKvVgmVmQtQNbIF7cvh5kdVpE47Cnr7erciIyAKyuLbzjwK1y4NF+ft
	 rZrm9gtuLQKZjFuaNFbeGPyqeOOkeHuSltT2HcRSCYB8MVVKQH8sRJkPUPJOV5JZJr
	 UYVaK7NwoXyd8d0zzSj9ZH1JytjspPhesC7sMnngjaAN4t3rBcsx8kFHXSZJnXSeEa
	 mBc81nU8o/WAw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 65A7CF4006C;
	Thu, 28 May 2026 10:31:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 28 May 2026 10:31:54 -0400
X-ME-Sender: <xms:2lEYaonyCscNUOqdUxXLRIKoFK9ZSQmVMeoEF78btpqXVUjNjnjsIg>
    <xme:2lEYanbiPQYuQbwgrfc84b8O7oxm1fZfbTgf3vQ-bucBLFw2xTDHPUTkDFM0cSZSm
    HWARZXHwLSTB0E0IPLN5pxHJQVdM6dVm25XwkgnanqRpmBcKL8y>
X-ME-Received: <xmr:2lEYaqbq33IQTEZ_quA9TzcNjc4Wo8WyJcPMfeR3bpPqGUS_VA_HBGQOLnZHTryGYfN66rDKNOMgcLK1ttEUJe8kOTgq56Ga>
X-ME-Proxy-Cause: dmFkZTFh+x5OYn8jFqDqC7Wfcfy34OS1sijeomaDwSfxCQL5ShWXDIyuF4+dB17if6fV1W
    XuNH0pLpYRaoxWFUOHRiglU0uQCEV7/dN5YqAXa87+3IJEn3o9kQ0tGuMZUB5OBJLK5s7U
    q6VUT6Lv/RaOhKG1NzlSDNHJ4AmBWaD/neZrbIHYEg01roAfUywWSelpZTbSsjC75BU+Vy
    v11QBGps7hxTDdVCp4G6LRpg5Jb9KVyMi6JxENUpaqdCSjcPKm9rzZ6TKjlC8RPtSpo81O
    KA3bMFNB6+8Jzw7xYNxA9bnMFzB2MIcHOD8uFROA7r+IKKukpunNc9S5ooFecE6RzJ+ttt
    rf/KWJRaBk7hXVddeQZ41joxtBH2x4CDqDMLMkq9b0KWXmUIndZGvBrFRpbl8+3VxejRc+
    x1mDHpDtgwhSamwF/uOA4X79HKjJ5TiDH7rhclXEeWUou/9JRp/N9iLRpmAzRF+T5a4Du9
    UqOUwqepPRlrdo5eppc2zzssD6rN5vo1gQ1qWenjfdOEP09XpTyys82w+CJH816p0o8yrU
    +fDkrJ9Gg4Yb7v4r6Xnk+8r+6sUw8lXFlcRbeZoPBxK685GhTd2jlvMm5bbXWxotpAtnTQ
    ZKSB1OoHJNT19txDu4Ybtx3lkFJre62sALVyrYkGoDERe9BfD+s5YuIUWFng
X-ME-Proxy: <xmx:2lEYapBDUVidk4r6QdXs2pAACJHe4x4k1w6BTkSTFPrk24nX-UT4FQ>
    <xmx:2lEYavaa72CY5FZkMcM8agvO8n0LAhYKGrI9eBT4Z2bgOiNotRlO5w>
    <xmx:2lEYaqgXdR37K9zNwBiMY6_tM0qQ_szjBUqw0Q7en-bFtKniR1Rd0w>
    <xmx:2lEYanbhDw4KpbqGHInrJz4x1uCujVfY-3ivUkDUi3Rt-4CGo1xY0w>
    <xmx:2lEYak7wBK7ht24XHEPsr-4TeCpLCXNXIKFTAHyY3WuNUTraNXoUKIc6>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 10:31:53 -0400 (EDT)
Date: Thu, 28 May 2026 07:31:52 -0700
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
Subject: Re: [PATCH v2 07/12] locking: Switch to _irq_{disable,enable}()
 variants in cleanup guards
Message-ID: <ahhR2MHf2gdg55PU@tardis.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-8-boqun@kernel.org>
 <20260528104529.GG343181@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528104529.GG343181@noisy.programming.kicks-ass.net>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,southpole.se,saunalahti.fi,gmail.com,linux.ibm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,linaro.org,goodmis.org,google.com,suse.de,amd.com,linux-foundation.org,iogearbox.net,linux.dev,garyguo.net,protonmail.com,umich.edu,huawei.com,intel.com,nvidia.com,infradead.org,linutronix.de,vger.kernel.org,onurozkan.dev,collabora.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tardis.local:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20165-lists,linux-s390=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[boqun@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_GT_50(0.00)[68];
	TAGGED_RCPT(0.00)[linux-s390];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC42A5F3BE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 12:45:29PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 08:21:43AM -0700, Boqun Feng wrote:
> > From: Boqun Feng <boqun.feng@gmail.com>
> > 
> > The semantics of various irq disabling guards match what
> > *_irq_{disable,enable}() provide, i.e. the interrupt disabling is
> > properly nested, therefore it's OK to switch to use
> > *_irq_{disable,enable}() primitives.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> 
> You really need them both? ;-)

Nah, I will clean this up ;-)

Regards,
Boqun

