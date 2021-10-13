Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340DF42BD3A
	for <lists+linux-s390@lfdr.de>; Wed, 13 Oct 2021 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhJMKlS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 13 Oct 2021 06:41:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45230 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhJMKlR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 06:41:17 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DA0bAG022180;
        Wed, 13 Oct 2021 06:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=J4MxnS8InZKcZ1OFq0Imth5gt8E2J7+SFOjHNCCTnSA=;
 b=Pp1pPjg8cf8b/7t5e3PLHkhsSaXfGNrugOoSkGzJtZAoTQZAJBiJM1nB9wJTa7+cuX+G
 7b70PmXGHQGadyz0aKdzfb+h4I49QEvuEHYao2RXE1iuQ80yUQ6W51As07VCb4yuMPTk
 5L/lziyQqRre4QR6ntUV/AlW/O3nBqQpkRYfIHJlMuCJmZJ6IFJOq9Lli7YpyloD0uBD
 pZN7+1BysEysyKCkKyTXgg97XMx5giiJxerONkrz9KYJ7Dn/gzjNdicHFxAUqSvQZ209
 xbMHjViTwtPyD1uzmmzD3Vu/tTRlwododHMtpJfK8kLT6LMWtO76rDWr8nma6FyTNSiI Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bns3f6497-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 06:39:13 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19DAFQtS017409;
        Wed, 13 Oct 2021 06:39:13 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bns3f648t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 06:39:13 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DAaAXU018700;
        Wed, 13 Oct 2021 10:39:11 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3bk2bjhusp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 10:39:11 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DAd0jX3801850
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 10:39:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 231314C07C;
        Wed, 13 Oct 2021 10:39:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B82634C070;
        Wed, 13 Oct 2021 10:38:59 +0000 (GMT)
Received: from [9.145.94.172] (unknown [9.145.94.172])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 10:38:59 +0000 (GMT)
Message-ID: <29d260f4-217f-2f37-d734-fa9765db95d9@linux.ibm.com>
Date:   Wed, 13 Oct 2021 12:38:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [kvm-unit-tests PATCH 2/2] lib: s390x: snippet.h: Add a few
 constants that will make our life easier
Content-Language: en-US
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com,
        thuth@redhat.com, seiden@linux.ibm.com
References: <20211013102722.17160-1-frankja@linux.ibm.com>
 <20211013102722.17160-3-frankja@linux.ibm.com>
 <20211013123558.40433784@p-imbrenda>
From:   Janosch Frank <frankja@linux.ibm.com>
In-Reply-To: <20211013123558.40433784@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o_0Yuoa-Zb8sgEBft8Y8hxxwJN_UnqLf
X-Proofpoint-ORIG-GUID: kGDTE9HxryUrcA2MUNVv_PLSI9XJ4hIV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_03,2021-10-13_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130071
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/13/21 12:35, Claudio Imbrenda wrote:
> On Wed, 13 Oct 2021 10:27:22 +0000
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> The variable names for the snippet objects are of gigantic length so
>> let's define a few macros to make them easier to read.
>>
>> Also add a standard PSW which should be used to start the snippet.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>> ---
>>   lib/s390x/snippet.h | 40 ++++++++++++++++++++++++++++++++++++++++
>>   s390x/mvpg-sie.c    | 13 ++++++-------
>>   2 files changed, 46 insertions(+), 7 deletions(-)
>>   create mode 100644 lib/s390x/snippet.h
>>
>> diff --git a/lib/s390x/snippet.h b/lib/s390x/snippet.h
>> new file mode 100644
>> index 00000000..9ead4fe3
>> --- /dev/null
>> +++ b/lib/s390x/snippet.h
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Snippet definitions
>> + *
>> + * Copyright IBM, Corp. 2021
>> + * Author: Janosch Frank <frankja@linux.ibm.com>
>> + */
>> +
>> +#ifndef _S390X_SNIPPET_H_
>> +#define _S390X_SNIPPET_H_
>> +
>> +/* This macro cuts down the length of the pointers to snippets */
>> +#define SNIPPET_NAME_START(type, file) \
>> +	_binary_s390x_snippets_##type##_##file##_gbin_start
>> +#define SNIPPET_NAME_END(type, file) \
>> +	_binary_s390x_snippets_##type##_##file##_gbin_end
>> +
>> +/* Returns the length of the snippet */
>> +#define SNIPPET_LEN(type, file) \
>> +	(uintptr_t)SNIPPET_NAME_END(type, file) - (uintptr_t)SNIPPET_NAME_START(type, file)
> 
> parentheses around the expansion:
> 	((uintptr_t)SNIPPET_NAME_END(type, file) - (uintptr_t)SNIPPET_NAME_START(type, file))
> 

