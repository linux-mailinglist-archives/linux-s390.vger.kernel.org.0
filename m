Return-Path: <linux-s390+bounces-9684-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA53A762D3
	for <lists+linux-s390@lfdr.de>; Mon, 31 Mar 2025 11:00:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E4D188BDA5
	for <lists+linux-s390@lfdr.de>; Mon, 31 Mar 2025 09:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0138418A93C;
	Mon, 31 Mar 2025 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P63v/gXs"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6D1524B0;
	Mon, 31 Mar 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743411598; cv=none; b=ikdevxV3vkHZyvl1MfeYGJK6Ngkme13jNStungHlMnAKYENXhkfYyVt407v6RLIaAf+hPFq9Hb3PMzTZbCGHaALIoEhAcvgc7Bn0/HIBxEFHhQB6OZa6GHNXLSM2cmajEhdDcQUc0iEwP/6XR5TS6qnUzXBfVXi1yynLrPDhNRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743411598; c=relaxed/simple;
	bh=wlyMiRRTUhq1gI4BBk63IVi+E60IuUm2kFWUlnj55KY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anLL3HMs/zkyfjP981rxq3J+yKe6vMw/Iy9+qDZkF46yW0Du00MddZsigZRef4/235vVoNGmd6bpHonOWX4rpcCp3XrxFz2Y5/UzGcoXFss3rDUWMiXBYJI6xBSRhz+fXTuHwwSgXUmg34bpSMWI6xMqRSPgNzk8OHJYm8G+M3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P63v/gXs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UKauVs020777;
	Mon, 31 Mar 2025 08:59:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/02MeeTgr+edfUre6+XCDI7lrRPKBN
	s5wpBz5Bd11FQ=; b=P63v/gXsRF4hDLy7ssEBBwh/kzsyGiOtp0mumcM5+A/LNj
	gdY0eBuzdPTmuXOhURZupJ1YyCReKhjV+btHVIxdh6bjRaJyvFsMnji9ym0MycpW
	FQ/tEiPUhIT3tmZjgUk0k8RfDGEkMM5umV5et3jPN0aBemzHNEpTH7otsAqg2D2s
	IgiQKjGXwzD3QmqVQYFZ00JQ3UFfmml/HrvUYzWU2spcPKwRznX4azB8E9B4uB+1
	1QpX2jha71AOh/TNdKabH257Nmy0qCW899l9HxKC4fFcsNGdaAqFdrftLmaLGGiG
	2KPUxEHGLnOeqqSwgqWBfYVrpnKHZUpIb/RQpJew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd4q286v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 08:59:20 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52V8pdhP010589;
	Mon, 31 Mar 2025 08:59:19 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd4q286t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 08:59:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V5GId8014560;
	Mon, 31 Mar 2025 08:59:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkw19g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 08:59:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52V8xEMj54460792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 08:59:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B244A20067;
	Mon, 31 Mar 2025 08:59:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D62920065;
	Mon, 31 Mar 2025 08:59:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.74.246])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 08:59:13 +0000 (GMT)
Date: Mon, 31 Mar 2025 10:59:11 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Steven Price <steven.price@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/ptdump: Split note_page() into level specific
 callbacks
Message-ID: <Z+pZX2QmFnNnnjZ5@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250317061818.16244-1-anshuman.khandual@arm.com>
 <20250317061818.16244-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317061818.16244-2-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FB8uw0hSchlofFmG1jPA1lzwCpmzLf0-
X-Proofpoint-ORIG-GUID: 3iKHP7Q1z45fUexTKfPdZicsNHs_J4-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 clxscore=1011 mlxscore=0 adultscore=0 mlxlogscore=741
 malwarescore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310063

On Mon, Mar 17, 2025 at 11:48:17AM +0530, Anshuman Khandual wrote:

Hi Anshuman,

...
> --- a/include/linux/ptdump.h
> +++ b/include/linux/ptdump.h
> @@ -11,9 +11,12 @@ struct ptdump_range {
>  };
>  
>  struct ptdump_state {
> -	/* level is 0:PGD to 4:PTE, or -1 if unknown */
> -	void (*note_page)(struct ptdump_state *st, unsigned long addr,
> -			  int level, u64 val);
> +	void (*note_page_pte)(struct ptdump_state *st, unsigned long addr, pte_t pte);
> +	void (*note_page_pmd)(struct ptdump_state *st, unsigned long addr, pmd_t pmd);
> +	void (*note_page_pud)(struct ptdump_state *st, unsigned long addr, pud_t pud);
> +	void (*note_page_p4d)(struct ptdump_state *st, unsigned long addr, p4d_t p4d);
> +	void (*note_page_pgd)(struct ptdump_state *st, unsigned long addr, pgd_t pgd);
> +	void (*note_page_flush)(struct ptdump_state *st);
>  	void (*effective_prot)(struct ptdump_state *st, int level, u64 val);

Should you treat effective_prot() similarly?

>  	const struct ptdump_range *range;
>  };

