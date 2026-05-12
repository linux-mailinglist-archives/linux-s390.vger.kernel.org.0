Return-Path: <linux-s390+bounces-19586-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AZvFmgdA2pD0gEAu9opvQ
	(envelope-from <linux-s390+bounces-19586-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 14:30:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD435520248
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 14:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD4AD301C8BD
	for <lists+linux-s390@lfdr.de>; Tue, 12 May 2026 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7410037206F;
	Tue, 12 May 2026 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7z+LwFD"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A073672A6;
	Tue, 12 May 2026 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588680; cv=none; b=iele5BlwkRWbpfhcTVJF2qSUFD6Q0iiC3FUPEmB251I3IGENE/o2+oaqlLQqX08sSwKWZZAWPrNzhhQk1+9jl5mY+M0P0dLjjI43dhE3kdMfXsYOLbozl1ciGhFGTTKPhens/0Br/ADhLwfWdtwU0rN2wBzgvNk3m75MHLu1JFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588680; c=relaxed/simple;
	bh=0WjgXT8uGEuv2OmAhZFIdCShmadqOYqNR6SLU3pqcUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+2zecY6KrBlaG41+V3gBj9DA09CQvonzBAvtHrioUahfh5DTbCUcqZ1RysDNMn6Y+g1osfbh/6dXxeNZu2J/O7gGd548m7+EyN2u42T9aGhUH6RibGLbcP3sSNudcSBtedIzHBlNGVnG6MIPz8JteykAuZkmQ2O3/4LMktVTqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7z+LwFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F89FC2BCB0;
	Tue, 12 May 2026 12:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588678;
	bh=0WjgXT8uGEuv2OmAhZFIdCShmadqOYqNR6SLU3pqcUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g7z+LwFD9uRctO+XZBIgnYJ1JJ1TTPeLlWf5Hc10oJb98KOnqA+Zp4d0LyZSi9YOO
	 U2Qi8Un2g4DRRRl93DQ2kIH8Tmf/j37D9ZNSxIIuIS1OFyYmN5Qa7FQgR0/K6/aGLD
	 eVpYga7N1it0KN/yvBYTY4lmwzjVg2AExltyCati9nb5BVDJyb+LvnBMySxEUJ3T+q
	 fUF1QLdqr1J4jqqL7IFpqmuCkIqopzqK7DVb36DMqmVeYxSAnZJIHjdJFPSbcTiP6A
	 Wh/szX5KLC+7Qu2kGogmtOOpyLqgYKooKW/qiEbz5iLBemBj1LCGOanRlXBpnOPKil
	 ZOifu5xNaODQg==
Date: Tue, 12 May 2026 15:24:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org,
	driver-core@lists.linux.dev, Oscar Salvador <osalvador@suse.de>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Danilo Krummrich <dakr@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Donet Tom <donettom@linux.ibm.com>, muchun.song@linux.dev
Subject: Re: [PATCH v2] drivers/base/memory: make memory block get/put
 explicit
Message-ID: <agMb-fIGsOnUKxL6@kernel.org>
References: <20260512072635.3969576-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512072635.3969576-1-songmuchun@bytedance.com>
X-Rspamd-Queue-Id: AD435520248
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,linuxfoundation.org,kvack.org,lists.linux.dev,suse.de,infradead.org,google.com,suse.com,vger.kernel.org,lists.ozlabs.org,linux.ibm.com,ellerman.id.au,gmail.com,chromium.org,linux.dev];
	TAGGED_FROM(0.00)[bounces-19586-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,bytedance.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 03:26:35PM +0800, Muchun Song wrote:
> Rename the memory block lookup helper to make the acquired reference
> explicit, add memory_block_put() to wrap put_device(), remove
> find_memory_block(), and use memory_block_get() as the single block-id
> based lookup interface.
> 
> This makes it clearer to callers that a successful lookup holds a
> reference that must be dropped, reducing the chance of forgetting the
> matching put and leaking the memory block device reference.
> 
> Link: https://lore.kernel.org/linux-mm/7887915D-E598-42B3-9AFE-BFFBACE8DE2D@linux.dev/#t
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Tested-by: Donet Tom <donettom@linux.ibm.com>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> Changes in v2:
> - mention the removal of find_memory_block() in the commit message
> - drop the redundant extern from the memory_block_get() declaration
> ---
>  .../platforms/pseries/hotplug-memory.c        | 14 ++-----
>  drivers/base/memory.c                         | 38 +++++++------------
>  drivers/base/node.c                           |  4 +-
>  drivers/s390/char/sclp_mem.c                  | 17 ++++-----
>  include/linux/memory.h                        |  7 +++-
>  mm/memory_hotplug.c                           |  5 +--
>  6 files changed, 35 insertions(+), 50 deletions(-)

-- 
Sincerely yours,
Mike.

