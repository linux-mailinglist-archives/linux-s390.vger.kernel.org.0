Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594701B60E8
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 18:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgDWQ2L (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Apr 2020 12:28:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729504AbgDWQ2L (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Apr 2020 12:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587659289;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDOcJzHXeT3ucjq/SyFh2PoJeAKLCX4lfsJF+FVo3H4=;
        b=hwyJ+NiznNilwWTCuEB9HWifS8Fkj/bNsYbygbSER+hMEhfnLvI1fFq4EcfWTo6E3Rs4+S
        7g69v42ud5tg6G6OL9MN8LL6F3TZHrfLWfUOaI2ZUaocIUueERM/Z3hCkcsCOD2nAHDXmq
        VSh3zzWwQhCPUU1JAU2a4wjYDiaycWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-mgbSpZcpP-ScUeREYBrAOA-1; Thu, 23 Apr 2020 12:28:07 -0400
X-MC-Unique: mgbSpZcpP-ScUeREYBrAOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAB8C8B58D0;
        Thu, 23 Apr 2020 16:27:55 +0000 (UTC)
Received: from gondolin (ovpn-112-121.ams2.redhat.com [10.36.112.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 364095F7E4;
        Thu, 23 Apr 2020 16:27:54 +0000 (UTC)
Date:   Thu, 23 Apr 2020 18:27:51 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200423182751.55dafe55.cohuck@redhat.com>
In-Reply-To: <20200423175559.309cc924.pasic@linux.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <20200423175559.309cc924.pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 23 Apr 2020 17:55:59 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 17 Apr 2020 14:38:11 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > Friendly ping.
> >   
> 
> Sorry for the late answer. I prefer to let Vineeth give us his opinion
> first. I did invest some 30 minutes in understanding the problem, but
> I'm not sure I understood it properly. According to my current
> understanding, the current state of affairs is a mess, and the proposed
> change wouldn't make the situation substantially cleaner, but it would
> help with the problem at hand.
> 
> Conny, do you have more background information on uevent suppression
> (is there some sort of a generic contract between kernel and userspace
> for uevent suppression)?

I'm not aware of a 'generic contract'; it's probably a lot of 'we
thought it would be a good idea to do it like that'.

> 
> From a quick grep it seems to me that most of the uses are about being
> nice to userspace in a sense, that we want to make sure that when
> event is received by userspace it can do it's thing, and does not have
> to wait until the kernel has finished with the stuff that needs to be
> done to reach a state of affairs that can be considered normal.

The general idea is that once userspace is notified of the existence of
a device, it can go ahead and try to make use of it. This is not always
true; sometimes, there's a logic problem in how devices are
initialized, sometimes, we want indeed to avoid userspace do work that
will turn out to be useless. The latter was the intention with uevent
suppression for I/O subchannels: do not notify userspace of the
existence of an I/O subchannel, unless there's a valid ccw device
behind it. Of course, that leads to trouble for vfio-ccw.

Another idea: Have the add uevent for subchannels in all cases, but
adapt any udev rules that do anything other than set driver_override to
do nothing unless a (to be added) change uevent comes along.

(And yes, I agree that this is a mess.)

> 
> Regards,
> Halil
> 
> 
> 
> > On Fri, 3 Apr 2020 12:40:32 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > Hi,
> > > 
> > > this is kind-of-a-followup to the uevent patches I sent in
> > > <20200327124503.9794-1-cohuck@redhat.com> last Friday.
> > > 
> > > Currently, the common I/O layer will suppress uevents for subchannels
> > > that are being registered, delegating generating a delayed ADD uevent
> > > to the driver that actually binds to it and only generating the uevent
> > > itself if no driver gets bound. The initial version of that delaying
> > > was introduced in fa1a8c23eb7d ("s390: cio: Delay uevents for
> > > subchannels"); from what I remember, we were seeing quite bad storms of
> > > uevents on LPARs that had a lot of I/O subchannels with no device
> > > accessible through them.  
> [..]
> > > Thoughts?
> > >   
> >   
> 

