Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F4F2B93
	for <lists+linux-s390@lfdr.de>; Thu,  7 Nov 2019 10:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfKGJz6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 Nov 2019 04:55:58 -0500
Received: from verein.lst.de ([213.95.11.211]:56164 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733271AbfKGJz5 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 Nov 2019 04:55:57 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C651A68B05; Thu,  7 Nov 2019 10:55:54 +0100 (CET)
Date:   Thu, 7 Nov 2019 10:55:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/5] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191107095554.GA11283@lst.de>
References: <20191106151439.30056-1-hch@lst.de> <20191106151439.30056-3-hch@lst.de> <f95d65cb-f864-5cfe-1161-4f940a59f38e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f95d65cb-f864-5cfe-1161-4f940a59f38e@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 07, 2019 at 10:47:39AM +0100, Hannes Reinecke wrote:
> > +	check_disk_size_change(disk, bdev, !invalidate);
> >  	bdev->bd_invalidated = 0;
> >  
> > -	if (!get_capacity(disk))
> > +	if (!get_capacity(disk)) {
> > +		/*
> > +		 * Tell userspace that the media / partition table may have
> > +		 * changed.
> > +		 */
> > +		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> >  		return 0;
> > +	}
> >  	
> I wonder; wouldn't we miss a true size change here?

Why would we?  We first unconditionally drop all partitions.  Then if
the device ha a non-zero capacity we probe for partitions.  What could
we miss?
