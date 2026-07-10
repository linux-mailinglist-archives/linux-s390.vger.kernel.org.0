Return-Path: <linux-s390+bounces-22026-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qyIKCGrEUGod4wIAu9opvQ
	(envelope-from <linux-s390+bounces-22026-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:07:38 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 135DC73972E
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:07:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NCwGQG7c;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22026-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22026-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F36073015D52
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFED33FD156;
	Fri, 10 Jul 2026 09:56:29 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5493FBEBC
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677389; cv=none; b=UtFTn6Joip2P92b8NQQ9wq3bmbfoplZTZ6I/0+H1UbHnGXVpxnSfMS8cQT2haCbDWM9/x5Q9DvahNJ3X6ADkVsGap1/zl8rqPUtHbjNjQRHVC8mw3D3Qqv5XHBEQ455BgPinRs8IYyirNgAg0hKrzcHCuAKgsiJ43qIvoxb75pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677389; c=relaxed/simple;
	bh=/h+zKVQoTKMpZ3w8eKd0qh8/ukXHvsReAYyqKGiElJo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dJGaH4UTUtVvB9kJWWjdD0vRvdg3Hx8Btr1kCnaZHaTh1qdOqoAnokpSxCckGLb8FtHgSckwNzBzFVdoOGCSLD9izbsMt9bpxGQwS26YqCdd7DxicfbDf/p5vdhdp/MTNGD6+XF6VvFuzTgWfuzmRSMqa38Q/KJVRwavKw39l4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCwGQG7c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAD21F00A3D;
	Fri, 10 Jul 2026 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677388;
	bh=ENZ7xCCTkcLAljxdHPR0xCOU0daubHM5eL8GF4Qu8yY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NCwGQG7ck5sS1lG/xbEFHK2orBl3iHOZ6/cml6TXSWfs1Uus/opeD1+rOp6QlLClY
	 WuMwIt5IedGAPMzWy7jAtQT4C/CIXRmLdupvGNqMa2J8hHRjiUhlGvMTwLPWfaUdbz
	 SYthR0bcCxsi/iX/0guORNUVujg1gsYyfFommCUvrWgJIDP3GYq5jvKyoGRN1ipeVF
	 c/F+VhZ644Y+NE3Fl2egqZyCzhGT9+jfx29FW0TRkT3xCt5NXO9+PIvKt/Zy73haBT
	 gHUl9gkcLZabM65taSpuSfWeZa1hnwLvoKgQjWUyIzVcHBOif+anPC58gCnE5ZYmJ7
	 qt4lfays4IdMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 02/13] RDMA/core: Handle device name conflicts
 when changing net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, mkoutny@suse.com, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, tj@kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, hannes@cmpxchg.org
In-Reply-To: <20260709095532.855647-3-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-3-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:27 +0000
Message-Id: <20260710095627.CDAD21F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-22026-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:mkoutny@suse.com,m:agordeev@linux.ibm.com,m:tj@kernel.org,m:hca@linux.ibm.com,m:hannes@cmpxchg.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 135DC73972E

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] User-triggerable WARN() during concurrent RDMA device unregistrati=
on and netns exit, leading to DoS on panic_on_warn systems.
--

--- Patch [2]: [PATCH rdma-next 02/13] RDMA/core: Handle device name confli=
cts when changing net namespace ---
commit 05c3f87e2143d43f2f1e27d0f13e1b1f97f35bab
Author: Jiri Pirko <jiri@nvidia.com>

RDMA/core: Handle device name conflicts when changing net namespace

This commit prepares namespace moves for per-netns names by checking
user-initiated moves for destination-name conflicts before disabling the
device. It also ensures teardown moves detach from the exiting namespace
even if fallback naming fails.

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
> @@ -1160,8 +1168,17 @@ static void rdma_dev_exit_net(struct net *net)
> =20
>  		/*
>  		 * If the real device is in the NS then move it back to init.
> +		 * Provide a fallback pattern so a name conflict in init_net
> +		 * cannot make the teardown move fail.
>  		 */
> -		rdma_dev_change_netns(dev, net, &init_net);
> +		if (net_eq(net, read_pnet(&dev->coredev.rdma_net))) {
> +			ret =3D rdma_dev_change_netns(dev, net, &init_net,
> +						    "ibdev%d");
> +			if (ret)
> +				WARN(1,
> +				     "Failed to move RDMA device %s to init_net on netns exit: %d\n",
> +				     dev_name(&dev->dev), ret);

[Severity: High]
Can this WARN(1) be triggered by a concurrent device unregistration?

Looking at rdma_dev_change_netns(), if a device is concurrently unregistere=
d,
the refcount drops to 0 and the function legitimately returns -ENODEV:

drivers/infiniband/core/device.c:rdma_dev_change_netns() {
    ...
    if (refcount_read(&device->refcount) =3D=3D 0 ||
        !net_eq(cur_net, read_pnet(&device->coredev.rdma_net))) {
            ret =3D -ENODEV;
            goto out;
    }
    ...
}

If rdma_dev_exit_net() runs concurrently with device unregistration (e.g.,
module unload, PCI hotplug, or link deletion of a software RDMA device like
RXE), rdma_dev_change_netns() will return -ENODEV and trigger this warning.

Because an unprivileged user can acquire CAP_NET_ADMIN in a user namespace,
create an RXE device, and race netns deletion with device deletion, could
this be used to intentionally crash a host configured with panic_on_warn=3D=
1?

> +		}
> =20
>  		put_device(&dev->dev);
>  		down_read(&devices_rwsem);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D2

