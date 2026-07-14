Return-Path: <linux-s390+bounces-22310-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8HvqGgPKVmrhBAEAu9opvQ
	(envelope-from <linux-s390+bounces-22310-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:45:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8577597F8
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:45:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hzMRhgZm;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22310-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22310-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3E643018C1E
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 23:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC3A409638;
	Tue, 14 Jul 2026 23:45:05 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3921442BE95;
	Tue, 14 Jul 2026 23:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072705; cv=none; b=p3J+6AldbbJTOIddx+CuBTdY7d3gHk4yYEaPQyn4TSxfA5i4ItQAR6d8l/9knx1b4W3oSMMK8cX//4hQHtnjg0kQxfrFiTJbQ9sRAbm/V9MxiIaxRm3RgbXpg2nSd0EuAuY9gnTJ0yQSGGBeSqpRlM9SEWmgFLwR88uWSxES8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072705; c=relaxed/simple;
	bh=VGb5zaWXR8O89aCdAZYNdfocUDZh6+3/R3u++JbL13Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qo91CrU9Xv79+WLB56vynNTV82siD0ku/k6LHakQVZ4W/tL86MS9z/f8ObY0SXa3ZWQZC3q7QREbu4impzVxCfs3f/iGbbd8v+evjNW22nuDKVRAF7W3LKD/rhQ7W4vt2HnOKhqraZCt1JrRZTOfv4ZrOKH9ZxT2M+sEvgs3UDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzMRhgZm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5661F000E9;
	Tue, 14 Jul 2026 23:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072703;
	bh=xSybn/rSElSg8hmK/MvGsyTLF8aSrSsXnyofv+nwbEQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzMRhgZm0vEYxEwK5wM4wetgBUC0GHZiTxp2LgmhqbD9bLbvtoupEvQdZJTopgGUb
	 jGtRvApISnCQgfVxuuM2LxFdi5oB+80YiIdS0w31n6HXbleF+POP0nGB9LWzjjL8SL
	 vLww8qMAPIo9InQ9+sEEP5cmh9zQSqnK49sfzNvQ7Ik/Ht7aLFipsuB/p2lBUhhYye
	 wjYdAaOQQ5pLWyETBi0eEm/6Qt52aE2c3Msqu6DhcMisTbWTfxyc+DJ17IQDItXJiC
	 Y+akHOa1/Dahwd6WCXD1ZnQBPI+v8zRRxNHtUmR4tG5Xwe7fXBQVRFQJMElXKNOAuv
	 f8zVlIId8djbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/6] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-6-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-6-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:45:03 +0000
Message-Id: <20260714234503.7C5661F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22310-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:farman@linux.ibm.com,m:agordeev@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD8577597F8

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Flawed usage of `array_index_nospec()` incorrectly clamps out-of-b=
ounds indices to 0 before a subtraction, leading to a speculative integer u=
nderflow and out-of-bounds array access.
--

--- Patch [5]: [PATCH v1 5/6] s390/vfio_ccw: ensure index for read/write re=
gions are within range ---
commit f00821fcd31baacca490cf51ca9a9206a56fdf45
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

The introduction of the capability chain clamped the region indexes to the
range of the capabilities itself, but neglected to do so for the existing
read/write regions. This commit enforces the same checks for those regions.

> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -245,6 +245,8 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device =
*vdev,
>  	if (index >=3D VFIO_CCW_NUM_REGIONS + private->num_regions)
>  		return -EINVAL;
> =20
> +	index =3D array_index_nospec(index, VFIO_CCW_NUM_REGIONS + private->num=
_regions);
> +
>  	switch (index) {
>  	case VFIO_CCW_CONFIG_REGION_INDEX:
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);

[Severity: High]
Does this introduce a speculative out-of-bounds access regression?

If an attacker provides an out-of-bounds index, the architectural bounds
check is bypassed during speculative execution. The array_index_nospec()
mitigation will clamp the out-of-bounds index to 0 to resolve data
dependencies safely.

However, if the CPU mispredicts the switch statement and executes the
default case, the clamped index of 0 is subtracted by
VFIO_CCW_NUM_REGIONS. This causes an integer underflow, leading to a
speculative read of private->region with a negative index, followed by
a speculative indirect call via ops->read().

Could we perform the array_index_nospec() masking after the subtraction,
specifically clamping against private->num_regions instead?

[ ... ]

> @@ -297,6 +299,8 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device=
 *vdev,
>  	if (index >=3D VFIO_CCW_NUM_REGIONS + private->num_regions)
>  		return -EINVAL;
> =20
> +	index =3D array_index_nospec(index, VFIO_CCW_NUM_REGIONS + private->num=
_regions);
> +
>  	switch (index) {
>  	case VFIO_CCW_CONFIG_REGION_INDEX:
>  		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
>  	default:
>  		index -=3D VFIO_CCW_NUM_REGIONS;
>  		return private->region[index].ops->write(private, buf, count,
>  							 ppos);

[Severity: High]
Will this suffer from the same speculative integer underflow as the read
path?

If array_index_nospec() clamps an out-of-bounds index to 0, the
subsequent subtraction will result in an underflow, allowing a
speculative out-of-bounds read and an indirect call through ops->write().

Additionally, it looks like this identical anti-speculation pattern is
already present in other locations such as
vfio_ccw_mdev_ioctl_get_region_info(),
intel_vgpu_ioctl_get_region_info(), and vfio_pci_ioctl_get_region_info().

Do those locations also need to be updated?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D5

