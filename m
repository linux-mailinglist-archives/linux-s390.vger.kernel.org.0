Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCC3216B07
	for <lists+linux-s390@lfdr.de>; Tue,  7 Jul 2020 13:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGGLF6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 7 Jul 2020 07:05:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgGGLF5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Jul 2020 07:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594119956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV+foSRtJ86agpIyAxkmLdOp0anp2eSGaJw/5KwJtx8=;
        b=HzhxXE6ib0AQB2Us8WI2iCeVOrGnQVIcMtAzgLpKZoVTZnxmsujuoEc4m4x9rmEFkNaSGn
        eOTJt4UEQ9mhmHkATZPzK4b3m1aSn4P5CZqK/YeNj4u/X/65Os+gHTgC2bPRMMcMGKVHPH
        8w3mnAmnUXi6oXJthtX3gKSImgo80vY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-AE5bAHHEPiWYWEH0RGs3NA-1; Tue, 07 Jul 2020 07:05:52 -0400
X-MC-Unique: AE5bAHHEPiWYWEH0RGs3NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F32218A0760;
        Tue,  7 Jul 2020 11:05:51 +0000 (UTC)
Received: from gondolin (ovpn-113-54.ams2.redhat.com [10.36.113.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1170F5BAC3;
        Tue,  7 Jul 2020 11:05:46 +0000 (UTC)
Date:   Tue, 7 Jul 2020 13:05:30 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com,
        drjones@redhat.com
Subject: Re: [kvm-unit-tests PATCH v10 9/9] s390x: css: ssch/tsch with sense
 and interrupt
Message-ID: <20200707130530.1f365c5f.cohuck@redhat.com>
In-Reply-To: <b4bad260-1ae5-7cd8-2339-63c73e3218bd@linux.ibm.com>
References: <1593707480-23921-1-git-send-email-pmorel@linux.ibm.com>
        <1593707480-23921-10-git-send-email-pmorel@linux.ibm.com>
        <20200706114655.5088b6b7.cohuck@redhat.com>
        <02eb7a70-7a74-6f09-334f-004e69aaa198@linux.ibm.com>
        <20200706162413.1a24fe40.cohuck@redhat.com>
        <b4bad260-1ae5-7cd8-2339-63c73e3218bd@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 7 Jul 2020 12:57:03 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-07-06 16:24, Cornelia Huck wrote:
> > On Mon, 6 Jul 2020 15:01:50 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> On 2020-07-06 11:46, Cornelia Huck wrote:  
> >>> On Thu,  2 Jul 2020 18:31:20 +0200
> >>> Pierre Morel <pmorel@linux.ibm.com> wrote:
> >>>      
> >>>> After a channel is enabled we start a SENSE_ID command using
> >>>> the SSCH instruction to recognize the control unit and device.
> >>>>
> >>>> This tests the success of SSCH, the I/O interruption and the TSCH
> >>>> instructions.
> >>>>
> >>>> The SENSE_ID command response is tested to report 0xff inside
> >>>> its reserved field and to report the same control unit type
> >>>> as the cu_type kernel argument.
> >>>>
> >>>> Without the cu_type kernel argument, the test expects a device
> >>>> with a default control unit type of 0x3832, a.k.a virtio-net-ccw.
> >>>>
> >>>> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >>>> ---
> >>>>    lib/s390x/asm/arch_def.h |   1 +
> >>>>    lib/s390x/css.h          |  32 ++++++++-
> >>>>    lib/s390x/css_lib.c      | 148 ++++++++++++++++++++++++++++++++++++++-
> >>>>    s390x/css.c              |  94 ++++++++++++++++++++++++-
> >>>>    4 files changed, 272 insertions(+), 3 deletions(-)  
> > 
> > (...)
> >   
> >>>> @@ -114,6 +128,7 @@ retry:
> >>>>    		return cc;
> >>>>    	}
> >>>>    
> >>>> +	report_info("stsch: flags: %04x", pmcw->flags);  
> >>>
> >>> It feels like all of this already should have been included in the
> >>> previous patch?  
> >>
> >> Yes, I did not want to modify it since it was reviewed-by.  
> > 
> > It's not such a major change (the isc change and this here), though...
> > what do the others think?  
> changed my mind:
> What about keeping css_enable() to only do enable, in case we only want 
> to do this, and add a function to modify the ISC.

Hm, the isc is only really relevant while the subchannel is enabled, so
this would be fine if we only ever modified the isc while the
subchannel is disabled. On the other hand, we introduce an extra round
of msch. No strong opinion on my side.

