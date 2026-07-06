Return-Path: <linux-s390+bounces-21650-lists+linux-s390=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-s390@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 24CWAZycS2q9WwEAu9opvQ
	(envelope-from <linux-s390+bounces-21650-lists+linux-s390=lfdr.de@vger.kernel.org>)
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 14:16:28 +0200
X-Original-To: lists+linux-s390@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC4710621
	for <lists+linux-s390@lfdr.de>; Mon, 06 Jul 2026 14:16:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=trQj4Uqc;
	dmarc=pass (policy=none) header.from=ibm.com;
	spf=pass (mail.lfdr.de: domain of "linux-s390+bounces-21650-lists+linux-s390=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-s390+bounces-21650-lists+linux-s390=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F31730071FF
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jul 2026 12:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4252D42377A;
	Mon,  6 Jul 2026 12:16:10 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76512C0F6C;
	Mon,  6 Jul 2026 12:16:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783340170; cv=none; b=eflnwz/UZfBMnBgmsR/8bNG8ZWekG0MejSebhQ8njShwttw+tzEB4GrLCXCiguElXEWIJFrQ4wVIywmzy7i3v1UEPNIKN0ceW+N+iVuAia+TM6BO2dcuY4ZM66QalyqctyZ4O+dv7F6TKR/yZa6CWG0tZYAlx5A18hvbxbaovfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783340170; c=relaxed/simple;
	bh=nm/F2nTaUxoWYUST3596aNSIo5IVASvCgv+CtyAOv/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y973jLPNJc+JVT+kjijydxjaZlz6bJ0UCgHJwIs9NBMG00OI+WxQ8pMlrqUPR0rOjZUQFpSoWhM0OWUOIBySQ40GbrlrszO1MA71ATAupZSCgN20+B2bHOWjtVgUDscFO8ot/fLHoQ87sZ35UyuL3j318ax6+phU4XWqy+tFv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=trQj4Uqc; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIOD33465244;
	Mon, 6 Jul 2026 12:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7gmy4C
	PRHm3jqZJsv5jigI35IHg15IAOTrRNJJTAI2M=; b=trQj4Uqch1bfQDnFE8raSS
	3Xtu/L6DMn9sxWYZxu1Uil5gNAQ2gU+BRKvCv8hEWxaJCe+0HgZOkeWnqSkeTcWz
	t1M0lBZTSpKLKVq+sOhLfmivoTe8eU/kVqcIAgQdp5rx0yOx6FPUA/BOUdcFcCtX
	6wzUITXNqXIvOX9Zbs40NjqQYEfvC5wl4v+G9AXf/Kv9eRaE7lFFlycqUf01SBSM
	tewmKhVMzxacWTaj7i+cCQF0DkB4/RohXD2UG9yxGGqE3TGdPNuR2SSrvpa3vwny
	c6aNY80TY6QEGAXee8dSIXaNL1gQLcTSEQizhs4RTox9tRjVVsomd9/Pl3S3dr0A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdhxfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:15:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666C4dix015153;
	Mon, 6 Jul 2026 12:15:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfw8mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 12:15:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666CFgSQ29688268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 12:15:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFE7720043;
	Mon,  6 Jul 2026 12:15:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2865D2004B;
	Mon,  6 Jul 2026 12:15:41 +0000 (GMT)
Received: from [9.87.152.232] (unknown [9.87.152.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 12:15:41 +0000 (GMT)
Message-ID: <f66efe81-cd11-4bfa-aa72-c5c1f2850343@linux.ibm.com>
Date: Mon, 6 Jul 2026 14:15:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/27] KVM: s390: arm64: Implement required functions
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-24-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260706085229.979525-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b9c76 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=XTNHhXoCNXvMEjF8tJMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfX69rDwgYN4VvW
 qNnbBCU/e85RZjbo5eNAoyA8J4XgUPqkIKXRJk4wD1Wbkn5AsUdwnIKdP7IYXzSd5JkykAe0fEa
 fBfKl7CO61g599aRmU0F+Pt0GUVtZP3BYaIRKpOI9hly08u4OdNWmPjWlRIaaZWmodOadE79VwY
 Ah0GCV5sZ5frUXrXOyUaW5eRBs92m+PmU1m2B9lyzbVwBgVIkoLuBoy2Nh3+iuHrt1GWQMw6+az
 sZ3P3H6Xd+XJ00wPOvQUbiN/zER6FURFtzZjd1olc67PENRM4pR/l3AGj5H5NG1+EAjwE8ehnHJ
 X7WgUF1ZNj6A/WhkIM8/J1SjjINdjhkdSewRRxkzWY420aVlnFvvcwio+vYI/81H8zRVkUVF03N
 NKNpqYlH+LYmXAORLAQDA4RqIEiJmlEIa8QltMuIrnEPzgVUr93fjugokzoaL/HdK86ZiPYaOav
 HS3LFwdDZxry3V6tvFw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEyMCBTYWx0ZWRfX+RJCwijO6USa
 DPqcCKbH+sqnYBiJvcE4zTuBRy2XTK2IJapL4eld8A+8S0Ty8PNZIxIDB+HQrgOdlzfg900yyKf
 PpEZcWnWj9NCiGvpN4LR3YnQ7LYe82A=
X-Proofpoint-GUID: V8JBv4LKY6dLxLcyn28d1r3gFH1SMzB7
X-Proofpoint-ORIG-GUID: V8JBv4LKY6dLxLcyn28d1r3gFH1SMzB7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060120
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
	TAGGED_FROM(0.00)[bounces-21650-lists,linux-s390=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:seiden@linux.ibm.com,m:kvm@vger.kernel.org,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-s390@vger.kernel.org,m:agordeev@linux.ibm.com,m:gra@linux.ibm.com,m:arnd@arndb.de,m:catalin.marinas@arm.com,m:borntraeger@linux.ibm.com,m:imbrenda@linux.ibm.com,m:david@kernel.org,m:fritz@linux.ibm.com,m:ggala@linux.ibm.com,m:hari55@linux.ibm.com,m:hca@linux.ibm.com,m:brueckner@linux.ibm.com,m:iii@linux.ibm.com,m:joey.gouly@arm.com,m:maz@kernel.org,m:nrb@linux.ibm.com,m:oss@nina.schoetterlglausch.eu,m:oupton@kernel.org,m:pbonzini@redhat.com,m:suzuki.poulose@arm.com,m:svens@linux.ibm.com,m:Ulrich.Weigand@de.ibm.com,m:gor@linux.ibm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER(0.00)[frankja@linux.ibm.com,linux-s390@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frankja@linux.ibm.com,linux-s390@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-s390];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DBC4710621

On 7/6/26 10:52, Steffen Eiden wrote:
> Implement the mostly trivial functions that the shared arm64 (kvm)
> code & headers oblige s390 to implement.
> 
> Implement a very basic smccc handler that (non-compliantly) is just able
> to stop a vcpu.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/arm64/kvm_emulate.h | 135 ++++++++++++++++++++++++++
>   arch/s390/include/arm64/kvm_nested.h  |  11 +++
>   arch/s390/kvm/arm64/handle_exit.c     | 110 +++++++++++++++++++++
>   arch/s390/kvm/arm64/inject_fault.c    |  21 ++++
>   4 files changed, 277 insertions(+)
>   create mode 100644 arch/s390/include/arm64/kvm_emulate.h
>   create mode 100644 arch/s390/include/arm64/kvm_nested.h
>   create mode 100644 arch/s390/kvm/arm64/handle_exit.c
>   create mode 100644 arch/s390/kvm/arm64/inject_fault.c
> 

[...]

> +/* manually copied from arch/arm64/kernel/traps.c */
> +static const char * const esr_class_str[] = {
> +	[0 ... ESR_ELx_EC_MAX]		= "UNRECOGNIZED EC",
> +	[ESR_ELx_EC_UNKNOWN]		= "Unknown/Uncategorized",
> +	[ESR_ELx_EC_WFx]		= "WFI/WFE",
> +	[ESR_ELx_EC_CP15_32]		= "CP15 MCR/MRC",
> +	[ESR_ELx_EC_CP15_64]		= "CP15 MCRR/MRRC",
> +	[ESR_ELx_EC_CP14_MR]		= "CP14 MCR/MRC",
> +	[ESR_ELx_EC_CP14_LS]		= "CP14 LDC/STC",
> +	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
> +	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
> +	[ESR_ELx_EC_PAC]		= "PAC",
> +	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
> +	[ESR_ELx_EC_BTI]		= "BTI",
> +	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
> +	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
> +	[ESR_ELx_EC_HVC32]		= "HVC (AArch32)",
> +	[ESR_ELx_EC_SMC32]		= "SMC (AArch32)",
> +	[ESR_ELx_EC_SVC64]		= "SVC (AArch64)",
> +	[ESR_ELx_EC_HVC64]		= "HVC (AArch64)",
> +	[ESR_ELx_EC_SMC64]		= "SMC (AArch64)",
> +	[ESR_ELx_EC_SYS64]		= "MSR/MRS (AArch64)",
> +	[ESR_ELx_EC_SVE]		= "SVE",
> +	[ESR_ELx_EC_ERET]		= "ERET/ERETAA/ERETAB",
> +	[ESR_ELx_EC_FPAC]		= "FPAC",
> +	[ESR_ELx_EC_SME]		= "SME",
> +	[ESR_ELx_EC_IMP_DEF]		= "EL3 IMP DEF",
> +	[ESR_ELx_EC_IABT_LOW]		= "IABT (lower EL)",
> +	[ESR_ELx_EC_IABT_CUR]		= "IABT (current EL)",
> +	[ESR_ELx_EC_PC_ALIGN]		= "PC Alignment",
> +	[ESR_ELx_EC_DABT_LOW]		= "DABT (lower EL)",
> +	[ESR_ELx_EC_DABT_CUR]		= "DABT (current EL)",
> +	[ESR_ELx_EC_SP_ALIGN]		= "SP Alignment",
> +	[ESR_ELx_EC_MOPS]		= "MOPS",
> +	[ESR_ELx_EC_FP_EXC32]		= "FP (AArch32)",
> +	[ESR_ELx_EC_FP_EXC64]		= "FP (AArch64)",
> +	[ESR_ELx_EC_GCS]		= "Guarded Control Stack",
> +	[ESR_ELx_EC_SERROR]		= "SError",
> +	[ESR_ELx_EC_BREAKPT_LOW]	= "Breakpoint (lower EL)",
> +	[ESR_ELx_EC_BREAKPT_CUR]	= "Breakpoint (current EL)",
> +	[ESR_ELx_EC_SOFTSTP_LOW]	= "Software Step (lower EL)",
> +	[ESR_ELx_EC_SOFTSTP_CUR]	= "Software Step (current EL)",
> +	[ESR_ELx_EC_WATCHPT_LOW]	= "Watchpoint (lower EL)",
> +	[ESR_ELx_EC_WATCHPT_CUR]	= "Watchpoint (current EL)",
> +	[ESR_ELx_EC_BKPT32]		= "BKPT (AArch32)",
> +	[ESR_ELx_EC_VECTOR32]		= "Vector catch (AArch32)",
> +	[ESR_ELx_EC_BRK64]		= "BRK (AArch64)",
> +};
> +
We could rip out the 32bit ones.
Not necessarily right now as it's easier to compare to the aarch64 
implementation like this but at least at a later time.

I was also wondering if it would make sense to have all the feature 
checks for unimplemented features in one file.

