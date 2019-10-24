Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4DDEE3CE1
	for <lists+linux-s390@lfdr.de>; Thu, 24 Oct 2019 22:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfJXUN5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 24 Oct 2019 16:13:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbfJXUN4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 24 Oct 2019 16:13:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571948034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4okx/0WuIUvMfg3eEWnxYk0ixrLOf5XkOoO4HYGvUSc=;
        b=CcowxEp76u4o2+LJHaVkifTvVhXq9l0etw3ahWCmEA57nC2nJELvMsGLK3SsIGVpOVe14R
        MgqF7eG9YjwxX037i8AjdI58wBXOomVwBFu3iAGee3x+zQUWPhjHA8NpPNx1jeNkmUDO/A
        DbAwMeRqj5OqWuD4Y6kDKMZ8VQ2CjG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-5KVeD95sOy2OSN9aLjwQqQ-1; Thu, 24 Oct 2019 16:13:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4CA1800DC7;
        Thu, 24 Oct 2019 20:13:49 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 971AE4530;
        Thu, 24 Oct 2019 20:13:31 +0000 (UTC)
Date:   Thu, 24 Oct 2019 14:13:30 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        mst@redhat.com, tiwei.bie@intel.com,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        cohuck@redhat.com, maxime.coquelin@redhat.com,
        cunming.liang@intel.com, zhihong.wang@intel.com,
        rob.miller@broadcom.com, xiao.w.wang@intel.com,
        haotian.wang@sifive.com, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, farman@linux.ibm.com,
        pasic@linux.ibm.com, sebott@linux.ibm.com, oberpar@linux.ibm.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, akrowiak@linux.ibm.com,
        freude@linux.ibm.com, lingshan.zhu@intel.com, idos@mellanox.com,
        eperezma@redhat.com, lulu@redhat.com, parav@mellanox.com,
        christophe.de.dinechin@gmail.com, kevin.tian@intel.com,
        stefanha@redhat.com
Subject: Re: [PATCH V5 1/6] mdev: class id support
Message-ID: <20191024141330.017a6480@x1.home>
In-Reply-To: <20191024134636.253131c5@x1.home>
References: <20191023130752.18980-1-jasowang@redhat.com>
        <20191023130752.18980-2-jasowang@redhat.com>
        <20191023154204.31d74866@x1.home>
        <38bdf762-524a-e0f1-6e9a-1102adfe8fb1@redhat.com>
        <20191024134636.253131c5@x1.home>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 5KVeD95sOy2OSN9aLjwQqQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 24 Oct 2019 13:46:36 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 24 Oct 2019 11:27:36 +0800
