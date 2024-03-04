Return-Path: <linux-s390+bounces-2291-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C46E286F9F2
	for <lists+linux-s390@lfdr.de>; Mon,  4 Mar 2024 07:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00B2816EB
	for <lists+linux-s390@lfdr.de>; Mon,  4 Mar 2024 06:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA39CC15B;
	Mon,  4 Mar 2024 06:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QFMhU84x"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5BD29B
	for <linux-s390@vger.kernel.org>; Mon,  4 Mar 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533066; cv=none; b=n8ycRvxvabDfN+xWji9J4BT1McSjMzdmcpfNX1W/3RI4FreTNxiG0+x7YZ+P/OH12Uroo2Z8K097duwhY4+0m3LbZ23nekMjtTaeRxvakYD0bnCme3vy0YMF+J2DnSQ+J5mv2Mik8/ogw+CJp5XKF3k259d4qH4yDbRzipHtBIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533066; c=relaxed/simple;
	bh=75momKa1i5L2SkoyYzGkwcRHeZuUZzEmhswGGwGWYKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HLFLxmLOhqW5Ddch86KB7JBStluApTPqRXOnIUi5pb8LkgnGc4Cg/xvAcarGAeeveDnewwJRC6fYxRVVJD/3V4ToiyTKYQB23+saJ9BHN4Az7VOesdvXE3rSS+FNKTnqWC3A/fHK8XjFtHCqSAxYbNHZlvfGHUpdZwd93bfopck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QFMhU84x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709533063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=O+fO6j0tC3hoYWlaRzxgXQx+mHiiCB/NggfeHPRfEfg=;
	b=QFMhU84xwkFGfsrbPa5qIRqWVTPQleRaPK3bI/xa2rNTd7KgiUyjBIuKJM1Tm4swavEjOI
	cGRnd8zjMdymsBR3U+xP1k96aMx8mgI4B61yHRKpR7YFFvqepAm7v8/g9iaMb8DOYyU3ic
	s97zeixjbh8KbioWz1cBqKzvB2pZnj0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-YP63aV5MPnOsawe6FTis7g-1; Mon, 04 Mar 2024 01:17:42 -0500
X-MC-Unique: YP63aV5MPnOsawe6FTis7g-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-42eee530595so12802531cf.1
        for <linux-s390@vger.kernel.org>; Sun, 03 Mar 2024 22:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533061; x=1710137861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+fO6j0tC3hoYWlaRzxgXQx+mHiiCB/NggfeHPRfEfg=;
        b=mhcoE0c5T0rBFDclfryzoQvhLsUMN1BzjKR585EbLEUJFVQH01UP0MFrNCSK/O7e4N
         BDJG8BQ/+PBDQsO17p5Gkj1TYxjeQ+dANnJTW5M0iK/ADRow627wllhduOGmtVfYOHDi
         U17Ki74F1GJh3ebKkcvoYGU1YP000yNpG0Xb8ff2QRy1OwW4dZyaVy0A8dQzYEhKGEuk
         zNYJ4Y3Qww3RiKHmWUw+OLV2Qm8IUgtMhwcDumqhbzSOKvQE4Bjm1ml2L3ihcWj9B94h
         dyZXdQ0WEkb6N1Y7Gl6xzQEtwvwT8YU90En6D43vVT8qzhRCwMb5NyrXsg3ML8P9O9Ks
         yyLA==
X-Forwarded-Encrypted: i=1; AJvYcCX46AlM0nc6cJj0zVjQzHNlxd7lsD5ocDcS786YvOxN9Rsqtm4YmqS4iiVdPbx9pgGv0YfXzlNyUlT5fI2vuchNewFwoHtDZczV+Q==
X-Gm-Message-State: AOJu0YxAlLbtzPCz6XD+vIDFO8eIkjqwDltiQ/53qj5LnFvIc/AEUzYx
	tNHHliigjcpYVrq+2wJHNsauYwNpRuRex1XrA7UdDV3MPtJPTrhiqhHSndqSaNTETx99YQ6EMgI
	7KRSX8KqH9FiirDuP3HqJ1l7SmYq4zXX596vS3fh2qbkSKQIho6+9ZUTlpVM=
X-Received: by 2002:ac8:5ac2:0:b0:42e:d2f2:71f2 with SMTP id d2-20020ac85ac2000000b0042ed2f271f2mr11566449qtd.23.1709533061683;
        Sun, 03 Mar 2024 22:17:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTwt3A1nfxsBAOT9o42hUQSyWoxM3TY/5qVm2pNryLGHmXlVu2wbWYv1lpVD9oV398f6MfcA==
X-Received: by 2002:ac8:5ac2:0:b0:42e:d2f2:71f2 with SMTP id d2-20020ac85ac2000000b0042ed2f271f2mr11566436qtd.23.1709533061382;
        Sun, 03 Mar 2024 22:17:41 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-178-133.web.vodafone.de. [109.43.178.133])
        by smtp.gmail.com with ESMTPSA id lr9-20020a0562145bc900b006904ca1971esm4405485qvb.42.2024.03.03.22.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 22:17:41 -0800 (PST)
Message-ID: <6329dd4c-2093-40c3-8eb8-701d8e8b2ecd@redhat.com>
Date: Mon, 4 Mar 2024 07:17:35 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH 5/7] arch-run: Add a "continuous" migration
 option for tests
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
 <20240226093832.1468383-6-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240226093832.1468383-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2024 10.38, Nicholas Piggin wrote:
