Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB9D4AB918
	for <lists+linux-s390@lfdr.de>; Mon,  7 Feb 2022 11:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiBGKxm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Feb 2022 05:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiBGKri (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Feb 2022 05:47:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DEC043188;
        Mon,  7 Feb 2022 02:47:37 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21789CcV008207;
        Mon, 7 Feb 2022 10:47:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=G5p8/TgV+7ouwkO7w5vpeCnL0Q5+ECKy2Ey35DJFgPA=;
 b=sW+w2UU9eHfLiTtcOlrKlGajwYQALaIDQvFIZ6KM1YSzBY6QO6R8yZo6Mm2o69HdSlPg
 YKy0a/gy++GBMwK0n1pzWEdXuEtZKoKjWIZOwoCKAtXki/dVVbd4s1CtG+XuH45xNYal
 72wWRek94j3E8hqsZ3vf+GSXcto0hlIoOuzc2bBno+FQOhacoZbA70tKDJsSDokiokoY
 ilTUk1x3vWWM9rP5X2G1nCqFtnT1eLNtqjpyHTKWdBG+UkGwaCnCsQA6z+vZd1CrOcNo
 yCrNOdbFmxMvzStKiAiQHjYnkz/w3yGOu+FpBZN9/rlNvX2AS924vwgB/vO63MTx3LaV +g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vkgseg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:47:36 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 217ANxVg025612;
        Mon, 7 Feb 2022 10:47:36 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22vkgsdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:47:36 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 217AgQrF032601;
        Mon, 7 Feb 2022 10:47:34 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3e1gv936ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 10:47:34 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 217AbSxl44171744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 10:37:28 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A9E6A407B;
        Mon,  7 Feb 2022 10:47:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8D08A4040;
        Mon,  7 Feb 2022 10:47:30 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.11.12])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 10:47:30 +0000 (GMT)
Date:   Mon, 7 Feb 2022 11:47:27 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, borntraeger@de.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, david@redhat.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, scgl@linux.ibm.com
Subject: Re: [PATCH v7 04/17] KVM: s390: pv: refactor s390_reset_acc
Message-ID: <20220207114727.04beaaa4@p-imbrenda>
In-Reply-To: <541085e4-1786-8571-5e3a-ef5ee9111973@linux.ibm.com>
References: <20220204155349.63238-1-imbrenda@linux.ibm.com>
        <20220204155349.63238-5-imbrenda@linux.ibm.com>
        <541085e4-1786-8571-5e3a-ef5ee9111973@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JPhSZDR2OuTFBjXykaCRW-tT0iseAveE
