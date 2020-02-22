Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98F04169176
	for <lists+linux-s390@lfdr.de>; Sat, 22 Feb 2020 20:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgBVTII (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 22 Feb 2020 14:08:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42642 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726701AbgBVTII (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 22 Feb 2020 14:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582398486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l8Co0LvRp3ramNpVW3gFF8vKkokm29L15IzKuQ8ukBs=;
        b=NWNXQdKf1K6da2Ths6s9CB6Gl17KaDXkUmxkV2O267owuNKaZUsJJkzrO/lZ55mM2l3Vk6
        1xj1df9UwhaME0hohDSIstB0M51dPph7KLFoeomGJ63roJQ8GN4slBRitfWzbfyyCGxwEX
        bL7ZxxDUOYjecDlj/Rnl9GoR3MDZl3E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-8wNYy80mN962hjK87E4yRg-1; Sat, 22 Feb 2020 14:08:04 -0500
X-MC-Unique: 8wNYy80mN962hjK87E4yRg-1
Received: by mail-wr1-f72.google.com with SMTP id j4so2854257wrs.13
        for <linux-s390@vger.kernel.org>; Sat, 22 Feb 2020 11:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8Co0LvRp3ramNpVW3gFF8vKkokm29L15IzKuQ8ukBs=;
        b=rxw0rzUIjw/1afiBZNVaZSbRmqVZkyKy3UEMtsTE8Jiko7o2SUP7oa2cTYKWsJBNKv
         RhMwEEPZsLUWS6BuNwKfa8RJHQtIV7hgHq6deJbmxRiTxKk3iQuRfQSh1setQxr5tICE
         9A58qHp7oKPRPZ8GcRx6rfta2mtTJpS9um+I5tErztBbZmmDfsy/wtlkxDLFm6RzgVda
         6+xF8XXlLQKp8w3SWKhSlmyrCUUiZYbfWCNRpI0+0SVVW6QvFSzpwgPtBzDDvc3fxKSd
         85vVJXkj6KDZJWLsikoauPb5WQdODhUxAhfp1JDqlAk2QzA4xLSi24upFqmnpUgCElRy
         aZqw==
X-Gm-Message-State: APjAAAX7Rv+f1+9L/yek7afUjIQb3HdGcoqbsxePudOvk0lso4cDZV6Y
        0vv+StInpqS8HOz5aZUmSxmb7zVFuFXC9AZC6yXh9Z89Z7V5xGFTVGVgOCNA1jkJW31Sgkils6z
        sphy4io06XAyhjfqX3YW2WQ==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr11484206wmc.39.1582398483372;
        Sat, 22 Feb 2020 11:08:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkw9wErSHWGp2TCjgAZ9qrXX7+D7Wndcr6dYdr8omT/WT5gNCQFRWrzivLVlKcFtBEcNGXcA==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr11484193wmc.39.1582398483111;
        Sat, 22 Feb 2020 11:08:03 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
        by smtp.gmail.com with ESMTPSA id m68sm9604715wme.48.2020.02.22.11.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 11:08:02 -0800 (PST)
Date:   Sat, 22 Feb 2020 14:07:58 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20200222140408-mutt-send-email-mst@kernel.org>
References: <20200220160606.53156-1-pasic@linux.ibm.com>
 <20200220160606.53156-3-pasic@linux.ibm.com>
 <20200220161309.GB12709@lst.de>
 <20200221153340.4cdcde81.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221153340.4cdcde81.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 21, 2020 at 03:33:40PM +0100, Halil Pasic wrote:
> AFAIU you have a positive attitude towards the idea, that 
> !F_VIRTIO_PLATFORM implies 'no DMA API is used by virtio' 
> should be scrapped. 
> 
> I would like to accomplish that without adverse effects to virtio-ccw
> (because caring for virtio-ccw is a part of job description).
> 
> Regards,
> Halil

It is possible, in theory. IIRC the main challenge is that DMA API
has overhead of indirect function calls even when all it
does it return back the PA without changes. So that will lead to
a measureable performance degradation. That might be fixable,
possibly using some kind of logic along the lines of
	if (iova is pa)
		return pa
	else
		indirect call

and for unmapping, we might need an API that says "unmap
is a nop, safe to skip" so we don't maintain the
dma address until unmap.


-- 
MST

