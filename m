Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7E1B6099
	for <lists+linux-s390@lfdr.de>; Thu, 23 Apr 2020 18:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgDWQUP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 23 Apr 2020 12:20:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54545 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728865AbgDWQUN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 12:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587658812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEq0UZbHGWiTLtOlqeCUUAcaNpLPTOeFh1jeoz1m0VI=;
        b=gy1sB2TUJyn2PiqafhRPMISenHCmiEKE0d6DEYv5ItIZEfv1UQ746aCZx6mk0q6/gFvx8U
        5Kd99QGbjejhOSg7UNdLjSs2HabWnVNeWh9dpvE8ezt7xo2bhE7Vk2CXXJ9uaVgq1LuBqe
        NSMUtZ7xc+IRtTdTEP/xaxXFOLnv7Jw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-2a9JpnF1MG-AnDrLeu_VKQ-1; Thu, 23 Apr 2020 12:20:08 -0400
X-MC-Unique: 2a9JpnF1MG-AnDrLeu_VKQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B390B108BC4B;
        Thu, 23 Apr 2020 16:20:06 +0000 (UTC)
Received: from gondolin (ovpn-112-121.ams2.redhat.com [10.36.112.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 049F86061C;
        Thu, 23 Apr 2020 16:20:04 +0000 (UTC)
Date:   Thu, 23 Apr 2020 18:20:01 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.vnet.ibm.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Boris Fiuczynski <fiuczy@linux.ibm.com>
Subject: Re: [RFD] uevent handling for subchannels
Message-ID: <20200423182001.40345df8.cohuck@redhat.com>
In-Reply-To: <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
References: <20200403124032.5e70603d.cohuck@redhat.com>
        <20200417143811.7e6ecb2c.cohuck@redhat.com>
        <8649ea94-8617-07b6-170e-65c278d9383b@linux.vnet.ibm.com>
        <c69da1c0-d151-257b-fe43-786e47a3cf9b@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 23 Apr 2020 16:52:24 +0200
Vineeth Vijayan <vneethv@linux.vnet.ibm.com> wrote:

> Hi Corenelia,
> 
> few cents on this,
> 
> 1. css_register_subchannel() is called only for valid subchannels, which 
> is taken care in the
> css_alloc_subchannel(). So Adding a second css_sch_is_valid() in 
> css_register_subchannel()
> might not help us here. We still need to find a mechanism to avoid the 
> performance impact
> because of the uevent-storm from IO-subchannels without any valid device 
> on them.

Ah, I missed that.

But I'm wondering whether the number of non-operational devices that
will end up not being registered is actually that high in a normal
setup.

The really bad case, as I understand it, is

0    ...    n      ...      m ... 0xffff
<nothing> <dev> <nothing> <dev> <nothing>

where we end up with large numbers of subchannels with !dnv prior to n
and between n and m. (On LPAR; z/VM and QEMU will usually have mostly
consecutive devices-on-subchannels, unless there has been a huge amount
of hotplug been going on.)

In this case, the !dnv check already prevents us from even registering
the device, so the only problematic devices left are those where we
fail to successfully drive I/O to -- are these very common on sane
setups?

(The code has seen some revisions since I introduced that suppression
stuff, maybe I'm missing something.)

> 
> 2. We will have to find a way to get the AVAILABLE-VALID-CCW-device 
> information from css layer,
> which would help vfio-ccw drivers to work with the uevents when it is 
> not suppressed.

But if we bind the subchannel to vfio-ccw, we do not have any ccw
device, right? Or am I misunderstanding?

> Then we could also change the way ccw_device_call_sch_unregister() 
> works, where
> the subchannel-unregister is happening from an upper layer.

Hm, what's the problem here? This seems to be mostly a case of "we did
I/O to the device and it appeared not operational; so we go ahead and
unregister the subchannel"? Childless I/O subchannels are a bit useless.

