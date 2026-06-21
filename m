Return-Path: <linux-s390+bounces-21071-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iAE5MntOOGq4awcAu9opvQ
	(envelope-from <linux-s390+bounces-21071-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 21 Jun 2026 22:50:03 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B356AB8F9
	for <lists+linux-s390@lfdr.de>; Sun, 21 Jun 2026 22:50:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b="g6iAM/3x";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21071-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21071-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59103300B476
	for <lists+linux-s390@lfdr.de>; Sun, 21 Jun 2026 20:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955A1364EA5;
	Sun, 21 Jun 2026 20:49:58 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC381643B;
	Sun, 21 Jun 2026 20:49:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782074998; cv=none; b=r+LFd2t7km5cueYI9qf+RrhohR2RydnJwQeb8EjnpHeA37e+278yHRcKR9uuouua58zMkT4eUIeabpdFLyu69+hNL1z9T59Z2i0WPkb0bWn0nYDsrLe/0/M/j5Wa6SrOL9a7qdSKOKbSjTKd9BPXBLpNxbHROWF/N1u1et2zvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782074998; c=relaxed/simple;
	bh=7lkfirBnw1Xta7UexC6RyUUzuxWU5/cPK+BGvQuqhIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daCKqZhHSd75U6xAS0BUXEI+XVGZDROaCVkf7MBVGidleTL12URZCY/O4ecrPSOTkhgolZwKNZJyvwhVselwbKQgonQFmW/r0DOtrK6is0VS7abSJMYWSli0Q5K6X9gTH5sGhRGsIFtovh+2RZs8w8uCSNILZ4Evd6VWU7bCikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g6iAM/3x; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M8eA5erpVUaElEed48rJS2wGTR5+Yv1nLd38ESSS2Rw=; b=g6iAM/3xDdWgV5X+yh4FkmLv62
	OiHp0rJWKrS0azBEgV4lUi6tf73QIx3b1EfxkJWLE9+0vYHZwchHgBudDH0pHDxxXgTjwrWdu/mct
	Pv33b+2kvV7VjO9v7r9ZJhg42qZrzl0nH7+5lsv84CGZePPxYtNzgtc+jHFw/OqqVr5gfB6dJeyht
	Ta+Y3SqdvDLqXkzUCijftXQvtQR1xKMpDX3P8Pi4bp33DePJ+q2Ae6ol72ij7EXyHBJ2UsHVBJ0x9
	+qUBkAxK1+zVPdKdmOAH0oG08P8SIzHjxBxu4r6NIyihQBFDoDV5qvDZCRzyYtm8IkqtseF10HUAj
	vqUbW0Ug==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbP6X-00000002ysn-1JeK;
	Sun, 21 Jun 2026 20:49:21 +0000
Date: Sun, 21 Jun 2026 21:49:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Barry Song <baohua@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, vbabka@kernel.org, rppt@kernel.org,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	Nanzhe Zhao <nzzhao@126.com>
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ajhOUdbWsswgQyl2@casper.infradead.org>
References: <5zdaa5uv5oj27q3taopl3amops57ouxgyfsdveudz4ovmbdw7z@6lwrlyvmhcp2>
 <CAGsJ_4yKxg1QugcsJi3WD0KVGJKe-zXycgm5D6cRi9vWtNcpDQ@mail.gmail.com>
 <ag4h87CBd-gph9zX@casper.infradead.org>
 <CAGsJ_4zA8afu0xXy0WS+tMe-eesDX1W6UBmfAsuouUpcAgK8JQ@mail.gmail.com>
 <ag4kj84EcKqamdB-@casper.infradead.org>
 <3be9475b-0e8a-4df8-a130-4262f993973d@kernel.org>
 <CAGsJ_4xC5LdhuoWV1=tK-RZ5rkjc8aOKOkmb1L_8BG_3gtJhDg@mail.gmail.com>
 <ahB6QyHgYq8ksj65@lucifer>
 <CAGsJ_4zxLvZ01i19vdo0xA47T1hxa1VRYvxLmiDhy5q1GDKPRg@mail.gmail.com>
 <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHTxaU4KdNmefU7C7cWZSLCFDLPdUrnqV6yzxzN+8RQ0Q@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21071-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[willy@infradead.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:surenb@google.com,m:baohua@kernel.org,m:ljs@kernel.org,m:david@kernel.org,m:liam@infradead.org,m:akpm@linux-foundation.org,m:linux-mm@kvack.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:mhocko@suse.com,m:jack@suse.cz,m:pfalcato@suse.de,m:wanglian@kylinos.cn,m:chentao@kylinos.cn,m:lianux.mm@gmail.com,m:kunwu.chan@gmail.com,m:liyangouwen1@oppo.com,m:chrisl@kernel.org,m:kasong@tencent.com,m:shikemeng@huaweicloud.com,m:nphamcs@gmail.com,m:bhe@redhat.com,m:youngjun.park@lge.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:loongarch@lists.linux.dev,m:linuxppc-dev@lists.ozlabs.org,m:linux-riscv@lists.infradead.org,m:linux-s390@vger.kernel.org,m:nzzhao@126.com,m:lianuxmm@gmail.com,m:kunwuchan@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,infradead.org,linux-foundation.org,kvack.org,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org,126.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,infradead.org:dkim,infradead.org:from_mime,casper.infradead.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42B356AB8F9

On Sat, Jun 20, 2026 at 04:48:57PM -0700, Suren Baghdasaryan wrote:
> Just checking in on the followup plans. IIUC the RFC mentioned will
> try to implement the solution we discussed at LSFMM: splitting
> VM_FAULT_RETRY into two flags - one for retrying under per-VMA locks
> and another one to fallback to mmap_lock.

I continue to hate this idea.  I don't believe that those who were
pushing for it have ever tried to understand the whole fault path.
It's utterly byzantine.

I defy anyone to make sense of this:

        /*
         * NOTE! This will make us return with VM_FAULT_RETRY, but with
         * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
         * is supposed to work. We have way too many special cases..
         */
        if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
                return 0;

        *fpin = maybe_unlock_mmap_for_io(vmf, *fpin);
        if (vmf->flags & FAULT_FLAG_KILLABLE) {
                if (__folio_lock_killable(folio)) {
                        /*
                         * We didn't have the right flags to drop the
                         * fault lock, but all fault_handlers only check
                         * for fatal signals if we return VM_FAULT_RETRY,
                         * so we need to drop the fault lock here and
                         * return 0 if we don't have a fpin.
                         */
                        if (*fpin == NULL)
                                release_fault_lock(vmf);
                        return 0;
                }

Wed need to simplify the fault path, not add additional complexity.
Josef has said he wouldn't've done the lock dropping had we had per-VMA
locks.  We should rip it out.

