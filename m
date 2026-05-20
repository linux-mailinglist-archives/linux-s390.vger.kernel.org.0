Return-Path: <linux-s390+bounces-19874-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DcyN+ywDWpy1gUAu9opvQ
	(envelope-from <linux-s390+bounces-19874-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 15:02:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C86458E694
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 15:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A9B6303CC2C
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 12:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C653C1413;
	Wed, 20 May 2026 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odw+ysF2"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1757B3C661A;
	Wed, 20 May 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779281770; cv=none; b=PUyc5l0cdqjK7Sq3yJtdlRgYu8hkzMgHRj+W/fq6bbookRVuGcqTmXQsoagP5QMCtk7WMylsiz1TfMDXV60gpg32R3GB5BH5FZunFGJvCYDUmDmF8/crHDtjPjasD85ZyrDwJPjOurns5peY3HWDrgzrrZA+STk5i3bV0cwk/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779281770; c=relaxed/simple;
	bh=ehjp2pyKA5Vmb1tl80rzsbvCFR/pkm4mxPnsNK2uQRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dr4YbRoIhD0Yld979/OqpVK/5viDElb79oUOuOUg/JgWwWA5rC0y/5GAw27/zIuxwFmZTqkrekMjUkLvyqFv0FFzXo8erNrH4pgcncKtLLsluealKkm+kCF6gIjZBngqm6if1xbn8orYfxA2bYqGZuoZhuKq/9N0yl4etSIWMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odw+ysF2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195301F000E9;
	Wed, 20 May 2026 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779281768;
	bh=IHcIhsCGtp+zFimfYJhlVXiifBlHPpWiDOsOVHQEJSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=odw+ysF2fSGs0CYgREQtSvLkA7C1vnjLq+yTGH8uUyZQL5gIwy8l0sgOhMQFrvR/U
	 uhiwWUqoaRwvkgB0dpBHlc/BUJ1q5+UUOAqod11j8iXpTYoTcMdKWbeJzuR6xMAqQ+
	 OvTmgxH6iYYQP1hB8J7APtE6URdQBmktp1g/AVzlcWRxqXXJ8L/XVRnaqQo7zC7Xng
	 ETzTvLZhkt1SvKxjfJTjvTYcMABci75fb1o2/YPfIpAPbJkiRERe++WMYYQiw7kmc/
	 0b+T91xT73D5pkQltTZRR+EMWtVC4246AhUUcvutCmfPfiXeX8053NtPz89QYDfQc2
	 xRaHqWoL1+79g==
Date: Wed, 20 May 2026 13:55:58 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Barry Song <baohua@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag2vKm3K00wCiwUV@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d1017a-e4c5-493e-bfca-932c6d64eaac@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19874-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,kernel.org,infradead.org,linux-foundation.org,kvack.org,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,126.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8C86458E694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 12:33:56PM +0200, David Hildenbrand (Arm) wrote:
> On 5/19/26 14:53, Lorenzo Stoakes wrote:
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> >>>
> >>> I think we either need to fix `fork()`, or keep the current
> >>> behavior of dropping the VMA lock before performing I/O.
> >>
> >> I see. So, this problem arises from the fact that we are changing the
> >> pagefaults requiring I/O operation to hold VMA lock...
> >> And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> >> is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> >> anonymous and COW VMAs only while holding mmap_write_lock, preventing
> >> any VMA modification. On the surface, that looks ok to me but I might
> >> be missing some corner cases. If nobody sees any obvious issues, I
> >> think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
> >
> > I wonder if you've confused the fault path and fork here, as I think Barry has
> > been a little unclear on that.
> >
> > What's being suggested in this thread is to fundamentally change fork behaviour
> > so it's different from the entire history of the kernel (or - presumably - at
> > least recent history :)
> I don't want fork() to become different in that regard.
>
> There is already a slight difference with vs. without per-VMA locks, because
> there is a window in-between us taking the write mmap_lock and all the per-VMA
> locks. I raised that previously [1] and assumed that it is probably fine.
>
> I also raised in the past why I think we must not allow concurrent page faults,
> at least as soon as anonymous memory is involved [2].
>
> ... and I raised that this is pretty much slower by design right now: "Well, the
> design decision that CONFIG_PER_VMA_LOCK made for now to make page faults fast
> and to make blocking any page faults from happening to  be slower ..." [3]

Thanks for the background will read through! :)

But yeah I think the transition from !vma->anon_vma -> vma->anon_vma being a bit
slow is kinda ok most page faults will of course have anon_vma populated.

Be interesting with CoW context, because we won't need to mmap read lock there
at all :)

>
> [1] https://lore.kernel.org/all/970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com/
> [2] https://lore.kernel.org/all/7e3f35cc-59b9-bf12-b8b1-4ed78223844a@redhat.com/
> [3] https://lore.kernel.org/all/2efa2c89-3765-721d-2c3c-00590054aa5b@redhat.com/
>
> --
> Cheers,
>
> David

Cheers, Lorenzo

