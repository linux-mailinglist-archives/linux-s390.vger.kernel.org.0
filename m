Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC727200240
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2020 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgFSG5a (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Jun 2020 02:57:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31686 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbgFSG53 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 02:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592549848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nqv5expqgPehOeHcou7l5fShS+bg6Ed7hQQmrDRcMPQ=;
        b=eLMbdE6LgAs0WKOIvomYXLJyonjTOfPt8zGtVsrhUyQEkwUEhnpMfHQ0h1VxpSW2oQt3Hq
        A02hZWi3yX/cQsuttM+ng4l0suBHJmAtjk9DdWS/14L1/p6oBHOYhokgojZZGw3AYGx2NP
        eaJpGhCCo9BdsyBwJVTD4TM6oh3w/EU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-AU6ijzt0Om6Vt-PTSwQYhw-1; Fri, 19 Jun 2020 02:57:26 -0400
X-MC-Unique: AU6ijzt0Om6Vt-PTSwQYhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C34B1800D42;
        Fri, 19 Jun 2020 06:57:25 +0000 (UTC)
Received: from gondolin (ovpn-112-224.ams2.redhat.com [10.36.112.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6ED9960BF4;
        Fri, 19 Jun 2020 06:57:21 +0000 (UTC)
Date:   Fri, 19 Jun 2020 08:57:18 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v9 12/12] s390x: css: ssch/tsch with
 sense and interrupt
Message-ID: <20200619085718.25964a0a.cohuck@redhat.com>
In-Reply-To: <2383bdc0-caaf-9cb0-f4c4-ed57c1d3dfb1@linux.ibm.com>
References: <1592213521-19390-1-git-send-email-pmorel@linux.ibm.com>
        <1592213521-19390-13-git-send-email-pmorel@linux.ibm.com>
        <20200617115442.036735c5.cohuck@redhat.com>
        <2383bdc0-caaf-9cb0-f4c4-ed57c1d3dfb1@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 17 Jun 2020 13:55:52 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 2020-06-17 11:54, Cornelia Huck wrote:
> > On Mon, 15 Jun 2020 11:32:01 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

(...)

> >> +int start_subchannel(unsigned int sid, int code, void *data, int count,
> >> +		     unsigned char flags)
> >> +{
> >> +	int cc;
> >> +	struct ccw1 *ccw = &unique_ccw;  
> > 
> > Hm... it might better to call this function "start_single_ccw" or
> > something like that.  
> 
> You are right.
> I will rework this.
> What about differentiating this badly named "start_subchannel()" into:
> 
> ccw_setup_ccw(ccw, data, cnt, flgs);
> ccw_setup_orb(orb, ccw, flgs)
> ccw_start_request(schid, orb);
> 
> would be much clearer I think.

Not sure about ccw_setup_ccw; might get a bit non-obvious if you're
trying to build a chain.

Let's see how this turns out.

(...)

> I will rework this.
> 
> - rework the start_subchannel()
> - rework the read_len() if we ever need this

I think checking the count after the request concluded is actually a
good idea. In the future, we could also add a check that it matches the
requested length for a request where SLI was not specified.

> 
> Also thinking to put the irq_io routine inside the library, it will be 
> reused by other tests.

Yes, that probably makes sense as well.

