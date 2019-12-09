Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29D521168AC
	for <lists+linux-s390@lfdr.de>; Mon,  9 Dec 2019 09:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfLIIx3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 9 Dec 2019 03:53:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbfLIIx3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Dec 2019 03:53:29 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB98qP0a107955
        for <linux-s390@vger.kernel.org>; Mon, 9 Dec 2019 03:53:28 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrtdp1293-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 09 Dec 2019 03:53:27 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pmorel@linux.ibm.com>;
        Mon, 9 Dec 2019 08:53:26 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 9 Dec 2019 08:53:24 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB98rNgZ42074182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Dec 2019 08:53:23 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4A05204F;
        Mon,  9 Dec 2019 08:53:23 +0000 (GMT)
Received: from oc3016276355.ibm.com (unknown [9.152.222.89])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C40955205A;
        Mon,  9 Dec 2019 08:53:22 +0000 (GMT)
Subject: Re: [kvm-unit-tests PATCH v3 2/9] s390x: Define the PSW bits
To:     Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <1575649588-6127-1-git-send-email-pmorel@linux.ibm.com>
 <1575649588-6127-3-git-send-email-pmorel@linux.ibm.com>
 <4d034f27-0449-08ea-5b45-be91a788bd6d@redhat.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
Date:   Mon, 9 Dec 2019 09:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4d034f27-0449-08ea-5b45-be91a788bd6d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120908-0012-0000-0000-000003730C5D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120908-0013-0000-0000-000021AED9AE
Message-Id: <36847ac9-fef4-1eea-8b3a-d8a94a989a6e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_01:2019-12-09,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912090077
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 2019-12-06 17:29, Thomas Huth wrote:
> On 06/12/2019 17.26, Pierre Morel wrote:
>> Let's define the PSW bits explicitly, it will clarify their
>> usage.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
>> ---
>>   lib/s390x/asm/arch_def.h | 127 +++++++++++++++++++++------------------
>>   s390x/cstart64.S         |  13 ++--
>>   2 files changed, 74 insertions(+), 66 deletions(-)
>>
>> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
>> index cf6e1ca..1293640 100644
>> --- a/lib/s390x/asm/arch_def.h
>> +++ b/lib/s390x/asm/arch_def.h
>> @@ -10,20 +10,81 @@
>>   #ifndef _ASM_S390X_ARCH_DEF_H_
>>   #define _ASM_S390X_ARCH_DEF_H_
>>   
>> -struct psw {
>> -	uint64_t	mask;
>> -	uint64_t	addr;
>> -};
>> -
>>   #define PSW_MASK_EXT			0x0100000000000000UL
>>   #define PSW_MASK_DAT			0x0400000000000000UL
>>   #define PSW_MASK_PSTATE			0x0001000000000000UL
>> +#define PSW_MASK_IO			0x0200000000000000
>> +#define PSW_MASK_EA			0x0000000100000000
>> +#define PSW_MASK_BA			0x0000000080000000
>> +
>> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
>>   
>>   #define CR0_EXTM_SCLP			0X0000000000000200UL
>>   #define CR0_EXTM_EXTC			0X0000000000002000UL
>>   #define CR0_EXTM_EMGC			0X0000000000004000UL
>>   #define CR0_EXTM_MASK			0X0000000000006200UL
>>   
>> +#define PGM_INT_CODE_OPERATION			0x01
>> +#define PGM_INT_CODE_PRIVILEGED_OPERATION	0x02
>> +#define PGM_INT_CODE_EXECUTE			0x03
>> +#define PGM_INT_CODE_PROTECTION			0x04
>> +#define PGM_INT_CODE_ADDRESSING			0x05
>> +#define PGM_INT_CODE_SPECIFICATION		0x06
>> +#define PGM_INT_CODE_DATA			0x07
>> +#define PGM_INT_CODE_FIXED_POINT_OVERFLOW	0x08
>> +#define PGM_INT_CODE_FIXED_POINT_DIVIDE		0x09
>> +#define PGM_INT_CODE_DECIMAL_OVERFLOW		0x0a
>> +#define PGM_INT_CODE_DECIMAL_DIVIDE		0x0b
>> +#define PGM_INT_CODE_HFP_EXPONENT_OVERFLOW	0x0c
>> +#define PGM_INT_CODE_HFP_EXPONENT_UNDERFLOW	0x0d
>> +#define PGM_INT_CODE_HFP_SIGNIFICANCE		0x0e
>> +#define PGM_INT_CODE_HFP_DIVIDE			0x0f
>> +#define PGM_INT_CODE_SEGMENT_TRANSLATION	0x10
>> +#define PGM_INT_CODE_PAGE_TRANSLATION		0x11
>> +#define PGM_INT_CODE_TRANSLATION_SPEC		0x12
>> +#define PGM_INT_CODE_SPECIAL_OPERATION		0x13
>> +#define PGM_INT_CODE_OPERAND			0x15
>> +#define PGM_INT_CODE_TRACE_TABLE		0x16
>> +#define PGM_INT_CODE_VECTOR_PROCESSING		0x1b
>> +#define PGM_INT_CODE_SPACE_SWITCH_EVENT		0x1c
>> +#define PGM_INT_CODE_HFP_SQUARE_ROOT		0x1d
>> +#define PGM_INT_CODE_PC_TRANSLATION_SPEC	0x1f
>> +#define PGM_INT_CODE_AFX_TRANSLATION		0x20
>> +#define PGM_INT_CODE_ASX_TRANSLATION		0x21
>> +#define PGM_INT_CODE_LX_TRANSLATION		0x22
>> +#define PGM_INT_CODE_EX_TRANSLATION		0x23
>> +#define PGM_INT_CODE_PRIMARY_AUTHORITY		0x24
>> +#define PGM_INT_CODE_SECONDARY_AUTHORITY	0x25
>> +#define PGM_INT_CODE_LFX_TRANSLATION		0x26
>> +#define PGM_INT_CODE_LSX_TRANSLATION		0x27
>> +#define PGM_INT_CODE_ALET_SPECIFICATION		0x28
>> +#define PGM_INT_CODE_ALEN_TRANSLATION		0x29
>> +#define PGM_INT_CODE_ALE_SEQUENCE		0x2a
>> +#define PGM_INT_CODE_ASTE_VALIDITY		0x2b
>> +#define PGM_INT_CODE_ASTE_SEQUENCE		0x2c
>> +#define PGM_INT_CODE_EXTENDED_AUTHORITY		0x2d
>> +#define PGM_INT_CODE_LSTE_SEQUENCE		0x2e
>> +#define PGM_INT_CODE_ASTE_INSTANCE		0x2f
>> +#define PGM_INT_CODE_STACK_FULL			0x30
>> +#define PGM_INT_CODE_STACK_EMPTY		0x31
>> +#define PGM_INT_CODE_STACK_SPECIFICATION	0x32
>> +#define PGM_INT_CODE_STACK_TYPE			0x33
>> +#define PGM_INT_CODE_STACK_OPERATION		0x34
>> +#define PGM_INT_CODE_ASCE_TYPE			0x38
>> +#define PGM_INT_CODE_REGION_FIRST_TRANS		0x39
>> +#define PGM_INT_CODE_REGION_SECOND_TRANS	0x3a
>> +#define PGM_INT_CODE_REGION_THIRD_TRANS		0x3b
>> +#define PGM_INT_CODE_MONITOR_EVENT		0x40
>> +#define PGM_INT_CODE_PER			0x80
>> +#define PGM_INT_CODE_CRYPTO_OPERATION		0x119
>> +#define PGM_INT_CODE_TX_ABORTED_EVENT		0x200
>> +
>> +#ifndef __ASSEMBLER__
>> +struct psw {
>> +	uint64_t	mask;
>> +	uint64_t	addr;
>> +};
>> +
>>   struct lowcore {
>>   	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
>>   	uint32_t	ext_int_param;			/* 0x0080 */
>> @@ -101,61 +162,6 @@ struct lowcore {
>>   } __attribute__ ((__packed__));
>>   _Static_assert(sizeof(struct lowcore) == 0x1900, "Lowcore size");
>>   
>> -#define PGM_INT_CODE_OPERATION			0x01
>> -#define PGM_INT_CODE_PRIVILEGED_OPERATION	0x02
>> -#define PGM_INT_CODE_EXECUTE			0x03
>> -#define PGM_INT_CODE_PROTECTION			0x04
>> -#define PGM_INT_CODE_ADDRESSING			0x05
>> -#define PGM_INT_CODE_SPECIFICATION		0x06
>> -#define PGM_INT_CODE_DATA			0x07
>> -#define PGM_INT_CODE_FIXED_POINT_OVERFLOW	0x08
>> -#define PGM_INT_CODE_FIXED_POINT_DIVIDE		0x09
>> -#define PGM_INT_CODE_DECIMAL_OVERFLOW		0x0a
>> -#define PGM_INT_CODE_DECIMAL_DIVIDE		0x0b
>> -#define PGM_INT_CODE_HFP_EXPONENT_OVERFLOW	0x0c
>> -#define PGM_INT_CODE_HFP_EXPONENT_UNDERFLOW	0x0d
>> -#define PGM_INT_CODE_HFP_SIGNIFICANCE		0x0e
>> -#define PGM_INT_CODE_HFP_DIVIDE			0x0f
>> -#define PGM_INT_CODE_SEGMENT_TRANSLATION	0x10
>> -#define PGM_INT_CODE_PAGE_TRANSLATION		0x11
>> -#define PGM_INT_CODE_TRANSLATION_SPEC		0x12
>> -#define PGM_INT_CODE_SPECIAL_OPERATION		0x13
>> -#define PGM_INT_CODE_OPERAND			0x15
>> -#define PGM_INT_CODE_TRACE_TABLE		0x16
>> -#define PGM_INT_CODE_VECTOR_PROCESSING		0x1b
>> -#define PGM_INT_CODE_SPACE_SWITCH_EVENT		0x1c
>> -#define PGM_INT_CODE_HFP_SQUARE_ROOT		0x1d
>> -#define PGM_INT_CODE_PC_TRANSLATION_SPEC	0x1f
>> -#define PGM_INT_CODE_AFX_TRANSLATION		0x20
>> -#define PGM_INT_CODE_ASX_TRANSLATION		0x21
>> -#define PGM_INT_CODE_LX_TRANSLATION		0x22
>> -#define PGM_INT_CODE_EX_TRANSLATION		0x23
>> -#define PGM_INT_CODE_PRIMARY_AUTHORITY		0x24
>> -#define PGM_INT_CODE_SECONDARY_AUTHORITY	0x25
>> -#define PGM_INT_CODE_LFX_TRANSLATION		0x26
>> -#define PGM_INT_CODE_LSX_TRANSLATION		0x27
>> -#define PGM_INT_CODE_ALET_SPECIFICATION		0x28
>> -#define PGM_INT_CODE_ALEN_TRANSLATION		0x29
>> -#define PGM_INT_CODE_ALE_SEQUENCE		0x2a
>> -#define PGM_INT_CODE_ASTE_VALIDITY		0x2b
>> -#define PGM_INT_CODE_ASTE_SEQUENCE		0x2c
>> -#define PGM_INT_CODE_EXTENDED_AUTHORITY		0x2d
>> -#define PGM_INT_CODE_LSTE_SEQUENCE		0x2e
>> -#define PGM_INT_CODE_ASTE_INSTANCE		0x2f
>> -#define PGM_INT_CODE_STACK_FULL			0x30
>> -#define PGM_INT_CODE_STACK_EMPTY		0x31
>> -#define PGM_INT_CODE_STACK_SPECIFICATION	0x32
>> -#define PGM_INT_CODE_STACK_TYPE			0x33
>> -#define PGM_INT_CODE_STACK_OPERATION		0x34
>> -#define PGM_INT_CODE_ASCE_TYPE			0x38
>> -#define PGM_INT_CODE_REGION_FIRST_TRANS		0x39
>> -#define PGM_INT_CODE_REGION_SECOND_TRANS	0x3a
>> -#define PGM_INT_CODE_REGION_THIRD_TRANS		0x3b
>> -#define PGM_INT_CODE_MONITOR_EVENT		0x40
>> -#define PGM_INT_CODE_PER			0x80
>> -#define PGM_INT_CODE_CRYPTO_OPERATION		0x119
>> -#define PGM_INT_CODE_TX_ABORTED_EVENT		0x200
> 
> This patch definitely does more than you've mentioned in the patch
> description. Please avoid the movement of the PGM definitions here and
> move that into a separate patch (if it is really necessary).
> 
>   Thomas
> 

OK, thanks,

Pierre

-- 
Pierre Morel
IBM Lab Boeblingen

