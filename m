Return-Path: <linux-s390+bounces-20526-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uIVsEqzYIWo8PgEAu9opvQ
	(envelope-from <linux-s390+bounces-20526-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 21:57:32 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0268D6430EA
	for <lists+linux-s390@lfdr.de>; Thu, 04 Jun 2026 21:57:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=shazbot.org header.s=fm3 header.b=XLCSQJqa;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="f s2Coo/";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20526-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-20526-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=shazbot.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60DDF30157AA
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2026 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2103C5838;
	Thu,  4 Jun 2026 19:57:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6EC3C6A5C;
	Thu,  4 Jun 2026 19:57:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780603046; cv=none; b=qnGhIGpuGzQ9fL86l6x8+pA7g1EaSp1mF4ZPCkh06PAL9j0ze8saspjBHQbIlzaEmucleUvDNTxvOag3yaQsnp60fVXB+14EP48DQMRUl/0caIqHGQ7koSGepioIXL8oA1PcNuz35DvFJdiXC+0w8MC0B4SFS0gvMa2g95CSgZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780603046; c=relaxed/simple;
	bh=1MdcKlqthG+hzs8PICe3pYtdd+ZxP43J4uLyODZiNfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNebNLS2VUOJarfxiEH97525MaZrurrB//rgcD+uzcB4p3rcDSzjzVyW7WZxDWBG5cdJusIkx35mhcUy8ktjvqbdBXMx4pacplCGJ5vP+/UOrkx00I89MqJ5dmme6rsfdM2N4j5qAen5+YH/h3jxkCwdeA1DVTAxpGgJWYP4WU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=XLCSQJqa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fs2Coo/I; arc=none smtp.client-ip=103.168.172.152
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBC3D140013A;
	Thu,  4 Jun 2026 15:57:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 04 Jun 2026 15:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1780603041;
	 x=1780689441; bh=3ldYKV+aJOGFJUhEnX3t7Ye52Gtyp0rTgCFtJaRdzSc=; b=
	XLCSQJqa0goCb09vwLmKLy7UTum2rutG/eIrUuLB3/hVXNnoyjo4qAO94qvcjYge
	hA0AUMcU68vsimSwT3exKM5sPrfhzT40wbOMbkUzqP5RcPiu7HPpxnpRXu2ZI9wL
	iOvguQkLOOvP13Jx/8rKeqlTZ+E3I7fZPHmzwxtKos8MOJa60w9+ounpCNazcJBt
	GrDrhad6PMV0a9CPoHFlWFgDkPPdpZ7wu/HEM9ohU7W8kgJnpW8Ryt0h8/pYc2GN
	VXeKypGuY8PvuJJRVibb/vyZc1KLp+urD0VdHszEhoWji6jwRUd5Wn3WmcjkWp8q
	6Gqr/a9FCQt6fBFp0/1YdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780603041; x=
	1780689441; bh=3ldYKV+aJOGFJUhEnX3t7Ye52Gtyp0rTgCFtJaRdzSc=; b=f
	s2Coo/IYtAOjMLZcpa4FeN9kFqPQE90vOLc06icrX8nhcHgfFoDeaNhMJfq/57tB
	C7QgYjvUjszg89rfzj6ssrSnlByT/YUoONTFrwNE5KJjM2bH4H+tgybKX/aDkf0u
	WVfy1X53Hfmujic8Bg4Q74PffwHedPWqOLCvVS64DYL93X93BqFqf1EJAXxhDk2X
	9wk8TVhStP5ORnm7viPVlcWWvPKau7jwcroJ4fA/vgOudqtPZ3hJg/6mxrLJOm+n
	5T16AuBV6uCIQQsvaaHMfE7aaYxik5H9mT57J2ET2d3V73Vp7mOcepMfQ3N8Ue97
	gDRsg58i508X+D3LJlTcw==
X-ME-Sender: <xms:oNghar-S6w106eexkOCiDx4iFU1qKh86X0gCEScCL1VuyTqFW4n5KA>
    <xme:oNghauGTo8-tuAV0RfU_fMGZSHiUiMRyr88jeQifYnKlWQ2k-iWCn55BWAepLdvTd
    CeUsI5mxt5vE4_zSgeWr8rz8vw1FlbQiYtFDiqiCME0KW1VcDbTqAI>
X-ME-Received: <xmr:oNghalQ-3k1eU2IYJFY06WcPJ-Gl4Wm6U9PswL9FWpEP0fOdR3iaO-RFVFI>
X-ME-Proxy-Cause: dmFkZTFtDuF3mNlTIcDf1bkmaiXAeRv34Wiks5LqE8J6ULTQdhFFDbJNuESjEnRMNQ+EqT
    VymHIQ+C/xhhcPXWsry9fBdNmLbdho34Q+StnZZNr3NVvv2xMPBF1iYAY/TQfJ2vdyOArw
    bXDmEuwfOkGP4zcPiv7Ovq4d+YBBXCuVI1mP9F6ohn2uPI+tIHjtRtLqX8SbPbUZy1ZAIW
    4bjv86hHn3FR3N9Yy2+GTs1+so1H6Oey/JNMuprs4WBue+7M0VUcLhLtRCMl+0lqVoYMvP
    IOiI6MgPiEsY7yZ3Q/S2Ns0dmscfQm91YU5y4hS4h0dfQprWIWaQGS7MkUfRbm3OjmRDb7
    pwfHrfSHKAkEjvKEa9XBkqc84C2TOrKw6oKLlANFb5EScVyxmYyCPppKi94vvvw3oYCmv4
    xzGzgCn++eLeHLQvdJBqNgYs4iUOt4u+PHANKBpXztaojrcjTexMUm5CFdsb4J/wsG5EbT
    YCtZhm/Obg7+a1neWgG6DTXuFLbrUAFa4EL7jpAfRg8FubRp8DuKvhOpPhNjcT3jKMMLD7
    /a24P+WVuRT3wB3dS3/WrUsAqfxcukPID+1d4XnKp4PB1PTAG2DXJUtKAaUSZ1Can4ooBz
    UYQB0XIrpt5jjq0/zW8yMb+vEDdVwoGRNs7a1PdBdz6dRX/SxB+EkMogkrMg
X-ME-Proxy: <xmx:oNghalShfYaKj6UJjkJWxc_lyufFCS5egy2n_UAYIcQUPHbsjWV6lA>
    <xmx:odghao0zyUz-RofCut-8KXfx5b9S4VEpuH_jdyhxMRwr26uXHi7veg>
    <xmx:odghavzsoU87Polxoz6AtQyLvRMcf7P_7ZMrOAlEapnJVklcFXlHYA>
    <xmx:odghakwyGt1DIVwq9koRLFTQVneuZ2o2TrglDKhzgJNSbcW6AExdgw>
    <xmx:odghahone3v7Vu-SRpVadWVLBvhckJR9EuOzPXV5_QGLL6mu1OSB_nuv>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:57:19 -0400 (EDT)
Date: Thu, 4 Jun 2026 13:57:17 -0600
From: Alex Williamson <alex@shazbot.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 helgaas@kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com, Julian
 Ruess <julianr@linux.ibm.com>, alex@shazbot.org, Chengwen Feng
 <fengchengwen@huawei.com>
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for
 vfio-pci driver
Message-ID: <20260604135717.5dc69583@shazbot.org>
In-Reply-To: <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
	<20260603182415.2324-4-alifm@linux.ibm.com>
	<aiE3I0bL0TX1nOec@kbusch-mbp>
	<d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[shazbot.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[shazbot.org:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[shazbot.org:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20526-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alifm@linux.ibm.com,m:kbusch@kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:helgaas@kernel.org,m:schnelle@linux.ibm.com,m:mjrosato@linux.ibm.com,m:julianr@linux.ibm.com,m:alex@shazbot.org,m:fengchengwen@huawei.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@shazbot.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0268D6430EA

On Thu, 4 Jun 2026 10:17:04 -0700
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 6/4/2026 1:28 AM, Keith Busch wrote:
> > On Wed, Jun 03, 2026 at 11:24:14AM -0700, Farhan Ali wrote: =20
> >> +static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
> >> +{
> >> +	struct vfio_pci_core_device *vdev =3D dev_get_drvdata(&pdev->dev);
> >> +
> >> +	if (!vdev->pci_saved_state)
> >> +		return;
> >> +
> >> +	pci_load_saved_state(pdev, vdev->pci_saved_state);
> >> +	pci_restore_state(pdev);
> >> +} =20
> > Shouldn't there be a cooresponding user space notification that the
> > device has been restored? There's an eventfd on the error detected side
> > so user space can know the device needs recovery, but how does it come
> > to know that the reset is completed? =20
>=20
> I think if the VFIO_DEVICE_RESET ioctl completes successfully it should=20
> be an indication that the reset has completed? AFAIU the ioctl will=20
> drive a reset via pci_try_reset_function(). If reset completes completes=
=20
> successfully the reset_done() callback is called via pci_dev_restore().=20
> So I don't think we need an eventfd to notify on reset completion.=20
> Otherwise we would have the same problem today, where userspace is=20
> unaware that VFIO_DEVICE_RESET did indeed successfully reset the device,=
=20
> no? Or am I missing something?

I'm starting to feel a little sketchy about this.  I asked claude to
enumerate the state restores and the source of that restored state.
Hopefully this ascii table survives:

  =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=AC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=90
  =E2=94=82           Step           =E2=94=82         Source         =E2=
=94=82 Snapshot-dependent? =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82                          =E2=94=82 EXP cap save buffer    =E2=
=94=82                     =E2=94=82
  =E2=94=82 pci_restore_pcie_state   =E2=94=82 (pci_find_saved_cap,   =E2=
=94=82 YES                 =E2=94=82
  =E2=94=82                          =E2=94=82 cap.data)              =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82                          =E2=94=82 live                   =E2=
=94=82                     =E2=94=82
  =E2=94=82 pci_restore_pasid_state  =E2=94=82 pdev->pasid_enabled +  =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 pasid_features         =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_pri_state    =E2=94=82 live pdev->pri_enabled =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82  + pri_reqs_alloc      =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_ats_state    =E2=94=82 live dev->ats_enabled  =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 + ats_stu              =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_vc_state     =E2=94=82 VC ext-cap save buffer =E2=
=94=82 YES                 =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82                          =E2=94=82 live resource_size()   =E2=
=94=82                     =E2=94=82
  =E2=94=82 pci_restore_rebar_state  =E2=94=82 (re-derived, written   =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 to hw)                 =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_dpc_state    =E2=94=82 DPC ext-cap save       =E2=
=94=82 YES                 =E2=94=82
  =E2=94=82                          =E2=94=82 buffer                 =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_ptm_state    =E2=94=82 PTM ext-cap save       =E2=
=94=82 YES                 =E2=94=82
  =E2=94=82                          =E2=94=82 buffer                 =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82                          =E2=94=82 TPH ext-cap save       =E2=
=94=82                     =E2=94=82
  =E2=94=82 pci_restore_tph_state    =E2=94=82 buffer, gated on live  =E2=
=94=82 YES (gated)         =E2=94=82
  =E2=94=82                          =E2=94=82 tph_enabled            =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_aer_clear_status     =E2=94=82 clears hw status (not  =E2=
=94=82 n/a                 =E2=94=82
  =E2=94=82                          =E2=94=82 a restore)             =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_aer_state    =E2=94=82 ERR ext-cap save       =E2=
=94=82 YES                 =E2=94=82
  =E2=94=82                          =E2=94=82 buffer                 =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82                          =E2=94=82 saved_config_space[16] =E2=
=94=82                     =E2=94=82
  =E2=94=82 pci_restore_config_space =E2=94=82  =E2=80=94 type-0 header    =
   =E2=94=82 YES                 =E2=94=82
  =E2=94=82                          =E2=94=82 (COMMAND, BARs,        =E2=
=94=82                     =E2=94=82
  =E2=94=82                          =E2=94=82 cacheline=E2=80=A6)         =
   =E2=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_pcix_state   =E2=94=82 PCI-X cap save buffer  =E2=
=94=82 YES                 =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_msi_state    =E2=94=82 live msi_desc list +   =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 msi(x)_enabled         =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_enable_acs           =E2=94=82 re-derived from ACS    =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 policy                 =E2=
=94=82                     =E2=94=82
  =E2=94=9C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=A4
  =E2=94=82 pci_restore_iov_state    =E2=94=82 live dev->sriov        =E2=
=94=82 no                  =E2=94=82
  =E2=94=82                          =E2=94=82 (num_VFs, ctrl)        =E2=
=94=82                     =E2=94=82
  =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=B4=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=98

For things like MSI/X, SR-IOV, RE-BAR, etc. we're actually restoring
from the kernel internal state rather than the save buffer state, so
this is a no-op.  However, one thing in that list stands out, TPH.

We don't yet support enabling TPH, but there are series on the list
that propose to add this.  The TPH buffer space in the saved state is
allocated just by the capability being present.  On open TPH is
disabled and the saved state is untouched, zeros.  If TPH is then
enabled and the device reset, the pre-reset save state populates the
TPH save buffer and we restore that state post-reset.  With the change
here, reset_done would then push the open saved state.  The live TPH
state is enabled, therefore the restore pushes the original open state,
zeros.

This would result in a visible user change and maybe more importantly
shows that we're relying on ad-hoc behavior, without really any specific
policy to have this work reliably.  It actually seems like only in the
close function, where we've disabled anything the user might have
enabled, is it really valid to restore the original state.  Thanks,

Alex

