Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7813F55DDAB
	for <lists+linux-s390@lfdr.de>; Tue, 28 Jun 2022 15:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbiF0Hpt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Jun 2022 03:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiF0Hpr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Jun 2022 03:45:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E99F660EA
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656315944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DJ8lTv8mNQFqfIpLLTdJ5wTzmtewiqdkMpwZ7L0k0po=;
        b=CvbzazEhsnrxYlxxmqXKq/wjdpjt4q5JJ31r+UR+Ij8/avZTeFuFOdeNX48Nv4Xn6IDWrN
        SHSE1HW0dgpkA9BVDWgLHCxZZiPe367TXVSyHAPXs3mJlc8BtGzamdkLRoZe9vtIsSaiaa
        L3yhwunItgVpG8j5fcrHpaCNKGtcnFw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-dZJNX9wZNEa8p16mDvlLZg-1; Mon, 27 Jun 2022 03:45:43 -0400
X-MC-Unique: dZJNX9wZNEa8p16mDvlLZg-1
Received: by mail-lf1-f70.google.com with SMTP id i3-20020a056512318300b0047f86b47910so4312124lfe.14
        for <linux-s390@vger.kernel.org>; Mon, 27 Jun 2022 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJ8lTv8mNQFqfIpLLTdJ5wTzmtewiqdkMpwZ7L0k0po=;
        b=pBIN20cnlCIt4WMH9yItiMd4RLx6XTP/RQ1IMi+hIgDEdyS/KHdl8hpb8hGeetcC+x
         XPub05vzPLz/jBifAsqv57GAMUYZOxjOX1bCUYDc9SCObkoGIZeJTUjxKzsB1kllWYAm
         SSDihAP62WNkBj5xaEiLphlP4WuWjZvXUR8RjDymTX6hQnFeciJfC3lBQsFEUliktOjF
         PtpsBvuQPaTNmNLOpiAVqYWgVNk7mj1zqMHTQaRh3+tLwC5+Gr7K8aKWs+zWNBA9723I
         xVaERw/DS5sOG5pUvv9zwQfmIyzuCkfkj4yGmlbz5Vlj/U6K4A2ul4IyYtG+tTq1W3Rz
         +Ikg==
X-Gm-Message-State: AJIora9wsAZSEb3RbqUID1Rs5ZpfZwHIvL0aZm1YS9SMEsd8+DIRDKVr
        FFGGxTc671qOuZrdYrlPS+k7eKaA423lS8dooX2Y6j2hq6LoLJs3/MGLncZLhjvZa7+vcKut5X6
        PBIL9zGRucJwUfIvEyijBQKOtPn4F334CHr+6kw==
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id bj37-20020a2eaaa5000000b0025bae574ad7mr6113590ljb.323.1656315941392;
        Mon, 27 Jun 2022 00:45:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vViYYUTuYJvHrB7a6J1t+RbESIVnJ/fW5l8pDtbVNhAjJvWLMAazge0YptM+fayabkTwGDETijvn1jNEjsB7g=
X-Received: by 2002:a2e:aaa5:0:b0:25b:ae57:4ad7 with SMTP id
 bj37-20020a2eaaa5000000b0025bae574ad7mr6113578ljb.323.1656315941180; Mon, 27
 Jun 2022 00:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
 <20220624025621.128843-26-xuanzhuo@linux.alibaba.com> <20220624025817-mutt-send-email-mst@kernel.org>
 <CACGkMEseptD=45j3kQr0yciRxR679Jcig=292H07-RYC2vXmFQ@mail.gmail.com> <20220627023841-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220627023841-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 27 Jun 2022 15:45:30 +0800
Message-ID: <CACGkMEvy8xF2T_vubKeUEPC2aroO_fbB0Xe8nnxK4OBUgAS+Gw@mail.gmail.com>
Subject: Re: [PATCH v10 25/41] virtio_pci: struct virtio_pci_common_cfg add queue_notify_data
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        kangjie.xu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 27, 2022 at 2:39 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Jun 27, 2022 at 10:30:42AM +0800, Jason Wang wrote:
> > On Fri, Jun 24, 2022 at 2:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Fri, Jun 24, 2022 at 10:56:05AM +0800, Xuan Zhuo wrote:
> > > > Add queue_notify_data in struct virtio_pci_common_cfg, which comes from
> > > > here https://github.com/oasis-tcs/virtio-spec/issues/89
> > > >
> > > > For not breaks uABI, add a new struct virtio_pci_common_cfg_notify.
> > >
> > > What exactly is meant by not breaking uABI?
> > > Users are supposed to be prepared for struct size to change ... no?
> >
> > Not sure, any doc for this?
> >
> > Thanks
>
>
> Well we have this:
>
>         The drivers SHOULD only map part of configuration structure
>         large enough for device operation.  The drivers MUST handle
>         an unexpectedly large \field{length}, but MAY check that \field{length}
>         is large enough for device operation.

Yes, but that's the device/driver interface. What's done here is the
userspace/kernel.

Userspace may break if it uses e.g sizeof(struct virtio_pci_common_cfg)?

Thanks

>
>
>
> >
> > >
> > >
> > > > Since I want to add queue_reset after queue_notify_data, I submitted
> > > > this patch first.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  include/uapi/linux/virtio_pci.h | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >
> > > > diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
> > > > index 3a86f36d7e3d..22bec9bd0dfc 100644
> > > > --- a/include/uapi/linux/virtio_pci.h
> > > > +++ b/include/uapi/linux/virtio_pci.h
> > > > @@ -166,6 +166,13 @@ struct virtio_pci_common_cfg {
> > > >       __le32 queue_used_hi;           /* read-write */
> > > >  };
> > > >
> > > > +struct virtio_pci_common_cfg_notify {
> > > > +     struct virtio_pci_common_cfg cfg;
> > > > +
> > > > +     __le16 queue_notify_data;       /* read-write */
> > > > +     __le16 padding;
> > > > +};
> > > > +
> > > >  /* Fields in VIRTIO_PCI_CAP_PCI_CFG: */
> > > >  struct virtio_pci_cfg_cap {
> > > >       struct virtio_pci_cap cap;
> > > > --
> > > > 2.31.0
> > >
>

