Return-Path: <linux-s390+bounces-1384-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFE8456FD
	for <lists+linux-s390@lfdr.de>; Thu,  1 Feb 2024 13:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C27A41F23116
	for <lists+linux-s390@lfdr.de>; Thu,  1 Feb 2024 12:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2683C15D5C2;
	Thu,  1 Feb 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2ozpfSy"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4280A15D5CC
	for <linux-s390@vger.kernel.org>; Thu,  1 Feb 2024 12:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789357; cv=none; b=N8nPwa1P9tpx99JJJbtQYjCj6MagFyM3Y89WW+FrqXIxbKbjPps1siQivzz5gnmdhL0cL8L42Ple6FS0157/Y5kc/9ZCxjh6T0tUk3ExkRDw1blMdDJnf66pH55T2hCCgaDqakHNutYUgHACI2jvSMHqTcLOGnqNcXp8Btp2C9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789357; c=relaxed/simple;
	bh=YS8ezMElsucbFsR8yn4ZIQju37+qo/N1VNkz7vn6Pqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKM9sApGN2hn6qMq85cbAW68eSfMcC8x9ts9NHxy5Auj9CM/LXC1EveTtJ4nJ7QN3R+kw1N1n0gDP7ZIOOVt9AU9eXOYC30G/4OgmzHGfS4/q0GAhuR/6u08fXOck95qp2CkB8IYXJVsk6x/4/1uM/6O/toNGDL+al8pdqOcqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c2ozpfSy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706789354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rw1hU7/rB5ghAx4XO3rhHrYvtnSU2nsmG80pY3d2fyI=;
	b=c2ozpfSyHg2LfU+1gaChwhn4eR6G8wr/FByiXcPXVxL/Fp01XW5/3fZypNqOZPwROxHEvk
	NX9Hh7T6EzLPwGM3qPugXVd1PP8QuZ5pmQblXaq50Px6SDMA+31zn/UVVPBGJOrQT8BrYS
	ZIW3DV+lRd4lieeUzrkIoaO4VolTJmc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-jut-kpciNQmSL3m3Krabag-1; Thu, 01 Feb 2024 07:09:12 -0500
X-MC-Unique: jut-kpciNQmSL3m3Krabag-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33b1799e433so211406f8f.2
        for <linux-s390@vger.kernel.org>; Thu, 01 Feb 2024 04:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789352; x=1707394152;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rw1hU7/rB5ghAx4XO3rhHrYvtnSU2nsmG80pY3d2fyI=;
        b=KzyRDJNANSzul69RQkOQd6QpO0KIN58by5CjOLva1HA3EWuJoN43+nxhTvVEIutwgW
         8jJtx3dCBOsybosQnrJ6to26Pg81uwW485q9g0lxhbPJ/IwtqKxvM2PjIzFV9iaDv56t
         8t0YonceNdVJN7UkoInexG7DdObFqrsR1DjgLh8PqO8kPanC0s7s5x+a/zoR1cLBuZ/n
         Rif9km88wHONLjQ2IUsZjt6MifU3Kp9DR10fUcDwn4y21W11ymHcWAA6TXKXnoqIa8mM
         VO7bBVHPtxMmli6gpT7b9b6GOtKZaC5bZjA7PxUcGHwtelNUnQN+DVDLur2JHidSOruy
         c5CA==
X-Gm-Message-State: AOJu0Yz+Lhm3SiPH3aKl6noiugl3nqd8/hTZr/v+rZkOqyVTpIb3TM6l
	Ee4DNkBYfTVZ15IyCuc1vUfWW37VSo+R7DfFafuPGTVNYUecmuz8fEuHbHuBc5HtiNckbLDZcQc
	GggOkO+ZfYwgE4BNNZ5m+4kCwo62BV/0sI8LWzvRdA5TpfI6JNRW0kGQopV0=
X-Received: by 2002:a5d:5348:0:b0:33a:ed61:b043 with SMTP id t8-20020a5d5348000000b0033aed61b043mr3805808wrv.44.1706789351919;
        Thu, 01 Feb 2024 04:09:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIOwmN+x5idWQ7nOOxgVyHPL8L6XNFCvyWzP4fNSvBqKBlPC2IfIbGbcqjOLye7qCNKemVpA==
X-Received: by 2002:a5d:5348:0:b0:33a:ed61:b043 with SMTP id t8-20020a5d5348000000b0033aed61b043mr3805792wrv.44.1706789351610;
        Thu, 01 Feb 2024 04:09:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSscERne+jSLK5rFiwIQtnmY1voRz1AJwA4IyXxfDK74FNzgjC3uXNX5JDSU2sqX5MGThuhhFvvWMaqCrzyB6+8wvwzGUoSNG1NU2ql5OGik5CGvaSGZvm+t6DoHxVMo83gYcaKvWuTvb4+7dFo9UOly+dnLv17JKeO1K6D8r12PUQuWqBJpSs1XPEZ/Wi5jNOPMMltin1WshvJIhcw+DGcdCn
Received: from [192.168.0.9] (ip-109-43-177-196.web.vodafone.de. [109.43.177.196])
        by smtp.gmail.com with ESMTPSA id bo18-20020a056000069200b0033af3aec393sm9384498wrb.38.2024.02.01.04.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:09:11 -0800 (PST)
Message-ID: <db6ac7f8-5a1e-4119-a48c-6c4b4e05cb27@redhat.com>
Date: Thu, 1 Feb 2024 13:09:10 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH] (arm|powerpc|s390x): Makefile: add
 `%.aux.o` target
To: Marc Hartmayer <mhartmay@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Nico Boehr <nrb@linux.ibm.com>,
 Eric Auger <eric.auger@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20240125151127.94798-1-mhartmay@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20240125151127.94798-1-mhartmay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/01/2024 16.11, Marc Hartmayer wrote:
> It's unusual to create multiple files in one target rule, therefore create an
> extra target for `%.aux.o` and list it as prerequisite. As a side effect, this
> change fixes the dependency tracking of the prerequisites of
> `.aux.o` (`lib/auxinfo.c` was missing).
> 
> Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
> ---
>   arm/Makefile.common     | 23 ++++++++++++-----------
>   powerpc/Makefile.common | 10 +++++-----
>   s390x/Makefile          |  9 +++++----
>   3 files changed, 22 insertions(+), 20 deletions(-)

Patch looks sane to me, so I went ahead and pushed it to the git repo. Thanks!

By the way, unrelated to your modifications, but while testing it, I noticed 
that "make distclean" leaves some files behind for the s390x build:

  ./configure --arch=s390x --cross-prefix=s390x-linux-gnu-
  make -j$(nproc)
  make distclean
  git status --ignored

On branch master
Your branch is up to date with 'origin/master'.

Ignored files:
   (use "git add -f <file>..." to include in what will be committed)
	.mvpg-snippet.d
	.sie-dat.d
	.spec_ex.d
	lib/auxinfo.o
	s390x/snippets/c/.cstart.d
	s390x/snippets/c/.flat.d

... in case someone wants to have a look ...

  Thomas


