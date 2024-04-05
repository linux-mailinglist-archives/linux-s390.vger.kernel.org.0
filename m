Return-Path: <linux-s390+bounces-3085-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D4899FEC
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 16:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397711F21600
	for <lists+linux-s390@lfdr.de>; Fri,  5 Apr 2024 14:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AC916D4DC;
	Fri,  5 Apr 2024 14:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L15hda2r"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1A516F0F3
	for <linux-s390@vger.kernel.org>; Fri,  5 Apr 2024 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327893; cv=none; b=LN6UzLBSEvg+5VMlTjtfjBtt3Qt/BXWTAORprn3O7irVKPVh8Z/ALu2kXl/Ektlr80kARXZDwx/jW2ATQroQT37l97pPYw9/zXFZtr/a6o5c/1EHXE7inIw2qxExMcf5Qx1Dwfw35JP7jfTWyorU6hidPw8MkyyDitNvfeAClP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327893; c=relaxed/simple;
	bh=PcBChv9MOzGSgT6JiR9lSFomnhCQx4x27lSG6SsaEk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz3erqdw5S2+zlVU2smcAUMoKoFLvAySa/xJAVyUKJUBuKY74gpazwHIxVd0MqYrMDrDb9UNqGAsuNTd7B+pMk8y/bSSIcF8pMZGWzzPFiIVJLKONB8QljuB+M+UXbWNgxi8XwKW3lhmaqt0AkANop33++tD/GAe/EY6XeC33gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L15hda2r; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 5 Apr 2024 16:38:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712327890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ba8wk7hPVgFRaxodfX5xG0+Os8iu9mUKIoqeWMmz5aw=;
	b=L15hda2rIOaCRvZBK3vqh8fTYR4wgUxh8/XJQIa4vLguxK6PHeCN3QS6pbvXq50KFoDeYx
	Gf1/tumQ+0/THe2+Tue/JW8hi5WKawqt32Mqu+Teb0HKg+Krh9bJDKT87ebHrvlzRqXNpe
	PiUaRyNkK1OA/NejrXxrOxI12IccH68=
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
Subject: Re: [kvm-unit-tests RFC PATCH 13/17] shellcheck: Fix SC2294
Message-ID: <20240405-469e12c137e05d64ecf337bb@orel>
References: <20240405090052.375599-1-npiggin@gmail.com>
 <20240405090052.375599-14-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405090052.375599-14-npiggin@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 05, 2024 at 07:00:45PM +1000, Nicholas Piggin wrote:
>   SC2294 (warning): eval negates the benefit of arrays. Drop eval to
>   preserve whitespace/symbols (or eval as string).
> 
> No bug identified.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/arch-run.bash | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 89a496014..ed440b4aa 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -179,7 +179,7 @@ run_migration ()
>  	exec {src_infifo_fd}<>${src_infifo}
>  	exec {dst_infifo_fd}<>${dst_infifo}
>  
> -	eval "${migcmdline[@]}" \
> +	"${migcmdline[@]}" \
>  		-chardev socket,id=mon,path=${src_qmp},server=on,wait=off \
>  		-mon chardev=mon,mode=control \
>  		< ${src_infifo} > ${src_outfifo} &
> @@ -219,7 +219,7 @@ run_migration ()
>  
>  do_migration ()
>  {
> -	eval "${migcmdline[@]}" \
> +	"${migcmdline[@]}" \
>  		-chardev socket,id=mon,path=${dst_qmp},server=on,wait=off \
>  		-mon chardev=mon,mode=control -incoming unix:${dst_incoming} \
>  		< ${dst_infifo} > ${dst_outfifo} &
> @@ -357,7 +357,7 @@ run_panic ()
>  	qmp=$(mktemp -u -t panic-qmp.XXXXXXXXXX)
>  
>  	# start VM stopped so we don't miss any events
> -	eval "$@" -chardev socket,id=mon,path=${qmp},server=on,wait=off \
> +	"$@" -chardev socket,id=mon,path=${qmp},server=on,wait=off \
>  		-mon chardev=mon,mode=control -S &
>  
>  	panic_event_count=$(qmp_events ${qmp} | jq -c 'select(.event == "GUEST_PANICKED")' | wc -l)
> -- 
> 2.43.0
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>

