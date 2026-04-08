Return-Path: <linux-s390+bounces-18633-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ65ME6y1mmFHQgAu9opvQ
	(envelope-from <linux-s390+bounces-18633-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 21:53:50 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1863C3743
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 21:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D1163021B19
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2026 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F172A3803C2;
	Wed,  8 Apr 2026 19:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TyDAes4r"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F32228CB8;
	Wed,  8 Apr 2026 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775677811; cv=none; b=FDshMcRdZaUcdgiLAWqJX26dRusGy2K+nKshizw7wY9unSckL5Y9bXnjk0HZuw+k5p+qsmtUawJKVWovx00M6PwRqRXhN64vEhsc0jOGNyl0JrtPOFbFkV+7dXjWBRZIPSjwNE3+mEyQZsoRXMxvp7uCLehCgin/45zFe+z+6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775677811; c=relaxed/simple;
	bh=uRuC2f4AV8+gonHc9J0+gQfrpGlhCSwfP5DrPfuTpos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ej8Gcjy4F6w3jujNUoWmQQe1uVu0c+emwNxYzZahrlGtkflTMYfxM3Bi0WTmsZEOeqayPnJxsZ+8sIHMJckiWkJZtdAPMYFicdDPT1cQj7gT5CoS3EgSYHHpHmbw/djdIiTMCD27bJepLrQCxHT9Drb0vKWifEKINkGCEGAL1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TyDAes4r; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rqfHIKMJG4o9KpbmGAbUtbTRjKCgElpRQKpWc5hqOfc=; b=TyDAes4r/JzVJCWef5mCqmoY0R
	9qb6eoM3SlzyPGbIuuNBr5yUDWjEkyEOgm+2iOJqjGRgkerfCrKjk3c2xo/Qv00YGiF6njKOW1atd
	ox6BnpO+4pTok5Xu0ihl/cEqhnvHHqvNYqiiML7gEOpJQPoRUESqNKDcvIcVYyQ/27Q5Vk7PZORpr
	aFalAmaqDaRMiucCoJYeVW1ovOGwuTQh+VgI0zVR+m07i1DTGDyrW1WtxODqHlagqJazZGJSj0jyL
	zk5b+Dl7/FROMKCAcpR+KvY7i4vz9YtDmonyYsP1abVRJDfQ5ilN3xLxJDih89BQ3g/xucUAb2gTR
	Q08EqEaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAYuI-00000005rWi-2gai;
	Wed, 08 Apr 2026 19:49:46 +0000
Date: Wed, 8 Apr 2026 20:49:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org,
	fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
	shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org,
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
	Liam.Howlett@oracle.com, ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Message-ID: <adaxWs8BjCJB1aan@casper.infradead.org>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
 <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18633-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E1863C3743
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 04:06:29PM +0100, Usama Arif wrote:
> On 06/04/2026 00:34, Hugh Dickins wrote:
> > What would help a lot would be the implementation of swap entries
> > at the PMD level.  Whether that would help enough, I'm sceptical:
> > I do think it's foolish to depend upon the availability of huge
> > contiguous swap extents, whatever the recent improvements there;
> > but it would at least be an arguable justification.
> > 
> Thanks for pointing this out. I should have thought of this as I
> have been thinking about fork a lot for 1G THP and for this series.
> 
> I am working on trying to make PMD level swap entires work. I hope
> to have a RFC soon.

I think you may have missed Hugh's point a little bit.  If we do
support PMD-level swap entries, that means we have to be able to find
contiguous space in the swap space for 512 entries.  I don't know how
hard that will be, but I can imagine it's not that easy.

