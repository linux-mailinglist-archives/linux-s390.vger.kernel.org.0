Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E474F2EDC
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2019 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbfKGNId (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 Nov 2019 08:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36708 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbfKGNIc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 08:08:32 -0500
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF46DC04BE1B
        for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2019 13:08:31 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id x186so2190340qke.13
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 05:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tXcdjIfv7WULf2HezusDMoDHkz/54up9J9zs1V5mjUk=;
        b=kmh/VP8PUrJAeHd7FUWXr1NhaAV9zh0LCVSr6RzP/9J//TvilHbuHOCE8xp2q3t2LX
         +zKm+TejUjPR18iJ5T9+2+sR7AB1+AnrA6SO+GSW7nYbtR/GcfQ1AlXDi4zq3IE5AdXJ
         YesJcfhmO/UfNu2IvaRy1k/Omx8r4lBv5HkgEpMpOAeg3PBE9vUYKtV3pDSPWy3QU3jX
         ekZ2PXa9m/hNZ0VJbZKrbRvRxpid1+/yXuhY2CFZWMaYZaxt2/dmIG5aeHBNkSOlt8AE
         oAIZBj32kldABkMOzscwGL1JVDECQrGeg2phviEGvsCLPQ/cG3engfpcQgUPptolStQk
         eNwA==
X-Gm-Message-State: APjAAAXaU6e+8in+6/ysfKFos0pf8P7p0AG8RzuB8vaqN4y10KSStObq
        p3GRmrY+CuzOVKckwgUKRFmTOjqxIrGsUiz8OktDOvDTBvV9y0uDiU049aehz7TqxctKxC5DhPJ
        7Fb0sSxBc65oDy+jYl8Osyw==
X-Received: by 2002:a0c:e947:: with SMTP id n7mr3315674qvo.103.1573132111121;
        Thu, 07 Nov 2019 05:08:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzprSHQlujR1MF9UHe+PqRrS5UswVR63DxA+6BEPw7ceXTuOVmM5LOubh+MnCt3hahFb/kSQ==
X-Received: by 2002:a0c:e947:: with SMTP id n7mr3315638qvo.103.1573132110806;
        Thu, 07 Nov 2019 05:08:30 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id 11sm1387231qtx.45.2019.11.07.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:08:29 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:08:17 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        cohuck@redhat.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, eperezma@redhat.com,
        lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191107080721-mutt-send-email-mst@kernel.org>
References: <20191106133531.693-1-jasowang@redhat.com>
 <20191106133531.693-7-jasowang@redhat.com>
 <20191107040700-mutt-send-email-mst@kernel.org>
 <bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
 <20191107061942-mutt-send-email-mst@kernel.org>
 <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
 <c588c724-04da-2991-9f88-f36c0d04364a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c588c724-04da-2991-9f88-f36c0d04364a@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 07, 2019 at 08:47:06PM +0800, Jason Wang wrote:
> 
> On 2019/11/7 下午8:43, Jason Wang wrote:
> > 
> > On 2019/11/7 下午7:21, Michael S. Tsirkin wrote:
> > > On Thu, Nov 07, 2019 at 06:18:45PM +0800, Jason Wang wrote:
> > > > On 2019/11/7 下午5:08, Michael S. Tsirkin wrote:
> > > > > On Wed, Nov 06, 2019 at 09:35:31PM +0800, Jason Wang wrote:
> > > > > > This sample driver creates mdev device that simulate
> > > > > > virtio net device
> > > > > > over virtio mdev transport. The device is implemented through vringh
> > > > > > and workqueue. A device specific dma ops is to make sure HVA is used
> > > > > > directly as the IOVA. This should be sufficient for kernel virtio
> > > > > > driver to work.
> > > > > > 
> > > > > > Only 'virtio' type is supported right now. I plan to add 'vhost' type
> > > > > > on top which requires some virtual IOMMU implemented in this sample
> > > > > > driver.
> > > > > > 
> > > > > > Acked-by: Cornelia Huck<cohuck@redhat.com>
> > > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > > I'd prefer it that we call this something else, e.g.
> > > > > mvnet-loopback. Just so people don't expect a fully
> > > > > functional device somehow. Can be renamed when applying?
> > > > Actually, I plan to extend it as another standard network interface for
> > > > kernel. It could be either a standalone pseudo device or a stack
> > > > device.
> > > > Does this sounds good to you?
> > > > 
> > > > Thanks
> > > That's a big change in an interface so it's a good reason
> > > to rename the driver at that point right?
> > > Oherwise users of an old kernel would expect a stacked driver
> > > and get a loopback instead.
> > > 
> > > Or did I miss something?
> > 
> > 
> > My understanding is that it was a sample driver in /doc. It should not
> > be used in production environment. Otherwise we need to move it to
> > driver/virtio.
> > 
> > But if you insist, I can post a V11.
> > 
> > Thanks
> 
> 
> Or maybe it's better to rename the type of current mdev from 'virtio' to
> 'virtio-loopback'. Then we can add more types in the future.
> 
> Thanks
> 

Maybe but is virtio actually a loopback somehow? I thought we
can bind a regular virtio device there, no?

-- 
MST
