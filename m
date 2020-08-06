Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38EA623DFCD
	for <lists+linux-s390@lfdr.de>; Thu,  6 Aug 2020 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgHFRx4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 6 Aug 2020 13:53:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47112 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728226AbgHFQaz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Aug 2020 12:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596731414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S8ASlZG4PjPJBhAfnFIIFM3UUn4KVlmkZfG7k5GeMeY=;
        b=iBL6rNKfUkouWKnsdDt9Uc5Gs/knd924a3U2DKmp4VT7w9wHqDBZZjuI8/xoZqwxy40Psf
        a15JyDAZtIngxircSTcvLEaeg19MJDucBDLIjofSCtM1N+mSZJk3cz+wfqTBWwCovGGj/J
        YNabpnd9nJnk2o+KzgaZN+lLR5cJFIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-1Bx-Afw6NCqOOHK1jEdsug-1; Thu, 06 Aug 2020 11:47:53 -0400
X-MC-Unique: 1Bx-Afw6NCqOOHK1jEdsug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41A2F1800D42;
        Thu,  6 Aug 2020 15:47:52 +0000 (UTC)
Received: from gondolin (ovpn-113-2.ams2.redhat.com [10.36.113.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4497D65C82;
        Thu,  6 Aug 2020 15:47:47 +0000 (UTC)
Date:   Thu, 6 Aug 2020 17:47:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, pasic@linux.ibm.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com,
        jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1 0/1] s390: virtio-ccw: PV needs VIRTIO I/O device
 protection
Message-ID: <20200806174744.595b9c8c.cohuck@redhat.com>
In-Reply-To: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
References: <1596723782-12798-1-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  6 Aug 2020 16:23:01 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi all,
> 
> In another series I proposed to add an architecture specific
> callback to fail feature negociation on architecture need.
> 
> In VIRTIO, we already have an entry to reject the features on the
> transport basis.
> 
> Transport is not architecture so I send a separate series in which
> we fail the feature negociation inside virtio_ccw_finalize_features,
> the virtio_config_ops.finalize_features for S390 CCW transport,
> when the device do not propose the VIRTIO_F_IOMMU_PLATFORM.
> 
> This solves the problem of crashing QEMU when this one is not using
> a CCW device with iommu_platform=on in S390.

This does work, and I'm tempted to queue this patch, but I'm wondering
whether we need to give up on a cross-architecture solution already
(especially keeping in mind that ccw is the only transport that is
really architecture-specific).

I know that we've gone through a few rounds already, and I'm not sure
whether we've been there already, but:

Could virtio_finalize_features() call an optional
arch_has_restricted_memory_access() function and do the enforcing of
IOMMU_PLATFORM? That would catch all transports, and things should work
once an architecture opts in. That direction also shouldn't be a
problem if virtio is a module.

> 
> Regards,
> Pierre
> 
> Regards,
> Pierre
> 
> Pierre Morel (1):
>   s390: virtio-ccw: PV needs VIRTIO I/O device protection
> 
>  drivers/s390/virtio/virtio_ccw.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 

