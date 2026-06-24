Return-Path: <linux-s390+bounces-21233-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rw5SA5nUO2qDdwgAu9opvQ
	(envelope-from <linux-s390+bounces-21233-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 14:59:05 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6056B6BE564
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 14:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=bOxhBONH;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21233-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-21233-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC9D4307CEFC
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2026 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADAD37B40C;
	Wed, 24 Jun 2026 12:56:41 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EC22F39AB
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 12:56:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782305801; cv=none; b=WxUqFO4KTwg1pkeiNkydQ9rxUB5l1MNg7n5IneJorhn4KgwyT7ZBHpX79HUStideGb+DVbLScMmTEaHBupYp4Iiltr4MEpVfzWCal+naPI5RxIuTXqY8CwtTdL3LIdSPBXqO6Ic+y7yXJGQummSDw4voQqEVyeM8IcFp/owq/rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782305801; c=relaxed/simple;
	bh=bhoXb5RTRVAVLmKt5V8ywfGvXPrQuWWDUG2x5h2MZ4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+zeCh2p4VAs0jS9Es/7IovRXqRsf3+oCk4RTZv7oSgqRnKqgOsUbx48l36LK1RPU4EJo1gsGI2kwVpAz/tvKmbmI16i1OcrIo8153EZnz/LuXf3Vhof/j1TPdLn7tC6FcmupFDvV6JVFUxezuHelnW2Kn4h8H3bkFsw2ggL7sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bOxhBONH; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAn2oM562336;
	Wed, 24 Jun 2026 12:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L0Tf7p
	Th20Nh40eQ/2RakmStbSdoVnFscjmsQrWoQ7o=; b=bOxhBONHzVz9oJ2F5s2hLY
	ebj/fboggtnQ5f9+cqquXygO+5UUr5Oc078kWkueE+lIb/svY59bzVCkXEVUNCHo
	zcZBoEP/a3ViIbbsIP0inEl8MknT47BPjnYSlPQ/QqIJEp/mQa52iF27SMEH+sZt
	vaSAiSNM+d7IzdMyk/9EyUzZM9z89La2o0f+5flhx6BXvg2FmK+dG0G9HcUVJbsu
	pra+Di4un3yCDxwzKP3fay4fjjplSOS3VBm8sg2RT6Gb81wq+92HuzVdJx8aqMs8
	kBijfcI70WzCdAhrMrvT3hA51avtKzxqCrj2akvF1s/78sIc7f6TQ0QJWxsxZWBQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsuw2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 12:56:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OCnkGd002546;
	Wed, 24 Jun 2026 12:56:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dg8bxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 12:56:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OCuJiQ43057440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 12:56:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF3720043;
	Wed, 24 Jun 2026 12:56:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EB8720040;
	Wed, 24 Jun 2026 12:56:18 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 12:56:18 +0000 (GMT)
Message-ID: <e516de9c-e9fb-45af-aa5e-8cb9dbf1e3f3@linux.ibm.com>
Date: Wed, 24 Jun 2026 14:56:18 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/18] target/s390x: Fix wrong address handling in
 address loops
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-2-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwNiBTYWx0ZWRfXzyiPplXsq14D
 NMuf2UjkTZU7sdEWTGKvzTZhjHYPk9YIk5CxU6ENNtqrgsY4L1BqOyVFSvMTcjUzOmqXIldMg02
 CamBSjLqQm2rr9gZ6lMijPZS3GFnKgSl3u4r3v0TpcvYBQrKf4Ik7+lPkxzFYw9IIXWHBaswPtV
 smLPCtvSTrCwxSblf0MOgDQub1yn9o8iHM5bv9yBW6cgcUC7jegeeaNEwAaOox/jj3sOVjJ0bsA
 mVAHuQfIDc0KInUGYVmEzVLEPnA7182pvW0UMScY6Hw4VqdT3tXQB/ZOuT1aZtz6RvyiXTGewbg
 FDoIxZzDNQvh+YuasZs8G8GjkSCJkV5DOIfv6Ub0FxDQnsBmfNUnb7nMhsrEAHvkI8rYAFuAxaC
 UeRkxIO/hbWRUH7r7cM/izuwgX9nSg==
X-Proofpoint-GUID: y3bp4mlRxJcW5cmzwMn-AoblMJWYWv6o
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwNiBTYWx0ZWRfX7h6+BZcSH7J/
 reLQOY2p1gO6OOR4x61q2GJUb44srojYY0e7J5dYqnUpVs/dZGcQZnLeJfxi2KNGuyi383tCunF
 5GGhyaS/rRtoSIyFqq6fBSTgUFZhi/s=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3bd3f8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=KHZQTp77v83W7mwugnYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: y3bp4mlRxJcW5cmzwMn-AoblMJWYWv6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240106
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21233-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:fcallies@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[iii@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6056B6BE564



On 6/24/26 10:09, Harald Freudenberger wrote:
> With the introduction of the address wrapping function
> wrap_address() the result can't be used to walk the
> source address any more. So introduce a new local variable
> to hold the wrapped address to avoid mixing source and
> wrapped address value.
> 
> Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx argument")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

If I take as an example AMODE 24 and look at the third loop iteration,
with the current code in master I would get:

     ((((addr & 0xffffff) + 8) & 0xffffff) + 8) & 0xffffff

and with your patch it would be:

     (addr + 8 + 8) & 0xffffff

which is undeniably more elegant, but otherwise looks equivalent to me.

What is the functional issue here?

> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index ae392bce0e..29ad2aff43 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
>       const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
>   
>       for (int i = 0; i < 8; i++, addr += 8) {
> -        addr = wrap_address(env, addr);
> -        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
> +        uint64_t _addr = wrap_address(env, addr);
> +        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
>       }
>   }

[...]


