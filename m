Return-Path: <linux-s390+bounces-18631-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMvGDQmJ1mmwFwgAu9opvQ
	(envelope-from <linux-s390+bounces-18631-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 18:57:45 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7453BF31D
	for <lists+linux-s390@lfdr.de>; Wed, 08 Apr 2026 18:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EB373006D77
	for <lists+linux-s390@lfdr.de>; Wed,  8 Apr 2026 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA493B19AB;
	Wed,  8 Apr 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UYnztJT3"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1BF347503;
	Wed,  8 Apr 2026 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667458; cv=none; b=uWTQp91w7hDcAzF+0KbHBYaVSk2nRakMVdRTyDQdfL+h/tvrUpIsZdPDXPAKhYGTvDyE4ONJIucBkkP1yikit2i21abmJI+xzfeZ3HQWEWR+sHxt+EUyNBhWasaIgte2GfK3jjbsOqJ0KW9V5tP/Fzg5mgQakNG8V8n+2i1otjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667458; c=relaxed/simple;
	bh=TSoeUXlgXH8Id4vYAnP139iSG/GBAmuilTv4/38sppw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=AYdfHeSIkzXsJcR6Wh5+mmv8GF1jotmilzcYhk21Fsb7s+bPLSPwXzFqdb2V05dB5SZN+Jo8kbvs0r2tZ1Fq2zB5ZSZ0JU1uxBOGJ8LZKjjKrm1jRlHH+tb8s8dX3J5vZeuqckrZEMnePbv9kPfrwiJk5nEFDoPczxQOqIJNmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UYnztJT3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80797C19421;
	Wed,  8 Apr 2026 16:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775667458;
	bh=TSoeUXlgXH8Id4vYAnP139iSG/GBAmuilTv4/38sppw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UYnztJT3NAozh9+rPNkiS8mTmYvo8ka5gZ2YoPN/WnY+m6Ia5+LMYnf1T+P3gCGmu
	 TqEVVpxNjKmptIUfcq7UNrWI9418oA1E6Y9Qzeuqg+iDPq/rwDO+XiludU9Pd9TyrM
	 YVXW9qG5xLevNcBaghxW9m2SFzpRDPQiIIqxa3O8SDeVzhtv7WalGApblfZdvpiMlT
	 6MXxweyMzDknf6RbrUepI7UbUERl+r3dmjGs/iR5SUVy7myw9KrLMVqtFsKNkw97zg
	 W1S0NB2BJdFxIUTp06ezPb1LZpr9DPNis05mIJ4BqFhKeX9KFX3TVOpIRm/KKE5mGS
	 YQfgU+VT7duCg==
Date: Wed, 8 Apr 2026 11:57:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Jonathan Corbet <corbet@lwn.net>, Lukas Wunner <lukas@wunner.de>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Farhan Ali <alifm@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Ramesh Errabolu <ramesh@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-s390@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v8 0/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Message-ID: <20260408165737.GA295659@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttd6cui@ub.hpns>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18631-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C7453BF31D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 02:18:18PM +0200, Vasily Gorbik wrote:
> On Tue, Apr 07, 2026 at 03:24:44PM +0200, Niklas Schnelle wrote:
> > Add a mechanism for architecture specific attributes on
> > PCI slots in order to add the user-defined ID (UID) as an s390 specific
> > PCI slot attribute. First though improve some issues with the s390 specific
> > documentation of PCI sysfs attributes noticed during development.
> 
> > Niklas Schnelle (2):
> >       docs: s390/pci: Improve and update PCI documentation
> >       PCI: s390: Expose the UID as an arch specific PCI slot attribute
> > 
> >  Documentation/arch/s390/pci.rst | 151 +++++++++++++++++++++++++++-------------
> >  arch/s390/include/asm/pci.h     |   4 ++
> >  arch/s390/pci/pci_sysfs.c       |  20 ++++++
> >  drivers/pci/slot.c              |  13 +++-
> >  4 files changed, 140 insertions(+), 48 deletions(-)
> 
> Bjorn, would you like to take this through the PCI tree? I think Niklas
> phrased the subject with that in mind.
> 
> Otherwise, I can take it through the s390 tree. If so, could you give
> me your Acked-by?

I did ack it, but I guess it was a previous version:

  https://lore.kernel.org/all/20260407193205.GA247806@bhelgaas

It'd be great if you merged it via s390.  The interesting parts are
really in arch/s390.