X-Proofpoint-ORIG-GUID: haTYM2Uv_heFJqGX6ixm8SgbZ_w5jDtN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 7 Feb 2022 11:02:28 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 2/4/22 16:53, Claudio Imbrenda wrote:
> > Refactor s390_reset_acc so that it can be reused in upcoming patches.
> > 
> > We don't want to hold all the locks used in a walk_page_range for too
> > long, and the destroy page UVC does take some time to complete.
> > Therefore we quickly gather the pages to destroy, and then destroy them
> > without holding all the locks.
> > 
> > The new refactored function optionally allows to return early without
> > completing if a fatal signal is pending (and return and appropriate
> > error code). Two wrappers are provided to call the new function.
> > 
> > Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> > (dropping Janosch's Ack because of major changes to the patch)
> > ---
> >   arch/s390/include/asm/gmap.h | 36 +++++++++++++-
> >   arch/s390/kvm/pv.c           | 12 ++++-
> >   arch/s390/mm/gmap.c          | 95 +++++++++++++++++++++++++-----------
> >   3 files changed, 111 insertions(+), 32 deletions(-)
> > 
> > diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
> > index 746e18bf8984..2a913014f63c 100644
> > --- a/arch/s390/include/asm/gmap.h
> > +++ b/arch/s390/include/asm/gmap.h
> > @@ -147,7 +147,41 @@ int gmap_mprotect_notify(struct gmap *, unsigned long start,
> >   void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
> >   			     unsigned long gaddr, unsigned long vmaddr);
> >   int gmap_mark_unmergeable(void);
> > -void s390_reset_acc(struct mm_struct *mm);
> >   void s390_remove_old_asce(struct gmap *gmap);
> >   int s390_replace_asce(struct gmap *gmap);
> > +void s390_uv_destroy_pfns(unsigned long count, unsigned long *pfns);
> > +int __s390_uv_destroy_range(struct mm_struct *mm, unsigned long start,
> > +			    unsigned long end, int interruptible);  
> 
> s/int/bool/ ?

I don't know, I like the fact that the function could return
different error codes in the future if needed.

> 
> > +
> > +/**
> > + * s390_uv_destroy_range - Destroy a range of pages in the given mm.
> > + * @mm the mm on which to operate on
> > + * @start the start of the range
> > + * @end the end of the range
> > + *
> > + * This call will call cond_sched, so it should not generate stalls, but it  
> 
> This function will call ?

will fix

> 
> > + * will otherwise only return when it completed.
> > + */
> > +static inline void s390_uv_destroy_range(struct mm_struct *mm, unsigned long start,
> > +					 unsigned long end)
> > +{
> > +	(void)__s390_uv_destroy_range(mm, start, end, 0);
> > +}
> > +
> > +/**
> > + * s390_uv_destroy_range_interruptibe - Destroy a range of pages in the  
> 
> interruptible

will fix

> 
> > + * given mm, but stop when a fatal signal is received.
> > + * @mm the mm on which to operate on
> > + * @start the start of the range
> > + * @end the end of the range
> > + *
> > + * This call will call cond_sched, so it should not generate stalls.  It
> > + * will return -EINTR if a fatal signal is received, or 0 if the whole range
> > + * has been destroyed.
> > + */
> > +static inline int s390_uv_destroy_range_interruptible(struct mm_struct *mm, unsigned long start,
> > +						      unsigned long end)
> > +{
> > +	return __s390_uv_destroy_range(mm, start, end, 1);
> > +}
> >   #endif /* _ASM_S390_GMAP_H */
> > diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> > index 3c59ef763dde..2ab22500e092 100644
> > --- a/arch/s390/kvm/pv.c
> > +++ b/arch/s390/kvm/pv.c
> > @@ -12,6 +12,8 @@
> >   #include <asm/gmap.h>
> >   #include <asm/uv.h>
> >   #include <asm/mman.h>
> > +#include <linux/pagewalk.h>
> > +#include <linux/sched/mm.h>
> >   #include "kvm-s390.h"
> >   
> >   int kvm_s390_pv_destroy_cpu(struct kvm_vcpu *vcpu, u16 *rc, u16 *rrc)
> > @@ -157,8 +159,14 @@ int kvm_s390_pv_deinit_vm(struct kvm *kvm, u16 *rc, u16 *rrc)
> >   {
> >   	int cc;
> >   
> > -	/* make all pages accessible before destroying the guest */
> > -	s390_reset_acc(kvm->mm);
> > +	/*
> > +	 * if the mm still has a mapping, make all its pages accessible
> > +	 * before destroying the guest
> > +	 */
> > +	if (mmget_not_zero(kvm->mm)) {
> > +		s390_uv_destroy_range(kvm->mm, 0, TASK_SIZE);
> > +		mmput(kvm->mm);
> > +	}
> >   
> >   	cc = uv_cmd_nodata(kvm_s390_pv_get_handle(kvm),
> >   			   UVC_CMD_DESTROY_SEC_CONF, rc, rrc);
> > diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> > index ce6cac4463f2..6eb5acb4be3d 100644
> > --- a/arch/s390/mm/gmap.c
> > +++ b/arch/s390/mm/gmap.c
> > @@ -2676,44 +2676,81 @@ void s390_reset_cmma(struct mm_struct *mm)
> >   }
> >   EXPORT_SYMBOL_GPL(s390_reset_cmma);
> >   
> > -/*
> > - * make inaccessible pages accessible again
> > - */
> > -static int __s390_reset_acc(pte_t *ptep, unsigned long addr,
> > -			    unsigned long next, struct mm_walk *walk)
> > +#define DESTROY_LOOP_THRESHOLD 32
> > +
> > +struct reset_walk_state {
> > +	unsigned long next;
> > +	unsigned long count;
> > +	unsigned long pfns[DESTROY_LOOP_THRESHOLD];
> > +};
> > +
> > +static int s390_gather_pages(pte_t *ptep, unsigned long addr,
> > +			     unsigned long next, struct mm_walk *walk)
> >   {
> > +	struct reset_walk_state *p = walk->private;
> >   	pte_t pte = READ_ONCE(*ptep);
> >   
> > -	/* There is a reference through the mapping */
> > -	if (pte_present(pte))
> > -		WARN_ON_ONCE(uv_destroy_owned_page(pte_val(pte) & PAGE_MASK));
> > -
> > -	return 0;
> > +	if (pte_present(pte)) {
> > +		/* we have a reference from the mapping, take an extra one */
> > +		get_page(phys_to_page(pte_val(pte)));
> > +		p->pfns[p->count] = phys_to_pfn(pte_val(pte));
> > +		p->next = next;
> > +		p->count++;
> > +	}
> > +	return p->count >= DESTROY_LOOP_THRESHOLD;
> >   }
> >   
> > -static const struct mm_walk_ops reset_acc_walk_ops = {
> > -	.pte_entry		= __s390_reset_acc,
> > +static const struct mm_walk_ops gather_pages_ops = {
> > +	.pte_entry = s390_gather_pages,
> >   };
> >   
> > -#include <linux/sched/mm.h>
> > -void s390_reset_acc(struct mm_struct *mm)
> > +/*
> > + * Call the Destroy secure page UVC on each page in the given array of PFNs.
> > + * Each page needs to have an extra reference, which will be released here.
> > + */
> > +void s390_uv_destroy_pfns(unsigned long count, unsigned long *pfns)
> >   {
> > -	if (!mm_is_protected(mm))
> > -		return;
> > -	/*
> > -	 * we might be called during
> > -	 * reset:                             we walk the pages and clear
> > -	 * close of all kvm file descriptors: we walk the pages and clear
> > -	 * exit of process on fd closure:     vma already gone, do nothing
> > -	 */
> > -	if (!mmget_not_zero(mm))
> > -		return;
> > -	mmap_read_lock(mm);
> > -	walk_page_range(mm, 0, TASK_SIZE, &reset_acc_walk_ops, NULL);
> > -	mmap_read_unlock(mm);
> > -	mmput(mm);
> > +	unsigned long i;
> > +
> > +	for (i = 0; i < count; i++) {
> > +		/* we always have an extra reference */
> > +		uv_destroy_owned_page(pfn_to_phys(pfns[i]));
> > +		/* get rid of the extra reference */
> > +		put_page(pfn_to_page(pfns[i]));
> > +		cond_resched();
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(s390_uv_destroy_pfns);
> > +
> > +/**
> > + * __s390_uv_destroy_range - Walk the given range of the given address
> > + * space, and call the destroy secure page UVC on each page.
> > + * Optionally exit early if a fatal signal is pending.
> > + * @mm the mm to operate on
> > + * @start the start of the range
> > + * @end the end of the range
> > + * @interruptible if not 0, stop when a fatal signal is received
> > + * Return: 0 on success, -EINTR if the function stopped before completing
> > + */
> > +int __s390_uv_destroy_range(struct mm_struct *mm, unsigned long start,
> > +			    unsigned long end, int interruptible)
> > +{
> > +	struct reset_walk_state state = { .next = start };
> > +	int r = 1;
> > +
> > +	while (r > 0) {
> > +		state.count = 0;
> > +		mmap_read_lock(mm);
> > +		r = walk_page_range(mm, state.next, end, &gather_pages_ops, &state);
> > +		mmap_read_unlock(mm);
> > +		cond_resched();
> > +		s390_uv_destroy_pfns(state.count, state.pfns);
> > +		if (interruptible && fatal_signal_pending(current))
> > +			return -EINTR;
> > +	}
> > +	return 0;
> >   }
> > -EXPORT_SYMBOL_GPL(s390_reset_acc);
> > +EXPORT_SYMBOL_GPL(__s390_uv_destroy_range);
> >   
> >   /**
> >    * s390_remove_old_asce - Remove the topmost level of page tables from the
> >   
> 

