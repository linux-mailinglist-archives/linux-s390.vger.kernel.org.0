Return-Path: <linux-s390+bounces-19037-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCfjGHjF62liRAAAu9opvQ
	(envelope-from <linux-s390+bounces-19037-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 24 Apr 2026 21:33:12 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B4462F02
	for <lists+linux-s390@lfdr.de>; Fri, 24 Apr 2026 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF54D301B935
	for <lists+linux-s390@lfdr.de>; Fri, 24 Apr 2026 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F3730F806;
	Fri, 24 Apr 2026 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xr6CBaIa"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AEF26A0B9;
	Fri, 24 Apr 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777059188; cv=none; b=DHeWWptwDdFfWsld6f8jPyQ7GrhV9aSl6EGl7yQwiksGnlD4Pg3PZq1nvvN8dXPn0r+W45cw4uhDr6GXwGhI036hmNVRtIjC/JFTCOIcNfZpQaoKY0vErUnZCfU4wsT4pR/qYTibFqmcOl8satpRcfrCwiC9Z/1EnijcDzY4x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777059188; c=relaxed/simple;
	bh=+MYRbr3OFdV6Nbv+dV/7GlmTEIKQUJcsRWcYZSxJ0Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpKD9CC6Qyh2mfd/iVM8nDzuJ8iZIzohlJdwW2qZFayXRSndqtRYXvRHbuCULNxwBw5PwjMdu/cTn4lp+GiUmoMoEtTeNBC28NUFst/aGjhuuy7HZ04/6TjhlmqHYoHivg8ezMhxJ+o7ew3SadrnprewcH2D91bvJcFwP7KO2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xr6CBaIa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d2PAallPai3NT1Ru+JLoUF71PzOdI7Dew3EE7u60fC4=; b=Xr6CBaIapBw6xdIU6KkiuKamAU
	hhXfugzjoN1SzNwKa+AVSxK8MLw6gLgrFm8LB83ADQf37w8XGME1BmN0zQRbsQD6InAJvK7uZ2T6M
	Q6OeG/vjJk8H+ogxA3RQDIGtoi7TX1iuIRK0jV7z3i5KC3OO7PPv8fWnQuTnT2VQSEa19ewGDDogv
	kpJFRvfq5dwzrtWgJ7dmj5wzgZ7OYRjBhNZHx2Z/wEGZ/cVWgz6RGJYDTi/Y1J6nR0eh0pDaTge6D
	KRINvi/gXQIzWE6QRHNfq5mL0zLE5g1GCPE8ft/lldpy4oyyhe+7tDjUU8VjAnfHormcQWKauTOMV
	qQ7pEnDw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGMGt-0000000Fhjc-3cRb;
	Fri, 24 Apr 2026 19:33:04 +0000
Date: Fri, 24 Apr 2026 20:33:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH v1 1/3] mm: process_mrelease: expedite clean file folio
 reclaim via mmu_gather
Message-ID: <aevFb-ZemUo4nB3I@casper.infradead.org>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-2-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421230239.172582-2-minchan@kernel.org>
X-Rspamd-Queue-Id: D14B4462F02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19037-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]

On Tue, Apr 21, 2026 at 04:02:37PM -0700, Minchan Kim wrote:
> +++ b/mm/swap.c
> @@ -1043,6 +1043,48 @@ void release_pages(release_pages_arg arg, int nr)
>  }
>  EXPORT_SYMBOL(release_pages);
>  
> +static inline void free_file_cache(struct folio *folio)
> +{
> +	if (folio_trylock(folio)) {
> +		mapping_evict_folio(folio_mapping(folio), folio);

If we already know that the folio is for a file (and I think we do?)
then we can just use folio->mapping here.  On the other hand, if it
could be KSM or something else weird, carry on.


