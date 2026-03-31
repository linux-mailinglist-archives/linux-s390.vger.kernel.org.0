Return-Path: <linux-s390+bounces-18327-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA2ZNrxwy2k3HwYAu9opvQ
	(envelope-from <linux-s390+bounces-18327-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 08:59:08 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B3364AD2
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 08:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D70C73026A9C
	for <lists+linux-s390@lfdr.de>; Tue, 31 Mar 2026 06:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E23B19CE;
	Tue, 31 Mar 2026 06:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nYR8Prqt"
X-Original-To: linux-s390@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03D36AB6B;
	Tue, 31 Mar 2026 06:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774940335; cv=none; b=AcJvQucBmQUj8iFNDR01V03X1d18oHQdE3SOBJ1g2pH5ugf6fiaxiEFCEHxQBd5y4gFKKDycP8/oWmhONQ/W2olo9JjVG6tVJ2jkqD6+hVT844mBSGsyOJ0qiSgR+O13HQG3GXC19CcQn4v76MxPv5jLJo9Aueq0n90xduFk7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774940335; c=relaxed/simple;
	bh=gdAhW5XZxq9vGLc72R8BpSvhHv8EyfMH7avdrolmSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KyvgERDndLLNSmH5aoNNPF4z6TObLh9ZKNTI0VFTfK00idoyLWqZOD9t3LoflMixq5JKxCde0zQFRCpF9DuQ7vJz+SGeQ7Um1cKuJw+f9j1YdItcfyuGsbD+PMTunougtZbqwh1W0AfhhP1ili7O75Hn2o0/bw+6R+dq7v+zp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nYR8Prqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D797C19423;
	Tue, 31 Mar 2026 06:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774940334;
	bh=gdAhW5XZxq9vGLc72R8BpSvhHv8EyfMH7avdrolmSUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYR8PrqtAatnvV4IOdJHVU3Lgl6k62pgnX3JJPR2XQQJ2srQArXS6N9Xo4vaxBr2c
	 KG75AcD09Km92E3IPUfu09+gLZf7JjCjzio+Whi6ZpVfb78vp4wcDHQI6yk/N4V4NQ
	 QMpzEr8UXgJxdfwbo4Pp/vx7gURLTJapwDYlzY/YxepU/Q8KvgPFGjCJFqWsKhYb1O
	 /Ws/HLVCt4DujloLg7EiYHxxisbu3lufEK8vt7/435RK8MwDIkxFolTQ0xrIuXbNJE
	 bgy4Beg25zLUGpfybpdn0mlUKUpzZ9zPOXQ8RbUcIbDJ38Ol3NkpNHFDph9PIstc0n
	 phsayGLCAytLQ==
Date: Mon, 30 Mar 2026 23:58:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-perf-users@vger.kernel.org, acme@kernel.org,
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
	hca@linux.ibm.com, japo@linux.ibm.com
Subject: Re: [PATCH] perf test: Skip perf data type profiling tests for s390
Message-ID: <actwrDEWZpcdgYzN@google.com>
References: <20260327123541.1756317-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260327123541.1756317-1-tmricht@linux.ibm.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18327-lists,linux-s390=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namhyung@kernel.org,linux-s390@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-s390];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 421B3364AD2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 01:35:41PM +0100, Thomas Richter wrote:
> Test case 'perf data type profiling tests' fails on s390 with this
> error:
> 
>   # ./perf mem record -- ./perf test -w code_with_type
>   failed: no PMU supports the memory events
>   # echo $?
>   255
>   #
> 
> because s390 does not support memory events at all. According to the
> man page, perf annotate --code-with-type only works with memory
> instructions only.  As command 'perf mem record ...' is not supported
> on s390, skip this test for s390.
> 
> Output before:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : FAILED!
> 
> Output after:
>  # ./perf test 'perf data type profiling tests'
>  77: perf data type profiling tests                        : Skip
> 
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/tests/shell/data_type_profiling.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/data_type_profiling.sh b/tools/perf/tests/shell/data_type_profiling.sh
> index 2a7f8f7c42d0..d9393be6249e 100755
> --- a/tools/perf/tests/shell/data_type_profiling.sh
> +++ b/tools/perf/tests/shell/data_type_profiling.sh
> @@ -35,6 +35,12 @@ test_basic_annotate() {
>  
>    echo "${mode} ${runtime} perf annotate test"
>  
> +  case "$(uname -m)" in
> +    "s390x")
> +      echo "Skip: 'perf mem record' not supported"
> +      err=2
> +      return ;;
> +  esac

Then I think it should be general like checking the error code after
running `perf mem record` first instead of looking at machine types.

Thanks,
Namhyung


>    case "x${runtime}" in
>      "xRust")
>      if ! perf check feature -q rust
> -- 
> 2.53.0
> 

