Return-Path: <linux-s390+bounces-20805-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qPF6CHguLGo7NAQAu9opvQ
	(envelope-from <linux-s390+bounces-20805-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 18:06:16 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A667AB5F
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 18:06:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BqMZBotc;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20805-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20805-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3400E3184EE5
	for <lists+linux-s390@lfdr.de>; Fri, 12 Jun 2026 16:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3887B36494B;
	Fri, 12 Jun 2026 16:05:13 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22729391E5B;
	Fri, 12 Jun 2026 16:05:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280313; cv=none; b=Yqzb/aoUuRzBtS1jJb2osOLVg885S+5bXsn1XZdiUSOcj7rGKkcbGhNZzZy/xS6ZlcDlDxD+VFu6iM0i1ubZayCDG7i+EfxL59MM1h9FfvIoHqNIKOcnoIstvaw9UPTRo1hAdlZouEBhvg91byd/oDGSxw8qgejJkWnLbQoeJnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280313; c=relaxed/simple;
	bh=jRcSZhdjW2n9VI50I1w0Kcv7cQL5bzw3mW5nIe5TGtU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KbaHIcavrfJPOjz6gt350+GGns8tXxW6wuKxiVN4JjEWfDhhYfuS706yjD7mABC2N2Ev4+FW3se2yAyaIaXdOFV8yVc+cm+lVvtRgIAWnhbZm5Dt7uo6bo+4Jylku1Ujd7zuxLlcZAPVtlkj3HvAGJVZCXblzSOEYnQRaHXZz70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqMZBotc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5101F00A3D;
	Fri, 12 Jun 2026 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781280311;
	bh=l07fS9VgDLgMMxEiLe+PmpxkCgntnaR6UyN1wkidaPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BqMZBotcDkmtYcrau4b04KAe7t0dTUecAPpYkmOQZU4q7XPff2zJKK1mWHNt/aK4Z
	 PWM7iv6YGG08QY8Ba/Eq1lTOOcNj67yHrw94bUlMs1VRi2Cj2GQaiG3u7otFv4cwQg
	 iKS1Ew4BycfPA9N/q8V59s6Jd/KPzfy5NGJ8m7U9Ly5pP0m9Dr70Pt82WFRoFx3Xml
	 hMSZxZXQbGKz/9FFz0nPXZsA5yY63CO6t3qkYVFqtM781zn4wg/64F4i8OyxWMUNi9
	 +gwCuOKsMTEvKEW9fJsY+z2PF/GnY7um+X8c8lypK7unStmwjBKI8DYPFqdamoVY2p
	 N/niSILW+An4A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] s390/virtio_ccw: Also suppress -EINVAL on device
 detach
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Bezenah" <wbezenah@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260612155407.199218-1-wbezenah@linux.ibm.com>
References: <20260612155407.199218-1-wbezenah@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:05:10 +0000
Message-Id: <20260612160511.1B5101F00A3D@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20805-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:wbezenah@linux.ibm.com,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,m:linux-s390@vger.kernel.org,m:hca@linux.ibm.com,m:kvm@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 806A667AB5F

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If deregistering indicators from the host fails with an error =
other than -ENODEV or -EINVAL (e.g., -EIO), virtio_ccw_drop_indicator() ski=
ps the cleanup of local adapter interrupt pointers, leading to a subsequent=
 use-after-free when virtqueues are deleted.
--

commit 6f54104d3533aa779587af76d171dec3ef8e1b8f
Author: William Bezenah <wbezenah@linux.ibm.com>

s390/virtio_ccw: Also suppress -EINVAL on device detach
   =20
This patch updates the error handling in virtio_ccw_del_vq() and
virtio_ccw_drop_indicator() to suppress -EINVAL along with -ENODEV
during device detach. This avoids spurious warning messages in the
kernel log when detaching virtio devices with multiple queues.

> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -429,7 +429,7 @@ static void virtio_ccw_drop_indicator(struct virtio_c=
cw_device *vcdev,
>  			    vcdev->is_thinint ?
>  			    VIRTIO_CCW_DOING_SET_IND_ADAPTER :
>  			    VIRTIO_CCW_DOING_SET_IND);
> -	if (ret && (ret !=3D -ENODEV))
> +	if (ret && (ret !=3D -ENODEV) && (ret !=3D -EINVAL))
>  		dev_info(&vcdev->cdev->dev,
>  			 "Failed to deregister indicators (%d)\n", ret);
>  	else if (vcdev->is_thinint)
>  		virtio_ccw_drop_indicators(vcdev);

[Severity: Critical]
This is a pre-existing issue, but does this if/else structure create a
use-after-free risk during virtqueue deletion?

If ccw_io_helper() fails with an error other than -ENODEV or -EINVAL
(for example, -EIO), the first branch executes and logs the warning, but
the 'else if' branch is entirely skipped.

This means virtio_ccw_drop_indicators() is never called, failing to clear
the virtqueue pointers in the shared airq_info->aiv array.

Because virtio_ccw_del_vqs() subsequently proceeds to free these virtqueues
via vring_del_virtqueue(), the uncleared pointers in the shared airq_info
will point to freed memory.

If an adapter interrupt arrives later for this leaked bit, could
virtio_airq_handler() retrieve the dangling pointer and trigger a
use-after-free by calling vring_interrupt() on the freed queue?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612155407.1992=
18-1-wbezenah@linux.ibm.com?part=3D1

