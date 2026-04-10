Return-Path: <linux-s390+bounces-18674-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JvVCZJ22GkxdggAu9opvQ
	(envelope-from <linux-s390+bounces-18674-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 06:03:30 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C223D1FFA
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 06:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C12B3300A316
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2026 04:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D02D877A;
	Fri, 10 Apr 2026 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTwwOmCn"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506FE226D02;
	Fri, 10 Apr 2026 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775793807; cv=none; b=u3ZhcUB1hApMfkL46mXStqCOR7LgD66yjQvq8btHtK2tXfWEpEb0r4gRRtB1IR9XQWQzLwIlDe/aDOwPubenep9eY1DCZLkth5CrPp7hYIYBBTiwDchRetG/3ZT4nezw0qhtp8CMuouEohRkA3bA2cF7X5YTIvFdNtuQNIweIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775793807; c=relaxed/simple;
	bh=51gwcxxKbsjSJ6P62E9+lQxS4sAO3RkltN35sl+FeeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQwYexXMj82/eNeLM2pmeg8E3ZpE62u4NNroVUDLsUZc8H2Np81yfpHsQ1bg7oDJDZIT+TmyO+BQn0lV07cWWyfBBDKrV1hHenO5j+oHEkc4B534kMiTPHN+CkCZlD7csUi14eaZz/ekCxkX5sZOuE0SGKd2VaxAyqsJd119TBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTwwOmCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C811C19421;
	Fri, 10 Apr 2026 04:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775793807;
	bh=51gwcxxKbsjSJ6P62E9+lQxS4sAO3RkltN35sl+FeeU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ZTwwOmCnHfyE7+bkzJjaVbyBp//sWA5e2AFZUXxy5G3DKNg9Tu0PzK3D3lmRHQWy5
	 VLUBqwcrSoDj71l1yXCr/g3qrMMMD1DkW4RWr0KsQkvXgpZ7PjX8Xbdy3cVZ+pUa6v
	 fBgr85oLlCLpzanZt7NB0FXY+lhkfXF/57a2HlS6FS4Ag07r7XjghK0extDGahYe3B
	 6BCIC9iU/C+AHQOyDBNuWKiVu8sHhd07IqQ/W+rlsvzYpX9BRESwqyJzUEVjsIBp/j
	 l0tQNSCgNX1JN7QtgqjzCwHl3+rzlNSLN/wTG/uNjRZWQ+ucLtD0uzwvritOStwh4G
	 B00dAH3dKVLKw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9E2DCCE0975; Thu,  9 Apr 2026 21:03:26 -0700 (PDT)
Date: Thu, 9 Apr 2026 21:03:26 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
 <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18674-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[9];
	HAS_REPLYTO(0.00)[paulmck@kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B9C223D1FFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 01:10:14PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 09, 2026 at 09:15:50PM +0200, Vasily Gorbik wrote:

[ . . . ]

> > Yes, tested on s390 LPAR (76 online, 400 possible) as well as
> > on x86 KVM with --smp 16,maxcpus=255 and CONFIG_NR_CPUS=256
> > no more workqueue lockup in both cases.
> > 
> > Thank you!
> > 
> > Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> 
> Thank you for testing this!
> 
> Please see below for an updated patch.  Tejun's patch might obsolete
> this one, but just in case he balks at SRCU queueing handlers for CPUs
> that are not even in the cpu_possible_mask.  ;-)

And because we don't invoke SRCU callbacks on CPUs that are not yet fully
online, such CPUs had better not invoke call_srcu(), synchronize_srcu(),
or synchronize_srcu_expedited() on a CPU that is not yet fully online.
I am therefore adding the warning shown below.

Better paranoid late than paranoid not at all.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index a67af44fc0745..d62509efb52f5 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1431,6 +1431,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 static void __call_srcu(struct srcu_struct *ssp, struct rcu_head *rhp,
 			rcu_callback_t func, bool do_norm)
 {
+	WARN_ON_ONCE(!rcu_cpu_beenfullyonline(raw_smp_processor_id()));
 	if (debug_rcu_head_queue(rhp)) {
 		/* Probable double call_srcu(), so leak the callback. */
 		WRITE_ONCE(rhp->func, srcu_leak_callback);

