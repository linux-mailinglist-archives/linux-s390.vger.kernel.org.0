Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259C6BD855
	for <lists+linux-s390@lfdr.de>; Thu, 16 Mar 2023 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCPSqY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Mar 2023 14:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCPSqX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Mar 2023 14:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05362C488D
        for <linux-s390@vger.kernel.org>; Thu, 16 Mar 2023 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678992337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msB9Vqg/JhQndpd4enpDX7wLYe89HC8KUPhwlSyu4MY=;
        b=WrmhEXbU8HLMSl9awJvhs0nssanGBPPYUMVsQIfNbSgPVYEi9Vj+XWK27eGrgDR420UfiH
        a4mkcXWRTBmVWarWrClmx9WlXCCZDWGbBQeusgi9cK4sV2ZLZL6Re/rO3PDuoTP6UN1Vkc
        rgrtQh6meR0lKQp+R8OTBrXwKdFgFlU=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-NHqBV4OoMwKsc9vGca4WxQ-1; Thu, 16 Mar 2023 14:45:36 -0400
X-MC-Unique: NHqBV4OoMwKsc9vGca4WxQ-1
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e0212ce00b0031d17f33e9aso1259577ilm.7
        for <linux-s390@vger.kernel.org>; Thu, 16 Mar 2023 11:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678992336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msB9Vqg/JhQndpd4enpDX7wLYe89HC8KUPhwlSyu4MY=;
        b=4mc0JN6qjii6amx/6WW5E0PPl4A3fVqRKt4VqxJBMepv/I/wPosWvyA7pksk7rCAOZ
         0dhvfVzaUNGbYd7ZCxeRrnEheVxnYw/6kTQx2/m/RglmHPNhMZyHskrHhTlmv98upX8j
         DQKuKY1WBNtfGP96OzsKDoG+Yk1iHKhaQwXuINjFbtQZdsqlp1Dk/60sHZpCyxvu1tur
         OduE86N7NTV3Vuq75d5k97alZIKgFvsc3qbtQz/wcfP9wzY8Mrqba4YfQ3zh5ACakidw
         qHEKGXZWIQ5pBvB1fXQ61J6Uycb70Nc+JchVWoSn0ZYNBD1W0RohWtmLljx2A69s8iiA
         xr6Q==
X-Gm-Message-State: AO0yUKWHuh1uU3/b7GnFpRL6zyJUOlyeD3sQVvdFqqG7dxUqESY92dLb
        Egy+UMCuhC+Pk/Gq2TUL7OjSJPpIbFIdcPY9yYtHXCdCx26caWRwtYzRFkulICnQcVdCj2Opejy
        oJhJRpMx59j5GjCFMILR8MA==
X-Received: by 2002:a92:d091:0:b0:315:365d:534f with SMTP id h17-20020a92d091000000b00315365d534fmr8191874ilh.19.1678992335754;
        Thu, 16 Mar 2023 11:45:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set9qQgqeAlftnpNauE2CjihQfPZJZ5OsDTnDHp/jf0ze+wvxzL6P4lb2qI9dZoMDXrMloIqAiw==
X-Received: by 2002:a92:d091:0:b0:315:365d:534f with SMTP id h17-20020a92d091000000b00315365d534fmr8191844ilh.19.1678992335398;
        Thu, 16 Mar 2023 11:45:35 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m14-20020a02c88e000000b004050767f779sm2680270jao.164.2023.03.16.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:45:34 -0700 (PDT)
Date:   Thu, 16 Mar 2023 12:45:32 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>
Subject: Re: [PATCH v6 12/24] vfio/pci: Allow passing zero-length fd array
 in VFIO_DEVICE_PCI_HOT_RESET
Message-ID: <20230316124532.30839a94.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB5276300FCAAF8BF7B4E03BA48CBF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230308132903.465159-1-yi.l.liu@intel.com>
        <20230308132903.465159-13-yi.l.liu@intel.com>
        <20230315165311.01f32bfe.alex.williamson@redhat.com>
        <BN9PR11MB5276300FCAAF8BF7B4E03BA48CBF9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 15 Mar 2023 23:31:23 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, March 16, 2023 6:53 AM
> > 
> > On Wed,  8 Mar 2023 05:28:51 -0800
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> > > This is another method to issue PCI hot reset for the users that bounds
> > > device to a positive iommufd value. In such case, iommufd is a proof of
> > > device ownership. By passing a zero-length fd array, user indicates kernel
> > > to do ownership check with the bound iommufd. All the opened devices  
> > within  
> > > the affected dev_set should have been bound to the same iommufd. This is
> > > simpler and faster as user does not need to pass a set of fds and kernel
> > > no need to search the device within the given fds.  
> > 
> > Couldn't this same idea apply to containers?  
> 
> User is allowed to create multiple containers. Looks we don't have a way
> to check whether multiple containers belong to the same user today.

No, but a common configuration is that all devices are in the same
container, ie. no-vIOMMU, and it's also rather common that when we have
multi-function devices, all functions are within the same IOMMU group
and therefore necessarily require the same address space and therefore
container.

> > I'm afraid this proposal reduces or eliminates the handshake we have
> > with userspace between VFIO_DEVICE_GET_PCI_HOT_RESET_INFO and
> > VFIO_DEVICE_PCI_HOT_RESET, which could promote userspace to ignore the
> > _INFO ioctl altogether, resulting in drivers that don't understand the
> > scope of the reset.  Is it worth it?  What do we really gain?  
> 
> Jason raised the concern whether GET_PCI_HOT_RESET_INFO is actually
> useful today.
> 
> It's an interface on opened device. So the tiny difference is whether the
> user knows the device is resettable when calling GET_INFO or later when
> actually calling PCI_HOT_RESET.

No, GET_PCI_HOT_RESET_INFO conveys not only whether a PCI_HOT_RESET can
be performed, but equally important the scope of the reset, ie. which
devices are affected by the reset.  If we de-emphasize the INFO
portion, then this easily gets confused as just a variant of
VFIO_DEVICE_RESET, which is explicitly a device-level cscope reset.  In
fact, I'd say the interface is not only trying to validate that the
user has sufficient privileges for the reset, but that they explicitly
acknowledge the scope of the reset.

> and with this series we also allow reset on affected devices which are not
> opened. Such dynamic cannot be reflected in static GET_INFO. More
> suitable a try-and-fail style.

Resets have side-effects, obviously, so this isn't the sort of thing we
can simply ask the user to probe for.  I agree that dynamics can
change, the GET_PCI_HOT_RESET_INFO is a point in time, isolated
functions on the same bus can change ownership.  However, in practice,
and in its primary use case with GPUs without isolation, it's
sufficiently static.  So I think this is a mischaracterization.  Thanks,

Alex

