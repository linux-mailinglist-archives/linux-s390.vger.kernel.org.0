Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3812CD030
	for <lists+linux-s390@lfdr.de>; Thu,  3 Dec 2020 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgLCHMk (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 3 Dec 2020 02:12:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729814AbgLCHMj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 02:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606979473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXF3TZzoNrGr5gKvXhDZQd3WblgUNL7SVEFeVZVdFmc=;
        b=WJ2HpcR+rN0ADxJnSendrP5ZJMXYCz3LImdR5I6QJSeBVdLUUccE7G33m2lXSAp1X4wQqp
        lhmzkFtkUh88LDUIwQ8EFWwn7e0K6t7BoWNNTsdPsGu11Ud76GZkTkZODO4loKXhfBev/O
        AcotYzMVK1OGMClbukUMr5M2AIK3v8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-W-Pz2EQHPWyTIzTKtgFMxw-1; Thu, 03 Dec 2020 02:11:11 -0500
X-MC-Unique: W-Pz2EQHPWyTIzTKtgFMxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECA8F8042B5;
        Thu,  3 Dec 2020 07:11:09 +0000 (UTC)
Received: from T590 (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DEEDD60BF1;
        Thu,  3 Dec 2020 07:10:59 +0000 (UTC)
Date:   Thu, 3 Dec 2020 15:10:55 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>,
        dm-devel@redhat.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 3/9] block: store a block_device pointer in struct bio
Message-ID: <20201203071055.GA633702@T590>
References: <20201201165424.2030647-1-hch@lst.de>
 <20201201165424.2030647-4-hch@lst.de>
 <20201203063941.GA629758@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203063941.GA629758@T590>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Dec 03, 2020 at 02:40:04PM +0800, Ming Lei wrote:
> On Tue, Dec 01, 2020 at 05:54:18PM +0100, Christoph Hellwig wrote:
> > Replace the gendisk pointer in struct bio with a pointer to the newly
> > improved struct block device.  From that the gendisk can be trivially
> > accessed with an extra indirection, but it also allows to directly
> > look up all information related to partition remapping.
> 
> The extra indirection is often done in fast path, so just wondering why
> you don't consider to embed gendisk into block_device? Then the extra
> indirection can be avoided.

oops, that is only possible for disk, and indirection is still needed
for partitions.


Thanks,
Ming

