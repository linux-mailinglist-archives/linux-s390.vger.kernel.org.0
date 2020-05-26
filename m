Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB7B1D6260
	for <lists+linux-s390@lfdr.de>; Sat, 16 May 2020 17:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgEPPnr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 16 May 2020 11:43:47 -0400
Received: from verein.lst.de ([213.95.11.211]:60888 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgEPPnr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sat, 16 May 2020 11:43:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id CD87368B05; Sat, 16 May 2020 17:43:44 +0200 (CEST)
Date:   Sat, 16 May 2020 17:43:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com
Subject: Re: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20200516154344.GA16828@lst.de>
References: <20200508131455.55407-1-sth@linux.ibm.com> <20200508131455.55407-4-sth@linux.ibm.com> <20200508155342.GC4200@lst.de> <6cd6788e-ce3d-7869-307a-9a6723f6eb79@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cd6788e-ce3d-7869-307a-9a6723f6eb79@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 11, 2020 at 06:30:44PM +0200, Stefan Haberland wrote:
> Am 08.05.20 um 17:53 schrieb Christoph Hellwig:
> > I think this should use symbol_get instead.
> 
> Thanks for the Feedback, also for the previous patch.
> I will incorporate it, run some test cycles and submit the patches
> again when I am ready.

Did you manage to get back to this?
