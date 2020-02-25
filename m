Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF4116B822
	for <lists+linux-s390@lfdr.de>; Tue, 25 Feb 2020 04:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgBYDi4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 24 Feb 2020 22:38:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726962AbgBYDi4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 24 Feb 2020 22:38:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582601934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FxhGFYz6fAwKel+McHgyPZZNImtqGnzaPwux7zsd3N0=;
        b=XxoYKCEoC+5UvrsdzSDj5dlaY9CQe+Urx96zy50d72pYFfgMgZhf7T0+/pIhoOA71ngSZn
        GUBvL//IU3TVWtpNOgo7Hm8DpVNEj3s8K8eQZzhHnL74yXIHRCtgx0K+YuaeCkISiwPDk/
        o8Cc18A15t6dKyu0H1zJtVZY6nz8xxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-r7S_sd4lOT-zPkHlkyjcCg-1; Mon, 24 Feb 2020 22:38:50 -0500
X-MC-Unique: r7S_sd4lOT-zPkHlkyjcCg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F27813E4;
        Tue, 25 Feb 2020 03:38:48 +0000 (UTC)
Received: from [10.72.13.170] (ovpn-13-170.pek2.redhat.com [10.72.13.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64A1B60BF7;
        Tue, 25 Feb 2020 03:38:36 +0000 (UTC)
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
 <b3c52c67-c740-a50e-2595-fe04d179c881@redhat.com>
 <20200224024641-mutt-send-email-mst@kernel.org>
 <08d6bdfb-9b49-c278-3c0b-2e02376cf0cf@redhat.com>
 <20200224083845-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <ac15de73-8c61-5e82-4ed2-760b7f3055bb@redhat.com>
Date:   Tue, 25 Feb 2020 11:38:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200224083845-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 2020/2/24 =E4=B8=8B=E5=8D=889:40, Michael S. Tsirkin wrote:
>> Subject: [PATCH] vhost: do not set VIRTIO_F_IOMMU_PLATFORM when IOMMU =
is not
>>   used
>>
>> We enable device IOTLB unconditionally when VIRTIO_F_IOMMU_PLATFORM is
>> negotiated. This lead unnecessary IOTLB miss/update transactions when
>> IOMMU is used. This patch fixes this.
>>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
>> ---
>>   hw/net/virtio-net.c | 3 +++
>>   hw/virtio/vhost.c   | 4 +---
>>   2 files changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index 3627bb1717..0d50e8bd34 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -879,6 +879,9 @@ static void virtio_net_set_features(VirtIODevice *=
vdev, uint64_t features)
>>           virtio_net_apply_guest_offloads(n);
>>       }
>>  =20
>> +    if (vdev->dma_as =3D=3D &address_space_memory)
>> +        features &=3D ~(1ULL << VIRTIO_F_IOMMU_PLATFORM);
>> +
>>       for (i =3D 0;  i < n->max_queues; i++) {
>>           NetClientState *nc =3D qemu_get_subqueue(n->nic, i);
> This pokes at acked features. I think they are also
> guest visible ...


It's the acked features of vhost device, so I guess not?

E.g virtio_set_features_nocheck() did:

 =C2=A0=C2=A0=C2=A0 val &=3D vdev->host_features;
 =C2=A0=C2=A0=C2=A0 if (k->set_features) {
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 k->set_features(vdev, val);
 =C2=A0=C2=A0=C2=A0 }
 =C2=A0=C2=A0=C2=A0 vdev->guest_features =3D val;

Thanks

>

