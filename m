Return-Path: <linux-s390+bounces-19556-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMm6CCHoAmpEyQEAu9opvQ
	(envelope-from <linux-s390+bounces-19556-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 10:43:13 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6B151CE03
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 10:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FC3A30BD4DD
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 08:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E922481679;
	Tue, 12 May 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDcpM7HE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9nMywJlr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XDcpM7HE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9nMywJlr"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CA2D979C
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575053; cv=none; b=n+cYuX9lYRRzjllMgWXnHxzETgpp938kqbI+NUNRUEFaHSZRs1Yk8rHuufJzGMO/bAz76281onREa7krUpCF489cqHPYU7Bun3yNNMU1ezeGnYzslV+WSSgJ6PfRfz62+5Zd+h8CEWz0vS7GQchGFI6OyGiG5CnUhNNlkgkY+uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575053; c=relaxed/simple;
	bh=74qM6PKIz0tnWK+vIrUBuOZuv8r7hJwfCLMNGU3acSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xa5uOCLu+SLwBGmFPqAD3O+ZiBshjiv608w5emfUsOf0XiyJOk9z1bEnk0HIDkhFeZ1GK/FvYNuT2K5CP4JDF0Eb7th/7cnh4siSq4fGVGRpd2TiTlq7l34cuG7v8Ga34rhDyAruPP4AoFT1EYCjNAlbN9N0pZHFhgk0uBIFevI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDcpM7HE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9nMywJlr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XDcpM7HE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9nMywJlr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1907A6BF57;
	Tue, 12 May 2026 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7Q6p7r7/PTCrwEUB3BqNV/hhNykM2WI5rGmdNMnE/M=;
	b=XDcpM7HE5T4YXQ8cU48rhnlq0031pTSR7lGt01xe7saIgyqP7q5NwgRWiPHf3ly+ynh0Cp
	EZoWgGFSUcyC91HlWChdyHpptKV6LkzEWJ/PLw65aRJuw6ydfzUw6Kmo7ugyC8/Dic1iRy
	Sg1qkIy8Or5cXMgS62vHomBmwb6OCqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7Q6p7r7/PTCrwEUB3BqNV/hhNykM2WI5rGmdNMnE/M=;
	b=9nMywJlr4PLXO8Wk+lLz+Kzebosqxs5kPLFv9AgywrldbKhOX8RyZbBI7VnrvIEdsRJ8xd
	Mcv8zGLYQKT+HDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778575050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7Q6p7r7/PTCrwEUB3BqNV/hhNykM2WI5rGmdNMnE/M=;
	b=XDcpM7HE5T4YXQ8cU48rhnlq0031pTSR7lGt01xe7saIgyqP7q5NwgRWiPHf3ly+ynh0Cp
	EZoWgGFSUcyC91HlWChdyHpptKV6LkzEWJ/PLw65aRJuw6ydfzUw6Kmo7ugyC8/Dic1iRy
	Sg1qkIy8Or5cXMgS62vHomBmwb6OCqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778575050;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j7Q6p7r7/PTCrwEUB3BqNV/hhNykM2WI5rGmdNMnE/M=;
	b=9nMywJlr4PLXO8Wk+lLz+Kzebosqxs5kPLFv9AgywrldbKhOX8RyZbBI7VnrvIEdsRJ8xd
	Mcv8zGLYQKT+HDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4920593A9;
	Tue, 12 May 2026 08:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rFANcjmAmrjBAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 12 May 2026 08:37:28 +0000
Date: Tue, 12 May 2026 10:37:19 +0200
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
Subject: Re: [PATCH 6/8] mm/bootmem_info: stop marking mem_section_usage as
 MIX_SECTION_INFO
Message-ID: <agLmv6kAorUNC37g@localhost.localdomain>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bootmem_info_prep-v1-6-3fb0be6fc688@kernel.org>
X-Spam-Flag: NO
X-Spam-Score: -8.30
X-Spam-Level: 
X-Rspamd-Queue-Id: 6D6B151CE03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19556-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,gaisler.com,kernel.org,linux-foundation.org,linux.ibm.com,ellerman.id.au,gmail.com,infradead.org,google.com,suse.com,vger.kernel.org,kvack.org,lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[osalvador@suse.de,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 04:05:34PM +0200, David Hildenbrand (Arm) wrote:
> We never free the ms->usage data for boot memory sections (see
> section_deactivate()). And to identify whether ms->usage was allocated
> from memblock, we simply identify it by looking at PG_reserved.
> 
> Consequently, there is no need to mark ms->usage as MIX_SECTION_INFO.
> Let's just stop doing that.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

