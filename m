Return-Path: <linux-s390+bounces-20744-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nMaFHb/DKWrZcwMAu9opvQ
	(envelope-from <linux-s390+bounces-20744-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 22:06:23 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9466CB00
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 22:06:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oPpki4Xm;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20744-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20744-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C206316AF30
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 20:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B638637E2EC;
	Wed, 10 Jun 2026 20:02:38 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1B4380FD3;
	Wed, 10 Jun 2026 20:02:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121758; cv=none; b=YqAFDpvUuzJyViEsYS9qBgN7g96xL5wG+fUqgDbAHupv0YwX4GZ+veYO4YCA7RLGo5wRSRLBcT45iHbt9qrcNM/nvXxqmtqel67iHCVYBHlr9pyHj72b4z7E15AceNsS/h64+bAPs9IiB2yLc996qqRC2womglxsU3xjfdkQK4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121758; c=relaxed/simple;
	bh=T/p6HC9Q8a8aAajkOkGveF6+nf0tnC0RM+WxpJEYHz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTr8qWbO+6HDzFcqUypox1sMAiZSErWLYOjIbnqdZAytMKmzurhF9+H8RuPiIcYA6c1EKQyNZE3nyXi37PpTczDCnG/BHpIr+oVGpaWRB4ubNXQB66/f2jur6mz6CUaaSRsYlT8wLj8eNGOBN5FGKFbSHiOvY0Zq8BFd6+k4kY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPpki4Xm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB0B1F00893;
	Wed, 10 Jun 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121756;
	bh=DGzsYpWYnSJv1ZTA52um4ym6YqhaLGbJSog82pKYXgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oPpki4XmIs7Xk0tj5HrlUWuFrB8BddyBZmz35xzsBSyFG9dK2NwYK5W3pRZVIcOM3
	 mgKejYvYxq1f0s2Gi3/5b0R1EaN20GllkjYqXw3zPfIQsHIthecmNR5wP85oGtcHMZ
	 j62efuPH83VAy2GhGiD+ICSoBf5LChPKmVJuFpWEGwjNsTk2djrkOwj33yr84QgsCy
	 Bd30tevnbLif0C9yTWOsdAICIa85H6qWjKPGJhZLAWd6FMPs0mHxs2AOwQyV0XSpel
	 6a0E935yiQ4zVkYZgTr6j1gSrr6ok9kr2UriYhd9VXcIiFJX2k/fHvpyb3Eti9h5wn
	 /xQ796b8yq9fw==
Date: Wed, 10 Jun 2026 17:02:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf build: Do not duplicate CFLAGS in Python extension
 builds
Message-ID: <ainC2J-eMxlcUSjC@x1>
References: <20260610112344.1550111-1-jremus@linux.ibm.com>
 <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:james.clark@linaro.org,m:jremus@linux.ibm.com,m:japo@linux.ibm.com,m:tmricht@linux.ibm.com,m:brueckner@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-20744-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linaro.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8F9466CB00

On Wed, Jun 10, 2026 at 02:38:24PM +0100, James Clark wrote:
> 
> 
> On 10/06/2026 12:23 pm, Jens Remus wrote:
> > setuptools already uses CFLAGS.  Passing CFLAGS with additional flags as
> > extra compile arguments causes CFLAGS to effectively get passed twice:
> > 
> > $ make -C tools/perf V=1 JOBS=1
> > ...
> > building 'perf' extension
> > gcc [CFLAGS] -fPIC -Iutil/include -I/usr/include/python3.14 \
> >    -c /root/linux/tools/perf/util/python.c \
> >    -o python_ext_build/tmp/root/linux/tools/perf/util/python.o \
> >    [CFLAGS] \
> >    -fno-strict-aliasing -Wno-write-strings -Wno-unused-parameter \
> >    -Wno-redundant-decls -Wno-cast-function-type \
> >    -Wno-declaration-after-statement
> > 
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

