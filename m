Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEBC1344B
	for <lists+linux-s390@lfdr.de>; Fri,  3 May 2019 22:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfECUEw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 May 2019 16:04:52 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40779 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfECUEw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 May 2019 16:04:52 -0400
Received: by mail-qt1-f196.google.com with SMTP id k24so4371489qtq.7
        for <linux-s390@vger.kernel.org>; Fri, 03 May 2019 13:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9X9Yn//uNc4nUt79TMtyqufL6vACayUvlMnGmpMumpM=;
        b=NVD9ntURWNJBpfmM4d4+mp1IiHt05+WV/LjSB2Q/S6ejSLW+QJbZJSm9sP28Y25p31
         2vn0IzEhaNNjvf3XUAt4/eYCIw1AKDyLw85DxfcD0N6ya+w36B3jCAn4WupyQb49x7ye
         aOk9U+N6BxVPBSBAxD8hdbJN6zrfUobVVmLFqtjvHkDnAdazxxrjsSkSQQQaTVkeA+cK
         YU7Z9LSH3KTN4pQ8pidqlQj+9kAWwW1E8rkfOTp8bK5tBdAZ5OI5HfquJtZiLFi2gzkW
         CX3owSqXdMesXGaJMebiPOD90An0yaVzsJwsjZMwibrB5mOqWzWr8YZZlq4iFIh5XMpr
         3+aw==
X-Gm-Message-State: APjAAAVJ/fOD58L1jbg+5BrxnOjvzl/sb41WCaVHJJuVfbPkexy30QpB
        JCwwaNtRoE3ydfQ7XZgOutqGmAfHH8Q=
X-Google-Smtp-Source: APXvYqxJqgC9JI6r+i5mLL7IPh0JnKywe0jyA2dWegR16gGx/T8GcVix3ycZOigW7QFKPasTYegZZA==
X-Received: by 2002:a0c:d928:: with SMTP id p37mr9920668qvj.45.1556913891689;
        Fri, 03 May 2019 13:04:51 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net. [173.76.105.71])
        by smtp.gmail.com with ESMTPSA id e131sm1882716qkb.80.2019.05.03.13.04.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 13:04:50 -0700 (PDT)
Date:   Fri, 3 May 2019 16:04:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 01/10] virtio/s390: use vring_create_virtqueue
Message-ID: <20190503160421-mutt-send-email-mst@kernel.org>
References: <20190426183245.37939-1-pasic@linux.ibm.com>
 <20190426183245.37939-2-pasic@linux.ibm.com>
 <20190503111724.70c6ec37.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503111724.70c6ec37.cohuck@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 03, 2019 at 11:17:24AM +0200, Cornelia Huck wrote:
> On Fri, 26 Apr 2019 20:32:36 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > The commit 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> > establishes a new way of allocating virtqueues (as a part of the effort
> > that taught DMA to virtio rings).
> > 
> > In the future we will want virtio-ccw to use the DMA API as well.
> > 
> > Let us switch from the legacy method of allocating virtqueues to
> > vring_create_virtqueue() as the first step into that direction.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c | 30 +++++++++++-------------------
> >  1 file changed, 11 insertions(+), 19 deletions(-)
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 
> I'd vote for merging this patch right away for 5.2.

So which tree is this going through? mine?

-- 
MST
