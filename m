Return-Path: <linux-s390+bounces-17719-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMKMOGK9vGlz2gIAu9opvQ
	(envelope-from <linux-s390+bounces-17719-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:22:10 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A12D583C
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 04:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87A353081B11
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C43923EAB3;
	Fri, 20 Mar 2026 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XCGRZxSu"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2E813959D;
	Fri, 20 Mar 2026 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773976721; cv=none; b=GUFnWz8LVcXovqse64oM6N5m7QGfNkHZF2LDERn7VCCdfgqe/jWYD6PvQsAA3Cut90KCyMTzOi2SanrtXDFR4xNbnHXRJdmubLy/6bxk+PkPgnFKYWULrfuQAeZlU6r/DSZEa1DssJmOFCZR8UCKaXkHhM1foMXAuzpIoSPURnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773976721; c=relaxed/simple;
	bh=RnWaFWKleytYk2xnMbn6rVyzIPDB56jqJgJOybkNp58=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KCoe+uwmK1mlAIbRT6HSLXrwASqtO2URLHdz1d8fXu1TMTNwBDOW8j2FuU9+M4oxTNHH7LM7iLT1PB4vaoKCPLcbaFhVI9ZDnHTvpAY1ltHWUgMjEbqcJqk2wkyrpAasvvivJ3qTnlIVjBk5E1OPmtk3MdTECry15UmHu8QdRyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XCGRZxSu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A21BC19424;
	Fri, 20 Mar 2026 03:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1773976720;
	bh=RnWaFWKleytYk2xnMbn6rVyzIPDB56jqJgJOybkNp58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCGRZxSuX7NB0ciVsWAd9qvBv9OyQ8YLbS1a+8P3iOs92SF02WGeSPOmDhHZYN8k3
	 2ERRZEycezU/gQTEFoNqad93hDeICz1JmYWv2WgOP9VeqK4G40VWziMGpyao6ozqpE
	 +lt/ohK+PFKlyJD2wClCMFCru8H2uNJzFHowMP6w=
Date: Thu, 19 Mar 2026 20:18:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: david@kernel.org, ljs@kernel.org, Liam.Howlett@oracle.com,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org (open),
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] change young flag check functions to return bool
Message-Id: <20260319201839.2dfa704041b8f13d8dbbfd3b@linux-foundation.org>
In-Reply-To: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17719-lists,linux-s390=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linux-foundation.org:dkim,linux-foundation.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 9C0A12D583C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 11:23:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> This is a cleanup patchset to change all young flag check functions to
> return bool, as discussed with David in the previous thread[1]. Since
> callers only care about whether the young flag was set, returning bool
> makes the intention clearer. No functional changes intended.

One observation from Sashiko.  Minorish, worth addressing:
	https://sashiko.dev/#/patchset/cover.1773890510.git.baolin.wang%40linux.alibaba.com

