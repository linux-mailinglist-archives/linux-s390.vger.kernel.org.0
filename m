Return-Path: <linux-s390+bounces-18757-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDwxNKBP2Wk4oQgAu9opvQ
	(envelope-from <linux-s390+bounces-18757-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 21:29:36 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F623DBFF6
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 21:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39E9F30036E4
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E2A347BDB;
	Fri, 10 Apr 2026 19:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaIxhMfg"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570930B509;
	Fri, 10 Apr 2026 19:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775849346; cv=none; b=Cckc02gAbjapf6dbRqCyiCRpykGGfkfr6vOkSFMRMAb5y/7iyF0f5gfmFSVz9hB64zan8M1PM61CVaRnH/GTgdpEzqAD2NTUryohuT+Xe5ULVwGjy9S/MGaMaH1HuCymm7D6Y4Ciaj/1L7nTy8M5sVvBlW3/a/vpFcZKgsVPtRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775849346; c=relaxed/simple;
	bh=zy0hAvV+NOwFb5nTFTEz3iYeb2USleR88YYuiS6EvR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKl+ClClVDSFnmtb5kpZoRGK+aCUKAShXYKyRBaawR7uFsXt0ZP9VNOOI+ev8CAUoXcAwaE6+jdhyvDXlKkQ7kJXG7cxWp56aSrzdF+ZjoX9YKfu4aUUWYJzh++WJv40E8E1i3f7+iMdfUgGwIsV7SamVPQiHOt/NwH1oRMvPQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaIxhMfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04B9C19421;
	Fri, 10 Apr 2026 19:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775849345;
	bh=zy0hAvV+NOwFb5nTFTEz3iYeb2USleR88YYuiS6EvR8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oaIxhMfg37pjioBpynzVtdgjP1hfBu+X9N+ucjEQuSjRNCze9Kd2Y07X+SGYiWxdD
	 rt0OinSl7bU5elKCd8v88B3zUlBCi5KbqtpYWXoazC+fV2pYnQXM6NAAUYcQX5wgUZ
	 k43fG1P50K7iVkitpYcivDdGuNiliJEG7h6xToBsW8/F8ErLAjvKp4uhW+5ICxqDL3
	 RjYUn7XuKgC3Xp7wlrvVpYpZHAo67lloSAqioc2JnUFK8v0W6XF3e+iXxUKIp8s0uX
	 UmSjNxZZEnOS7DkJhP7pTBiun1tydlNaVV3e50sD/KxGf0xdD/dfBSP+33xJu8BoBv
	 2H7nxuryitg0Q==
Date: Fri, 10 Apr 2026 09:29:04 -1000
From: Tejun Heo <tj@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <adlPgOKBSkGavsss@slm.duckdns.org>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <25415176-d977-41c1-83d1-3f060292f636@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25415176-d977-41c1-83d1-3f060292f636@paulmck-laptop>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18757-lists,linux-s390=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,slm.duckdns.org:mid]
X-Rspamd-Queue-Id: 38F623DBFF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello, Paul.

On Fri, Apr 10, 2026 at 12:17:21PM -0700, Paul E. McKenney wrote:
> > The easiest way to do this is just creating the initial workers for all
> > possible pools. Please see below. However, the downside is that it's going
> > to create all workers for all possible cpus. This isn't a problem for
> > anybody else but these IBM mainframes often come up with a lot of possible
> > but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> > be negligible on some configurations.
> > 
> > IBM folks, is that okay?
> 
> I have also seen x86 systems whose firmware claimed very large numbers
> of CPUs.  :-(

Yeah, I remember seeing those but at least the ones I remember are from long
times ago. Hopefully, no bios is getting things that wrong anymore.

> > Also, why do you need to queue work items on an offline CPU? Do they
> > actually have to be per-cpu? Can you get away with using an unbound
> > workqueue?
> 
> It is good for them to run on the specified CPU in the common case for
> cache-locality reasons, but if they were occasionally redirected to some
> other CPU, that would be just fine.

I see.  

> I am also keeping the patch that avoids queueing work to CPUs that are not
> yet fully online.  Further adjustments will be needed if someone invokes
> call_srcu(), synchronize_srcu(), or synchronize_srcu_expedited() from an
> CPU that is not yet fully online.  Past experience of course suggests that
> this will be happen, and that there will be a good reason for it.  ;-)

I'm gonna hold for now. From workqueue side, it's a really easy change, so
please let me know if this comes up again.

Thanks.

-- 
tejun

