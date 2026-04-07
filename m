Return-Path: <linux-s390+bounces-18558-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHmICfey1GnvwQcAu9opvQ
	(envelope-from <linux-s390+bounces-18558-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 07 Apr 2026 09:32:07 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C24A13AACE5
	for <lists+linux-s390@lfdr.de>; Tue, 07 Apr 2026 09:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 81C88300DF73
	for <lists+linux-s390@lfdr.de>; Tue,  7 Apr 2026 07:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA910260580;
	Tue,  7 Apr 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvSsjwjn"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73941A680A;
	Tue,  7 Apr 2026 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775547074; cv=none; b=nabbX0xfvuxNwneDWCTs6ggvRFQvBpw5brcz8pwqwp4ojAFEr9puLCMX4ksC8NRsOLO7G8Zvkxo+8NgCg7kW4AdUG8p9OlmhWkYR24BOqX4moZ5hcqCbELPJhS3T7JxSerYGZHeq3YDT4tMfkom00XlJJBRxx85FGPWIgKwjkD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775547074; c=relaxed/simple;
	bh=NVDjMQFgmAHBxYp6kLgV8qFIBBwD3Y23WHMoI9o3Px0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fj4q5wjHhbjVddxLP/72O1lVDR3kpl8AkQq6e2z6/8NazTXS1yKVaA/lGE5AuM9URLLZ5fG5goqEMG8cORAD3KfAKVNQzbtpCYuzPtqL1sBWIoqNTQh75hFC3bVqhKvVkf1z9L3/slXb59OoTCJ6P3rrF06nWN41Mh8IeEtcFY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvSsjwjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6E3C116C6;
	Tue,  7 Apr 2026 07:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775547074;
	bh=NVDjMQFgmAHBxYp6kLgV8qFIBBwD3Y23WHMoI9o3Px0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvSsjwjnEd/nLeIBTUqjj052QUtXDNyVzqPFAv4cQ3Mb7s1OlKGUHKPBM9xO65o9M
	 sDG9ObxZotUfLNZtXbjFGt0Ynj6MJWeR6qGVhBbAQpEVxuP4s8KPBm+OdnmW+xL0us
	 79DIMJkf/LUAxE/1Bmu15qHuBiiDKVDarsv+sS9FTzF5u+7xV4OecGdjAGuTdaTAKE
	 ZrLOF/yQ+Oiil3EVomPhA3IeEv00/oAzNWyWZLCXIEhHQ/HaW+s7veeWQyWG1mgfGO
	 835chDGj2cmP1iocHf/Io2oHtdFLNKvPPsz3HKxv368nTNGtC3mV81mu/itT6XbVt+
	 61iPrjQZMnr3w==
Date: Tue, 7 Apr 2026 00:31:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	irogers@google.com, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH v2 2/3] perf config: Make
 symbol_conf::addr2line_disable_warn configurable
Message-ID: <adSywBZXvrFUFlQD@z2>
References: <20260402080159.2028733-1-tmricht@linux.ibm.com>
 <20260402080159.2028733-3-tmricht@linux.ibm.com>
 <ac8h9ypRe4nHUu5q@google.com>
 <72f255b9-8480-4e5b-be42-b8a185e4c5dc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72f255b9-8480-4e5b-be42-b8a185e4c5dc@linux.ibm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18558-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C24A13AACE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 07, 2026 at 08:58:54AM +0200, Thomas Richter wrote:
> On 4/3/26 04:12, Namhyung Kim wrote:
> > On Thu, Apr 02, 2026 at 10:01:58AM +0200, Thomas Richter wrote:
> >> Make symbol_conf::addr2line_disable_warn configurable by reading
> >> the perfconfig file. Use section core and addr2line-disable-warn =
> >> value.
> > 
> > I think it's better to have it under "report" or something.  But it
> > seems we already have one in the "core" section.
> > 
> 
> ...snip...
> 
> It was added to the core section of the perf-config file by this patch:
> 
> 
> commit 701677b95764 ("perf srcline: Add a timeout to reading from addr2line")
> 
> submitted by Ian Rogers in 2023. That is the reason why I left it in this section for
> backward compatability.
> We could also move it to the annotate::* section. What do you prefer?

I think we should keep it under "core" to be compatible.

Thanks,
Namhyung

> 
> I will add the other remarks in the new patch v3.
> -- 
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
> --
> IBM Deutschland Research & Development GmbH
> 
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
> 
> Geschäftsführung: David Faller
> 
> Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294

