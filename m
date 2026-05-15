Return-Path: <linux-s390+bounces-19700-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EyxEG0rB2oLsgIAu9opvQ
	(envelope-from <linux-s390+bounces-19700-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 15 May 2026 16:19:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F4551414
	for <lists+linux-s390@lfdr.de>; Fri, 15 May 2026 16:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47806300DF5B
	for <lists+linux-s390@lfdr.de>; Fri, 15 May 2026 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B007447F2D1;
	Fri, 15 May 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8XzLjTV"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C53847ECFB;
	Fri, 15 May 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778854377; cv=none; b=pKwQM2Xac15lYWYYCNXXHbp7NqZ4aOfRgD8JxQ4JxVjXpEOPe1MlOiEacd9erzqsnySfGEIF6+orcjFep7pTw4ChUezVKYqU+Lmw/kkDHu0eda7nLt0hycO3YK7okAc6wYM9+3Heq3Sk0dthZbYFnsWLXdyIZBCs0uGZDH6JyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778854377; c=relaxed/simple;
	bh=9UNiRIOMItKEXLdbm4ULxBk3vf+YjPTZzQWrvLl0NcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjo0wKDhvLo5F/aSROqP7tRP6vAv63Qtqu7jOadNMT62dFHFmmHIiqSOCXOhSUeeCsZ0T9c3LfVOSQdUNVYPiaOo9cSxiHaPIFq9cdUQcFqV2Jd1IXn3me0HvzjRF7WfcnY54GWI6r9eHaoQsI1iwVks9k89d9sLyfh8FsnWENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8XzLjTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44A0C2BCF6;
	Fri, 15 May 2026 14:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778854377;
	bh=9UNiRIOMItKEXLdbm4ULxBk3vf+YjPTZzQWrvLl0NcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8XzLjTV5ekKX/GeDS/yLSmSwfJaxqT08w/d/U/NL0/fzuBuk2Wdtx00Mc8QRL6US
	 eClFl/yaJm+fwI06gCwoyOVI/91BHC8nvE+sxIBrDyt6+PxHZuLwW+BirBYqn65qtd
	 pp6pN1nMkktbVMSBZ9M+ggziCl7HyNUFYY1zBAzM1XyQTHAocml47qa/q0N+HB4/Zs
	 x+HmCrzPp1DMQCYTgjB1/yU5DQ4TIOKwZopvS/dnZNArU15mzlpsvIHvGUyhrsXXMb
	 cNscvKBY4M9j6Fj7sitMd4VePlGGpB1rf2vZVNbCiNey8UrfKjaJEizyrAL3upyuh+
	 Au2HKI2ZmiFOw==
Date: Fri, 15 May 2026 16:12:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, 
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <20260515-leitung-pyramide-13b63e9b621f@brauner>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
 <afoUt3te1k2TNao-@tiehlicka>
 <afowD31YsGVdVUBP@google.com>
 <agJN2esiIGIhUlMG@google.com>
 <agQeABD0W7wn4pCt@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <agQeABD0W7wn4pCt@tiehlicka>
X-Rspamd-Queue-Id: 9D0F4551414
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19700-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 08:45:20AM +0200, Michal Hocko wrote:
> On Mon 11-05-26 14:44:57, Minchan Kim wrote:
> > Posted v3 - https://lore.kernel.org/linux-mm/20260511214226.937793-1-minchan@kernel.org/
> 
> Is there any reason to fragment the discussion into yet another email
> threat? I believe Christian is still catching up after LSFMMBPF last
> week so give him some time to have a look at this proposal before
> sending yet another version please.

Yeah, thanks. Frankly, it's very hard to follow what's going on in this
patch series. Let me see if I can find the latest posting.

