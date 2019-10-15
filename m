Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021FAD6DE0
	for <lists+linux-s390@lfdr.de>; Tue, 15 Oct 2019 05:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfJODhq (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Oct 2019 23:37:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727472AbfJODhq (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 23:37:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F94118CB8F9;
        Tue, 15 Oct 2019 03:37:45 +0000 (UTC)
Received: from [10.72.12.168] (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F112C5C1D4;
        Tue, 15 Oct 2019 03:37:19 +0000 (UTC)
Subject: Re: [PATCH V3 0/7] mdev based hardware virtio offloading support
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, mst@redhat.com, tiwei.bie@intel.com,
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
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com
References: <20191011081557.28302-1-jasowang@redhat.com>
 <20191014174946.GC5359@stefanha-x1.localdomain>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6d12ad8f-8137-e07d-d735-da59a326e8ed@redhat.com>
Date:   Tue, 15 Oct 2019 11:37:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014174946.GC5359@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.63]); Tue, 15 Oct 2019 03:37:45 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2019/10/15 上午1:49, Stefan Hajnoczi wrote:
> On Fri, Oct 11, 2019 at 04:15:50PM +0800, Jason Wang wrote:
>> There are hardware that can do virtio datapath offloading while having
>> its own control path. This path tries to implement a mdev based
>> unified API to support using kernel virtio driver to drive those
>> devices. This is done by introducing a new mdev transport for virtio
>> (virtio_mdev) and register itself as a new kind of mdev driver. Then
>> it provides a unified way for kernel virtio driver to talk with mdev
>> device implementation.
>>
>> Though the series only contains kernel driver support, the goal is to
>> make the transport generic enough to support userspace drivers. This
>> means vhost-mdev[1] could be built on top as well by resuing the
>> transport.
>>
>> A sample driver is also implemented which simulate a virito-net
>> loopback ethernet device on top of vringh + workqueue. This could be
>> used as a reference implementation for real hardware driver.
>>
>> Consider mdev framework only support VFIO device and driver right now,
>> this series also extend it to support other types. This is done
>> through introducing class id to the device and pairing it with
>> id_talbe claimed by the driver. On top, this seris also decouple
>> device specific parents ops out of the common ones.
> I was curious so I took a quick look and posted comments.
>
> I guess this driver runs inside the guest since it registers virtio
> devices?


It could run in either guest or host. But the main focus is to run in 
the host then we can use virtio drivers in containers.


>
> If this is used with physical PCI devices that support datapath
> offloading then how are physical devices presented to the guest without
> SR-IOV?


We will do control path meditation through vhost-mdev[1] and 
vhost-vfio[2]. Then we will present a full virtio compatible ethernet 
device for guest.

SR-IOV is not a must, any mdev device that implements the API defined in 
patch 5 can be used by this framework.

Thanks

[1] https://lkml.org/lkml/2019/9/26/15

[2] https://patchwork.ozlabs.org/cover/984763/


>
> Stefan
