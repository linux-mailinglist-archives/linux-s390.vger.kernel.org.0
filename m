Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3F6169EB8
	for <lists+linux-s390@lfdr.de>; Mon, 24 Feb 2020 07:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgBXGpZ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Feb 2020 01:45:25 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51630 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgBXGpZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 Feb 2020 01:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582526723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+i0fK/6YGm7npQKME+PbIroFMY6L7ykjROnHSkLZS8=;
        b=DzrAITE4rrOEzS3SJQWlH+LDA19uHGnY12kdPrnPzKzeDjGiOW/uVkWYYYHU02swaU4DOk
        DLreMxYBtfRPqUN4qv0yesxQETFtjhNkqimiyypKYH6bhE3nq5fxPEL+rZGHhNN5Z8P6Yz
        LL4Xm2Vjz7DFR5AvXXGOT5qAD2Hi0Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-fc4PveIwPYCPthI0So09Pg-1; Mon, 24 Feb 2020 01:45:21 -0500
X-MC-Unique: fc4PveIwPYCPthI0So09Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87D2D107ACC4;
        Mon, 24 Feb 2020 06:45:18 +0000 (UTC)
Received: from [10.72.13.147] (ovpn-13-147.pek2.redhat.com [10.72.13.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333AA8AC41;
        Mon, 24 Feb 2020 06:45:04 +0000 (UTC)
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <426e6972-0565-c931-e171-da0f58fbf856@redhat.com>
 <20200221155602.4de41fa7.pasic@linux.ibm.com>
 <0181712c-e533-fcfd-2638-8a0649d713dd@redhat.com>
 <20200224010607-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
Date:   Mon, 24 Feb 2020 14:45:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224010607-mutt-send-email-mst@kernel.org>
Content-Type: multipart/mixed;
 boundary="------------BCF6A0F752A8D2F33C415C99"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is a multi-part message in MIME format.
--------------BCF6A0F752A8D2F33C415C99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 2020/2/24 =E4=B8=8B=E5=8D=882:06, Michael S. Tsirkin wrote:
> On Mon, Feb 24, 2020 at 12:01:57PM +0800, Jason Wang wrote:
>> On 2020/2/21 =E4=B8=8B=E5=8D=8810:56, Halil Pasic wrote:
>>> On Fri, 21 Feb 2020 14:22:26 +0800
>>> Jason Wang <jasowang@redhat.com> wrote:
>>>
>>>> On 2020/2/21 =E4=B8=8A=E5=8D=8812:06, Halil Pasic wrote:
>>>>> Currently if one intends to run a memory protection enabled VM with
>>>>> virtio devices and linux as the guest OS, one needs to specify the
>>>>> VIRTIO_F_IOMMU_PLATFORM flag for each virtio device to make the gue=
st
>>>>> linux use the DMA API, which in turn handles the memory
>>>>> encryption/protection stuff if the guest decides to turn itself int=
o
>>>>> a protected one. This however makes no sense due to multiple reason=
s:
>>>>> * The device is not changed by the fact that the guest RAM is
>>>>> protected. The so called IOMMU bypass quirk is not affected.
>>>>> * This usage is not congruent with  standardised semantics of
>>>>> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal re=
ason
>>>>> for using DMA API in virtio (orthogonal with respect to what is
>>>>> expressed by VIRTIO_F_IOMMU_PLATFORM).
>>>>>
>>>>> This series aims to decouple 'have to use DMA API because my (guest=
) RAM
>>>>> is protected' and 'have to use DMA API because the device told me
>>>>> VIRTIO_F_IOMMU_PLATFORM'.
>>>>>
>>>>> Please find more detailed explanations about the conceptual aspects=
 in
>>>>> the individual patches. There is however also a very practical prob=
lem
>>>>> that is addressed by this series.
>>>>>
>>>>> For vhost-net the feature VIRTIO_F_IOMMU_PLATFORM has the following=
 side
>>>>> effect The vhost code assumes it the addresses on the virtio descri=
ptor
>>>>> ring are not guest physical addresses but iova's, and insists on do=
ing a
>>>>> translation of these regardless of what transport is used (e.g. whe=
ther
>>>>> we emulate a PCI or a CCW device). (For details see commit 6b1e6cc7=
855b
>>>>> "vhost: new device IOTLB API".) On s390 this results in severe
>>>>> performance degradation (c.a. factor 10).
>>>> Do you see a consistent degradation on the performance, or it only
>>>> happen when for during the beginning of the test?
>>>>
>>> AFAIK the degradation is consistent.
>>>
>>>>> BTW with ccw I/O there is
>>>>> (architecturally) no IOMMU, so the whole address translation makes =
no
>>>>> sense in the context of virtio-ccw.
>>>> I suspect we can do optimization in qemu side.
>>>>
>>>> E.g send memtable entry via IOTLB API when vIOMMU is not enabled.
>>>>
>>>> If this makes sense, I can draft patch to see if there's any differe=
nce.
>>> Frankly I would prefer to avoid IOVAs on the descriptor ring (and the
>>> then necessary translation) for virtio-ccw altogether. But Michael
>>> voiced his opinion that we should mandate F_IOMMU_PLATFORM for device=
s
>>> that could be used with guests running in protected mode. I don't sha=
re
>>> his opinion, but that's an ongoing discussion.
>>>
>>> Should we end up having to do translation from IOVA in vhost, we are
>>> very interested in that translation being fast and efficient.
>>>
>>> In that sense we would be very happy to test any optimization that ai=
m
>>> into that direction.
>>>
>>> Thank you very much for your input!
>>
>> Using IOTLB API on platform without IOMMU support is not intended. Ple=
ase
>> try the attached patch to see if it helps.
>>
>> Thanks
>>
>>
>>> Regards,
>>> Halil
>>>
>>>> Thanks
>>>>
>>>>
>>>>> Halil Pasic (2):
>>>>>      mm: move force_dma_unencrypted() to mem_encrypt.h
>>>>>      virtio: let virtio use DMA API when guest RAM is protected
>>>>>
>>>>>     drivers/virtio/virtio_ring.c |  3 +++
>>>>>     include/linux/dma-direct.h   |  9 ---------
>>>>>     include/linux/mem_encrypt.h  | 10 ++++++++++
>>>>>     3 files changed, 13 insertions(+), 9 deletions(-)
>>>>>
>>>>>
>>>>> base-commit: ca7e1fd1026c5af6a533b4b5447e1d2f153e28f2
>> >From 66fa730460875ac99e81d7db2334cd16bb1d2b27 Mon Sep 17 00:00:00 200=
1
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Mon, 24 Feb 2020 12:00:10 +0800
>> Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly
>>
>> When transport does not support IOMMU, we should clear IOMMU_PLATFORM
>> even if the device and vhost claims to support that. This help to
>> avoid the performance overhead caused by unnecessary IOTLB miss/update
>> transactions on such platform.
>>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>   hw/virtio/virtio-bus.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
>> index d6332d45c3..2741b9fdd2 100644
>> --- a/hw/virtio/virtio-bus.c
>> +++ b/hw/virtio/virtio-bus.c
>> @@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, E=
rror **errp)
>>       VirtioBusState *bus =3D VIRTIO_BUS(qbus);
>>       VirtioBusClass *klass =3D VIRTIO_BUS_GET_CLASS(bus);
>>       VirtioDeviceClass *vdc =3D VIRTIO_DEVICE_GET_CLASS(vdev);
>> -    bool has_iommu =3D virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_P=
LATFORM);
>>       Error *local_err =3D NULL;
>>  =20
>>       DPRINTF("%s: plug device.\n", qbus->name);
>> @@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev,=
 Error **errp)
