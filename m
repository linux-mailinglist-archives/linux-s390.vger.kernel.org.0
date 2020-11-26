Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1462C596F
	for <lists+linux-s390@lfdr.de>; Thu, 26 Nov 2020 17:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403865AbgKZQoD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 26 Nov 2020 11:44:03 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403862AbgKZQoC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Nov 2020 11:44:02 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQGQ0lm164832
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 11:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=eGK3qg/CheUjbmGI0Foop/TXUPetOJbOSsIBdJOm8kQ=;
 b=mz9E2jdtKGTAVBhJQUhkJGZW6p3Xms/mUQGVxOhCd2KU4Af0CCrgzd7gQFQFmKBfLEyC
 hQipL07MVmBpP76Cu1qZY9YV4MCbF5RX3M2pvkAl1shzQs4B113eRrHJO7ke4+yf9w14
 Rw+FQ07c79NDSLiL0nVDpszGhs4ev05DkB9vwYV73//ii0cuLhNTu8foOojU9aD6XEqC
 dI2DqJK7u3DW6x1rncfVmBfQNk0a3cCDw4jnL265wqf+h8WzWPsd8dOR+A9aWVwgCX17
 WGppBPPjVv7M/3ZHMe8L8ybrnv2FnlusSeh4Qpca5cWZEJVvd2ltxx2O/oClo9v62o2s sg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352fvngd30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 11:44:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQGgbHk014048
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 16:44:00 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 34xth8dubm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 26 Nov 2020 16:43:59 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQGhurw65208760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 16:43:56 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21C82A405C;
        Thu, 26 Nov 2020 16:43:56 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D40BDA4054;
        Thu, 26 Nov 2020 16:43:55 +0000 (GMT)
Received: from oc3871087118.ibm.com (unknown [9.145.159.67])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 16:43:55 +0000 (GMT)
Date:   Thu, 26 Nov 2020 17:43:54 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/pci: fix CPU address in MSI for directed IRQ
Message-ID: <20201126164353.GA10121@oc3871087118.ibm.com>
References: <af38d74d-5310-9700-1773-85b8372022d4@linux.ibm.com>
 <20201125142930.GA13435@oc3871087118.ibm.com>
 <31dfedbf-cfe4-09d2-5dc5-ee9fb847d109@linux.ibm.com>
 <8a072525-7915-27c8-40ef-d7c826419a89@linux.ibm.com>
 <10403770-249e-ccbc-a90a-f4ceeb190346@linux.ibm.com>
 <20201125155818.GA16580@oc3871087118.ibm.com>
 <a3be779d-6103-014a-3090-a0ea86c5668a@linux.ibm.com>
 <20201126121934.GA514@oc3871087118.ibm.com>
 <4143b73b-0dd1-3d07-3fe0-7362f4b46f17@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4143b73b-0dd1-3d07-3fe0-7362f4b46f17@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_06:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxlogscore=999 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011260097
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 26, 2020 at 04:08:57PM +0100, Niklas Schnelle wrote:
> 
> 
> On 11/26/20 1:19 PM, Alexander Gordeev wrote:
> > The directed MSIs are delivered to CPUs whose address is
> > written to the MSI message data. The current code assumes
> > that a CPU logical number (as it is seen by the kernel)
> > is also that CPU address.
> > 
> > The above assumption is not correct, as the CPU address
> > is rather the value returned by STAP instruction. That
> > value is not necessarily matches the kernel logical CPU
> > number.
> 
> I took the liberty of correcting the "is not" grammar error
> above to "does not necessarily match".
> 
> > 
> > Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> 
> Still works well and checkpatches clean. I 
> 
> > ---
> >  arch/s390/pci/pci_irq.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> > index 743f257cf2cb..1309fd302f58 100644
> > --- a/arch/s390/pci/pci_irq.c
> > +++ b/arch/s390/pci/pci_irq.c
> > @@ -103,9 +103,10 @@ static int zpci_set_irq_affinity(struct irq_data *data, const struct cpumask *de
> >  {
> >  	struct msi_desc *entry = irq_get_msi_desc(data->irq);
> >  	struct msi_msg msg = entry->msg;
> > +	int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
> >  
> >  	msg.address_lo &= 0xff0000ff;
> > -	msg.address_lo |= (cpumask_first(dest) << 8);
> > +	msg.address_lo |= (cpu_addr << 8);
> >  	pci_write_msi_msg(data->irq, &msg);
> >  
> >  	return IRQ_SET_MASK_OK;
> > @@ -238,6 +239,7 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> >  	unsigned long bit;
> >  	struct msi_desc *msi;
> >  	struct msi_msg msg;
> > +	int cpu_addr;
> >  	int rc, irq;
> >  
> >  	zdev->aisb = -1UL;
> > @@ -287,9 +289,16 @@ int arch_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
> >  					 handle_percpu_irq);
> >  		msg.data = hwirq - bit;
> >  		if (irq_delivery == DIRECTED) {
> > +			if (msi->affinity) {
> > +				cpu = cpumask_first(&msi->affinity->mask);
> > +				cpu_addr = smp_cpu_get_cpu_address(cpu);
> > +			} else {
> > +				cpu_addr = 0;
> > +			}
> 
> One question I haven't really figured out from looking at the spec is
> why using cpu_addr = 0; is a good fallback. Shouldn't that be smp_cpu_get_cpu_address(0) or
> do we now know that the CPU addresses always start at 0?

Nice catch! I think the safest way is smp_cpu_get_cpu_address(0)
whatever the spec says. I'll send v3. 

> > +
> >  			msg.address_lo = zdev->msi_addr & 0xff0000ff;
> > -			msg.address_lo |= msi->affinity ?
> > -				(cpumask_first(&msi->affinity->mask) << 8) : 0;
> > +			msg.address_lo |= (cpu_addr << 8);
> > +
> >  			for_each_possible_cpu(cpu) {
> >  				airq_iv_set_data(zpci_ibv[cpu], hwirq, irq);
> >  			}
> > 
