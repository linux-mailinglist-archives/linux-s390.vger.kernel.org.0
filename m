Return-Path: <linux-s390+bounces-21449-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +0yBBhdBRWrc9QoAu9opvQ
	(envelope-from <linux-s390+bounces-21449-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:32:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFB76EFD26
	for <lists+linux-s390@lfdr.de>; Wed, 01 Jul 2026 18:32:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PcDH3ssh;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21449-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21449-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B5173045EC3
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2026 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992136D517;
	Wed,  1 Jul 2026 16:27:31 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC206368D71;
	Wed,  1 Jul 2026 16:27:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923251; cv=none; b=ii8fXe8hHJ7DOuhLAkCCPlCqAN4mEJw8ToF/GUzsTHeS+GwrvW0/txrQMwUUPS0gIOhgsz4ARg19VVOiDp1R/nDHiV0RWKAp+VTvvPUTMsvkoYWeXZgplol6hZik5ZKv7ZE3SmqzCM6MlD4EJUPbWPmG4Qj9+C8bWu5/dDB1Aes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923251; c=relaxed/simple;
	bh=oUNt8kraS7RbX9oNGjSy8d+EHCoQYobAjd1iZhVjGBA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aqSlA/TYsIr5eAITsnYSgB/5vC0LRd4cKIMew1JhNUimLIp6dgYNRgZTwBXSG5VCjuL8owVudYbubRDhG5ENBr0nt51Xjzqsg3G3ke19rsE1G598kkG8IoyWY6e2xopmWY6TzRKXB2fwu8MyAcadaUmEoepN/CXxKREdTlsx3dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcDH3ssh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F132C1F000E9;
	Wed,  1 Jul 2026 16:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782923249;
	bh=C71zmEENUUiDRRoYW052MW6KSTKMKDP4q3Wwg+f/qT0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PcDH3sshnIKB1nOl15CKxBrQaDGKTvXUeZs4vJ3Wet58t661luZDNYqdCg31Jt+Yv
	 kHtqE8JjxsstmBaYsAFH/WhmZNv3AML+DGXxuBIl8YAYgu/YQpZYOwmoiIVFylso6M
	 MwZLG6QIfVNq0YvcO9P9AuY4SKXXaUk6+QwN/RGBVowHCidmevGSxfEirXTXn4HEOM
	 9mIgmfUDbyL8Z+C1+ksSd2ypqfyuYnBIYTt8sry1N7+kw061PRbLVYehF4KgvC7c+9
	 LvfkbVH+5q7f/9b11a75PcOpa6MekU1t2JavKepjsTZTc96A+grkoClJtd95Zt1gzB
	 3/JswJ9P7i8bg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/11] dma-buf: heaps: Add debugfs support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, conor+dt@kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-7-d80f7b871bb4@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 16:27:28 +0000
Message-Id: <20260701162728.F132C1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21449-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:hca@linux.ibm.com,m:agordeev@linux.ibm.com,m:linux-s390@vger.kernel.org,m:conor+dt@kernel.org,m:gor@linux.ibm.com,m:dri-devel@lists.freedesktop.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,smtp.kernel.org:mid,vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DFB76EFD26

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] debugfs_create_dir failure handling causes namespace pollution.
- [Low] Incomplete resource teardown in newly added dma_heap_exit() functio=
n.

Pre-existing issues:
- [High] Use-After-Free due to character device exposure before uniqueness =
validation completes.
--

commit be3535d09b01d53c055d9d5fb7c60f03232a5ac7
Author: Thierry Reding <treding@nvidia.com>

dma-buf: heaps: Add debugfs support

Add a callback to struct dma_heap_ops that heap providers can implement
to show information about the state of the heap in debugfs. A top-level
directory named "dma_heap" is created in debugfs and individual files
will be named after the heaps.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index a76bf3f8b071a..1ceb6ee8c05a2 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -224,6 +225,46 @@ const char *dma_heap_get_name(struct dma_heap *heap)

[ ... ]

> +static struct dentry *dma_heap_debugfs_dir;
> +
> +static void dma_heap_init_debugfs(void)
> +{
> +	struct dentry *dir;
> +
> +	dir =3D debugfs_create_dir("dma_heap", NULL);
> +	if (IS_ERR(dir))
> +		return;
> +
> +	dma_heap_debugfs_dir =3D dir;
> +}

[Severity: Low]
If debugfs_create_dir() returns an error, this early return leaves
dma_heap_debugfs_dir as NULL.

Later, when dma_heap_add() calls debugfs_create_file() with this NULL paren=
t,
won't it create the heap files directly in the debugfs root directory inste=
ad
of failing safely?

[ ... ]

> @@ -298,6 +339,13 @@ struct dma_heap *dma_heap_add(const struct dma_heap_=
export_info *exp_info)
> =20
>  	/* Add heap to the list */
>  	list_add(&heap->list, &heap_list);
> +
> +#ifdef CONFIG_DEBUG_FS
> +	if (heap->ops && heap->ops->show)
> +		debugfs_create_file(heap->name, 0444, dma_heap_debugfs_dir,
> +				    heap, &dma_heap_debug_fops);
> +#endif
> +
>  	mutex_unlock(&heap_list_lock);
> =20
>  	return heap;

[Severity: High]
This is a pre-existing issue, but doesn't the current design of
dma_heap_add() allow a use-after-free?

The character device is made live and exposed to userspace early:

	cdev_init(&heap->heap_cdev, &dma_heap_fops);
	ret =3D cdev_add(&heap->heap_cdev, heap->heap_devt, 1);

But then, if the uniqueness check fails:

	list_for_each_entry(h, &heap_list, list) {
		if (!strcmp(h->name, exp_info->name)) {
			...
			goto err3;
		}

The error path frees the heap without revoking the live character device:

err0:
	kfree(heap);

If userspace opens the device concurrently before the uniqueness check fail=
s,
could it access the freed heap object?

[ ... ]

> @@ -334,6 +382,14 @@ static int dma_heap_init(void)
>  	}
>  	dma_heap_class->devnode =3D dma_heap_devnode;
> =20
> +	dma_heap_init_debugfs();
> +
>  	return 0;
>  }
>  subsys_initcall(dma_heap_init);
> +
> +static void __exit dma_heap_exit(void)
> +{
> +	dma_heap_exit_debugfs();
> +}
> +__exitcall(dma_heap_exit);

[Severity: Low]
Does this exit function omit teardown steps?

It cleans up debugfs but seems to be missing calls to
unregister_chrdev_region() and class_destroy() that were set up in
dma_heap_init().

If this subsystem is ever built as a loadable module, won't this leak those
resources on unload?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-tegra-vpr-=
v3-0-d80f7b871bb4@nvidia.com?part=3D7

