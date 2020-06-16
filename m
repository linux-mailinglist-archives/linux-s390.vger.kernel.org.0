Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C75421FBBDA
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2020 18:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgFPQfR (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 16 Jun 2020 12:35:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729810AbgFPQfQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 Jun 2020 12:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592325314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORHnGJFA6Z19L1N7yd7kPFx1/z/PnVDRBNvmZJMNqEQ=;
        b=fMosJs1XNVkbER8KI+dtKPsk5Ps/nSyrwab7fIyqLlzYzMnNUQh23ZVEEn7/KzmBBe7Udt
        T1Yam78jJ+OUJ02BFpleIz/yV7Net4EtF3l7dJmX0UA4r2N7AeyiVPoL7Zd8yaq6jG83xq
        2Y4ADwQ18zMMP43Kmk321dHMckMqI2w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-Umurh_kOMVWF0hoV2xrlnw-1; Tue, 16 Jun 2020 12:35:13 -0400
X-MC-Unique: Umurh_kOMVWF0hoV2xrlnw-1
Received: by mail-qv1-f72.google.com with SMTP id ba13so15932894qvb.15
        for <linux-s390@vger.kernel.org>; Tue, 16 Jun 2020 09:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ORHnGJFA6Z19L1N7yd7kPFx1/z/PnVDRBNvmZJMNqEQ=;
        b=nFw9WBogQDhF8Urue29HPETEkVJOyM4190q/ub8d3yQC9lwKxicdSwpef/SQ6a+60Y
         erx7K8/z5/BWoVZq5MiNkm9tjRqGIuZsTpp9fdEdhPBK+4EJ4N2z71CpeuiVjnGj9s5J
         hEEN8X48FU8CtVIdMMpzZQ7kBFd11OczCZ1G+Z6frJSoyuTI3BXlsYIB7AGN8KKfCzgK
         40Pbufq4gPJ/w7dK5GKWzcZqGc2Ocb4SEyZc1hUrSuVH0eGDLgLupzIcJ+SgF5ddih64
         fiQLaoXRVejg4O1YlSzA+frmRoMGjx3F0lZNnMSxw7Hg26K0afpBnJJp6HZYEkwy0TpE
         8r/g==
X-Gm-Message-State: AOAM5307dvzvoaUOtDajbGb7UefKOJdRXttunzkNgWCl5tFFn4wgkSO3
        hw+pzjNUh5sptESxId7lrps0FJaRfnBCWKZgxkd00xuKMsghPbsnWBMfkzwBgjApX8cth+vGSJC
        h4nIRfnK1qZkUpP/uaMNxCA==
X-Received: by 2002:a37:9587:: with SMTP id x129mr21560269qkd.184.1592325312801;
        Tue, 16 Jun 2020 09:35:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFtYGitcStKhm9rXFtngsYzszPm1k1N+2h9Oc/swRH+scEB+KPGSxp8+t3TKRkUXSpqa15Pg==
X-Received: by 2002:a37:9587:: with SMTP id x129mr21560236qkd.184.1592325312498;
        Tue, 16 Jun 2020 09:35:12 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id b24sm14336505qkj.0.2020.06.16.09.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:35:11 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:35:10 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Message-ID: <20200616163510.GD11838@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222302.8452-1-peterx@redhat.com>
 <20200616155933.GA12897@oc3871087118.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616155933.GA12897@oc3871087118.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi, Alexander,

On Tue, Jun 16, 2020 at 05:59:33PM +0200, Alexander Gordeev wrote:
> > @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> > 
> > -	/*
> > -	 * Major/minor page fault accounting is only done on the
> > -	 * initial attempt. If we go through a retry, it is extremely
> > -	 * likely that the page will be found in page cache at that point.
> > -	 */
> >  	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> > -		if (fault & VM_FAULT_MAJOR) {
> > -			tsk->maj_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> > -				      regs, address);
> > -		} else {
> > -			tsk->min_flt++;
> > -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> > -				      regs, address);
> > -		}
> >  		if (fault & VM_FAULT_RETRY) {
> >  			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
> >  			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
> 
> Seems like the call to mm_fault_accounting() will be missed if
> we entered here with FAULT_FLAG_RETRY_NOWAIT flag set, since it
> jumps to "out_up"...

This is true as a functional change.  However that also means that we've got a
VM_FAULT_RETRY, which hints that this fault has been requested to retry rather
than handled correctly (for instance, due to some try_lock failed during the
fault process).

To me, that case should not be counted as a page fault at all?  Or we might get
the same duplicated accounting when the page fault retried from a higher stack.

Thanks,

-- 
Peter Xu

