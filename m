Return-Path: <linux-s390+bounces-20531-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jM/eF50gImo9SwEAu9opvQ
	(envelope-from <linux-s390+bounces-20531-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 03:04:29 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E766443C3
	for <lists+linux-s390@lfdr.de>; Fri, 05 Jun 2026 03:04:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FV7UuTIA;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20531-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20531-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C5230374B3
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jun 2026 01:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFCC2F5313;
	Fri,  5 Jun 2026 01:00:16 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A123535E;
	Fri,  5 Jun 2026 00:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621216; cv=none; b=hx28wJbz+r9UBHC6DC33wUSxssvz7UcB7qE266jnUc3DxpAK++5WDHxvvvtvV8tH48TLXhjAtjdiX+reke4gqYQTYLsNUvLsujZOcyAMjaLD7RYr5OSTfkSxC7hFXX9jbGRkdg7ZeuhLK9MrdoHBNO4Rhck/JVxCwr/eRgWeAxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621216; c=relaxed/simple;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYl0UbDhFeNncG6SEth+K4kN9CcCflu0cuhVESpTVRu3Kzrui2SPSbKSxANp9WclIV+n7FT8TVVbQsWxwXoQB/y2A6isoW9nM1E+bJ+vESpE9DH/mcw8C0qZVSN9okUotSv4mKJTqYrB9fz0i3+XHVYuW7lUE7s/zTUqyXf0kSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FV7UuTIA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEDF1F00893;
	Fri,  5 Jun 2026 00:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621197;
	bh=uvxQ8m/0FnjSq2hX2DJ7JY5O6ptuAhKyFcmM0+SqdDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FV7UuTIA9nXYCTQdrZZfkYLPla7MfXoMk9JBQGXD8E6O3JeVZ8noXFwAiRTcGSkiG
	 W1E6UfVYL1zDmwogaVZj3DwZpjueen+dGCzKQo0ke5ZCdkt5y4s6jQvB3vcBr0q2k/
	 5zMUf1gXU4yYCb9VaqZ1FpKBYaxlJRzL8seAwf8I1EV3xbsR5RzcirVhuu+7mcYerp
	 2iHf8scUUAf0UGYnrFlhzWpP25WM1cMsSOLI91OeLkt8yMjFwVNEf8x7lNB0JkDCVX
	 FA7XptQIIQkiVR9RNrq6zyb+w3n9rtX2CXGMXtneI5zgxSgBjxNGwz6mh+H34odnWw
	 kP5OoFOiPLZYg==
Date: Thu, 4 Jun 2026 17:59:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Mahesh J Salgaonkar
 <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, Niklas
 Schnelle <schnelle@linux.ibm.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>, Kevin Tian
 <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini
 <sstabellini@kernel.org>, Oleksandr Tyshchenko
 <oleksandr_tyshchenko@epam.com>, Keith Busch <kbusch@kernel.org>, Alexander
 Duyck <alexanderduyck@fb.com>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604175955.56ca1406@kernel.org>
In-Reply-To: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
	<20260604182031.GB2487554@ziepe.ca>
	<a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dimitri.daskalakis1@gmail.com,m:jgg@ziepe.ca,m:bhelgaas@google.com,m:linux-pci@vger.kernel.org,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:mahesh@linux.ibm.com,m:oohall@gmail.com,m:schnelle@linux.ibm.com,m:gerald.schaefer@linux.ibm.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:alex@shazbot.org,m:kevin.tian@intel.com,m:ankita@nvidia.com,m:leon@kernel.org,m:jgross@suse.com,m:sstabellini@kernel.org,m:oleksandr_tyshchenko@epam.com,m:kbusch@kernel.org,m:alexanderduyck@fb.com,m:daskald@meta.com,m:linuxppc-dev@lists.ozlabs.org,m:linux-s390@vger.kernel.org,m:kvm@vger.kernel.org,m:xen-devel@lists.xenproject.org,m:dimitridaskalakis1@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20531-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-s390@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[ziepe.ca,google.com,vger.kernel.org,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,shazbot.org,intel.com,nvidia.com,suse.com,epam.com,fb.com,meta.com,lists.ozlabs.org,lists.xenproject.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3E766443C3

On Thu, 4 Jun 2026 16:49:05 -0700 Dimitri Daskalakis wrote:
> Hey Jason, thanks for the feedback. We (at Meta) are definitely
> interested in SIOV-like capabilities for device passthrough to containers.

I think "definitely interested" is quite an exaggeration.
More importantly, which big company is interested in what
tech should be irrelevant upstream. Please don't make these
sort of arguments. The code has to stand on its own.

