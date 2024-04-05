Return-Path: <linux-s390+bounces-3073-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F66899F36
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 16:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78E7E1F246B6
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 14:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007FA16EBE7;
	Fri,  5 Apr 2024 14:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V93lojpq"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268F516EBF2
	for <linux-s390@vger.kernel.org>; Fri,  5 Apr 2024 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326482; cv=none; b=a6VU5rxCtdTkggUe2+xhpp28zgqq7cN9u9wVHVGzxtT78GO7Hnba83WoQ6EHy20KaFU8o13sDCC80K/lXIATYk8XjlkMCi/fPj/c3gAu3su4XWoj+lVzcCyN8ULSc3TlSmQZ00Z1lELgimG17Gj0lAwYha4rcvV+gaBHTfPiLak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326482; c=relaxed/simple;
	bh=60gtkwZJtkUtTxXHSjKwbcJb39g5QFNR0ZBBLFlidoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL6YavryHtB7i8mw2N2z4ZBcjWxe6yjMugmvtTnjzskvPL/mPJBLUFvp9n3wcZnJnWWsL2fz8GxrAM3oIzKz8BqeHKFJYuJf71FD+uYFE4TVz9iWUT/VksTMrKMRoo++XXYwdkWmgUEOX/47W9v+Rvsiu3JOqV7OYvUcrrccy3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V93lojpq; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 16:14:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712326479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=heAcEwYd7ijpY/xlwlhbXGvXei4nJYnvLvvU1hD8rP4=;
	b=V93lojpqVYIlZQiqZXFDquqlSKvLYFNQmgaNMvkBsWqYVRGAYZ07rhsZq9/EOH58OovLUc
	uzn5SHI1jOD9TlgGpyWWBTH0cj0dhdAC9366N2qxkkawJ/G743tzPpM8/tQzjvFXjeH4PJ
	86IB1uMsalwse7274aB/YXZukh83xS8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Nico =?utf-8?B?QsO2aHI=?= <nrb@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	Shaoqin Huang <shahuang@redhat.com>, Nikos Nikoleris <nikos.nikoleris@arm.com>, 
	Nadav Amit <namit@vmware.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	Ricardo Koller <ricarkol@google.com>, rminmin <renmm6@chinaunicom.cn>, Gavin Shan <gshan@redhat.com>, 
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>, Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [kvm-unit-tests RFC PATCH 02/17] shellcheck: Fix SC2223
Message-ID: <20240405-04a2850c5340d5e29c822124@orel>
References: <20240405090052.375599-1-npiggin@gmail.com>
 <20240405090052.375599-3-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405090052.375599-3-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 07:00:34PM +1000, Nicholas Piggin wrote:
>   SC2223 (info): This default assignment may cause DoS due to globbing.
>   Quote it.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  run_tests.sh         | 4 ++--
>  scripts/runtime.bash | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/run_tests.sh b/run_tests.sh
> index bb3024ff9..9067e529e 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -158,8 +158,8 @@ function run_task()
>  	fi
>  }
>  
> -: ${unittest_log_dir:=logs}
> -: ${unittest_run_queues:=1}
> +: "${unittest_log_dir:=logs}"
> +: "${unittest_run_queues:=1}"
>  config=$TEST_DIR/unittests.cfg
>  
>  print_testname()
> diff --git a/scripts/runtime.bash b/scripts/runtime.bash
> index e4ad1962f..2d7ff5baa 100644
> --- a/scripts/runtime.bash
> +++ b/scripts/runtime.bash
> @@ -1,6 +1,6 @@
>  : "${RUNTIME_arch_run?}"
> -: ${MAX_SMP:=$(getconf _NPROCESSORS_ONLN)}
> -: ${TIMEOUT:=90s}
> +: "${MAX_SMP:=$(getconf _NPROCESSORS_ONLN)}"
> +: "${TIMEOUT:=90s}"
>  
>  PASS() { echo -ne "\e[32mPASS\e[0m"; }
>  SKIP() { echo -ne "\e[33mSKIP\e[0m"; }
> -- 
> 2.43.0

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

