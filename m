Return-Path: <linux-s390+bounces-20138-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF6iDrUDGGqdZggAu9opvQ
	(envelope-from <linux-s390+bounces-20138-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 10:58:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F45EF130
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 10:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69965316AB0C
	for <lists+linux-s390@lfdr.de>; Thu, 28 May 2026 08:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2838AC7A;
	Thu, 28 May 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WMt+kwP4"
X-Original-To: linux-s390@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E9367B78;
	Thu, 28 May 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958408; cv=none; b=favUqeLE24Cb8dfYErVa9fcI4b+dIGz0Axti/luMRIwlqITeOlOjZ9Nc/xeY3a7ppJbzH/cV+ynNCot7j4zNS24PGE2riX6FGDEIGerZToZkk51Boac8C25RkeQQeTOZ9wdOGYfVbfMfR3OuQmITwxmuyj/zuQ0FksvcF6yMa3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958408; c=relaxed/simple;
	bh=8fVVgfxlsOq9kNuGYzSy5h/dA7VryhFKl3t6JHkuogU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYjgpJoZP0bHS6TWuhO45jd/LfG2UnK0Oxe85evaD64d8soNcR6TjutInfl4vFZp+I1CuYpJkC/tt9Oy7z8WlbvuQ4Y7oRnlYNH6Tn0EmMJodT2VQ1eHlVBULQfHmZmzs9ftzKN9IsxkUBAAwzhn8rtnxgO0LPg+eNr5jOUAbhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WMt+kwP4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nu+2uJB0bWOahJZM395trqlBX9jrloGHIPyChDFiT4g=; b=WMt+kwP4HyNu4MxGTFi9A9bWL8
	I2vaJGQoRhwDX6g/0qB7yDnua1YQSzPQrViv3x1dOgw/6NIGCo7mJd5eVL0Z+kChl+oL7hNbxm4+q
	QKA+dCZ9jIJ9xP5nt5FvZkhvJH9HWs3Jr+bDnkv0cHQbPzHvs2nDIJK0lueoPxhJip9HsUmtceZJc
	O8Dew8VdViDsT/VjNjWBFVK5IcdIaj7eQwmihQsAd9IU9B4aWaMTdW+Tj7fcuXOZvbyUoWCz7H7rN
	zDBZczW/tM2JZZ4bpnCzeYHzJ21k5778f+4lirKrTNNFKjGkU+vtA+FH4ZWN1nwTpkVLBQply4LiT
	YlfcTbfA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSWUQ-00000005RNi-04pb;
	Thu, 28 May 2026 08:53:18 +0000
Date: Thu, 28 May 2026 01:53:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@infradead.org>,
	"T.J. Mercier" <tjmercier@google.com>, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, mripard@kernel.org,
	sumit.semwal@linaro.org, lkp@intel.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org,
	Dan Williams <djbw@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org
Subject: Re: [PATCH] powerpc: Export set_memory_encrypted and
 set_memory_decrypted
Message-ID: <ahgCfazNTdk7Em-K@infradead.org>
References: <20260522225853.878411-1-tjmercier@google.com>
 <ahPqbfH54R3JJyaV@infradead.org>
 <20260527160716.GN2487554@ziepe.ca>
 <20260527181549.GBahc01Xflm2yo5OqI@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527181549.GBahc01Xflm2yo5OqI@fat_crate.local>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20138-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ziepe.ca,infradead.org,google.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,lists.ozlabs.org,linaro.org,intel.com,vger.kernel.org,lists.linux.dev,kvack.org,amd.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: D83F45EF130
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 11:15:49AM -0700, Borislav Petkov wrote:
> On Wed, May 27, 2026 at 01:07:16PM -0300, Jason Gunthorpe wrote:
> > > Setting memory decrypted is a dangerous operations and should only
> > > be available to core code.  We should have various allocators for
> > > decrypted code, but not export the functionality to random code.
> > 
> > At the very least an EXPORT_SYMBOL_NS.
> > 
> > Looks like there are about 3 modules using it already..
> 
> Looks like more to me...
> 
> In any case, we exported them back then for some framebuffer things:
> 
> 95cf9264d5f3 ("x86, drm, fbdev: Do not specify encrypted memory for video mappings")

Which is exactly one of these things that should not happen - mapping
random I/O memory without the proper helpers..


