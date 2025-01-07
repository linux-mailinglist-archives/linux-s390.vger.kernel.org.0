Return-Path: <linux-s390+bounces-8050-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AEFA04D78
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jan 2025 00:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9AF37A27CA
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jan 2025 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB671E47CD;
	Tue,  7 Jan 2025 23:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rsGTROJu"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82701E47B0
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 23:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736292319; cv=none; b=dZcGDl0cRVaSWGnEPEhFtBFfdN1hfeRbAfWxYGLhzf4NkuGjgsqm2wZt8t8TkiVEF/SD4HhnjooXuQ0z8JCj3kjWxPcku+u4wMY5+TBW5RWD7gGBIGr+2DDTDteARlC33mc3+TSGDk3SH1zBIzNVqv3+hLxwqWVdCbsUiH5e2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736292319; c=relaxed/simple;
	bh=fThI4GuoYILxwokpbOArAjaeI0f2fL5ggjUt0swvmLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLPKp4O+YHb3Kcf3kh3hSCeYzWLBV23yuMVt1smeB2LKG6CcPHP28xLekVqZ8ha/K4DmZyExFMK/DMTvhF48cUpiUK7rTXyNUnLLY2uhPYnWNmPoaropYhGewQ03u85/BQpLXKK444VsfOCQVkA+hjjBeakCU/M72XQbLBoiq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rsGTROJu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f897692c-cbf2-4906-aa15-1661162621eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736292299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rqcFnTSKm2DGg/IXOAcHA62iWf5YmtAk6en8LZ1mVpY=;
	b=rsGTROJun3qvnTQMQ7eZmM3vtPqnlVG+5htHQi6Rh72x8RifhjdzR1ZthsKwb8VpJVsdJf
	wYnoLY/q4RMmYPPpsuBSE19LgjKfukxSBe7Z8ceKwYmIbn0HTUMdg5onWGCK9upccI1QX9
	LFiPScE9/G4FPaII6G9XlV2Vd/7semo=
Date: Tue, 7 Jan 2025 15:24:51 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 4/5] libbpf: fix error when st-prefix_ops and
 ops from differ btf
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, Daniel Xu <dlxu@meta.com>
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-5-alibuda@linux.alibaba.com>
 <2f56aca3-a27a-49b6-90de-7f1b2ff39df1@linux.dev>
 <20241223021036.GC36000@j66a10360.sqa.eu95>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241223021036.GC36000@j66a10360.sqa.eu95>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/22/24 6:10 PM, D. Wythe wrote:
> On Thu, Dec 19, 2024 at 02:43:30PM -0800, Martin KaFai Lau wrote:
>> On 12/17/24 6:44 PM, D. Wythe wrote:
>>> Here are four possible case:
>>>
>>> +--------+-------------+-------------+---------------------------------+
>>> |        | st_opx_xxx  | xxx         |                                 |
>>> +--------+-------------+-------------+---------------------------------+
>>> | case 0 | btf_vmlinux | bft_vmlinux | be used and reg only in vmlinux |
>>> +--------+-------------+-------------+---------------------------------+
>>> | case 1 | btf_vmlinux | bpf_mod     | INVALID                         |
>>> +--------+-------------+-------------+---------------------------------+
>>> | case 2 | btf_mod     | btf_vmlinux | reg in mod but be used both in  |
>>> |        |             |             | vmlinux and mod.                |
>>> +--------+-------------+-------------+---------------------------------+
>>> | case 3 | btf_mod     | btf_mod     | be used and reg only in mod     |
>>> +--------+-------------+-------------+---------------------------------+
>>>
>>> At present, cases 0, 1, and 3 can be correctly identified, because
>>> st_ops_xxx is searched from the same btf with xxx. In order to
>>> handle case 2 correctly without affecting other cases, we cannot simply
>>> change the search method for st_ops_xxx from find_btf_by_prefix_kind()
>>> to find_ksym_btf_id(), because in this way, case 1 will not be
>>> recognized anymore.
>>>   	snprintf(tname, sizeof(tname), "%.*s",
>>> @@ -1020,17 +1021,25 @@ find_struct_ops_kern_types(struct bpf_object *obj, const char *tname_raw,
>>>   	}
>>>   	kern_type = btf__type_by_id(btf, kern_type_id);
>>> +	ret = snprintf(stname, sizeof(stname), "%s%s", STRUCT_OPS_VALUE_PREFIX, tname);
>>
>> How about always look for "struct bpf_struct_ops_smc_ops" first,
>> figure out the btf, and then look for "struct smc_ops", would it
>> work?
> 
> I think this might not work, as the core issue lies in the fact that
> bpf_struct_ops_smc_ops and smc_ops are located on different btf.
> Searching for one fisrt cannot lead to the inference of the other.

Take a look at btf_find_by_name_kind(btf, 1 /* from base_btf */, ...) and also 
btf_type_by_id(). It starts searching from the btf->base_btf which should be the 
btf_vmlinux here and should have the "struct smc_ops". Please try.

