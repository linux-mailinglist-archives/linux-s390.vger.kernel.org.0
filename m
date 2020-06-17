Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDA51FD27E
	for <lists+linux-s390@lfdr.de>; Wed, 17 Jun 2020 18:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFQQoV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 17 Jun 2020 12:44:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38483 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726511AbgFQQoU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 Jun 2020 12:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592412258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uHqYGq8gMGijl7hrfFNPw6Y3ObzoMwmEvofgpNQ4KMA=;
        b=YesicYofcjNjs/qjIdJJF4tpYBaifVmWcsWmSxzQ0bpV1lFE2ZayjKqhOpiox8iiMlMmhD
        6IqMOHeUJakc8CTc4oQLTscdwZbnoOm1AavnHmC7ChChrdpWFYBk4XIpVz19m/ocStA5+5
        kB2kj963IoXPut3FqMxslp2X4QY/gkU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-2Jmd5TKqPc6-qmz6070q1g-1; Wed, 17 Jun 2020 12:44:17 -0400
X-MC-Unique: 2Jmd5TKqPc6-qmz6070q1g-1
Received: by mail-qt1-f200.google.com with SMTP id x6so2186960qts.3
        for <linux-s390@vger.kernel.org>; Wed, 17 Jun 2020 09:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHqYGq8gMGijl7hrfFNPw6Y3ObzoMwmEvofgpNQ4KMA=;
        b=jLpmMVBmXzFt7ESjiGJojCK4qiIQ/oThja1q2WSUscgYWuDNLaQK6KkxthtdKgAWUa
         kQTBtNIpBG9jVGDa2EzTOOWvM9JtF3DLrrHLwDvBVGkL3bKfv1Gxj3WYret5xRpzo8Nj
         kQTnHj7EAuGww3HMi6gz8NUBUXeUpxHNTxo4ztFV11DEqRdHnzhRmDHKAiqhrynu7ORG
         UQRCR1ud4rIK2RvKovX4aAyi3KD6pELdKj3KSsekeDArq696tImiaHphz6AKzaQnHk10
         +wclndnmiasPmXC6EEGZqgVUr+z0LJw3aBM+m/P7flDi6wxR/H4YFWU5CbA+u1O5Jy7s
         //tw==
X-Gm-Message-State: AOAM533e78Z4hu89fLOg9K0FDsMZKLXYagg5RtrSDeX2ORW4I4DrZJJ5
        zL9jIt7Cve5IhRErk9tk0pg2/T+X9KpPyNQStB+BAx2BOKcPYrtWATJ+9JXjgunxh3t8ZHijIux
        iKxtpzA+MFmy8XQnvb5SKSA==
X-Received: by 2002:ac8:35fd:: with SMTP id l58mr27549713qtb.324.1592412256721;
        Wed, 17 Jun 2020 09:44:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzlHNvNUfv10ny3GvWXjj+c+QD1W86k7S+sDSFqbWy+cGxtKmllCh4TQR/EJJQuXLGd22t+g==
X-Received: by 2002:ac8:35fd:: with SMTP id l58mr27549692qtb.324.1592412256431;
        Wed, 17 Jun 2020 09:44:16 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m26sm380110qtm.73.2020.06.17.09.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 09:44:15 -0700 (PDT)
Date:   Wed, 17 Jun 2020 12:44:13 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200617164413.GG76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
 <20200616163510.GD11838@xz-x1>
 <edb88596-6f2c-2648-748d-591a0b1e0131@de.ibm.com>
 <20200617160617.GD76766@xz-x1>
 <8bd8dcf6-f2f0-d44e-9bf8-6fd4fe299aa9@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bd8dcf6-f2f0-d44e-9bf8-6fd4fe299aa9@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 17, 2020 at 06:14:52PM +0200, Christian Borntraeger wrote:
