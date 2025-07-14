Return-Path: <linux-s390+bounces-11544-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A634B03CAB
	for <lists+linux-s390@lfdr.de>; Mon, 14 Jul 2025 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BB84A47C4
	for <lists+linux-s390@lfdr.de>; Mon, 14 Jul 2025 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BEC248F73;
	Mon, 14 Jul 2025 10:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prFSARqR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="prFSARqR"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A57248F5C
	for <linux-s390@vger.kernel.org>; Mon, 14 Jul 2025 10:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752490403; cv=none; b=g35ZqLI0lPnBocK+3c5mSyizM8fLHQ/tf76utRh40ZbjzW/XsAnsIrKPna7GiHNl+L662Z4FCvQUPlM6aZ/uQZuEEDkBqTDDAuLKFRCNkj53y282LKrvSvBVi5UU/1h4VvBpuyyngtgcEY3FD+RUmOH9UaKJzHmS8Zd99AW2FrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752490403; c=relaxed/simple;
	bh=HZe+PSFIqtSRG5XYWpqVB5BT6I6rETa16PlVd1/YRCw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxszdKJlQLgpX/Z47yMkw1dhIQJ4dRvd1i4kt6G/5QPD16KbyGr4KJihiIbGscZe7yv/b9oSuXvSoQ+ypzbrunzSAFvy7QbmJYggeBm2AyJy9nfB6J2TWmbu2SHsj/gGz1pQR0a3w+NCWPWzI8TXJjEoVI3UevAKFO5K2jBnWpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prFSARqR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=prFSARqR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7595211D7;
	Mon, 14 Jul 2025 10:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752490398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZe+PSFIqtSRG5XYWpqVB5BT6I6rETa16PlVd1/YRCw=;
	b=prFSARqReeyfjPoQVKpWsWnQUiRWMjeNelanE+EdFi69FPDX9MiWu197NuuvIL0f+RrmK+
	+rUyAuH+8ua/rAH/8H1DdVKR4LYIcELijvdrzUhHhJOnDoSfl4srnSCRwePZAa9ewAb4Uf
	SzA12gZfA2INeorJVrPa9l2MC2BJ0Gg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752490398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HZe+PSFIqtSRG5XYWpqVB5BT6I6rETa16PlVd1/YRCw=;
	b=prFSARqReeyfjPoQVKpWsWnQUiRWMjeNelanE+EdFi69FPDX9MiWu197NuuvIL0f+RrmK+
	+rUyAuH+8ua/rAH/8H1DdVKR4LYIcELijvdrzUhHhJOnDoSfl4srnSCRwePZAa9ewAb4Uf
	SzA12gZfA2INeorJVrPa9l2MC2BJ0Gg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 380E013A60;
	Mon, 14 Jul 2025 10:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B03aC57hdGhGWwAAD6G6ig
	(envelope-from <mwilck@suse.com>); Mon, 14 Jul 2025 10:53:18 +0000
Message-ID: <deb1ee37ebfde54f8a6258b2492a6d5898419a6e.camel@suse.com>
Subject: Re: [PATCH] multipath-tools: fix default blacklist of s390 devices
From: Martin Wilck <mwilck@suse.com>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Stefan Haberland <sth@linux.ibm.com>, Nigel Hislop
 <hislop_nigel@emc.com>,  Matthias Rudolph
 <Matthias.Rudolph@hitachivantara.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik	 <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Hannes
 Reinecke <hare@suse.de>,  Benjamin Marzinski	 <bmarzins@redhat.com>,
 Christophe Varoqui <christophe.varoqui@opensvc.com>,  S390-ML
 <linux-s390@vger.kernel.org>, DM-DEVEL-ML <dm-devel@lists.linux.dev>
Date: Mon, 14 Jul 2025 12:53:17 +0200
In-Reply-To: <20250712201454.215404-1-xose.vazquez@gmail.com>
References: <20250712201454.215404-1-xose.vazquez@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.de:email,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Sat, 2025-07-12 at 22:14 +0200, Xose Vazquez Perez wrote:
> Each blacklist only their own devices.
>=20
> Cc: Stefan Haberland <sth@linux.ibm.com>
> Cc: Nigel Hislop <hislop_nigel@emc.com>
> Cc: Matthias Rudolph <Matthias.Rudolph@hitachivantara.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Martin Wilck <mwilck@suse.com>
> Cc: Benjamin Marzinski <bmarzins@redhat.com>
> Cc: Christophe Varoqui <christophe.varoqui@opensvc.com>
> Cc: S390-ML <linux-s390@vger.kernel.org>
> Cc: DM-DEVEL-ML <dm-devel@lists.linux.dev>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
> ---
> DASD devices been blacklisted twice, since:
> https://github.com/opensvc/multipath-tools/commit/a6ff4f957c78bd15c49278a=
d359671a705eaf4b5
> In the current code:
> https://github.com/opensvc/multipath-tools/blob/de16cf82c5263fc148118be56=
ebf44c8f0ee60b8/libmultipath/blacklist.c#L233
> ---
> =C2=A0libmultipath/hwtable.c | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Martin Wilck <mwilck@suse.com>

