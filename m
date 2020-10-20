Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92868284E24
	for <lists+linux-s390@lfdr.de>; Tue,  6 Oct 2020 16:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJFOhU (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 6 Oct 2020 10:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49562 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJFOhT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Oct 2020 10:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601995038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6ZIZjbt2o77S85jvqak2MaI7uEyyGCg0A60HU2GrFU=;
        b=EuLaJYr1jGPb6IuHm3BIdjwAsPNisqmzmbyof2z1X5NuV3/cn/mlXX06O48BkX62+A8oNo
        knYdmUK3lVXbtetmb09/8+XUjOx8xQ8JKynuUOU2KFm6jJTd7SjO2xEr3VzHDThsIcZBu/
        mUe8vtjIfsjRYaewS2L2rhGfULi99bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-tAhbLo59OVuBEubgeYhBUg-1; Tue, 06 Oct 2020 10:37:14 -0400
X-MC-Unique: tAhbLo59OVuBEubgeYhBUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C335C80401A;
        Tue,  6 Oct 2020 14:37:12 +0000 (UTC)
Received: from gondolin (ovpn-112-156.ams2.redhat.com [10.36.112.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D0D8A6115F;
        Tue,  6 Oct 2020 14:37:10 +0000 (UTC)
Date:   Tue, 6 Oct 2020 16:37:07 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, vneethv@linux.vnet.ibm.com
Subject: Re: [PATCH 01/10] s390/cio: Export information about
 Endpoint-Security Capability
Message-ID: <20201006163707.0bd1b90a.cohuck@redhat.com>
In-Reply-To: <153dde83-0f87-69d4-df65-a43342f5fc8e@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-2-sth@linux.ibm.com>
        <20201006114656.6b1a97b1.cohuck@redhat.com>
        <153dde83-0f87-69d4-df65-a43342f5fc8e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 6 Oct 2020 16:23:36 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Hi,
>=20
> talked to Vineeth, here is his answer...
>=20
> Am 06.10.20 um 11:46 schrieb Cornelia Huck:
> > On Fri,  2 Oct 2020 21:39:31 +0200
> > Stefan Haberland <sth@linux.ibm.com> wrote:
> > =20
> >> From: Sebastian Ott <sebott@linux.ibm.com>
> >>
> >> Add a new sysfs attribute 'esc' per chpid. This new attribute exports
> >> the Endpoint-Security-Capability byte of channel-path description bloc=
k,
> >> which could be 0-None, 1-Authentication, 2 and 3-Encryption.
> >>
> >> For example:
> >> $ cat /sys/devices/css0/chp0.34/esc
> >> 0
> >>
> >> Reference-ID: IO1812
> >> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> >> [vneethv@linux.ibm.com: cleaned-up & modified description]
> >> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> >> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> >> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> >> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> >> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> >> ---
> >>  drivers/s390/cio/chp.c  | 15 +++++++++++++++
> >>  drivers/s390/cio/chsc.h |  3 ++-
> >>  2 files changed, 17 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
> >> index dfcbe54591fb..8d0de6adcad0 100644
> >> --- a/drivers/s390/cio/chp.c
> >> +++ b/drivers/s390/cio/chp.c
> >> @@ -384,6 +384,20 @@ static ssize_t chp_chid_external_show(struct devi=
ce *dev,
> >>  }
> >>  static DEVICE_ATTR(chid_external, 0444, chp_chid_external_show, NULL);
> >> =20
> >> +static ssize_t chp_esc_show(struct device *dev,
> >> +			    struct device_attribute *attr, char *buf)
> >> +{
> >> +	struct channel_path *chp =3D to_channelpath(dev);
> >> +	ssize_t rc;
> >> +
> >> +	mutex_lock(&chp->lock);
> >> +	rc =3D sprintf(buf, "%x\n", chp->desc_fmt1.esc); =20
> > I'm wondering: Do we need to distinguish between '0' =3D=3D 'no esc, and
> > the hardware says so' and '0' =3D=3D 'the chsc to get that information =
is
> > not supported'? I see that for the chid the code checks for a flag in
> > desc_fmt1, and I indeed see that nothing is displayed for
> > chid/chid_external when I run under QEMU. =20
>=20
> ESC=3D=3D0 due to 'missing support for the required CHSC information' is
> just another symptom of "unsupported" because the CSS firmware code
> doesn't bring the required support.
> Also, not sure if there is any flag/value which provide this
> distinction. So we think having 2 different values "Unknown" and
> "Unsupported" is not required in this scenario.
>=20
> So, we kept a single "ESC=3D=3D0" which indicates "Unsupported", but as y=
ou
> mentioned, in different levels.

Ok, that makes sense, also considering how this is used later on.

>=20
> >> +	mutex_unlock(&chp->lock);
> >> +
> >> +	return rc;
> >> +}
> >> +static DEVICE_ATTR(esc, 0444, chp_esc_show, NULL);
> >> +
> >>  static ssize_t util_string_read(struct file *filp, struct kobject *ko=
bj,
> >>  				struct bin_attribute *attr, char *buf,
> >>  				loff_t off, size_t count) =20
> > (...)
> > =20
>=20
>=20

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

