Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085AC23C5E7
	for <lists+linux-s390@lfdr.de>; Wed,  5 Aug 2020 08:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHEGdl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 5 Aug 2020 02:33:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHEGdl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Aug 2020 02:33:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0756UsTo155366;
        Wed, 5 Aug 2020 02:33:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32qkgjna1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 02:33:35 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0756U9kZ030194;
        Wed, 5 Aug 2020 06:33:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 32n0184309-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 06:33:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0756XVgc20316616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 06:33:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1BF4204B;
        Wed,  5 Aug 2020 06:33:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8583B42047;
        Wed,  5 Aug 2020 06:33:31 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed,  5 Aug 2020 06:33:31 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        hca@linux.ibm.com
Subject: Re: [PATCH v3 3/3] s390: convert to GENERIC_VDSO
References: <20200804150124.41692-1-svens@linux.ibm.com>
        <20200804150124.41692-4-svens@linux.ibm.com>
        <87tuxikuub.fsf@nanos.tec.linutronix.de>
Date:   Wed, 05 Aug 2020 08:33:31 +0200
In-Reply-To: <87tuxikuub.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Tue, 04 Aug 2020 22:41:00 +0200")
Message-ID: <yt9d8setsitg.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050054
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Thomas,

Thomas Gleixner <tglx@linutronix.de> writes:

> Sven Schnelle <svens@linux.ibm.com> writes:
>> --- /dev/null
>> +++ b/arch/s390/include/asm/vdso/data.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __S390_ASM_VDSO_DATA_H
>> +#define __S390_ASM_VDSO_DATA_H
>> +
>> +#include <linux/types.h>
>> +#include <vdso/datapage.h>
>
> I don't think this header needs vdso/datapage.h

Agreed.

>> +struct arch_vdso_data {
>> +	__u64 tod_steering_delta;
>> +	__u64 tod_steering_end;
>> +};
>> +
>> +#endif /* __S390_ASM_VDSO_DATA_H */
>
>> --- /dev/null
>> +++ b/arch/s390/include/asm/vdso/gettimeofday.h
>
>> +static inline u64 __arch_get_hw_counter(s32 clock_mode)
>> +{
>> +	const struct vdso_data *vdso = __arch_get_vdso_data();
>
> If you go and implement time namespace support for VDSO then this
> becomes a problem. See do_hres_timens().
>
> As we did not expect that this function needs vdso_data we should just
> add a vdso_data pointer argument to __arch_get_hw_counter(). And while
> looking at it you're not the first one. MIPS already uses it and because
> it does not support time namespaces so far nobody noticed yet.
>
> That's fine for all others because the compiler will optimize it
> out when it's unused. If the compiler fails to do so, then this is the
> least of our worries :)
>
> As there is no new VDSO conversion pending in next, I can just queue
> that (see below) along with #1 and #2 of this series and send it to
> Linus by end of the week.

Fine with me.

>> +	u64 adj, now;
>> +
>> +	now = get_tod_clock();
>> +	adj = vdso->arch.tod_steering_end - now;
>> +	if (unlikely((s64) adj > 0))
>> +		now += (vdso->arch.tod_steering_delta < 0) ? (adj >> 15) : -(adj >> 15);
>> +	return now;
>> +}
>
>
>> --- /dev/null
>> +++ b/arch/s390/include/asm/vdso/processor.h
>> @@ -0,0 +1,5 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +#ifndef __ASM_VDSO_PROCESSOR_H
>> +#define __ASM_VDSO_PROCESSOR_H
>> +
>> +#endif /* __ASM_VDSO_PROCESSOR_H */
>
> The idea of this file was to provide cpu_relax() self contained without
> pulling in tons of other things from asm/processor.h.

Thanks, i'll add that.

>> diff --git a/arch/s390/include/asm/vdso/vdso.h b/arch/s390/include/asm/vdso/vdso.h
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
>> diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
>> new file mode 100644
>> index 000000000000..6c67c08cefdd
>> --- /dev/null
>> +++ b/arch/s390/include/asm/vdso/vsyscall.h
>> @@ -0,0 +1,26 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __ASM_VDSO_VSYSCALL_H
>> +#define __ASM_VDSO_VSYSCALL_H
>> +
>> +#ifndef __ASSEMBLY__
>> +
>> +#include <linux/hrtimer.h>
>> +#include <linux/timekeeper_internal.h>
>
> I know you copied that from x86 or some other architecture, but thinking
> about the above these two includes are not required for building VDSO
> itself. Only the kernel update side needs them and they are included
> already there. I'm going to remove them from x86 as well.

Thanks, i removed them from my patch.

>> @@ -443,9 +396,8 @@ static void clock_sync_global(unsigned long long delta)
>>  		panic("TOD clock sync offset %lli is too large to drift\n",
>>  		      tod_steering_delta);
>>  	tod_steering_end = now + (abs(tod_steering_delta) << 15);
>> -	vdso_data->ts_dir = (tod_steering_delta < 0) ? 0 : 1;
>> -	vdso_data->ts_end = tod_steering_end;
>> -	vdso_data->tb_update_count++;
>> +	vdso_data->arch.tod_steering_end = tod_steering_end;
>
> Leftover from the previous version. Should be arch_data.tod....

Oops, indeed.

> Heiko, do you consider this 5.9 material or am I right to assume that
> this targets 5.10?

I talked to Heiko yesterday and we agreed that it's to late for 5.9, so
we target 5.10.

Thanks,
Sven
