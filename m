Return-Path: <linux-s390+bounces-20972-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n59PKvWFM2qADAYAu9opvQ
	(envelope-from <linux-s390+bounces-20972-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:45:25 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 408AA69DBAB
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 07:45:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b="rS0/VG0m";
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-20972-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-20972-lists+linux-s390=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A179301415A
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jun 2026 05:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF7F23D7C2;
	Thu, 18 Jun 2026 05:45:23 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70322F388
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 05:45:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761523; cv=none; b=lltbQQhyqZ1BRCvbwyvVYxuFZN5oPlHzFz7AB+biAugxsprqsZ8rePfiCuNz5+JCZysp1ax7EbxV4EVFMpmtVsA1zsYDwM20Qh2ZEGmW1xC9YWBW8z5PrzwXATxmH7LzFFGZ1gmF2up5CqYLihlnV8/RuyOY5GWPhDyB+leuIJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761523; c=relaxed/simple;
	bh=+E5wulnlOptCs3meRh3GNx3/9IZVAT4Vv4JM6Si0g08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KcRlE2M9ZGIkDtWnwBABEIMIVAof29QxFrNNv9qjUVOZBmSE5otimWaih/6OLAsQFCFhC9Orz8QpSQsQ2xr1ip8phS0Jc/JIw/YG7JSYsvHZHC89uShEZp4d4XX452w9Z2R0S4s7aSO7NCUdR+8Nt8YGs52+016tqcRczYW4yMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rS0/VG0m; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHnElK979390;
	Thu, 18 Jun 2026 05:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YdQ54H
	7S7LT+jb3Ctuc5OQZ/JikAaTTJJHUsT6yHa9Q=; b=rS0/VG0mqpD6il3skRg6SW
	90TmvdNXG6J5+OUYsBUWm1Ltbcd827V0Xjl0r8LoQEQq0ChLEA6uILOIUEndE1Rv
	x9C09rTq2SbC095fQYG9xI1QMmHgbrXxCo/Vf2T48NjZDclSSvwi8pR72/bSIJIu
	w7r1ZWAPn7CXG5Rl/B03hK3R74hI9pfetpURsdbs5w6b+U4cffYzIgO/Y70ZhxNt
	3ETJtM4xSgzvVoelXxoDw3wite6Z43Aw/dMlaJ3eLy9Bzsn8r7cDWrjPy9tyg3OV
	NivskBsDpLfpNr5YmNFcihmsoM0wuIdPIO17T3TmSyUnArOIteqS20of/ftq15hw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx6e60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:45:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65I5Z0Jt032180;
	Thu, 18 Jun 2026 05:45:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172a66q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jun 2026 05:45:13 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65I5j99p50987436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 05:45:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A70A120040;
	Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75A922004B;
	Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Received: from [9.224.89.241] (unknown [9.224.89.241])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 18 Jun 2026 05:45:09 +0000 (GMT)
Message-ID: <f3d24c22-ae20-4f06-9c08-4fb7063d2c23@linux.ibm.com>
Date: Thu, 18 Jun 2026 07:45:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/17] target/s390x: Support AES XTS for cpacf km
 instruction
Content-Language: en-GB
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        iii@linux.ibm.com, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-9-freude@linux.ibm.com>
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260617094820.34402-9-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L180RiLWnN2vzZjrNpC5zp28Tw1_3kbY
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a3385ea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=E14sLqMX2J24vDWi-R0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfXzwsYs5ICb+Wk
 Fc/p7tqsIFx4JHYUO9MOMNrKjHdFVg7mlAF8h04jjczSIM8rQMCjHdSdNzwVNLgD4uyVVwIrEoG
 qYERBv1lPTJuj/fmHj5Yagh1JKiTLSM=
X-Proofpoint-ORIG-GUID: L180RiLWnN2vzZjrNpC5zp28Tw1_3kbY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDA0NSBTYWx0ZWRfX3v7HfWqXqd5q
 9GVhvLDC2LRcwLLoM5MEQT2jGK/MbiXD2NHBPdBk5Bi/0+uSyaTAgsISsJBSNXSE5FkptVtC1dV
 oeztKY+HeTjHc5zIT0+WZ05g2u1vHLKfT72GT2NHFhGlZi0bzn4g9VvwYBkpz46bBkSnrFGz3qm
 5Q2D1Y7zGWMygZ4lN28UptHn4NmgEI4g7HFcsH0whTgtqU7uFhNJslb3//cvsyyMZENFt3KTvPa
 i5VOKuBAdC1kpNwuq32irwYrJgNW9cDGtEwBhNzlOtkvmvLzytfV/gjf60dRlgCAOBLF/ZiSHyl
 nosRWKoLBBvkZYv0uzzSVeBK1UiVhhj+eGfentBlIXB1NCv12HUrruRePDtz1baSm5uXiXfoNQV
 Nz4ZmCbEIW/w+niyKuStEEy7uPY8KXqbrnNbAetQQGu7W/fwN17VZ/tRvSWbmrZI1ZcSDzHykvW
 HNXY0YQ3L3pJoOjkiug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180045
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20972-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:freude@linux.ibm.com,m:richard.henderson@linaro.org,m:iii@linux.ibm.com,m:david@kernel.org,m:thuth@redhat.com,m:berrange@redhat.com,m:qemu-s390x@nongnu.org,m:qemu-devel@nongnu.org,m:linux390-list@tuxmaker.boeblingen.de.ibm.com,m:linux-s390@vger.kernel.org,m:dengler@linux.ibm.com,m:borntraeger@linux.ibm.com,m:cohuck@redhat.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[fcallies@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 408AA69DBAB



On 17.06.26 11:48, Harald Freudenberger wrote:
> Support the subfunctions XTS-AES-128 and XTS-AES-256
> for the cpacf km instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   2 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 107 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |   6 ++
>   4 files changed, 119 insertions(+)

[ snip ]

> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {

I guess this has the same "feature" as the real xts where the pcc part 
is not included if not explicitly done beforehand by the user right? But 
since CPACF does it that way I guess you can't do it the "correct" way. 
Instead of XTS + PCC you could implement Full XTS... just something to 
think about.

> +        /* fetch one AES block into buf1  */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
> +        /* buf1 xor tweak => buf2 */

[ snip ]


