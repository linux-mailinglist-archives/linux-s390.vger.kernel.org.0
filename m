Return-Path: <linux-s390+bounces-1423-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CE84664E
	for <lists+linux-s390@lfdr.de>; Fri,  2 Feb 2024 04:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C6A1C2611C
	for <lists+linux-s390@lfdr.de>; Fri,  2 Feb 2024 03:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF5BE7E;
	Fri,  2 Feb 2024 03:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WKpRfWkg"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C1DF4E9
	for <linux-s390@vger.kernel.org>; Fri,  2 Feb 2024 03:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843198; cv=none; b=clrAqq7qeLly6V896XFT0GvRN8ayGrL7SznwavoY3UlC93weLDYOm45/j+NNqiJxfW7B2R859wUPg+IvtUg+dYfMY7vJPAKcZY8yTVfSYiGbkR1jCqaSfJ4AWEwMctz5MDn22+6JF78yS1WWa9JpPP2TcqP3MUyV4ir4vnOIUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843198; c=relaxed/simple;
	bh=QYZqJFdgYNLavms/nUo1ysLWMYWkecHneGmYCeW0PAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CEd7K3tXx2idCuqRBiqr+mcRMn35nhhdGRn2t8MIiFqjysU0PSOZDK6beTc5lli6l4xHmOsjEWyWaT1jYNYa/ASrS6U6eAvkqF0CJOLip6CagPiIXsF+088dxloShZh+kJ2/Q/jTYflSpn8+Jf2i+FW5vBd7xqjocHlGlLblrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WKpRfWkg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706843195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5MXqqYcm0nwNL3MENOJLZhnS+rtBOxM/i4dVzBZQWc=;
	b=WKpRfWkgaes3heAfZjfNQ+gVxfvS9KOX2Sw9rPGXu8vbsDiuhxFmJWDiac3upMXf4OksBd
	X0CJlqmfJTl/rSf4wlX8/I6ADNi0KLllnPqayNZnUQaxI3HIVg4SWNVNyjy8lIJ6VT14+K
	6Ggw0KILmugkMaOgS3FkluoWjZr6ot4=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-4Ush2eLjPy60Rc2sr6_Riw-1; Thu, 01 Feb 2024 22:06:34 -0500
X-MC-Unique: 4Ush2eLjPy60Rc2sr6_Riw-1
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-598fdf35732so1743936eaf.1
        for <linux-s390@vger.kernel.org>; Thu, 01 Feb 2024 19:06:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843193; x=1707447993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5MXqqYcm0nwNL3MENOJLZhnS+rtBOxM/i4dVzBZQWc=;
        b=SugGQpOUGqZcN6jL12Jy+yE5LuV769DVoq742uUoa+nqqpCYGzjeFLk62YEXhwJ/+K
         6lecrE9kt9Rd35vS8DVgkZm04ZloHRSzpFHSdagRkytZObbMPA685qYXqSv9FZu/0UEO
         RYzm5obdfs33wVg7W3EraGyfvOH6Z+Hxc8L9bevhFyR12SXqM44O9XZ68RkOZA3yHj6D
         7DlloVNtQqQjFGXIIZSlNFIXoFBBtwyWJsm6DctLh+oJZVxNSBKJSJUAh4uc8szytQP2
         FIUtV4C/QYjPJ3K6J2LmIyyyY8GPqIXqxpLdOZp0wxMSBvfftAvtHVdn3pNSf/NaQD8s
         7sBA==
X-Gm-Message-State: AOJu0YyEtJWBR8L6ZCN5gNyFrkXpaMDxnMxLU04m+OeojSYqO27AsP4m
	PM/0Zkb2JZSFp992plOvapZyPDpMwwnboHmR6ig9aXR7B2iPrmi9RmSO5coa6Z7emeITQdFQTUD
	A+EmIlKN6r0fMab+gHUxRO8zf0+Q4FCTR9Mmdci7fjds6Zr9QQ03ie3etpfJc7V9OtRJBkokQp/
	T2/TSn0ENsNU0TudxvddhxEvWb7bOTo/fk2g==
X-Received: by 2002:a05:6358:7e8b:b0:178:cb3e:b74c with SMTP id o11-20020a0563587e8b00b00178cb3eb74cmr721181rwn.28.1706843193265;
        Thu, 01 Feb 2024 19:06:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnnf0uYApnwJ8ot71PqIV/dtLwp0t3UGDcHzLTReGmnUTng7hr5CvYF6Rt6fg0aixEyvGJkwHqZoRSyzJB6TI=
X-Received: by 2002:a05:6358:7e8b:b0:178:cb3e:b74c with SMTP id
 o11-20020a0563587e8b00b00178cb3eb74cmr721167rwn.28.1706843192958; Thu, 01 Feb
 2024 19:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com>
 <20240130114224.86536-18-xuanzhuo@linux.alibaba.com> <CACGkMEv2cyuesaTx899hwZt7uDdqwmAwXJ8fZDv00W9FbVbTpw@mail.gmail.com>
 <1706757660.3554723-2-xuanzhuo@linux.alibaba.com> <CACGkMEtwWAijrLOrdgJ9ZPx5VjSfJtwVm1k1U8fsg9+tvgRHxg@mail.gmail.com>
 <1706766995.312187-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706766995.312187-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 2 Feb 2024 11:06:21 +0800
