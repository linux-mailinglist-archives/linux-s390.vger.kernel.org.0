Return-Path: <linux-s390+bounces-2277-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C286E24C
	for <lists+linux-s390@lfdr.de>; Fri,  1 Mar 2024 14:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460E328460A
	for <lists+linux-s390@lfdr.de>; Fri,  1 Mar 2024 13:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B096F506;
	Fri,  1 Mar 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJmWp8Dp"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499DB6D1A7
	for <linux-s390@vger.kernel.org>; Fri,  1 Mar 2024 13:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709299985; cv=none; b=jZuKjsgKfyxuPXgr8zqC+/8ql3wJQ8CDpnN7lwuh7sUDEKR5TJ2v7+z7Kn8Zuw8OzWGZpKE+0nwt1bCD0I8bRsloAkWcNTeNz1I3foXMEWDhV8Sq2dGpzNWZO1wcaFfVlwP6wT0Jx6mbMMg4HuA30Q4Gwif08r54pb18nnQdxpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709299985; c=relaxed/simple;
	bh=n3AYtPZiHWRv1G7y6L5PBE1iBSN6RsRBTpOEAndNkco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eMKL1L0byQNP1NKvXplP6mu949JrCWKlluwi3PiSPx0Yubf2R47EQAcxMJznVXb1VpuhZLpam2J/UalcuYs02VxlZe8DlcWzAzckAw2SsXlfv1rDXljI01gdIfNxC2YmpPlym0TvHb/OLhBgrGssFP6gugSGMh+AgzN2T7frskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJmWp8Dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709299981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lRrZ49EeCBRPggg9ASeyz3DJTLJRzQqZi93PdwIxr2g=;
	b=jJmWp8DpmpoOPLX2XRVU798WjutzUBAgJS5Po2Ydwx1tLkBgpIquGILEWySV8cGERbeYoB
	DpWNxIcKBnsPuS9YRQDiq6OPxlumP56W1UaNasX9FjLwrnocgPimFvhLO9LBbQFC9S44WP
	1mgxM/ta2/3ixaJXzMPhMlRSib8oW/E=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-Hjmil1eRM6qDg4Mzxca-4Q-1; Fri, 01 Mar 2024 08:32:59 -0500
X-MC-Unique: Hjmil1eRM6qDg4Mzxca-4Q-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-78319f64126so304951385a.3
        for <linux-s390@vger.kernel.org>; Fri, 01 Mar 2024 05:32:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709299979; x=1709904779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRrZ49EeCBRPggg9ASeyz3DJTLJRzQqZi93PdwIxr2g=;
        b=BUtkosddcMtw+zIRUeL1oClFyvmId0656vA59cClMTF7uK22dkUv3GIx8dnrI8QUu9
         jdeLVvRDAQ22FOmngMbpW7cRgd7+heon6uBzaFFyBQN+KnKMf3Q0bfGMDhmi26y6odLs
         A6Pqj33wOm+Di5c0w+r2Ddzoxc+wN2q1O4vo8733W0yhRvvphQXHnX/r82I/wTxSyyts
         3OudTwaTPAgsr+9jDJSNIO/23t5kW4tsNrzJlCjHHATTwdqTa7dAlDFfvEbeOwJHmkWR
         PRnLTRSBDI97DuLQMr6XAzK7+lgll5sG4uKP4aLP+KTwSZ6X9HFg5h3D279r7w+CLaXe
         1zbw==
X-Forwarded-Encrypted: i=1; AJvYcCXolz8czMDE/dGPwZwRkkH7lRzZ5HWVFpkR9yeH526iZ7LKGGQZ6N9hPChgj1Qe7OQaelJPJ4NUVasRQrXg2kYej+mtjuLZziZOgg==
X-Gm-Message-State: AOJu0Yw6p3BeFrdKR3bc7/ZotXtVJP7TwBNCPi7zWDP0or+bqC5tNN9P
	mOtpc7BSChCIE5P6eRGGENmiNA8XxAx8iNVvw3awOIPZqdocAgTp1G6yLrJPJepROrC8BiVPFzJ
	Oq7VpswzK/xKdSOvaKXhy8nU+6ZVTUB9yPRBgjz+b3kkf7u61lD9ozmPfccc=
