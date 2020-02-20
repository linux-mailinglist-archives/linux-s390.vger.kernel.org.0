Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A69111669D4
	for <lists+linux-s390@lfdr.de>; Thu, 20 Feb 2020 22:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgBTVaD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 20 Feb 2020 16:30:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39994 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgBTVaD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 20 Feb 2020 16:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582234202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
        b=Z9QZQ6z+3Jg+cBZ4q/9oSXYT1ToM107VKQ3ai9+L2gdzWef4eq7Sb8YlSgOtRIYHO/plp5
        nKarORGw/cSjB22isEmbDfgGGKR12Hp72jdNSX/UQKM3dhoAdyce8VnNS4n22jywR6X3TL
        XPatCt1lSX0X3nEkk0aDFzACmQoQLQE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-5CR8ztYMPNi5IRmC8kW-Kw-1; Thu, 20 Feb 2020 16:29:59 -0500
X-MC-Unique: 5CR8ztYMPNi5IRmC8kW-Kw-1
Received: by mail-qk1-f198.google.com with SMTP id k133so28374qke.13
        for <linux-s390@vger.kernel.org>; Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lf3au2MSHJPbioLz91pJ+pe3QhvFI4k4CcE4NuKgsdw=;
        b=HKNpZtGnhxVK4wTZzeQRpSRknp0DmnnO9N4o2wXCuWawV7mzVQyQ/yI19AZC9EXAw5
         h0SutfJ2keuo2luSQ7iKHeTASxjbnU9iHParWZreMQicCFx2/eyOvRjwVf1exWAHOQjp
         lLKFZz6Z2QEIh+lbdBAu/HkcPbtsDvFh6D0Wu1ECAiam/wsjczpMqu0mQCrVuiDgMBLc
         oycY3A1BpegW6rabCVL30nojkTDL+NtTLAGrWbM+FX3xVn/Yi8NpqZTm1icsnooivDJp
         fwYDk5X6C4Mvi6jNQm8BDQKd0uqHfJvj0ictRo4SvrsNvhqJRI6dnBMrZDfWu2H6/UD3
         2B6A==
X-Gm-Message-State: APjAAAUrWOnbCdRvQ04AK+7yQRuG/NExzcDaehLdv6eZXC8IPDRaFrLR
        j10Oq7bue1zVuB2Mr8w7C4YSOnwtZ+MUjkPJfwbJUxbyDqAq/FApwwfYDpButhnUWhgpNaeArwl
        uG7Fmfcx6AXm6/gR0pbyx4g==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036879qtn.368.1582234199336;
        Thu, 20 Feb 2020 13:29:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwCyE/IGRqPbb728yukodcrAAG8HoUGpZIWGc8w9a3plX9TiklcItDV0lrQNkao9NxMwpK5TQ==
X-Received: by 2002:ac8:4616:: with SMTP id p22mr29036863qtn.368.1582234199118;
        Thu, 20 Feb 2020 13:29:59 -0800 (PST)
Received: from redhat.com (bzq-109-67-14-209.red.bezeqint.net. [109.67.14.209])
        by smtp.gmail.com with ESMTPSA id c45sm453698qtd.43.2020.02.20.13.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 13:29:57 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:29:50 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Viktor Mihajlovski <mihajlov@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Michael Mueller <mimu@linux.ibm.com>
Subject: Re: [PATCH 0/2] virtio: decouple protected guest RAM form
 VIRTIO_F_IOMMU_PLATFORM
Message-ID: <20200220162747-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220160606.53156-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Feb 20, 2020 at 05:06:04PM +0100, Halil Pasic wrote:
> * This usage is not congruent with  standardised semantics of
> VIRTIO_F_IOMMU_PLATFORM. Guest memory protected is an orthogonal reason
> for using DMA API in virtio (orthogonal with respect to what is
> expressed by VIRTIO_F_IOMMU_PLATFORM). 

Quoting the spec:

  \item[VIRTIO_F_ACCESS_PLATFORM(33)] This feature indicates that
  the device can be used on a platform where device access to data
  in memory is limited and/or translated. E.g. this is the case if the device can be located
  behind an IOMMU that translates bus addresses from the device into physical
  addresses in memory, if the device can be limited to only access
  certain memory addresses or if special commands such as
  a cache flush can be needed to synchronise data in memory with
  the device. Whether accesses are actually limited or translated
  is described by platform-specific means.
  If this feature bit is set to 0, then the device
  has same access to memory addresses supplied to it as the
  driver has.
  In particular, the device will always use physical addresses
  matching addresses used by the driver (typically meaning
  physical addresses used by the CPU)
  and not translated further, and can access any address supplied to it by
  the driver. When clear, this overrides any platform-specific description of
  whether device access is limited or translated in any way, e.g.
  whether an IOMMU may be present.

since device can't access encrypted memory,
this seems to match your case reasonably well.

-- 
MST

