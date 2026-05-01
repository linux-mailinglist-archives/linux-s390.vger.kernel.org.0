Return-Path: <linux-s390+bounces-19261-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Bh+Bfe/9GkDEQIAu9opvQ
	(envelope-from <linux-s390+bounces-19261-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 17:00:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 892274AD76E
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 17:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36715301B913
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2026 14:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978893CD8C8;
	Fri,  1 May 2026 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Er8GF8z4"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18D42E173B;
	Fri,  1 May 2026 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647436; cv=none; b=NlF3vnCEnFhzSe+QDJS/yhgHpzjBR//UcPidoPv+eA7NPT3KH0efs9APmeueny5tVAwlzdioqDY/SzSiRz8OljpcNWjrWYjZuNUojEXVR76wbBcFvwTkA1geFhAg+3raqI9jfglvtc/lkyiLRGIsT52G/p1dnWnZL2cO61zgPhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647436; c=relaxed/simple;
	bh=ds5qEdrw885QHRjvKKYO1xHswqo7gHLI9viitfcmqVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzoIG24mBrbEDvp2oAM1L6B1F/8lFiWczTQXqxBTIkW/cNAc31BcqWvdDG9yRbEYhfNHFDhBgfLyBKolDmbneq/3tZE/9Q0KGWE/QMXOMx/WWDUktNh7pWPircSdRlW98AhasbGyy6QjXWIP1FoB9jclHXRUtFgCnyux2lYHFmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Er8GF8z4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GWaEOZ6T8RZshC5VNeX+VR+c38seOstsZgFtVZK1Yb0=; b=Er8GF8z4i4fcdoqldcSz6UdIrK
	0uV2fMmb401OPsbWUDQlEgY0WImYvRoaOS/51Kt7cci4PwM0IwWZmDRUbGXw7O9IkTUTcXx4Dq2Om
	1ySnKP5ZPsmA0cdTKwQEUsbejJKOkDxp+xsnqOc9et7bCG9WzZFKFYNxcz4UjijcH9lNIaYGg9axV
	D8CvZuRnVnBvGs0WeFCpwaRxMrcj+ZmM+kVA2Q+aDmR35tDfpqtDlNjfzVDU0ieNT7dT3nkuFY8KO
	oBaeuIlQkfSbM8D3+gtqA/Kl4BULEQcG2OPtDBswRpN88NbjoIlZE7bl29JItAlrzNVWRNazfWERT
	lB1uWyaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIpIN-00000008wbR-3iIK;
	Fri, 01 May 2026 14:56:48 +0000
Date: Fri, 1 May 2026 15:56:47 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Barry Song <baohua@kernel.org>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, jack@suse.cz,
	pfalcato@suse.de, wanglian@kylinos.cn, chentao@kylinos.cn,
	lianux.mm@gmail.com, kunwu.chan@gmail.com, liyangouwen1@oppo.com,
	chrisl@kernel.org, kasong@tencent.com, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, youngjun.park@lge.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <afS_L-5XeWIldTXA@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <afNM-gIqxpyJ6ro7@casper.infradead.org>
 <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4w0qcYmukHqsyRd0jomoyYkJjOt8b-Cgp53BgP-8QQghw@mail.gmail.com>
X-Rspamd-Queue-Id: 892274AD76E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19261-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kvack.org,kernel.org,infradead.org,google.com,suse.com,suse.cz,suse.de,kylinos.cn,gmail.com,oppo.com,tencent.com,huaweicloud.com,redhat.com,lge.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,lists.ozlabs.org];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]

On Fri, May 01, 2026 at 06:49:58AM +0800, Barry Song wrote:
> 1. There is no deterministic latency for I/O completion. It depends on
> both the hardware and the software stack (bio/request queues and the
> block scheduler). Sometimes the latency is short; at other times it can
> be quite long. In such cases, a high-priority thread performing operations
> such as mprotect, unmap, prctl_set_vma, or madvise may be forced to wait
> for an unpredictable amount of time.

But does that actually happen?  I find it hard to believe that thread A
unmaps a VMA while thread B is in the middle of taking a page fault in
that same VMA.  mprotect() and madvise() are more likely to happen, but
it still seems really unlikely to me.


