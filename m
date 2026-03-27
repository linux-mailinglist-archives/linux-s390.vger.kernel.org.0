Return-Path: <linux-s390+bounces-18266-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOKLGk/Bxmm8OQUAu9opvQ
	(envelope-from <linux-s390+bounces-18266-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 18:41:35 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C77BE34885F
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 18:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03C0530BCB43
	for <lists+linux-s390@lfdr.de>; Fri, 27 Mar 2026 17:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7521E3FA5D7;
	Fri, 27 Mar 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltMB+8JM"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A8012B93;
	Fri, 27 Mar 2026 17:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633024; cv=none; b=D3KvorKpOqXgFG9vjAwWfra6f3VsvBTT79ye22PQqNyr9G3VA2UeaC2Xm+bZiEDNjPXilpL5MWwz6ZFyK45vIAvfjdS3MAwgkrejOLA94JoR9Rfqu7bK0gwteH8qlTVh85R8YuSadO1naLM1cT7Zm9fBnmdcPZqja6WFvfV7fuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633024; c=relaxed/simple;
	bh=qjbVszfk5H0B4FMQ+oBG1kCyJ2Mm1XRJcJft2Can3OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5QA6MangFnfYJ/f1PkiqfsMuR31hUc4mRnZMr5G395LCWuFS7qIRyMBx1zZ3/fUNfBqt+678t+tVCCQB68oN3/r9+FLVGyz7txK/h9sbqfL0aV9bEN4lB1HEJjyBZumZcSfHS9BFJQgTqzd3ql/BdoHl28UwaBoatgt/Zjpvas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltMB+8JM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5743DC19424;
	Fri, 27 Mar 2026 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774633023;
	bh=qjbVszfk5H0B4FMQ+oBG1kCyJ2Mm1XRJcJft2Can3OE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltMB+8JMKlPEXIY+iIffEuXUD808lFlKdG9/t8DDuX0N0gSKM2YjihjUaPimovERF
	 nONpobPbdpl1PNuDk7eWBuDiZuCBgL7jiX1dh0NOWE4sxMlAVvIXTrQ9rW57zK9dPr
	 gPFB0fWqjJ6aQujfaZXbKSmqImEHgvcmo5w7aKr794x1Of9QkaASPEInq4ggaixK3F
	 +ITlFC4rXBuG5I83mFhZQcA3KPGihyZQyj6vqfjt+MyFHxzhhFqSK89Z15LiwM6mHF
	 nTrt+qNaLoz/uftVzl17mVVVTodB57d8SFUettkdWl1gRWWGNnkDz+BDwpWKIq+CFU
	 w8w+9j5eLaqqg==
Date: Fri, 27 Mar 2026 17:37:01 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-ID: <df0c2fc2-467a-4ffb-a697-7c89d64bad6b@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
 <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18266-lists,linux-s390=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,kernel.org,nvidia.com,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,oracle.com,redhat.com,arm.com,linux.dev,suse.cz,google.com,suse.com,suse.de,linux.ibm.com,ellerman.id.au,kvack.org,lists.ozlabs.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: C77BE34885F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 10:32:27AM -0700, Suren Baghdasaryan wrote:
> On Fri, Mar 27, 2026 at 10:03 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > Three of your patches lack review tags so now it's 65!
> >
> > Three is now zero, thanks Lorenzo.
>
> I just finished fixups for issues Sashiko flagged. They are pretty
> small but important. Testing them right now and running Sashiko
> locally. Once done I'll post v6 and will ask Lorenzo to re-review
> those specific changes. Sorry Lorenzo, I'll point out the specific
> changes I had to make and will try to make it easy for you.

No worries :)

Could you send to ljs@kernel.org on the respin? Sorry to nag about it but my
email more and more set up for that and makes my life a wee bit easier :>)

> Thanks,
> Suren.

Cheers, Lorenzo

