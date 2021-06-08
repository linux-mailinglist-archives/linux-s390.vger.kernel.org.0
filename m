Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD439F63F
	for <lists+linux-s390@lfdr.de>; Tue,  8 Jun 2021 14:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbhFHMUV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Jun 2021 08:20:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232211AbhFHMUV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Jun 2021 08:20:21 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 158C3CM6063447;
        Tue, 8 Jun 2021 08:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Opf4Ctek6JihCniOnw0YkjAsjK8FjoVK5qhyv2Cctas=;
 b=KAuYf9YSuXZsLBcNw3pJIByiGwnvtS5puX3C8TDeRFOwQv0Rob/Ou7fln2RfGVLRqp/B
 18kQvV5QaWKyej0EqtPyLXy6dVZQQpAf+RvBaU2XxZNvkgJ/wfBKtLoFWyxwF514c7cK
 0xTlVKfmtBNlUAYVasPrCfb8gIFX4mTc0Dw1mD8Ry+EfPHaxrEKo0cTA2ULvRNaXuHj2
 0H9O0mLi4O66TyXaDuLkNOg1zGP1KfGRKb5goIk+fy3KeS0LlwxariMGlAGR4iQkhx8n
 Scpivqljlct7T3EGuKF9J3x5To9KO+gV2o/wmInVGdYYt8uk6Z4dECBUhLAuxAFqx0yv Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3927r91cvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 08:18:27 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 158C3FRj063782;
        Tue, 8 Jun 2021 08:18:27 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3927r91cv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 08:18:27 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 158CC3Ff018715;
        Tue, 8 Jun 2021 12:18:25 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3900w89gue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Jun 2021 12:18:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 158CIMm613959630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Jun 2021 12:18:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FCBCA405F;
        Tue,  8 Jun 2021 12:18:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4D7CA407B;
        Tue,  8 Jun 2021 12:18:21 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.171.36.114])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Jun 2021 12:18:21 +0000 (GMT)
Subject: Re: [PATCH] KVM: selftests: introduce P47V64 for s390x
To:     pbonzini@redhat.com
Cc:     bgardon@google.com, dmatlack@google.com, drjones@redhat.com,
        frankja@linux.ibm.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, peterx@redhat.com,
        venkateshs@chromium.org
References: <4d6513f3-d921-dff0-d883-51c6dbdcbe39@de.ibm.com>
 <20210608114546.6419-1-borntraeger@de.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <264e8e21-059b-d869-28bb-3d8f33b8459c@de.ibm.com>
Date:   Tue, 8 Jun 2021 14:18:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210608114546.6419-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -PPwLt4uR16sQwAynogWlhZ_64EmetN2
X-Proofpoint-GUID: HKeuFq2TvGJPbIM0HWA-6L9lCCUCfUmm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_09:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080081
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 08.06.21 13:45, Christian Borntraeger wrote:
> s390x can have up to 47bits of physical guest and 64bits of virtual
> address  bits. Add a new address mode to avoid errors of testcases
> going beyond 47bits.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>   tools/testing/selftests/kvm/include/kvm_util.h | 3 ++-
>   tools/testing/selftests/kvm/lib/kvm_util.c     | 5 +++++
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
> index fcd8e3855111..6d3f71822976 100644
> --- a/tools/testing/selftests/kvm/include/kvm_util.h
> +++ b/tools/testing/selftests/kvm/include/kvm_util.h
> @@ -43,6 +43,7 @@ enum vm_guest_mode {
>   	VM_MODE_P40V48_4K,
>   	VM_MODE_P40V48_64K,
>   	VM_MODE_PXXV48_4K,	/* For 48bits VA but ANY bits PA */
> +	VM_MODE_P47V64_4K,	/* For 48bits VA but ANY bits PA */
>   	NUM_VM_MODES,
>   };
>   
> @@ -60,7 +61,7 @@ enum vm_guest_mode {
>   
>   #elif defined(__s390x__)
>   
> -#define VM_MODE_DEFAULT			VM_MODE_P52V48_4K
> +#define VM_MODE_DEFAULT			VM_MODE_P47V64_4K
>   #define MIN_PAGE_SHIFT			12U
>   #define ptes_per_page(page_size)	((page_size) / 16)
>   
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 28e528c19d28..d61ad15b1979 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -175,6 +175,7 @@ const char *vm_guest_mode_string(uint32_t i)
>   		[VM_MODE_P40V48_4K]	= "PA-bits:40,  VA-bits:48,  4K pages",
>   		[VM_MODE_P40V48_64K]	= "PA-bits:40,  VA-bits:48, 64K pages",
>   		[VM_MODE_PXXV48_4K]	= "PA-bits:ANY, VA-bits:48,  4K pages",
> +		[VM_MODE_P47V64_4K]	= "PA-bits:47,  VA-bits:64,  4K pages",
>   	};
>   	_Static_assert(sizeof(strings)/sizeof(char *) == NUM_VM_MODES,
>   		       "Missing new mode strings?");
> @@ -192,6 +193,7 @@ const struct vm_guest_mode_params vm_guest_mode_params[] = {
>   	{ 40, 48,  0x1000, 12 },
>   	{ 40, 48, 0x10000, 16 },
>   	{  0,  0,  0x1000, 12 },
> +	{ 47, 64,  0x1000, 12 },
>   };
>   _Static_assert(sizeof(vm_guest_mode_params)/sizeof(struct vm_guest_mode_params) == NUM_VM_MODES,
>   	       "Missing new mode params?");
> @@ -277,6 +279,9 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
>   		TEST_FAIL("VM_MODE_PXXV48_4K not supported on non-x86 platforms");
>   #endif
>   		break;
> +	case VM_MODE_P47V64_4K:
> +		vm->pgtable_levels = 4;

I will change that to 5 as well.
