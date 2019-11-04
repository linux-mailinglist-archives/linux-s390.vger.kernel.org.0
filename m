Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E05D6EEBBA
	for <lists+linux-s390@lfdr.de>; Mon,  4 Nov 2019 22:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbfKDVui (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 4 Nov 2019 16:50:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47319 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387755AbfKDVuh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 16:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572904236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W3lmpgT5tPkT29wU4MchKPccsewSX6lb1B5aFRAHrjA=;
        b=LVVU1U8RilXtMI9PkDdTyHxM0SVWW6KCi8mpo608UXeQZhUfXoKroCg0RYB4G3VpklEtha
        3rfrdDTJ0r46KOeBWHHDbsjDh7viqtrFI8BeMshx/eL0AxNWKS0B+ROIK++7jaD6LYRo9v
        9lwPr96rhPwuihIFeERDV9Rd4vBtirA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-AO8n43n_Nrq6fre6MQDThg-1; Mon, 04 Nov 2019 16:50:33 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 799DD1005500;
        Mon,  4 Nov 2019 21:50:29 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49CE85C1B2;
        Mon,  4 Nov 2019 21:50:03 +0000 (UTC)
Date:   Mon, 4 Nov 2019 14:50:02 -0700
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
Subject: Re: [PATCH V7 1/6] mdev: class id support
Message-ID: <20191104145002.4dfed0c4@x1.home>
In-Reply-To: <20191104123952.17276-2-jasowang@redhat.com>
References: <20191104123952.17276-1-jasowang@redhat.com>
        <20191104123952.17276-2-jasowang@redhat.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: AO8n43n_Nrq6fre6MQDThg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  4 Nov 2019 20:39:47 +0800
Jason Wang <jasowang@redhat.com> wrote:

> Mdev bus only supports vfio driver right now, so it doesn't implement
> match method. But in the future, we may add drivers other than vfio,
> the first driver could be virtio-mdev. This means we need to add
> device class id support in bus match method to pair the mdev device
> and mdev driver correctly.
>=20
> So this patch adds id_table to mdev_driver and class_id for mdev
> device with the match method for mdev bus.
>=20
> Reviewed-by: Parav Pandit <parav@mellanox.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  .../driver-api/vfio-mediated-device.rst       |  5 ++++
>  drivers/gpu/drm/i915/gvt/kvmgt.c              |  1 +
>  drivers/s390/cio/vfio_ccw_ops.c               |  1 +
>  drivers/s390/crypto/vfio_ap_ops.c             |  1 +
>  drivers/vfio/mdev/mdev_core.c                 | 16 ++++++++++++
>  drivers/vfio/mdev/mdev_driver.c               | 25 +++++++++++++++++++
>  drivers/vfio/mdev/mdev_private.h              |  1 +
>  drivers/vfio/mdev/vfio_mdev.c                 |  6 +++++
>  include/linux/mdev.h                          |  8 ++++++
>  include/linux/mod_devicetable.h               |  8 ++++++
>  samples/vfio-mdev/mbochs.c                    |  1 +
>  samples/vfio-mdev/mdpy.c                      |  1 +
>  samples/vfio-mdev/mtty.c                      |  1 +
>  13 files changed, 75 insertions(+)
>=20
> diff --git a/Documentation/driver-api/vfio-mediated-device.rst b/Document=
ation/driver-api/vfio-mediated-device.rst
> index 25eb7d5b834b..6709413bee29 100644
> --- a/Documentation/driver-api/vfio-mediated-device.rst
> +++ b/Documentation/driver-api/vfio-mediated-device.rst
> @@ -102,12 +102,14 @@ structure to represent a mediated device's driver::
>        * @probe: called when new device created
>        * @remove: called when device removed
>        * @driver: device driver structure
> +      * @id_table: the ids serviced by this driver
>        */
>       struct mdev_driver {
>  =09     const char *name;
>  =09     int  (*probe)  (struct device *dev);
>  =09     void (*remove) (struct device *dev);
>  =09     struct device_driver    driver;
> +=09     const struct mdev_class_id *id_table;
>       };
> =20
>  A mediated bus driver for mdev should use this structure in the function=
 calls
> @@ -170,6 +172,9 @@ that a driver should use to unregister itself with th=
e mdev core driver::
> =20
>  =09extern void mdev_unregister_device(struct device *dev);
> =20
> +It is also required to specify the class_id in create() callback through=
::
> +
> +=09int mdev_set_class(struct mdev_device *mdev, u16 id);
> =20
>  Mediated Device Management Interface Through sysfs
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index 343d79c1cb7e..6420f0dbd31b 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -678,6 +678,7 @@ static int intel_vgpu_create(struct kobject *kobj, st=
ruct mdev_device *mdev)
>  =09=09     dev_name(mdev_dev(mdev)));
>  =09ret =3D 0;
> =20
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  out:
>  =09return ret;
>  }
> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index f0d71ab77c50..cf2c013ae32f 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -129,6 +129,7 @@ static int vfio_ccw_mdev_create(struct kobject *kobj,=
 struct mdev_device *mdev)
