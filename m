Return-Path: <linux-s390+bounces-19855-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFaRCgVoDWquwgUAu9opvQ
	(envelope-from <linux-s390+bounces-19855-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 09:51:33 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0C95892CA
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 09:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F253034669
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 07:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC35E399360;
	Wed, 20 May 2026 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gEybL7aB"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE9351C1C;
	Wed, 20 May 2026 07:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263429; cv=none; b=tKq+MLw7UkmTUmfm/jA1Ffma11JD8H6zjyWG+Fl9txdVn2lChy3lE0p3V1Yl+VOmJxbkEfzQv2PTPhnOsP1pWR8RDLaOCVFMLUgArt5mDpGW5TIRXHoW7EnWrMevlg26IjhfXcIk0aO6uHd1Rfo//EJ7lEWiaKd+4D3+z7CS4Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263429; c=relaxed/simple;
	bh=8h8QzQ3bvGW1O7RXX739a+wEI+Rm3n1kyOMDOPSvEn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBVrlK1TuRQ/zND3451PExaR4zRioQ+UxPJBEyDHQJB+8Voqq9F1+Mmzel6nGjBJsph5bFQlISoNlWYcOb11dl9KHhyX9LsNodLMAv37grrIlDU8leOfVYe+Sx1walKKB0gzDebTeG1tcukhn3ASV8KxpCJbzVs9sDb/wUzALBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gEybL7aB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B43D1F00893;
	Wed, 20 May 2026 07:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779263424;
	bh=8h8QzQ3bvGW1O7RXX739a+wEI+Rm3n1kyOMDOPSvEn4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gEybL7aBm3ng+QrbW0I+5Hs8oWbvhLnqN9+2v+IeAKE9ieM9FaKfZzY/r0KtvGAMv
	 UlbzgbPaCjqJHKsyF34JuP43LJBXrfZAZzHDm+DgqhrfaYDvVdJKPK2wZl0LGe4aDV
	 DBmnddYsaubogT9yRSf7C3WuNGyGQjd901PXhgvoWTTKLjmCjQCIVi1K4OqAzSKlXj
	 61TWkO1lsLpElgwhATl1xyR4ojLPcrMK/IY8eJJgK50WvGOcidhzXThsmufAMeqiFt
	 PseREKIwrtV7FeW3hPz53msuOkY9tNmm/x3Njh/sOFlQGLBEaSTgEbViYdNEZovb3M
	 9u5XlFtsz9bdw==
Date: Wed, 20 May 2026 08:50:14 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Barry Song <baohua@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, mhocko@suse.com, 
	jack@suse.cz, pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn, 
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org, 
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com, bhe@redhat.com, 
	youngjun.park@lge.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ag1mk2DSJsiORaxK@lucifer>
References: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
 <afS_L-5XeWIldTXA@casper.infradead.org>
 <CAGsJ_4wk=SDtgin+84Ev2TamU-JFfmrg_SUay=-tcYmnFvK6Nw@mail.gmail.com>
 <afTpoL3FklpQZNMM@casper.infradead.org>
 <CAGsJ_4ysMcrmDLSOwBkf7qwCQrcDWeEMXkHDajTJFMLKUk0bSQ@mail.gmail.com>
 <agrWuDNGddNmvMFD@lucifer>
 <CAGsJ_4zqLfdWoTH9s7FFaqWWj0mESfikYgr7=GcV64qcuXrPxA@mail.gmail.com>
 <CAJuCfpE0WQrB3zJp9qn3jvn5DthS=ttpX7gJJvyEhA_BJGrp5g@mail.gmail.com>
 <agxbq1TxJdniMQT3@lucifer>
 <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4zxyZP_xkFCGWfLyXkqomrX6DNqyMVirk=aggtwB1zExw@mail.gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19855-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,infradead.org,linux-foundation.org,kvack.org,kernel.org,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,126.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2A0C95892CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 05:18:52AM +0800, Barry Song wrote:
> On Tue, May 19, 2026 at 8:53 PM Lorenzo Stoakes <ljs@kernel.org> wrote:
> >
> > On Mon, May 18, 2026 at 12:56:59PM -0700, Suren Baghdasaryan wrote:
> >
> > > >
> > > > I think we either need to fix `fork()`, or keep the current
> > > > behavior of dropping the VMA lock before performing I/O.
> > >
> > > I see. So, this problem arises from the fact that we are changing the
> > > pagefaults requiring I/O operation to hold VMA lock...
> > > And you want to lock VMA on fork only if vma_is_anonymous(vma) ||
> > > is_cow_mapping(vma->vm_flags). So, we will be blocking page faults for
> > > anonymous and COW VMAs only while holding mmap_write_lock, preventing
> > > any VMA modification. On the surface, that looks ok to me but I might
> > > be missing some corner cases. If nobody sees any obvious issues, I
> > > think it's worth a try.
> >
> > Not sure if you noticed but I did raise concerns ;)
> >
> > I wonder if you've confused the fault path and fork here, as I think Barry has
> > been a little unclear on that.
>
> I think I’ve been absolutely clear :-)

On this point sure, I would argue less so around the fork stuff but I responded
on that specifically elsewhere so let's keep things moving :>)

> We should either stick to the current behavior - drop
> the VMA lock before doing I/O, or change fork() so that it
> does not wait on vma_start_write().

Again, as I said elsewhere, I think there might be a 3rd way possibly. It's a
big mistake to assume that there are only specific solutions to problems in the
kernel then to present a false dichotomy.

We absolutely hear you on this being a problem and it WILL be addressed one way
or another.

Of the two approaches, as I said elsewhere, I prefer what you've done in this
series to anything touching fork.

But give me time to look through the series please (I'd also suggest RFC'ing
when it's something kinda fundamental that might generate converastion, makes
life a bit easier on the review side :)

>
> Before per-VMA locks, page faults dropped mmap_lock before
> doing I/O. After per-VMA locks, page faults dropped the
> VMA lock before doing I/O. In both cases, fork() would not
> wait for I/O in the page-fault path.
>
> Now you guys are suggesting performing I/O while holding
> the VMA lock, which means fork() must wait for that I/O to
> complete. Since an application can have more than 1000
> VMAs, and I/O can be stalled for an unpredictable amount
> of time in the bio/request queue or filesystem GC, fork()
> could end up blocked on multiple VMAs while taking
> vma_start_write() for each of them.
>
> As a result, fork() could hold mmap_lock for a very, very,
> very long time. fork() itself would become extremely slow,
> and any other task needing mmap_lock would also be blocked
> behind it.

Yep aware, we spoke in Zagreb about this, and on this thread, we know :)

>
> >
> > What's being suggested in this thread is to fundamentally change fork behaviour
> > so it's different from the entire history of the kernel (or - presumably - at
> > least recent history :) and permit concurrent page faults to occur on a forking
> > process.
> >
> > I absolutely object to this for being pretty crazy. I mean I'm not sure we
> > really want to be simultaneously modifying page tables while invoking
> > copy_page_range()? No?
>
> If you object to touching fork(), can you at least accept
> keeping the existing behavior of dropping the VMA lock
> before doing I/O? If you object to both approaches, then I
> really do not know how we can continue :-)

Again as per above, let's not impose a false dichtomy, let's take our time, and
specifically - please give me time to read through the series and think about
this.

>
> Thanks
> Barry

Thanks, Lorenzo

