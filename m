Return-Path: <linux-s390+bounces-18374-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ2aD94WzGnfOAYAu9opvQ
	(envelope-from <linux-s390+bounces-18374-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 20:47:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8DC3702F0
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE65D3030122
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 18:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1201390232;
	Tue, 31 Mar 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCuxgfhk"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6038F92D;
	Tue, 31 Mar 2026 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774982857; cv=none; b=AS7r2PV5IfaZWhGVOZ71uKyjkWbUkJ09bjXdYiW8n6nzBPf6VDIWygfcotmddHmHr5xlRAFTZk1LqoDt0XCM/bQ99zSdeHM6JTy9YwXFuIOBHEeD695KOkldtETuIk0nYM7g+KSODrzjSyzknfoX9wzMJrgPdk0EitHA4RqFmY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774982857; c=relaxed/simple;
	bh=CUmvYJ+q9fr0CWu9PeM2hiD4yICAuMHbTJnAtOumyIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jW40qwX7ruYJLoxuAQxfz8CP6WtytgNdSKHXEAUt7ZAIOLT/P30+NP7gGQ6yetPvHo8Jlvp1gjLw0JW5p5NmlKCFSba+tTplavKNfNEsD+7jQyRFujKe/UWOgTxoq0ajY8h0QFhWwImqsvHEie1VyTYkUlUbHCk8ybBjq6FdsXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCuxgfhk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779CC19423;
	Tue, 31 Mar 2026 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774982857;
	bh=CUmvYJ+q9fr0CWu9PeM2hiD4yICAuMHbTJnAtOumyIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCuxgfhkhW2T2Q50p+f5sEFLu1o0vSZtLrAfwaZoDPLQotj+9CrNSTDt99ktgypf0
	 MqMjS1oLLVheBrOv/aoB/sQc9tYjtIjC/ON9njXZ8nlquEQUpcy2R2Dzu3FqVm9JRJ
	 737vuu2fWRDxzXosqSJOW5RbqspgpR3kk6iFFWJbqzbyiGMOEl6NrLLshNFasROsd4
	 IM20vPN1u5cNPCMCE1aKuMkErL4MqR9RU85mu2IOedMimZ6HxcwaaMDeifSkR2Ht24
	 990T0kFs1K2Gzus8kty9SgWt4RW2zATT8xfXIbGYhsrGnfOjyG2IoPG52Z5DLh85h0
	 r0nRshjuR/m8w==
Date: Tue, 31 Mar 2026 19:47:30 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
 <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18374-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,infradead.org,kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,oracle.com,redhat.com,arm.com,linux.dev,suse.cz,suse.com,suse.de,linux.ibm.com,ellerman.id.au,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC8DC3702F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > Instead? That is, assuming we really need to care about this at all.
> > >
> > > But I think I don't like this change at all?
> >
> > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > vote confirming my scepticism I'll go ahead and remove the parts I
> > added to avoid extra vma_start_write_killable() call (3 instances in
> > all) and will post v7.
>
> Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> v7.
>

Ack, if we just drop the problematic bits we might still be fine for 7.1 :)

Cheers, Lorenzo