Message-ID: <CACGkMEt-sveBvAGTVsqpFSAoDpdUk66oT8wtPASu7dhAb12oJw@mail.gmail.com>
Subject: Re: [PATCH vhost 17/17] virtio_net: sq support premapped mode
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

On Thu, Feb 1, 2024 at 2:01=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
>
> On Thu, 1 Feb 2024 13:36:46 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> > On Thu, Feb 1, 2024 at 11:28=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.aliba=
ba.com> wrote:
> > >
> > > On Wed, 31 Jan 2024 17:12:47 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> > > > On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.a=
libaba.com> wrote:
> > > > >
> > > > > If the xsk is enabling, the xsk tx will share the send queue.
> > > > > But the xsk requires that the send queue use the premapped mode.
> > > > > So the send queue must support premapped mode.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio_net.c | 167 +++++++++++++++++++++++++++++++++=
+++++-
> > > > >  1 file changed, 163 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > index 226ab830870e..cf0c67380b07 100644
> > > > > --- a/drivers/net/virtio_net.c
> > > > > +++ b/drivers/net/virtio_net.c
> > > > > @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
> > > > >  #define VIRTIO_XDP_REDIR       BIT(1)
> > > > >
> > > > >  #define VIRTIO_XDP_FLAG        BIT(0)
> > > > > +#define VIRTIO_DMA_FLAG        BIT(1)
> > > > >
> > > > >  /* RX packet size EWMA. The average packet size is used to deter=
mine the packet
> > > > >   * buffer size when refilling RX rings. As the entire RX ring ma=
y be refilled
> > > > > @@ -140,6 +141,21 @@ struct virtnet_rq_dma {
> > > > >         u16 need_sync;
> > > > >  };
> > > > >
> > > > > +struct virtnet_sq_dma {
> > > > > +       union {
> > > > > +               struct virtnet_sq_dma *next;
> > > > > +               void *data;
> > > > > +       };
> > > > > +       dma_addr_t addr;
> > > > > +       u32 len;
> > > > > +       bool is_tail;
> > > > > +};
> > > > > +
> > > > > +struct virtnet_sq_dma_head {
> > > > > +       struct virtnet_sq_dma *free;
> > > > > +       struct virtnet_sq_dma *head;
> > > >
> > > > Any reason the head must be a pointer instead of a simple index?
> > >
> > >
> > > The head is used for kfree.
> > > Maybe I need to rename it.
> > >
> > > About the index(next) of the virtnet_sq_dma.
> > > If we use the index, the struct will be:
> > >
> > > struct virtnet_sq_dma {
> > >        dma_addr_t addr;
> > >        u32 len;
> > >
> > >        u32 next;
> > >        void *data
> > > };
> > >
> > > The size of virtnet_sq_dma is same.
> >
> > Ok.
> >
> > >
> > >
> > > >
> > > > > +};
> > > > > +
> > > > >  /* Internal representation of a send virtqueue */
> > > > >  struct send_queue {
> > > > >         /* Virtqueue associated with this send _queue */
> > > > > @@ -159,6 +175,8 @@ struct send_queue {
> > > > >
> > > > >         /* Record whether sq is in reset state. */
> > > > >         bool reset;
> > > > > +
> > > > > +       struct virtnet_sq_dma_head dmainfo;
> > > > >  };
> > > > >
> > >
> > > ....
> > >
> > > > > +
> > > > > +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> > > > > +{
> > > > > +       struct virtnet_sq_dma *d;
> > > > > +       int size, i;
> > > > > +
> > > > > +       size =3D virtqueue_get_vring_size(sq->vq);
> > > > > +
> > > > > +       size +=3D MAX_SKB_FRAGS + 2;
> > > >
> > > > Is this enough for the case where an indirect descriptor is used?
> > >
> > >
> > > This is for the case, when the ring is full, the xmit_skb is called.
> > >
> > > I will add comment.
> >
> > Just to make sure we are at the same page.
> >
> > I meant, we could have more pending #sg than allocated here.
> >
> > For example, we can have up to (vring_size - 2 - MAX_SKB_FRAGS) *
> > MAX_SKB_FRAGS number of pending sgs?
> >
>
> Oh, my was wrong.
>
> But the max value a
> But shouldn't the maximum value be vring_size * (2 + MAX_SKB_FRAGS)?

This seems to be safer, yes.

>
> And for the reason above, we should allocate (vring_size + 1) * (2 + MAX_=
SKB_FRAGS);

Then we need to benchmark to see if it has an impact on the performance.

Thanks

>
> Thanks.
>
>
> > Thanks
> >
> > >
> > > Thanks.
> > >
> > >
> > > >
> > > > Thanks
> > > >
> > >
> >
>


