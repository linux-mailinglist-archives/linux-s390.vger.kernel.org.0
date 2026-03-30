Return-Path: <linux-s390+bounces-18318-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIG/EP/IymmL/wUAu9opvQ
	(envelope-from <linux-s390+bounces-18318-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 30 Mar 2026 21:03:27 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C8360185
	for <lists+linux-s390@lfdr.de>; Mon, 30 Mar 2026 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C99F3300E68A
	for <lists+linux-s390@lfdr.de>; Mon, 30 Mar 2026 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BABF2FDC57;
	Mon, 30 Mar 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SIPOM7xF"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4935E1C3F31;
	Mon, 30 Mar 2026 19:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774897400; cv=none; b=LRk+S6nBkw5JDc5/YEGRSgHCR6ng8EuiN3oK8RuzPn5/XQbuJ78dVNZ7HbR63uGMiq/fu7msta37/3lgKTP/NXrSxDHJvxPv27YAqMiBoB2yVJa7B/DAXj/FuTymm2HF+OU3u60NZYnzSyomV9XJ9mtvRwb5eEezdb0OthPO6lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774897400; c=relaxed/simple;
	bh=bYoBpf9mMwP/A8V7PLvxT4p0yP3S1B/zELC0UR3Nn7o=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WoS8LGt4H0FwZP9e5M28twOW8X6ekq/LP6qhKNUWT9ejCczn80KqGKdF2Sdv+84RHcjOhc/eFHOWJ8Nrt9/VdVo8XwC9NCY9AamFiyaVKHxKO5FvOdfU9SwwD0yUnWFPppdq4dCGeDRho5jGyUe0VGpsCu27aP8MYO96gnIFReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SIPOM7xF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67614C4CEF7;
	Mon, 30 Mar 2026 19:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774897399;
	bh=bYoBpf9mMwP/A8V7PLvxT4p0yP3S1B/zELC0UR3Nn7o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SIPOM7xFPJM7CrHXXiyNKv84sJFnXFhGPo0qbVxnJG61dZY7p4Eb7Ci/76pw2+X7f
	 E2hoUm9F5YJbTXrpgwLJBvEGXpCZ2fhj7BAAj6icy5xB1xulFPO9GwscEcy/c8C+69
	 4XJlWIr0ODjMmsDi9uH5naeTYGTi7f5yFJcWbdL8=
Date: Mon, 30 Mar 2026 12:03:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand
 <david@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed
 <yosry.ahmed@linux.dev>, Zi Yan <ziy@nvidia.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Usama Arif <usama.arif@linux.dev>, Kiryl
 Shutsemau <kas@kernel.org>, Dave Chinner <david@fromorbit.com>, Roman
 Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Alexander
 Egorenkov <egorenar@linux.ibm.com>
Subject: Re: [PATCH v3 7/7] mm: switch deferred split shrinker to list_lru -
 [s390] panic in __memcg_list_lru_alloc
Message-Id: <20260330120318.3499796039de007752554cea@linux-foundation.org>
In-Reply-To: <4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
References: <20260318200352.1039011-1-hannes@cmpxchg.org>
	<20260318200352.1039011-8-hannes@cmpxchg.org>
	<4d3f8d79-3593-47df-9de8-f94f7f09a403@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18318-lists,linux-s390=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:dkim,linux-foundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 403C8360185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 18:37:01 +0200 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:

> with this series in linux-next (since next-20260324) I see a reproducible panic on s390 in the
> dump kernel when running NVMe standalone dump (ngdump).
> This only happens in the 'capture kernel', normal boot of the same kernel works fine.

Thanks.  It seems that hannes is working on a significant respin, so
I'll remove this version of the series from mm.git/linux-next.


