Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCF25B1809
	for <lists+linux-s390@lfdr.de>; Thu,  8 Sep 2022 11:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIHJId (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 8 Sep 2022 05:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbiIHJIc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Sep 2022 05:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76537F7769
        for <linux-s390@vger.kernel.org>; Thu,  8 Sep 2022 02:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662628110;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AAQa4isXcnz/CqAw9Or0VLGVMQujP+L3g/TlUU+ZO2I=;
        b=diCygZpyCdafwuD7e2PmbVE84zFzO+88akNjZeHQLvAzYyewPRiViBka9dsqGnitxPb45j
        hXUeDvM00U1tEUx7pyrUfZmYoA9/n77eIv3GKw5NCofbIOSCXuYy4zMji5BHPlgrQ/j3nd
        23x3YYHlTTIMNupYFdMwjRbTMT6rs7g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-596-SC_5gPjBN_upnv1BoSyFRw-1; Thu, 08 Sep 2022 05:08:29 -0400
X-MC-Unique: SC_5gPjBN_upnv1BoSyFRw-1
Received: by mail-qt1-f199.google.com with SMTP id bz20-20020a05622a1e9400b003436a76c6e6so13831157qtb.1
        for <linux-s390@vger.kernel.org>; Thu, 08 Sep 2022 02:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=AAQa4isXcnz/CqAw9Or0VLGVMQujP+L3g/TlUU+ZO2I=;
        b=cYXyYVh4k01FxGCybRcHX63YnTlBPUVe2X5i/7XJa/uLT2W205OOiTWxM1egizG27n
         2A8Fe4A9o0zdoG/1R0DCAGNr5n0stqUDOKxtiP/oYM1w8CV05YzXGyqduZDtWYcU3ByR
         h8oJPwFDq3tVt7Xm0uFWh+S2z8N0bOc8xhcGDTF42pXye2LGhgHXQDrTRqEVxZGVuKan
         76fHezbGdmZcLEBSmUj2+4DqIiZTohtB+Mtbi3o9dgPrN7fqrsmIp6SnKo8rU+fsFO9i
         6uczAwJBZLYyckZdLspO4ZFIGpvNM6p+KOwWDAB2qlEwTLvDZcGIrXsHB3pGMwdIEJnb
         02dQ==
X-Gm-Message-State: ACgBeo3/Ie8WsvEU6n6j9/Otj7nxVTlDnev+eoisJndLlAnxaYOhbeFk
        uvyLSnHVAyMI9VBHBAHLrYJkzNRpVPsZyoCgUkiQO3AmI7hk+c+cLG6x8MphNDTEmRaL7Mg/wQp
        QIyI6mkizxmLVHixmet1N9Q==
X-Received: by 2002:ac8:58d2:0:b0:344:5698:a2e8 with SMTP id u18-20020ac858d2000000b003445698a2e8mr7273763qta.392.1662628109331;
        Thu, 08 Sep 2022 02:08:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7WJ3e3rc/rDtFXXj3tevRpC3CGaundZvbMDIERUF76jhlMbQUf5uKHf0h+nvyWes4AGw7qCA==
X-Received: by 2002:ac8:58d2:0:b0:344:5698:a2e8 with SMTP id u18-20020ac858d2000000b003445698a2e8mr7273747qta.392.1662628109111;
        Thu, 08 Sep 2022 02:08:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id r3-20020ae9d603000000b006af0ce13499sm16489061qkk.115.2022.09.08.02.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 02:08:27 -0700 (PDT)
Message-ID: <527db896-b064-2f02-ae96-6525496176c4@redhat.com>
Date:   Thu, 8 Sep 2022 11:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2 01/15] vfio: Add helpers for unifying vfio_device life
 cycle
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Abhishek Sahu <abhsahu@nvidia.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220901143747.32858-1-kevin.tian@intel.com>
 <20220901143747.32858-2-kevin.tian@intel.com>
 <90862543-9343-7389-a1ff-be9a011be64e@redhat.com>
 <BN9PR11MB527639DCC5706ADA8F0519D38C409@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <BN9PR11MB527639DCC5706ADA8F0519D38C409@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Kevin,

On 9/8/22 08:19, Tian, Kevin wrote:
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Thursday, September 8, 2022 3:28 AM
>>> +/*
>>> + * Alloc and initialize vfio_device so it can be registered to vfio
>>> + * core.
>>> + *
>>> + * Drivers should use the wrapper vfio_alloc_device() for allocation.
>>> + * @size is the size of the structure to be allocated, including any
>>> + * private data used by the driver.
>>> + *
>>> + * Driver may provide an @init callback to cover device private data.
>> nit: this comment may rather relate to the vfio_init_device function
> Yes but vfio_init_device() is used only by ccw and presumably will be
> abandoned once ccw fixes its life cycle mess. Given that I prefer to leaving
> the comment here to be noted by broader users.

OK

Eric
>
>> Besides
>>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>>
> Thanks and other comments adopted. 

