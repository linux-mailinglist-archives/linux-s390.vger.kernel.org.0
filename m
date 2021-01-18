Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF8712FA387
	for <lists+linux-s390@lfdr.de>; Mon, 18 Jan 2021 15:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405029AbhAROsI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Jan 2021 09:48:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405256AbhAROrT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:47:19 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10IEXpF1081567
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=+FJNn6bV28blBKvX+3i74Qey9renzNwjJ+bwLH0DxcU=;
 b=VakaX+lVRwW+LZT6vTZatn09cH7J9D1L/mWZY78IZuYfzmn6XfmpLvZb4YiFzuiIBxw6
 nvZKO38Jlq57U7TalHeI89yHvKXb4AHrTEObk6fWbwMMSyBdT+yxmAj78oT94vdjs7J2
 AoCMVaXun1Bdn96FkF2BtyWANkam7PJt6rVUhDmLQowVUhvY3zc11Y+yfM3MgHEOgyL1
 Pt/bO+QPZMB51RyJzu3Kuk0XSqnvS5KLmMeEU2hKr4hdulvPa2LnqlaWVIfy0pqcRlq0
 BlYqi93mx72mYbHDvVTjNq7fNDB0AhTOOOF4XPoDi0UWo7OX2UBfqnSraBKUufSZpO+E qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365a0smgar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:46:38 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10IEY3Aa084514
        for <linux-s390@vger.kernel.org>; Mon, 18 Jan 2021 09:46:37 -0500
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 365a0smg9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 09:46:37 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10IEhV1E020911;
        Mon, 18 Jan 2021 14:46:35 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 363qs7j5f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Jan 2021 14:46:35 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10IEkWXA43057458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 14:46:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 322424204B;
        Mon, 18 Jan 2021 14:46:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6EA2B42042;
        Mon, 18 Jan 2021 14:46:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.77.2])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 Jan 2021 14:46:31 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix uv_call() exception behavior
To:     Thomas Huth <thuth@redhat.com>
Cc:     david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210118140344.3074-1-frankja@linux.ibm.com>
 <4d402c02-c75a-5a9e-6f02-87a513864e0d@redhat.com>
From:   Janosch Frank <frankja@linux.ibm.com>
Message-ID: <a962c32c-d6b3-85fd-93bf-b0da9d298e75@linux.ibm.com>
Date:   Mon, 18 Jan 2021 15:46:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4d402c02-c75a-5a9e-6f02-87a513864e0d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-18_13:2021-01-18,2021-01-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101180088
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 1/18/21 3:40 PM, Thomas Huth wrote:
> On 18/01/2021 15.03, Janosch Frank wrote:
>> On a program exception we usually skip the instruction that caused the
>> exception and continue. That won't work for UV calls since a "brc 3,0b"
>> will retry the instruction if the CC is > 1.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>
>> I know this isn't very pretty.
>> I'm open for suggestions.
>>
>> ---
>>   lib/s390x/asm/uv.h | 14 ++++++++------
>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
>> index 4c2fc48..252f1a3 100644
>> --- a/lib/s390x/asm/uv.h
>> +++ b/lib/s390x/asm/uv.h
>> @@ -53,21 +53,23 @@ struct uv_cb_share {
>>   static inline int uv_call(unsigned long r1, unsigned long r2)
>>   {
>>   	int cc;
>> +	struct lowcore *lc = 0x0;
>>   
>>   	/*
>> -	 * The brc instruction will take care of the cc 2/3 case where
>> -	 * we need to continue the execution because we were
>> -	 * interrupted. The inline assembly will only return on
>> -	 * success/error i.e. cc 0/1.
>> -	*/
>> +	 * CC 2 and 3 tell us to re-execute because the instruction
>> +	 * hasn't yet finished.
>> +	 */
>> +	lc->pgm_int_code = 0;
>> +retry:
>>   	asm volatile(
>>   		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
>> -		"		brc	3,0b\n"
>>   		"		ipm	%[cc]\n"
>>   		"		srl	%[cc],28\n"
>>   		: [cc] "=d" (cc)
>>   		: [r1] "a" (r1), [r2] "a" (r2)
>>   		: "memory", "cc");
>> +	if (!lc->pgm_int_code && cc > 1)
>> +		goto retry;
> 
> Why not simply:
> 
> 	do {
> 		asm volatile(...);
> 	} while (!lc->pgm_int_code && cc > 1)
> 
> ?

That would also be an option but it would basically be the same horrible
looking quick fix.

Claudio proposed implementing a one shot uv_call that doesn't branch
back. We should be able to use that purely for privilege checks.

> 
>    Thomas
> 

