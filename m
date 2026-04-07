Return-Path: <linux-s390+bounces-18601-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI7PDH9h1Wk85gcAu9opvQ
	(envelope-from <linux-s390+bounces-18601-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Apr 2026 21:56:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A33F13B41E3
	for <lists+linux-s390@lfdr.de>; Tue, 07 Apr 2026 21:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E07BF3023330
	for <lists+linux-s390@lfdr.de>; Tue,  7 Apr 2026 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E1525A642;
	Tue,  7 Apr 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FElrXRsz"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C273F126C17;
	Tue,  7 Apr 2026 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775591801; cv=none; b=lE3AmZBJMljbzL9tnteFs0kgrEtkOsdJ1NAyG81a0Xqs7fSajj7KL2XIY31wZJPtTPale+rcnUJbO4SB2YMHM3oLhntvb2mZhqxdszqX73UDwizCjhcPycqXl/dfj3Wwx7xTL4zOr4tZHtNdy43gWJKR45e2sklvEO2Y+iGuLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775591801; c=relaxed/simple;
	bh=DtWNZr4Jo5RuxN7LV0LKAmjia2Fz63RniapcsPaf7+c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W6ulqIRXCCPLgS60qVyGd9/r+L2FXJHfNOOJz+du1LpywEe7FmtxbTDOgQk6SZJwYicjiR2B37MzBFRMSYYPcEcnJNGQDPow+TyRWagpgro6T8os4SRyt1XbW0g0dhU4ErO8ybLfQYtK+OYxDN/chRHjX2FewRCdzBlWviNevkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FElrXRsz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8E6C116C6;
	Tue,  7 Apr 2026 19:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775591801;
	bh=DtWNZr4Jo5RuxN7LV0LKAmjia2Fz63RniapcsPaf7+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FElrXRszYrT7tENCRG7igqqsyY2+Fbe5B1NwwyqwrpL7zYPsk94VC6mEE/UXCWFoW
	 AtKYclNDCk1deh1D1FeDyFGBjwmrJgOtEO96BTMHWPOIP1xCya0ioSGmMl/V1o+HAy
	 GYLwqW1g2GJ8ead81zmz2MWGhD5liOP0ITYugFd3ZrtvJM8wwaiYvmOmWVkWefu1y7
	 yTiBbg5Xv3zLJllqKRBwPlZWALJKkDAQ7yuTyC8Gn8oKUoYMUwJKSoOcOorW6KWxHz
	 bdlekN7qQJNKtrudIXrKV5LFpI720JK12el0lTI5HKfTOHpUp+t2Y7btpwBZkL152V
	 iiDrzAJNI7NZw==
Date: Tue, 7 Apr 2026 14:56:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de, alex@shazbot.org,
	clg@redhat.com, kbusch@kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 2/7] PCI: Avoid saving config space state if
 inaccessible
Message-ID: <20260407195640.GA251318@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330174011.1161-3-alifm@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18601-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A33F13B41E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 10:40:06AM -0700, Farhan Ali wrote:
> The current reset process saves the device's config space state before
> reset and restores it afterward. However errors may occur unexpectedly and
> it may then be impossible to save config space because the device may be
> inaccessible (e.g. DPC). This results in saving invalid values that get
> written back to the device during state restoration.
> 
> With a reset we want to recover/restore the device into a functional state.
> So avoid saving the state of the config space when the device config space
> is inaccessible.
> 
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 70162f15a72c..b36263834289 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
>  }
>  EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
>  
> +static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
> +{
> +	u32 val;
> +
> +	/*
> +	 * If device's config space is inaccessible it can return ~0 for
> +	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
> +	 * check Command and Status registers. Note that this is racy
> +	 * because the device may become inaccessible partway through
> +	 * next access.
> +	 */
> +	pci_read_config_dword(dev, PCI_COMMAND, &val);
> +	if (PCI_POSSIBLE_ERROR(val)) {
> +		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
> +				msg);
> +		return false;

I wonder if it's feasible to do the pci_save_state() into a temporary
buffer, check the buffer for PCI_POSSIBLE_ERROR(), and copy the temp
buffer into the real buffer if we think the save was successful.  I
know this is a lot more work, but I would like to avoid the raciness
if possible.

> +	}
> +
> +	return true;
> +}
> +
>  /**
>   * pci_find_parent_resource - return resource region of parent bus of given
>   *			      region
> @@ -5029,6 +5050,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  	 */
>  	pci_set_power_state(dev, PCI_D0);
>  
> +	if (!pci_dev_config_accessible(dev, "save state"))
> +		return;
> +
>  	pci_save_state(dev);
>  	/*
>  	 * Disable the device by clearing the Command register, except for
> -- 
> 2.43.0
> 