> 
> 
> On 17.06.20 18:06, Peter Xu wrote:
> > Hi, Christian,
> > 
> > On Wed, Jun 17, 2020 at 08:19:29AM +0200, Christian Borntraeger wrote:
> >>
> >>
> >> On 16.06.20 18:35, Peter Xu wrote:
> >>> Hi, Alexander,
> >>>
> >>> On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> >>>>> @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >>>>>  	if (unlikely(fault & VM_FAULT_ERROR))
> >>>>>  		goto out_up;
> >>>>>
> >>>>> -	/*
> >>>>> -	 * Major/minor page fault accounting is only done on the
> >>>>> -	 * initial attempt. If we go through a retry, it is extremely
> >>>>> -	 * likely that the page will be found in page cache at that point.
> >>>>> -	 */
> >>>>>  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> >>>>> -		if (fault & VM_FAULT_MAJOR) {
> >>>>> -			tsk->maj_flt++;
> >>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> >>>>> -				      regs, address);
> >>>>> -		} else {
> >>>>> -			tsk->min_flt++;
> >>>>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> >>>>> -				      regs, address);
> >>>>> -		}
> >>>>>  		if (fault & VM_FAULT_RETRY) {
> >>>>>  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >>>>>  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> > 
> > [1]
> > 
> >>>>
> >>>> Seems like the call to mm_fault_accounting() will be missed if
> >>>> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> >>>> jumps to "out_up"...
> >>>
> >>> This is true as a functional change.  However that also means that we've got a
> >>> VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
> >>> than handled correctly (for instance, due to some try_lock failed during the
> >>> fault process).
> >>>
> >>> To me, that case should not be counted as a page fault at all?  Or we might get
> >>> the same duplicated accounting when the page fault retried from a higher stack.
> >>>
> >>> Thanks
> >>
> >> This case below (the one with the gmap) is the KVM case for doing a so called
> >> pseudo page fault to our guests. (we notify our guests about major host page
> >> faults and let it reschedule to something else instead of halting the vcpu).
> >> This is being resolved with either gup or fixup_user_fault asynchronously by
> >> KVM code (this can also be sync when the guest does not match some conditions)
> >> We do not change the counters in that code as far as I can tell so we should
> >> continue to do it here.
> >>
> >> (see arch/s390/kvm/kvm-s390.c
> >> static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
> >> {
> >> [...]
> >>         } else if (current->thread.gmap_pfault) {
> >>                 trace_kvm_s390_major_guest_pfault(vcpu);
> >>                 current->thread.gmap_pfault = 0;
> >>                 if (kvm_arch_setup_async_pf(vcpu))
> >>                         return 0;
> >>                 return kvm_arch_fault_in_page(vcpu, current->thread.gmap_addr, 1);
> >>         }
> > 
> > Please correct me if I'm wrong... but I still think what this patch does is the
> > right thing to do.
> > 
> > Note again that IMHO when reached [1] above it means the page fault is not
> > handled correctly so we need to fallback to KVM async page fault, then we
> > shouldn't increment the accountings until it's finally handled correctly. That
> > final accounting should be done in the async pf path in gup code where the page
> > fault is handled:
> > 
> >   kvm_arch_fault_in_page
> >     gmap_fault
> >       fixup_user_fault
> > 
> > Where in fixup_user_fault() we have:
> > 
> > 	if (tsk) {
> > 		if (major)
> > 			tsk->maj_flt++;
> > 		else
> > 			tsk->min_flt++;
> > 	}
> > 
> 
> Right that case does work. Its the case where we do not inject a pseudo pagefault and
> instead fall back to synchronous fault-in.
> What is about the other case:
> 
> kvm_setup_async_pf
> 	->workqueue
> 		async_pf_execute
> 			get_user_pages_remote
> 
> Does get_user_pages_remote do the accounting as well? I cant see that.
> 

It should, with:

  get_user_pages_remote
    __get_user_pages_remote
      __get_user_pages_locked
        __get_user_pages
          faultin_page

Where the accounting is done in faultin_page().

We probably need to also move the accounting in faultin_page() to be after the
retry check too, but that should be irrelevant to this patch.

Thanks!

-- 
Peter Xu

