Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE96BE5E9
	for <lists+linux-s390@lfdr.de>; Fri, 17 Mar 2023 10:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbjCQJwF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 17 Mar 2023 05:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjCQJvn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Mar 2023 05:51:43 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997651C7E9;
        Fri, 17 Mar 2023 02:51:31 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H9et1G003729;
        Fri, 17 Mar 2023 09:51:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Zexh+Vr/h5dgW7WWBKShjVaBD2huRitTxOdeSIL/BRg=;
 b=hct6ZN/WeJ4G5qbHZfZZGCSHvcRJoYtpGiNSWUBObBNlLP44HQYlI3eXvRWVwtq8pj3w
 mAz0KAMwVktQa3wFxGut6I1F/uRq+bSPK0LzxXHKDk6CLtyspf5HRBYPgCULXkmpzYwM
 60z2KcyUJovDj8wPS59aCOXPdrH7izxYyn6PYMzEdTTEild2Iz2VMWUnAv8HElxyMNiI
 K/MwCDO99LSgEkhxMRdSHy/fTdsymbMMeBWjVMVmcZSVrtaKH1Gl7RsLaG3x8/GgXPa+
 h7F5vznjdiWz8S3x8URhiQH2K/kpF47pKNCaFZBMzLSJSCsRotAqbKS7xYifgVduaLjw Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcnff0mkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:51:30 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32H9fHa1004769;
        Fri, 17 Mar 2023 09:51:30 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3pcnff0mjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:51:29 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32GHcLx9016073;
        Fri, 17 Mar 2023 09:51:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3pbs549n4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 09:51:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32H9pOBD20054622
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Mar 2023 09:51:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7FCFA2005A;
        Fri, 17 Mar 2023 09:51:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B84C20043;
        Fri, 17 Mar 2023 09:51:24 +0000 (GMT)
Received: from [9.171.47.172] (unknown [9.171.47.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 17 Mar 2023 09:51:24 +0000 (GMT)
Message-ID: <fa15b29e-9b9a-d2d5-40c7-5720169c3c56@linux.ibm.com>
Date:   Fri, 17 Mar 2023 10:51:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [kvm-unit-tests PATCH v3 3/3] s390x/spec_ex: Add test of EXECUTE
 with odd target address
Content-Language: en-US
To:     Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20230315155445.1688249-1-nsg@linux.ibm.com>
 <20230315155445.1688249-4-nsg@linux.ibm.com>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20230315155445.1688249-4-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cQCODxQlxxcOMn9hTLuXCkrAQr0F6myQ
X-Proofpoint-GUID: ZpgTix8E-lyKniMkfQrmUtzraBHjcozy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_05,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170064
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 3/15/23 16:54, Nina Schoetterl-Glausch wrote:
> The EXECUTE instruction executes the instruction at the given target
> address. This address must be halfword aligned, otherwise a
> specification exception occurs.
> Add a test for this.
> 
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>   s390x/spec_ex.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/s390x/spec_ex.c b/s390x/spec_ex.c
> index 83b8c58e..5fa05dba 100644
> --- a/s390x/spec_ex.c
> +++ b/s390x/spec_ex.c
> @@ -177,6 +177,30 @@ static int short_psw_bit_12_is_0(void)
>   	return 0;
>   }
>   
> +static int odd_ex_target(void)
> +{
> +	uint64_t pre_target_addr;
> +	int to = 0, from = 0x0dd;
> +
> +	asm volatile ( ".pushsection .text.ex_odd\n"
> +		"	.balign	2\n"
> +		"pre_odd_ex_target:\n"
> +		"	. = . + 1\n"
> +		"	lr	%[to],%[from]\n"
> +		"	.popsection\n"
> +
> +		"	larl	%[pre_target_addr],pre_odd_ex_target\n"
> +		"	ex	0,1(%[pre_target_addr])\n"
> +		: [pre_target_addr] "=&a" (pre_target_addr),
> +		  [to] "+d" (to)
> +		: [from] "d" (from)
> +	);
> +
> +	assert((pre_target_addr + 1) & 1);
> +	report(to != from, "did not perform ex with odd target");
> +	return 0;
> +}
> +
>   static int bad_alignment(void)
>   {
>   	uint32_t words[5] __attribute__((aligned(16)));
> @@ -218,6 +242,7 @@ static const struct spec_ex_trigger spec_ex_triggers[] = {
>   	{ "psw_bit_12_is_1", &psw_bit_12_is_1, false, &fixup_invalid_psw },
>   	{ "short_psw_bit_12_is_0", &short_psw_bit_12_is_0, false, &fixup_invalid_psw },
>   	{ "psw_odd_address", &psw_odd_address, false, &fixup_invalid_psw },
> +	{ "odd_ex_target", &odd_ex_target, true, NULL },
>   	{ "bad_alignment", &bad_alignment, true, NULL },
>   	{ "not_even", &not_even, true, NULL },
>   	{ NULL, NULL, false, NULL },

