Return-Path: <linux-s390+bounces-7817-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650969F8814
	for <lists+linux-s390@lfdr.de>; Thu, 19 Dec 2024 23:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 263E81884AA0
	for <lists+linux-s390@lfdr.de>; Thu, 19 Dec 2024 22:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8092D1D6DB8;
	Thu, 19 Dec 2024 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sb6wvgt1"
X-Original-To: linux-s390@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6C1BD039
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734648505; cv=none; b=RBMVkRKTPSr1ejkZhn+FLRm5SdOnWCIpLKxUkyC3aNMtUReXMbmlBPL4An4RLnQlCkKqiI4XjlEzRhXBVYFa23PScYkBni7bDhbIVFgUatF6o81fLFXtpcFKTxuTA//0vWsRZo0iBAAY2j1PQtwbJvJq2KpfYWr2sH/f17ICpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734648505; c=relaxed/simple;
	bh=bVLivMjyvvwnY1UYTPJNC34WHGsS7Sk7aRFNrajpuqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdJAPh19Xo/erbjTeK2oafND3lvZ/mavp5kzh7rdCmN63Oidj+4jR6ZRrK9WcP0jKI+49Er+/vEiSClIcmyqht32geB6tZF89j0gwBGLSUhahoVSNss33vGr0QRaVt88nmDygP4Zn5SS5gvXIYIMum0wfQjwmoAcCHpUmgQxZoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sb6wvgt1; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfa40af2-e726-477a-bab2-7abebfdd6384@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734648499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSsuDssCmx2sxK0P8EgA2+wWZ55+lycFjf0EWg5cyj4=;
	b=Sb6wvgt1trpADBnHEqCoMlIKT5o93qDL/6I1Zw4YY6xSEFqo1VlWn01LxBMaGTjRI2al6O
	82KBtrFqb5TyAwf8GnQ5QMunX286Xzhp7W61mRW3hBV7gI9F+ZXFD1C0eUBe53fsmsgbpP
	bJ1njh+UV8sqX1Jh1BnbZuWbvaF54Sw=
Date: Thu, 19 Dec 2024 14:48:12 -0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/5] net/smc: bpf: register smc_ops info
 struct_ops
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, pabeni@redhat.com,
 song@kernel.org, sdf@google.com, haoluo@google.com, yhs@fb.com,
 edumazet@google.com, john.fastabend@gmail.com, kpsingh@kernel.org,
 jolsa@kernel.org, guwen@linux.alibaba.com, kuba@kernel.org,
 davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20241218024422.23423-1-alibuda@linux.alibaba.com>
 <20241218024422.23423-4-alibuda@linux.alibaba.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241218024422.23423-4-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/17/24 6:44 PM, D. Wythe wrote:
> +static int smc_bpf_ops_check_member(const struct btf_type *t,
> +				    const struct btf_member *member,
> +				    const struct bpf_prog *prog)
> +{
> +	u32 moff = __btf_member_bit_offset(t, member) / 8;
> +
> +	switch (moff) {
> +	case offsetof(struct smc_ops, name):
> +	case offsetof(struct smc_ops, flags):
> +	case offsetof(struct smc_ops, set_option):
> +	case offsetof(struct smc_ops, set_option_cond):
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

The whole smc_bpf_ops_check_member() should not be needed.

