Return-Path: <linux-s390+bounces-18659-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDSPMyLq12msUggAu9opvQ
	(envelope-from <linux-s390+bounces-18659-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 09 Apr 2026 20:04:18 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75A3CE6B5
	for <lists+linux-s390@lfdr.de>; Thu, 09 Apr 2026 20:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8D70300B474
	for <lists+linux-s390@lfdr.de>; Thu,  9 Apr 2026 18:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9ED3DEFEC;
	Thu,  9 Apr 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMpNcdhs"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900C3BAD99;
	Thu,  9 Apr 2026 18:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775757850; cv=none; b=DDw2tMHwKXyETRgmF+bn9FJouxMmqzVwxYaAoAB3X4g7w/jxEtTpcO702kwaCJVysRPKzzCC2EeKm98mjUItVy7nIXz5mrvbkMWv4HSKw56D7zsVQ7djYRK+CCzdNVd6+2hMSygtYkwKfbsOTdhhOfMhiiGYvBbQfXY6/5qxtwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775757850; c=relaxed/simple;
	bh=d8AIbs48DsB7I9rlxqCE2S7rRppl9jBjYD/LxBFZ8ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1mLrXT0v9ZNHU6q/E6mPwCoqkWMP4yVp5cRUEkhtvhWqXywIPnNX8YPWMdRuwF79y465TziO0Cx8lM2CkT4e4QaWmAtvM44mlAhIPbSj5Q/v8awqmS9B3NKa5NMgnYwK8oHjcsJY4nZ85kv9l/eJ5zKVmvnhIpXDO2BZfHfvt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMpNcdhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C93C4CEF7;
	Thu,  9 Apr 2026 18:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775757850;
	bh=d8AIbs48DsB7I9rlxqCE2S7rRppl9jBjYD/LxBFZ8ZA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lMpNcdhs4ql5b91jzVP+0IVBS/9KHXgsm4YzfjyegE3/q1mcGbiCBbOoGX36l47S/
	 fc7IiTQg6+STPDSu4M+ORYEYq4BIsNoNK4VdZOGfZXu82JuMRTtmJEABo01RM10k3q
	 aBIXFYK/8aHLVV1ST9gdNyZLqy9YVDh32U9+B9E/e7zjvv1KQz0m+WWAjZ2r3WkBrN
	 ukEOIe9gfeS+YvQjYn3IUxN8GNb52UqZLhMDcLzPF6qfr6IkcyR53TG0kDGC5ESttr
	 jhyja/faoEXDeKCuecLKWyWhQrpHpEolzyH7GrnndApBpIQYdLif1/IdorXRBgafHl
	 SjqEBmmZMrHiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 7AB3CCE0975; Thu,  9 Apr 2026 11:04:09 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:04:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <3e18247d-ef19-4963-8257-a0f4494f992a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfmbO1nxSwHvtHx@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfmbO1nxSwHvtHx@slm.duckdns.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18659-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulmck@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	HAS_REPLYTO(0.00)[paulmck@kernel.org]
X-Rspamd-Queue-Id: AF75A3CE6B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 07:48:28AM -1000, Tejun Heo wrote:
> On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> > On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > > 
> > > > [Cc workqueue]
> > > > 
> > > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > > unbound one hence there are still workers?
> > > > 
> > > 
> > > Ah, as Paul replied in another email, the problem was because these CPUs
> > > had never been onlined, so they don't even have unbound workers?
> > 
> > Hahaha, we do initialize worker pool for every possible CPU but the
> > transition to unbound operation happens in the hot unplug callback. We
> > probably need to do some of the hot unplug operation during init if the CPU
> > is possible but not online. That said, what kind of machine is it? Is the
> > firmware just reporting bogus possible mask? How come the CPUs weren't
> > online during boot?
> 
> Just saw ibm on the cc list. Guess this was on s390?

It was indeed.  What workqueue tricks does s390 play?

							Thanx, Paul

