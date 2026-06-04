Return-Path: <linux-s390+bounces-20473-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D06NFiU5IWptBQEAu9opvQ
	(envelope-from <linux-s390+bounces-20473-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 10:36:53 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD5E63E09E
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 10:36:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BQ+THwyO;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20473-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20473-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D36630BD8E7
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 08:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406A23DEACC;
	Thu,  4 Jun 2026 08:28:27 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A3D3DD514;
	Thu,  4 Jun 2026 08:28:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780561707; cv=none; b=KXUoYzk9KB1nf0ul+eIYPj5Af8po2NZ7OgtKA80jVkxs8ITL25ugd0dIDUmCu1MKbMn9rMLXZeO/4D/KfJY1TgjV9I2kTXxphTlB4tVmEVVQCnPVp6aZtu3+kXqNsRm4WDnDtb3L6pfStqA1VNI0+yWzCgxK6uGpV+k6V8JAIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780561707; c=relaxed/simple;
	bh=vUnqqsxv1EBJ+58jWdwqKtnqCiXqa68E72t8d17wGsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBxFd7o4HikXwZpUOfyMi+QN8BM4Qn0HCalSc4SVjsRilWtCGUa07T5RoULIMvMEN2oeoTIKV1Lilsmc3TiGtH/ttsqJ6qtI2oerUZ41VaOQCreCp33uDrAC2bEgXiKf1h0GWzL3iXuz7sgiqzoVVB3/lOb9siEfVefLwMt9rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQ+THwyO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CD41F00893;
	Thu,  4 Jun 2026 08:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780561706;
	bh=3XPIGSkEIdQPrCd3EHkI8/wMO36/Ln2Q0vsOqyP86UI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BQ+THwyO3atWKyuWbkbVjOSxBbCHiYYmqdOam81LAGMWWb5Rdz9SWtzSmnRE0lwqc
	 vAChx67ngQ6INf4WnBfSmxa3nKV0wFfqSWSP1WFsbW+2GV1tYqxt2RdScHlBhiwA6q
	 1YfuPKklaQkVrvA9p0xWBIJEZ/VOeX07wL2vZUltNOJJdgLksK5Illri0f7Fr3gLZP
	 yVnDBXEq26k37lo0yEWjSp4CpylOwlJePB8RlIg+NYlkN05MNUMDa9yQrezfbzS9Wa
	 VdmfWs4MF5SvGmuh+sZsNrbb8Bf/ElOE8qDJupQO0EbUAQ41A2V2vMqfDD/dbP2skQ
	 cmQHwXpU/+lMw==
Date: Thu, 4 Jun 2026 09:28:19 +0100
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, helgaas@kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
Message-ID: <aiE3I0bL0TX1nOec@kbusch-mbp>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603182415.2324-4-alifm@linux.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20473-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kbusch@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:alex@shazbot.org,m:helgaas@kernel.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:julianr@linux.ibm.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kbusch-mbp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAD5E63E09E

On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote:
> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> +{
> +	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
> +
> +	if (!vdev->pci_saved_state)
> +		return;
> +
> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> +	pci_restore_state(pdev);
> +}

Shouldn't there be a cooresponding user space notification that the
device has been restored? There's an eventfd on the error detected side
so user space can know the device needs recovery, but how does it come
to know that the reset is completed?

