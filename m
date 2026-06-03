Return-Path: <linux-s390+bounces-20457-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LvMKNJR/IGp94QAAu9opvQ
	(envelope-from <linux-s390+bounces-20457-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:25:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F44F63AD49
	for <lists+linux-s390@lfdr.de>; Wed, 03 Jun 2026 21:25:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=TV6Hs6aO;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="Z XoN9O7";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20457-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20457-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C23E3053FEB
	for <lists+linux-s390@lfdr.de>; Wed,  3 Jun 2026 19:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A441348BD43;
	Wed,  3 Jun 2026 19:24:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8148B373;
	Wed,  3 Jun 2026 19:24:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514666; cv=none; b=fOCBiYK3AGAZ/C7+RqvqBg7tAm2DNf7MAYMRawaydUUUk7ZFMrMzTyNDnkTP/o7QNbGrIBYnVSXuuBfc3BxoBi6MAZeSnjlyxTGuq1RjRGC8otwP23XB4JN26YFR69vjLSzzcXAI6RbsTLf5+b/2kbWs9rmKhhetXbebPMwDnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514666; c=relaxed/simple;
	bh=2c+mIhiF0BF1iEG8YF1CwO2l7bbG/E9FKbOISdl0o6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0PgfREVNqI2YLAtfH/VY92FSpqCGHhGLeaKjV22qnL3gFIoMiu2QkBwh4Rr5sqs0W44+ms9gWwBh3SVnDJEA0gtaR8NbRldJGRFoqHp1u7s/FIuRYzzZOssNNkbFOVKVd9BO0OljYfTR+5lEU6ZErhC7sl3bTYFmqO384z99w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=TV6Hs6aO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZXoN9O7J; arc=none smtp.client-ip=202.12.124.148
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 77AF11D000EE;
	Wed,  3 Jun 2026 15:24:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 03 Jun 2026 15:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780514658;
	 x=1780601058; bh=SMG9G4OqJ5Osq9kAINMvdjXo5kiIV2/lOU5H8n3lh6Q=; b=
	TV6Hs6aO9MJK5k+nFRYIB5Ot8Ef0y93l/hu8vL4iSRlLtbQhslDoTnRcFSeYMMR+
	ee8E7s2UiUa7ea35RRL3qvHspQRhzOz8PL33SSoItizOgCDF0RSG26HxDJayqWTF
	DEJC+ZIJSQMErK+lmuT21tgQfeJHCyPxjs/4lfb19Ecjt2q+AgQMFXzRNYjBTXBH
	GmVPeMRXNiVgx9tb7kIrysJhTorqDcTcp5uyowQAkMyn07/9bET/D4X5gqa+4uiY
	vLA+tLlRl0X9lr/HEVDJWUY47lqajmJP9wEStacYUIA4XK3YZJjHCWlf433E4ngc
	uluaXTZqM9w8vCqrSBR5OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780514658; x=
	1780601058; bh=SMG9G4OqJ5Osq9kAINMvdjXo5kiIV2/lOU5H8n3lh6Q=; b=Z
	XoN9O7JfOz8w1eDNNkux11mpJ6Ul3WF2wZ0+mAl6vDM0eugMxPVt7Gh2/xcvF1Xs
	m3slusTRwbMwYQl9MG+17MKdxanzng6UIFa6wnrTBea3/xPprOycNonyOPn0ts45
	Ue4lm+1nOim6Y6xQosMRvxcN6NYNTGrxHn1LD2dl+3siQq1me9wJbTwucGRJjUvW
	ugCdzBhJ4ne9zq3yiwphwJxNEMCjKZ4lTORclKSFjm3a50JfWuO9t8+BvqQg8k9I
	FntHZT2oBDOGNIWHhdmzdNj/QPCc1yQGFIWsEsiaU0/LH0rA/eqkA4aNTD6uDuzD
	hbzwSPaXOAZbHdxmhC/iw==
X-ME-Sender: <xms:Yn8gaqLLWS-NbJdPYdIN206j5LGiMHQsp38QXv2s6zc6wiwQXq2ppQ>
    <xme:Yn8gajjXoW20lpy94esPBZ3GGY5rBE80TENBMcxyDbvqZ3mCCYkGVK649Xitiibln
    gCiKMQQ5wEnYCjEx6pSJw6CoGn3UBpHDI7_0-MQhyn98HwvjzWMsA>
X-ME-Received: <xmr:Yn8gaj-ym6g9BotnbJ0TOlREXMutfxPBoISz-O9siTglKNdv6uH2oxynXhA>
X-ME-Proxy-Cause: dmFkZTGotx2FL0pmZGBC7KWjxWg1WpUSD6gaxYQINCpdPFmdjHf6OhV/ccBD0X6I0KybaF
    BdN9rGjFeVyRnz2S0S0Zbz4NvOfH1b/LmYQWfc54XFLVZUHPfnhy4j2/dSFXFapJ5/gsgP
    MY+GzWaGPF73JTsAKKFIXbNESVyNsb8YmIX3eO2SyRwz5htGI6Jt2luewRWQrzdZO/o93k
    h5IvWme7q3be3mYd6MZxn+XbzxmE26utAx8fkeoS0S4XMb+90XX++O04hAH+QfoLYQWiUj
    BeGj6qpkIKBDAUj7wwvCRHagJmpQDjetX48utRkJCAIdKbuoaJYiFEQVWWxTzDM60ge9Ru
    rFev/lF1c5AtewGSJ0r1QOXrMxBT5Gai4XFiTsHl9A5qJTZzVsVSjneuuFM8pKxXrmJeX2
    VoMEcmDSfvRr4SdwUxCkVm/YWHnFTPAIhE28apRftDLsjzhmhvvYgVlluzVpWEV8eLaxDb
    L3T/a3p/kCXCrr5dbCgEkgUuKVOrdtJn8aWrW2Jx6h0cBvftNtvX5mW7sI5Zixo5/dD6zF
    z7wBjgbuk/FjQRWJtDpxghwGPztnRj8gg2FhqCKY01Vo6dieX01eoJMiyroom8d5DEmMej
    +enW/SomPcobyJg8Qq4ioL4aj5yK/PwgwdkRwdz2Ie1GqHesCMzS5PqT8D6Q
X-ME-Proxy: <xmx:Yn8gano1eqQfCgdjVW5l8n3JA7gMK_TIVqrLwCFLkmg9JaQ2mt6HaQ>
    <xmx:Yn8gaoNqMgK_d6exS8eNwM_X2IeUPbV7UKvDwZxBFztot7YW9x2Ylg>
    <xmx:Yn8gal5p0Borr60R1A7nZipQoO_cfSMibQa3_DnxN5NV8MDinuAYNw>
    <xmx:Yn8gakWj_gGL6-NnLhz2IEIp2w8YkHH4ncXxD7fYxO-Zo2zyNL-JPg>
    <xmx:Yn8gahrDcsF0yliN3vjui0ciTC-z5FY0ra92OEJ4pQslqoozUr7jwP63>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 15:24:16 -0400 (EDT)
Date: Wed, 3 Jun 2026 13:24:15 -0600
From: Alex Williamson <alex@shazbot.org>
To: Omar Elghoul <oelghoul@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
 farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v2 2/3] vfio-pci/zdev: Add VFIO FMB device feature
