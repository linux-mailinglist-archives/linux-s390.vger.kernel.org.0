Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772451E1F2C
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2020 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgEZJzt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 May 2020 05:55:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728746AbgEZJzs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 05:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590486948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cQApP9aKEI0EAEIJXWQWFCwQQofjUokxLamDjDh03I=;
        b=OCRlOM8UzXYBvbldOqAruxuKRleP6CclZdyqQk9FMDP2Te/jSMLxhUMvqOwebJDdeJAJxr
        un9sLDbSWEuTHtfKKPMB5LM3y2u856HpubyARlay6dsTB5E6UKIj/2aQGqckKO8AZDk9gl
        9ZUIkWaF506F4YDtDgGTuIsg3Kr9/wU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-9HbLNGWxPI6ox2gEn9O8Vg-1; Tue, 26 May 2020 05:55:46 -0400
X-MC-Unique: 9HbLNGWxPI6ox2gEn9O8Vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1AB651800D42;
        Tue, 26 May 2020 09:55:45 +0000 (UTC)
Received: from gondolin (ovpn-113-77.ams2.redhat.com [10.36.113.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4D3110013D5;
        Tue, 26 May 2020 09:55:43 +0000 (UTC)
Date:   Tue, 26 May 2020 11:55:41 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Jared Rossi <jrossi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] vfio-ccw: Fix interrupt handling for
 HALT/CLEAR
Message-ID: <20200526115541.4a11accc.cohuck@redhat.com>
In-Reply-To: <20200513142934.28788-1-farman@linux.ibm.com>
References: <20200513142934.28788-1-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 13 May 2020 16:29:30 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> There was some suggestion earlier about locking the FSM, but I'm not
> seeing any problems with that. Rather, what I'm noticing is that the
> flow between a synchronous START and asynchronous HALT/CLEAR have
> different impacts on the FSM state. Consider:
> 
>     CPU 1                           CPU 2
> 
>     SSCH (set state=CP_PENDING)
>     INTERRUPT (set state=IDLE)
>     CSCH (no change in state)
>                                     SSCH (set state=CP_PENDING)
>     INTERRUPT (set state=IDLE)
>                                     INTERRUPT (set state=IDLE)

A different question (not related to how we want to fix this): How
easily can you trigger this bug? Is this during normal testing with a
bit of I/O stress, or do you have a special test case?

