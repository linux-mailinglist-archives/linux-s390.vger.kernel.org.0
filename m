Return-Path: <linux-s390+bounces-20464-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XumHJKuvIGq/6gAAu9opvQ
	(envelope-from <linux-s390+bounces-20464-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 00:50:19 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AF863BA93
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 00:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=hexmOFas;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="a q+RYKJ";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20464-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-s390+bounces-20464-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A19C73025719
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 22:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E8C3AFB0C;
	Wed,  3 Jun 2026 22:47:00 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95953A63E3;
	Wed,  3 Jun 2026 22:46:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526820; cv=none; b=Vf9VKOajuGHYSJbpOVeo0pi+oBH4Ko8CT3f0LA19o33JT9Gix9zbZaPB1aLL1H33yo0LA0/LPcLPAufNS3oPOaZTiZ5hLp/uBv7nyx9E5qNYfk/v6DOtT4Z9LfpjdoZ81jn0LJU3xYABxOgkiss04Lo5hN39lzmvRE4bihcM/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526820; c=relaxed/simple;
	bh=/sGv8vqrEIUPJa9DsW4mcTchRLPerXGfVwWW0hz7DaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ojv9jFkZFGHvB8LRaKo0EFoq5bFGzbY2U6swMohTmU9xA9nLR8zwJqwESiuIgNCXGwIM+PEMaoJgRnOBRGHgZ+stxIWgKFdm5Y9R9IJNxdA09HGxN4GR7GKOMaddCpmzr1mbgubIlPQzxvd/yzTb75SVoZC7lJmLTyjszaIyDKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hexmOFas; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aq+RYKJP; arc=none smtp.client-ip=202.12.124.144
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0A8651D0008A;
	Wed,  3 Jun 2026 18:46:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 03 Jun 2026 18:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780526817;
	 x=1780613217; bh=ly6jMDgbX4xN6wPWO17/Ooj7q7iXng0dSBpqivMnvW4=; b=
	hexmOFasjzpCZcCJELdKPaY38LzJzwAioTt+HPPwgvImZF75M+6UgEoGcM8WS8ji
	W2v6b75uv19OufNIur74MdBEETKLvC8UHrpxKIGVwf1fqirNBILmffUNQhuBXGmL
	2KFIb06zRYBjBvaEvDFInP2jRY0xs4Kj4Kn1/fBpbs27HIFr6UkAWPaoLmfyr6D+
	cRtt6NiwyRpLbjVcRLho24x8jqCctAhSfLAeYIxXSGvOy7uFjf3qGRtmKqOIu+c6
	YVt+hp7cFoyOCOdGQSLzJrm0qCO5crez6FO7D9LLux+G6Noy7/z33hpK+hbgOoXw
	plgwJWhuCjIrDCHZh8wB/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780526817; x=
	1780613217; bh=ly6jMDgbX4xN6wPWO17/Ooj7q7iXng0dSBpqivMnvW4=; b=a
	q+RYKJPm9LDAVhLRLlUhEj5xEP+OuZULEaWzHz5R4Ik0LrEYJY87gkZO2QSLoV7a
	xdAYdoWOhv7tLutGuGaKJHAAuFbB0wYdJ1K6nIg9EcnYzm6VM/BziDEF0clSZdar
	+BPgPiBWcEQZe45cL/JBO8/fDyKV5rVXyXTvJ/zBh99+/NjhpdpWuGtQ4MKBCM1y
	k7KeBCF0c2bqAaFjdmRvA34uQKk5dslt2hylXUYrWQ5CTRvOn7LgKWfDe+90O9bS
	Zl2Ka/wX+UsZy2ht8uFgjph9P/L3+Fy/FxVZkCm43qo9V/ID7xuZn47REL1derpI
	RaxQL2kX32KgfFhi0Gkpw==
X-ME-Sender: <xms:4a4gautCxM7o46j6XGg8Xh8lG1vB1V8byW6AQHxpDD2_7Z-669EWMg>
    <xme:4a4garqwxZrKamN377fpoaEu7tBM2aXXeekaJxUEFl76GPz3vRkElCxd0kAMSVKEl
    EjeYgA32fb8rizQuVqTS_dwt5tDfldod1Y836VFGfaIz-i2GDTc_gc>
X-ME-Received: <xmr:4a4galUd5kOtk--0DqaKAR6JA5ACl1v2M9rK_lsfuK3aBcI3W6mNS2jvXmI>
X-ME-Proxy-Cause: dmFkZTFgoydlopjKJjKdl830FpBqqJdCKJDFNUb9+yRv2ZGZk9tc7+jMaAVGne97Tzsh8B
    QipyZfFi1M8xdZyGcq6uXnlybJk5mLxCNPVGsgS49QTznyI1rnQZMXEaWQ0Vy7f0bKrRr7
    ZJTcF8m87L6HkYvZyuUmWNt92Dg+ribrX+if8+cGxzxzk3B3A56W9qe+cAVyMIOduL8AXh
    xZ6uGqEm62a9o6CyG1n9UuX3cQwZMUwx/iOsmJyEiFEKan1d6sVz9H1fc8+AIbyM6o49YV
    6A9b8VUsaAozroq+FvRjt3nIK/B1CPWdqPXaxPylZE5FWKAv7iGLcxDx2nTB2vKsFqxUqn
    DulsgQzOo71s6KzV6nsOy6z+sKN+Y4KdqVMZZRHNYvveVCoP7wzCjyYJG3dOX8e3IqdCpe
    ET+4a1Cs81EPK6yObNawLjAvNt91/VQICQm21PrY6LCdVNB9r0uxSL8Lvc3GHWEFLpvkIV
    k22hWVK940a03NA9GPZBZv+PdqnVqGI1+855ueQOlU/b30tjjs2kZw2VHLeXTRbB6YgO7I
    9h7NuKJRVK/xjI8GA4Zm+rHzi1+sGJ+5hsNOZpr/uW1YySaDJVE3hPo032zwy+zGJEg64r
    z/2CuB8FfudRHvdnv/zn4ceGsHc79nbC8a9V9GMkGgQNxQvsgi6HH0Bnc2aw
X-ME-Proxy: <xmx:4a4gaj1hKcorU8ZrMZnKRhjL5eHiQW4jpE-5OPo69bPrB2NXxiUB_w>
    <xmx:4a4gaqt4hcJDDUhH2clNDMZGvkrYxNgz_v3zdTAkYu7eY3asS6Ry8Q>
    <xmx:4a4garXVxjtcPZh3eP-C9RwzpkN0U_lKokRWv4_qX59t9XM61koRVg>
    <xmx:4a4gaiy3UOAqE5ujiCe1GN76VbFyrTY4ySkptQ1X2Vo_KXdNHQZccg>
    <xmx:4a4ganbhIQTrqzlj0C81HQ7OEjEqi2I4jlDK1mMcnk0Hl6Q2_6cAV64f>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 18:46:56 -0400 (EDT)
Date: Wed, 3 Jun 2026 16:46:55 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, helgaas@kernel.org, schnelle@linux.ibm.com,
 mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>,
 alex@shazbot.org
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Message-ID: <20260603164655.1f533ea5@shazbot.org>
In-Reply-To: <20260603182415.2324-4-alifm@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-4-alifm@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20464-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:julianr@linux.ibm.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,shazbot.org:mid,shazbot.org:dkim,shazbot.org:from_mime,shazbot.org:email,messagingengine.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5AF863BA93

On Wed,  3 Jun 2026 11:24:14 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On error recovery for a PCI device bound to vfio-pci driver, we want to
> recover the state of the device to its last known saved state. The callback
> restores the state of the device to its initial saved state.
> 
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Alex Williamson <alex@shazbot.org>
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Sashiko has some interesting comments:

https://sashiko.dev/#/patchset/20260603182415.2324-4-alifm@linux.ibm.com

I think the critical is a calculated risk we're taking, restoring the
hand-off state after reset.  I don't think we'd considered the race,
and it seems the commit log could use some improvement, especially if
we do need to revisit this based on the calculated risk.  Thanks,

Alex

