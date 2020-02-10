Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36E831581CC
	for <lists+linux-s390@lfdr.de>; Mon, 10 Feb 2020 18:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgBJRxa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 10 Feb 2020 12:53:30 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31095 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726831AbgBJRx3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 12:53:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581357208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6/wIpS+L/edbqdVXxr0j7MT6sCsOYDqwy1UQp9VYpeo=;
        b=KmRfVowVA3NDfmraZkqKOhhds5298rc0MlTWtTvDQZ5RjJOm+XwQFOileylMT4i76Eq3U9
        cTtWLjrUWxDVC4z+KZsckvGt/H/zHH9eLTADJRS13F5dCVquibbhw2q7PNb9KHG2rBXHwb
        9GAol4VSbi4Cx0nc7VYHlJlXsSI0o1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-JNrdRO0oM6iqZbyPypCX3w-1; Mon, 10 Feb 2020 12:53:26 -0500
X-MC-Unique: JNrdRO0oM6iqZbyPypCX3w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 410DD1005514;
        Mon, 10 Feb 2020 17:53:24 +0000 (UTC)
Received: from gondolin (ovpn-117-244.ams2.redhat.com [10.36.117.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2753E5D9CA;
        Mon, 10 Feb 2020 17:53:18 +0000 (UTC)
Date:   Mon, 10 Feb 2020 18:53:07 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH 24/35] KVM: s390: protvirt: disallow one_reg
Message-ID: <20200210185307.73b45f78.cohuck@redhat.com>
In-Reply-To: <20200207113958.7320-25-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-25-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  7 Feb 2020 06:39:47 -0500
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> From: Janosch Frank <frankja@linux.ibm.com>
> 
> A lot of the registers are controlled by the Ultravisor and never
> visible to KVM. Some fields in the sie control block are overlayed,
> like gbea. As no userspace uses the ONE_REG interface on s390 it is safe
> to disable this for protected guests.

Last round, I suggested

"As no known userspace uses the ONE_REG interface on s390 if sync regs
are available, no functionality is lost if it is disabled for protected
guests."

Any opinion on that?

> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  Documentation/virt/kvm/api.txt | 6 ++++--
>  arch/s390/kvm/kvm-s390.c       | 3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)

