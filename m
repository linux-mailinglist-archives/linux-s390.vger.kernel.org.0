Return-Path: <linux-s390+bounces-1324-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF53843A9E
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jan 2024 10:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BE71C28000
	for <lists+linux-s390@lfdr.de>; Wed, 31 Jan 2024 09:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884F6D1A1;
	Wed, 31 Jan 2024 09:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4+q0JPC"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADB369955
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 09:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692356; cv=none; b=KDB2HuopLlbey+UAKKcP+9ra4k6u+iLaaeEWFrjk9OwA877qQtNA5/O7NZs2LvHgoI7DYgzz5d/Sx8Hv5M7iyYiDbrvxaBhXYa6s2OWlgZ7a/CA2Ie2B7Iov5YKqHxfN5Bkc5i+psx6urARUMJ1GhErLSTn9rAihgpLJvPf7tvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692356; c=relaxed/simple;
	bh=DevodeaH+jch2K7q2J7ci6jCI8PTfbG6p15sjzeL04I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpal97kUNGeweTL2PLYwQhZAbuARVOZ8fv+56lgMBOetiQYYr/D6qs0QXS+fpetkR/eLd+3lZMnL+5HzZGaD+x8zkwwQz6zv1MkmwX2hHuZqNfCmVkCVwb7dfYYfalWnIOpnRsS9Ff9KZzb/Xcgj9153iDaRIOSBji7cBrJpu6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4+q0JPC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2gdg9RDObpqK4bkMt73JUbXQJSSaxJiWlkmE80gR1M=;
	b=P4+q0JPCBKnXNwD6h9vtBOSdIG9kHr0x8anf3Q7eh1BvtcSkHJXTlBGP1MGzjZM+9D3Kuy
	w2kdJAhPwCmwcLXLYyKSYvcLSjTKlvhTOonjbUnyhR3NCJgJiBD4mr9AW69HlAU+7lyV7l
	guvAcM58w3L8v0IZ7pXcldVAhizLIug=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-cD27-9n4M36Omx185PhzHw-1; Wed, 31 Jan 2024 04:12:32 -0500
X-MC-Unique: cD27-9n4M36Omx185PhzHw-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-59907104d88so4791597eaf.3
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 01:12:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692351; x=1707297151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2gdg9RDObpqK4bkMt73JUbXQJSSaxJiWlkmE80gR1M=;
        b=TkS+23TdF2vMQ7Bd6cCmn0x68+KofnmqwvVFgkwzW33M9feF1vo+NaDFV5K6GSpU/c
         PWwbcmRTb2agY7E2C6JeWGeXF1F7XiuR/UipYl7sshggkYRbkVs1WOtBSvvaJxW3PsFe
         ZjzU58Xz6jWjqV87/c5ddtl+JRP4n4QRjUD/t4UVnxYJh5F6irP5ZfHEaPEnW1RrYl1e
         ttQtz3LaPVRTStIlA0QhUEX/I61Z24VT/6jXI9QyBqW+m+4feLvlkrAVZsVuS7Iqd6/b
         6urQnE4c3gCtww2tE/R/duXb6KEOXmgzy0me4aPaiQgEcNxVeCVZuewav2JP1p01IF/j
         gSxg==
X-Gm-Message-State: AOJu0Yzrgtw8qFMWSycWOuFmcYw9xBrGngkIWQmz+mPIwA3GpTI5hQKL
	4nrTirGASuXIhSjZ2lcsmxxAFi8kOZdd9pSOv8SMUHeCpNkqlcIv02DjxWGH0NnVSREoJxxRct7
	EhbDs9ngisCJoWPiwUJi2I5EeDnvtFjm3WZb23KxAmMrn6tsUd7vG2R0nsXnPCghpFp9q1+aSWM
	FZ87kfV78HST5TnY1kKFqGPFU6OQUmWkn75A==
X-Received: by 2002:a05:6358:999e:b0:176:40d5:2bd5 with SMTP id j30-20020a056358999e00b0017640d52bd5mr828181rwb.6.1706692351277;
        Wed, 31 Jan 2024 01:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5NRr7GtdKMQ4owCABZALmFK8Ctmda9rRzFtgneCkccV/xIa+/8MmJgT2OLhfyx42b2XxtxqmD6xFHD/Xq8vY=
