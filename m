Return-Path: <linux-s390+bounces-19284-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF6PGIYY9Wm+IQIAu9opvQ
	(envelope-from <linux-s390+bounces-19284-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 23:17:58 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BF624AFC48
	for <lists+linux-s390@lfdr.de>; Fri, 01 May 2026 23:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 496C2300514F
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2026 21:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532536BCC3;
	Fri,  1 May 2026 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBCThL0Z"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016E3369203;
	Fri,  1 May 2026 21:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777670273; cv=none; b=RT8OOp0LLGhTAbsUNoKZpDhlj6oc8q9TRyhiUg9VBx5IVXiRLug9EB3c/GTtC8KuQfbS3rkTOgvvgntx4fEQr7uqhynpoCdvkHsutYxPCMadTU8kRoo+ljKEysK1uYgCNk3ByxG9ZKB0uADHGbIsD6sC3cWG9hsjUGkm9CB+tdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777670273; c=relaxed/simple;
	bh=vlOkMj8GrldfLKQy/WTdxUydoj8upb7F0jPdovFF7F0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8hLSvv+l1aZNp/YFKWuIgcDXnQXny0DFQYPjd1JkTIttIuEVMg0U1o/XiKEkWYV8C7pV8lAAK59bALQwyOQDkaIT0TONv6x81TtLdLRz4c4dKqLlfB2U3CJS+YZwuIW58//g3L79ji2aT45QH+BXKektT2utBsURG6QFPKTCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBCThL0Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3201CC2BCB4;
	Fri,  1 May 2026 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777670272;
	bh=vlOkMj8GrldfLKQy/WTdxUydoj8upb7F0jPdovFF7F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBCThL0ZUOciVlUdDPlkZOk2cwVOOm8Tbr2iNkMf1UGQrhNwVAoYKLFZTpPGFIugP
	 CqIPbpV2kLYCf98CGWmWPPj6kC5jgCpM6j2ptLOpMUKKF3lFhrXG1YmCUhVoADAayI
	 kJl0abVkEp8vQhV144UzJ7SeaBM5+Nrw3EneesVRY12GOeH95mQQuElzJpImNe8ygq
	 ZIwcBr2eGznEeLx7R3QktlCeMAd6ttF4Ov8uCuxvX/cvkctsDe/NY8BkUl7IBTC+EY
	 FEPU5ZI3zs5pRja1ojW9ao3vP6IaxyzGTCsDFql6UajD++8QUl6QYku9G8t22L60lr
	 ElPjU2QMNNO7Q==
Date: Fri, 1 May 2026 14:17:50 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>, Christian Brauner <brauner@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <afUYfpwWsUQoB9hz@google.com>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afMnKrYT0xG_a-b3@tiehlicka>
X-Rspamd-Queue-Id: 5BF624AFC48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-19284-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minchan@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Thu, Apr 30, 2026 at 11:55:54AM +0200, Michal Hocko wrote:
> On Wed 29-04-26 14:13:59, Minchan Kim wrote:
> > This policy differs from the global OOM killer, which kills all processes
> > sharing the same mm to guarantee memory reclamation at all costs (preventing
> > system hangs).
> 
> Incorrect, we do the same for memcg OOM killer as well. This is not
> about preventing system hands. But rather to 
> 
> > However, process_mrelease() is invoked by userspace policy.
> > If it fails due to sharing, userspace can simply adapt and select another
> > victim process (such as another background app in Android case) to release
> > memory. We do not need to force success or affect processes that were not
> > targeted.
> 
> This is a wrong justification for the proposed semantic. You seem to be
> assuming this is just fine rather than this would be problematic for
> reasons a), b) and c). If there are no strong reasons _against_
> following the global policy then we should stick with it. There are very
> good reasons why we are doing that on the global level.
> 
> If for no other reasons then the proposed semantic severly criples the
> shared MM case. You are left with a racy kill and call process_mrelease
> approach. You certainly do not want to allow a simple way for tasks to
> evade your LMK, do you? So just choose something else is a very bad
> approach.
> 
> So unless you are aware of a specific reason(s) where collective kill is a
> clearly an incorrect behavior then I believe the proper way is to kill
> all processes sharing the mm (unless you are crossing any security
> boundary when doing that).

I agree that in the case of a global or memcg OOM, the kernel deals with an
emergency, system-wide crisis where killing all sibling processes sharing
the same mm is an absolute necessity for system survival, bypassing
user-space privilege screening.

However, process_mrelease() is an explicit user-space initiated system call,
and I am still hesitant to place that same raw, destructive policy blindly
at the UAPI syscall level even though I don't know of any known security
issues right now.

If we really want to go that way for the collective kill, at least, we should
evaluate signal authorization (kill permission) against *every single*
sibling process beforehand instead of only the target task of
process_mrelease. Do you agree?

Also, I wonder what the signal/process maintainer thinks about this approach.
Christian Brauner <brauner@kernel.org>?