X-Received: by 2002:a05:620a:158c:b0:787:ba6c:65c3 with SMTP id d12-20020a05620a158c00b00787ba6c65c3mr1583192qkk.21.1709299979490;
        Fri, 01 Mar 2024 05:32:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7DBxLg18an/NNcRDDOTDpdJ7QCDRh9RX/3rqDqE/BSDlt5DQxOty6xZ0bcfxamgoIxBXd7w==
X-Received: by 2002:a05:620a:158c:b0:787:ba6c:65c3 with SMTP id d12-20020a05620a158c00b00787ba6c65c3mr1583168qkk.21.1709299979156;
        Fri, 01 Mar 2024 05:32:59 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de. [109.43.178.133])
        by smtp.gmail.com with ESMTPSA id g27-20020a05620a109b00b00787f7d5a727sm1635652qkk.44.2024.03.01.05.32.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 05:32:58 -0800 (PST)
Message-ID: <e802a3a4-5ab7-447f-b09b-75d710ba7bd6@redhat.com>
Date: Fri, 1 Mar 2024 14:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 1/7] arch-run: Keep infifo open
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org
References: <20240226093832.1468383-1-npiggin@gmail.com>
 <20240226093832.1468383-2-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240226093832.1468383-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 10.38, Nicholas Piggin wrote:
> The infifo fifo that is used to send characters to QEMU console is
> only able to receive one character before the cat process exits.
> Supporting interactions between test and harness involving multiple
> characters requires the fifo to remain open.
> 
> This also allows us to let the cat out of the bag, simplifying the
> input pipeline.

LOL, we rather let the cat out of the subshell now, but I like the play on 
words :-)

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   scripts/arch-run.bash | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index 6daef3218..e5b36a07b 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -158,6 +158,11 @@ run_migration ()
>   	mkfifo ${src_outfifo}
>   	mkfifo ${dst_outfifo}
>   
> +	# Holding both ends of the input fifo open prevents opens from
> +	# blocking and readers getting EOF when a writer closes it.
> +	mkfifo ${dst_infifo}
> +	exec {dst_infifo_fd}<>${dst_infifo}
> +
>   	eval "$migcmdline" \
>   		-chardev socket,id=mon,path=${src_qmp},server=on,wait=off \
>   		-mon chardev=mon,mode=control > ${src_outfifo} &
> @@ -191,14 +196,10 @@ run_migration ()
>   
>   do_migration ()
>   {
> -	# We have to use cat to open the named FIFO, because named FIFO's,
> -	# unlike pipes, will block on open() until the other end is also
> -	# opened, and that totally breaks QEMU...
> -	mkfifo ${dst_infifo}
>   	eval "$migcmdline" \
>   		-chardev socket,id=mon,path=${dst_qmp},server=on,wait=off \
>   		-mon chardev=mon,mode=control -incoming unix:${dst_incoming} \
> -		< <(cat ${dst_infifo}) > ${dst_outfifo} &
> +		< ${dst_infifo} > ${dst_outfifo} &
>   	incoming_pid=$!
>   	cat ${dst_outfifo} | tee ${dst_out} | filter_quiet_msgs &
>   
> @@ -245,7 +246,6 @@ do_migration ()
>   
>   	# keypress to dst so getchar completes and test continues
>   	echo > ${dst_infifo}
> -	rm ${dst_infifo}

I assume it will not get deleted by the trap handler? ... sounds fine to me, 
so I dare to say:

Reviewed-by: Thomas Huth <thuth@redhat.com>



