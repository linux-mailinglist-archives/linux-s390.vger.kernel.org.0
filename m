Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9E65BF093
	for <lists+linux-s390@lfdr.de>; Wed, 21 Sep 2022 00:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiITWxI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Sep 2022 18:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiITWxE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 18:53:04 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9930771BC1;
        Tue, 20 Sep 2022 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663714383; x=1695250383;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sHtrOnBaxGvQ56osQFAlf1j639pK5eHVkz3K6Bavq+I=;
  b=SpbXQr2DyvbHyBx/SH9KZ6FqQYOX0f78sCmmTJctqxQ+V7xh3M+iD+Tc
   4wt8IU7uiY9fov/z+hmMh330VsljAl7WIzS+VazrKUQKLj/kopkIXg1vM
   cUOakTZYI5bSPu4zePj7dvC8TYSMtD0tr+UYCAmraI10cM9q8hHoqE/mo
   ++Acx17fJpdpuR9zyZ5YDQjf6YJzD/FsoEurWhK2xpDTQdT8p0pqgG/UH
   Squv/TTM3CDB2ZFvrSrvIAK5ZLNwGc7rSOkU0BMS5zcv9YXdL+dXzMSEH
   WKzZIkq+/jaDwAW7vObCEZVwls6YbnRAsSFva2TVWYO1C94xbbTO49ADU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10476"; a="282883237"
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="282883237"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2022 15:53:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,331,1654585200"; 
   d="scan'208";a="652283212"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP; 20 Sep 2022 15:53:00 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:53:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 15:52:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 20 Sep 2022 15:52:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 20 Sep 2022 15:52:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N7f9S92Pst3B5eHHU8ojbzvYMBFG0ainjYIvBihItDpoUn+8Qjxi1Bn63s/JIu7GET31Aa8m9wAb22nqssHSXADWtbE8B8+ySB/u1wpOIXMD4N8iEa8crkMsSqEF8UcLPV3ks78fjqC6ZXM4sguUe40xOt1k4b27cEFBz/yzqAZ05SOC6hIRxQvN1tpeIoX92ZFpKPVTvOJ5dgp9t3HEAfoh2jcr1eNnhmtT08WdaydwQNzf6NEmu3Ma1f9Fy0P3TWc4CeO7clitXzteMR3L8L4/sBjld08gcV1xozWFmtxDisK7JRcIIgXYF3EmJ7IpRTkE+yJpISK/ghsMbzkyhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kthWvXxxP5tSgw1b33n4ProbZJnXz8PXRdWbOhZFDPo=;
 b=SyXNoKuic1aJ4XSxxXTAujdIHo5sy0j5SKEOIMS5b+B33YO7LvEe/NDoq33U0F2h4LzX7DfNbLsNvlymPSeq6zIowVvEnZjkGAL2Vjhquuha0Mkp7iECXy/pqFV8I7KvjwGYSeZFIm+mGQlGu+6dLRcZQtZlblk7nfsjMeA8Hhv04QywZ4D8J6qe9MI+J2TB14PjFCi+Cp7jStMCXkT1jE2eBUeiHmtbOPS17jEGNvJ7OjR7Mky0d5ZgKJwzFsnK6h/LHaDRtRMX6sntnfF0YRPoucAJyHNSaIZduiBY04+/sXxpem9mpUdgYoMaZkcbB0MrCe7txIQ62ain+GwlLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BN9PR11MB5404.namprd11.prod.outlook.com (2603:10b6:408:11d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 22:52:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::a435:3eff:aa83:73d7%6]) with mapi id 15.20.5632.019; Tue, 20 Sep 2022
 22:52:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
CC:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        "Peter Oberparleiter" <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        "Cornelia Huck" <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        "Shameer Kolothum" <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Eric Auger <eric.auger@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v3 06/15] vfio/mtty: Use the new device life cycle helpers
Thread-Topic: [PATCH v3 06/15] vfio/mtty: Use the new device life cycle
 helpers
Thread-Index: AQHYw/jlk/cF5qgZnEulnxqLlAKI863ow0eAgAA6zIA=
Date:   Tue, 20 Sep 2022 22:52:57 +0000
Message-ID: <BN9PR11MB5276F8872ABDFAEB8A8C2AE78C4C9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220909102247.67324-1-kevin.tian@intel.com>
        <20220909102247.67324-7-kevin.tian@intel.com>
 <20220920131723.2541b7e8.alex.williamson@redhat.com>
