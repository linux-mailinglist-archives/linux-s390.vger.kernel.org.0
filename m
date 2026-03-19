Return-Path: <linux-s390+bounces-17700-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAr/KNAovGkxtgIAu9opvQ
	(envelope-from <linux-s390+bounces-17700-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 17:48:16 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 102882CF141
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 17:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B91732AE024
	for <lists+linux-s390@lfdr.de>; Thu, 19 Mar 2026 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBE3EF0CC;
	Thu, 19 Mar 2026 16:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL2p7D4n"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748E73ED5C6;
	Thu, 19 Mar 2026 16:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938057; cv=none; b=EGLKykmaI9Z4BTdhfsQtb1WWbYJmmLNX0CGFhwOsLEv4mR6liiL/WUyWvO34pDEx+ILEvSfqLBXvWjifFbImYgKf7B5tpE1WQGZ1ibzhzgRSh0gDs/VHYAWWmrHRh5tHpkPUK3dnvIqsRvkhtKyQ/D4QgaFCXQn6T540ek4H4Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938057; c=relaxed/simple;
	bh=We2az9rV2uZhEm2AbxZxzNYfpPMKfj/UCTlthMox8c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaVoK2Hoa7o5W/gCJV0GvXVgP0qcIxTPQD0XNeckkr5q/sbY+4gWCSPm/WY5mjybec2ZZykXBe28rOOpQPfk8CTeP84EkmFECXEB+EnDEV1BTW/gkNTpWp1rmun22/irO0teXO3jk9Bp2gF2k5I+TRfu/ckiT58chM3tCkdLD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL2p7D4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6525C19424;
	Thu, 19 Mar 2026 16:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938057;
	bh=We2az9rV2uZhEm2AbxZxzNYfpPMKfj/UCTlthMox8c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AL2p7D4nNNuwVwc7Lph39O0JFakdkYyaKrzGaPHTF2GlW3nDaBEjsMovt8IMS1cvj
	 nF/Y3zcnq4HLceLlcb6ZNa8uwOSPS9SWkhVjLMbig3i7KtVn/sUAbfmVPQesBc+smm
	 1em/bPnI5cwFnbtL9+1T0wOIIFyaOYswLb8TV3Jrtgd9OpVCyzRy0/2cXUKGL7tmOg
	 p/vGe+nw48VyFu5vUn7QxEbTeLZzSpoqZVdkf5aZk90hZ1WePMNrOHlWOcl6wQkke1
	 ZJTW5adr2V3cuwzpxHwFD5YXGP9Xk9BnMlUdpEnaAU+qap2KVjtghs04ibjGQEjgmW
	 /TmfbXYeRDlPg==
Date: Thu, 19 Mar 2026 16:34:04 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, 
	linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] mm: remove CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE
Message-ID: <8ebdbdba-d0b5-4887-98e5-bc45f4565d51@lucifer.local>
References: <20260319-config_migration-v1-0-42270124966f@kernel.org>
 <20260319-config_migration-v1-1-42270124966f@kernel.org>
 <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abwVK8nLpSLVcT5G@gourry-fedora-PF4VCD3F>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17700-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,arm.com,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,linux-foundation.org,oracle.com,google.com,suse.com,nvidia.com,intel.com,sk.com,linux.alibaba.com,linutronix.de,goodmis.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org,kvack.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lucifer.local:mid,gourry.net:email]
X-Rspamd-Queue-Id: 102882CF141
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 11:24:27AM -0400, Gregory Price wrote:
> On Thu, Mar 19, 2026 at 09:19:40AM +0100, David Hildenbrand (Arm) wrote:
> > All architectures that select CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE also
> > select CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG. So we can just remove
> > CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE.
> >
> > For CONFIG_MIGRATION, make it depend on CONFIG_MEMORY_HOTREMOVE instead,
> > and make CONFIG_MEMORY_HOTREMOVE select CONFIG_MIGRATION (just like
> > CONFIG_CMA and CONFIG_COMPACTION already do).
> >
> > We'll clean up CONFIG_MIGRATION next.
> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>
> HOTREMOVE has long been a thorn in my side, I appreciate you cleaning
> this up.

That is quite the HOTTAKE young Gregory!

(It seems my pun crimes are continuing)

>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
> ~Gregory

Cheers, Lorenzo

