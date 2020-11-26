Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8C92C57E0
	for <lists+linux-s390@lfdr.de>; Thu, 26 Nov 2020 16:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbgKZPJE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Nov 2020 10:09:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47756 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389884AbgKZPJE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 10:09:04 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQF29Vx120197
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 10:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=mHr8ZMsOBDGK7JXawS+GgcUJjAUDAfMf4KYgTclmSq4=;
 b=MGJgUGXwVtFBeJDbb2YUqkkOQzt9nrM7+m1txU95Xnst9dDi3KBRZn72IcT4fTRRV9dc
 scf8QnEP+fSvzsoTgZlExCJOlyXpcRJXnmYSWBhqwAjXvIEzqMUS51SMPW9KoJcANClu
 n6E7wPQqAuUrdAlgkSRlwbKZK9XH0YGij5Uln3wVubjJ1Upkc6ANR9dNY8FjDiQbFdwN
 JwLPcJ17jJIVkppKpvHcsl1jRWy0O/Oscs9+UO4KSc6xqiMrkhzSgyDV5pROLqNQvX9t
 IrFR+FTsOBeRYC+9U7TvN5QiKemiA8Sbguvs5pMRaylyoneCRB39e2Xk5kVpeiEU51CG tA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3526npp9qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 10:09:03 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQF7SsL031597
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 15:09:01 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma05fra.de.ibm.com with ESMTP id 352ata03tw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 15:09:01 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQF8wPD15925716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 15:08:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CDFBAE04D;
        Thu, 26 Nov 2020 15:08:58 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1F1FAE051;
        Thu, 26 Nov 2020 15:08:57 +0000 (GMT)
Received: from [9.171.80.142] (unknown [9.171.80.142])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 15:08:57 +0000 (GMT)
Subject: Re: [PATCH v2] s390/pci: fix CPU address in MSI for directed IRQ
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
References: <af38d74d-5310-9700-1773-85b8372022d4@linux.ibm.com>
 <20201125142930.GA13435@oc3871087118.ibm.com>
 <31dfedbf-cfe4-09d2-5dc5-ee9fb847d109@linux.ibm.com>
 <8a072525-7915-27c8-40ef-d7c826419a89@linux.ibm.com>
 <10403770-249e-ccbc-a90a-f4ceeb190346@linux.ibm.com>
 <20201125155818.GA16580@oc3871087118.ibm.com>
 <a3be779d-6103-014a-3090-a0ea86c5668a@linux.ibm.com>
 <20201126121934.GA514@oc3871087118.ibm.com>
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Message-ID: <4143b73b-0dd1-3d07-3fe0-7362f4b46f17@linux.ibm.com>
Date:   Thu, 26 Nov 2020 16:08:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201126121934.GA514@oc3871087118.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_05:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260089
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 11/26/20 1:19 PM, Alexander Gordeev wrote:
> The directed MSIs are delivered to CPUs whose address is
> written to the MSI message data. The current code assumes
> that a CPU logical number (as it is seen by the kernel)
> is also that CPU address.
> 
> The above assumption is not correct, as the CPU address
> is rather the value returned by STAP instruction. That
> value is not necessarily matches the kernel logical CPU
> number.

I took the liberty of correcting the "is not" grammar error
above to "does not necessarily match".

> 
> Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Still works well and checkpatches clean. I 

> ---
>  arch/s390/pci/pci_irq.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index 743f257cf2cb..1309fd302f58 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
>  {
>  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
>  	struct msi_msg msg = entry->msg;
> +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
>  
>  	msg.address_lo &= 0xff0000ff;
> -	msg.address_lo |= (cpumask_first(dest) << 8);
> +	msg.address_lo |= (cpu_addr << 8);
>  	pci_write_msi_msg(data->irq, &msg);
>  
>  	return IRQ_SET_MASK_OK;
> @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	unsigned long bit;
>  	struct msi_desc *msi;
>  	struct msi_msg msg;
> +	int cpu_addr;
>  	int rc, irq;
>  
>  	zdev->aisb = -1UL;
> @@ -287,9 +289,16 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  					 handle_percpu_irq);
>  		msg.data = hwirq - bit;
>  		if (irq_delivery == DIRECTED) {
> +			if (msi->affinity) {
> +				cpu = cpumask_first(&msi->affinity->mask);
> +				cpu_addr = smp_cpu_get_cpu_address(cpu);
> +			} else {
> +				cpu_addr = 0;
> +			}

One question I haven't really figured out from looking at the spec is
why using cpu_addr = 0; is a good fallback. Shouldn't that be smp_cpu_get_cpu_address(0) or
do we now know that the CPU addresses always start at 0?

> +
>  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
> -			msg.address_lo |= msi->affinity ?
> -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
> +			msg.address_lo |= (cpu_addr << 8);
> +
>  			for_each_possible_cpu(cpu) {
>  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
>  			}
> 
