Return-Path: <linux-s390+bounces-8578-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6720CA1A0F6
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 10:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55831188DD06
	for <lists+linux-s390@lfdr.de>; Thu, 23 Jan 2025 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F7820CCCD;
	Thu, 23 Jan 2025 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TR8YmfOq"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5420C48D;
	Thu, 23 Jan 2025 09:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737625290; cv=none; b=Gc9bi/9//P/l8td1Z9O3grBtE8xlO5NyIlkaP5v46sfYMkiUUHMmZYuZpTW0C3TEP8iXmQRYBIPSPzS20Wfr3DftDCAg+H7/YmPjlRKdFvDJLjw11XQ+stfz8Fe01EhkclLPwF9s9CR6mEAZApAv4iwQC9YxMAXREdEZR1PaLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737625290; c=relaxed/simple;
	bh=ZXEK66f/kI7Jj0on4IUo5Ogt0GqVvL/YG5sbLnbZsBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIGWYRGHl9rmb2lYEl1K2nRFddXzXjx6tQ4EEfNptrDFbQGbD+EbsvS6Vwo3NVBDwuuwcl+yLJ4TGFn6LV5k5IBCTFLAk32DanKarQ3F09vHS1mHUJ7214syszB3sr98DNO2vHOZlpQdsFYl4ZIGv5q/Rur6KOZBvFXAEeS+XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TR8YmfOq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5O2qT026487;
	Thu, 23 Jan 2025 09:40:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BkAMvB
	ka9lz7qA1vfG9q4Q/Fh4/ZUTAlk7oKlinox1I=; b=TR8YmfOqwnRiuSaQD5JCC8
	iRhfBLl/6sDvkevMOl/a3M1jucZ9tRLXWb9pVFZ44CHcBGP3L+9stn+N1IL2ZG7t
	F+7IVbplzeIbftdPK6Iz3cRkMqW5ZP7uZfIuibww+rEUExGXmK1XDQnLGz0Fn/xZ
	uzAcjDP8vy5f2UyphRlln5O63OcHsI8Ygy9BdIw1jCrnI8BbPEUZ11Ud0uUm0zgZ
	aPOimWQbY0uk0FeWqK1iCZebJ4zvaejxIwuWOVFihr8DKNGpcgjJNH1bSTfZpQtc
	pKLYFna5GtxFEduzAFb91D6EoE0cJECqMvypjkvg7Fd113VG5R8Z+PVShw5cBh6A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44bfk7s3r9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 09:40:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50N5rm19024241;
	Thu, 23 Jan 2025 09:40:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yd0qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jan 2025 09:40:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50N9eg7F32768342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 09:40:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647D02004B;
	Thu, 23 Jan 2025 09:40:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC7D20043;
	Thu, 23 Jan 2025 09:40:39 +0000 (GMT)
Received: from [9.203.114.244] (unknown [9.203.114.244])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jan 2025 09:40:39 +0000 (GMT)
Message-ID: <02f48a21-2dc6-457d-b8a5-bafb9dbb64c2@linux.ibm.com>
Date: Thu, 23 Jan 2025 15:10:37 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hugetlb: bring gigantic page allocation under
 hugepages_supported()
To: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: akpm@linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20250121150419.1342794-1-sourabhjain@linux.ibm.com>
 <20250122150613.28a92438@thinkpad-T15>
 <f6576f1c-bba3-44cc-bcb4-95318d2ece5c@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <f6576f1c-bba3-44cc-bcb4-95318d2ece5c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AO_UvKkwcxoYsdky9iPtWgvMAHp3_3YT
X-Proofpoint-ORIG-GUID: AO_UvKkwcxoYsdky9iPtWgvMAHp3_3YT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_04,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=938
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501230072



On 23/01/25 9:00 am, Sourabh Jain wrote:
> Hello Gerald,
> 
> On 22/01/25 19:36, Gerald Schaefer wrote:
>> On Tue, 21 Jan 2025 20:34:19 +0530
>> Sourabh Jain <sourabhjain@linux.ibm.com> wrote:
>>
>>> Despite having kernel arguments to enable gigantic hugepages, this
>>> provides a way for the architecture to disable gigantic hugepages on the
>>> fly, similar to what we do for hugepages.
>>>
>>> Components like fadump (PowerPC-specific) need this functionality to
>>> disable gigantic hugepages when the kernel is booted solely to collect
>>> the kernel core dump.
>>>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Ingo Molnar <mingo@redhat.com>
>>> Cc: Borislav Petkov <bp@alien8.de>
>>> Cc: Heiko Carstens <hca@linux.ibm.com>
>>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>>> Cc: Muchun Song <muchun.song@linux.dev>
>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> ---
>>>
>>> To evaluate the impact of this change on architectures other than
>>> PowerPC, I did the following analysis:
>>>
>>> For architectures where hugepages_supported() is not redefined, it
>>> depends on HPAGE_SHIFT, which is found to be a constant. It is mostly
>>> initialized to PMD_SHIFT.
>>>
>>> Architecture : HPAGE_SHIFT initialized with
>>>
>>> ARC: PMD_SHIFT (constant)
>>> ARM: PMD_SHIFT (constant)
>>> ARM64: PMD_SHIFT (constant)
>>> Hexagon: 22 (constant)
>>> LoongArch: (PAGE_SHIFT + PAGE_SHIFT - 3) (appears to be constant)
>>> MIPS: (PAGE_SHIFT + PAGE_SHIFT - 3) (appears to be constant)
>>> PARISC: PMD_SHIFT (appears to be constant)
>>> RISC-V: PMD_SHIFT (constant)
>>> SH: 16 | 18 | 20 | 22 | 26 (constant)
>>> SPARC: 23 (constant)
>>>
>>> So seems like this change shouldn't have any impact on above
>>> architectures.
>>>
>>> On the S390 and X86 architectures, hugepages_supported() is redefined,
>>> and I am uncertain at what point it is safe to call
>>> hugepages_supported().
>> For s390, hugepages_supported() checks EDAT1 machine flag, which is
>> initialized long before any initcalls. So it is safe to be called
>> here.
> Thanks for the info.
>>
>> My common code hugetlb skills got a little rusty, but shouldn't
>> arch_hugetlb_valid_size() already prevent getting here for gigantic
>> hugepages, in case they are not supported? And could you not use
>> that for your purpose?
> 
> Yes, handling this in arch_hugetlb_valid_size is even better. That way,
> we can avoid initializing data structures to hold hstate, which is not
> required anyway.
> 
> Thanks for the review and suggestion. I will handle this in the
> architecture-specific code.

Yeah, adding a check for hugetlb_disabled in arch_hugetlb_valid_size()
should take care of things?

- Hari

