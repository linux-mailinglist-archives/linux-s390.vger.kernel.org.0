Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018A7260AFB
	for <lists+linux-s390@lfdr.de>; Tue,  8 Sep 2020 08:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgIHGbg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 8 Sep 2020 02:31:36 -0400
Received: from verein.lst.de ([213.95.11.211]:51513 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbgIHGbg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 8 Sep 2020 02:31:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E4B0568AFE; Tue,  8 Sep 2020 08:31:33 +0200 (CEST)
Date:   Tue, 8 Sep 2020 08:31:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org
Subject: set_fs removal for s390
Message-ID: <20200908063133.GA14217@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi s390 maintainers,

the base work to remove address space overrides using set_fs() has
landed in linux-next through this tree:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=base.set_fs

and in addition to x86 and powerpc converted there, we have arm, arm64
and RISC-V conversion in progress.  That means s390 is the only "tier 1"
architecture still missing.  Due to the special instructions for
accessing the user space address space I don't really feel like doing
the conversion myself, but it would be great if we could get s390 done
for 5.10 as well.

The rought TODO list is:
 (1) actually stop using set_fs in the zrcypt driver.  I could prepare
     a crude untested patch for that if it helps.
 (2) implement the __get_user_nofault and __put_user_nofault helpers to
     safely access kernel memory.  These should behave like
     get_user/put_user under set_fs(KERNEL_DS), but not actually
     manipulate any task state to do so
 (3) unselect CONFIG_SET_FS and remove all the code related to overriding
     the address space(3) unselect CONFIG_SET_FS and remove all the code
     related to overriding the address space limit
