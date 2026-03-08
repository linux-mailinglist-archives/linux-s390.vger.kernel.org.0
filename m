Return-Path: <linux-s390+bounces-16988-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFBmA+FXrWmd1gEAu9opvQ
	(envelope-from <linux-s390+bounces-16988-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Sun, 08 Mar 2026 12:05:05 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D02D722F63C
	for <lists+linux-s390@lfdr.de>; Sun, 08 Mar 2026 12:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7A5793006084
	for <lists+linux-s390@lfdr.de>; Sun,  8 Mar 2026 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4AA369996;
	Sun,  8 Mar 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QxykAMG6"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80CA368940;
	Sun,  8 Mar 2026 11:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772967897; cv=none; b=MFZq1lNxWnQytaSdvlDme7/sjPxdLh2+vKZwssrsUTWAE1yPvrddO6TtdoPRzLmxr7YQzeoT7HHIDCDvUJ530k1qJNGjrPq+na06Thsxk2IjRyxIMAJIywYsUz2tkznR0eCGvKGUhqzCkjDZ24Y2JJXt23ceiBzHzha7eomM/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772967897; c=relaxed/simple;
	bh=kTWmwkjqAuxbZE1dJfJkIkunYo6hoZH2L1Nl2Atky8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqRZED3mzIa7OYn9A0bm6YBxKeL+/N6pDKQew5u1A2/F5nTSG3NsGsC6Q1+SrdFCvzE9nqAM1s+cl+LAjmxODsKB5u31UnLokH72iB+9tmJU960ikf0+PCzh2KRALUTmFZLauLALGVVlCko/CBMEoZJL1xcBgA66hU4AFUGMFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QxykAMG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0497C116C6;
	Sun,  8 Mar 2026 11:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772967897;
	bh=kTWmwkjqAuxbZE1dJfJkIkunYo6hoZH2L1Nl2Atky8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxykAMG6oEUGhgixi0hOLGjBm1FJMnwS/NiQs0WEjN/4FpgIz5+wlPIcbuH7J+k5e
	 /W4NiVa+echEHKBe2tCOAuUHsxz+mf1MnLpGRWzFu+kF6evFSGPx60F1zA3ZJbdUlm
	 GZ9CMgj/ri2Z1Xlajtt6BA4bSUkoQrpLSEwpBanE=
Date: Sun, 8 Mar 2026 12:04:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers: s390: hmcdrv_dev: remove commented out code
Message-ID: <2026030844-tarantula-train-0b62@gregkh>
References: <20260308103255.757461-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308103255.757461-1-jkoolstra@xs4all.nl>
X-Rspamd-Queue-Id: D02D722F63C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-16988-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.386];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,xs4all.nl:email,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 11:32:51AM +0100, Jori Koolstra wrote:
> The create_class() api is retiring in favor of class_register() (see:
> https://lore.kernel.org/all/2023040244-duffel-pushpin-f738@gregkh/).
> The HMCDRV_DEV_CLASS define is hiding a use of create_class(), but it is
> permanently disabled as it is commented out. To avoid supporting code
> that is disabled, the suggestion is to remove all code hiding be behind
> any #ifdef HMCDRV_DEV_CLASS.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  drivers/s390/char/hmcdrv_dev.c | 114 +--------------------------------
>  1 file changed, 1 insertion(+), 113 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

