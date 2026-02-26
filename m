Return-Path: <linux-s390+bounces-16573-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uILpA4eYoGnhkwQAu9opvQ
	(envelope-from <linux-s390+bounces-16573-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 20:01:27 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A953A1AE1FF
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC62431FBC4F
	for <lists+linux-s390@lfdr.de>; Thu, 26 Feb 2026 18:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17ADA3B52FB;
	Thu, 26 Feb 2026 18:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i179VGxt"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E887735A380;
	Thu, 26 Feb 2026 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772131190; cv=none; b=NRIx8RtdzT3yt5IQ+XX2MGGqdhP3N4T974KCtZxvSWgKLS4ZBPcyZsLjNRmwZtmOqh28yhWQ9SBKJPrdSRsjUdZSUKik4W5moqUD67J3B6gkItLf6gP+DjvgBGtnEx1sL5URMNiMIkgSPO7/B0FsUJgwTJXNg8dPjgTxPKdYx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772131190; c=relaxed/simple;
	bh=yxpixQXF10diQcjpH/CxM0sGAjXPLjm+F5U6ZgVuPD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+EpTLn/4W0CFZhpjNR9BhxPvuZ7hmhBrXgjLIhbtYzUZfVMb5XygDokPY3BXT1QFuFDJ5r3UQwGZJfdU3D+974Zni4YbDjTdnrakYP8G/qcmqX++LA0G0lwTtcxnGgU5o6felUZB2SsObpFeV+FTFvGtSRuq4PqdIa1wplqOgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i179VGxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E211C116C6;
	Thu, 26 Feb 2026 18:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772131189;
	bh=yxpixQXF10diQcjpH/CxM0sGAjXPLjm+F5U6ZgVuPD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i179VGxtntCh/++JV+Uq1SFW+frbUYJiuyc+49jAKSPa8CU8l96SDoAym3jTjb4Do
	 Bv14047eSt7cNmqRGZkCa6DMiaFH95xMeqOq+vAQxZzkgkv1+WoIkn2ENJCFIfRQw/
	 QJR9KmgayNL9k6DRh35kBoNJy671Ud5Mjdu9Obj7kgAu8uYtVGroSDd/pmL+VpTtxd
	 XUr+HRorvJBkAEx9yqh7iF9PDiU+zNdZLulNqRMSEQDlQRPvvcWSU4UtgfMQHvafTk
	 r7C5eTq25jd95eF9usVx28d6c3pAMXbx1d2ErX31Zu5J7JG4MAaMTg3nhYvgHCaw9B
	 tA+dJMYWL+sjg==
Date: Thu, 26 Feb 2026 20:39:45 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Ramesh Errabolu <ramesh@linux.ibm.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v1] PCI: Add write-only 'uevent' sysfs attribute for PCI
 slots
Message-ID: <20260226183945.GL12611@unreal>
References: <20260225150815.81268-1-ramesh@linux.ibm.com>
 <20260226083427.GF12611@unreal>
 <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4d83f50-c3c1-4fdf-bc7c-50a3cc8353b6@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16573-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A953A1AE1FF
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:53:32AM -0600, Ramesh Errabolu wrote:
> 
> On 2/26/2026 2:34 AM, Leon Romanovsky wrote:
> > On Wed, Feb 25, 2026 at 09:08:15AM -0600, Ramesh Errabolu wrote:
> > > Add a new write-only 'uevent' attribute to PCI slot sysfs
> > > entries. This provides a mechanism for userspace to explicitly
> > > synthesize PCI slot uevents when needed.
> > > 
> > > For cold-plugged PCI devices, slots may be created before
> > > udev is ready to receive events, causing the initial 'add'
> > > uevents to be missed. As a result, slot specific udev
> > > rules that define naming, permissions, and related policies,
> > > are not applied at boot. Allowing userspace to resynthesize
> > > the 'add' uevent ensures these rules are processed correctly.
> > This patch sounds like a hack to me. AFAIK, "udevadm trigger"
> > performs exactly that.
> > 
> > Thanks
> 
> AFAIK, PCI slots do not yet raise a uevent. 

Right

> Secondly there is no uevent attribute in slot-id directory to submit requests to raise a uevent. This 
> patch fills that gap

Please start from the beginning and explain what you mean by 'the gap'.
Which scenario failed before and began working after this patch? From your
description, it sounds like the behavior should already be covered by the
'udevadm trigger' command.

I want to note that drivers/pci/slot.c has remained largely unchanged since 2008.

Thanks

