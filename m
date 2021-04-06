Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5835570E
	for <lists+linux-s390@lfdr.de>; Tue,  6 Apr 2021 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbhDFOzL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 6 Apr 2021 10:55:11 -0400
Received: from verein.lst.de ([213.95.11.211]:54860 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239488AbhDFOzL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 6 Apr 2021 10:55:11 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6FA6868B02; Tue,  6 Apr 2021 16:54:57 +0200 (CEST)
Date:   Tue, 6 Apr 2021 16:54:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ariel Elior <aelior@marvell.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jens Axboe <axboe@fb.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>, Lijun Ou <oulijun@huawei.com>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        netdev@vger.kernel.org, Potnuri Bharat Teja <bharat@chelsio.com>,
        rds-devel@oss.oracle.com, Sagi Grimberg <sagi@grimberg.me>,
        samba-technical@lists.samba.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Weihang Li <liweihang@huawei.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA: Add access flags to
 ib_alloc_mr() and ib_mr_pool_init()
Message-ID: <20210406145457.GA7790@lst.de>
References: <20210405052404.213889-2-leon@kernel.org> <c21edd64-396c-4c7c-86f8-79045321a528@acm.org> <YGvwUI022t/rJy5U@unreal> <20210406052717.GA4835@lst.de> <YGv4niuc31WnqpEJ@unreal> <20210406121312.GK7405@nvidia.com> <20210406123034.GA28930@lst.de> <20210406140437.GR7405@nvidia.com> <20210406141552.GA4936@lst.de> <20210406144039.GS7405@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406144039.GS7405@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 06, 2021 at 11:40:39AM -0300, Jason Gunthorpe wrote:
> Yes, but the complexity is how the drivers are constructed they are
> designed to reject flags they don't know about..
> 
> Hum, it looks like someone has already been in here and we now have a
> IB_ACCESS_OPTIONAL concept. 
> 
> Something like this would be the starting point:
>
> [...]
>
> However I see only EFA actually uses IB_ACCESS_OPTIONAL, so the lead
> up would be to audit all the drivers to process optional access_flags
> properly. Maybe this was done, but I don't see much evidence of it..
>
> Sigh. It is a big mess cleaning adventure in drivers really.

Yes.  When passing flags to drivers we need to have a good pattern
in place for distinguishing between mandatory and optional flags.
That is something everyone gets wrong at first (yourself included)
and which then later needs painful untangling.  So I think we need
to do that anyway.

> > Do we actually ever need the strict ordering semantics in the kernel?
> 
> No, only for uverbs.

Which is a pretty clear indicator that we should avoid all this ULP
churn.  Note that the polarity of the the flag passed to the HCA
driver doesn't really matter either - we should just avoid having to
deal with it in the kernel ULP API.
