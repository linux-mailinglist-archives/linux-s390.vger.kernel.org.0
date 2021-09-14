Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4765D40B3B5
	for <lists+linux-s390@lfdr.de>; Tue, 14 Sep 2021 17:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbhINPwW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Sep 2021 11:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234826AbhINPvy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 11:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631634636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jJZEdwvFQ3ljWbLKCYoI62KGMcI1gt7/agR2sAPSxa0=;
        b=XRtPb7vWBFqmWqr0JaSO+N7EC7b524wqv47V4WczEDyw9EePkg1o/a/Bqu4CSBHXRcRybc
        jVIQZYWg/RzCBJaosvKdSz8Q6c/XI8xRnezXEg8cSwTH9QZzx6SzcxuTeAHwBp1/Cuk3PQ
        lpUnfJIu4jd/TiuxheWVXwJcaB0dsn4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-GmG0s0aDNHqI4HgOwagdZQ-1; Tue, 14 Sep 2021 11:50:35 -0400
X-MC-Unique: GmG0s0aDNHqI4HgOwagdZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3DFCC623;
        Tue, 14 Sep 2021 15:50:31 +0000 (UTC)
Received: from localhost (unknown [10.39.193.211])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 28282100AE35;
        Tue, 14 Sep 2021 15:50:27 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/9] vfio/ccw: Use functions for alloc/free of the
 vfio_ccw_private
In-Reply-To: <YTtBDbVsRveVE3i9@infradead.org>
Organization: Red Hat GmbH
References: <0-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
 <1-v2-7d3a384024cf+2060-ccw_mdev_jgg@nvidia.com>
 <YTtBDbVsRveVE3i9@infradead.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 14 Sep 2021 17:50:25 +0200
Message-ID: <87sfy7gnr2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 10 2021, Christoph Hellwig <hch@infradead.org> wrote:

> On Thu, Sep 09, 2021 at 04:38:41PM -0300, Jason Gunthorpe wrote:
>> +
>> +	private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
>> +	if (!private)
>> +		return ERR_PTR(-ENOMEM);
>
> Nit: there is no need to add GFP_KERNEL when using GFP_DMA.
>
> Also a question to the s390 maintainers: why do we need 31-bit
> addressability for the main private data structure?

I don't think we need it anymore since c98e16b2fa12 ("s390/cio: Convert
ccw_io_region to pointer") and probably should just drop the GFP_DMA.

