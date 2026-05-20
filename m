Return-Path: <linux-s390+bounces-19885-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCRXKpfaDWrE4AUAu9opvQ
	(envelope-from <linux-s390+bounces-19885-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 18:00:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72959161F
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A6F130156CD
	for <lists+linux-s390@lfdr.de>; Wed, 20 May 2026 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1F733F8B1;
	Wed, 20 May 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cyaqbLsB"
X-Original-To: linux-s390@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4125233B97A;
	Wed, 20 May 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292307; cv=none; b=LhC09t2q/xbmMM5aRmE+WLVonsyDxTfGCVqxex0cSrhTlQyLzwEg6/9hzKdwZUa+ZYRcSEwqnUF5e06wKsqiEp3ql0AFtqH/mIPz94ZJQKzSKA+PipIAaMOZzhZ3TGZ9jcMU3aQWnoT+6lz2m+e6KwBXvRikrWAK2+27xyBx7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292307; c=relaxed/simple;
	bh=kOLHBiAE8jzr/6A/jfKB80TncYB/sF5NVut1RV0l83s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcdFgDOeuJJiEqqQTQFgyxp5RutSfm/dBNtVLpk0WUQ61bD7ttxiyJn2DedTo6BW293AddnjaBcZ/kyKFAmUEDZlkCiiClFNzSqEqhmyT6AmZNI9QJe/LXY+ydLsmg6wwXWiykbBxn25z7fCW6LlkDAcBtfiTDoaO79eRIquFPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cyaqbLsB; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nHpPl/F5wMWITSrzVhdG/rFO68ZENNnx6ANAJViJJd4=; b=cyaqbLsBd8TuWcXbuV/p5H62kB
	CPDi3rJN3wZOEF/fhu8hFy+E+oVys1eKQlanPYBPekgaq//TV2sSD7Jchzv2LgBbxXhcOOC0l0Ry8
	9SnhwSFGySALbCrBsjDCC5O2wjGvIOCbRSABlsk+Ib1fGGnL4KqoZorXYfy1GmNhI2cd3LOTuECCv
	lMwE1IdyRtXlXLQtC4JvBPki8Md0j2IcpmpYhZiq6N0e4CJwOuZ7UpBpPFJi8N8bfHdB1HPnxnRv8
	ZZrYqWVRQak1F6Q4qVwFsn3WfAXJpo7BNBy5OhFYXlXJvdw22uerI5O3BWMxUehl76ZANhRMzCIl6
	SgYkrggQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wPjCH-003DHq-0U;
	Wed, 20 May 2026 15:51:01 +0000
Date: Wed, 20 May 2026 08:50:54 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 3/7] atm: convert to getsockopt_iter
Message-ID: <ag3XTX5rXE4tNbsT@gmail.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-3-0d8eed952627@debian.org>
 <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eada2df3-7e3f-46a5-b290-fe0e8975a1bb@redhat.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19885-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com,lists.sourceforge.net,vger.kernel.org,lists.infradead.org,lists.linux.dev,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-s390,nfc];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2E72959161F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Paolo,

On Tue, May 19, 2026 at 04:04:12PM +0200, Paolo Abeni wrote:
> On 5/15/26 10:32 AM, Breno Leitao wrote:
> > @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
> >  }
> >  
> >  int vcc_getsockopt(struct socket *sock, int level, int optname,
> > -		   char __user *optval, int __user *optlen)
> > +		   sockopt_t *opt)
> >  {
> >  	struct atm_vcc *vcc;
> > +	int val;
> 
> I *think* you should use 'unsigned long' here to avoid user-visible
> changes due to put_user() replacement.

I initially used 'unsigned long' in v1, but that proved incorrect and was
flagged by sashiko:

https://lore.kernel.org/all/agXhTGVurhrJmBNu@gmail.com/

The issue is that we need a 4-byte operation here since both __SO_SIZE
and SO_SETCLP are 4 bytes. Using an 8-byte type causes copy_to_iter() to
truncate the copy to 4 bytes while returning 4, which could result in
copying the upper portion of the 8-byte value (potentially all zeros,
depending on endianness).

Thanks for the review,
--breno

