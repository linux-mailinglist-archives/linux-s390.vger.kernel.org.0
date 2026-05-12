Return-Path: <linux-s390+bounces-19558-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHF8HvToAmpKygEAu9opvQ
	(envelope-from <linux-s390+bounces-19558-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 10:46:44 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B4651CF0E
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 10:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82B2B308C995
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C24BC023;
	Tue, 12 May 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jyj/SB+C";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uHPvgflS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0T9CA8lU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="A3zfqhPU"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5BC4963C0
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575423; cv=none; b=lVkjomdWTyBJhpbH9vXGTe9WXx8BiZZeSpYWvoR6JxecALQyAFPN7PfqfZtt4W6u5+q/zOSG6uWtSn0NnJWhu9YHtf6IfeWwx+3Z1IXsToBscppPGB+Q/4hQra6tXnZfvC20wOaLHbeIj3DaJAGjzWiPBZpvHXOjHRO9zkIYBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575423; c=relaxed/simple;
	bh=PQdqbUKA3JBbP56Psy2GOvmmBtoadOA+GVwPG2sOEHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkA2a1XChS0sRWdgajWxsfPW6UeNnS+2IeS2GHJmD5igwb8JkzxtZUMpxnVWFqtqhzlYA5863ihddsugYjHJ4gUDNgKNL+5Uxdb69udjtXJYoJ1xIeQkGnfuYWMOc76Iy+feTlPEFet5orxp5MaQx7OwquL3gftuGG0QutpLCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jyj/SB+C; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uHPvgflS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0T9CA8lU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=A3zfqhPU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12BA46C03E;
	Tue, 12 May 2026 08:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=Jyj/SB+Cj0ycIn6iy8AirBgulA6woT7s7jmXHjjxlRIXRCVzsL6L8KCyFx0VmNqINjW+Bd
	fhe2neyAlpOi8KZqoA127vAVVcGFSUGufO3DYQu9FCiXiSgA0rWidbHoptSnYRs4onmu6C
	PN421IzXHTv3Mt9DUQwcjpW2lPi8GJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=uHPvgflSxr1f21qR9SmbrNgQVen1f+3vhIPieRLWMld01iYwwQiqW1lWb5qjTqEV++QpjZ
	P9ahR7tCkwfmtKCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=0T9CA8lUeaTSCvXnCWFLGeD+LEPDue/aNB43knGlbA4F86IRy7dtWguts2d6AfqI2klKZS
	WYm3JaJXzqdRIpHnu38kmGpnJK9452IJ65qb+UasIJRLB1ZPVD33kAJowFuAKhI9cH9tBW
	ufEMI5OiM1Uh6TdRERinXKYvWpRKahk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575407;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=29b8Duc4D+FvzOXVRuZz1VlOr/VXWhIuNt0lSvWwvds=;
	b=A3zfqhPU29cjLTrw7wX35axoGznxQqTbC6ajU+CyBOykK0HUW7zpfn7gd/5crHxz+VlE+f
	//4KXicVjO4LUJBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BC8593A9;
	Tue, 12 May 2026 08:43:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aOwfMi3oAmqfCgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:43:25 +0000
Date: Tue, 12 May 2026 10:43:20 +0200
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 8/8] powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE
Message-ID: <agLoKNAFMGPXFSqC@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-8-3fb0be6fc688@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 06B4651CF0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19558-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@suse.de,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:05:36PM +0200, David Hildenbrand (Arm) wrote:
> register_page_bootmem_info_node() essentially only calls
> register_page_bootmem_memmap(). However, on powerpc that function is a
> nop. So there is not benefit in using CONFIG_HAVE_BOOTMEM_INFO_NODE
> anymore, let's just drop it.
> 
> We can stop including bootmem_info.h.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  arch/powerpc/mm/init_64.c | 8 --------
>  mm/Kconfig                | 2 +-
>  2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
> index b6f3ae03ca9e..64f0df5bb5cd 100644
> --- a/arch/powerpc/mm/init_64.c
> +++ b/arch/powerpc/mm/init_64.c
> @@ -41,7 +41,6 @@
>  #include <linux/libfdt.h>
>  #include <linux/memremap.h>
>  #include <linux/memory.h>
> -#include <linux/bootmem_info.h>
>  
>  #include <asm/pgalloc.h>
>  #include <asm/page.h>
> @@ -388,13 +387,6 @@ void __ref vmemmap_free(unsigned long start, unsigned long end,
>  
>  #endif
>  
> -#ifdef CONFIG_HAVE_BOOTMEM_INFO_NODE
> -void register_page_bootmem_memmap(unsigned long section_nr,
> -				  struct page *start_page, unsigned long size)
> -{
> -}
> -#endif /* CONFIG_HAVE_BOOTMEM_INFO_NODE */
> -
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/mm/Kconfig b/mm/Kconfig
> index e221fa1dc54d..97b079372325 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -537,7 +537,7 @@ endchoice
>  
>  config MEMORY_HOTREMOVE
>  	bool "Allow for memory hot remove"
> -	select HAVE_BOOTMEM_INFO_NODE if (X86_64 || PPC64)
> +	select HAVE_BOOTMEM_INFO_NODE if X86_64
>  	depends on MEMORY_HOTPLUG
>  	select MIGRATION
>  
> 
> -- 
> 2.43.0
> 
> 

-- 
Oscar Salvador
SUSE Labs

