Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E955167E8C
	for <lists+linux-s390@lfdr.de>; Fri, 21 Feb 2020 14:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBUN15 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 21 Feb 2020 08:27:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbgBUN15 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 21 Feb 2020 08:27:57 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01LDPXWr018832
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:27:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y8uc0th5d-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 21 Feb 2020 08:27:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 21 Feb 2020 13:27:54 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 21 Feb 2020 13:27:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01LDRmrG20971590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Feb 2020 13:27:48 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DE4F5204F;
        Fri, 21 Feb 2020 13:27:48 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.149])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2DB6352052;
        Fri, 21 Feb 2020 13:27:48 +0000 (GMT)
Date:   Fri, 21 Feb 2020 14:27:46 +0100
From:   Halil Pasic <pasic@linux.ibm.com>
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
In-Reply-To: <20200221025915.GB2298@umbus.fritz.box>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
        <20200220160606.53156-3-pasic@linux.ibm.com>
        <20200220161309.GB12709@lst.de>
        <20200221025915.GB2298@umbus.fritz.box>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/6L0zE9scbEzJxcRVxZin/tR"; protocol="application/pgp-signature"
X-TM-AS-GCONF: 00
x-cbid: 20022113-0016-0000-0000-000002E8FC1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022113-0017-0000-0000-0000334C1C9A
Message-Id: <20200221142746.1da0881f.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-21_03:2020-02-19,2020-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002210104
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--Sig_/6L0zE9scbEzJxcRVxZin/tR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2020 13:59:15 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Feb 20, 2020 at 05:13:09PM +0100, Christoph Hellwig wrote:
> > On Thu, Feb 20, 2020 at 05:06:06PM +0100, Halil Pasic wrote:
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 867c7ebd3f10..fafc8f924955 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -243,6 +243,9 @@ static bool vring_use_dma_api(struct virtio_devic=
e *vdev)
> > >  	if (!virtio_has_iommu_quirk(vdev))
> > >  		return true;
> > > =20
> > > +	if (force_dma_unencrypted(&vdev->dev))
> > > +		return true;
> >=20
> > Hell no.  This is a detail of the platform DMA direct implementation.
> > Drivers have no business looking at this flag, and virtio finally needs
> > to be fixed to use the DMA API properly for everything but legacy devic=
es.
>=20
> So, this patch definitely isn't right as it stands, but I'm struggling
> to understand what it is you're saying is the right way.
>=20
> By "legacy devices" I assume you mean pre-virtio-1.0 devices, that
> lack the F_VERSION_1 feature flag.  Is that right?  Because I don't
> see how being a legacy device or not relates to use of the DMA API.
>=20
> I *think* what you are suggesting here is that virtio devices that
> have !F_IOMMU_PLATFORM should have their dma_ops set up so that the
> DMA API treats IOVA=3D=3DPA, which will satisfy what the device expects.
> Then the virtio driver can use the DMA API the same way for both
> F_IOMMU_PLATFORM and !F_IOMMU_PLATFORM devices.

I've considered this idea, and as a matter a fact would be my preferred
solution. It would be, if we could use GFP_DMA when allocating coherent
memory through the DMA API. For CCW devices we *must* have some of the
device accessible memory 31 bit addressable (in physical address space),
because the s390 architecture *mandates it*. I had patches
(https://lkml.org/lkml/2019/9/23/313) that do that but Christoph was not
open to the idea.

Always pushing all the stuff allocated by virtio devices into the DMA
zone is not a good option for us. We did that for protected guests,
because that was what Christoph was willing to accept, but not happy
with it.

I'm willing to go down that rute, but I really need the capability to
tell the DMA API 'do this allocation from ZONE_DMA'. I don't care how.


>=20
> But if that works for !F_IOMMU_PLATFORM_DEVICES+F_VERSION_1 devices,
> then AFAICT it will work equally well for legacy devices.

I agree.

>=20
> Using the DMA API for *everything* in virtio, legacy or not, seems
> like a reasonable approach to me.  But, AFAICT, that does require the
> DMA layer to have some kind of explicit call to turn on this
> behaviour, which the virtio driver would call during initializsation.
> I don't think we can do it 100% within the DMA layer, because only the
> driver can reasonably know when a device has this weird non-standard
> DMA behaviour.
>=20

IMHO one could make the DMA API work with different DMA ops. The
virtio transport or the virtio core can probably intervene. But then, we
(virtio-ccw) would need the iommu=3Doff DMA ops to do the bounce buffering
iff force_dma_unencrypted().

Regards,
Halil

--Sig_/6L0zE9scbEzJxcRVxZin/tR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJeT9rSAAoJEA0vhuyXGx0AgHQP+gLGTX4Ns4WO0rTvm272UO/v
hxbJZMxeojiTFWHD4TkCbltyBOw2vVGwyCrlR264NQDgcPkDbUpp/kU5KyuUWkMx
fg6K4ZOh4ZiwczUstvV5PB0qzEbKI4lK8uktHUzvHBdo7Hkflb3adUCZekqhKgJU
E5dipJ6cqTuWGgjY9hqOhFHBphLbThSY1fUlgIv3yXFrwW0LGUX4WFETF3Mq9S5y
4Z8xR8QsjPoNEmRpP6uZhSZ7ue5i0iRpf+zgJRF/F7mP4buODibZ3rN7YGhRP+ip
LP4NDLuooYIDnVVGcDZm578p/20XCGYldebH7wIcpoJemQGMRE8ZxS3eqvqhFMS4
PhUYS8/mR8v5Hq61r85qu4R6JDHJ8yH47YEFFVO+ZLrhk4WE7/NXohjGWzimmsx7
+oaTFLiuuQvn7K3ur1KGfgiMYDt4f2x7AstT3dr1qXj+jtKLcUUsSCjRdCN/CT65
o+lpGU4sDp04ekLWOGCtyymzC4QoJq8fZ5osnQnRb+w5mbDleSUgKD8FZbX2Zonu
t8XpKJBtY3ByHi2qu0Ll/1Kx22TTtTtt4CNedhQLvzZ6BEmZtx1/yQHZ6ju3V4p+
y6kumCXn8PCdSsrnzJL2zblvZhrDuyshzKNtB2Ihgn5ksldJ6z54hUCuw/oFbZ/y
B9ZUzg5KJmqce9haoZCY
=zf/I
-----END PGP SIGNATURE-----

--Sig_/6L0zE9scbEzJxcRVxZin/tR--

