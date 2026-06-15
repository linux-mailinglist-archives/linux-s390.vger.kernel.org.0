Return-Path: <linux-s390+bounces-20882-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /iu2El5JMGqWQwUAu9opvQ
	(envelope-from <linux-s390+bounces-20882-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:50:06 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E11446894E2
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 20:50:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="E5i1aF/q";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20882-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20882-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5C4F301134B
	for <lists+linux-s390@lfdr.de>; Mon, 15 Jun 2026 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F423ACF1C;
	Mon, 15 Jun 2026 18:49:59 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3153ACEE6;
	Mon, 15 Jun 2026 18:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549399; cv=none; b=F+G+3GxAGDxDEOIq9XspkLWNug5MPDLu7cZ0H3S0hrvdhJkdU8vGYodXC6hh8PVo8XCPdOS9+0v96nUtFAPbCIqO62ram3i35Tj/KSKYLmtfal7t1JyfyLiOi8M75O7jUerq9SSi1EdkvaUd+P9xpKCl9Ll2a4JPbgE6WYijLxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549399; c=relaxed/simple;
	bh=5xoJHXLQnVPdx1Ms3IqitrRuJ++vsT85wBygoGY1EuA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lL7gO2LCNc8w+I0/kEib02Lz6AQ2rdi8rWyrkJ0KHH8BxVbpR5Hjr+eUNTw+Mq0fC0PlqFBdWEbq+7YyupjdoFZJfCxJyXRsn58+2Et4blsQe3DZ9yb5p3388JfqSV3VvEd1PtlXhqA9XUMa1ABbOOwgpPLcD+lqed/aeh5RreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E5i1aF/q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636641F000E9;
	Mon, 15 Jun 2026 18:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549398;
	bh=IdfMhJBTiBwtonu2cKzH+Z/me0sW67orYePw2OkHeyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E5i1aF/quxszXKVjfITR03c/VhbLZicmM4vRYSC7Vz+wMynn1yl92CmXnHw9kYYU3
	 rVecmI+QRAGjYxBkb6J30MPxr37AtMVAv8xIzGz5yU414+AeV13CQalJPfcsTnkvek
	 WOwSsEDehQFAvanKa0TxPV7lYQdze19xUXPOyD9hOC2sEhsGi5pqImgNBI7+CLdQRt
	 SzL6pWEgsXAdkj4jmqgGG94fyswZPLgJ0vamsyizXicXOatXMEEkyfxeMrUlcpp13d
	 nI3b4TqvZbDohtm9r159bSuVMVwUWoyczrJ4tNWSmqY2Rzfi3XtFn3cc9tGubf6Drb
	 RyucDVVoY7w/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 2/3] vfio-pci/zdev: Add a device feature for error
 information
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-pci@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260615183616.2902-3-alifm@linux.ibm.com>
References: <20260615183616.2902-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:49:56 +0000
Message-Id: <20260615184957.636641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20882-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:linux-pci@vger.kernel.org,m:hca@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E11446894E2

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The UAPI struct `vfio_device_feature_zpci_err` uses C bitfields,=
 which violates UAPI design principles and breaks cross-architecture/cross-=
compiler compatibility.
--

commit 894c3dcf471b795ab55da889778d75f212c1eee2
Author: Farhan Ali <alifm@linux.ibm.com>

vfio-pci/zdev: Add a device feature for error information

For zPCI devices, platform specific error information is provided by firmwa=
re.
This commit adds a new device feature to expose this error information to
userspace to enable recovery.

> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 5de618a3a5eee..83c93193b22de 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h

[ ... ]

> @@ -1534,6 +1534,36 @@ struct vfio_device_feature_dma_buf {
>   */
>  #define VFIO_DEVICE_FEATURE_MIG_PRECOPY_INFOv2  12
> =20
> +/**
> + * VFIO_DEVICE_FEATURE_ZPCI_ERROR feature provides PCI error information=
 to
> + * userspace for vfio-pci devices on s390. On s390, PCI error recovery
> + * involves platform firmware and notification to operating systems is d=
one
> + * by architecture specific mechanism. Exposing this information to
> + * userspace allows it to take appropriate actions to handle an
> + * error on the device. The ioctl returns -ENOMSG if there are no pending
> + * PCI errors.
> + */
> +
> +struct vfio_device_feature_zpci_err {
> +	__u32 feature_flags;		/* Indicate future features */
> +	__u32 reserved1;
> +	__u32 fh;			/* function handle */
> +	__u32 fid;			/* function id */
> +	__u64 faddr;                    /* failing address */
> +	__u32 ett		:  4;	/* expected table type */
> +	__u32 mvn		: 12;	/* MSI vector number */
> +	__u32 dmaas		:  8;	/* DMA address space */
> +	__u32 reserved2		:  6;
> +	__u32 q			:  1;	/* event qualifier */
> +	__u32 rw		:  1;	/* read/write */

[Severity: Medium]
Does this UAPI struct violate kernel UAPI design principles by using C
bitfields?

The C standard does not specify the memory layout of bitfields, leaving it
entirely up to the compiler and target endianness. Placing bitfields direct=
ly in
a globally exposed UAPI header could mean that generic userspace tools or
hypervisors compiled with different compilers or on architectures with diff=
erent
endianness might map these fields to the wrong bits when interpreting the
struct.

Could these be replaced with a standard __u32 variable alongside explicit
#define bitmasks and shifts?

> +	__u32 reserved3;
> +	__u16 reserved4;
> +	__u16 pec;			/* PCI event code */
> +	__u8 reserved5[28];		/* Allow for future expansion */
> +};
> +
> +#define VFIO_DEVICE_FEATURE_ZPCI_ERROR 13
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183616.2902=
-1-alifm@linux.ibm.com?part=3D2

