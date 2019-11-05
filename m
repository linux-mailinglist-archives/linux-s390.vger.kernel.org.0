Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3388BF0494
	for <lists+linux-s390@lfdr.de>; Tue,  5 Nov 2019 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390560AbfKER66 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Nov 2019 12:58:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36790 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388711AbfKER66 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Nov 2019 12:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572976736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6tu1v4G9fE/ChX8bRQ38WG0hz1iaA5qDIbKie9vJH4o=;
        b=OGvjmcl+1limUf2GkEkJwjghjeSB80IqjEl1TXQ+9WbunBhMAjbZipFyjfZF63v0EFNEZu
        /Beadxq3H0y5Q+YpXXUCv/ipfijwm0/bL1qwIBMIlWeRsLum3FeDIcvpGRKvaqkvb9+V5E
        Zk4KOVMEqKDBFV0t2fM0LS0k5Fohx/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-vstKXwaEPzyCzJ10MyBS1A-1; Tue, 05 Nov 2019 12:58:52 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03AE21800D4A;
        Tue,  5 Nov 2019 17:58:46 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 31C85100164D;
        Tue,  5 Nov 2019 17:58:35 +0000 (UTC)
Date:   Tue, 5 Nov 2019 10:58:34 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        mst@redhat.com, tiwei.bie@intel.com,
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
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V8 0/6] mdev based hardware virtio offloading support
Message-ID: <20191105105834.469675f0@x1.home>
In-Reply-To: <20191105093240.5135-1-jasowang@redhat.com>
References: <20191105093240.5135-1-jasowang@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: vstKXwaEPzyCzJ10MyBS1A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue,  5 Nov 2019 17:32:34 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Hi all:
>=20
> There are hardwares that can do virtio datapath offloading while
> having its own control path. This path tries to implement a mdev based
> unified API to support using kernel virtio driver to drive those
> devices. This is done by introducing a new mdev transport for virtio
> (virtio_mdev) and register itself as a new kind of mdev driver. Then
> it provides a unified way for kernel virtio driver to talk with mdev
> device implementation.
>=20
> Though the series only contains kernel driver support, the goal is to
> make the transport generic enough to support userspace drivers. This
> means vhost-mdev[1] could be built on top as well by resuing the
> transport.
>=20
> A sample driver is also implemented which simulate a virito-net
> loopback ethernet device on top of vringh + workqueue. This could be
> used as a reference implementation for real hardware driver.
>=20
> Also a real ICF VF driver was also posted here[2] which is a good
> reference for vendors who is interested in their own virtio datapath
> offloading product.
>=20
> Consider mdev framework only support VFIO device and driver right now,
> this series also extend it to support other types. This is done
> through introducing class id to the device and pairing it with
> id_talbe claimed by the driver. On top, this seris also decouple
> device specific parents ops out of the common ones.
>=20
> Pktgen test was done with virito-net + mvnet loop back device.
>=20
> Please review.
>=20
> [1] https://lkml.org/lkml/2019/10/31/440
> [2] https://lkml.org/lkml/2019/10/15/1226
>=20
> Changes from V7:
> - drop {set|get}_mdev_features for virtio
> - typo and comment style fixes


Seems we're nearly there, all the remaining comments are relatively
superficial, though I would appreciate a v9 addressing them as well as
the checkpatch warnings:

https://patchwork.freedesktop.org/series/68977/

Consider this a last call for reviews or acks (or naks) from affected
mdev vendor drivers, mdev-core sub-maintainers (Hi Kirti), virtio
stakeholders, etc.  Thanks,

Alex

