Return-Path: <linux-s390+bounces-2773-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8393D88B969
	for <lists+linux-s390@lfdr.de>; Tue, 26 Mar 2024 05:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72241C30BEE
	for <lists+linux-s390@lfdr.de>; Tue, 26 Mar 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5F012AAC4;
	Tue, 26 Mar 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fOwR1SBR"
X-Original-To: linux-s390@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03A12A17C
	for <linux-s390@vger.kernel.org>; Tue, 26 Mar 2024 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711427136; cv=none; b=olu8OFBJsJKKf2FgGhQrsej7vwtE4WSpuqIvr8S88yo1rfbktbOvWTb5FeBjQ86rxjBGfmNDsknR2oCSbHiqXzb5sl8ztwXOyWqUPX8gCaPxDCkkeRMEq0yRZH72eWAo8ONtMaUBSAKhxe/0n/wkk43PQyGdRrTL343QPtXLrAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711427136; c=relaxed/simple;
	bh=JMNEMnkdRhkyYJr9/0biS8F0pBLtab3qD91d6+Fkz7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCWZvYlAsvpSd+4hTWku3avvCue291aZ00ZR4osIKT5BUnQfGuFW+aPVNqkBPywKoKz0tYQTG/zZ8hBsjQVzXdUcwlmsoFYGmcpjurasndU4+0utKBkx9BWGNweXNCOjryBGohJZVxtT7GkEKv/ssPG+FvWEt31qESCy44s5zUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fOwR1SBR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711427133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9wx4BuvKLz4tvOMSdVGgTgc289YmZwETUSF9fXZYpA=;
	b=fOwR1SBRQS6trD389Z5u4LojnD9GYRVETKaE4ruVYySLiiobAmkoJZgErWm7X9C3fRcZis
	t3zkbFB8e1yzTE9w4kZfPLPQyIWf3p40VCpNRDPhU6T0Doq2PgJXRCIxe3nZ36TPWDBmib
	UCyJo3eo8d5yy7Obv04o1yTevdQFuVg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-cLQpDb5vOPyTNXat4Q0DQg-1; Tue, 26 Mar 2024 00:25:31 -0400
X-MC-Unique: cLQpDb5vOPyTNXat4Q0DQg-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e0984b137aso17992225ad.2
        for <linux-s390@vger.kernel.org>; Mon, 25 Mar 2024 21:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711427131; x=1712031931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9wx4BuvKLz4tvOMSdVGgTgc289YmZwETUSF9fXZYpA=;
        b=YngLAG+04dJJFOTC11PsOBOqCf1b10H49Npormn8QZsOZGXN11tL8dsN+qzdQewsFB
         DE1/ZF1DS14D6zqj+zznqjzB/SlhMf69QFFkTqE/2Xm3EI4WD7APplYOQYYOfKUZcY3T
         qzIpZA9epM58AEJIMU5KgqLDT+oJlZqso2TYHeSZmzUZXHdpXORnGS5V1fgtaEUgNrqB
         7g587RjxwfCXrdPinKWmsWP7Xr1fqdwTaSNve8uU3sW3ORUVHDxhBU88sa2VIvpZn8LL
         rag4ZC/iqzKWc+0K2YEN474WqsbQzMvsFCyNhPmrANI7jY+Zk4HQJrYplr+OXDsT2bK2
         UqCg==
X-Forwarded-Encrypted: i=1; AJvYcCXNBgXnV8susz/V89jMHQC739zdmiB8SgGjjjIzPrFAhI7pMephWQhWoAqc195MJTrFNfBnqOYIxxjMJQmHuzdaBUWi3rDeRDC7vg==
X-Gm-Message-State: AOJu0Yx4v1y033ayiudmtKBvUuC71Q6caBOIItTMBxssWWLMvVuxe2OT
	JJoeoFwRhjg3PO9TjPoxEAOHYU4cYcsihqK2d2DJneHpHv9brEeEgTtXHQqoYW7jBI08mkgTUTa
	ei67NLMg6E3mKaRp5wv4nf/JZAb1jjgDo6UFL9553F1wywc8tEgO5+vf0W3esiLT/oR5yYxkooJ
	YdkRrcgpKj6+dul8NU/u+OZl6KQaa4L9DeKw==