Message-ID: <20260603132415.53e9a934@shazbot.org>
In-Reply-To: <cc2cb880-2d53-419f-a813-539ce0f5311b@linux.ibm.com>
References: <20260519224204.19154-1-oelghoul@linux.ibm.com>
	<20260519224204.19154-3-oelghoul@linux.ibm.com>
	<20260602162409.1ca3c765@shazbot.org>
	<395b0d85-3057-4bd5-b8cc-10ceea2d978a@linux.ibm.com>
	<20260603095538.65b07206@shazbot.org>
	<cc2cb880-2d53-419f-a813-539ce0f5311b@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20457-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:oelghoul@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,m:borntraeger@linux.ibm.com,m:svens@linux.ibm.com,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:alifm@linux.ibm.com,m:farman@linux.ibm.com,m:gbayer@linux.ibm.com,m:alex@shazbot.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,messagingengine.com:dkim,shazbot.org:mid,shazbot.org:from_mime,shazbot.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F44F63AD49

On Wed, 3 Jun 2026 14:26:30 -0400
Omar Elghoul <oelghoul@linux.ibm.com> wrote:

> On 6/3/26 11:55 AM, Alex Williamson wrote:
> > On Wed, 3 Jun 2026 08:35:43 -0400
> > Omar Elghoul <oelghoul@linux.ibm.com> wrote:
> >   
> >> On 6/2/26 6:24 PM, Alex Williamson wrote:  
> >>>
> >>> Why does the user need to be able to control these?  
> >> We want the user (e.g. QEMU) to be able to control these so that when a
> >> guest enables or disables the FMB, this state gets cascaded to the host and
> >> all the way to the firmware.  
> >>>
> >>> Doesn't allowing the user to disable FMB remove guaranteed host-based
> >>> monitoring?  
> >> Yes it does, but this one isn't an oversight and is intentional behavior
> >> to achieve the functionality mentioned above. The host-based monitoring is
> >> not necessarily guaranteed and is treated as a device-specific state, so it
> >> makes sense in the case of passthrough to have that state reflect the state
> >> of the guest that is actually using the device.  
> > 
> > If we really need a SET for enable/disable, I think it should be a
> > separate feature.  It really makes no sense to pass a giant structure
> > into a SET operation to look at the state of one flag bit.
> > 
> > [...]
> > 
> > Hmm, I also see fmb_length in VFIO_DEVICE_INFO_CAP_ZPCI_BASE.  If we
> > have that, do we really need structured data in the GET feature?  Maybe
> > GET just provides a user pointer and the raw fmb data is copied to it.  
> 
> If we did this and passed just flags, a user ptr, and possibly a buffer
> length field, what would you think of leaving them in one feature? This
> way, the SET case would have possibly 8 or 16 bytes of overhead rather
> than the entire FMB structs, but would still keep the uAPI simple enough
> by avoiding multiple VFIO features for the same firmware feature.

It doesn't seem the GET needs either flags or buffer length.  The data
is opaque through vfio, so there's nothing to flag.  The buffer size is
at best a sanity check, it has no actual bearing on the copy to user
buffer.  We're not writing to a variable length ioctl buffer, we're
writing out to the user pointer.  The feature only needs to be
consistent that it copies no more than fmb_length.

The combined SET/GET that perform different actions especially stands
out because of the structure, but I don't think making the structure
size more manageable resolves that they do very different things.  I
think the implementation is also much easier if GET simply dumps the
FMB to the user pointer and SET takes only a scalar enable/disable
value, ie. a fundamental type that's handled as a bool.  Thanks,

Alex