> The cooperative migration protocol is very good to control precise
> pre and post conditions for a migration event. However in some cases
> its intrusiveness to the test program, can mask problems and make
> analysis more difficult.
> 
> For example to stress test migration vs concurrent complicated
> memory access, including TLB refill, ram dirtying, etc., then the
> tight spin at getchar() and resumption of the workload after
> migration is unhelpful.
> 
> This adds a continuous migration mode that directs the harness to
> perform migrations continually. This is added to the migration
> selftests, which also sees cooperative migration iterations reduced
> to avoid increasing test time too much.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   common/selftest-migration.c | 16 +++++++++--
>   lib/migrate.c               | 18 ++++++++++++
>   lib/migrate.h               |  3 ++
>   scripts/arch-run.bash       | 55 ++++++++++++++++++++++++++++++++-----
>   4 files changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/common/selftest-migration.c b/common/selftest-migration.c
> index 0afd8581c..9a9b61835 100644
> --- a/common/selftest-migration.c
> +++ b/common/selftest-migration.c
> @@ -9,12 +9,13 @@
>    */
>   #include <libcflat.h>
>   #include <migrate.h>
> +#include <asm/time.h>
>   
> -#define NR_MIGRATIONS 30
> +#define NR_MIGRATIONS 15
>   
>   int main(int argc, char **argv)
>   {
> -	report_prefix_push("migration");
> +	report_prefix_push("migration harness");
>   
>   	if (argc > 1 && !strcmp(argv[1], "skip")) {
>   		migrate_skip();
> @@ -24,7 +25,16 @@ int main(int argc, char **argv)
>   
>   		for (i = 0; i < NR_MIGRATIONS; i++)
>   			migrate_quiet();
> -		report(true, "simple harness stress");
> +		report(true, "cooperative migration");
> +
> +		migrate_begin_continuous();
> +		mdelay(2000);
> +		migrate_end_continuous();
> +		mdelay(1000);
> +		migrate_begin_continuous();
> +		mdelay(2000);
> +		migrate_end_continuous();
> +		report(true, "continuous migration");
>   	}
>   
>   	report_prefix_pop();
> diff --git a/lib/migrate.c b/lib/migrate.c
> index 1d22196b7..770f76d5c 100644
> --- a/lib/migrate.c
> +++ b/lib/migrate.c
> @@ -60,3 +60,21 @@ void migrate_skip(void)
>   	puts("Skipped VM migration (quiet)\n");
>   	(void)getchar();
>   }
> +
> +void migrate_begin_continuous(void)
> +{
> +	puts("Begin continuous migration\n");
> +	(void)getchar();
> +}
> +
> +void migrate_end_continuous(void)
> +{
> +	/*
> +	 * Migration can split this output between source and dest QEMU
> +	 * output files, print twice and match once to always cope with
> +	 * a split.
> +	 */
> +	puts("End continuous migration\n");
> +	puts("End continuous migration (quiet)\n");
> +	(void)getchar();
> +}
> diff --git a/lib/migrate.h b/lib/migrate.h
> index db6e0c501..35b6703a2 100644
> --- a/lib/migrate.h
> +++ b/lib/migrate.h
> @@ -11,3 +11,6 @@ void migrate_quiet(void);
>   void migrate_once(void);
>   
>   void migrate_skip(void);
> +
> +void migrate_begin_continuous(void);
> +void migrate_end_continuous(void);
> diff --git a/scripts/arch-run.bash b/scripts/arch-run.bash
> index d0f6f098f..5c7e72036 100644
> --- a/scripts/arch-run.bash
> +++ b/scripts/arch-run.bash
> @@ -125,15 +125,17 @@ qmp_events ()
>   filter_quiet_msgs ()
>   {
>   	grep -v "Now migrate the VM (quiet)" |
> +	grep -v "Begin continuous migration (quiet)" |
> +	grep -v "End continuous migration (quiet)" |
>   	grep -v "Skipped VM migration (quiet)"
>   }
>   
>   seen_migrate_msg ()
>   {
>   	if [ $skip_migration -eq 1 ]; then
> -		grep -q -e "Now migrate the VM" < $1
> +	        grep -q -e "Now migrate the VM" -e "Begin continuous migration" < $1
>   	else
> -		grep -q -e "Now migrate the VM" -e "Skipped VM migration" < $1
> +	        grep -q -e "Now migrate the VM" -e "Begin continuous migration" -e "Skipped VM migration" < $1
>   	fi
>   }
>   
> @@ -161,6 +163,7 @@ run_migration ()
>   	src_qmpout=/dev/null
>   	dst_qmpout=/dev/null
>   	skip_migration=0
> +	continuous_migration=0
>   
>   	mkfifo ${src_outfifo}
>   	mkfifo ${dst_outfifo}
> @@ -186,9 +189,12 @@ run_migration ()
>   	do_migration || return $?
>   
>   	while ps -p ${live_pid} > /dev/null ; do
> -		# Wait for test exit or further migration messages.
> -		if ! seen_migrate_msg ${src_out} ;  then
> +		if [[ ${continuous_migration} -eq 1 ]] ; then

Here you're using "[[" for testing ...

> +			do_migration || return $?
> +		elif ! seen_migrate_msg ${src_out} ;  then
>   			sleep 0.1
> +		elif grep -q "Begin continuous migration" < ${src_out} ; then
> +			do_migration || return $?
>   		elif grep -q "Now migrate the VM" < ${src_out} ; then
>   			do_migration || return $?
>   		elif [ $skip_migration -eq 0 ] && grep -q "Skipped VM migration" < ${src_out} ; then

... while the other code seems to use "[" for testing values. Can we try to 
stick to one style, please (unless it's really required to use "[[" somewhere)?

  Thanks,
   Thomas


