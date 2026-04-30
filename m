Return-Path: <linux-s390+bounces-19243-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sl73NbZM82lnzQEAu9opvQ
	(envelope-from <linux-s390+bounces-19243-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 14:36:06 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F24A2C80
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 14:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58E4D3010D9C
	for <lists+linux-s390@lfdr.de>; Thu, 30 Apr 2026 12:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A0B402430;
	Thu, 30 Apr 2026 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iAUflMNT"
X-Original-To: linux-s390@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABC2580D7;
	Thu, 30 Apr 2026 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777552561; cv=none; b=re02+X6oYUy5kg6pOSMocpkaMvBUDDhTIqbEd5f2PSMfYC/LSbFGHu32TfgnAoUU7DABD5sMJV3J6a8NCwP4Z2PSq192jFyf/lTggtnLuUwobHdFbtx6OkKPmx8mwEpSA1xt1fcyelhT3DdmKaEQehBa/2EfMpqzsbllwVLu/Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777552561; c=relaxed/simple;
	bh=NpjPCAuO0cHXX6Uxki3ujO8q3e1V7kp6ktQotyMlRLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjdK88vxAD7HXXC2gC6Z3qSv6HJFpGBpv7AZCWpNjCqrYWnoGV2tUOKHRZC/ljkL3OWgR4LTHmTyOG4O9lJjNVX3OJKuCb1M+3b9kewhQgYgOfK46oaZyxvJyDp1Sj1F0TDxGZm+xdRS8UpDpIDKyfA6N3MZNpaOnKJICtUh26Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iAUflMNT; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z+Z3DKsnSFmL8ihuU1z6jpmoa/PGowkZGNbOeWbnqGA=; b=iAUflMNTY8s90bOygRPipE/x2+
	2rqGdbTRLii/gKwyDrwP3nkrR0VatKKYld/V/816iJ1P+tXhX+d+idNR+EHjQMboflVsiybW8W+j8
	eYWs7JCkiHvjY2IB2zf7TqoA45+x4aQ6qJmQlmCWvqYPr8NfFayhBn2Yo/Fe4ZPpdXhwYsAJOnz9D
	fjrOixede6cq1gwHChteZEiQiJMRusCYSEQAeQfmUhSpF81serK2xu7B77/VvMp8ZkRnZOjTGarSl
	f2YwbxhX7fGYNMGzMT5rb3gdo1ooWSq/7jwDHw+A2onKlKlIcG5HcwM0Ymw87xAmNi9iGAAb7Q4sY
	9LSfVJFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIQc7-00000007Dpy-0PSw;
	Thu, 30 Apr 2026 12:35:31 +0000
Date: Thu, 30 Apr 2026 13:35:30 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
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
Subject: Re: [PATCH v2 4/5] mm: Don't retry page fault if folio is uptodate
 during swap-in
Message-ID: <afNMkqwxC00OT134@casper.infradead.org>
References: <20260430040427.4672-1-baohua@kernel.org>
 <20260430040427.4672-5-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430040427.4672-5-baohua@kernel.org>
X-Rspamd-Queue-Id: 127F24A2C80
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
	TAGGED_FROM(0.00)[bounces-19243-lists,linux-s390=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,casper.infradead.org:mid]

On Thu, Apr 30, 2026 at 12:04:26PM +0800, Barry Song (Xiaomi) wrote:
> If we are waiting for long I/O to complete, it makes sense to
> avoid holding locks for too long. However, if the folio is
> uptodate, we are likely only waiting for a concurrent PTE
> update to finish. Retrying the entire page fault seems
> excessive.

I think the idea is good, but the implementation is misplaced.
The check for folio_uptodate() should be inside folio_lock_or_retry()
rather than tampering with FAULT_FLAG_ALLOW_RETRY in its caller.

Similarly for your next patch.

> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> ---
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 0c740ca363cc..a2e4f2d87ec8 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4949,6 +4949,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	}
>  
>  	swapcache = folio;
> +	/*
> +	 * If the folio is uptodate, we are likely only waiting for
> +	 * another concurrent PTE mapping to complete, which should
> +	 * be brief. No need to drop the lock and retry the fault.
> +	 */
> +	if (folio_test_uptodate(folio))
> +		vmf->flags &= ~FAULT_FLAG_ALLOW_RETRY;
>  	ret |= folio_lock_or_retry(folio, vmf);
>  	if (ret & VM_FAULT_RETRY) {
>  		if (fault_flag_allow_retry_first(vmf->flags) &&
> -- 
> 2.39.3 (Apple Git-146)
> 
> 

