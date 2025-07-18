Return-Path: <linux-s390+bounces-11603-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813DB0A44C
	for <lists+linux-s390@lfdr.de>; Fri, 18 Jul 2025 14:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79721582F01
	for <lists+linux-s390@lfdr.de>; Fri, 18 Jul 2025 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183452D94B4;
	Fri, 18 Jul 2025 12:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="URKeXKJu"
X-Original-To: linux-s390@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA2221297;
	Fri, 18 Jul 2025 12:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752842319; cv=none; b=PvpGZXoBhOjarghR/xTPjPJeW9tY7VA1xVWcuXP7DFEYLtl+Rvcc7j7zlAsPxipy2zyL07X+ESqCHbVVHyqYUNZtpRRHPsqBRnnvq8m0qaJi/PgXJJW1aMZ9KnqLAQKMcHaZrXWGykXKFxFPDIY+9kQ6/RR74mK0mlWJHLqFNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752842319; c=relaxed/simple;
	bh=qJGabvaVAxVV1UGOMUcFloFEqAz/n/6K5TXGIBHwEGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUbrPnGoPAZu6W3FiQ12zi2V+wbCI6A+/ZjS7WuZGJek+7VsJqiVMMS0CXKxtafALzlJymjMUSHy2TwnwN5D8Dp7SMpzq6faXcjSw6ziypNlBhEpnuV4Vg6zJdhTYywK+NFai755v93sRHGyrToy1fsdRIClnD0Hyj3agjbGLDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=URKeXKJu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8Vqmq024126;
	Fri, 18 Jul 2025 12:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=AJ7Yc9S8ybUjsYZ6mEaq1yLAIUmrbN
	SGYdtADWMsG68=; b=URKeXKJunyhD1+j06LLJVhu9nrCnwkh/iFkJ+KqLceutkJ
	lH6azZ0lpfqejdykiNA3ZxSbHRAY7I1Oe2ofzfG5FzAI81cs8IAywk1t82gctF96
	/o3jbVwuMc5cil0FbQWACOQ5ZiQG4vV2etuzyQz7URfPR/nrPJQf1DZhlXuVKOJN
	NxJh8+4yqJ/OcK6D3BIv27rMR7G4j3h0s8vutnVnqpzJ4Q5oCFJu277PfekDn5LD
	Ri6rCWReLXVlipONFhPvQw1CmFlhUlr0AiE4bsbADWqh1oin2aa3yJuOHm08spDj
	aZMThCv5XUcYajgl9Ap22Ps1QEW4jLA4rijDIR9Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47y07txh9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:38:18 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56ICcIx9012599;
	Fri, 18 Jul 2025 12:38:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47y07txh9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:38:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56I9BoEl025987;
	Fri, 18 Jul 2025 12:38:17 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v31q18vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 12:38:16 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ICcEjA53543262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 12:38:15 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2E4A2004B;
	Fri, 18 Jul 2025 12:38:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B69C620043;
	Fri, 18 Jul 2025 12:38:13 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.132.117])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 18 Jul 2025 12:38:13 +0000 (GMT)
Date: Fri, 18 Jul 2025 14:38:12 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
        akpm@linux-foundation.org, ryabinin.a.a@gmail.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 10/12] kasan/s390: call kasan_init_generic in
 kasan_init
Message-ID: <8412bf39-8235-4abb-ae35-db6029a605b3-agordeev@linux.ibm.com>
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-11-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717142732.292822-11-snovitoll@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mdxNuC1xCFhuxtIpSH9TZqP6KhLLlotA
X-Proofpoint-GUID: vIORyTF4ypaBonjC46BtYf4jbJ2mxKDQ
X-Authority-Analysis: v=2.4 cv=d/v1yQjE c=1 sm=1 tr=0 ts=687a403b cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=cM5Q7b1H7_XZ2lFhe3QA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDA5NSBTYWx0ZWRfXwYseivfKqS1x J8WeqMyeE4+9+fwXyYNzZbOhx8wQEU+BxVKA5pL924Piu0WwYnZ0ds8Gg6cLrfaUCEmqngt+K2h v0iQpTIsCHidE0ZLR0UHnsBWuH3UYoIGkKH5HBy3pVo4QZasuFlmAgru0z1FY/j8NsXwfkpXZxf
 P46pOLu6NzYfd/QSa1kpO8S7p+tsd29lPZD2iYUmkG34IGk5n0wysprtNon/KZ0ojmcC9eLbIuy IJZ06FnAowNYqChDKS5euUgyI5PN9bMJlP6hA85NQeYAk9U5yWGraX/LIaWr6M8JtPEGSrTaRm/ 97uHxnx4L8KCPt+hyzHTf8w8bwvZvsP8xkv54H22+2e+so4ZRLAKAvDB9IiTB51ufI4/jZQUx39
 cC7c3CC6MUmnD00YlyhwGtbDdUSPCITIRC25vIbBO7x884VH8097j8NcoFOgTL8icQ3rTJvo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180095

On Thu, Jul 17, 2025 at 07:27:30PM +0500, Sabyrzhan Tasbolatov wrote:
> Call kasan_init_generic() which handles Generic KASAN initialization
> and prints the banner. Since s390 doesn't select ARCH_DEFER_KASAN,
> kasan_enable() will be a no-op, and kasan_enabled() will return
> IS_ENABLED(CONFIG_KASAN) for optimal compile-time behavior.
> 
> s390 sets up KASAN mappings in the decompressor and can run with KASAN
> enabled from very early, so it doesn't need runtime control.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  arch/s390/kernel/early.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
> index 54cf0923050..7ada1324f6a 100644
> --- a/arch/s390/kernel/early.c
> +++ b/arch/s390/kernel/early.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <asm/asm-extable.h>
>  #include <linux/memblock.h>
> +#include <linux/kasan.h>
>  #include <asm/access-regs.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/machine.h>
> @@ -65,7 +66,7 @@ static void __init kasan_early_init(void)
>  {
>  #ifdef CONFIG_KASAN
>  	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized\n");
> +	kasan_init_generic();
>  #endif
>  }

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

