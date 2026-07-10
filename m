Return-Path: <linux-s390+bounces-22028-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bi4kCXLEUGoh4wIAu9opvQ
	(envelope-from <linux-s390+bounces-22028-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:07:46 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F1A73973B
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 12:07:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hMBdxTtf;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-22028-lists+linux-s390=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-s390+bounces-22028-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F9B3012C48
	for <lists+linux-s390@lfdr.de>; Fri, 10 Jul 2026 09:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E423FBB6F;
	Fri, 10 Jul 2026 09:56:31 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D33FD960
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677391; cv=none; b=OCR6FYUXXX3sELRlSrI4S8G/yTnzKbS5OBRLWLq+O3j/PR0zFHdbW4A3lUCLpGCCOo8OUxid/M2BNsBlD09xFxpzyrbb0u8Ld/WoXEQIGIhA8TufdpJoxmLuxSzyqInXKG3UogFzUz779b0Gc/VyutguSBybChkM7mR3l7/KfYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677391; c=relaxed/simple;
	bh=y7Yx92GnkN+WHD07YIMZOFrt5RTUzcykzhKiBjKZW2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uua8jy0lC005ygA7czcsQdUcTqZYRfdskFkG28oX6lwo4qmzBeRcnTT9n7UU9kZoKMZPuMQ4tsn5J+O+l+RQwCxo1gJE8bBJGJ64Hbj5rO9EIcaH1V5uyC6XkKcGF//PfYa/AKkV8ldeKWf0RYP6C6gJTgUAAkwppzfWefB0snI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMBdxTtf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF89E1F00A3A;
	Fri, 10 Jul 2026 09:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677390;
	bh=SxwlYTG4ofBRLEx9F54kIe3mArVI39EVXzSgYODYViI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hMBdxTtfo+s4MWc7KrsbyOfRe5wumSOdGxlnTelEr6P9FQGSHNYemE7KPg+KwejyY
	 F8hezrQ6SzZPxdE6uhSPfONurjMOTx9DvWnzUgXUFX9IWr1rSwh8ER/xB4mJXLAFyh
	 xVWQkDh1UW4onmiwTOyeM/XOlqpi/QYl5TP+nxM751j5NRDX8M/2RiPF1MTqA98B+H
	 xZD+ZKOBklV5Ssu16eB0f6wfmDxAfKok2INaMXg6wdHImljY8PF3+z5a55SbD6xehz
	 lsKL5z1t+jEajhCqy/gXo3D7H/4whsbIHLh5NHWsVKipMLcSsiaxd8MsPz3tcfgKQG
	 Wk8uCBYJjv/EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup device
 visibility to the net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, mkoutny@suse.com, "Heiko Carstens" <hca@linux.ibm.com>, hannes@cmpxchg.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709095532.855647-9-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-9-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:29 +0000
Message-Id: <20260710095629.BF89E1F00A3A@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22028-lists,linux-s390=lfdr.de];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-s390@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jiri@resnulli.us,m:tj@kernel.org,m:mkoutny@suse.com,m:hca@linux.ibm.com,m:hannes@cmpxchg.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gor@linux.ibm.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli.us:email,smtp.kernel.org:mid,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58F1A73973B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Scoping RDMA cgroup device visibility to the reader's network name=
space breaks host-level cgroup administration and monitoring.
- [Medium] Concurrent lockless read of `device->net` using `read_pnet()` wi=
thout `READ_ONCE()` leads to a data race.
--

--- Patch [8]: [PATCH rdma-next 08/13] RDMA/cgroup: Scope rdma cgroup devic=
e visibility to the net namespace ---
commit 18e4bddcfb08bd42bef710d6d1b72824d15fa2c9
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/cgroup: Scope rdma cgroup device visibility to the net namespace

Track each rdma cgroup device's net namespace and sharing mode, then filter
name lookups and cgroupfs enumeration to devices visible from the caller's
namespace. Keep the cached sharing mode synchronized across registration,
netns moves, and runtime mode changes.

> diff --git a/kernel/cgroup/rdma.c b/kernel/cgroup/rdma.c
> index 5e82a03b3270a..c8b4e3de76305 100644
> --- a/kernel/cgroup/rdma.c
> +++ b/kernel/cgroup/rdma.c
[ ... ]
> @@ -464,6 +465,13 @@ void rdmacg_unregister_device(struct rdmacg_device *=
device)
>  }
>  EXPORT_SYMBOL(rdmacg_unregister_device);
> =20
> +/* netns_shared is toggled without rdmacg_mutex, hence READ_ONCE(). */
> +static bool rdmacg_device_visible(const struct rdmacg_device *device)
> +{
> +	return READ_ONCE(device->netns_shared) ||
> +	       net_eq(read_pnet(&device->net), current->nsproxy->net_ns);

[Severity: Medium]
Does this lockless read of device->net using read_pnet() cause a data race?

When another thread concurrently moves the RDMA device to a new network
namespace, it updates device->net:

drivers/infiniband/core/cgroup.c:ib_device_rdmacg_change_netns() {
	write_pnet(&device->cg_device.net, net);
}

While write_pnet() uses rcu_assign_pointer() to update the pointer concurre=
ntly,
read_pnet() here expands to a plain pointer access without READ_ONCE(). Sin=
ce
rdmacg_mutex is not held during the write, could this plain read race with =
the
assignment and cause undefined behavior?

[Severity: High]
Does tying RDMA cgroup device visibility to the reader's network namespace
break host-level cgroup administration and monitoring?

If a device is moved to a non-init network namespace (exclusive mode), host
administrators and orchestration tools (like systemd or Kubernetes running =
in
init_net) will completely lose visibility and control over its RDMA cgroup
resources. Attempting to write to rdma.max will result in -ENODEV, and read=
ing
rdma.current will show an empty list for these devices.

Since cgroup state must reflect the cgroup's configuration independent of t=
he
reading process's network namespace, does tying the UAPI to
current->nsproxy->net_ns violate VFS semantics where an open file descripto=
r's
behavior would dynamically change depending on which process calls write()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D8

