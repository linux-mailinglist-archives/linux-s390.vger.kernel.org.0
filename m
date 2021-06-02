Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DEB39817E
	for <lists+linux-s390@lfdr.de>; Wed,  2 Jun 2021 08:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFBG4G (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 2 Jun 2021 02:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbhFBG4E (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Jun 2021 02:56:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69974C061574;
        Tue,  1 Jun 2021 23:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=GNz/Hu0V5gogSB4co5eOK6xP1gnr1qh2/gA3KL3Dtxg=; b=BI35MypsV5ujI5j9LOM8ffKO3O
        PPR2xJ+smyVf1yBqrB22os7cElpqLd6BGSF+LAFux1FWghPPtYUh71lumcyGTaH+GySHaNY4TdhS/
        AV4vc/JIVMat63n8MdcbvA03bNT/GrAfqDiF7ptTNcphdfH4Gmp4s374edZksMq4302Y5G3rKEHTv
        zkjAvx0fvVtUm2B/6XY5TSPrkqQmnos5aAqRHBWaQFtoEeGLkMCCmRvVNoipNM5EQcjvqqNXgrxv+
        Uv5yjt1xCW0uwaWbb4vvYLNz6VSHAG5NmTU3avE4Jh6rqZRN77aCtw5TtcxU3fh9zr5QCwFWGydth
        c/21yB+g==;
Received: from shol69.static.otenet.gr ([83.235.170.67] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1loKlB-0025F3-IY; Wed, 02 Jun 2021 06:53:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Tim Waugh <tim@cyberelk.net>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        xen-devel@lists.xenproject.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-s390@vger.kernel.org
Subject: simplify gendisk and request_queue allocation for blk-mq based drivers
Date:   Wed,  2 Jun 2021 09:53:15 +0300
Message-Id: <20210602065345.355274-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi all,

this series is the scond part of cleaning up lifetimes and allocation of
the gendisk and request_queue structure.  It adds a new interface to
allocate the disk and queue together for blk based drivers, and uses that
in all drivers that do not have any caveats in their gendisk and
request_queue lifetime rules.

Diffstat:
 block/blk-mq.c                      |   91 +++++++++++++++-------------------
 block/blk.h                         |    1 
 block/elevator.c                    |    2 
 drivers/block/amiflop.c             |   16 +-----
 drivers/block/aoe/aoeblk.c          |   33 ++++--------
 drivers/block/aoe/aoedev.c          |    3 -
 drivers/block/ataflop.c             |   16 +-----
 drivers/block/floppy.c              |   20 +------
 drivers/block/loop.c                |   19 ++-----
 drivers/block/nbd.c                 |   53 +++++++------------
 drivers/block/null_blk/main.c       |   11 +---
 drivers/block/paride/pcd.c          |   19 +++----
 drivers/block/paride/pd.c           |   30 ++++-------
 drivers/block/paride/pf.c           |   18 ++----
 drivers/block/ps3disk.c             |   36 +++++--------
 drivers/block/rbd.c                 |   52 ++++++-------------
 drivers/block/rnbd/rnbd-clt.c       |   35 +++----------
 drivers/block/sunvdc.c              |   47 ++++-------------
 drivers/block/swim.c                |   34 +++++-------
 drivers/block/swim3.c               |   33 +++++-------
 drivers/block/sx8.c                 |   23 ++------
 drivers/block/virtio_blk.c          |   26 ++-------
 drivers/block/xen-blkfront.c        |   96 ++++++++++++++----------------------
 drivers/block/z2ram.c               |   15 +----
 drivers/cdrom/gdrom.c               |   45 +++++++---------
 drivers/md/dm-rq.c                  |    9 +--
 drivers/memstick/core/ms_block.c    |   25 +++------
 drivers/memstick/core/mspro_block.c |   26 ++++-----
 drivers/mtd/mtd_blkdevs.c           |   48 ++++++++----------
 drivers/mtd/ubi/block.c             |   68 ++++++++++---------------
 drivers/s390/block/scm_blk.c        |   21 ++-----
 include/linux/blk-mq.h              |   24 ++++++---
 include/linux/elevator.h            |    1 
 33 files changed, 386 insertions(+), 610 deletions(-)
