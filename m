Return-Path: <linux-s390+bounces-2649-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FFF881BBD
	for <lists+linux-s390@lfdr.de>; Thu, 21 Mar 2024 05:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EF21F20F3F
	for <lists+linux-s390@lfdr.de>; Thu, 21 Mar 2024 04:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2F4BA45;
	Thu, 21 Mar 2024 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zs6pv9Rv"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A8CFBF4
	for <linux-s390@vger.kernel.org>; Thu, 21 Mar 2024 04:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710993769; cv=none; b=SKkzfvCcS1hLG6XJp+KnyPnQn89Uh+g14wSkEkZRv9MswiPBQyRBhS2q3bOVhaqCxFhjrVeL1+b4JbWUkh3xbQtX4kfje03s00GUpYGXp9z7P7A/PKneUb9JZqY8Wv5hXae0tE1s2WJ0I+cXd/qGHyIox/kJ2RmWGxsOQP9nHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710993769; c=relaxed/simple;
	bh=2PFlG164x7Tjlxo8yf+VFV8m3jl7xKzCzlaHcYUXMY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qM3agMJoImCFR/+vegXH1mjbH7ysXCY6lNd8BEli7AA5yNkX8AQOFkXJ1RPBXRCMIN3xH4VoSuOn74MaERCpDYtvrpjfLtYC2VDMHKyG4ZkZl7SqlSXAdBqpGXlylNcz+77AjVhGtI44AsliF587ifjvPCvWDBDV/SUMIT+xi6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zs6pv9Rv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710993766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v2DyW0gz8L++p8KbNPZpU2XbgztY6GT9iss1dzyNyg=;
	b=Zs6pv9RvS6rsxN22vY17WTJIl1iK+pI1cYTAvs/g6mM91zbH6MMvuOAYKlTMOgeFamJamH
	6fzwHPpbxIjxmkwXG68yLuFYxtT4LG+N0Z5G+9+xXzBFDQQlbfqeLzyITGcNmYs6rR+tmR
	bQpTEIHnRmtZsmh1Ctf6MLFv4mKeMSY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-JdlDFGCZPwqknEzMVzUB6Q-1; Thu, 21 Mar 2024 00:02:45 -0400
X-MC-Unique: JdlDFGCZPwqknEzMVzUB6Q-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-29e09df31d0so432376a91.0
        for <linux-s390@vger.kernel.org>; Wed, 20 Mar 2024 21:02:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710993764; x=1711598564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v2DyW0gz8L++p8KbNPZpU2XbgztY6GT9iss1dzyNyg=;
        b=SFMZt3sBHTjl/BSL/jtJLWSX7AEvyqj6J/dGWYJ+ZEyrg0fnVc8TQHgTYKiEGbPiQ8
         7q/ByNRS/veCqKJKIzj6ChGWAC9+UhGWIAannuTvuk+re1v3wfhPrOQD11D5fGCZxroZ
         lmXZXYmVmLpL2XxUDvUiAqjCnW5FlYa8qXL119+oBp+Iz806BZGXyYzWoKgKoFxQzkiz
         QfZcUkYN6AIXr3JJKYyktdHlO9Yb5evQIS4sxi6T7gd74PwVXc5qoMP9GTsTBdnMnf6W
         d7HGBhrLycKUezrDpm6YLDE85K/XwzeqoJQzy6E9w8PyGe8sGpW/hZv53NHSQzcM8cjp
         fcuw==
X-Forwarded-Encrypted: i=1; AJvYcCVKlVOWGp77O4gWTSq/ndmnFlYRdLMFHC61YmDGNX+2m/JKT/HOvZfIYSCbnchPdlqgyLW68kNhI8reOooAleeBleG6r1CMgeiQcw==
X-Gm-Message-State: AOJu0YzKhQw7s4k9LS6PuOhJALqYSYTQ3ADBcG/J2PeJEA7Gaib9RLRZ
	0E14kEUWfAs6mtVCSNvIro1NUfaXoh+dDbMfvI+SUdyMHnV3W5+fK8KK5F0NvWATJsRFblBq5Lu
	0m99JbRvimG3X3dDB72RkVTObo3y2WAoF8/uRi+IKrb6a+nVIpVXfcaoFoqOKGw+Q9WT1bA8HvK
	FU8yisbcWrRKoj+pp1OoZT/UzsEdafkLv7oQ==
