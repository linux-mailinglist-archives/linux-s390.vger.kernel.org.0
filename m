Return-Path: <linux-s390+bounces-7277-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019739D934F
	for <lists+linux-s390@lfdr.de>; Tue, 26 Nov 2024 09:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913B21651F1
	for <lists+linux-s390@lfdr.de>; Tue, 26 Nov 2024 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8A2199EA2;
	Tue, 26 Nov 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JaSzBd2B"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEB245023
	for <linux-s390@vger.kernel.org>; Tue, 26 Nov 2024 08:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732609799; cv=none; b=ihwCQ0tjTz15uRmFys7xAf+EZtKdtR8Y90jOIsOV2GC12/HwWzmxr7xuaS7O3344+s61GP11YDm3Y2TslhlfbQqAB+oW09hQpvuxNy69yrsb+UkZs0Q7WiW4dkbAj1eNqooPnXD6FsfwqrrRmwr6Hxm8bLtmJVkYB8PlFyme+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732609799; c=relaxed/simple;
	bh=+PHgQAc1B4ytje4hZjbwIj43XIYJaG2UExnCW3e7OSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQQb+v7IggVqWlb8EquryNIKkFv74YDdPAUEXydpvKFRj9Qca2ZNBLdUaj+5DqUnPdSmZIhb5A5nbmX1fzP6TsmWXK1XYNOz2UcwYHehXEToohOIwTvGZ/9kvBsLQuK9kfagLDSltnDK+EDMW72H9lk7QzkOZtApKOETGjW9EDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JaSzBd2B; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf535357-74ad-4eaa-96d7-5e527789d10d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732609794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9gbq5TzS0a4IseLhp6Tc7c8shxkxLBAvltDhxn81LO0=;
	b=JaSzBd2BrWOg6ShpnvSIn3jvyObCFgbc4poOgfmDA3ZL1r2HAODai5v/JMM3yApimSjtmk
	8BiU3pmMegXppbjtIFWVz+LnbO2Po8x3VnruvmSeZLiJnTMEv++QeKjWSiwJonGJhzlhJq
	I5HMEFnkGtmDNYmMtclXJY6j/iMiMBk=
Date: Tue, 26 Nov 2024 09:29:49 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] bpf/selftests: add simple selftest for
 bpf_smc_ops
To: Martin KaFai Lau <martin.lau@linux.dev>,
 "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, dtcccc@linux.alibaba.com
References: <1729737768-124596-1-git-send-email-alibuda@linux.alibaba.com>
 <1729737768-124596-5-git-send-email-alibuda@linux.alibaba.com>
 <8c06240b-540b-472f-974f-d2db80d90c22@linux.dev>
 <e8ba7dc0-96b5-4119-b2f6-b07432f65fdb@linux.alibaba.com>
 <0a8c2285-29c2-4a79-b704-c2baeac90b70@linux.dev>
 <c96fe7a8-8512-48e8-b253-d5ff8a0f4755@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <c96fe7a8-8512-48e8-b253-d5ff8a0f4755@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/11/26 0:32, Martin KaFai Lau 写道:
> On 11/25/24 2:52 AM, Zhu Yanjun wrote:
>>>> # ./test_progs -t smc
>>>> #27/1    bpf_smc/load:OK
>>>> #27      bpf_smc:OK
>>>> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>>>>
>>>> The above command is based on several kernel modules. After these 
>>>> dependent kernel modules are loaded, then can run the above command 
>>>> successfully.
> 
>>>
>>> This is indeed a problem, a better way may be to create a separate 
>>> testing directory for SMC, and we are trying to do this.
>>
>> Got it. In the latest patch series, if a test program in sample/bpf 
>> can verify this bpf feature, it is better than a selftest program in 
>> the directory tools/ testing/selftests/bpf.
>>
>> I delved into this selftest tool. It seems that this selftest tool 
>> only makes the basic checks. A test program in sample/bpf can do more.
> 
> sample(s)/bpf? No new test should be added to samples/bpf which is 
> obsolete. The bpf CI only runs tests under selftests/bpf.

Thanks for letting me know this, Martin.

In the past, with samples/bpf, we can know a lot of details of bpf 
samples. But in the selftests/bpf, it seems that only load method can be 
found. For example, in this smc bpf selftests commit, we can not find 
how to change parameters in smc. In the past, this method about how to 
change parameters can be found in samples/bpf.

I am not sure whether this selftests/bpf is designed for this simple 
tests or the detailed information can be found in other places.

Zhu Yanjun

> 
> There is selftests/bpf/config to tell the bpf CI about what kconfig 
> needs to turn on.
> 


