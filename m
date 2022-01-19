Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8801493F9D
	for <lists+linux-s390@lfdr.de>; Wed, 19 Jan 2022 19:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356631AbiASSEx (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 19 Jan 2022 13:04:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239619AbiASSEw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Jan 2022 13:04:52 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20JHjw1P007026;
        Wed, 19 Jan 2022 18:04:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ywQb3BT/1Y0w4e+TzDhc/I6FfT+g8lTL2iFFf8ZakJ8=;
 b=tuF0S7fIWvGUVyEpvZ17MftrYqKuG4If5vgfZAywfqqkgDTWXHDIWJWrqEEsXyNshUhC
 A4lX53yzsIsBqXQmjo6HvrwPFItkC0fQGb23yHZ8MqY2rIXCv5cXgpLxQbo+S/wqhQht
 MzE/sGsRnc7jszrl4oLoK+2AOoLwIGuDiPx/AYCHLYv/ZUY2ZAvXqtA3W97o+Q0rybjp
 DBd6orRjXRg6/DpDZCF1oo50ryTBtsJT37m+J7ZOMiVUBWK5MH5xF5/avAHQ/mZUKfzv
 S8yTmZUygFaCbsIpabfm9sWDaD4BTUOrg+1ePorgd3fgS4eitqEBlFoRPlhUexVXtuFG RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmeg5234-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:04:52 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20JHmxCO018034;
        Wed, 19 Jan 2022 18:04:52 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dpmeg5228-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:04:51 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20JHwEoP027736;
        Wed, 19 Jan 2022 18:04:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3dknw9qdtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 18:04:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20JI4kbK44040644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jan 2022 18:04:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00B79A4078;
        Wed, 19 Jan 2022 18:04:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F05CCA4059;
        Wed, 19 Jan 2022 18:04:44 +0000 (GMT)
Received: from [9.171.7.240] (unknown [9.171.7.240])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jan 2022 18:04:44 +0000 (GMT)
Message-ID: <fce9a0b7-61b5-df74-afd9-c238721f03db@linux.ibm.com>
Date:   Wed, 19 Jan 2022 19:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 15/30] KVM: s390: pci: do initial setup for AEN
 interpretation
Content-Language: en-US
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220114203145.242984-1-mjrosato@linux.ibm.com>
 <20220114203145.242984-16-mjrosato@linux.ibm.com>
From:   Pierre Morel <pmorel@linux.ibm.com>
In-Reply-To: <20220114203145.242984-16-mjrosato@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OyQE-zQ6OgUMXSW-c5URxdU8idPZ00_H
X-Proofpoint-ORIG-GUID: x0dlOFrTW9xYVWyPquAo-8bdlfjePN4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_10,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190102
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



