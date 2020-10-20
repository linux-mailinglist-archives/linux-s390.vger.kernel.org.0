Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00A3286EF3
	for <lists+linux-s390@lfdr.de>; Thu,  8 Oct 2020 09:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgJHHDa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Oct 2020 03:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgJHHD3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602140607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnhkSbVbWcPpnLBy80OV7GY//sNBKeciOwQqXhu40yk=;
        b=CPJ3KOKVyVnvrWcEceyKZZsqn2MROWYsxnPTerdINdeXb2d6VDl2gHttqz+aQZasORyzi+
        TlUxPu4mZ+b9n4VfjNLbb+PT5PtlQCNAYg6fbscxU7aYrIG8BSmBrHO+yn+kbdclDNxqZV
        sBbxZI4Ppg8+OzQWUrnI6ixnZNKjUY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-bi3f3i_sOAWcUk7xxrosQA-1; Thu, 08 Oct 2020 03:03:26 -0400
X-MC-Unique: bi3f3i_sOAWcUk7xxrosQA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5984D8030A2;
        Thu,  8 Oct 2020 07:03:24 +0000 (UTC)
Received: from gondolin (ovpn-113-82.ams2.redhat.com [10.36.113.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1A35F5C1BD;
        Thu,  8 Oct 2020 07:03:21 +0000 (UTC)
Date:   Thu, 8 Oct 2020 09:03:19 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jan =?UTF-8?B?SMO2cHBuZXI=?= <hoeppner@linux.ibm.com>
Cc:     Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 08/10] s390/dasd: Display FC Endpoint Security
 information via sysfs
Message-ID: <20201008090319.4161c220.cohuck@redhat.com>
In-Reply-To: <702cf75e-5193-92d3-79a7-182ac86df16e@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-9-sth@linux.ibm.com>
        <20201006122632.098149ba.cohuck@redhat.com>
        <d88b8230-993e-d63d-394a-efcaf60f813d@linux.ibm.com>
        <20201007114928.6a088a7d.cohuck@redhat.com>
        <243fe10e-ce80-57de-a92c-3a6457cde40a@linux.ibm.com>
        <20201007184011.6dece07f.cohuck@redhat.com>
        <702cf75e-5193-92d3-79a7-182ac86df16e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 7 Oct 2020 22:10:11 +0200
Jan H=C3=B6ppner <hoeppner@linux.ibm.com> wrote:

> On 10/7/20 6:40 PM, Cornelia Huck wrote:
> > On Wed, 7 Oct 2020 16:33:37 +0200
> > Jan H=C3=B6ppner <hoeppner@linux.ibm.com> wrote:
> >  =20
> >>>>>> +static inline void dasd_path_release(struct kobject *kobj)
> >>>>>> +{
> >>>>>> +/* Memory for the dasd_path kobject is freed when dasd_free_devic=
e() is called */
> >>>>>> +}
> >>>>>> +     =20
> >>>>>
> >>>>> As already said, I don't think that's a correct way to implement th=
is.
> >>>>>      =20
> >>>>
> >>>> As you correctly pointed out, our release function doesn't do anythi=
ng.
> >>>> This is because our path data is a (static) part of our device.
> >>>> This data is critical to keep our devices operational.
> >>>> We can't simply rely on allocated memory if systems are under stress=
.    =20
> >>>
> >>> Yes, avoiding freeing and reallocating memory certainly makes sense.
> >>>    =20
> >>>>
> >>>> Having this data dynamically allocated involves a lot of rework of o=
ur
> >>>> path handling as well. There are a few things that are subject to im=
provement
> >>>> and evaluating whether our dasd_path structures can be dynamic is on=
e of
> >>>> these things. However, even then, the above concern persists and I
> >>>> highly doubt that dynamic dasd_paths objects are doable for us at th=
is
> >>>> moment.
> >>>>
> >>>> I do understand the concerns, however, we release the memory for das=
d_path
> >>>> structures eventually when dasd_free_device() is called. Until that =
point,
> >>>> the data has to be kept alive. The rest is taking care of by the kob=
ject
> >>>> library.   =20
> >>>
> >>> Yes, there doesn't seem to be any memory leakage.
> >>>    =20
> >>>> In our path handling we also make sure that we can always verify/val=
idate
> >>>> paths information even if a system is under high memory pressure. An=
other
> >>>> reason why it would contradictory for dasd_path objects to be dynami=
c.
> >>>>
> >>>> I hope this explains the reasoning behind the release function.   =20
> >>>
> >>> I understand where you're coming from.
> >>>
> >>> However, "static" kobjects (in the sense of "we may re-register the
> >>> same kobject") are still problematic. Is there any way to simply
> >>> "disappear" path objects that are not valid at the moment, or mark th=
em
> >>> as not valid?   =20
> >>
> >> You could use kobject_del(), but it is rather intended to be used for
> >> a two-stage removal of the kobject.
> >> =20
> >>>
> >>> Also, the simple act of registering/unregistering a kobject already
> >>> creates stress from its sysfs interactions... it seems you should try
> >>> to avoid that as well?
> >>>    =20
> >>
> >> We don't re-register kobjects over and over again. The kobjects are
> >> infact initialized and created only _once_. This is done either during
> >> device initialization (after dasd_eckd_read_conf() in
> >> dasd_eckd_check_characteristics()) or when a path is newly added
> >> (in the path event handler).
> >> The kobject will stay until the memory for the whole device is being
> >> freed. This is also the reason why the kobject can stay initialized and
> >> we track ourselves whether we did the initialization/creation already
> >> (which we check e.g. when a path is removed and added again).
> >> So, instead of the release function freeing the kobject data,
> >> it is done by our dasd_free_device() (same thing, different function I=
MHO).
> >>
> >> I think the concerns would be more worrisome if we'd remove/add
> >> the kobjects every time. And then I agree, we'd run into trouble.
> >> =20
> >=20
> > The thing that tripped me is
> >=20
> > +void dasd_path_remove_kobj(struct dasd_device *device, int chp)
> > +{
> > +	if (device->path[chp].in_sysfs) {
> > +		kobject_put(&device->path[chp].kobj);
> > +		device->path[chp].in_sysfs =3D false;
> > +	}
> > +}
> >=20
> > As an exported function, it is not clear where this may be called from.
> > Given your explanation above (and some more code reading on my side),
> > the code looks ok in its current incarnation (but non-idiomatic).
> >=20
> > Is there a way to check that indeed nobody re-adds a previously removed
> > path object due to a (future) programming error? And maybe add a
> > comment that you must never re-register a path? "The path is gone,
> > let's remove the object" looks quite tempting.
> >  =20
>=20
> A comment is the minimum I can think of at the moment and
> I'll prepare a fixup patch or a new version of this patch that adds
> a proper comment for this function.
> Other ways to protect the usage must be investigated.=20
> I have to discuss with Stefan what the best approach would be as the patc=
hset
> is supposed to be ready for upstream integration.
>=20
> I'd prefer a fixup patch that we could send with at least one more fixup =
patch
> that we have in the pipe already. Let's see. I hope that's fine with you
> (and Jens obviously) so far.

Fine with me. I don't really have a horse in that race; I just wanted
to look at this from a vfio-ccw perspective and then stumbled over the
kobject handling...