X-Received: by 2002:a05:6358:999e:b0:176:40d5:2bd5 with SMTP id
 j30-20020a056358999e00b0017640d52bd5mr828142rwb.6.1706692350948; Wed, 31 Jan
 2024 01:12:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:19 +0800
Message-ID: <CACGkMEvmqVpcXCaF6f24N6gTN2yHJOeu0bL4JBYL4Zmyg8C2sQ@mail.gmail.com>
Subject: Re: [PATCH vhost 02/17] virtio_ring: packed: remove double check of
 the unmap ops
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> In the functions vring_unmap_extra_packed and vring_unmap_desc_packed,
> multiple checks are made whether unmap is performed and whether it is
> INDIRECT.
>
> These two functions are usually called in a loop, and we should put the
> check outside the loop.
>
> And we unmap the descs with VRING_DESC_F_INDIRECT on the same path with
> other descs, that make the thing more complex. If we distinguish the
> descs with VRING_DESC_F_INDIRECT before unmap, thing will be clearer.
>
> 1. only one desc of the desc table is used, we do not need the loop
> 2. the called unmap api is difference from the other desc
> 3. the vq->premapped is not needed to check
> 4. the vq->indirect is not needed to check
> 5. the state->indir_desc must not be null
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 4677831e6c26..7280a1706cca 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1220,6 +1220,7 @@ static u16 packed_last_used(u16 last_used_idx)
>         return last_used_idx & ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR));
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
>                                      const struct vring_desc_extra *extra=
)
>  {
> @@ -1227,33 +1228,18 @@ static void vring_unmap_extra_packed(const struct=
 vring_virtqueue *vq,
>
>         flags =3D extra->flags;
>
> -       if (flags & VRING_DESC_F_INDIRECT) {
> -               if (!vq->use_dma_api)
> -                       return;
> -
> -               dma_unmap_single(vring_dma_dev(vq),
> -                                extra->addr, extra->len,
> -                                (flags & VRING_DESC_F_WRITE) ?
> -                                DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       } else {
> -               if (!vring_need_unmap_buffer(vq))
> -                       return;
> -
> -               dma_unmap_page(vring_dma_dev(vq),
> -                              extra->addr, extra->len,
> -                              (flags & VRING_DESC_F_WRITE) ?
> -                              DMA_FROM_DEVICE : DMA_TO_DEVICE);
> -       }
> +       dma_unmap_page(vring_dma_dev(vq),
> +                      extra->addr, extra->len,
> +                      (flags & VRING_DESC_F_WRITE) ?
> +                      DMA_FROM_DEVICE : DMA_TO_DEVICE);
>  }
>
> +/* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
>                                     const struct vring_packed_desc *desc)
>  {
>         u16 flags;
>
> -       if (!vring_need_unmap_buffer(vq))
> -               return;
> -
>         flags =3D le16_to_cpu(desc->flags);
>
>         dma_unmap_page(vring_dma_dev(vq),
> @@ -1329,7 +1315,7 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>                         total_sg * sizeof(struct vring_packed_desc),
>                         DMA_TO_DEVICE);
>         if (vring_mapping_error(vq, addr)) {
> -               if (vq->premapped)
> +               if (!vring_need_unmap_buffer(vq))
>                         goto free_desc;
>
>                 goto unmap_release;
> @@ -1344,10 +1330,11 @@ static int virtqueue_add_indirect_packed(struct v=
ring_virtqueue *vq,
>                 vq->packed.desc_extra[id].addr =3D addr;
>                 vq->packed.desc_extra[id].len =3D total_sg *
>                                 sizeof(struct vring_packed_desc);
> -               vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT=
 |
> -                                                 vq->packed.avail_used_f=
lags;
>         }
>
> +       vq->packed.desc_extra[id].flags =3D VRING_DESC_F_INDIRECT |
> +               vq->packed.avail_used_flags;

Is this a bug fix? Or if we only need to check _F_INDIRECT, we can
simply avoid doing this by checking vq->indirect && state->indir_desc?

> +
>         /*
>          * A driver MUST NOT make the first descriptor in the list
>          * available before all subsequent descriptors comprising
> @@ -1388,6 +1375,8 @@ static int virtqueue_add_indirect_packed(struct vri=
ng_virtqueue *vq,
>  unmap_release:
>         err_idx =3D i;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));

Nitpick, using BUG_ON might be better as it may lead to unexpected
results which we can't recover from.

> +
>         for (i =3D 0; i < err_idx; i++)
>                 vring_unmap_desc_packed(vq, &desc[i]);
>
> @@ -1484,9 +1473,10 @@ static inline int virtqueue_add_packed(struct virt=
queue *_vq,
>                         if (unlikely(vring_need_unmap_buffer(vq))) {
>                                 vq->packed.desc_extra[curr].addr =3D addr=
;
>                                 vq->packed.desc_extra[curr].len =3D sg->l=
ength;
> -                               vq->packed.desc_extra[curr].flags =3D
> -                                       le16_to_cpu(flags);
>                         }
> +
> +                       vq->packed.desc_extra[curr].flags =3D le16_to_cpu=
(flags);
> +
>                         prev =3D curr;
>                         curr =3D vq->packed.desc_extra[curr].next;
>
> @@ -1536,6 +1526,8 @@ static inline int virtqueue_add_packed(struct virtq=
ueue *_vq,
>
>         vq->packed.avail_used_flags =3D avail_used_flags;
>
> +       WARN_ON(!vring_need_unmap_buffer(vq));
> +
>         for (n =3D 0; n < total_sg; n++) {
>                 if (i =3D=3D err_idx)
>                         break;
> @@ -1605,7 +1597,9 @@ static void detach_buf_packed(struct vring_virtqueu=
e *vq,
>         struct vring_desc_state_packed *state =3D NULL;
>         struct vring_packed_desc *desc;
>         unsigned int i, curr;
> +       u16 flags;
>
> +       flags =3D vq->packed.desc_extra[id].flags;
>         state =3D &vq->packed.desc_state[id];
>
>         /* Clear data ptr. */
> @@ -1615,22 +1609,32 @@ static void detach_buf_packed(struct vring_virtqu=
eue *vq,
>         vq->free_head =3D id;
>         vq->vq.num_free +=3D state->num;
>
> -       if (unlikely(vring_need_unmap_buffer(vq))) {
> -               curr =3D id;
> -               for (i =3D 0; i < state->num; i++) {
> -                       vring_unmap_extra_packed(vq,
> -                                                &vq->packed.desc_extra[c=
urr]);
> -                       curr =3D vq->packed.desc_extra[curr].next;
> +       if (!(flags & VRING_DESC_F_INDIRECT)) {
> +               if (vring_need_unmap_buffer(vq)) {
> +                       curr =3D id;
> +                       for (i =3D 0; i < state->num; i++) {
> +                               vring_unmap_extra_packed(vq,
> +                                                        &vq->packed.desc=
_extra[curr]);
> +                               curr =3D vq->packed.desc_extra[curr].next=
;
> +                       }

So before the change, we had:

        if (unlikely(vq->do_unmap)) {
                curr =3D id;
                for (i =3D 0; i < state->num; i++) {
                        vring_unmap_extra_packed(vq,
                                                 &vq->packed.desc_extra[cur=
r]);
                        curr =3D vq->packed.desc_extra[curr].next;
                }
        }

This looks like a bug as we should unmap the indirect descriptor
regradless of whether do_unmap is true or false.

If yes, we need a independent fix instead of squashing it in this patch?

>                 }
> -       }
>
> -       if (vq->indirect) {
> +               if (ctx)
> +                       *ctx =3D state->indir_desc;
> +       } else {
> +               const struct vring_desc_extra *extra;
>                 u32 len;
>
> +               if (vq->use_dma_api) {
> +                       extra =3D &vq->packed.desc_extra[id];
> +                       dma_unmap_single(vring_dma_dev(vq),
> +                                        extra->addr, extra->len,
> +                                        (flags & VRING_DESC_F_WRITE) ?
> +                                        DMA_FROM_DEVICE : DMA_TO_DEVICE)=
;
> +               }
> +

Thanks


