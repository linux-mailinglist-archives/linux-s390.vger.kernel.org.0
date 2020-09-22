Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B87274388
	for <lists+linux-s390@lfdr.de>; Tue, 22 Sep 2020 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgIVNwW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 22 Sep 2020 09:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbgIVNwW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Sep 2020 09:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600782740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UfJX+wYYmH/wK4kLLTxGKgaWCNaGjgdbMHRevMH7+TA=;
        b=E0lN7WbJfWER8Ts2/AiHVK37G8fx8HJSXZ49leCuEpw/zeI/wM25cQiqJlRoKGAnTmf6C2
        nmvHK9MZVHSbZ+cTcpCb9FnM/sLCH0UL37koxns7sr5zbz3dz/s2KVgLvOp6ZOA8zdf2Mk
        SuScuRNMiP4/pIPELZkYsat+UcBEWFI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-7xoGXXwyMciZ02QKhL5t9A-1; Tue, 22 Sep 2020 09:52:19 -0400
X-MC-Unique: 7xoGXXwyMciZ02QKhL5t9A-1
Received: by mail-wr1-f72.google.com with SMTP id l17so7389437wrw.11
        for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2020 06:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UfJX+wYYmH/wK4kLLTxGKgaWCNaGjgdbMHRevMH7+TA=;
        b=VViip1fpXqzS6lQDtD8AdhH46uizbaTYwTYZuXrQ2N8fZ5C3v35ruwvtDxL68n5n5n
         Q3lk841fAaokWW4bO/djMnPsldwTnVfppGJeJVAHXVajluEVp0PNJX0SFL65x4qRL4M2
         e3Z7rbCq/h6VWmDJc1Qy0cOJUqKU+WxpvCbHYzx71EHVP02Y2Ge119I8rpMK0KXb+RMq
         Yy4xfPXJsGZc7MrvDwEwY6EqbNipTjC3ixOxzXWV0etdgCF3Xu/4ifbyN+ZWyk0vidwU
         t0QUZVURfRZjZInq1p6wD4IPy8Qs50XjblHmt5Fj2Ranyh+Z7vS08XgUdp0zc5xX/B0t
         52cw==
X-Gm-Message-State: AOAM530YRlC6AkTTtk98YsXihMN/XDd8rGJMhwbajIf3EsU9JL70qP+/
        K8b04IeTP+eTyE5plU6qyJnGfQULrfzQ0F5tb8jXdcQNiYESUHfuRaS9kJgovz4NrZ6xdUS+I/2
        xVR+LOswxPeN4atSG7SO5HA==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr1187575wme.148.1600782737964;
        Tue, 22 Sep 2020 06:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA4/2LFfWxU8NUoke6X3tzAXQxbMT++c6m4LRcHMg/WZ6CRi0/J2NuZBapW4USmj+BNJiNDQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr1187547wme.148.1600782737763;
        Tue, 22 Sep 2020 06:52:17 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net. [109.65.116.225])
        by smtp.gmail.com with ESMTPSA id y1sm4650054wmi.36.2020.09.22.06.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 06:52:16 -0700 (PDT)
Date:   Tue, 22 Sep 2020 09:52:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Pierre Morel <pmorel@linux.ibm.com>, linux-kernel@vger.kernel.org,
        pasic@linux.ibm.com, frankja@linux.ibm.com, jasowang@redhat.com,
        cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200922095158-mutt-send-email-mst@kernel.org>
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
 <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Will do for the next Linux.

On Tue, Sep 22, 2020 at 02:15:17PM +0200, Christian Borntraeger wrote:
> Michael,
> 
> are you going to pick this series?
> 
> 
> On 10.09.20 10:53, Pierre Morel wrote:
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> > 
> > I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
> > I forgot in drivers/virtio/Kconfig, and put back the inclusion
> > of virtio_config.h for the definition of the callback in
> > arch/s390/mm/init.c I wrongly removed in the last series.
> > 
> > Regards,
> > Pierre
> > 
> > 
> > Pierre Morel (2):
> >   virtio: let arch advertise guest's memory access restrictions
> >   s390: virtio: PV needs VIRTIO I/O device protection
> > 
> >  arch/s390/Kconfig             |  1 +
> >  arch/s390/mm/init.c           | 11 +++++++++++
> >  drivers/virtio/Kconfig        |  6 ++++++
> >  drivers/virtio/virtio.c       | 15 +++++++++++++++
> >  include/linux/virtio_config.h | 10 ++++++++++
> >  5 files changed, 43 insertions(+)
> > 