X-Received: by 2002:a17:90a:1149:b0:29b:46f0:6f8e with SMTP id d9-20020a17090a114900b0029b46f06f8emr2343090pje.8.1710993763864;
        Wed, 20 Mar 2024 21:02:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMpqJFATA8PChGL8OsNH1HW/ssHL0TM9NHUZ2jHtHUk9ZiHnTTe3Jsbo29jeLgCiV6NI70JzploPwbhQvlHK8=
X-Received: by 2002:a17:90a:1149:b0:29b:46f0:6f8e with SMTP id
 d9-20020a17090a114900b0029b46f06f8emr2343058pje.8.1710993763496; Wed, 20 Mar
 2024 21:02:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312021013.88656-1-xuanzhuo@linux.alibaba.com>
 <20240312021013.88656-2-xuanzhuo@linux.alibaba.com> <CACGkMEvVgfgAxLoKeFTgy-1GR0W07ciPYFuqs6PiWtKCnXuWTw@mail.gmail.com>
 <1710395908.7915084-1-xuanzhuo@linux.alibaba.com> <CACGkMEsT2JqJ1r_kStUzW0+-f+qT0C05n2A+Yrjpc-mHMZD_mQ@mail.gmail.com>
 <1710487245.6843069-1-xuanzhuo@linux.alibaba.com> <CACGkMEspzDTZP1yxkBz17MgU9meyfCUBDxG8mjm=acXHNxAxhg@mail.gmail.com>
 <1710741592.205804-1-xuanzhuo@linux.alibaba.com> <20240319025726-mutt-send-email-mst@kernel.org>
 <CACGkMEsO6e2=v36F=ezhHCEaXqG0+AhkCM2ZgmKAtyWncnif5Q@mail.gmail.com>
 <1710927569.5383172-1-xuanzhuo@linux.alibaba.com> <1710928485.9310899-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1710928485.9310899-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 21 Mar 2024 12:02:31 +0800
Message-ID: <CACGkMEtxEL3yf4G-gNZxaqMVzAUV3VinmaF03knjU_mQ5_8K8Q@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: find_vqs: pass struct instead of
 multi parameters
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 6:07=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Wed, 20 Mar 2024 17:39:29 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > On Wed, 20 Mar 2024 17:22:50 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Mar 19, 2024 at 2:58=E2=80=AFPM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 01:59:52PM +0800, Xuan Zhuo wrote:
> > > > > On Mon, 18 Mar 2024 12:18:23 +0800, Jason Wang <jasowang@redhat.c=
om> wrote:
> > > > > > On Fri, Mar 15, 2024 at 3:26=E2=80=AFPM Xuan Zhuo <xuanzhuo@lin=
ux.alibaba.com> wrote:
> > > > > > >
> > > > > > > On Fri, 15 Mar 2024 11:51:48 +0800, Jason Wang <jasowang@redh=
at.com> wrote:
> > > > > > > > On Thu, Mar 14, 2024 at 2:00=E2=80=AFPM Xuan Zhuo <xuanzhuo=
@linux.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, 14 Mar 2024 11:12:24 +0800, Jason Wang <jasowang@=
redhat.com> wrote:
> > > > > > > > > > On Tue, Mar 12, 2024 at 10:10=E2=80=AFAM Xuan Zhuo <xua=
nzhuo@linux.alibaba.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > Now, we pass multi parameters to find_vqs. These para=
meters
> > > > > > > > > > > may work for transport or work for vring.
> > > > > > > > > > >
> > > > > > > > > > > And find_vqs has multi implements in many places:
> > > > > > > > > > >
> > > > > > > > > > >  arch/um/drivers/virtio_uml.c
> > > > > > > > > > >  drivers/platform/mellanox/mlxbf-tmfifo.c
> > > > > > > > > > >  drivers/remoteproc/remoteproc_virtio.c
> > > > > > > > > > >  drivers/s390/virtio/virtio_ccw.c
> > > > > > > > > > >  drivers/virtio/virtio_mmio.c
> > > > > > > > > > >  drivers/virtio/virtio_pci_legacy.c
> > > > > > > > > > >  drivers/virtio/virtio_pci_modern.c
> > > > > > > > > > >  drivers/virtio/virtio_vdpa.c
> > > > > > > > > > >
> > > > > > > > > > > Every time, we try to add a new parameter, that is di=
fficult.
> > > > > > > > > > > We must change every find_vqs implement.
> > > > > > > > > > >
> > > > > > > > > > > One the other side, if we want to pass a parameter to=
 vring,
