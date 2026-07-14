Return-Path: <linux-s390+bounces-22306-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tNZRBPnHVmqQBAEAu9opvQ
	(envelope-from <linux-s390+bounces-22306-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:36:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEEF75977B
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2026 01:36:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fRtSyLL1;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22306-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-22306-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 431053019139
	for <lists+linux-s390@lfdr.de>; Tue, 14 Jul 2026 23:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50D368D5A;
	Tue, 14 Jul 2026 23:36:20 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE422DB78C;
	Tue, 14 Jul 2026 23:36:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784072180; cv=none; b=pyJRnZdHVTvi4aaV3dN4sv54ilbPNq4KhnhUekPQiL40YSZ4ohFgeoIXILE3VMApmKxOHQ+qtLAZGJ2wIsEGP7hmAGzd3n9+5s+FG+sXoOwb2NX84iIP13pjT5iVDmoxpNxGHodSFWKq8ssGtTjGg2VqQ5TMEA60qQn+vJhiBBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784072180; c=relaxed/simple;
	bh=BOkCVySygQ9budy8uDJQ6N9JHWWz2vcJGwpn9JHDP6A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VmJgERWzkTVVViDljEb6WnJ3/Ga1pegSDtOiTj/mQrrQdt2IAMN6Cvvr4Vg6gZz55mTF02/7UI2Qsqgz7MeXX0biZuEeC8EOF9Pnjb5JVr/cCvrVh2pkAx2jIVl6STo+F4eZRAo9bIAxMHusyrKf2RhX9n1uKr+U1jJdEdqwbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRtSyLL1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2374C1F000E9;
	Tue, 14 Jul 2026 23:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784072179;
	bh=YWNzO6NzPddmQz3rvGf3dH2g7hNi0iP5lugtCq+Nhe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRtSyLL1HTGiUAH8ZiRvriBcAqNSEyD+VX3k/aKEZXZUhPBdvhDrMEktHEEkxoPlt
	 O/w45Fk7CKAO0ZBEJ2RiC0Nza88TynVL2nCR79pvSqW8SdPSgv73wHgET3xleTGwYg
	 5hKXiWxKNPdoaRI3kMFMHFVkOM0RPXeVGkjgGwPVCThHoTy75Q7Pme1DzYLQqhTikE
	 c+9u/g3aLRAHsGMNUPAanHhD4/63z6r3mqW6+gMyHKwOUAt3AG59Mo9WuYUQa6dYgX
	 iJ6DS7k4rCb5RT7SsJitxYOEfOeMlaS+SNSNebdRClcEA0OXS651WxFUMmHVOfG37c
	 DvZKYmedXZEow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/6] s390/vfio_ccw: free all memory if cp_init()
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260714232208.1683788-4-farman@linux.ibm.com>
References: <20260714232208.1683788-1-farman@linux.ibm.com>
 <20260714232208.1683788-4-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 23:36:18 +0000
Message-Id: <20260714233619.2374C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22306-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,smtp.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:farman@linux.ibm.com,m:gor@linux.ibm.com,m:kvm@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:hca@linux.ibm.com,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 6CEEF75977B

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of `cp_free()` can lead to a double-free =
of ccwchain structures and use-after-free of unpinned pages.
--

--- Patch [3]: [PATCH v1 3/6] s390/vfio_ccw: free all memory if cp_init() f=
ails ---
commit f65cc16ffb4e4ab4d98caf412ccd788513657f79
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: free all memory if cp_init() fails

This commit refactors the cleanup of ccwchain segments during
initialization. It moves the memory freeing outside of the recursive
ccwchain handling logic to prevent memory leaks when cp_init() fails.

> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 76632b18fc37c..74b1f25e01e72 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c

[ ... ]

> @@ -740,7 +754,7 @@ int cp_init(struct channel_program *cp, union orb *or=
b)
>  	memcpy(&cp->orb, orb, sizeof(*orb));
> =20
>  	/* Build a ccwchain for the first CCW segment */
> -	ret =3D ccwchain_handle_ccw(orb->cmd.cpa, cp);
> +	ret =3D ccwchain_build_ccws(orb->cmd.cpa, cp);
> =20
>  	if (!ret)
>  		cp->initialized =3D true;

[Severity: Critical]
This is a pre-existing issue, but could the concurrent execution of
cp_free() on this initialized channel program lead to a double-free of
ccwchain structures and a use-after-free of unpinned pages?

If a guest VM issues a channel program to an mdev to cause a subchannel
interrupt and then immediately triggers a vfio device reset ioctl, could
vfio_ccw_sch_io_todo() and fsm_close() race?

In drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_sch_io_todo(), the workqueue
path reads private->state and calls cp_free() without acquiring io_mutex
or sch->lock:

        if (is_final && private->state =3D=3D VFIO_CCW_STATE_CP_PENDING) {
                cp_free(&private->cp);
                cp_is_finished =3D true;
        }

Concurrently, fsm_close() can acquire sch->lock, successfully disable the
subchannel, set private->state =3D VFIO_CCW_STATE_STANDBY, drop the lock,
and call cp_free().

If vfio_ccw_sch_io_todo() reads the state as VFIO_CCW_STATE_CP_PENDING
before fsm_close() updates it, both threads might execute cp_free()
simultaneously.

In drivers/s390/cio/vfio_ccw_cp.c:cp_free(), there is a lockless check:

        if (!cp->initialized)
                return;

        cp->initialized =3D false;

Does this lockless time-of-check to time-of-use allow both threads to=20
proceed and call kfree() on the same ccwchain structures, potentially
leading to a host kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714232208.1683=
788-1-farman@linux.ibm.com?part=3D3

