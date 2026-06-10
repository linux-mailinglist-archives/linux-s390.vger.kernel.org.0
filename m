Return-Path: <linux-s390+bounces-20745-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NCYtCojDKWrKcwMAu9opvQ
	(envelope-from <linux-s390+bounces-20745-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 22:05:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC0E66CAF1
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 22:05:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FbLkmAAQ;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20745-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-s390+bounces-20745-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860E0302F438
	for <lists+linux-s390@lfdr.de>; Wed, 10 Jun 2026 20:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D303939D3;
	Wed, 10 Jun 2026 20:05:23 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF45331EA4;
	Wed, 10 Jun 2026 20:05:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121922; cv=none; b=QlFEbEwRU1gf6O1Mfz+DjqxM44Mxx7W5LzhP9Ulrw75XdrSb3zWj/+3MLqL2UEXsBUcj85NvSRZwb06zfxxAaK+8Ggvzqwlb7VqJiSj859P2sydZ3mv6nDT0uFY4pvbHaSI2vu93jc8+4QWj8EYhEN67cpf7Q1qEnlg+Hlqk3uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121922; c=relaxed/simple;
	bh=0qffO1zeu2Z9/a9U08SC9vhlvpitayQOghPrLhC3RsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aq7eirkO6xdzfKR53QLyQdk+s0nUS3FXm3ta7myCWA+a5HULk5IJp0NY1hxFu43wRGcz1iXHZMKSQ3OpxKdyex28Wr4JVbHV4MSInmMj8Vm6F7xkH+a2BbMoBSPa/e39kO3EICTHTeByHkQYKjmSUzK9FSSS1xNTz88GuAi0I10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbLkmAAQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F11F00893;
	Wed, 10 Jun 2026 20:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121917;
	bh=7rT/ne9euQ4wOGv70UqHVlvjkpEYBAEsUF0ZfhZ9MKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FbLkmAAQmr/99HzdzKV9wQmVC+rryW7qzAIxJYpi0D3faZSDq4x7EqBjjkG3c/56G
	 JUde8Tcs/cQdiN1bzwtVVPfCdI69HYmew7hqyFJ9xuKpnDRyXjB2jdDwYRacPL7F6q
	 4L9Mz4HwVpzvaC0v7sjfbCey/RftHjPqPRFKXUgs+VJ8VsUU9bbRsBV3/8BkYB2EnN
	 TiHNvNb8DfAUiO6BleY1qXBGDbDeAsDpMdgWjVysjlUadNKWXedY0CuIIptOdXjADx
	 9DyfK2xHcF1/nOWR6WV28sSkW7ZfE9sRfCCaFuTCrW70aPzLoIkI/gmDUedXJUNXLS
	 mB0cRQob0hjKQ==
Date: Wed, 10 Jun 2026 17:05:13 -0300
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling
 as PIC
Message-ID: <ainDeXsfPw0mwXe4@x1>
References: <20260610112451.1553054-1-jremus@linux.ibm.com>
 <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76b93d7-89bb-483a-80dd-59e3dbf921a3@linaro.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:james.clark@linaro.org,m:jremus@linux.ibm.com,m:japo@linux.ibm.com,m:tmricht@linux.ibm.com,m:brueckner@linux.ibm.com,m:hca@linux.ibm.com,m:linux-s390@vger.kernel.org,m:peterz@infradead.org,m:mingo@redhat.com,m:namhyung@kernel.org,m:mark.rutland@arm.com,m:alexander.shishkin@linux.intel.com,m:jolsa@kernel.org,m:irogers@google.com,m:adrian.hunter@intel.com,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-perf-users@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20745-lists,linux-s390=lfdr.de];
	FORGED_SENDER(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,infradead.org,redhat.com,kernel.org,arm.com,linux.intel.com,google.com,intel.com,gmail.com,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linaro.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC0E66CAF1

On Wed, Jun 10, 2026 at 02:39:10PM +0100, James Clark wrote:
> On 10/06/2026 12:24 pm, Jens Remus wrote:
> > +++ b/tools/perf/Makefile.config
> > @@ -109,6 +109,7 @@ endif
> >   ifeq ($(ARCH),s390)
> >     CFLAGS += -fPIC
> > +  CXXFLAGS += -fPIC
> >   endif
> >   ifeq ($(ARCH),mips)
> 
> Reviewed-by: James Clark <james.clark@linaro.org>

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo

