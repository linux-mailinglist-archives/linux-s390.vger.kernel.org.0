Return-Path: <linux-s390+bounces-22287-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6Rq2FyxUVmri3QAAu9opvQ
	(envelope-from <linux-s390+bounces-22287-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:22:20 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DF7756607
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 17:22:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=KPPAUCP4;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22287-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-22287-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D84E3043774
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 15:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2024963CE;
	Tue, 14 Jul 2026 15:16:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2C249552B
	for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 15:16:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784042184; cv=none; b=UVJPK/uajftyigp1OpFpyKuzILjYKkEoA8iPiGFm4fCcWdZUgWVlQYdQKnHsxNXbw2xSaGff0mms2+XuAxLzZPLOkHDNJYKENjFIs1thNX2VueJj84nsOEEnhhm/s0RLY530xQUTD96XVpUuGJQIZyTXY+Kg82+PgVXfqfQ+IfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784042184; c=relaxed/simple;
	bh=b+EJlyZCjRd+zn9R4Sh1X4jRP+azN9ASK6QXE0fMCOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKCVQhWkCc962xZdAqDXWnrT9h4lVeduQAgDOH07mRlkpjE7AcwPCrAg29PPdHTeCrMRIXjAPTHgl90DUJ3LSeuOtDi5tNVXk404Jvo6Vw1AJvnpASP9D6pEUbJoUN5E30DzhtK+6lo6dcJMlYTFe8J2YCcqKfl3vKo1nuYKqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPPAUCP4; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1170043a91.0
        for <linux-s390@vger.kernel.org>; Tue, 14 Jul 2026 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042182; x=1784646982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=KPPAUCP4LIdjO5XJ0zjy2zAJBq10fBFDDwlJY9GTpiAxYnLIYddoRSL3J3DqiV2P6y
         +ku+Y5iejEVZh74yQXu/qXHGwYG5tW7DUPanHDeomUKhLvdQ9xVYaRVbrSddbLJOI0ad
         Qa3CN2PzZmtaETC8zO5yZkKtPICmsqoVsAjJTpPBDiVw91s3T/y1PMupM2jzbtWqABLc
         vuMkMEHNPjyjGBPp96D51ljj1HiXb5xNpmWEkTe5pRWRrWkxeNs3m/dCydtAoDLnHP6C
         yMrnw4pGDOFin2LSg/EILdO6tpkQIxtwxT8Aq/YMZplq4BBxszdXGzHEbNOqUuiMfQt6
         xyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042182; x=1784646982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=XGpmLUHdbvC3FWLg0TVQvmBG+1bW+IwhED/yhITm9Hm4XHtLAXNGKk6nbu9iYnVwxF
         iPBWVRhEVF+LsXJZv4oPxBbBIt+x8+Cix7aL/Ut5DFwa7jQ/4Q4enKu0oQZWZh90ArDD
         /jmMuBj1ZvZVf+0EvlSsZUd7GDoyKW4IcgrSMfqWtQL2QI/fq2Oo3RctToG0s4NGZClJ
         oCilzY4xdsVMb9GRv/RAyM6SR/M23bADrfZRYYLKD87gNor8ME99NRKZ9ThxA37IR3y5
         Y0vCr3hLARkaj2CwVcrp77aShhw1k56tH2jtV2w7RWKR1YWdPaaBA3MLE6Vd5bXinqqx
         D05g==
X-Forwarded-Encrypted: i=1; AHgh+RohUcYJ9toSjBpU9nC5FX9PjRhgea2sQwBTMH3dtenluVxj2Ufh+XC5wJvfHz4pOT1XAcX1xW41ZhSB@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHiwnlNosBlyZuUMUCYyy5AAyb5kS5m/b04kFianIPIZsipQN
	idM//d1PdcyOkO5xLP2zKSYbLO03JAsUB3Am58aFXnMLiF4mnvhGmRw/
X-Gm-Gg: AfdE7cltP0tmwTg+QREZceeFJQ9C3TCBu4140sdBnCWxV/OpkhaX76HV5mwN4beQjSM
	ZUNA7SS/7nYlhcfNkAbDXRoUD7Ph6buCJiHHI+RD7nOKdvP2Fsag4tE8ulpAXXmKj84c1hoeciI
	bu6QUIHvZk/svvgTSBm17LesP1lvMEwULHfwqf7jD/cLFuc2QAEqmEYfAeWqyqez7LLCB8oZ94J
	O7lGnFLLDaTQORBDpRjIZpOcEBf7IG5lJyGLiMiRg3XCrXOHTy04eaoU3NUJ7/eteVx6nugw7Ff
	Sfky1n1B1rxUQX7t1pKfFOSNp0lWn2zPRqwXCVW/HZ042E1Lk0J8tBtqtkbBhRGQMKUZa1nqQcZ
	VzSKgFr9pa5ESC62UsXD/+TVNZDvQVhpsJpcNMp9Ih6kuv0boBfl9Wy61+7uFQ2d7CgNVzX4RJg
	d4Pm87hQe5DrlOdwuGtHl9IztTIyyt63Afo1GFByqRlo0R
X-Received: by 2002:a17:90b:2e8f:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-38dc7b3f8ccmr13234040a91.24.1784042181685;
        Tue, 14 Jul 2026 08:16:21 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm49794403eec.7.2026.07.14.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:16:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:16:16 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ning Sun <ning.sun@intel.com>, x86@kernel.org,
	tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Message-ID: <alZSwAM4pwmMOeaD@fedora>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,infradead.org,google.com,suse.com,soleen.com,armlinux.org.uk,arm.com,lists.infradead.org,lists.linux.dev,hansenpartnership.com,gmx.de,vger.kernel.org,linux.ibm.com,ellerman.id.au,lists.ozlabs.org,dabbelt.com,eecs.berkeley.edu,davemloft.net,gaisler.com,nod.at,cambridgegreys.com,sipsolutions.net,redhat.com,alien8.de,linux.intel.com,zytor.com,intel.com,lists.sourceforge.net,linaro.org,nvidia.com];
	TAGGED_FROM(0.00)[bounces-22287-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[vishalmoola@gmail.com,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kevin.brodsky@arm.com,m:linux-mm@kvack.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:pasha.tatashin@soleen.com,m:linux@armlinux.org.uk,m:catalin.marinas@arm.com,m:will@kernel.org,m:ryan.roberts@arm.com,m:linux-arm-kernel@lists.infradead.org,m:chenhuacai@kernel.org,m:loongarch@lists.linux.dev,m:James.Bottomley@hansenpartnership.com,m:deller@gmx.de,m:linux-parisc@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:linuxppc-dev@lists.ozlabs.org,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:linux-riscv@lists.infradead.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:linux-s390@vger.kernel.org,m:davem@davemloft.net,m:andreas@gaisler.com,m:sparclinux@vger.kernel.org,m:richard@nod.at,m:anton.ivanov@cambridgegreys.com,m:johannes@sipsolutions.net,m:linux-um@lists.infr
 adead.org,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:hpa@zytor.com,m:luto@kernel.org,m:peterz@infradead.org,m:ning.sun@intel.com,m:x86@kernel.org,m:tboot-devel@lists.sourceforge.net,m:ardb@kernel.org,m:ilias.apalodimas@linaro.org,m:linux-efi@vger.kernel.org,m:apopple@nvidia.com,m:willy@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-arch@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishalmoola@gmail.com,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[57];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,fedora:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2DF7756607

On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
> As a step towards removing pagetable ctor/dtor calls for kernel
> mm's, move the page type updates from the ctor/dtor to
> pagetable_{alloc,free}.

Thanks for doing this patchset.

We should switch over from __folio_set_pgtable() to __SetPagePgtable()
in this patch. Ptdescs and folios should be treated as distinctly
independent of each other.

Eventually, we want to replace the memcg accounting as well, but
there's no existing API for that right now. Lets leave that as is for
now; this patchset is big enough already ;)

> __pagetable_ctor() is now empty so remove it;
> pagetable_{pud,p4d,pgd}_ctor() will be removed at a later stage.
> 
> The ctor is normally called after pagetable_alloc() (and dtor before
> pagetable_free()) so this patch should have no functional effect in
> most cases. Where calls to ctor/dtor are currently missing (e.g.
> x86's split_large_page()), this patch will ensure the page type is
> set correctly.
> 
> This patch is based on Matthew's earlier implementation linked
> below, with the difference that when freeing the page type is
> cleared in __pagetable_free(), meaning that the update is delayed
> until the pages are actually freed in the
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE case. This shouldn't matter in
> practice.
> 
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Link: https://lore.kernel.org/r/20251113140448.1814860-4-willy@infradead.org
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  include/linux/mm.h | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 361a0d7b74c5..94f0fb1c662a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3684,6 +3684,7 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>  	if (!page)
>  		return NULL;
>  
> +	__folio_set_pgtable(page_folio(page));
>  	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
>  
>  	return page_ptdesc(page);
> @@ -3694,6 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
>  {
>  	struct page *page = ptdesc_page(pt);
>  
> +	__folio_clear_pgtable(page_folio(page));
>  	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
>  
>  	__free_pages(page, compound_order(page));
> @@ -3799,19 +3801,9 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>  
> -static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> -{
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
> -	__folio_set_pgtable(folio);
> -}
> -
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
>  	ptlock_free(ptdesc);
> -	__folio_clear_pgtable(folio);
>  }
>  
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> @@ -3825,7 +3817,6 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
>  {
>  	if (!mm_is_kernel(mm) && !ptlock_init(ptdesc))
>  		return false;
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3917,7 +3908,6 @@ static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
>  	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
>  		return false;
>  	ptdesc_pmd_pts_init(ptdesc);
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3942,17 +3932,14 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  
>  static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  extern void __init pagecache_init(void);
> 
> -- 
> 2.51.2
> 

