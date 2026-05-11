Return-Path: <linux-s390+bounces-19519-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKPgKulOAmrIqgEAu9opvQ
	(envelope-from <linux-s390+bounces-19519-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 23:49:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C085167EC
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 23:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31FB93026F39
	for <lists+linux-s390@lfdr.de>; Mon, 11 May 2026 21:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F044D8D92;
	Mon, 11 May 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tomABWcT"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB04D2EF4;
	Mon, 11 May 2026 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778536141; cv=none; b=VmWi78YICdNvNg/XalbbOhsGfuSH+g5cTV/uR8hHW2aKhTI0N09BXpXVEvQTR0oFK+zIi2BVzyv5UzEElqXMLTJHDsDjDxF4gKK3n+g0ryfE7U/dgoS5jTWEk56Ufkuz0HAz/iSbPUDiRDCkqnBrdusOStwhY+L2LqAyXUjMWqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778536141; c=relaxed/simple;
	bh=5BQmJOTGx+nxkOVS+Q328vEXsZt1I3F1c0weN13LzI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBNwkbYGSrwSIW5aYd+q9rKZnFOI610pulZnIU60/7gqu9rKYnCoi2+4Lf1NLqVEgVY0Lj0fU0UKFQ5+IxJkWR61nZxpLlTpOMt3apYyxFy4T8An5PWJD1K49wWzUiqyfm627ErgglU47FBacbvSsy2ZXGt2k2kz8UkBus42K1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tomABWcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0B3C2BCF7;
	Mon, 11 May 2026 21:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778536141;
	bh=5BQmJOTGx+nxkOVS+Q328vEXsZt1I3F1c0weN13LzI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tomABWcTQ+Dmg4owGcstqgU4YUjwi09Bbs70dlz6K3UI0YMmjEZfU6kvoCUTevWH1
	 IoAUvYEDhjPzVAoSY1nOMyIv90VheIE+9Ev/ApE8SDrftopozrm8fo3w1yMu1VeTVh
	 GkUK6poSC54kK5Af4IeUD4laYXOszE5S/WqL4V97Tgarf6WuMVWWWOTLpPe7Oe5cW8
	 MI0sP7eTE/pgKmAfRW0xthetmxmz++onEphOjANsSHauuQ+4dqzA18Rq9COnzDVjQQ
	 zycfnL7F3U8i0Y4ZiWKqZ3sVS9q/If2sqw9q5l9cPUeWv8s19CMnBSUiI9pSCEF51p
	 PBsdow1fR1WqQ==
Date: Mon, 11 May 2026 14:48:59 -0700
From: Minchan Kim <minchan@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <agJOy1vnvYGipnku@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
 <20260505145318.97692A14-agordeev@linux.ibm.com>
 <af5cEycgIu2GUicn@google.com>
 <d9644dab-120f-485c-9324-205282d89234-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9644dab-120f-485c-9324-205282d89234-agordeev@linux.ibm.com>
X-Rspamd-Queue-Id: 11C085167EC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19519-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minchan@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 06:13:09PM +0200, Alexander Gordeev wrote:
> On Fri, May 08, 2026 at 02:56:35PM -0700, Minchan Kim wrote:
> 
> Hi Minchan,
> 
> > > > +void free_pages_and_caches(struct mm_struct *mm, struct encoded_page **pages, int nr)
> > > > +{
> > > > +	bool try_evict_file_folios = mm_flags_test(MMF_UNSTABLE, mm);
> > > > +	struct folio_batch folios;
> > > > +	unsigned int refs[PAGEVEC_SIZE];
> > > > +
> > > > +	folio_batch_init(&folios);
> > > > +	for (int i = 0; i < nr; i++) {
> > > > +		struct folio *folio = page_folio(encoded_page_ptr(pages[i]));
> > > > +
> > > > +		if (folio_test_anon(folio))
> > > > +			free_swap_cache(folio);
> > > > +		else if (unlikely(try_evict_file_folios))
> > > > +			free_file_cache(folio);
> > > 
> > > This condition is absent in free_pages_and_swap_cache().
> > > What would happen with non-anon and non-evict folio?
> > 
> > Are you asking about mlocked pages for file?
> > 
> > During unmapping, munlock_vma_folio() inside __folio_remove_rmap() clears
> > the PG_mlocked flag and moves the folio back to the evictable LRU list.
> > 
> > By the time the folios reach free_pages_and_caches(), if the folio is
> > exclusive, it will be successfully evicted. However, if the folio is shared,
> > mapping_evict_folio() detects it via the refcount check and skips the
> > eviction.
> > 
> > However, I realized we miss shmem folios in the swap cache due to the new
> > folio_test_anon() check we introduced. I will update the check to something
> > like this:
> > 
> > if (folio_test_swapcache(folio))
> >     free_swap_cache(folio);
> 
> This condition looks redundant, since free_swap_cache() checks it too.

What I meant is that the free_pages_and_swap_cache calls free_swap_cache
unconditionally for all those folio but my change in
free_pages_and_cached calls it only anon folio, which will miss shmem
cases.

