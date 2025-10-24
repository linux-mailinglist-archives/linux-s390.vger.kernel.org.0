Return-Path: <linux-s390+bounces-14217-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2BC07FA4
	for <lists+linux-s390@lfdr.de>; Fri, 24 Oct 2025 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E903AC44A
	for <lists+linux-s390@lfdr.de>; Fri, 24 Oct 2025 20:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4E52DA75A;
	Fri, 24 Oct 2025 20:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Exbd5bsf"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E942DA776
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 20:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761336352; cv=none; b=nBTdpTPkvmVUHb8a1M2v8cFXszZr4IKT0mK//p/7bFEN3NqG5LgZHMi0IUPoKxIYKEyz6HaEJnlTN+obtnJqA9QdalGXbH3BF1AQVexN7L2dVxjIoFHRlLf6DXQL8G0+I7+B+yWVU1DwZR8xtudKoLV0k/oo7K9hNIXlF++UbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761336352; c=relaxed/simple;
	bh=zB12qLiW048+bzj+QWo/Yh48JJX7bRhXlhLPyLUgRT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPAT1QnPCkpVjIcx27Tt729FA9QkZ7UT5ltZPsoKQyjLF3UoSFdcR7Cu9UyCCDPhRUW74x7fyLC+QQfQd8z/JiteheZzjzp1QqXW3qcolcnCTrVzBZUtLRIdO41kpxUnFY54fPnPrDj0OaeDAWh8w/kiWB78cvyFkNaEe2BLFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Exbd5bsf; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 24 Oct 2025 20:05:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761336347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5kibUrhGEIh1wdjnl8ZsspLMeFM7U2onbljFtVXAgg=;
	b=Exbd5bsf/Tm5LIy+8QoVhG42/C0IUQp5OSAWxcboh4tanMCzpIkUQ79onbMEOK4YPdqCxs
	RjiNuyVFWKVgZL4lbRM0JP7q7nY9JQ3TVoH9vTDnZdiRfZFmye8OrvBUrGHwzOHyEGFvdP
	PEQs8k/CqVsM8cf4HYazoKCaJGZJVOw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/12] remove is_swap_[pte, pmd]() + non-swap
 confusion
Message-ID: <7tjpibvbt2nwkkrzcbrsw3t3ehxckjrro6vxqukh4ld4memodx@cxfpmwbr3fo6>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 24, 2025 at 08:41:16AM +0100, Lorenzo Stoakes wrote:
> There's an established convention in the kernel that we treat leaf page
> tables (so far at the PTE, PMD level) as containing 'swap entries' should
> they be neither empty (i.e. p**_none() evaluating true) nor present
> (i.e. p**_present() evaluating true).
> 
> However, at the same time we also have helper predicates - is_swap_pte(),
> is_swap_pmd() - which are inconsistently used.
> 
> This is problematic, as it is logical to assume that should somebody wish
> to operate upon a page table swap entry they should first check to see if
> it is in fact one.
> 
> It also implies that perhaps, in future, we might introduce a non-present,
> none page table entry that is not a swap entry.
> 
> This series resolves this issue by systematically eliminating all use of
> the is_swap_pte() and is swap_pmd() predicates so we retain only the
> convention that should a leaf page table entry be neither none nor present
> it is a swap entry.
> 
> We also have the further issue that 'swap entry' is unfortunately a really
> rather overloaded term and in fact refers to both entries for swap and for
> other information such as migration entries, page table markers, and device
> private entries.
> 
> We therefore have the rather 'unique' concept of a 'non-swap' swap entry.
> 
> This is deeply confusing, so this series goes further and eliminates the
> non_swap_entry() predicate, replacing it with is_non_present_entry() - with
> an eye to a new convention of referring to these non-swap 'swap entries' as
> non-present.

I just wanted to say THANK YOU for doing this. It is indeed a very
annoying and confusing convention, and I wanted to do something about it
in the past but never got around to it..

> 
> It also introduces the is_swap_entry() predicate to explicitly and
> logically refer to actual 'true' swap entries, improving code readibility,
> avoiding the hideous convention of:
> 
> 	if (!non_swap_entry(entry)) {
> 		...
> 	}
> 
> As part of these changes we also introduce a few other new predicates:
> 
> * pte_to_swp_entry_or_zero() - allows for convenient conversion from a PTE
>   to a swap entry if present, or an empty swap entry if none. This is
>   useful as many swap entry conversions are simply checking for flags for
>   which this suffices.
> 
> * get_pte_swap_entry() - Retrieves a PTE swap entry if it truly is a swap
>   entry (i.e. not a non-present entry), returning true if so, otherwise
>   returns false. This simplifies a lot of logic that previously open-coded
>   this.
> 
> * is_huge_pmd() - Determines if a PMD contains either a present transparent
>   huge page entry or a huge non-present entry. This again simplifies a lot
>   of logic that simply open-coded this.
> 
> REVIEWERS NOTE:
> 
> This series applies against mm-unstable as there are currently conflicts
> with mm-new. Should the series receive community assent I will resolve
> these at the point the RFC tag is removed.
> 
> I also intend to use this as a foundation for further work to add higher
> order page table markers.
> 
> Lorenzo Stoakes (12):
>   mm: introduce and use pte_to_swp_entry_or_zero()
>   mm: avoid unnecessary uses of is_swap_pte()
>   mm: introduce get_pte_swap_entry() and use it
>   mm: use get_pte_swap_entry() in debug pgtable + remove is_swap_pte()
>   fs/proc/task_mmu: refactor pagemap_pmd_range()
>   mm: avoid unnecessary use of is_swap_pmd()
>   mm: introduce is_huge_pmd() and use where appropriate
>   mm/huge_memory: refactor copy_huge_pmd() non-present logic
>   mm/huge_memory: refactor change_huge_pmd() non-present logic
>   mm: remove remaining is_swap_pmd() users and is_swap_pmd()
>   mm: rename non_swap_entry() to is_non_present_entry()
>   mm: provide is_swap_entry() and use it
> 
>  arch/s390/mm/gmap_helpers.c   |   2 +-
>  arch/s390/mm/pgtable.c        |   2 +-
>  fs/proc/task_mmu.c            | 214 ++++++++++++++++++++--------------
>  include/linux/huge_mm.h       |  49 +++++---
>  include/linux/swapops.h       |  99 ++++++++++++++--
>  include/linux/userfaultfd_k.h |  16 +--
>  mm/debug_vm_pgtable.c         |  43 ++++---
>  mm/filemap.c                  |   2 +-
>  mm/hmm.c                      |   2 +-
>  mm/huge_memory.c              | 189 ++++++++++++++++--------------
>  mm/hugetlb.c                  |   6 +-
>  mm/internal.h                 |  12 +-
>  mm/khugepaged.c               |  29 ++---
>  mm/madvise.c                  |  14 +--
>  mm/memory.c                   |  62 +++++-----
>  mm/migrate.c                  |   2 +-
>  mm/mincore.c                  |   2 +-
>  mm/mprotect.c                 |  45 ++++---
>  mm/mremap.c                   |   9 +-
>  mm/page_table_check.c         |  25 ++--
>  mm/page_vma_mapped.c          |  30 +++--
>  mm/swap_state.c               |   5 +-
>  mm/swapfile.c                 |   3 +-
>  mm/userfaultfd.c              |   2 +-
>  24 files changed, 511 insertions(+), 353 deletions(-)
> 
> --
> 2.51.0

