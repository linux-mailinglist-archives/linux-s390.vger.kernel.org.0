Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A9620D378
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jun 2020 21:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgF2S7N (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jun 2020 14:59:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33759 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728059AbgF2S7M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jun 2020 14:59:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DvR5lot4hzCFT5eKKaI2zdb2cQ/Ts1ntFHFt81EYMcQ=;
        b=AS6Hetx93aYp9sX5b/A2qG4E/aGCY4T3cVukc733LCH8S+6fjJGt939Mucm7a4cmR2kvKy
        8MZGdLFojdDFbGUbUc0bj3QnCs2ZcVkfShcghz81SltVdWf6MiyOiBuWlH/07vY0iKItqp
        FfIqP1GZazyzlGcpKSu/mQHiMicxuu4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-tk6KlmltOlK2xGJforFtxQ-1; Mon, 29 Jun 2020 07:56:37 -0400
X-MC-Unique: tk6KlmltOlK2xGJforFtxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 221EA464;
        Mon, 29 Jun 2020 11:56:36 +0000 (UTC)
Received: from gondolin (ovpn-113-61.ams2.redhat.com [10.36.113.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 933D97166E;
        Mon, 29 Jun 2020 11:56:34 +0000 (UTC)
Date:   Mon, 29 Jun 2020 13:56:31 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Peter Oberparleiter <oberpar@linux.ibm.com>
Cc:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200629135631.10db3c32.cohuck@redhat.com>
In-Reply-To: <20200430124316.023a82b0.cohuck@redhat.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
        <20200423182001.40345df8.cohuck@redhat.com>
        <53d7d08d-c1d2-dad3-7f01-a165b24b0359@linux.ibm.com>
        <20200430124316.023a82b0.cohuck@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 30 Apr 2020 12:43:16 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

<It's been some time, but this topic has recently popped up again.>

> On Mon, 27 Apr 2020 12:10:17 +0200
> Peter Oberparleiter <oberpar@linux.ibm.com> wrote:
> 
> > On 23.04.2020 18:20, Cornelia Huck wrote:  
> > > On Thu, 23 Apr 2020 16:52:24 +0200
> > > Vineeth Vijayan <vneethv@linux.vnet.ibm.com> wrote:    
> > >> Then we could also change the way ccw_device_call_sch_unregister() 
> > >> works, where
> > >> the subchannel-unregister is happening from an upper layer.    
> > > 
> > > Hm, what's the problem here? This seems to be mostly a case of "we did
> > > I/O to the device and it appeared not operational; so we go ahead and
> > > unregister the subchannel"? Childless I/O subchannels are a bit useless.    
> > 
> > Hey Conny,
> > 
> > sparked by your proposal, Vineeth and myself looked at the corresponding
> > CIO code and wondered if things couldn't be done in a generally
> > better/cleaner way. So here we'd like to get your opinion.
> > 
> > In particular, as it is currently, a child-driver (IO subchannel driver,
> > vfio-ccw, etc.) unregisters a device owned by a parent-device-driver
> > (CSS), which feels from a high-level-view like a layering violation:
> > only the parent driver should register and unregister the parent device.
> > Also in case no subchannel driver is available (e.g. due to
> > driver_override=none), there would be no subchannel ADD event at all.  
> 
> Doesn't the base css code generate the uevent in that case?

Just checked again, the code in css_register_subchannel() should indeed
take care of the !driver case. But still, even better if we can get rid
of it :)

> 
> > 
> > So, tapping into you historical expertise about CIO, is there any reason
> > for doing it this way beyond being nice to userspace tooling that
> > subchannels with non-working CCW devices are automatically hidden by
> > unregistering them?  
> 
> We always had ccw devices behind I/O subchannels, but that has not been
> the case since we introduced vfio-ccw, so hopefully everybody can deal
> with that. The rationale behind this was that device-less I/O
> subchannels were deemed to be useless; I currently can't remember
> another reason.
> 
> What about EADM, btw? CHSC does not have a device, and message does not
> have a driver.

Just checked EADM; it does not have a child device.

> 
> > 
> > Removing the child-unregisters-parent logic this would also enable
> > manual rebind of subchannels for which only a different driver than the
> > default one can successfully talk to the child device, though I'm
> > unaware of any current application for that.  
> 
> Yes.
> 
> Let me think about that some more (no clear head currently, sorry.)

Ok, so I've resumed the thinking process, and I think getting rid of
the "no I/O subchannel without functional device" approach is a good
idea, and allows us to make handling driver matches more similar to
everyone else.

What changes would be needed?
* The whole logic to suppress uevents for subchannels and generate one
  later will go. (Touches the various subchannel driver, including
  vfio-ccw.)
* ccw_device_todo() can just unregister the ccw device, and there's no
  longer a need for ccw_device_call_sch_unregister(). (IIUC, this also
  covers setting disconnected devices offline.)
* As the I/O subchannel driver now needs to deal with cases where no
  ccw device is available, the code for that needs to be checked.
  (That's probably the most time-consuming task.)

Userspace should be fine with I/O subchannels without ccw device,
that's nothing new.

Does that sound reasonable?

