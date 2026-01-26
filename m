Return-Path: <linux-s390+bounces-16053-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGuDMOLPd2mxlQEAu9opvQ
	(envelope-from <linux-s390+bounces-16053-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 26 Jan 2026 21:34:42 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD9C8D1C2
	for <lists+linux-s390@lfdr.de>; Mon, 26 Jan 2026 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F9423008C18
	for <lists+linux-s390@lfdr.de>; Mon, 26 Jan 2026 20:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C102D6E75;
	Mon, 26 Jan 2026 20:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5oE0pSP"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE92C235E;
	Mon, 26 Jan 2026 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769459681; cv=none; b=K3g3fht1IxDwVJEZAShQY20ZBOU2W/dWwHwYzK6dqpfG5PXK7De6MPCat+kRFzkvZICb/1TmnsfgLSaSuS16o4l7rUoqWcYYRqS1pIieut8A4sGeA5YE/gAur+QuuLDxJdal73R5UMmx+0pKPbQU7uh5h15kmYaf4oRyo5+1DHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769459681; c=relaxed/simple;
	bh=0DaUJEWw095etmaVpAYNdkX2gtyRy/7Z9hThXSMPvVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0C3Oms4alkwUfsH1LsofAX08okwo5QSBjxGcHZE8DJBUn/na4RRJIzMf4KYzeI6fHEs3OM/h71OVbVOiyyPSmQXGGB1+gBAOLjh48YYnctI61Uge4poQdnS9iKLpymG4RSRCWcpzfaN9onMEIus7K/OVc8+eu3eZnhJkTq/mYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5oE0pSP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353F9C2BC87;
	Mon, 26 Jan 2026 20:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769459680;
	bh=0DaUJEWw095etmaVpAYNdkX2gtyRy/7Z9hThXSMPvVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i5oE0pSPRjjAMJarHMW4ZM3DN+qiRdLKyWu5aFpTypspaKZrbNCV+6SVpBhd8HoeN
	 xs+pDTm6SUTpsdK+i2Fj6dg7GgLJaJCBIxI2LD7lC6QcAtzwEilzAPl9aBDWr+4NTG
	 pgpy2PHstfM7cqk4nePRLEEZJRtMZZbUls/5ai0fOLVu816Qt14IAsCDvbernF2rCS
	 zdf21NmlC4nr1RMIeFHbCkAUuZ/cgwS3Mxkhep99DIiETZuyiSEV/UZfUp9WHcRjyp
	 W6qebzXtUvcDUqusab5YB0oAseJflzqZp+LJ47e5maFCujooRPR3yYgT92ZZqaB/Bd
	 qajk8fGUQNWxQ==
Date: Mon, 26 Jan 2026 17:34:37 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org,
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com,
	sumanthk@linux.ibm.com, hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH linux-next] perf test: Fix test perf evlist for z/VM s390x
Message-ID: <aXfP3avz62ZM14bE@x1>
References: <20260126101823.2090077-1-tmricht@linux.ibm.com>
 <CAP-5=fXPGXJMDPQc4XxrEWW_HgJTbrbL6g1xfTBn14jDiW0Yxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXPGXJMDPQc4XxrEWW_HgJTbrbL6g1xfTBn14jDiW0Yxw@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16053-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acme@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FD9C8D1C2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 09:42:54AM -0800, Ian Rogers wrote:
> On Mon, Jan 26, 2026 at 2:18 AM Thomas Richter <tmricht@linux.ibm.com> wrote:
> >
> > Perf test case 'perf evlist tests' fails on z/VM machines on s390.
> >
> > The failure is causes by event cycles. This event is not available
> > on virtualized machines like z/VM on s390.
> > Change to software event cpu-clock to fix this.
> >
> >     Output before:
> >       # ./perf test 78
> >       79: perf evlist tests              : FAILED!
> >       #
> >
> >     Output after:
> >       # ./perf test 78
> >       79: perf evlist tests              : Ok
> >       #
> >
> > Fixes: b04d2b919912 ("perf test: Fix test case perf evlist tests for s390x")
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Tested-by: Jan Polensky <japo@linux.ibm.com>
> > Reviewed-by: Jan Polensky <japo@linux.ibm.com>
> > Cc: Ian Rogers <irogers@google.com>

> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next,

- Arnaldo