In-Reply-To: <20220920131723.2541b7e8.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BN9PR11MB5404:EE_
x-ms-office365-filtering-correlation-id: c28dd072-8239-4b06-15db-08da9b5adc9f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ie+qd3f/1AJxyCsjLDwFVIRk7OBqhUk+s+eEH7WC202pv2CdNezFB6OLpJye/uUPDvoOKWFOereSyyVLr5yGhSdev3ICNfFEC7fWMNknSMYr6cye32LpphBGDhp8Zb57a6FFtyGYOKHSmP4pxeDFugtFDKtPpHLGePQdOu9BuIEKU8wgQSkYcp034HovDoVZLasQnXhYvMaqQU714ZbBeb9cdJrLZvMourHqdMfkkXqfNKu4GZX2O9FBxkO9DKOPUJG/a09M5FhPU/zrmveU775XrATbRn80T1QII19EpKvTnZJDYF8iZ9dcdvcPTJ/Sop5FLkaKrZhBmIj9FB3ycF2xMIOnz002cEM0b7iOH0hESzyQtGT6IbLLXY2kqKccsiJlBDQk95tHC3ZCnIm84uUTA9s23laDS63xD3d0Ue/bCak2K+r/ZUhIw9sbEZ5xE8flP6PUfnEhgc2ZzcI3jFnZMBM9bkxOtb566+UjMHwQWMq93KW1ZrrXJa/ioHHf0fFgeuH/9Rtr9ErWRsoGfOc/NnoOEKAlUIlOKB4kKVKAASXOuems/2GQsVhwtLuMAcaKx00/lPgTBGhbp3TuNwe2XK8Edc7YlyYGFEbRToEBb5AjqDe/ip3/b+Dl+9aCM2kSuq5mX52ypARSnrLF5TZ5SqqtXKy6YDlAxrzvcezw09+M49/HzniFvShCoi0Czx0g/Osfvh5SvbJ0fHOrXy0T6GIK3tb4d6wiRijBT5UMk+OvL6+X4xJzk7sL5Y5Li8Zo46nRiGEd8x74ToEClQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199015)(86362001)(7696005)(6506007)(8676002)(64756008)(66476007)(8936002)(26005)(52536014)(4326008)(38070700005)(41300700001)(66556008)(478600001)(71200400001)(66946007)(76116006)(54906003)(66446008)(33656002)(6916009)(316002)(186003)(2906002)(9686003)(83380400001)(122000001)(7406005)(7416002)(82960400001)(5660300002)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pCMg2KVcq4pw3FaK8coDO1/YSdEnCWsDadzLBOlfe+a2pZXhnbybY3/03TT4?=
 =?us-ascii?Q?jpHFnKqVMVf8i8B+ciXMJOITUVl22y9+3U+MSicaOSgCxAxAf2xBC3Dy7g+P?=
 =?us-ascii?Q?wzjCLSzMk0/LO1RE648eARBuY538DT8zk0iClaMzKls4PT8GLnBfIEaJg67r?=
 =?us-ascii?Q?MGKcRcfxP/8FS+4fqggKuLPb/V+qX/0MoiOWyYsQTC85BRg0+9I0cBN2XEMm?=
 =?us-ascii?Q?Gn0QyCMlkJ4cwHQU7ELumw0KeouC6cbzsdymRoaJABIyvFE0GsyMe3zosW49?=
 =?us-ascii?Q?ETtt0UZ2IUT6qWq3vDldFPAD9n4VyfkR0PLbU1Gw/z6tdDgbpJJ7SIP/T3nK?=
 =?us-ascii?Q?Q9B9zUspy4/vmlwYPvhxRSlCdkHPi1sHu3OYLEOW8KIwRGF0+0I54bNmaIWp?=
 =?us-ascii?Q?DGUcW2B2ciFsyeYnIvE6U7bQ8LeO+EMZ58XlcKmYiGnXcQFOvxJcwOu428kl?=
 =?us-ascii?Q?0THDIFp3Ou/4KgsV0iaFrEnQO8NVq0m4mFQa7j+BNGfZDNqQpXugxaAIPREF?=
 =?us-ascii?Q?+JNr3h9gObYWjdtxPy1GwuRhcQMPupN9RlmnaG1yFrcGcW1c7PCRzfxAGta/?=
 =?us-ascii?Q?gDLPPkhXha2dxyhnVW/SIwbNPUmodjkACnrk15lVpqV4JDw3NS9XfCSTMWKG?=
 =?us-ascii?Q?J/8T3PB1mObDOPUAmymPNjTRwoA8kuepNqrlb/B9nk6nGr3+TuYCkCwsOx5A?=
 =?us-ascii?Q?KmdTFfVa6svL9T5Fg+dSKWFnOqdtJm+QhGf3zoTt3fH//SqxNcD2ZibPaGkg?=
 =?us-ascii?Q?J2oyiYuTpQ7zZR34apXfZNDnlcOTB/Y8j81s3oS2Tq4jBzzIM91pwBLEtu3k?=
 =?us-ascii?Q?yBy+S3qf8lb5JR+144235ZQ1q5bRQ+wNbv3WxeTHMII+c+oSgg1Rnq02C1Kc?=
 =?us-ascii?Q?T9kdnsVYmVnWUdLJJ1ehQjO1ur9+uZn1AVlnJQE3ij3SyG+OGeGnj4uRnUYu?=
 =?us-ascii?Q?ZqUGHe1BVM/JSbsSr5uHBjpeqgnLxLXgr5bsO6BBBaV0b6NOOESQG+HcxqqH?=
 =?us-ascii?Q?/8DYXIgFRUT+ikVy3X+yQuYcbh5bLd6Vjzsml1ss9iaBxOaB0Ix/PX87cH5f?=
 =?us-ascii?Q?4mHd6daIaC+rtIlYuvrngimLvSn2utSQ29zfSeM0w08LUatsdjdm7JbZMdwN?=
 =?us-ascii?Q?LsCgXGaf4gVqVAWK4bZikQW6ceiL6pG72wc4ELr073yFJ+KxoKnY/WpesSQm?=
 =?us-ascii?Q?zBo0dUWm9VwKQnfrr5aWDLDD1Lzs+vQPFxYzkySOYEgrF7GrFM3bWr5ZIpYS?=
 =?us-ascii?Q?7IcboInkHSRB26CLrfRQ9U8F/qa72Wt3Kz6xA8ivAQYCvasgN/3GJZ2nKX4I?=
 =?us-ascii?Q?XUVvnGAQh7FsXKzWy418rh3ovBGz+BR7rWp2RC2l9wBfaotfCkllq3I8zmSw?=
 =?us-ascii?Q?0lmpzYJxZx0RCrnctirsw79GyplS+fdXEfyIMoCwXKyyFpILn4j4H5n/i4R1?=
 =?us-ascii?Q?YssVLhp3Neeck/zTi4F1vDXoLETZxTzHg4kYKTIPhqLuFM8W9c0HStKXpz1t?=
 =?us-ascii?Q?/LILLY24C8lCb/PxE0xExt5eZu2WDgfID0e+ednENjSH18j/UtVkJJOBh3OE?=
 =?us-ascii?Q?8CyD5XjfnyIgBvKL4FoX5qFemSYRkYf6Quroo+RH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c28dd072-8239-4b06-15db-08da9b5adc9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 22:52:57.6809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XVnvjlRAvyWUgFS6YaGk2enEuJdQsvYtFFHBvDhTt/Ayi4E75IqNUK2y+037DeAPgd/lIqene+gqfZ9Qe8iyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, September 21, 2022 3:17 AM
>=20
> On Fri,  9 Sep 2022 18:22:38 +0800
> Kevin Tian <kevin.tian@intel.com> wrote:
>=20
> > From: Yi Liu <yi.l.liu@intel.com>
> >
> > and manage available ports inside @init/@release.
> >
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  samples/vfio-mdev/mtty.c | 67 +++++++++++++++++++++++-----------------
> >  1 file changed, 39 insertions(+), 28 deletions(-)
> >
> > diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> > index f42a59ed2e3f..41301d50b247 100644
> > --- a/samples/vfio-mdev/mtty.c
> > +++ b/samples/vfio-mdev/mtty.c
> ...
> > +static int mtty_probe(struct mdev_device *mdev)
> > +{
> > +	struct mdev_state *mdev_state;
> > +	int ret;
> > +
> > +	mdev_state =3D vfio_alloc_device(mdev_state, vdev, &mdev->dev,
> > +				       &mtty_dev_ops);
> > +	if (IS_ERR(mdev_state))
> > +		return PTR_ERR(mdev_state);
> >
> >  	ret =3D vfio_register_emulated_iommu_dev(&mdev_state->vdev);
> >  	if (ret)
> > -		goto err_vconfig;
> > +		goto err_put_vdev;
> >  	dev_set_drvdata(&mdev->dev, mdev_state);
> >  	return 0;
> >
> > -err_vconfig:
> > -	kfree(mdev_state->vconfig);
> > -err_state:
> > -	vfio_uninit_group_dev(&mdev_state->vdev);
> > -	kfree(mdev_state);
> > -err_nr_ports:
> > -	atomic_add(nr_ports, &mdev_avail_ports);
> > +err_put_vdev:
> > +	vfio_put_device(&mdev_state->vdev);
> >  	return ret;
> >  }
> >
> > +static void mtty_release_dev(struct vfio_device *vdev)
> > +{
> > +	struct mdev_state *mdev_state =3D
> > +		container_of(vdev, struct mdev_state, vdev);
> > +
> > +	kfree(mdev_state->vconfig);
> > +	vfio_free_device(vdev);
> > +	atomic_add(mdev_state->nr_ports, &mdev_avail_ports);
>=20
> I must be missing something, isn't this a use-after-free?

Yes, it's a use-after-free indeed. Thanks for catching it!

>=20
> mdev_state is allocated via vfio_alloc_device(), where vdev is the
> first entry in that structure, so this is equivalent to
> kvfree(mdev_state).  mbochs has the same issue.  mdpy and vfio-ap
> adjust global counters after vfio_free_device(), which I think muddies
> the situation.  Shouldn't we look suspiciously at any .release callback
> where vfio_free_device() isn't the last thing executed?  Thanks,
>=20

Yes. I'll scrutinize it again. To be consistent I'll make sure the free
is the last line in all .release callbacks though not required for
some (e.g. mdpy and vfio-ap).
