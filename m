Return-Path: <linux-s390+bounces-18971-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPYhGFh36GmVKgIAu9opvQ
	(envelope-from <linux-s390+bounces-18971-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 09:23:04 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB2E442E78
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 09:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 683493013B70
	for <lists+linux-s390@lfdr.de>; Wed, 22 Apr 2026 07:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B02C36C9F0;
	Wed, 22 Apr 2026 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mmhiYkVY"
X-Original-To: linux-s390@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4877F36AB4A;
	Wed, 22 Apr 2026 07:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842581; cv=none; b=ioLhXHAKxKXQpz4bzjhnbWO3p6DjOYFoDI7FokklIMQRmPlfg3tkmjKIX0hzn2Rsu7Y8nCxnF+w1IBIsQhVc7l38R/uN4SeffToLbxLFTl0jYAMzRsP04VgTrWlYHR8DM4uzi1C9aT4dbSjbovlHYEPex8fKemkOj2dS4yvBcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842581; c=relaxed/simple;
	bh=sRc5XRd88qnnYTUsgRaSZpfz9lFgEVT5Bz2KMe/l2Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rso0OsQ9roxsN99uxM1WF4LhFWZ2Klf/kClDNs0kLVtzSXp0e53M7XY/44i0Ryf/DoIEWI6z1Kyf8APAyboms+gNJeEqWCv5mTxQrgxs2YlSq50NTaoFgjPFHkbnbAU+11Pxaj51+U7F1xj/eGZIgC1kMmnrBYOROuCZe4Bj8Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mmhiYkVY; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1776842568; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=899XW99T8m7phQqcFM+gx4r/gMPFpYUZ5qz3cB2BL/I=;
	b=mmhiYkVYDCjD/ZOqzOFZl31j/pGldYJXEC55UU1TJmadbrZB2dzlyFCnM/9UAADYjH+2etSRJGnvI3VHeBeNZZDu0YA9iAhKhlLSYkmjM7Kb3CQz0fgKfToJs0K655mhpTaTYavjUzuk7xe+u12fILRJXuLuZvWqBEM8jOQMrmE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0X1VNEnq_1776842566;
Received: from 30.74.144.136(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X1VNEnq_1776842566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Apr 2026 15:22:47 +0800
Message-ID: <b6a6eead-cfd2-4459-9c6d-384dc6cd72d8@linux.alibaba.com>
Date: Wed, 22 Apr 2026 15:22:46 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org
Cc: hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
 mhocko@suse.com, brauner@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com,
 Minchan Kim <minchan@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260421230239.172582-3-minchan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18971-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.alibaba.com:dkim,linux.alibaba.com:mid]
X-Rspamd-Queue-Id: CDB2E442E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 4/22/26 7:02 AM, Minchan Kim wrote:
> For the process_mrelease reclaim, skip LRU handling for exclusive
> file-backed folios since they will be freed soon so pointless
> to move around in the LRU.
> 
> This avoids costly LRU movement which accounts for a significant portion
> of the time during unmap_page_range.
> 
> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
>       exit_mm
>       __mmput
>       exit_mmap
>       unmap_vmas
>     - unmap_page_range
>        - 55.75% folio_mark_accessed
>           + 48.79% __folio_batch_add_and_move
>             4.23% workingset_activation
>        + 12.94% folio_remove_rmap_ptes
>        + 9.86% page_table_check_clear
>        + 3.34% tlb_flush_mmu
>          1.06% __page_table_check_pte_clear
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>   mm/memory.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2f815a34d924..fcb57630bb8d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1640,6 +1640,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>   	bool delay_rmap = false;
>   
>   	if (!folio_test_anon(folio)) {
> +		bool skip_mark_accessed;
> +
>   		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>   		if (pte_dirty(ptent)) {
>   			folio_mark_dirty(folio);
> @@ -1648,7 +1650,16 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>   				*force_flush = true;
>   			}
>   		}
> -		if (pte_young(ptent) && likely(vma_has_recency(vma)))
> +
> +		/*
> +		 * For the process_mrelease reclaim, skip LRU handling for exclusive
> +		 * file-backed folios since they will be freed soon so pointless
> +		 * to move around in the LRU.
> +		 */
> +		skip_mark_accessed = mm_flags_test(MMF_UNSTABLE, mm) &&
> +				     !folio_maybe_mapped_shared(folio);
> +		if (likely(!skip_mark_accessed) && pte_young(ptent) &&
> +		    likely(vma_has_recency(vma)))
>   			folio_mark_accessed(folio);
>   		rss[mm_counter(folio)] -= nr;
>   	} else {

Seems we should also skip marking exclusive pmd-sized folios as accessed 
in zap_huge_pmd_folio().