Will do

>> +
>> +/*
>> + * C snippet instructions start at 0x4000 due to the prefix and the
>> + * stack being before that.
>> + */
>> +#define SNIPPET_C_ENTRY_ADDR 0x4000
>> +/* ASM snippets only have the prefix and hence start at 0x2000 */
> 
> wouldn't it be possible to make both start at the same address?
> would make everything easier.

Sure, for the ASM snippets the entry address only depends on where you 
copy them if I'm not mistaken.

> 
> ASM snippets would have a couple of unused pages, but who cares?
> 
>> +#define SNIPPET_ASM_ENTRY_ADDR 0x2000
>> +
>> +/* Standard entry PSWs for snippets which can simply be copied into the guest PSW */
>> +static const struct psw snippet_c_psw = {
>> +	.mask = PSW_MASK_64,
>> +	.addr = SNIPPET_C_ENTRY_ADDR,
>> +};
>> +
>> +static const struct psw snippet_asm_psw = {
>> +	.mask = PSW_MASK_64,
>> +	.addr = SNIPPET_ASM_ENTRY_ADDR,
>> +};
>> +#endif
>> diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
>> index 5adcec1e..46170d02 100644
>> --- a/s390x/mvpg-sie.c
>> +++ b/s390x/mvpg-sie.c
>> @@ -19,6 +19,7 @@
>>   #include <vm.h>
>>   #include <sclp.h>
>>   #include <sie.h>
>> +#include <snippet.h>
>>   
>>   static u8 *guest;
>>   static struct vm vm;
>> @@ -27,8 +28,8 @@ static uint8_t *src;
>>   static uint8_t *dst;
>>   static uint8_t *cmp;
>>   
>> -extern const char _binary_s390x_snippets_c_mvpg_snippet_gbin_start[];
>> -extern const char _binary_s390x_snippets_c_mvpg_snippet_gbin_end[];
>> +extern const char SNIPPET_NAME_START(c, mvpg_snippet)[];
>> +extern const char SNIPPET_NAME_END(c, mvpg_snippet)[];
>>   int binary_size;
>>   
>>   static void test_mvpg_pei(void)
>> @@ -77,10 +78,9 @@ static void test_mvpg_pei(void)
>>   
>>   static void test_mvpg(void)
>>   {
>> -	int binary_size = ((uintptr_t)_binary_s390x_snippets_c_mvpg_snippet_gbin_end -
>> -			   (uintptr_t)_binary_s390x_snippets_c_mvpg_snippet_gbin_start);
>> +	int binary_size = SNIPPET_LEN(c, mvpg_snippet);
>>   
>> -	memcpy(guest, _binary_s390x_snippets_c_mvpg_snippet_gbin_start, binary_size);
>> +	memcpy(guest, SNIPPET_NAME_START(c, mvpg_snippet), binary_size);
>>   	memset(src, 0x42, PAGE_SIZE);
>>   	memset(dst, 0x43, PAGE_SIZE);
>>   	sie(&vm);
>> @@ -96,8 +96,7 @@ static void setup_guest(void)
>>   
>>   	sie_guest_create(&vm, (uint64_t)guest, HPAGE_SIZE);
>>   
>> -	vm.sblk->gpsw.addr = PAGE_SIZE * 4;
>> -	vm.sblk->gpsw.mask = PSW_MASK_64;
>> +	vm.sblk->gpsw = snippet_c_psw;
>>   	vm.sblk->ictl = ICTL_OPEREXC | ICTL_PINT;
>>   	/* Enable MVPG interpretation as we want to test KVM and not ourselves */
>>   	vm.sblk->eca = ECA_MVPGI;
> 

