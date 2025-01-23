Return-Path: <linux-s390+bounces-8600-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 844AAA1A73D
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 16:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C26A18832C7
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8C0211463;
	Thu, 23 Jan 2025 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hl6Hcs/W"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4632220E707
	for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2025 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737647010; cv=none; b=Bly+XYu0mZuh1peAPd4yHqrbedpQ+k/pEn2TOtDCRRdn7QlmSgvM0MxrCN+IBYEMdLGobrQlHpBK6uT9SZnpDjbKcnRv95RPgzKe4tzXqhkih0ysYWs/vzKhS/qhXEDdshxlSlKhtxEjARD/SWHKOI0Ay093Bfr9Ftp68oxc4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737647010; c=relaxed/simple;
	bh=qkECEkGP1oaxhrwSnkqGPG21zp6cwkywDFxQbDVj3PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNv1mmH+mUrOiSp+N2YD6Ie+uMcYtnDmtGxzHx41O+N0zsPkQQ+LEECI+3xf1/qT2s62V7CuZzNlezeKwJyXyJuvprw5C+fxfbZbHROeKq4sFtWbiE/bHxXoci18FZx11G0kaTtAB60KwRCsC8ptNthGsM6NaraKmSuNEAuor2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hl6Hcs/W; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 23 Jan 2025 16:43:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737646996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dk8ApH0cAFI0UZWZTyTEsgDS1l6elNezuUyetdqvFcU=;
	b=hl6Hcs/Wpq3qPazpHiKpHaE1Zxs3LexvXlU6sL69OB1v0FLTd8edx3TSReHSivNzX0HTmt
	TFFEJPiSREeaIeHIPaIiaNabx1gopzHVPybyZKkXyx1r8bamvo0FgP/U8QytmSi83UcrMb
	LVC+c6eOrY7PAWx/QKJUTfzUgtmmeoY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v2 14/18] run_tests: Add KVMTOOL
 environment variable for kvmtool binary path
Message-ID: <20250123-e805b8b162fd2dfbd54b0541@orel>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
 <20250120164316.31473-15-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120164316.31473-15-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 20, 2025 at 04:43:12PM +0000, Alexandru Elisei wrote:
> kvmtool is often used for prototyping new features, and a developer might
> not want to install it system-wide. Add a KVMTOOL environment variable to
> make it easier for tests to use a binary not in $PATH.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  run_tests.sh          | 1 +
>  scripts/arch-run.bash | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index acaaadbb879b..d38954be9093 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -36,6 +36,7 @@ The following environment variables are used:
>      TIMEOUT         Timeout duration for the timeout(1) command
>      CHECK           Overwrites the 'check' unit test parameter (see
>                      docs/unittests.txt)
> +    KVMTOOL         Path to kvmtool binary for ARCH-run
>  EOF
>  }
>  
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 34f633cade01..5d840b72f8cb 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -457,7 +457,7 @@ search_kvmtool_binary ()
>  {
>  	local kvmtoolcmd kvmtool
>  
> -	for kvmtoolcmd in lkvm vm lkvm-static; do
> +	for kvmtoolcmd in ${KVMTOOL:-lkvm vm lkvm-static}; do
>  		if $kvmtoolcmd --help 2>/dev/null| grep -q 'The most commonly used'; then
>  			kvmtool="$kvmtoolcmd"
>  			break

Let's had the help text that search_qemu_binary() has with this patch
pointing out that a binary can be specified with KVMTOOL.

Thanks,
drew

> -- 
> 2.47.1
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv

