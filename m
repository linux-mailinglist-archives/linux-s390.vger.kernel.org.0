Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 341C2F2EE6
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2019 14:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfKGNJB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 Nov 2019 08:09:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388867AbfKGNI4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 08:08:56 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6C0285945C
        for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2019 13:08:55 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id s3so2198654qkd.6
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2019 05:08:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sGkh4BOm1ga49aAyABsuJ1+hTpGliKNhcGi2Gh8UYvM=;
        b=r2rFISbVrre8j7Jjnovusv8RqdUaNZr6FLHwtA/57csO05YkXw/4jPOFlOyQzl/qMR
         xvCtT0fudtt+l0+CScAKbAovftYdXhWWd2oEBeLlFvxa0L39npUfYauyvkfjK651w2uB
         oTR54aNHv7yBz3K8cpw7sgaLoR8mnqdeP2FdbuwAny8He4naTfDT2E3kZExipQg78opP
         15dnuie1nqWMNn3gZTzIj2YBDuvwZXUqdlDItbU+tAhBHDn4JMaGz/ZUKyQ7UsObw/qy
         IEX1HFYHB55auBzwz+Ty2BdiWtri1wWWNijGzx1VhKz4AjZjiSAiItktGChPJQflxiU3
         7nGw==
X-Gm-Message-State: APjAAAW/8VU932jUk29H/yiOJZy7BGT4rZ6raeqKlO462eLvDaxHfk98
        iT+p5+rIF87YREobnO/xfECnrR2W4NvZWj2GF4AEbjxjAeQRQPOawLgckTkP21VmAa0j5/pXWxl
        klcLnucCh3jhm8hN2GKNC3w==
X-Received: by 2002:ac8:30ea:: with SMTP id w39mr3701960qta.250.1573132134376;
        Thu, 07 Nov 2019 05:08:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqyuaZUrn0+Bhr6V2XR4C8EnN+CEUlSfNq4Ndy0t+kY3CRNcx3lsYUHZ/oZi4s940i7uHezLLA==
X-Received: by 2002:ac8:30ea:: with SMTP id w39mr3701918qta.250.1573132134172;
        Thu, 07 Nov 2019 05:08:54 -0800 (PST)
Received: from redhat.com (bzq-79-178-12-128.red.bezeqint.net. [79.178.12.128])
        by smtp.gmail.com with ESMTPSA id x203sm1051418qkb.11.2019.11.07.05.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 05:08:53 -0800 (PST)
Date:   Thu, 7 Nov 2019 08:08:41 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, kwankhede@nvidia.com,
        alex.williamson@redhat.com, tiwei.bie@intel.com,
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
Subject: Re: [PATCH V10 6/6] docs: sample driver to demonstrate how to
 implement virtio-mdev framework
Message-ID: <20191107080834-mutt-send-email-mst@kernel.org>
References: <20191106133531.693-1-jasowang@redhat.com>
 <20191106133531.693-7-jasowang@redhat.com>
 <20191107040700-mutt-send-email-mst@kernel.org>
 <bd2f7796-8d88-0eb3-b55b-3ec062b186b7@redhat.com>
 <20191107061942-mutt-send-email-mst@kernel.org>
 <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d09229bc-c3e4-8d4b-c28f-565fe150ced2@redhat.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 07, 2019 at 08:43:29PM +0800, Jason Wang wrote:
> 
> On 2019/11/7 下午7:21, Michael S. Tsirkin wrote:
> > On Thu, Nov 07, 2019 at 06:18:45PM +0800, Jason Wang wrote:
> > > On 2019/11/7 下午5:08, Michael S. Tsirkin wrote:
> > > > On Wed, Nov 06, 2019 at 09:35:31PM +0800, Jason Wang wrote:
> > > > > This sample driver creates mdev device that simulate virtio net device
> > > > > over virtio mdev transport. The device is implemented through vringh
> > > > > and workqueue. A device specific dma ops is to make sure HVA is used
> > > > > directly as the IOVA. This should be sufficient for kernel virtio
> > > > > driver to work.
> > > > > 
> > > > > Only 'virtio' type is supported right now. I plan to add 'vhost' type
> > > > > on top which requires some virtual IOMMU implemented in this sample
> > > > > driver.
> > > > > 
> > > > > Acked-by: Cornelia Huck<cohuck@redhat.com>
> > > > > Signed-off-by: Jason Wang<jasowang@redhat.com>
> > > > I'd prefer it that we call this something else, e.g.
> > > > mvnet-loopback. Just so people don't expect a fully
> > > > functional device somehow. Can be renamed when applying?
> > > Actually, I plan to extend it as another standard network interface for
> > > kernel. It could be either a standalone pseudo device or a stack device.
> > > Does this sounds good to you?
> > > 
> > > Thanks
> > That's a big change in an interface so it's a good reason
> > to rename the driver at that point right?
> > Oherwise users of an old kernel would expect a stacked driver
> > and get a loopback instead.
> > 
> > Or did I miss something?
> 
> 
> My understanding is that it was a sample driver in /doc. It should not be
> used in production environment. Otherwise we need to move it to
> driver/virtio.
> 
> But if you insist, I can post a V11.
> 
> Thanks

this can be a patch on top.
