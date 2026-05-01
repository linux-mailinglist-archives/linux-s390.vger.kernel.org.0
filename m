Return-Path: <linux-s390+bounces-19263-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFKwOpTP9GkYFQIAu9opvQ
	(envelope-from <linux-s390+bounces-19263-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 18:06:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C874ADEC3
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 18:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C28223007372
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2026 16:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D3E3EF0DE;
	Fri,  1 May 2026 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WFSklIdw"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628B3DC4AB;
	Fri,  1 May 2026 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651598; cv=none; b=dW5SDvkyxngEwNZFqOaIkMLfp5HlPccXsFkVvkVyw7MEkj6BkbgXTC/06SJOYrTZbUMVrtTfuJpcfOTw5Vh4MJtZZtVc+xz0UPvCBJivMoIap6lxhpCvh+VA4Uy+hvYULRzLDeNjKx0mjLlpNURFPmrPopJTNhTtb04E0mbj3cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651598; c=relaxed/simple;
	bh=uzJ2PI/5irzqcFSPjVCx7mCAKDQ9nari3HG292g6H0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkzwCoiOJ1LTTGJAo2IRt6pEWvB7Zxip22hI1+6jmS9KNbkgdIy08pI+6vm+VghWdiYLBm+6PA1kPqhpj53awPGqK9kDoD2rBIocmNw6AFEichZmX7ey8iCqSGmTsISNLWMZQh8RecSOHk1OxrUzcwmhlLJ1ucCiCmeDtt9Biwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WFSklIdw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HCOnYxAIgiWvR0Bg9Z3oQP7NtLB+AbBygf9mhxuV9oQ=; b=WFSklIdwMHQLNKo0hSt8FUEdor
	8PWAceSimwETsGI72z85Zv4wA/tsNlycLa8f6sQG/Aw6w8RnhXi0Af5mjum18LwybDyAvb1+Uxh9f
	Eq5T7ug+O10pWFjftTfOmniisY01PyMq7+2peSvdamJ+AAvHZRIQTazUoIUXsplGALDIdW/42jR8p
	U9uUO/7PltvaGp/EEhx55GmxP2PijjP4N8jL7/SdhnE0m0apJTc1yrnAE6WrXuehMZUnK54FJ0YvF
	M5qMff6H54NLzO+TN+U51R/JiQDmY0k5rW4FXREurwavyb9AebilT1ieN2HbK2yQvGHgLvA2FHU0e
	rgYRe6xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIqNP-000000091GR-0gTr;
	Fri, 01 May 2026 16:06:03 +0000
Date: Fri, 1 May 2026 17:06:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "Barry Song (Xiaomi)" <baohua@kernel.org>, akpm@linux-foundation.org,
	linux-mm@kvack.org, david@kernel.org, liam@infradead.org,
	vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, jack@suse.cz, pfalcato@suse.de,
	wanglian@kylinos.cn, chentao@kylinos.cn, lianux.mm@gmail.com,
	kunwu.chan@gmail.com, liyangouwen1@oppo.com, chrisl@kernel.org,
	kasong@tencent.com, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afTPamwDbtY_tgk_@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <afTKsSj0i-ZkRZN5@lucifer>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afTKsSj0i-ZkRZN5@lucifer>
X-Rspamd-Queue-Id: 41C874ADEC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19263-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,kvack.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, May 01, 2026 at 04:52:12PM +0100, Lorenzo Stoakes wrote:
> After a brief eyeball I share Matthew's assessment, I really don't like this
> series, it's piling on complexity for what seem like niche cases.

I don't think they're niche cases ... I think it's a real problem.
While our current code performs better for this workload than the
pre-vma-lock code did, it doesn't perform as well as it could.

> We already have enough weirdness in fault code honestly.
> 
> Let's maybe discuss at LSF if you're attending?

Not only is he attending, there's a topic scheduled (currently 10:30 on
Wednesday).

