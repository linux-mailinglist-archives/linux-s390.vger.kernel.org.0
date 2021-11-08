Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE33447F3B
	for <lists+linux-s390@lfdr.de>; Mon,  8 Nov 2021 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhKHMHK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Nov 2021 07:07:10 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62308 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238065AbhKHMHK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Nov 2021 07:07:10 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A89pie0029876;
        Mon, 8 Nov 2021 12:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ABj6WWHoy5NYOjly/Rg2UGvcVE/acbZzY0wzCJocWc0=;
 b=DUiuMLbqT8hCxJ4YptJyCZ3DlqDA9BDYxRKPHSuUaM1JL3KsJFC5quqky0LJNFFOnX1L
 JZ9HrvcfqbjXXu5WOAv2W1forkcixF8J5XR97oeUgwSdEW3326bOJjPw4xxX2DOalz3X
 zM7YYEMhA1XhJ2JsuANnA7CTlmk6ESLACDdo0PCAposJaartNlUfRmSPVw6eIRr2yu6h
 RhIJPUikqCrOjxeftVCmrrtQiZx1WbVX/HW8464CUtP2gd35M1AGwNbTy21/9dG6FuHp
 cd69VeMXLpaYZRFbBnXnDm1LEgfdfYUTjJSSj5X2VFvr2SX50wCbLww2xVS3rHI5SrT2 fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c6aspanbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 12:04:25 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1A8BQ2qn017845;
        Mon, 8 Nov 2021 12:04:25 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3c6aspanat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 12:04:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1A8Bvlh8017292;
        Mon, 8 Nov 2021 12:04:23 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 3c5hb9wmdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Nov 2021 12:04:23 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1A8C4KJY18481502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Nov 2021 12:04:20 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C09652052;
        Mon,  8 Nov 2021 12:04:20 +0000 (GMT)
Received: from [9.171.16.13] (unknown [9.171.16.13])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id D3A2652051;
        Mon,  8 Nov 2021 12:04:19 +0000 (GMT)
Message-ID: <28d90d6f-b481-3588-cd33-39624710b7bd@de.ibm.com>
Date:   Mon, 8 Nov 2021 13:04:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] KVM: s390x: add debug statement for diag 318 CPNC data
Content-Language: en-US
To:     Janosch Frank <frankja@linux.ibm.com>,
        Collin Walling <walling@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     david@redhat.com, imbrenda@linux.ibm.com
References: <20211027025451.290124-1-walling@linux.ibm.com>
 <4488b572-11bf-72ff-86c0-395dfc7b3f71@linux.ibm.com>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <4488b572-11bf-72ff-86c0-395dfc7b3f71@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LPSBHzTXrdxt-1mdeI2BHXSBXjrAoNTY
X-Proofpoint-GUID: sPFWq_9dN4NqtcezwgFbz-H0XuzNmui9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-08_03,2021-11-08_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111080076
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



Am 08.11.21 um 12:12 schrieb Janosch Frank:
> On 10/27/21 04:54, Collin Walling wrote:
>> The diag 318 data contains values that denote information regarding the
>> guest's environment. Currently, it is unecessarily difficult to observe
>> this value (either manually-inserted debug statements, gdb stepping, mem
>> dumping etc). It's useful to observe this information to obtain an
>> at-a-glance view of the guest's environment, so lets add a simple VCPU
>> event that prints the CPNC to the s390dbf logs.
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6a6dd5e1daf6..da3ff24eabd0 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -4254,6 +4254,7 @@ static void sync_regs_fmt2(struct kvm_vcpu *vcpu)
>>       if (kvm_run->kvm_dirty_regs & KVM_SYNC_DIAG318) {
>>           vcpu->arch.diag318_info.val = kvm_run->s.regs.diag318;
>>           vcpu->arch.sie_block->cpnc = vcpu->arch.diag318_info.cpnc;
>> +        VCPU_EVENT(vcpu, 2, "setting cpnc to %d", vcpu->arch.diag318_info.cpnc);
>>       }
>>       /*
>>        * If userspace sets the riccb (e.g. after migration) to a valid state,
>>
> 
> Won't that turn up for every vcpu and spam the log?

only if the userspace always sets the dirty bit (which it should not).
