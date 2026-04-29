Return-Path: <linux-s390+bounces-19207-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFENAb5I8mnDpQEAu9opvQ
	(envelope-from <linux-s390+bounces-19207-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 20:06:54 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7453B498937
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 20:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D19A73000E07
	for <lists+linux-s390@lfdr.de>; Wed, 29 Apr 2026 18:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0717E3FFAC1;
	Wed, 29 Apr 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AU63GQB4"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F23CA4A3;
	Wed, 29 Apr 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485903; cv=none; b=l9xRp6CmM42xgOf3dmoAkQS+C8rwBWBY0UWR7fkI0ln3A9i8RHUsu1FfR8ShSutvLmnw7wpOU1LW6MmUucKgMS0zw28Lh5nlVPWMKGUcwNNS4fGxDS2BEixPh2eSlzlcJZKdPeSDG9jyAqSTN+K9B5etjNcdP6RXcKKCdgFBnZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485903; c=relaxed/simple;
	bh=1woczW14b6ka92d2DtkzEGGr0tbp7tW/95JTnA/PU3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOdtqYVtPH4neIOrZfdXyox50wSw7P22B0qKAQqZLt2I+5Bz3gsFU3EOf9wLDYXAnqfYvu9cA0W3SbYRxz6py9GXa8AvkFH2/PXW+Kf3rc6acbbCFmmxVc44wjZQGe21aKrKJKERhRVOqkIS5M3mfllI5UGk4/h4z4LJOxGOmts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AU63GQB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC1AC19425;
	Wed, 29 Apr 2026 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777485903;
	bh=1woczW14b6ka92d2DtkzEGGr0tbp7tW/95JTnA/PU3g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=AU63GQB4LuCikKlfna7FrrEm+XUlXDHZS4WxQ8zoE2Fyi1K1apql3fgcSRq959X2Q
	 9urdJNMf8epRingOI/Gp+yS8FhmNRyh3hjXUIAq2vQp2VzcagKPCiy1dO/eB6VqpXH
	 +QWP6L6hfgo2HVbFLPi+3BZvxSmA+02IXnHl4W7bNHgAKfUPCTdKq+dZgg4yD+eMgy
	 OgN2ohyctS263jFOPyk4QJ/YWun82+ZUqcan0CBOJBZZ7IVnk6ghHxkV4Ew/1hwgK2
	 vEmJyzSEQE7Vuzf5aXL0Qfy4jGi1rZ2rkUU6jy/fmqQV3PVjpZ89MkdSmkJB4R327F
	 vwf8jLWQ6nrkg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id DD14CCE0442; Wed, 29 Apr 2026 11:05:02 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:05:02 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Samir M <samir@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <022fe334-1c53-41f1-94cd-96140b2f9cdf@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
 <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
 <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>
 <ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop>
 <tte9o87@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tte9o87@ub.hpns>
X-Rspamd-Queue-Id: 7453B498937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,vger.kernel.org,linux.ibm.com];
	TAGGED_FROM(0.00)[bounces-19207-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[11];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 07:50:31PM +0200, Vasily Gorbik wrote:
> On Tue, Apr 14, 2026 at 12:24:12PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 09, 2026 at 09:03:26PM -0700, Paul E. McKenney wrote:
> > Please see below for the full patch, including refraining from queueing
> > workqueue handlers on not-yet-online CPUs and diverting SRCU callbacks
> > from not-yet-fully-online CPUs to the boot CPU's callback queue.
> ...
> > commit ce533a60b2ef29a9b516cc717e77c6b679bc09c0
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Apr 9 11:16:02 2026 -0700
> > 
> >     srcu: Don't queue workqueue handlers to never-online CPUs
> >     
> >     While an srcu_struct structure is in the midst of switching from CPU-0
> >     to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> >     have never been online.  Worse yet, it can attempt in invoke callbacks
> >     for CPUs that never will be online due to not being present in the
> >     cpu_possible_mask.  This can cause hangs on s390, which is not set up to
> >     deal with workqueue handlers being scheduled on such CPUs.  This commit
> >     therefore causes Tree SRCU to refrain from queueing workqueue handlers
> >     on CPUs that have not yet (and might never) come online.
> >     
> >     Because callbacks are not invoked on CPUs that have not been
> >     online, it is an error to invoke call_srcu(), synchronize_srcu(), or
> >     synchronize_srcu_expedited() on a CPU that is not yet fully online.
> >     However, it turns out to be less code to redirect the callbacks
> >     from too-early invocations of call_srcu() than to warn about such
> >     invocations.  This commit therefore also redirects callbacks queued on
> >     not-yet-fully-online CPUs to the boot CPU.
> >     
> >     Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >     Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> >     Cc: Tejun Heo <tj@kernel.org>
> 
> I retested it on s390 and on x86 KVM with --smp 16,maxcpus=255, all
> looks good to me.
> 
> FWIW, again:
> 
> Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Would you mind adding Cc: stable so it gets picked up for v7.0?
> 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") is what made it reproducible for us.
> 
> Thank you!

And thank you for testing it, plus apologies for the hassle!

At my next rebase, I will add the following:

Fixes: 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when non-preemptible")
Tested-by: Vasily Gorbik <gor@linux.ibm.com>

That should pull it into the needed -stable releases.

Seem reasonable?

							Thanx, Paul

