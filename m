Return-Path: <linux-s390+bounces-17764-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jc5I+qPvWnY+wIAu9opvQ
	(envelope-from <linux-s390+bounces-17764-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 19:20:26 +0100
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2399B2DF501
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 19:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D774328F435
	for <lists+linux-s390@lfdr.de>; Fri, 20 Mar 2026 18:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B838D3E0231;
	Fri, 20 Mar 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcJ0yUdj"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C9C3E0226;
	Fri, 20 Mar 2026 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030371; cv=none; b=e3/0rBS1XgGqdvfHZikRG3PWiIq8cMepeWWHznt+oA0lKg38HGDCaMFM150R6a+EgUR8xb0PSUViYXzYZb/dWj03XQhcoXE01WoY2WuMsvp+5KnkSR/ktnnpTNv81WLD0b+S/7guaC9+t8WIZosuYq9SA5ZMXcyMS2S3I/wR65E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030371; c=relaxed/simple;
	bh=wXlKT/adYsdpnI/u+Z9wPcZOZZ/MwshDM5G3iSOzys4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=poU/V/RRBTxk3ZJodfo/Nf3N1rSpdsrCZAibd5aLbYQdy/hCGRgZCYP2eVnqVgxII8qyQMQdIir1i5MBynBYYWVwEF2xhIO8DFIVtL1Cb3S3D5LzjuwtQ0hcPdJx+14IBS2gLhxIUaX+zRuSkYVae912V/pb5KwgxG5SuaacOBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mcJ0yUdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3074C19425;
	Fri, 20 Mar 2026 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030371;
	bh=wXlKT/adYsdpnI/u+Z9wPcZOZZ/MwshDM5G3iSOzys4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mcJ0yUdjm9Q2ofg9iTh+HV1T723kZiwNL9pllg96oCdleVAkQlRAzbT/w1QIL4c2u
	 3hiH89KSnsW0ogcnP+iPWKoRZdTdJ7R6l3spPdye+Q2ZtdQcL/wpHKelcCXChP5ZfG
	 dhIwt4U9wpfxioUqPdtTptZ6lwmXfTOhD70ET+QQvs9xslTLWTaBrYhd3eKXyB69gQ
	 Ol8GPniLkvn+UEeE5ZAyNx5QrMtPPCg8EmU+/lxlA+Xe6qVUKMy0tDMVwaEXR6Vyoj
	 cSl3WEFDFtkIlTJbQKffAptnuYcZ41N0oSYlkS1rEu9QNzpSFjMe8D9TehrAmHwuvb
	 1W92IyZu7aR3w==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, tmricht@linux.ibm.com, Ian Rogers <irogers@google.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
 japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
 sumanthk@linux.ibm.com
In-Reply-To: <20260318234600.730340-1-irogers@google.com>
References: <20260318234600.730340-1-irogers@google.com>
Subject: Re: [PATCH v8 0/5] perf evsel fallback changes, better s390
 defaults
Message-Id: <177403037073.155109.5895128300936871602.b4-ty@b4>
Date: Fri, 20 Mar 2026 11:12:50 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-02735
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
	TAGGED_FROM(0.00)[bounces-17764-lists,linux-s390=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2399B2DF501
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 16:45:55 -0700, Ian Rogers wrote:

> Discussion with Thomas Richter in:
> https://lore.kernel.org/lkml/20260306071002.2526085-1-tmricht@linux.ibm.com/
> showed that the evsel__fallback wasn't working for s390. These patches
> avoid the problematic frame pointer callchain on s390 and fix
> evsel__fallback from a range of problems when falling back to a
> software event. I simulated failures when developing the patches but
> they are untested other than that.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung


