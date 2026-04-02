Return-Path: <linux-s390+bounces-18501-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DNLOtTmzmkRrwYAu9opvQ
	(envelope-from <linux-s390+bounces-18501-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 02 Apr 2026 23:59:48 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642738E90F
	for <lists+linux-s390@lfdr.de>; Thu, 02 Apr 2026 23:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0963308871B
	for <lists+linux-s390@lfdr.de>; Thu,  2 Apr 2026 21:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329D38A73D;
	Thu,  2 Apr 2026 21:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A35AfRKe"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F55B38A738;
	Thu,  2 Apr 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775167052; cv=none; b=aXlB8VVkiRxU1kFH+evEDuKCXP5KkT0r92YNfM3SXDCdlb3d8I71yCGIiTRSAGkY4s+856QTwwS7C0wgU6zYmf3UigLWhmjCOJCWUFsOF1n09Dnq+a54RD3qCuttbLZa9pdH1bbbX736jRs5TEBiiJ+N9mXX6yWEIMS2btOG93s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775167052; c=relaxed/simple;
	bh=d/VNN2TaVfpjmuvxsRrmtlWax3Pf5gh13PmPiBpNiVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R4//+1KhOEgNqxSl8yX19qsydL0PsUPTzjHx5JqKW3MByzXr6zkZougVcZg2xJYojkWBEKZya3892cvtWqPZedbId+gmO2GNqdnh+DIJ9LZR/FKI71sWw8+665o+jxgiCakkQ81btZjY/vUyFiN1cCwvv98JSOKtDcdAaiFO8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A35AfRKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79929C116C6;
	Thu,  2 Apr 2026 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775167051;
	bh=d/VNN2TaVfpjmuvxsRrmtlWax3Pf5gh13PmPiBpNiVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A35AfRKewSdj+eO0dT6tXRBrFd+C2HoauoBBZ4GUaaMLEKJE/rD/E0jP0wyVOhQru
	 Qa0VfV/B4JGmPhpygmTOEOiq9ueMV0lmRPWWkESjGjgE+kBuCYxTCvppJPP1ct1Q2M
	 Vn007ogjHn0gNxGfGlZ53u4rtoWmVCrTr79iekDF0aIVmaqBADzXBYMGrgpu6h7MEz
	 3bLB4bdH4UOZTNa/Yz1RpzuqBctPu0hDrp2z4VSul1xGkTSvGWfZK8+41uSnO3tMxR
	 eQ0oUfL/e9zpF8JnnCd/k3iS/pvpMJ1oFI7xugxSLJTL5VPV96Xc9wuI1A1CPZAKR+
	 H3AWa/dplSHIA==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, acme@kernel.org, irogers@google.com, 
 Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
 hca@linux.ibm.com, japo@linux.ibm.com
In-Reply-To: <20260401122102.30737-1-tmricht@linux.ibm.com>
References: <20260401122102.30737-1-tmricht@linux.ibm.com>
Subject: Re: [PATCH v3] perf test: Skip perf data type profiling tests for
 s390
Message-Id: <177516705145.1014987.18278317117378120291.b4-ty@kernel.org>
Date: Thu, 02 Apr 2026 14:57:31 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18501-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7642738E90F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 01 Apr 2026 14:21:01 +0200, Thomas Richter wrote:
> Test case 'perf data type profiling tests' fails on s390 with this
> error:
> 
>   # ./perf mem record -- ./perf test -w code_with_type
>   failed: no PMU supports the memory events
>   # echo $?
>   255
>   #
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung



