Return-Path: <linux-s390+bounces-1684-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B5284FF86
	for <lists+linux-s390@lfdr.de>; Fri,  9 Feb 2024 23:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71751B2421A
	for <lists+linux-s390@lfdr.de>; Fri,  9 Feb 2024 22:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDB28370;
	Fri,  9 Feb 2024 22:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SHOzVEDj"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD067210E7
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 22:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707516924; cv=none; b=bHWeL2mS/JKyqeqkciVT1H92yNyJRbNuoenP/gw9chB/P6L8SMkq28DmLP/QzMxygRim/Fo9xCWcE3juV3MtSnNn+M9Vf1SZbLaMMgtiNrFNQ8zyV1jTEN54Lr5N25dRk755eJLJ/+mfGOsFhuRXAkwEfcPL/v+sFg7ascnhW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707516924; c=relaxed/simple;
	bh=3aVfhg/C+wAo1wz9GZnGBRw740WrndMiu2OG5sNBjh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwmpJRNatax6yYOMJkL9zHMF/izctHTgMeaHvvtx1bt91TrlbDL8o2pu5Hei149X8KhaoCrSvfxWUNazoatlm/4/2HZCgUCFkUxsq2UzvRaqCGpVZePzyqEe7psj5ttM2Htie4iT13vu8gdBCfvV3YctPqkejbfKUC1wVE+0KUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SHOzVEDj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707516920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IHB7ZolLgofmfMRsfkbwn2QUSh6DVNhQllqTULKzUgI=;
	b=SHOzVEDjQ+4Y+h8yhuzoLSfLENz4pib2VDKT4VQx9+4blO+JsYWvJvYfd78LaRL6067XyE
	xnaANZNrhUGNrXjJY0c9LoyZ/rFzHp1GIaIDfnkxqIEZi/x1AFdfWQSl9CYnilyeRX37r4
	4t3QwsbDGibNwI7KOivSrP0l5siw8LQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-_SIakAvhN7i8GkgZgtC1Hw-1; Fri, 09 Feb 2024 17:15:17 -0500
X-MC-Unique: _SIakAvhN7i8GkgZgtC1Hw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3532785A589;
	Fri,  9 Feb 2024 22:15:16 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CE8F71C14B04;
	Fri,  9 Feb 2024 22:15:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Subject: [PATCH v2 00/10] mm/memory: optimize unmap/zap with PTE-mapped THP
Date: Fri,  9 Feb 2024 23:14:59 +0100
Message-ID: <20240209221509.585251-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

This series is based on [1]. Similar to what we did with fork(), let's
implement PTE batching during unmap/zap when processing PTE-mapped THPs.

We collect consecutive PTEs that map consecutive pages of the same large
folio, making sure that the other PTE bits are compatible, and (a) adjust
the refcount only once per batch, (b) call rmap handling functions only
once per batch, (c) perform batch PTE setting/updates and (d) perform TLB
entry removal once per batch.

Ryan was previously working on this in the context of cont-pte for
arm64, int latest iteration [2] with a focus on arm6 with cont-pte only.
This series implements the optimization for all architectures, independent
of such PTE bits, teaches MMU gather/TLB code to be fully aware of such
large-folio-pages batches as well, and amkes use of our new rmap batching
function when removing the rmap.

To achieve that, we have to enlighten MMU gather / page freeing code
(i.e., everything that consumes encoded_page) to process unmapping
of consecutive pages that all belong to the same large folio. I'm being
very careful to not degrade order-0 performance, and it looks like I
managed to achieve that.

While this series should -- similar to [1] -- be beneficial for adding
cont-pte support on arm64[2], it's one of the requirements for maintaining
a total mapcount[3] for large folios with minimal added overhead and
further changes[4] that build up on top of the total mapcount.

Independent of all that, this series results in a speedup during munmap()
and similar unmapping (process teardown, MADV_DONTNEED on larger ranges)
with PTE-mapped THP, which is the default with THPs that are smaller than
a PMD (for example, 16KiB to 1024KiB mTHPs for anonymous memory[5]).

On an Intel Xeon Silver 4210R CPU, munmap'ing a 1GiB VMA backed by
PTE-mapped folios of the same size (stddev < 1%) results in the following
runtimes for munmap() in seconds (shorter is better):

Folio Size | mm-unstable |      New | Change
---------------------------------------------
      4KiB |    0.058110 | 0.057715 |   - 1%
     16KiB |    0.044198 | 0.035469 |   -20%
     32KiB |    0.034216 | 0.023522 |   -31%
     64KiB |    0.029207 | 0.018434 |   -37%
    128KiB |    0.026579 | 0.014026 |   -47%
    256KiB |    0.025130 | 0.011756 |   -53%
    512KiB |    0.024292 | 0.010703 |   -56%
   1024KiB |    0.023812 | 0.010294 |   -57%
   2048KiB |    0.023785 | 0.009910 |   -58%

CCing especially s390x folks, because they have a tlb freeing hooks that
needs adjustment. Only tested on x86-64 for now, will have to do some more
stress testing. Compile-tested on most other architectures. The PPC
change is negleglible and makes my cross-compiler happy.

[1] https://lkml.kernel.org/r/20240129124649.189745-1-david@redhat.com
[2] https://lkml.kernel.org/r/20231218105100.172635-1-ryan.roberts@arm.com
[3] https://lkml.kernel.org/r/20230809083256.699513-1-david@redhat.com
[4] https://lkml.kernel.org/r/20231124132626.235350-1-david@redhat.com
[5] https://lkml.kernel.org/r/20231207161211.2374093-1-ryan.roberts@arm.com

---

The performance numbers are from v1. I did a quick benchmark run of v2
and nothing significantly changed -- because nothing in the code
significantly changed. Sending this out ASAP, so Ryan can make progress
with cont-pte.

v1 -> v2:
* "mm/memory: factor out zapping of present pte into zap_present_pte()"
 -> Initialize "struct folio *folio" to NULL
* "mm/memory: handle !page case in zap_present_pte() separately"
 -> Extend description regarding arch_check_zapped_pte()
* "mm/mmu_gather: add __tlb_remove_folio_pages()"
 -> ENCODED_PAGE_BIT_NR_PAGES_NEXT
 -> Extend patch description regarding "batching more"
* "mm/mmu_gather: improve cond_resched() handling with large folios and
   expensive page freeing"
 -> Handle the (so far) theoretical case of possible soft lockups when
    we zero/poison memory when freeing pages. Try to keep old behavior in
    that corner case to be safe.
* "mm/memory: optimize unmap/zap with PTE-mapped THP"
 -> Clarify description of new ptep clearing functions regarding "present
    PTEs"
 -> Extend patch description regarding relaxed mapcount sanity checks
 -> Improve zap_present_ptes() description
* Pick up RB's

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org

David Hildenbrand (10):
  mm/memory: factor out zapping of present pte into zap_present_pte()
  mm/memory: handle !page case in zap_present_pte() separately
  mm/memory: further separate anon and pagecache folio handling in
    zap_present_pte()
  mm/memory: factor out zapping folio pte into zap_present_folio_pte()
  mm/mmu_gather: pass "delay_rmap" instead of encoded page to
    __tlb_remove_page_size()
  mm/mmu_gather: define ENCODED_PAGE_FLAG_DELAY_RMAP
  mm/mmu_gather: add tlb_remove_tlb_entries()
  mm/mmu_gather: add __tlb_remove_folio_pages()
  mm/mmu_gather: improve cond_resched() handling with large folios and
    expensive page freeing
  mm/memory: optimize unmap/zap with PTE-mapped THP

 arch/powerpc/include/asm/tlb.h |   2 +
 arch/s390/include/asm/tlb.h    |  30 ++++--
 include/asm-generic/tlb.h      |  40 ++++++--
 include/linux/mm_types.h       |  37 ++++++--
 include/linux/pgtable.h        |  70 ++++++++++++++
 mm/memory.c                    | 169 +++++++++++++++++++++++----------
 mm/mmu_gather.c                | 107 ++++++++++++++++++---
 mm/swap.c                      |  12 ++-
 mm/swap_state.c                |  15 ++-
 9 files changed, 393 insertions(+), 89 deletions(-)


base-commit: d7f43604944787ce929efeaabd0f462414002a8f
-- 
2.43.0


