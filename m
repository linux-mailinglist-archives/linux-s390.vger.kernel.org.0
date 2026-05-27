Return-Path: <linux-s390+bounces-20121-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +NX3G9ZKF2qaAAgAu9opvQ
	(envelope-from <linux-s390+bounces-20121-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 21:49:42 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A1F5E9A8E
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 21:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE297305EA0E
	for <lists+linux-s390@lfdr.de>; Wed, 27 May 2026 19:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4343B1EC6;
	Wed, 27 May 2026 19:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDXKKjBG"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6453B19B1;
	Wed, 27 May 2026 19:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911361; cv=none; b=qr+V+g2Uyalbwkm/mKvx25JPNBOQHQ1G8Dn9OcY20VwUDZVHHflgJ7mmQQdnibWaue3AGds9YXsyO16s9ybgVLdHXdEmUw4dk5838q3QELgWAuY2hKSObXoyt5WdBXfp83jrxNceOYNIvvprvok4ntAi6/G9BvL4W/buTFHxjMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911361; c=relaxed/simple;
	bh=BOX6oxFNMVOGHWdWk7SOAtjBTLNjNCjT/ks26xjpu1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R0auOEIRk/zMy4I1m2npNk7B9sKSTc7nXi6rvLWHmaxd4I8DWTDdjszpHVpDRckPBcbZ3WpUFHpL/WznD2jQS7XvUG8KhWuLJC9LQuFfrpy9WhcPUQk/77JTkjV2Vs/QVdBC74SCwd2trrdU5lH57B3ThQvhv32YML7g/i+Ihw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDXKKjBG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389B41F00A3E;
	Wed, 27 May 2026 19:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911360;
	bh=J2iEHJs+dlCLb9cMhei6nH0VvPn5UMkWOBOgpg/1DvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MDXKKjBGTTL2bI5I9xNZXhC/HIW9nMcQptqnzF2lpJh5YFVKewR59CRV/0HerxJt9
	 KLeRGck8gq1nXKagsG+ylI+5bcvEdQrlXYSuaqCBes1Ec9VOJYCIngdmPFTcSLAy/Y
	 3ZTFMrHBk0zahdNuYbKzE87o2MDJa7pBjwFOOeoNVhbcLmJfKxonVfidV8kQscLNxe
	 r6W3FG4n1mq9Nk6jNEKdakP2Ovz0oJJ8WKbioLDDaZwhZhVrVYrK9mrcdM9jbqL5Pi
	 iGG+ttY+/VUkVXj5KTLYHranhV6FQqkX9H1GX2mJI93oQPKibzs4u1SCjxcUHAoBCW
	 5iGUjfs1OXLhA==
From: Sasha Levin <sashal@kernel.org>
To: Natanael Copa <ncopa@alpinelinux.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vneethv@linux.ibm.com,
	oberpar@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com
Subject: Re: [REGRESSION] 6.6.141 s390x build failure in s390/cio due to missing driver_override infrastructure
Date: Wed, 27 May 2026 15:48:59 -0400
Message-ID: <20260527-agent5-item005-s390cio@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526221254.183e23ef@ncopa-desktop.lan>
References: <20260525101635.26090-1-ncopa@alpinelinux.org> <20260525231000.agent5-0002@kernel.org> <20260526221254.183e23ef@ncopa-desktop.lan>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20121-lists,linux-s390=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-s390@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D2A1F5E9A8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> FYI. We also needed this for the build to pass:
>
> diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
> [...]
> -       spin_lock_irq(sch->lock);
> +       spin_lock_irq(&sch->lock);

Thanks - this points at the backport of c34b09cbd6fc0 ("s390/cio: Update
purge function to unregister the unused subchannels") which had its own
issues on 6.6.y. I reverted c34b09cbd6fc0 on 6.6 so 6.6.142
should build cleanly without the manual fix. If the upstream purge
update is still wanted on 6.6, it can be re-submitted as a proper
backport once the driver-core prerequisites are in 6.6.142.

--
Thanks,
Sasha

