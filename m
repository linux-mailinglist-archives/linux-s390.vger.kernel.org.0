Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA250FD8
	for <lists+linux-s390@lfdr.de>; Mon, 24 Jun 2019 17:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730742AbfFXPJl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-s390@lfdr.de>); Mon, 24 Jun 2019 11:09:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730741AbfFXPJl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Jun 2019 11:09:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 01E7C30C0DC8;
        Mon, 24 Jun 2019 15:09:41 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3DD019C6A;
        Mon, 24 Jun 2019 15:09:39 +0000 (UTC)
Date:   Mon, 24 Jun 2019 17:09:37 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Farhan Ali <alifm@linux.ibm.com>
Cc:     Eric Farman <farman@linux.ibm.com>, pasic@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [RFC v1 1/1] vfio-ccw: Don't call cp_free if we are processing
 a channel program
Message-ID: <20190624170937.4c76de8d.cohuck@redhat.com>
In-Reply-To: <3e93215c-c11a-d0bb-8982-be3f2b467e13@linux.ibm.com>
References: <cover.1561055076.git.alifm@linux.ibm.com>
        <46dc0cbdcb8a414d70b7807fceb1cca6229408d5.1561055076.git.alifm@linux.ibm.com>
        <638804dc-53c0-ff2f-d123-13c257ad593f@linux.ibm.com>
        <581d756d-7418-cd67-e0e8-f9e4fe10b22d@linux.ibm.com>
        <2d9c04ba-ee50-2f9b-343a-5109274ff52d@linux.ibm.com>
        <56ced048-8c66-a030-af35-8afbbd2abea8@linux.ibm.com>
        <20190624114231.2d81e36f.cohuck@redhat.com>
        <20190624120514.4b528db5.cohuck@redhat.com>
        <20190624134622.2bb3bba2.cohuck@redhat.com>
        <20190624140723.5aa7b0b1.cohuck@redhat.com>
        <3e93215c-c11a-d0bb-8982-be3f2b467e13@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 24 Jun 2019 15:09:41 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 24 Jun 2019 10:44:17 -0400
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 06/24/2019 08:07 AM, Cornelia Huck wrote:
> > On Mon, 24 Jun 2019 13:46:22 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> >> On Mon, 24 Jun 2019 12:05:14 +0200
> >> Cornelia Huck <cohuck@redhat.com> wrote:
> >>  
> >>> On Mon, 24 Jun 2019 11:42:31 +0200
> >>> Cornelia Huck <cohuck@redhat.com> wrote:
> >>>      
> >>>> On Fri, 21 Jun 2019 14:34:10 -0400
> >>>> Farhan Ali <alifm@linux.ibm.com> wrote:
> >>>>        
> >>>>> On 06/21/2019 01:40 PM, Eric Farman wrote:  
> >>>>>>
> >>>>>>
> >>>>>> On 6/21/19 10:17 AM, Farhan Ali wrote:  
> >>>>>>>
> >>>>>>>
> >>>>>>> On 06/20/2019 04:27 PM, Eric Farman wrote:  
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 6/20/19 3:40 PM, Farhan Ali wrote:  
> >>  
> >>>>>>>>> diff --git a/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>>>>> b/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>>>>> index 66a66ac..61ece3f 100644
> >>>>>>>>> --- a/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>>>>> +++ b/drivers/s390/cio/vfio_ccw_drv.c
> >>>>>>>>> @@ -88,7 +88,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct
> >>>>>>>>> *work)
> >>>>>>>>>                  (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
> >>>>>>>>>         if (scsw_is_solicited(&irb->scsw)) {
> >>>>>>>>>             cp_update_scsw(&private->cp, &irb->scsw);  
> >>>>>>>>
> >>>>>>>> As I alluded earlier, do we know this irb is for this cp?  If no, what
> >>>>>>>> does this function end up putting in the scsw?  
> >>>>
> >>>> Yes, I think this also needs to check whether we have at least a prior
> >>>> start function around. (We use the orb provided by the guest; maybe we
> >>>> should check if that intparm is set in the irb?)  
> >>>
> >>> Hrm; not so easy as we always set the intparm to the address of the
> >>> subchannel structure...
> >>>
> >>> Maybe check if we have have one of the conditions of the large table
> >>> 16-6 and correlate to the ccw address? Or is it enough to check the
> >>> function control? (Don't remember when the hardware resets it.)  
> >>
> >> Nope, we cannot look at the function control, as csch clears any set
> >> start function bit :( (see "Function Control", pg 16-13)
> >>
> >> I think this problem mostly boils down to "csch clears pending status;
> >> therefore, we may only get one interrupt, even though there had been a
> >> start function going on". If we only go with what the hardware gives
> >> us, I don't see a way to distinguish "clear with a prior start" from
> >> "clear only". Maybe we want to track an "issued" status in the cp?  
> > 
> > Sorry for replying to myself again :), but maybe we should simply call
> > cp_free() if we got cc 0 from a csch? Any start function has been
> > terminated at the subchannel during successful execution of csch, and
> > cp_free does nothing if !cp->initialized, so we should hopefully be
> > safe there as well. We can then add a check for the start function in
> > the function control in the check above and should be fine, I think.
> > 
> >   
> 
> So you mean not call cp_free in vfio_ccw_sch_io_todo, and instead call 
> cp_free for a cc=0 for csch (and hsch) ?
> 
> Won't we end up with memory leak for a successful for ssch then?

No; both:

- free if cc=0 for csch (as this clears the status; hsch doesn't)
- free in _todo if the start function is set in the irb and the status
  is final

> 
> But even if we don't remove the cp_free from vfio_ccw_sch_io_todo, I am 
> not sure if your suggestion will fix the problem. The problem here is 
> that we can call vfio_ccw_sch_io_todo (for a clear or halt interrupt) at 
> the same time we are handling an ssch request. So depending on the order 
> of the operations we could still end up calling cp_free from both from 
> threads (i refer to the threads I mentioned in response to Eric's 
> earlier email).

What I don't see is why this is a problem with ->initialized; wasn't
the problem that we misinterpreted an interrupt for csch as one for a
not-yet-issued ssch?

> 
> Another thing that concerns me is that vfio-ccw can also issue csch/hsch 
> in the quiesce path, independently of what the guest issues. So in that 
> case we could have a similar scenario to processing an ssch request and 
> issuing halt/clear in parallel. But maybe I am being paranoid :)

I think the root problem is really trying to clear a cp while another
thread is trying to set it up. Should we maybe use something like rcu?
