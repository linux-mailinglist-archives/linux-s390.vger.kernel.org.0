Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0811A74B3
	for <lists+linux-s390@lfdr.de>; Tue, 14 Apr 2020 09:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390779AbgDNH3I (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 14 Apr 2020 03:29:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgDNH3I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=BKn5jefJR/eysebjx+9KHAQmWkLyv0jA4EDNIFifSXU=; b=NJA54/BGEKWwWdE69yY4wIT5oi
        L2GFmGf4i7zf/xvo/uxJYmoEqF296UekQ0y5zdjNoVWsHNl+II55OIrN5cI2QfNKQomvfvn9NWFIe
        5WiermtDUHj9xHslW1EXv5Bz+H3taWtn7xbGqZ/eSjAVAKiKu1DfH7mqC4cL8LMp0qRXiHqkzYQXL
        nyOiBvXsDEgf+g9WE+1z4k+UXg3jY9MTEbRJecuLfwGWYNELp13woGt5mrR/u7n6VfEEAONMRzA28
        h6mkdvgMSyWRb/b8CPbEyYvuoyD8ACdVSJAsyPcoCIt7oXmPUbSEOWnEXcixHGaVRW/82zcyvrPGj
        2RTWcO8g==;
Received: from [2001:4bb8:180:384b:4c21:af7:dd95:e552] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOG0I-0005YV-Ki; Tue, 14 Apr 2020 07:29:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: more partition handling cleanups v2
Date:   Tue, 14 Apr 2020 09:28:52 +0200
Message-Id: <20200414072902.324936-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

this series cleans up more lose ends in the partitioning code.  It also
removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.

Changes since v1:
 - fix a brown paperbag typo in blkpg_do_ioctl
 - fix a commit message typo