> > > > > > > > > > > we must change the call path from transport to vring.
> > > > > > > > > > > Too many functions need to be changed.
> > > > > > > > > > >
> > > > > > > > > > > So it is time to refactor the find_vqs. We pass a str=
ucture
> > > > > > > > > > > cfg to find_vqs(), that will be passed to vring by tr=
ansport.
> > > > > > > > > > >
> > > > > > > > > > > Because the vp_modern_create_avq() use the "const cha=
r *names[]",
> > > > > > > > > > > and the virtio_uml.c changes the name in the subseque=
nt commit, so
> > > > > > > > > > > change the "names" inside the virtio_vq_config from "=
const char *const
> > > > > > > > > > > *names" to "const char **names".
> > > > > > > > > > >
> > > > > > > > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > > > > > > > Acked-by: Johannes Berg <johannes@sipsolutions.net>
> > > > > > > > > > > Reviewed-by: Ilpo J=3DE4rvinen <ilpo.jarvinen@linux.i=
ntel.com>
> > > > > > > > > >
> > > > > > > > > > The name seems broken here.
> > > > > > > > >
> > > > > > > > > Email APP bug.
> > > > > > > > >
> > > > > > > > > I will fix.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > [...]
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >  typedef void vq_callback_t(struct virtqueue *);
> > > > > > > > > > >
> > > > > > > > > > > +/**
> > > > > > > > > > > + * struct virtio_vq_config - configure for find_vqs(=
)
> > > > > > > > > > > + * @cfg_idx: Used by virtio core. The drivers should=
 set this to 0.
> > > > > > > > > > > + *     During the initialization of each vq(vring se=
tup), we need to know which
> > > > > > > > > > > + *     item in the array should be used at that time=
. But since the item in
> > > > > > > > > > > + *     names can be null, which causes some item of =
array to be skipped, we
> > > > > > > > > > > + *     cannot use vq.index as the current id. So add=
 a cfg_idx to let vring
> > > > > > > > > > > + *     know how to get the current configuration fro=
m the array when
> > > > > > > > > > > + *     initializing vq.
> > > > > > > > > >
> > > > > > > > > > So this design is not good. If it is not something that=
 the driver
> > > > > > > > > > needs to care about, the core needs to hide it from the=
 API.
> > > > > > > > >
> > > > > > > > > The driver just ignore it. That will be beneficial to the=
 virtio core.
> > > > > > > > > Otherwise, we must pass one more parameter everywhere.
> > > > > > > >
> > > > > > > > I don't get here, it's an internal logic and we've already =
done that.
> > > > > > >
> > > > > > >
> > > > > > > ## Then these must add one param "cfg_idx";
> > > > > > >
> > > > > > >  struct virtqueue *vring_create_virtqueue(struct virtio_devic=
e *vdev,
> > > > > > >                                          unsigned int index,
> > > > > > >                                          struct vq_transport_=
config *tp_cfg,
> > > > > > >                                          struct virtio_vq_con=
fig *cfg,
> > > > > > > -->                                      uint cfg_idx);
> > > > > > >
> > > > > > >  struct virtqueue *vring_new_virtqueue(struct virtio_device *=
vdev,
> > > > > > >                                       unsigned int index,
> > > > > > >                                       void *pages,
> > > > > > >                                       struct vq_transport_con=
fig *tp_cfg,
> > > > > > >                                       struct virtio_vq_config=
 *cfg,
> > > > > > > -->                                      uint cfg_idx);
> > > > > > >
> > > > > > >
> > > > > > > ## The functions inside virtio_ring also need to add a new pa=
ram, such as:
> > > > > > >
> > > > > > >  static struct virtqueue *vring_create_virtqueue_split(struct=
 virtio_device *vdev,
> > > > > > >                                                       unsigne=
d int index,
> > > > > > >                                                       struct =
vq_transport_config *tp_cfg,
> > > > > > >                                                       struct =
virtio_vq_config,
> > > > > > > -->                                                   uint cf=
g_idx);
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > I guess what I'm missing is when could the index differ from cf=
g_idx?
> > > > >
> > > > >
> > > > >  @cfg_idx: Used by virtio core. The drivers should set this to 0.
> > > > >      During the initialization of each vq(vring setup), we need t=
o know which
> > > > >      item in the array should be used at that time. But since the=
 item in
> > > > >      names can be null, which causes some item of array to be ski=
pped, we
> > > > >      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^
> > > > >      cannot use vq.index as the current id. So add a cfg_idx to l=
et vring
> > > > >      know how to get the current configuration from the array whe=
n
> > > > >      initializing vq.
> > > > >
> > > > >
> > > > > static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned =
int nvqs,
> > > > >
> > > > >       ................
> > > > >
> > > > >       for (i =3D 0; i < nvqs; ++i) {
> > > > >               if (!names[i]) {
> > > > >                       vqs[i] =3D NULL;
> > > > >                       continue;
> > > > >               }
> > > > >
> > > > >               if (!callbacks[i])
> > > > >                       msix_vec =3D VIRTIO_MSI_NO_VECTOR;
> > > > >               else if (vp_dev->per_vq_vectors)
> > > > >                       msix_vec =3D allocated_vectors++;
> > > > >               else
> > > > >                       msix_vec =3D VP_MSIX_VQ_VECTOR;
> > > > >               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks=
[i], names[i],
> > > > >                                    ctx ? ctx[i] : false,
> > > > >                                    msix_vec);
> > > > >
> > > > >
> > > > > Thanks.
> > > >
> > > >
> > > > Jason what do you think is the way to resolve this?
> > >
> > > I wonder which driver doesn't use a specific virtqueue in this case.
> >
> >
> > commit 6457f126c888b3481fdae6f702e616cd0c79646e
> > Author: Michael S. Tsirkin <mst@redhat.com>
> > Date:   Wed Sep 5 21:47:45 2012 +0300
> >
> >     virtio: support reserved vqs
> >
> >     virtio network device multiqueue support reserves
> >     vq 3 for future use (useful both for future extensions and to make =
it
> >     pretty - this way receive vqs have even and transmit - odd numbers)=
.
> >     Make it possible to skip initialization for
> >     specific vq numbers by specifying NULL for name.
> >     Document this usage as well as (existing) NULL callback.
> >
> >     Drivers using this not coded up yet, so I simply tested
> >     with virtio-pci and verified that this patch does
> >     not break existing drivers.
> >
> >     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >     Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> >
> > This patch introduced this.
> >
> > Could we remove this? Then we can use the vq.index directly. That will
> > be great.

I think we can, as multiqueue virtio-net use 2N as ctrl vq finally, so
the logic doesn't apply.

>
> I checked the current kernel.
> Just virtio-ballon uses this feture. But we can fix by one line code.

That would be fine.

Thanks

>
> Thanks.
>
>
> >
> > >
> > > And it looks to me, introducing a per-vq-config struct might be bette=
r
> > > then we have
> > >
> > > virtio_vqs_config {
> > >       unsigned int nvqs;
> > >       struct virtio_vq_config *configs;
> > > }
> >
> > YES. I prefer this. But we need to refactor every driver.
> >
> > >
> > > So we don't need the cfg_idx stuff.
> >
> > This still needs cfg_idx.
> >
> > Thanks
> >
> >
> > >
> > > Thanks
> > >
> > > >
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > > Thanks.
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > Thanks
> > > > > > > >
> > > > > > > > >
> > > > > > > > > Thanks.
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > Thanks
> > > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > >
> > > >
> > >
> >
>


