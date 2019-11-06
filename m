Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD4A0F1EAE
	for <lists+linux-s390@lfdr.de>; Wed,  6 Nov 2019 20:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfKFTZj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 Nov 2019 14:25:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28679 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfKFTZi (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 Nov 2019 14:25:38 -0500
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3DE2833025F
        for <linux-s390@vger.kernel.org>; Wed,  6 Nov 2019 19:25:38 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id c77so17107525qkb.8
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 11:25:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=J/Zt/NfiTx+Ld2uAQJIUZCZlEBcXHtsRtDQxesGEOxE=;
        b=Scx4m5gjELhqBbeDAjQiAOMGnyRDsfFJEY05p4EMA60uMus/L0SMoNGbcduVjez9Yx
         fYn2hvQewjTVg7+KT57Ukn8E36qpV9PnPErgwVgKdiK+eS5Gxhn+TEVSzZ3OcM4+I6T/
         P//QKhoGO442gQIlDj4zRL76ux6NgehHkdKMYt8vgnl+qckUveaAY27U+4c0CjxOpDC8
         ez66KdlbwHqV6MTv7GKAGdTVprwkn9X+pfMmeVRHPt9PqQu5A7yiDh8PJpqgKMXa+beA
         7FI/20l8E1LFidxvsz8l+ACdUGZwTlQv1xUmvUpCmk8Tcaof/PNXv6qzE5T9CVFkh09u
         0yow==
X-Gm-Message-State: APjAAAWzFI1bn6yUKl38osb55sBaBcZ7yD/KAkcfHw5KUsrZVkj8LKiV
        T3THRCQro3/htF6wDs1lXZsNB+3k7lvvPAwNU9FWpH3hRCwitfw6rXq9TXDdUVImOcBI9o7OLkT
        f6Sbs5lso3ZILLrvwjFQCRw==
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr3561000qkm.393.1573068337469;
        Wed, 06 Nov 2019 11:25:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVUeLBA9o5ynyS/oZRBUg3gqW1DOYZfoi4p5JLJ/1OKZhj6MjBGfohoGDCJio3vEXQLJQBsQ==
X-Received: by 2002:a05:620a:226:: with SMTP id u6mr3560981qkm.393.1573068337135;
        Wed, 06 Nov 2019 11:25:37 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id f39sm13094663qtb.26.2019.11.06.11.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:25:35 -0800 (PST)
Date:   Wed, 6 Nov 2019 14:25:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        tiwei.bie@intel.com, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, cohuck@redhat.com,
        maxime.coquelin@redhat.com, cunming.liang@intel.com,
        zhihong.wang@intel.com, rob.miller@broadcom.com,
        xiao.w.wang@intel.com, haotian.wang@sifive.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        farman@linux.ibm.com, pasic@linux.ibm.com, sebott@linux.ibm.com,
        oberpar@linux.ibm.com, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V8 0/6] mdev based hardware virtio offloading support
Message-ID: <20191106142449-mutt-send-email-mst@kernel.org>
References: <20191105093240.5135-1-jasowang@redhat.com>
 <20191105105834.469675f0@x1.home>
 <393f2dc9-8c67-d3c9-6553-640b80c15aaf@redhat.com>
 <20191106120312.77a6a318@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191106120312.77a6a318@x1.home>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 06, 2019 at 12:03:12PM -0700, Alex Williamson wrote:
> On Wed, 6 Nov 2019 11:56:46 +0800
> Jason Wang <jasowang@redhat.com> wrote:
> 
> > On 2019/11/6 上午1:58, Alex Williamson wrote:
> > > On Tue,  5 Nov 2019 17:32:34 +0800
> > > Jason Wang <jasowang@redhat.com> wrote:
> > >  
> > >> Hi all:
> > >>
> > >> There are hardwares that can do virtio datapath offloading while
> > >> having its own control path. This path tries to implement a mdev based
> > >> unified API to support using kernel virtio driver to drive those
> > >> devices. This is done by introducing a new mdev transport for virtio
> > >> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> > >> it provides a unified way for kernel virtio driver to talk with mdev
> > >> device implementation.
> > >>
> > >> Though the series only contains kernel driver support, the goal is to
> > >> make the transport generic enough to support userspace drivers. This
> > >> means vhost-mdev[1] could be built on top as well by resuing the
> > >> transport.
> > >>
> > >> A sample driver is also implemented which simulate a virito-net
> > >> loopback ethernet device on top of vringh + workqueue. This could be
> > >> used as a reference implementation for real hardware driver.
> > >>
> > >> Also a real ICF VF driver was also posted here[2] which is a good
> > >> reference for vendors who is interested in their own virtio datapath
> > >> offloading product.
> > >>
> > >> Consider mdev framework only support VFIO device and driver right now,
> > >> this series also extend it to support other types. This is done
> > >> through introducing class id to the device and pairing it with
> > >> id_talbe claimed by the driver. On top, this seris also decouple
> > >> device specific parents ops out of the common ones.
> > >>
> > >> Pktgen test was done with virito-net + mvnet loop back device.
> > >>
> > >> Please review.
> > >>
> > >> [1] https://lkml.org/lkml/2019/10/31/440
> > >> [2] https://lkml.org/lkml/2019/10/15/1226
> > >>
> > >> Changes from V7:
> > >> - drop {set|get}_mdev_features for virtio
> > >> - typo and comment style fixes  
> > >
> > > Seems we're nearly there, all the remaining comments are relatively
> > > superficial, though I would appreciate a v9 addressing them as well as
> > > the checkpatch warnings:
> > >
> > > https://patchwork.freedesktop.org/series/68977/  
> > 
> > 
> > Will do.
> > 
> > Btw, do you plan to merge vhost-mdev patch on top? Or you prefer it to 
> > go through Michael's vhost tree?
> 
> I can include it if you wish.  The mdev changes are isolated enough in
> that patch that I wouldn't presume it, but clearly it would require
> less merge coordination to drop it in my tree.  Let me know.  Thanks,
> 
> Alex

I'm fine with merging through your tree. If you do, feel free to
include

Acked-by: Michael S. Tsirkin <mst@redhat.com>


-- 
MST