X-Received: by 2002:a17:902:6b43:b0:1e0:e11:c631 with SMTP id g3-20020a1709026b4300b001e00e11c631mr8163141plt.34.1711427130699;
        Mon, 25 Mar 2024 21:25:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXA4/VrxxLV5/0yu0bKQNp2eKt6WpfLHFRyOM9uOZEF+7AXkJpebrXsx2rM2mTk3VQMJOQtUr0/A5INAd0BHY=
X-Received: by 2002:a17:902:6b43:b0:1e0:e11:c631 with SMTP id
 g3-20020a1709026b4300b001e00e11c631mr8163116plt.34.1711427130295; Mon, 25 Mar
 2024 21:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240321101532.59272-1-xuanzhuo@linux.alibaba.com>
 <20240321101532.59272-2-xuanzhuo@linux.alibaba.com> <CABVzXAkwcKMb7pC21aUDLEM=RoyOtGA2Vim+LF0oWQ7mjUx68g@mail.gmail.com>
 <b420a545-0a7a-431c-aa48-c5db3d221420@redhat.com> <1711346901.0977402-2-xuanzhuo@linux.alibaba.com>
 <87zfum7ii8.fsf@redhat.com> <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
In-Reply-To: <CACGkMEv0g9CJmZzO4bH2BjcL5Wc0NxE6+zQ2Wgg=3v2AqR=XQA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Mar 2024 12:25:19 +0800
Message-ID: <CACGkMEt4rkuieVzFs6OKmpOcp9oC1R-LCju+t-7WfDcSjLND6w@mail.gmail.com>
Subject: Re: [PATCH vhost v4 1/6] virtio_balloon: remove the dependence where
 names[] is null
To: Cornelia Huck <cohuck@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Hildenbrand <david@redhat.com>, 
	virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>, 
	Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org, 
	Daniel Verkamp <dverkamp@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 12:11=E2=80=AFPM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Mon, Mar 25, 2024 at 5:44=E2=80=AFPM Cornelia Huck <cohuck@redhat.com>=
 wrote:
> >
> > On Mon, Mar 25 2024, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > > On Fri, 22 Mar 2024 22:02:27 +0100, David Hildenbrand <david@redhat.c=
om> wrote:
> > >> On 22.03.24 20:16, Daniel Verkamp wrote:
> > >> > On Thu, Mar 21, 2024 at 3:16=E2=80=AFAM Xuan Zhuo <xuanzhuo@linux.=
alibaba.com> wrote:
> > >> >>
> > >> >> Currently, the init_vqs function within the virtio_balloon driver=
 relies
> > >> >> on the condition that certain names array entries are null in ord=
er to
> > >> >> skip the initialization of some virtual queues (vqs). This behavi=
or is
> > >> >> unique to this part of the codebase. In an upcoming commit, we pl=
an to
> > >> >> eliminate this dependency by removing the function entirely. Ther=
efore,
> > >> >> with this change, we are ensuring that the virtio_balloon no long=
er
> > >> >> depends on the aforementioned function.
> > >> >
> > >> > This is a behavior change, and I believe means that the driver no
> > >> > longer follows the spec [1].
> > >> >
> > >> > For example, the spec says that virtqueue 4 is reporting_vq, and
> > >> > reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set=
,
> > >> > but there is no mention of its virtqueue number changing if other
> > >> > features are not set. If a device/driver combination negotiates
> > >> > VIRTIO_BALLOON_F_PAGE_REPORTING but not VIRTIO_BALLOON_F_STATS_VQ =
or
> > >> > VIRTIO_BALLOON_F_FREE_PAGE_HINT, my reading of the specification i=
s
> > >> > that reporting_vq should still be vq number 4, and vq 2 and 3 shou=
ld
> > >> > be unused. This patch would make the reporting_vq use vq 2 instead=
 in
