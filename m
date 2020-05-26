Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04B81C671F
	for <lists+linux-s390@lfdr.de>; Wed,  6 May 2020 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbgEFExC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 6 May 2020 00:53:02 -0400
Received: from verein.lst.de ([213.95.11.211]:38744 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEFExC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 6 May 2020 00:53:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 46CD968C4E; Wed,  6 May 2020 06:52:59 +0200 (CEST)
Date:   Wed, 6 May 2020 06:52:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <20200506045258.GB9846@lst.de>
References: <20200430111754.98508-1-sth@linux.ibm.com> <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de> <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com> <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com> <20200505124423.GA26313@lst.de> <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 05, 2020 at 05:09:56PM +0200, Stefan Haberland wrote:
> OK, thanks for the hint.I did not have this in mind. And I still have
> to look up how this is working at all.
> But isn't this only a real issue for devices with more than 16 minors
> or partitions? So it should not be a problem for DASDs with our limit
> of 3 partitions and the fixed amount of minors, right?
> 
> Just tested with CONFIG_DEBUG_BLOCK_EXT_DEVT enabled and about 1000
> unlabeled devices. Did not see an issue.
> 
> While I see the SCSI devices with MAJOR 259 and quite a random MINOR
> all the DASD devices keep their MAJOR 94 and ascending MINOR.

Looks like it only changes the minors, and not the majors.  Still
checking for major and relying on a shared structure define in different
places just doesn't look maintainable.

> > And compared to all the complications I think the biodasdinfo method
> > is the least of all those evils.
> 
> Are you talking about your first patch suggestion?Then I disagree.
> I still do not like to force the driver to be built in if there is an
> alternative.

No, I mean the series that I actually sent out:

https://lkml.org/lkml/2020/4/21/66
https://lkml.org/lkml/2020/4/21/68
https://lkml.org/lkml/2020/4/21/69
