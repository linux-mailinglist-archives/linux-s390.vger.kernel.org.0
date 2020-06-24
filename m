Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF0A5207D9A
	for <lists+linux-s390@lfdr.de>; Wed, 24 Jun 2020 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391383AbgFXUky (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 24 Jun 2020 16:40:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgFXUkx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Jun 2020 16:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593031252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s/Q+RsZBYMOAhrMPCGGxWYAFNZoQJnDuY4/Qu5DbXBw=;
        b=cGo19hyg1lEv1BEwzv+MYIVL9q89DC5V2rj4iRHHuoyrUnA9Lre9IdCgAgAYKuFY/Gl86f
        GUhGi/x4TV4+QepuoQ7/xZebYXTZnrBdG0Bvui0TsDm9hc1o4N5GbeSINsKHnham5NkHil
        1qTzGrbOxj1dTB8r/IbV/+/7Ka5R2qc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-L_8KEJnyOFu73cjLNVk_dw-1; Wed, 24 Jun 2020 16:40:50 -0400
X-MC-Unique: L_8KEJnyOFu73cjLNVk_dw-1
Received: by mail-qk1-f199.google.com with SMTP id h18so2500967qkj.13
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2020 13:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/Q+RsZBYMOAhrMPCGGxWYAFNZoQJnDuY4/Qu5DbXBw=;
        b=UesVyGw2un9DVSnOVf1+jS6dMSlsVt15tDcvo84WTQeUEbttP426yTa9/gwVPZQF7Q
         9umQCctqv25Uy4KqrQPmmMc27IgPs8/rdfL0zwb1hDJWH5tq2WPVzvo1xbzdSu5kkSw0
         PUSUj/BoM/j8+ZNbkVen8bHgu3Gn3dWOy/hHjb7IP0gNg3uNBCfbCTWXwz9lGrvrmrBj
         ZoIeeL0uWFhm9frWdchgxWxyPhu9C+Y0pubIaCdFyPSsf2rTUJGkVQ2knEQTfTVvgaOC
         6lbZznpCV54Fza4Sx2DyBfNt/tpKN4INcQ5CvPJ3kiIh6LoytE9O1pi/rJeeFWCEtgLm
         wJrA==
X-Gm-Message-State: AOAM532KM/iLbvgLMfP3ebEOjROE7lYBt5oJRe9avSxmf/bOaCp5ed3w
        /Oyc9WDT1y2mRz6vShXF9pZ1Dc9+Z/AD3CpTo+KNIi1SMGiGcOCbzYaCvmhYImHUdnGLUDjYc5f
        68VEK3DxRHS3Jzp1tTpkO3g==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr27918965qtv.289.1593031250300;
        Wed, 24 Jun 2020 13:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDdof3kQnRWMH/ZuwYgHnSQWiMQJJVG8ff1Lps2dKtAX8O4FtVpVCamC1ozXzBQ9kDQ5TqUw==
X-Received: by 2002:ac8:4d4d:: with SMTP id x13mr27918944qtv.289.1593031250075;
        Wed, 24 Jun 2020 13:40:50 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p3sm4444095qtl.21.2020.06.24.13.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:40:49 -0700 (PDT)
Date:   Wed, 24 Jun 2020 16:40:47 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 18/26] mm/s390: Use general page fault accounting
Message-ID: <20200624204047.GC64004@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619161335.9664-1-peterx@redhat.com>
 <20200624204930.2445bcd6@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624204930.2445bcd6@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 24, 2020 at 08:49:30PM +0200, Gerald Schaefer wrote:
> On Fri, 19 Jun 2020 12:13:35 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> > 
> > CC: Heiko Carstens <heiko.carstens@de.ibm.com>
> > CC: Vasily Gorbik <gor@linux.ibm.com>
> > CC: Christian Borntraeger <borntraeger@de.ibm.com>
> > CC: linux-s390@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/s390/mm/fault.c | 16 +---------------
> >  1 file changed, 1 insertion(+), 15 deletions(-)
> > 
> > diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> > index ab6d7eedcfab..4d62ca7d3e09 100644
> > --- a/arch/s390/mm/fault.c
> > +++ b/arch/s390/mm/fault.c
> > @@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	 * make sure we exit gracefully rather than endlessly redo
> >  	 * the fault.
> >  	 */
> > -	fault = handle_mm_fault(vma, address, flags, NULL);
> > +	fault = handle_mm_fault(vma, address, flags, regs);
> >  	if (fault_signal_pending(fault, regs)) {
> >  		fault = VM_FAULT_SIGNAL;
> >  		if (flags & FAULT_FLAG_RETRY_NOWAIT)
> > @@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
> >  	if (unlikely(fault & VM_FAULT_ERROR))
> >  		goto out_up;
> 
> There are two cases here where we skipped the accounting,
> fault_signal_pending() and VM_FAULT_ERROR, similar to other archs.
> 
> fault_signal_pending() should be ok, because that only seems to be true
> for fault & VM_FAULT_RETRY, in which case the new approach also skips
> the accounting.

IMHO it's still possible to have fault_signal_pending() return true even if the
fault is not with VM_FAULT_RETRY, e.g., when the signal is delivered right
after the fault is correctly handled for the thread.  However I hope we can
avoid considering that too even if so...

> 
> But for VM_FAULT_ERROR, the new approach would do accounting, IIUC. Is
> that changed on purpose? See also my reply on [PATCH 01/26].

(replied in the other thread)

Thanks,

-- 
Peter Xu