>  =09=09=09   private->sch->schid.ssid,
>  =09=09=09   private->sch->schid.sch_no);
> =20
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  =09return 0;
>  }
> =20
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio=
_ap_ops.c
> index 5c0f53c6dde7..07c31070afeb 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -343,6 +343,7 @@ static int vfio_ap_mdev_create(struct kobject *kobj, =
struct mdev_device *mdev)
>  =09list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
>  =09mutex_unlock(&matrix_dev->lock);
> =20
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  =09return 0;
>  }
> =20
> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.=
c
> index b558d4cfd082..d23ca39e3be6 100644
> --- a/drivers/vfio/mdev/mdev_core.c
> +++ b/drivers/vfio/mdev/mdev_core.c
> @@ -45,6 +45,16 @@ void mdev_set_drvdata(struct mdev_device *mdev, void *=
data)
>  }
>  EXPORT_SYMBOL(mdev_set_drvdata);
> =20
> +/* Specify the class for the mdev device, this must be called during
> + * create() callback.
> + */

Standard non-networking multi-line comment style please, ie.

/*
 * Multi-
 * line
 * comment
 */

Thanks,
Alex

> +void mdev_set_class(struct mdev_device *mdev, u16 id)
> +{
> +=09WARN_ON(mdev->class_id);
> +=09mdev->class_id =3D id;
> +}
> +EXPORT_SYMBOL(mdev_set_class);
> +
>  struct device *mdev_dev(struct mdev_device *mdev)
>  {
>  =09return &mdev->dev;
> @@ -324,6 +334,12 @@ int mdev_device_create(struct kobject *kobj,
>  =09if (ret)
>  =09=09goto ops_create_fail;
> =20
> +=09if (!mdev->class_id) {
> +=09=09ret =3D -EINVAL;
> +=09=09dev_warn(dev, "mdev vendor driver failed to specify device class\n=
");
> +=09=09goto add_fail;
> +=09}
> +
>  =09ret =3D device_add(&mdev->dev);
>  =09if (ret)
>  =09=09goto add_fail;
> diff --git a/drivers/vfio/mdev/mdev_driver.c b/drivers/vfio/mdev/mdev_dri=
ver.c
> index 0d3223aee20b..ed06433693e8 100644
> --- a/drivers/vfio/mdev/mdev_driver.c
> +++ b/drivers/vfio/mdev/mdev_driver.c
> @@ -69,8 +69,33 @@ static int mdev_remove(struct device *dev)
>  =09return 0;
>  }
> =20
> +static int mdev_match(struct device *dev, struct device_driver *drv)
> +{
> +=09unsigned int i;
> +=09struct mdev_device *mdev =3D to_mdev_device(dev);
> +=09struct mdev_driver *mdrv =3D to_mdev_driver(drv);
> +=09const struct mdev_class_id *ids =3D mdrv->id_table;
> +
> +=09if (!ids)
> +=09=09return 0;
> +
> +=09for (i =3D 0; ids[i].id; i++)
> +=09=09if (ids[i].id =3D=3D mdev->class_id)
> +=09=09=09return 1;
> +=09return 0;
> +}
> +
> +static int mdev_uevent(struct device *dev, struct kobj_uevent_env *env)
> +{
> +=09struct mdev_device *mdev =3D to_mdev_device(dev);
> +
> +=09return add_uevent_var(env, "MODALIAS=3Dmdev:c%02X", mdev->class_id);
> +}
> +
>  struct bus_type mdev_bus_type =3D {
>  =09.name=09=09=3D "mdev",
> +=09.match=09=09=3D mdev_match,
> +=09.uevent=09=09=3D mdev_uevent,
>  =09.probe=09=09=3D mdev_probe,
>  =09.remove=09=09=3D mdev_remove,
>  };
> diff --git a/drivers/vfio/mdev/mdev_private.h b/drivers/vfio/mdev/mdev_pr=
ivate.h
> index 7d922950caaf..c65f436c1869 100644
> --- a/drivers/vfio/mdev/mdev_private.h
> +++ b/drivers/vfio/mdev/mdev_private.h
> @@ -33,6 +33,7 @@ struct mdev_device {
>  =09struct kobject *type_kobj;
>  =09struct device *iommu_device;
>  =09bool active;
> +=09u16 class_id;
>  };
> =20
>  #define to_mdev_device(dev)=09container_of(dev, struct mdev_device, dev)
> diff --git a/drivers/vfio/mdev/vfio_mdev.c b/drivers/vfio/mdev/vfio_mdev.=
c
> index 30964a4e0a28..38431e9ef7f5 100644
> --- a/drivers/vfio/mdev/vfio_mdev.c
> +++ b/drivers/vfio/mdev/vfio_mdev.c
> @@ -120,10 +120,16 @@ static void vfio_mdev_remove(struct device *dev)
>  =09vfio_del_group_dev(dev);
>  }
> =20
> +static const struct mdev_class_id vfio_id_table[] =3D {
> +=09{ MDEV_CLASS_ID_VFIO },
> +=09{ 0 },
> +};
> +
>  static struct mdev_driver vfio_mdev_driver =3D {
>  =09.name=09=3D "vfio_mdev",
>  =09.probe=09=3D vfio_mdev_probe,
>  =09.remove=09=3D vfio_mdev_remove,
> +=09.id_table =3D vfio_id_table,
>  };
> =20
>  static int __init vfio_mdev_init(void)
> diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> index 0ce30ca78db0..78b69d09eb54 100644
> --- a/include/linux/mdev.h
> +++ b/include/linux/mdev.h
> @@ -118,6 +118,7 @@ struct mdev_type_attribute mdev_type_attr_##_name =3D=
=09=09\
>   * @probe: called when new device created
>   * @remove: called when device removed
>   * @driver: device driver structure
> + * @id_table: the ids serviced by this driver
>   *
>   **/
>  struct mdev_driver {
> @@ -125,6 +126,7 @@ struct mdev_driver {
>  =09int  (*probe)(struct device *dev);
>  =09void (*remove)(struct device *dev);
>  =09struct device_driver driver;
> +=09const struct mdev_class_id *id_table;
>  };
> =20
>  #define to_mdev_driver(drv)=09container_of(drv, struct mdev_driver, driv=
er)
> @@ -132,6 +134,7 @@ struct mdev_driver {
>  void *mdev_get_drvdata(struct mdev_device *mdev);
>  void mdev_set_drvdata(struct mdev_device *mdev, void *data);
>  const guid_t *mdev_uuid(struct mdev_device *mdev);
> +void mdev_set_class(struct mdev_device *mdev, u16 id);
> =20
>  extern struct bus_type mdev_bus_type;
> =20
> @@ -145,4 +148,9 @@ struct device *mdev_parent_dev(struct mdev_device *md=
ev);
>  struct device *mdev_dev(struct mdev_device *mdev);
>  struct mdev_device *mdev_from_dev(struct device *dev);
> =20
> +enum {
> +=09MDEV_CLASS_ID_VFIO =3D 1,
> +=09/* New entries must be added here */
> +};
> +
>  #endif /* MDEV_H */
> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_deviceta=
ble.h
> index 5714fd35a83c..f32c6e44fb1a 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -821,4 +821,12 @@ struct wmi_device_id {
>  =09const void *context;
>  };
> =20
> +/**
> + * struct mdev_class_id - MDEV device class identifier
> + * @id: Used to identify a specific class of device, e.g vfio-mdev devic=
e.
> + */
> +struct mdev_class_id {
> +=09__u16 id;
> +};
> +
>  #endif /* LINUX_MOD_DEVICETABLE_H */
> diff --git a/samples/vfio-mdev/mbochs.c b/samples/vfio-mdev/mbochs.c
> index ac5c8c17b1ff..115bc5074656 100644
> --- a/samples/vfio-mdev/mbochs.c
> +++ b/samples/vfio-mdev/mbochs.c
> @@ -561,6 +561,7 @@ static int mbochs_create(struct kobject *kobj, struct=
 mdev_device *mdev)
>  =09mbochs_reset(mdev);
> =20
>  =09mbochs_used_mbytes +=3D type->mbytes;
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  =09return 0;
> =20
>  err_mem:
> diff --git a/samples/vfio-mdev/mdpy.c b/samples/vfio-mdev/mdpy.c
> index cc86bf6566e4..665614574d50 100644
> --- a/samples/vfio-mdev/mdpy.c
> +++ b/samples/vfio-mdev/mdpy.c
> @@ -269,6 +269,7 @@ static int mdpy_create(struct kobject *kobj, struct m=
dev_device *mdev)
>  =09mdpy_reset(mdev);
> =20
>  =09mdpy_count++;
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  =09return 0;
>  }
> =20
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index ce84a300a4da..90da12ff7fd9 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -755,6 +755,7 @@ static int mtty_create(struct kobject *kobj, struct m=
dev_device *mdev)
>  =09list_add(&mdev_state->next, &mdev_devices_list);
>  =09mutex_unlock(&mdev_list_lock);
> =20
> +=09mdev_set_class(mdev, MDEV_CLASS_ID_VFIO);
>  =09return 0;
>  }
> =20