On 1/14/22 21:31, Matthew Rosato wrote:
> Initial setup for Adapter Event Notification Interpretation for zPCI
> passthrough devices.  Specifically, allocate a structure for forwarding of
> adapter events and pass the address of this structure to firmware.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>   arch/s390/include/asm/pci.h      |   4 +
>   arch/s390/include/asm/pci_insn.h |  12 +++
>   arch/s390/kvm/interrupt.c        |  14 +++
>   arch/s390/kvm/kvm-s390.c         |   9 ++
>   arch/s390/kvm/pci.c              | 144 +++++++++++++++++++++++++++++++
>   arch/s390/kvm/pci.h              |  42 +++++++++
>   arch/s390/pci/pci.c              |   6 ++
>   7 files changed, 231 insertions(+)
>   create mode 100644 arch/s390/kvm/pci.h
> 
> diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> index 9b6c657d8d31..9ff8dc19975e 100644
> --- a/arch/s390/include/asm/pci.h
> +++ b/arch/s390/include/asm/pci.h
> @@ -9,6 +9,7 @@
>   #include <asm-generic/pci.h>
>   #include <asm/pci_clp.h>
>   #include <asm/pci_debug.h>
> +#include <asm/pci_insn.h>
>   #include <asm/sclp.h>
>   
>   #define PCIBIOS_MIN_IO		0x1000
> @@ -204,6 +205,9 @@ extern const struct attribute_group *zpci_attr_groups[];
>   extern unsigned int s390_pci_force_floating __initdata;
>   extern unsigned int s390_pci_no_rid;
>   
> +extern union zpci_sic_iib *zpci_aipb;
> +extern struct airq_iv *zpci_aif_sbv;
> +
>   /* -----------------------------------------------------------------------------
>     Prototypes
>   ----------------------------------------------------------------------------- */
> diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_insn.h
> index 32759c407b8f..ad9000295c82 100644
> --- a/arch/s390/include/asm/pci_insn.h
> +++ b/arch/s390/include/asm/pci_insn.h
> @@ -101,6 +101,7 @@ struct zpci_fib {
>   /* Set Interruption Controls Operation Controls  */
>   #define	SIC_IRQ_MODE_ALL		0
>   #define	SIC_IRQ_MODE_SINGLE		1
> +#define	SIC_SET_AENI_CONTROLS		2
>   #define	SIC_IRQ_MODE_DIRECT		4
>   #define	SIC_IRQ_MODE_D_ALL		16
>   #define	SIC_IRQ_MODE_D_SINGLE		17
> @@ -127,9 +128,20 @@ struct zpci_cdiib {
>   	u64 : 64;
>   } __packed __aligned(8);
>   
> +/* adapter interruption parameters block */
> +struct zpci_aipb {
> +	u64 faisb;
> +	u64 gait;
> +	u16 : 13;
> +	u16 afi : 3;
> +	u32 : 32;
> +	u16 faal;
> +} __packed __aligned(8);
> +
>   union zpci_sic_iib {
>   	struct zpci_diib diib;
>   	struct zpci_cdiib cdiib;
> +	struct zpci_aipb aipb;
>   };
>   
>   DECLARE_STATIC_KEY_FALSE(have_mio);
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index f9b872e358c6..a591b8cd662f 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -32,6 +32,7 @@
>   #include "kvm-s390.h"
>   #include "gaccess.h"
>   #include "trace-s390.h"
> +#include "pci.h"
>   
>   #define PFAULT_INIT 0x0600
>   #define PFAULT_DONE 0x0680
> @@ -3278,6 +3279,11 @@ void kvm_s390_gib_destroy(void)
>   {
>   	if (!gib)
>   		return;
> +	if (IS_ENABLED(CONFIG_PCI) && sclp.has_aeni && aift) {
> +		mutex_lock(&aift->lock);
> +		kvm_s390_pci_aen_exit();
> +		mutex_unlock(&aift->lock);
> +	}
>   	chsc_sgib(0);
>   	unregister_adapter_interrupt(&gib_alert_irq);
>   	free_page((unsigned long)gib);
> @@ -3315,6 +3321,14 @@ int kvm_s390_gib_init(u8 nisc)
>   		goto out_unreg_gal;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_PCI) && sclp.has_aeni) {
> +		if (kvm_s390_pci_aen_init(nisc)) {
> +			pr_err("Initializing AEN for PCI failed\n");
> +			rc = -EIO;
> +			goto out_unreg_gal;
> +		}
> +	}
> +
>   	KVM_EVENT(3, "gib 0x%pK (nisc=%d) initialized", gib, gib->nisc);
>   	goto out;
>   
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 14a18ba5ff2c..01dc3f6883d0 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -48,6 +48,7 @@
>   #include <asm/fpu/api.h>
>   #include "kvm-s390.h"
>   #include "gaccess.h"
> +#include "pci.h"
>   
>   #define CREATE_TRACE_POINTS
>   #include "trace.h"
> @@ -503,6 +504,14 @@ int kvm_arch_init(void *opaque)
>   		goto out;
>   	}
>   
> +	if (IS_ENABLED(CONFIG_PCI)) {
> +		rc = kvm_s390_pci_init();
> +		if (rc) {
> +			pr_err("Unable to allocate AIFT for PCI\n");
> +			goto out;
> +		}
> +	}
> +
>   	rc = kvm_s390_gib_init(GAL_ISC);
>   	if (rc)
>   		goto out;
> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 1c33bc7bf2bd..dae853da6df1 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -10,6 +10,138 @@
>   #include <linux/kvm_host.h>
>   #include <linux/pci.h>
>   #include <asm/kvm_pci.h>
> +#include <asm/pci.h>
> +#include <asm/pci_insn.h>
> +#include "pci.h"
> +
> +struct zpci_aift *aift;
> +
> +static inline int __set_irq_noiib(u16 ctl, u8 isc)
> +{
> +	union zpci_sic_iib iib = {{0}};
> +
> +	return zpci_set_irq_ctrl(ctl, isc, &iib);
> +}
> +
> +/* Caller must hold the aift lock before calling this function */
> +void kvm_s390_pci_aen_exit(void)
> +{
> +	unsigned long flags;
> +	struct kvm_zdev **gait_kzdev;
> +
> +	/*
> +	 * Contents of the aipb remain registered for the life of the host
> +	 * kernel, the information preserved in zpci_aipb and zpci_aif_sbv
> +	 * in case we insert the KVM module again later.  Clear the AIFT
> +	 * information and free anything not registered with underlying
> +	 * firmware.
> +	 */
> +	spin_lock_irqsave(&aift->gait_lock, flags);
> +	gait_kzdev = aift->kzdev;
> +	aift->gait = 0;
> +	aift->sbv = 0;
> +	aift->kzdev = 0;
> +	spin_unlock_irqrestore(&aift->gait_lock, flags);
> +
> +	kfree(gait_kzdev);
> +}
> +
> +int kvm_s390_pci_aen_init(u8 nisc)
> +{
> +	struct page *page;
> +	int rc = 0, size;
> +	bool first = false;
> +
> +	/* If already enabled for AEN, bail out now */
> +	if (aift->gait || aift->sbv)
> +		return -EPERM;
> +
> +	mutex_lock(&aift->lock);
> +	aift->kzdev = kcalloc(ZPCI_NR_DEVICES, sizeof(struct kvm_zdev),
> +			      GFP_KERNEL);
> +	if (!aift->kzdev) {
> +		rc = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	if (!zpci_aipb) {

I think you should externalize all this allocation and setup of aipb
in a dedicated function zpci_setup_aipb()
from here ----->

> +		zpci_aipb = kzalloc(sizeof(union zpci_sic_iib), GFP_KERNEL);
> +		if (!zpci_aipb) {
> +			rc = -ENOMEM;
> +			goto free_zdev;
> +		}
> +		first = true;
> +		aift->sbv = airq_iv_create(ZPCI_NR_DEVICES, AIRQ_IV_ALLOC, 0);
> +		if (!aift->sbv) {
> +			rc = -ENOMEM;
> +			goto free_aipb;
> +		}
> +		zpci_aif_sbv = aift->sbv;
> +		size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
> +					    sizeof(struct zpci_gaite)));
> +		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, size);
> +		if (!page) {
> +			rc = -ENOMEM;
> +			goto free_sbv;
> +		}
> +		aift->gait = (struct zpci_gaite *)page_to_phys(page);
> +
> +		zpci_aipb->aipb.faisb = virt_to_phys(aift->sbv->vector);
> +		zpci_aipb->aipb.gait = virt_to_phys(aift->gait);
> +		zpci_aipb->aipb.afi = nisc;
> +		zpci_aipb->aipb.faal = ZPCI_NR_DEVICES;
> +
> +		/* Setup Adapter Event Notification Interpretation */
> +		if (zpci_set_irq_ctrl(SIC_SET_AENI_CONTROLS, 0, zpci_aipb)) {
> +			rc = -EIO;
> +			goto free_gait;

to here---->

> +		}
> +	} else {
> +		/*
> +		 * AEN registration can only happen once per system boot.  If
> +		 * an aipb already exists then AEN was already registered and
> +		 * we can re-use the aipb contents.  This can only happen if
> +		 * the KVM module was removed and re-inserted.
> +		 */
> +		if (zpci_aipb->aipb.afi != nisc ||
> +		    zpci_aipb->aipb.faal != ZPCI_NR_DEVICES) {
> +			rc = -EINVAL;
> +			goto free_zdev;
> +		}
> +		aift->sbv = zpci_aif_sbv;
> +		aift->gait = (struct zpci_gaite *)zpci_aipb->aipb.gait;
> +	}
> +
> +	/* Enable floating IRQs */
> +	if (__set_irq_noiib(SIC_IRQ_MODE_SINGLE, nisc)) {
> +		rc = -EIO;
> +		kvm_s390_pci_aen_exit();
> +	}
> +
> +	goto unlock;

and the according errors

here ---->
> +
> +free_gait:
> +	size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
> +				    sizeof(struct zpci_gaite)));
> +	free_pages((unsigned long)aift->gait, size);
> +free_sbv:
> +	if (first) {
> +		/* If AEN setup failed, only free a newly-allocated sbv */
> +		airq_iv_release(aift->sbv);
> +		zpci_aif_sbv = 0;
> +	}
> +free_aipb:
> +	if (first) {
> +		/* If AEN setup failed, only free a newly-allocated aipb */
> +		kfree(zpci_aipb);
> +		zpci_aipb = 0;
> +	}

to here ---->

To simplify the understanding.

> +free_zdev:
> +	kfree(aift->kzdev);
> +unlock:
> +	mutex_unlock(&aift->lock);
> +	return rc;
> +}
>  

... snip...

The second part of the if(aipb) else
could also be externalise in zpci_reset_aipb()

which leads to

    if(!aipb)
	ret = zpci_setup_aipb()
    else
	ret = zpci_reset_aipb()

    if (ret)
	goto cleanup;

     enable_irq()
	goto unlock;

I think that if we can do that it would be much clearer.
what do you think?

-- 
Pierre Morel
IBM Lab Boeblingen
