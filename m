Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158FA15BAF7
	for <lists+linux-s390@lfdr.de>; Thu, 13 Feb 2020 09:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgBMIpB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 13 Feb 2020 03:45:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729496AbgBMIpB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Feb 2020 03:45:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581583500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hn3WrUa+llk/toxacuv4ppNzSqH2ai2ii21rs8gjazk=;
        b=GLE6/72RYwcEe4XRv/4jbtkWUw7hV39fhpDn7HgHSJTCUpqVnSGQOAU3CLT5CsRo7YC+QU
        ZXZMZ/KgUaEk9mKnfLAsE/N2EaU9OJcg3PYoeCJvHz8kw5KgXIt1SfF8fMAAkoCMVnzXl2
        B0xdx1diMKtGMtfv2uQ70xxZio9SqFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-oIWsehGWOHumwd_1Tred8Q-1; Thu, 13 Feb 2020 03:44:56 -0500
X-MC-Unique: oIWsehGWOHumwd_1Tred8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 255E08017DF;
        Thu, 13 Feb 2020 08:44:55 +0000 (UTC)
Received: from gondolin (ovpn-117-87.ams2.redhat.com [10.36.117.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 062785C13E;
        Thu, 13 Feb 2020 08:44:49 +0000 (UTC)
Date:   Thu, 13 Feb 2020 09:44:38 +0100
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
        Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/35] s390/mm: provide memory management functions for
 protected KVM guests
Message-ID: <20200213094438.21204b84.cohuck@redhat.com>
In-Reply-To: <e0642555-9781-163a-7dd3-75e769dfb2d9@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
        <20200207113958.7320-6-borntraeger@de.ibm.com>
        <20200212144212.1d0b4226.cohuck@redhat.com>
        <e0642555-9781-163a-7dd3-75e769dfb2d9@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 13 Feb 2020 08:43:33 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 12.02.20 14:42, Cornelia Huck wrote:
> > On Fri,  7 Feb 2020 06:39:28 -0500
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >>
> >> This provides the basic ultravisor calls and page table handling to cope
> >> with secure guests:
> >> - provide arch_make_page_accessible
> >> - make pages accessible after unmapping of secure guests
> >> - provide the ultravisor commands convert to/from secure
> >> - provide the ultravisor commands pin/unpin shared
> >> - provide callbacks to make pages secure (inacccessible)
> >>  - we check for the expected pin count to only make pages secure if the
> >>    host is not accessing them
> >>  - we fence hugetlbfs for secure pages
> >>
> >> Co-developed-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> >> Signed-off-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
> >> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >> [borntraeger@de.ibm.com: patch merging, splitting, fixing]
> >> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> >> ---
> >>  arch/s390/include/asm/gmap.h        |   2 +
> >>  arch/s390/include/asm/mmu.h         |   2 +
> >>  arch/s390/include/asm/mmu_context.h |   1 +
> >>  arch/s390/include/asm/page.h        |   5 +
> >>  arch/s390/include/asm/pgtable.h     |  34 +++++-
> >>  arch/s390/include/asm/uv.h          |  52 +++++++++
> >>  arch/s390/kernel/uv.c               | 172 ++++++++++++++++++++++++++++
> >>  7 files changed, 263 insertions(+), 5 deletions(-)  
> > 
> > (...)
> >   
> >> +/*
> >> + * Requests the Ultravisor to encrypt a guest page and make it
> >> + * accessible to the host for paging (export).
> >> + *
> >> + * @paddr: Absolute host address of page to be exported
> >> + */
> >> +int uv_convert_from_secure(unsigned long paddr)
> >> +{
> >> +	struct uv_cb_cfs uvcb = {
> >> +		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
> >> +		.header.len = sizeof(uvcb),
> >> +		.paddr = paddr
> >> +	};
> >> +
> >> +	uv_call(0, (u64)&uvcb);
> >> +
> >> +	if (uvcb.header.rc == 1 || uvcb.header.rc == 0x107)  
> > 
> > I think this either wants a comment or some speaking #defines.  
> 
> Yes. We will improve some other aspects of this patch, but I will add
> 
> 	/* Return on success or if this page was already exported */

Sounds good.

> >   
> >> +		return 0;
> >> +	return -EINVAL;
> >> +}  
> > 
> > (...)
> >   
> 

