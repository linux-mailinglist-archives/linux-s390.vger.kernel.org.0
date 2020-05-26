Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD791C950D
	for <lists+linux-s390@lfdr.de>; Thu,  7 May 2020 17:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgEGP3J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 7 May 2020 11:29:09 -0400
Received: from verein.lst.de ([213.95.11.211]:47391 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGP3J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 7 May 2020 11:29:09 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A33A868B05; Thu,  7 May 2020 17:29:06 +0200 (CEST)
Date:   Thu, 7 May 2020 17:29:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-kernel@vger.kernel.org,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: remove ioctl_by_bdev from DASD driver
Message-ID: <20200507152906.GA31257@lst.de>
References: <20200430111754.98508-1-sth@linux.ibm.com> <20200430111754.98508-2-sth@linux.ibm.com> <20200430131351.GA24813@lst.de> <4ab11558-9f2b-02ee-d191-c9a5cc38de0f@linux.ibm.com> <70f541fe-a678-8952-0753-32707d21e337@linux.ibm.com> <20200505124423.GA26313@lst.de> <a6c99eba-44f2-2944-a135-50ed75ef2c55@linux.ibm.com> <20200506045258.GB9846@lst.de> <10918cd1-a4a9-7872-9672-efcd28ef0751@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10918cd1-a4a9-7872-9672-efcd28ef0751@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, May 07, 2020 at 05:22:28PM +0200, Stefan Haberland wrote:
> OK, just thought again about your suggestion and also that
> you have already been talking about a symbol lookup I just
> have written a prototype that took your first two patches
> as base, exports the symbol of dasd_biodasdinfo and in
> ibm.c I do a kallsyms_lookup_name("dasd_biodasdinfo").
> 
> So I would not have to define a structure twice or rely on
> MAJORs. Also we would not have to define an own file
> operation only for DASD devices.
> 
> What do you think about this? If you agree I will polish
> the patches, test them and send them for review.

How do you figure out a given gendisk is a DASD device?  I guess
dasd_biodasdinfo could just check the block_device_operations
pointer first thing.  That's still a little ugly, but seems the
least bad idea so far, so please at least post it for discussion.
