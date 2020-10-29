Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA01329E0CA
	for <lists+linux-s390@lfdr.de>; Thu, 29 Oct 2020 02:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbgJ1WDP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 28 Oct 2020 18:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729503AbgJ1WDP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 18:03:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603922593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
        b=G1H2YZ+773nk/7tFdaV+XqMyYuinKmCcef9QiAw/4VMV9hNMHKb3F3J/duUywIsHZFsNER
        kMLo26mBX5XrQc6nXWpO3qsre7f2wnMHmen/ALn2TyHg6ZYKeLqLR9j+Ff3ydPI1T5miAL
        CSP6MZA6YWplqplkTm119o8n4O3JVqo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-oV4FPeUWNeu2aR8aoBlRpw-1; Wed, 28 Oct 2020 14:01:19 -0400
X-MC-Unique: oV4FPeUWNeu2aR8aoBlRpw-1
Received: by mail-wr1-f69.google.com with SMTP id q15so143363wrw.8
        for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2020 11:01:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Nk2LjAqH68iPpRMmd15ZYH8jce4ByIolJyVBRLfJOQ=;
        b=RF/4wF3qVZ08EsfZVo5Vaf41AdZKSHzYM/oNCn7SF6CWpabKXyCs+9zL7PSERUZGo5
         /zK0JDboP1aXtUKckLqM/dCgwf81AbH9Ob6p5Vh2QKb6/2fQgfGP8KPZHIoOSCyFz03D
         0xBprnZYF5aNW7iT8gustyhAdbqLJhGsy/Prwb3CtLYXjQS7j/2UP2QxFtoWdq0mGGxp
         hwBV5MXgCQFQj9rlCa9NiLD49QLmFz2j1JsJQg3+0b7zlUy8VCVWrfzJ5e/nz2iRyh6b
         gO82QWv5++0dvS/V2z0TItke66A4R5DMtXk7LhucTQ9WHfojggR48/BSEdp+mWFfsqMH
         Jazg==
X-Gm-Message-State: AOAM532qXdowjIgY/KJ/mrSZpQnzicy9UfTLD6TXPRJjqnDS7LIazGi6
        uuzO24mJxU878D38+nUuJpIvCjbC6mI1x2dFZGiS+ykpyzC1hkA1GixbV1P0ly5Mwg1urH730cq
        BGGGxLB8Z4aquspzqQ6eCNA==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525242wrn.257.1603908076672;
        Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS4a2Tb6jVLditxSIK/2tiQlDfblWIHCJN1cagQ8Ey8zoitAc/WOhLkPDuLKeb4iVg6mXqJg==
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr525205wrn.257.1603908076449;
        Wed, 28 Oct 2020 11:01:16 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id a17sm440271wra.29.2020.10.28.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:01:15 -0700 (PDT)
Date:   Wed, 28 Oct 2020 14:01:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     Christoph Hellwig <hch@lst.de>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
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
Subject: Re: [PATCH 2/2] virtio: let virtio use DMA API when guest RAM is
 protected
Message-ID: <20201028135103-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
 <20200222140408-mutt-send-email-mst@kernel.org>
 <20200224171657.GB7278@lst.de>
 <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <691d8c8e-665c-b05f-383f-78377fcf6741@amazon.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 28, 2020 at 03:24:03PM +0100, Alexander Graf wrote:
> On 24.02.20 18:16, Christoph Hellwig wrote:
> > On Sat, Feb 22, 2020 at 02:07:58PM -0500, Michael S. Tsirkin wrote:
> > > On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> > > > AFAIU you have a positive attitude towards the idea, that
> > > > !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio'
> > > > should be scrapped.
> > > > 
> > > > I would like to accomplish that without adverse effects to virtio-ccw
> > > > (because caring for virtio-ccw is a part of job description).
> > > > 
> > > > Regards,
> > > > Halil
> > > 
> > > It is possible, in theory. IIRC the main challenge is that DMA API
> > > has overhead of indirect function calls even when all it
> > > does it return back the PA without changes.
> > 
> > That overhead is gone now, the DMA direct calls are direct calls these
> > days.
> 
> Michael, would that mitigate your concerns to just always use the DMA API?
> If not, wouldn't it make sense to benchmark and pinpoint Christoph to paths
> that do slow things down, so we can finally move virtio into a world where
> it doesn't bypass the kernel DMA infrastructure.
> 
> 
> Alex


There's no specific concern really. One can in theory move the code
handling !VIRTIO_F_ACCESS_PLATFORM such that instead of having a branch
in virtio code, you instead override platform DMA API and then use DMA
API unconditionally.

The gain from that will probably be marginal, but maybe I'm wrong.
Let's see the patches.

We still need to do the override when !VIRTIO_F_ACCESS_PLATFORM,
according to spec. Encrypted hypervisors still need to set
VIRTIO_F_ACCESS_PLATFORM.


Is VIRTIO_F_ACCESS_PLATFORM a good default? Need to support
legacy guests does not allow that at the qemu level, we
need to be conservative there. But yes, if you have a very
modern guest then it might be a good idea to just always
enable VIRTIO_F_ACCESS_PLATFORM. I say might since unfortunately
most people only use VIRTIO_F_ACCESS_PLATFORM with
vIOMMU, using it without VIRTIO_F_ACCESS_PLATFORM is supported
but is a path less well trodden. Benchmarking that,
fixing issues that surface if any would be imho effort
well spent, and would be a prerequisite to making it
a default in a production system.


> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 

