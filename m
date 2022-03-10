Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2E4D4280
	for <lists+linux-s390@lfdr.de>; Thu, 10 Mar 2022 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiCJIaI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Mar 2022 03:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiCJIaI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Mar 2022 03:30:08 -0500
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8811135701;
        Thu, 10 Mar 2022 00:29:05 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0V6neRLx_1646900938;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0V6neRLx_1646900938)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Mar 2022 16:28:59 +0800
Message-ID: <1646900411.6481435-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 17/26] virtio_pci: queue_reset: support VIRTIO_F_RING_RESET
Date:   Thu, 10 Mar 2022 16:20:11 +0800
From:   Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, bpf@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-18-xuanzhuo@linux.alibaba.com>
 <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
In-Reply-To: <8b9d337d-71c2-07b4-8e65-6f83cf09bf7a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 9 Mar 2022 16:54:10 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2022/3/8 =E4=B8=8B=E5=8D=888:35, Xuan Zhuo =E5=86=99=E9=81=93:
> > This patch implements virtio pci support for QUEUE RESET.
> >
> > Performing reset on a queue is divided into these steps:
> >
> >   1. virtio_reset_vq()              - notify the device to reset the qu=
eue
> >   2. virtqueue_detach_unused_buf()  - recycle the buffer submitted
> >   3. virtqueue_reset_vring()        - reset the vring (may re-alloc)
> >   4. virtio_enable_resetq()         - mmap vring to device, and enable =
the queue
> >
> > This patch implements virtio_reset_vq(), virtio_enable_resetq() in the
> > pci scenario.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   drivers/virtio/virtio_pci_common.c |  8 +--
> >   drivers/virtio/virtio_pci_modern.c | 83 ++++++++++++++++++++++++++++++
> >   2 files changed, 88 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio=
_pci_common.c
> > index fdbde1db5ec5..863d3a8a0956 100644
> > --- a/drivers/virtio/virtio_pci_common.c
> > +++ b/drivers/virtio/virtio_pci_common.c
> > @@ -248,9 +248,11 @@ static void vp_del_vq(struct virtqueue *vq)
> >   	struct virtio_pci_vq_info *info =3D vp_dev->vqs[vq->index];
> >   	unsigned long flags;
> >
> > -	spin_lock_irqsave(&vp_dev->lock, flags);
> > -	list_del(&info->node);
> > -	spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +	if (!vq->reset) {
> > +		spin_lock_irqsave(&vp_dev->lock, flags);
> > +		list_del(&info->node);
> > +		spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +	}
> >
> >   	vp_dev->del_vq(info);
> >   	kfree(info);
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio=
_pci_modern.c
> > index 49a4493732cf..3c67d3607802 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -34,6 +34,9 @@ static void vp_transport_features(struct virtio_devic=
e *vdev, u64 features)
> >   	if ((features & BIT_ULL(VIRTIO_F_SR_IOV)) &&
> >   			pci_find_ext_capability(pci_dev, PCI_EXT_CAP_ID_SRIOV))
> >   		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
> > +
> > +	if (features & BIT_ULL(VIRTIO_F_RING_RESET))
> > +		__virtio_set_bit(vdev, VIRTIO_F_RING_RESET);
> >   }
> >
> >   /* virtio config->finalize_features() implementation */
> > @@ -199,6 +202,82 @@ static int vp_active_vq(struct virtqueue *vq, u16 =
msix_vec)
> >   	return 0;
> >   }
> >
> > +static int vp_modern_reset_vq(struct virtqueue *vq)
> > +{
> > +	struct virtio_pci_device *vp_dev =3D to_vp_device(vq->vdev);
> > +	struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
> > +	struct virtio_pci_vq_info *info;
> > +	unsigned long flags;
> > +	unsigned int irq;
> > +
> > +	if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
> > +		return -ENOENT;
> > +
> > +	vp_modern_set_queue_reset(mdev, vq->index);
> > +
> > +	info =3D vp_dev->vqs[vq->index];
> > +
> > +	/* delete vq from irq handler */
> > +	spin_lock_irqsave(&vp_dev->lock, flags);
> > +	list_del(&info->node);
> > +	spin_unlock_irqrestore(&vp_dev->lock, flags);
> > +
> > +	INIT_LIST_HEAD(&info->node);
> > +
> > +	vq->reset =3D VIRTIO_VQ_RESET_STEP_DEVICE;
> > +
> > +	/* sync irq callback. */
> > +	if (vp_dev->intx_enabled) {
> > +		irq =3D vp_dev->pci_dev->irq;
> > +
> > +	} else {
> > +		if (info->msix_vector =3D=3D VIRTIO_MSI_NO_VECTOR)
> > +			return 0;
> > +
> > +		irq =3D pci_irq_vector(vp_dev->pci_dev, info->msix_vector);
> > +	}
> > +
> > +	synchronize_irq(irq);
>
>
> Synchronize_irq() is not sufficient here since it breaks the effort of
> the interrupt hardening which is done by commits:
>
> 080cd7c3ac87 virtio-pci: harden INTX interrupts
> 9e35276a5344 virtio_pci: harden MSI-X interrupts
>
> Unfortunately=C2=A0 080cd7c3ac87 introduces an issue that disable_irq() w=
ere
> used for the affinity managed irq but we're discussing a fix.
>


ok, I think disable_irq() is still used here.

I want to determine the solution for this detail first. So I posted the cod=
e, I
hope Jason can help confirm this point first.

There are three situations in which vq corresponds to an interrupt

1. intx
2. msix: per vq vectors
2. msix: share irq

Essentially can be divided into two categories: per vq vectors and share ir=
q.

For share irq is based on virtqueues to find vq, so I think it is safe as l=
ong
as list_del() is executed under the protection of the lock.

In the case of per vq vectors, disable_irq() is used.

Thanks.

+static int vp_modern_reset_vq(struct virtqueue *vq)
+{
+       struct virtio_pci_device *vp_dev =3D to_vp_device(vq->vdev);
+       struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
+       struct virtio_pci_vq_info *info;
+       unsigned long flags;
+       unsigned int irq;
+
+       if (!virtio_has_feature(vq->vdev, VIRTIO_F_RING_RESET))
+               return -ENOENT;
+
+       vp_modern_set_queue_reset(mdev, vq->index);
+
+       info =3D vp_dev->vqs[vq->index];
+
+       /* delete vq from irq handler */
+       spin_lock_irqsave(&vp_dev->lock, flags);
+       list_del(&info->node);
+       vp_modern_set_queue_reset(mdev, vq->index);
+
+       info =3D vp_dev->vqs[vq->index];
+
+       /* delete vq from irq handler */
+       spin_lock_irqsave(&vp_dev->lock, flags);
+       list_del(&info->node);
+       spin_unlock_irqrestore(&vp_dev->lock, flags);
+
+       INIT_LIST_HEAD(&info->node);
+
+       /* For the case where vq has an exclusive irq, to prevent the irq f=
rom
+        * being received again and the pending irq, call disable_irq().
+        *
+        * In the scenario based on shared interrupts, vq will be searched =
from
+        * the queue virtqueues. Since the previous list_del() has been del=
eted
+        * from the queue, it is impossible for vq to be called in this cas=
e.
+        * There is no need to close the corresponding interrupt.
+        */
+       if (vp_dev->per_vq_vectors && msix_vec !=3D VIRTIO_MSI_NO_VECTOR)
+               disable_irq(pci_irq_vector(vp_dev->pci_dev, info->msix_vect=
or));
+
+       vq->reset =3D true;
+
+       return 0;
+}
+
+static int vp_modern_enable_reset_vq(struct virtqueue *vq)
+{
+       struct virtio_pci_device *vp_dev =3D to_vp_device(vq->vdev);
+       struct virtio_pci_modern_device *mdev =3D &vp_dev->mdev;
+       struct virtio_pci_vq_info *info;
+       unsigned long flags, index;
+       int err;
+
+       if (!vq->reset)
+               return -EBUSY;
+
+       index =3D vq->index;
+       info =3D vp_dev->vqs[index];
+
+       /* check queue reset status */
+       if (vp_modern_get_queue_reset(mdev, index) !=3D 1)
+               return -EBUSY;
+
+       err =3D vp_active_vq(vq, info->msix_vector);
+       if (err)
+               return err;
+
+       if (vq->callback) {
+               spin_lock_irqsave(&vp_dev->lock, flags);
+               list_add(&info->node, &vp_dev->virtqueues);
+               spin_unlock_irqrestore(&vp_dev->lock, flags);
+       } else {
+               INIT_LIST_HEAD(&info->node);
+       }
+
+       vp_modern_set_queue_enable(&vp_dev->mdev, index, true);
+       vq->reset =3D false;
+
+       if (vp_dev->per_vq_vectors && msix_vec !=3D VIRTIO_MSI_NO_VECTOR)
+               enable_irq(pci_irq_vector(vp_dev->pci_dev, info->msix_vecto=
r));
+
+       return 0;
+}


