Return-Path: <linux-s390+bounces-16416-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEk1LWjLnGlHKQQAu9opvQ
	(envelope-from <linux-s390+bounces-16416-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 23 Feb 2026 22:49:28 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A5317DBB0
	for <lists+linux-s390@lfdr.de>; Mon, 23 Feb 2026 22:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E2630B65A2
	for <lists+linux-s390@lfdr.de>; Mon, 23 Feb 2026 21:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8203793AA;
	Mon, 23 Feb 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3VAwrvu"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFA91C84B8;
	Mon, 23 Feb 2026 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883184; cv=none; b=PYRa2EtClxsZudiFnwDOF++pyrEr/p9KnBXdcQ9NtvxkgSyMuLtxYmYZpRy24Lr/94Whk7oVXoFQR5EIi1wOFw/8SJz/hfeX1dNSZu44XKNz3y/GAdXReEDZjNOWHCK52ITCP4wQ9ZAENc6uCdQ2uq3SI/JoJp2w+j68lWhC70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883184; c=relaxed/simple;
	bh=sXw/xuIPZ/muxOcqNvQkiUZ0xy5gHeQLJtTjwQF68l8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1auvVWUWBDbeZLEVjShSC5osuOlWyZ+uth3fvK19ymBLD1x+mu1Wts7J7T5XgT7ur9pckzC3O6QPTiGwdSWevZT5CfFZAwYvHCaaZH2iKLkefqgLfnqzweVfi6pHZx50ANC6m1+eAGixAJdwCU0/yjQzbZaUcRVLz97NSOEpJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3VAwrvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5109AC116C6;
	Mon, 23 Feb 2026 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771883183;
	bh=sXw/xuIPZ/muxOcqNvQkiUZ0xy5gHeQLJtTjwQF68l8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g3VAwrvuW9OBgR/BfYwPEupNT2r17XHju8pD7v09Np5bqkbyt52e8I5T9c106Y2EK
	 91oELYFdWdKbiKCC1uINofm7WyaoTD6fND/rNhOHjQfC+YgYm4jPQn4lILDHyMqnTx
	 S/BMiuQO5BjluSrkZ2plRnihYGsFX+T8COcM23oZWXBNu7FBpGxqMDw3Oksd1ZTrUS
	 vz8Dqs1Gm8vJdriq9se49nP4ScnvXtZZXJL2pHGTHuTLEZQ+KIX45a9+f2wVXB51QA
	 GlCsueYHAADYsRK/CIi23sF4wcEuIodlGTpl9k1FmmOtzhDq+kvusSw4HYo5MqHP/Q
	 ZaLwiuUwGc0Bw==
Date: Mon, 23 Feb 2026 13:46:21 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2] perf symbol: Remove psw_idle() from list of idle
 symbols
Message-ID: <aZzKrRB0__RahFJV@google.com>
References: <20260219113850.354271-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260219113850.354271-1-tmricht@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16416-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32A5317DBB0
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:38:50PM +0100, Thomas Richter wrote:
> Commit fa2ae4a377c0 ("s390/idle: Rewrite psw_idle() in C")
> 
> removes symbols psw_idle() and psw_idle_exit() from the linux
> kernel for s390. Remove them in perf tool's list of idle
> functions. They can not be detected anymore.

But I think old kernels may still run somewhere.  It seems the above
commit was merged to v6.10.  Maybe we should wait some more time before
removing it in the tool.

Thanks,
Namhyung

> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  tools/perf/util/symbol.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 814f960fa8f8..575951d98b1b 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -752,8 +752,6 @@ static bool symbol__is_idle(const char *name)
>  		"poll_idle",
>  		"ppc64_runlatch_off",
>  		"pseries_dedicated_idle_sleep",
> -		"psw_idle",
> -		"psw_idle_exit",
>  		NULL
>  	};
>  	int i;
> -- 
> 2.53.0
> 