> Jason Wang <jasowang@redhat.com> wrote:
>=20
> > On 2019/10/24 =E4=B8=8A=E5=8D=885:42, Alex Williamson wrote: =20
> > > On Wed, 23 Oct 2019 21:07:47 +0800
> > > Jason Wang <jasowang@redhat.com> wrote:
> > >   =20
> > >> Mdev bus only supports vfio driver right now, so it doesn't implemen=
t
> > >> match method. But in the future, we may add drivers other than vfio,
> > >> the first driver could be virtio-mdev. This means we need to add
> > >> device class id support in bus match method to pair the mdev device
> > >> and mdev driver correctly.
> > >>
> > >> So this patch adds id_table to mdev_driver and class_id for mdev
> > >> device with the match method for mdev bus.
> > >>
> > >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > >> ---
> > >>   .../driver-api/vfio-mediated-device.rst       |  5 +++++
> > >>   drivers/gpu/drm/i915/gvt/kvmgt.c              |  1 +
> > >>   drivers/s390/cio/vfio_ccw_ops.c               |  1 +
> > >>   drivers/s390/crypto/vfio_ap_ops.c             |  1 +
> > >>   drivers/vfio/mdev/mdev_core.c                 | 18 +++++++++++++++
> > >>   drivers/vfio/mdev/mdev_driver.c               | 22 +++++++++++++++=
++++
> > >>   drivers/vfio/mdev/mdev_private.h              |  1 +
> > >>   drivers/vfio/mdev/vfio_mdev.c                 |  6 +++++
> > >>   include/linux/mdev.h                          |  8 +++++++
> > >>   include/linux/mod_devicetable.h               |  8 +++++++
> > >>   samples/vfio-mdev/mbochs.c                    |  1 +
> > >>   samples/vfio-mdev/mdpy.c                      |  1 +
> > >>   samples/vfio-mdev/mtty.c                      |  1 +
> > >>   13 files changed, 74 insertions(+)
> > >>
> > >> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Doc=
umentation/driver-api/vfio-mediated-device.rst
> > >> index 25eb7d5b834b..6709413bee29 100644
> > >> --- a/Documentation/driver-api/vfio-mediated-device.rst
> > >> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> > >> @@ -102,12 +102,14 @@ structure to represent a mediated device's dri=
ver::
> > >>         * @probe: called when new device created
> > >>         * @remove: called when device removed
> > >>         * @driver: device driver structure
> > >> +      * @id_table: the ids serviced by this driver
> > >>         */
> > >>        struct mdev_driver {
> > >>   =09     const char *name;
> > >>   =09     int  (*probe)  (struct device *dev);
> > >>   =09     void (*remove) (struct device *dev);
> > >>   =09     struct device_driver    driver;
> > >> +=09     const struct mdev_class_id *id_table;
> > >>        };
> > >>  =20
> > >>   A mediated bus driver for mdev should use this structure in the fu=
nction calls
> > >> @@ -170,6 +172,9 @@ that a driver should use to unregister itself wi=
th the mdev core driver::
> > >>  =20
> > >>   =09extern void mdev_unregister_device(struct device *dev);
> > >>  =20
> > >> +It is also required to specify the class_id in create() callback th=
rough::
> > >> +
> > >> +=09int mdev_set_class(struct mdev_device *mdev, u16 id);
> > >>  =20
> > >>   Mediated Device Management Interface Through sysfs
> > >>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> > >> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915=
/gvt/kvmgt.c
> > >> index 343d79c1cb7e..6420f0dbd31b 100644
> > >> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> > >> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> > >> @@ -678,6 +678,7 @@ static int intel_vgpu_create(struct kobject *kob=
j, struct mdev_device *mdev)
> > >>   =09=09     dev_name(mdev_dev(mdev)));
> > >>   =09ret =3D 0;
> > >>  =20
> > >> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
> > >>   out:
> > >>   =09return ret;
> > >>   }
> > >> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio=
_ccw_ops.c
> > >> index f0d71ab77c50..cf2c013ae32f 100644
> > >> --- a/drivers/s390/cio/vfio_ccw_ops.c
> > >> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> > >> @@ -129,6 +129,7 @@ static int vfio_ccw_mdev_create(struct kobject *=
kobj, struct mdev_device *mdev)
> > >>   =09=09=09   private->sch->schid.ssid,
> > >>   =09=09=09   private->sch->schid.sch_no);
> > >>  =20
> > >> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
> > >>   =09return 0;
> > >>   }
> > >>  =20
> > >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto=
/vfio_ap_ops.c
> > >> index 5c0f53c6dde7..07c31070afeb 100644
> > >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> > >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> > >> @@ -343,6 +343,7 @@ static int vfio_ap_mdev_create(struct kobject *k=
obj, struct mdev_device *mdev)
> > >>   =09list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
> > >>   =09mutex_unlock(&matrix_dev->lock);
> > >>  =20
> > >> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
> > >>   =09return 0;
> > >>   }
> > >>  =20
> > >> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_=
core.c
> > >> index b558d4cfd082..3a9c52d71b4e 100644
> > >> --- a/drivers/vfio/mdev/mdev_core.c
> > >> +++ b/drivers/vfio/mdev/mdev_core.c
> > >> @@ -45,6 +45,16 @@ void mdev_set_drvdata(struct mdev_device *mdev, v=
oid *data)
> > >>   }
> > >>   EXPORT_SYMBOL(mdev_set_drvdata);
> > >>  =20
> > >> +/* Specify the class for the mdev device, this must be called durin=
g
> > >> + * create() callback.
> > >> + */
> > >> +void mdev_set_class(struct mdev_device *mdev, u16 id)
> > >> +{
> > >> +=09WARN_ON(mdev->class_id);
> > >> +=09mdev->class_id =3D id;
> > >> +}
> > >> +EXPORT_SYMBOL(mdev_set_class);
> > >> +
> > >>   struct device *mdev_dev(struct mdev_device *mdev)
> > >>   {
> > >>   =09return &mdev->dev;
> > >> @@ -135,6 +145,7 @@ static int mdev_device_remove_cb(struct device *=
dev, void *data)
> > >>    * mdev_register_device : Register a device
> > >>    * @dev: device structure representing parent device.
> > >>    * @ops: Parent device operation structure to be registered.
> > >> + * @id: class id.
> > >>    *
> > >>    * Add device to list of registered parent devices.
> > >>    * Returns a negative value on error, otherwise 0.
> > >> @@ -324,6 +335,13 @@ int mdev_device_create(struct kobject *kobj,
> > >>   =09if (ret)
> > >>   =09=09goto ops_create_fail;
> > >>  =20
> > >> +=09if (!mdev->class_id) {
> > >> +=09=09ret =3D -EINVAL;
> > >> +=09=09WARN(1, "class id must be specified for device %s\n",
> > >> +=09=09     dev_name(dev));   =20
> > > Nit, dev_warn(dev, "mdev vendor driver failed to specify device class=
\n");   =20
> >=20
> >=20
> > Will fix.
> >=20
> >  =20
> > >   =20
> > >> +=09=09goto add_fail;
> > >> +=09}
> > >> +
> > >>   =09ret =3D device_add(&mdev->dev);
> > >>   =09if (ret)
> > >>   =09=09goto add_fail;
> > >> diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mde=
v_driver.c
> > >> index 0d3223aee20b..319d886ffaf7 100644
> > >> --- a/drivers/vfio/mdev/mdev_driver.c
> > >> +++ b/drivers/vfio/mdev/mdev_driver.c
> > >> @@ -69,8 +69,30 @@ static int mdev_remove(struct device *dev)
> > >>   =09return 0;
> > >>   }
> > >>  =20
> > >> +static int mdev_match(struct device *dev, struct device_driver *drv=
)
> > >> +{
> > >> +=09unsigned int i;
> > >> +=09struct mdev_device *mdev =3D to_mdev_device(dev);
> > >> +=09struct mdev_driver *mdrv =3D to_mdev_driver(drv);
> > >> +=09const struct mdev_class_id *ids =3D mdrv->id_table;
> > >> +   =20
> > > Nit, as we start to allow new mdev bus drivers, mdev-core might want =
to
> > > protect itself from a NULL id_table, by either failing the
> > > mdev_register_driver() or failing the match here.  I think such a
> > > condition would segfault as written here, but clearly we don't have
> > > such external drivers yet.  Thanks,   =20
> >=20
> >=20
> > I'm not sure I get the point here. My understanding is that mdev-core=
=20
> > won't try to be matched here since it was not a complete mdev device. =
=20
>=20
> The parent driver failing to set a type vs the parent driver failing to

Correction, the second half of this should be in reference to the mdev
bus driver.

> register with a struct mdev_driver where id_table is not null are
> different issues.  I agree that if a vendor driver was not updated for
> this series that they'd never successfully create a device because the
> mdev-core would reject it for not setting a class, but mdev_match() is
> called for devices that might be created by other vendor drivers, so
> loading a parent driver with a null id_table potentially breaks
> matching for everyone.  Thanks,

The point is still valid though, for example if vfio-mdev registered
with a null id_table it would break matching for virtio-mdev depending
on the order we iterate through drivers as we call mdev_match().
Thanks,

Alex

