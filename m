Return-Path: <linux-s390+bounces-20966-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KyYtBbd/M2rMCwYAu9opvQ
	(envelope-from <linux-s390+bounces-20966-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:18:47 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F1F69DAA7
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:18:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=CfsX2t6U;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20966-lists+linux-s390=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-s390+bounces-20966-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FDB030125DD
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 05:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5912FD1B3;
	Thu, 18 Jun 2026 05:18:43 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E21B1F30BB
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781759923; cv=none; b=guOSbvwqEK7pbWD8A7hCkbQNKYa6gQev86lfJQjLYmlDtmwhtNz6DWKNXStDXQ6P5uMGavnejGhfxUBhyfwuN1xoFeJoeATP6Ajc+wIOQi3+kbqh4MPkCHsf2PO3obazaWN7B/PFsGxGbSNGTuiLLVSko42/YXe9E3NFTzCqcII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781759923; c=relaxed/simple;
	bh=wRyRyKTVnAwiG2tsQ0CRyjgJkpFlX39l61b4NbPhKfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tGMk9LHZwiY0PPsRhuLIaPayqT/fRr8H7/w4UTwJ8OOx0iUWv6rhk9A5xs3B3nYqt+N/UAXUFyOuzRvI7xocwZZ0vZ278YfFh9Smo3mukCGQL9oP9jZPj5RO9hPs09MvZl1y/y2cCgVK8vokNZaMtQEGEXXYf/juGka/EcaTonE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CfsX2t6U; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmNg91250962;
	Thu, 18 Jun 2026 05:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ul2lpy
	gMmk5Bgkmm0OVzYMry2gJVaQXV30FxWdOLe6E=; b=CfsX2t6UhnpmaxocSTW7dN
	kWP6MPcLv81Pu1MWPjan5aipK6Eimf67cHvXnXLLFBIPMSqymzwF+E4PDgTPUMLc
	XXV3T8BBO1EKzZyJN2HR+1fQXi/Nn2OTgC5s6i0yFkNPvQoVVzN7fELCaIl8fH6y
	wUcO3U+u95sxBHRZYpvQ8Di/v4oaYug0r3Ict9DUzUl3yF4bx0jMRk4VlAw+2oFu
	fu0Iv33jbqim19z5b3347O9Fn/0F7al2M3c79uiF8rKoS+JVnWTk7NBovKSpYMkp
	NAMN0nIuPLQkM2nP08jHKRCl4KQST/RV7mGQDYNFDTZ5CUUarKZJ3xjjod5YtZPQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequ6em3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:18:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I54l8P031755;
	Thu, 18 Jun 2026 05:18:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a4bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:18:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5IKOr57934252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:18:20 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6551820043;
	Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32A4520040;
	Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:18:20 +0000 (GMT)
Message-ID: <1c0b83e3-a9f6-423f-8330-d51ca26a196c@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:18:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/17] target/s390x: Support cpacf sha256
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-4-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-4-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX5ZqwN2hqz3Dp
 DzxJ7Kv6geYmQvwKbfFD/NfVLmfrC1DIdoVczu0DsSLhiRm7t3D5o2AsJJ6dcAImxyZoPPaEEFU
 WL+qkaZScbbdlxQA3G1TtleGm2nfhOQ=
X-Proofpoint-ORIG-GUID: N0naJPEtG_uxkuj4O3k2dsAxlPh-fHRe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX9MtN6hgUF6G4
 GeIRpR5NK1zXRoJO1/LeQpjM/m99VmpGy3TsAL3AlHtBKK0cbFWD+C0xZOF4eleKcljzpWRy/Si
 ZJXOOjg09J8yUaDAWonC+fr7Xkz23N74CFl3wWxMk771b0fP42/h62p06AJ8a9kfvue4mlme5X+
 U6X2bbXqJdRRrawHodkFnvsMrBQvhlAYbdYknLU5akRGfYtvTMwwyYt/INgysjllungOoz6rwxP
 y+px2g6xIWt9txh8NIIBHrnuI4CRWB3OZz35+YVFZh7Vn9KHxPX9M0cSsoVWImPWqLwBY/1toL9
 cuClDKSR3niAjgyOr4smVJ+ehcJBYUceCRNBJowEBBASEb8WhxoYqXEZCJzw9zCryfe5b/S3XZY
 QOdcr4PBzlWEQnWJGWcuhd+OGzH3hviypJR6J7yQLaD35F9ELatWHbXqyI/CgWjvUh+MHFI1Kry
 42mgzptfIDE1LivaWoA==
X-Proofpoint-GUID: N0naJPEtG_uxkuj4O3k2dsAxlPh-fHRe
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a337fa1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=CEokcfMmFq3Gd3i0g-0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20966-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55F1F69DAA7



On 17.06.26 11:48, Harald Freudenberger wrote:
> Add a new file cpacf_sha256.c which implements sha256.
> Add support for the sha256 subfuction for CPACF kimd and klmd.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>

With the one typo (see below) fixed:

Reviewed-by: Finn Callies <fcallies@linux.ibm.com>

> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   5 +
>   target/s390x/tcg/cpacf_sha256.c  | 232 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   8 ++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 248 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_sha256.c
> 
> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
> index 8218e6470e..5cf5b92c37 100644
> --- a/target/s390x/gen-features.c
> +++ b/target/s390x/gen-features.c
> @@ -916,7 +916,9 @@ static uint16_t qemu_V7_1[] = {
>    */
>   static uint16_t qemu_MAX[] = {
>       S390_FEAT_MSA_EXT_5,
> +    S390_FEAT_KIMD_SHA_256,
>       S390_FEAT_KIMD_SHA_512,
> +    S390_FEAT_KLMD_SHA_256,
>       S390_FEAT_KLMD_SHA_512,
>       S390_FEAT_PRNO_TRNG,
>   };
> diff --git a/target/s390x/tcg/cpacf.h b/target/s390x/tcg/cpacf.h
> index d27839ddd9..e2c36306b2 100644
> --- a/target/s390x/tcg/cpacf.h
> +++ b/target/s390x/tcg/cpacf.h
> @@ -8,6 +8,11 @@
>   #ifndef S390X_CPACF_H
>   #define S390X_CPACF_H
>   
> +/* from crypto_sha256.c */

The comment should be cpacf_sha256.c instead of crypto_sha256.c

> +int cpacf_sha256(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                 uint64_t param_addr, uint64_t *message_reg, uint64_t *len_reg,
> +                 uint32_t type);
> +
[ snip ]

