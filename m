Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CE624EC67
	for <lists+linux-s390@lfdr.de>; Sun, 23 Aug 2020 11:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgHWJLJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 23 Aug 2020 05:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgHWJLA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Aug 2020 05:11:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11941C061575;
        Sun, 23 Aug 2020 02:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=No1/zNvYiAlQJ+2VM2KxEVKX9my3nDvRhpc7oRbGQdM=; b=j1K8V7plEOJeLPtvyxOs4Di0MB
        K/7b31MHvupcxYapWHKr1a0hx0nGDI6xZzN3XPcorEnvGv+Zd2hvS+dCLU05yaqKrDDzeFTm/4DtO
        upJ2qqAS7pLLSDzPsXlNqdj7D7Pc2xnMJCelkfwXxsJS21cH28KDhnBzkZGZGSwUwyHELrP7eZ6KM
        XOhkPG5Ftewq53mD+aBu0fTnMQD92wLWJFth+fzWO/WjGpN2OvwA8bBehgXFghsezlndydOr9WziI
        0j7oIrogrtZKa145H/tfv5KlcfSijH1M0kuxuZKyAyvozqf7s3ukgjpNbDng+n1qyEzvWz+45tV7+
        Ot/nIsDQ==;
Received: from 171.168.43.195.cust.ip.kpnqwest.it ([195.43.168.171] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9m1U-0003KT-Cw; Sun, 23 Aug 2020 09:10:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Xianting Tian <xianting_tian@126.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-kernel@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org
Subject: fix block device size update serialization v2
Date:   Sun, 23 Aug 2020 11:10:40 +0200
Message-Id: <20200823091043.2600261-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jens,

this series fixes how we update i_size for the block device inodes (and
thus the block device).  Different helpers use two different locks
(bd_mutex and i_rwsem) to protect the update, and it appears device
mapper uses yet another internal lock.  A lot of the drivers do the
update handcrafted in often crufty ways.  And in addition to that mess
it turns out that the "main" lock, bd_mutex is pretty dead lock prone
vs other spots in the block layer that acquire it during revalidation
operations, as reported by Xianting.

Fix all that by adding a dedicated spinlock just for the size updates.

Changes since v1:
 - don't call __invalidate_device under the new spinlock
 - don't call into the file system code from the nvme removal code