> > >> > this case.
> > >> >
> > >> > If the new behavior is truly intended, then the spec does not matc=
h
> > >> > reality, and it would need to be changed first (IMO); however,
> > >> > changing the spec would mean that any devices implemented correctl=
y
> > >> > per the previous spec would now be wrong, so some kind of mechanis=
m
> > >> > for detecting the new behavior would be warranted, e.g. a new
> > >> > non-device-specific virtio feature flag.
> > >> >
> > >> > I have brought this up previously on the virtio-comment list [2], =
but
> > >> > it did not receive any satisfying answers at that time.
> >
> > I had missed it back then, but now that I read it, I realize that we
> > really have a bit of a mess here :/
> >
> > >>
> > >> Rings a bell, but staring at this patch, I thought that there would =
be
> > >> no behavioral change. Maybe I missed it :/
> > >>
> > >> I stared at virtio_ccw_find_vqs(), and it contains:
> > >>
> > >>      for (i =3D 0; i < nvqs; ++i) {
> > >>              if (!names[i]) {
> > >>                      vqs[i] =3D NULL;
> > >>                      continue;
> > >>              }
> > >>
> > >>              vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callb=
acks[i],
> > >>                                           names[i], ctx ? ctx[i] : f=
alse,
> > >>                                           ccw);
> > >>              if (IS_ERR(vqs[i])) {
> > >>                      ret =3D PTR_ERR(vqs[i]);
> > >>                      vqs[i] =3D NULL;
> > >>                      goto out;
> > >>              }
> > >>      }
> > >>
> > >> We increment queue_idx only if an entry was not NULL. SO I thought n=
o
> > >> behavioral change? (at least on s390x :) )
> >
> > The code for pci behaves in the same way.
> >
> > >>
> > >> It's late here in Germany, so maybe I'm missing something.
> > >
> > > I think we've encountered a tricky issue. Currently, all transports h=
andle queue
> > > id by incrementing them in order, without skipping any queue id. So, =
I'm quite
> > > surprised that my changes would affect the spec. The fact that the
> > > 'names' value is null is just a small trick in the Linux kernel imple=
mentation
> > > and should not have an impact on the queue id.
> > >
> > > I believe that my recent modification will not affect the spec. So, l=
et's
> > > consider the issues with this patch set separately for now. Regarding=
 the Memory
> > > Balloon Device, it has been operational for many years, and perhaps w=
e should
> > > add to the spec that if a certain vq does not exist, then subsequent =
vqs will
> > > take over its id.
> >
> > The changes here do not really seem to affect the spec issue that Danie=
l
> > had noted, unless I'm reading the code wrong.
>
> Spec seems to be wrong here:
>
> 5.5.2 Virtqueues
>
> 0 inflateq 1 deflateq 2 statsq 3 free_page_vq4 r eporting_vq
>
> And this is the Qemu implementation:
>
> 5.5.2 Virtqueues
>
>     s->ivq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>     s->dvq =3D virtio_add_queue(vdev, 128, virtio_balloon_handle_output);
>     s->svq =3D virtio_add_queue(vdev, 128, virtio_balloon_receive_stats);
>
>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_FREE_PAGE_H=
INT)) {
>         s->free_page_vq =3D virtio_add_queue(vdev, VIRTQUEUE_MAX_SIZE,
>                                            virtio_balloon_handle_free_pag=
e_vq);
>         precopy_add_notifier(&s->free_page_hint_notify);
>
>         object_ref(OBJECT(s->iothread));
>         s->free_page_bh =3D
> aio_bh_new_guarded(iothread_get_aio_context(s->iothread),
>
> virtio_ballloon_get_free_page_hints, s,
>                                              &dev->mem_reentrancy_guard);
>     }
>
>     if (virtio_has_feature(s->host_features, VIRTIO_BALLOON_F_REPORTING))=
 {
>         s->reporting_vq =3D virtio_add_queue(vdev, 32,
>                                            virtio_balloon_handle_report);
>     }
>
> We need to fix it.

Another possible issue:

FS device:

5.11.2 Virtqueues

0 hiprio 1 notification queue 2=E2=80=A6n request queues

The notification queue only exists if VIRTIO_FS_F_NOTIFICATION is set.

Kernel driver had this:

enum {
        VQ_HIPRIO,
        VQ_REQUEST
};

Which means request starts from 1.

Thanks

>
> >
> > However, we should try to address the spec mess, where we have at least
> > some of the most popular/important implementations behaving differently
> > than the spec describes... I would suggest to discuss that on the virti=
o
> > lists -- but they are still dead, and at this point I'm just hoping
> > they'll come back eventually :/
> >
>
> Thanks


