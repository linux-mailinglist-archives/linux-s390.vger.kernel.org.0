Return-Path: <linux-s390+bounces-21119-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lSCSLiubOWpEvgcAu9opvQ
	(envelope-from <linux-s390+bounces-21119-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 22:29:31 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FA96B2442
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 22:29:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="XtRc8//A";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21119-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-21119-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 955EF3017CB7
	for <lists+linux-s390@lfdr.de>; Mon, 22 Jun 2026 20:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC734EF0D;
	Mon, 22 Jun 2026 20:29:24 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D2A34DB56;
	Mon, 22 Jun 2026 20:29:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782160164; cv=none; b=B1flbg22miuvStwies+9ehHdwSGENyfWpbKpN6cO20JHNBjXZnetF6hT3UQF3M3Ws1QoCEeED361PKR41kh4STOM9+NmFIn1MCf+F8SDsOd05wdFbZL/0u6t53DV6r+Uxu2QLV7lcYMGSHQFrovmEtR+jAZL+9+c+1GaLzLZaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782160164; c=relaxed/simple;
	bh=1UpYt39gL2CGu8eQhJRGQeqNuGREyFn8XumI7Buz0Ts=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=esbU3ra/+ZpxcO74Pc+H6WvVe/baV3JelIfve5aVlpcy/e42EgvJ0rYTWmYLKVDw35z8T6f+Lzn/24aNHIR/6ruW+H2eZcB72CEL2xX4MPsLwQ9293TVtrzJvKMEbEMGo+ZKnW5P0k22vrb158gROq8XKouyQmQvTRftSXDc5sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtRc8//A; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C871F000E9;
	Mon, 22 Jun 2026 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782160163;
	bh=jGxREV0cO/b8wbT25QdJ9vSRQVB6ERQhzC73UEzuFoQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=XtRc8//ADuSYsmjuowJwwg5bmg0a4Ybrmnd1KL6xiWKQxUvbr7rHWTkzmNbeHGeYJ
	 bIv+74lJZA9GXkblaV7+zVPwuoz6jrAfC8+BCVDD2utIr+68GGayYfBqyEDKREuNcb
	 x+g6XNDqor6av+pta67fktSmRae1AKrYe4wemD0qt9TXlChNOCRFXYu4RsE9dpgkzA
	 W879jA2ZcuNvCYgD9XRvAamNjD/qxFeMN880f3zD4TPB3YueiXDL4vs+XOoktPjKvv
	 CO1gOXzbx5HlSxZsrG590Sahdvev4FrzsMhXkRmPrNemUyX/Y/damEkpmErALObyqv
	 jF5eBKOb0TMzA==
From: Thomas Gleixner <tglx@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
 schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: Re: [PATCH v20 4/4] PCI/MSI: Enable memory decoding before
 restoring MSI-X messages
In-Reply-To: <20260622171840.1618-5-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
 <20260622171840.1618-5-alifm@linux.ibm.com>
Date: Mon, 22 Jun 2026 22:29:20 +0200
Message-ID: <87ik7al3of.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21119-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:alex@shazbot.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fw13:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 90FA96B2442

On Mon, Jun 22 2026 at 10:18, Farhan Ali wrote:
> The current MSI-X restoration path assumes the Command register Memory bit
> is enabled when writing MSI-X messages. But its possible the last saved and
> restored state of device may not have the Memory bit enabled, even if a
> device driver later enables Memory bit and MSI-X. Attempting to access
> Memory space without Memory bit enabled can lead to Unsupported Request
> (UR) from the device. Fix this by enabling Memory bit and restore
> it afterwards.
>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> ---
>  drivers/pci/msi/msi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 81d24a270a79..46a0d9f68a57 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -874,6 +874,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
>  	bool write_msg;
> +	u16 cmd;
>  
>  	if (!dev->msix_enabled)
>  		return;
> @@ -882,6 +883,8 @@ void __pci_restore_msix_state(struct pci_dev *dev)
>  	pci_intx_for_msi(dev, 0);
>  	pci_msix_clear_and_set_ctrl(dev, 0,
>  				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
> +	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> +	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);

Can we please have a comment there which explains this? Three month down
the road this will results in head scratching otherwise.

I agree with Niklas that this wants a Fixes and a Cc:stable tag.

Other than that:

Reviewed-by: Thomas Gleixner <tglx@kernel.org>

Thanks,

        tglx



