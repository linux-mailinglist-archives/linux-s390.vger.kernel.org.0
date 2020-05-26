Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A19D1C55D8
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgEEMo0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 08:44:26 -0400
Received: from verein.lst.de ([213.95.11.211]:35169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEEMo0 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 5 May 2020 08:44:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A5B2068C4E; Tue,  5 May 2020 14:44:23 +0200 (CEST)
Date:   Tue, 5 May 2020 14:44:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <20200505124423.GA26313@lst.de>
References: <20200430111754.98508-1-sth@linux.ibm.com> <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de> <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com> <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 04, 2020 at 10:45:33AM +0200, Stefan Haberland wrote:
> > findthe corresponding device for example. Not sure if this is that easy.
> 
> I did some additional research on this.
> What I could imagine:
> 
> The gendisk->private_data pointer currently contains a pointer to
> the dasd_devmap structure. This one is also reachable by iterating
> over an exported dasd_hashlist.
> So I could export the dasd_hashlist symbol, iterate over it and try
> to find the dasd_devmap pointer I have from the gendisk->private_data
> pointer.
> This would ensure that the gendisk belongs to the DASD driver and I
> could use the additional information that is somehow reachable through
> the gendisk->private_data pointer.
> 
> But again, I am not sure if this additional code and effort is needed.
> From my point of view checking the gendisk->major for DASD_MAJOR is
> OK to ensure that the device belongs to the DASD driver.

With CONFIG_DEBUG_BLOCK_EXT_DEVT you can't rely on major numbers.

And compared to all the complications I think the biodasdinfo method
is the least of all those evils.  Jens, any opinion?