>>           return;
>>       }
>>  =20
>> -    if (klass->get_dma_as !=3D NULL && has_iommu) {
>> -        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATF=
ORM);
>> +    if (false && klass->get_dma_as !=3D NULL &&
>> +        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
>>           vdev->dma_as =3D klass->get_dma_as(qbus->parent);
>>       } else {
>> +        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLA=
TFORM);
>>           vdev->dma_as =3D &address_space_memory;
>>       }
>>   }
>
> This seems to clear it unconditionally. I guess it's just a debugging
> patch, the real one will come later?


My bad, here's the correct one.

Thanks


>
>> --=20
>> 2.19.1
>>

--------------BCF6A0F752A8D2F33C415C99
Content-Type: text/x-patch;
 name="0001-virtio-turn-on-IOMMU_PLATFORM-properly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-virtio-turn-on-IOMMU_PLATFORM-properly.patch"

From b8a8b582f46bb86c7a745b272db7b744779e5cc7 Mon Sep 17 00:00:00 2001
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 24 Feb 2020 12:00:10 +0800
Subject: [PATCH] virtio: turn on IOMMU_PLATFORM properly

When transport does not support IOMMU, we should clear IOMMU_PLATFORM
even if the device and vhost claims to support that. This help to
avoid the performance overhead caused by unnecessary IOTLB miss/update
transactions on such platform.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/virtio-bus.c b/hw/virtio/virtio-bus.c
index d6332d45c3..4be64e193e 100644
--- a/hw/virtio/virtio-bus.c
+++ b/hw/virtio/virtio-bus.c
@@ -47,7 +47,6 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
     VirtioBusState *bus = VIRTIO_BUS(qbus);
     VirtioBusClass *klass = VIRTIO_BUS_GET_CLASS(bus);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_GET_CLASS(vdev);
-    bool has_iommu = virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM);
     Error *local_err = NULL;
 
     DPRINTF("%s: plug device.\n", qbus->name);
@@ -77,10 +76,11 @@ void virtio_bus_device_plugged(VirtIODevice *vdev, Error **errp)
         return;
     }
 
-    if (klass->get_dma_as != NULL && has_iommu) {
-        virtio_add_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
+    if (klass->get_dma_as != NULL &&
+        virtio_host_has_feature(vdev, VIRTIO_F_IOMMU_PLATFORM)) {
         vdev->dma_as = klass->get_dma_as(qbus->parent);
     } else {
+        virtio_clear_feature(&vdev->host_features, VIRTIO_F_IOMMU_PLATFORM);
         vdev->dma_as = &address_space_memory;
     }
 }
-- 
2.19.1


--------------BCF6A0F752A8D2F33C415C99--

