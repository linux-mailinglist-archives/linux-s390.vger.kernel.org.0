Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3121FA5AA
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2020 03:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFPBdN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 15 Jun 2020 21:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgFPBdN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jun 2020 21:33:13 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9344C08C5C2
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2020 18:33:12 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so14278446qtq.11
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2020 18:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Di1OC4PTZzEbx58ucUzMdRigSSlUT5vLA9t7nSG00pc=;
        b=KqiktX0dDYoeLQwnB/SSYxMcckTKQNnQLEJ1kZsWFkEm9K93JmhN3I4Pb0Ur+ZqQc9
         z1kB/HBZn48RlVa2LknqLQPscf+kf0IKChJeLo/xXkHlT7YBtcUpNxxcpDwpqvPHxYZX
         wMQrbaEeUn3cc+BUagy48Mx4zufaMLqTMmeu6TlX4TIkY63TtgIDMaoV+eBH6HcvMLhl
         4FP+7vnx8r8RQtOOjrDbJZXN6GVPNrhQnI4nYgU1I1Gr964kKkgbN1bd1hp2Gj5HZY3C
         tZxPY71NlZ30yu4OF4F2meN4612neDBLD0iUUY5gX/Euh5/aiX7VNNe/knDM078DhDSC
         nVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Di1OC4PTZzEbx58ucUzMdRigSSlUT5vLA9t7nSG00pc=;
        b=Ag1tY1xL6siSpcT1kPTBcUEN93rbeNRuo4lP/3kcyef/IA2IMtqaH06DSCMFTTO+3/
         6vp+yUS9pEaiknu/RqKHEGUiW0hSGKQY5prDi0uDCvBFAzt/QSM99cYqw0YBDZVljqV6
         nB4c8dPcOFk8T3H9kViCBBLdfPww3Gx2NmuokhjY/13DbNUsgtbYTe597viSHqrt03LR
         F7zywDtzOMaFpLa2YM432I/LtoogM2KMR8cmt5sDpXJgg6GCIMVXu8C/WsICrxwD1ChZ
         0P3K7ITJJ1uC36Z5UqnDjCLFvkVebMIUNrkZ/g3doj/+fB+IvJGDDPOTU6w+0QMAjHYu
         XgZw==
X-Gm-Message-State: AOAM533s6fwK2NvjfPdRghyiB66Bb1TikeMNqsshSrRLupBxq3WwKIy2
        +aoMJdBo7KQmPVMhdIAGXYSX8A==
X-Google-Smtp-Source: ABdhPJyYriXJD2angPWvgeIt4hD8bibRikr2EuSW51MBBiFyhIK1iKXxZh9go49F3vdQaMQN9jZttg==
X-Received: by 2002:ac8:1c72:: with SMTP id j47mr18363260qtk.198.1592271191979;
        Mon, 15 Jun 2020 18:33:11 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d193sm12942623qke.124.2020.06.15.18.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 18:33:11 -0700 (PDT)
Date:   Mon, 15 Jun 2020 21:33:09 -0400
From:   Qian Cai <cai@lca.pw>
To:     linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org
Cc:     heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        darrick.wong@oracle.com, kirill@shutemov.name, willy@infradead.org,
        peterx@redhat.com, yang.shi@linux.alibaba.com, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: VM_BUG_ON_PAGE(page_to_pgoff(page) != offset) on s390
Message-ID: <20200616013309.GB815@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Ever since a few days ago, linux-next on s390 has started to crash
with compiling workloads or during boot below.

This .config if ever matters,

https://raw.githubusercontent.com/cailca/linux-mm/master/s390.config

Since our s390 guest has only 2 CPUs, it is probably going to take a
long time to bisect.

01: [   60.589979] page:000003d0830bd540 refcount:257 mapcount:0 mapping:0000000
01: 0ac9dec15 index:0x155 head:000003d0830bc000 order:8 compound_mapcount:0 comp
01: ound_pincount:0
01: [   60.590361] mapping->aops:xfs_address_space_operations [xfs] dentry name:
01: "lvm"
01: [   60.590369] flags: 0x2000000000000000()
01: [   60.590380] raw: 2000000000000000 000003d0830bc001 000003d0830bd548 00000
01: 00000000400
01: [   60.590387] raw: 0000000000000000 0000000000000000 ffffffff00000000 00000
01: 00000000000
01: [   60.590394] head: 2000000000010015 000003d0830dd588 000000008fb34c20 0000
01: 0000cc4f0568
01: [   60.590401] head: 0000000000000100 0000000000000000 ffffffff00000101 0000
01: 00008f78a000
01: [   60.590407] page dumped because: VM_BUG_ON_PAGE(page_to_pgoff(page) != o
01: fset)
01: [   60.590428] ------------[ cut here ]------------
01: [   60.590435] kernel BUG at mm/filemap.c:2516!
01: [   60.590512] monitor event: 0040 ilc:2 [#1] SMP
01: [   60.590518] Modules linked in: ip_tables x_tables xfs dm_mirror dm_region
01: _hash dm_log dm_mod
01: [   60.590531] CPU: 1 PID: 665 Comm: lvmconfig Not tainted 5.8.0-rc1-next-20
01: 200615 #1
01: [   60.590535] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)
01: [   60.590539] Krnl PSW : 0704c00180000000 00000000bdf0bb46 (filemap_fault+0
01: x191e/0x27c0)
01: [   60.590550]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
01:  RI:0 EA:3
01: [   60.590555] Krnl GPRS: 0000000000000001 0000037c002adef5 000003d0830bd578
01:  0000030000000000
01: [   60.591850]            0000030000000001 0000030000000000 000003e00156fdc8
01:  000003e00156fdc0
01: [   60.591854]            00000000c8f0b800 0000000000000155 000003d0830bd548
01:  000003d0830bd540
01: [   60.591859]            00000000bed41008 00000000bea6f900 00000000bdf0bb42
01:  000003e00156f9d0
01: [   60.591872] Krnl Code: 00000000bdf0bb36: c030005b1e45        larl    %r3,
01: 00000000bea6f7c0
01: [   60.591872]            00000000bdf0bb3c: c0e5000597ca        brasl   %r14
01: ,00000000bdfbead0
01: [   60.591872]           #00000000bdf0bb42: af000000            mc      0,0
01: [   60.591872]           >00000000bdf0bb46: c020007d238d        larl    %r2,
01: 00000000beeb0260
01: [   60.591872]            00000000bdf0bb4c: c0e50028aebe        brasl   %r14
01: ,00000000be4218c8
01: [   60.591872]            00000000bdf0bb52: eb1a0003000c        srlg    %r1,
01: %r10,3
01: [   60.591872]            00000000bdf0bb58: a52d0300            llihl   %r2,
01: 768
01: [   60.591872]            00000000bdf0bb5c: b9080012            agr     %r1,
01: %r2
01: [   60.591901] Call Trace:
01: [   60.591905]  [<00000000bdf0bb46>] filemap_fault+0x191e/0x27c0
01: [   60.591910] ([<00000000bdf0bb42>] filemap_fault+0x191a/0x27c0)
01: [   60.591967]  [<000003ff80240cfc>] xfs_filemap_fault+0x1ac/0x528 [xfs]
__xfs_filemap_fault at /home/linux-mm/linux/fs/xfs/xfs_file.c:1214
(inlined by) xfs_filemap_fault at /home/linux-mm/linux/fs/xfs/xfs_file.c:1228
01: [   60.591973]  [<00000000bdfc8428>] __do_fault+0xc0/0x470
01: [   60.591977]  [<00000000bdfd75f2>] handle_mm_fault+0x1782/0x29b8
01: [   60.591983]  [<00000000bdb50c60>] do_dat_exception+0x200/0x9c8
do_exception at arch/s390/mm/fault.c:481
(inlined by) do_dat_exception at arch/s390/mm/fault.c:583
01: [   60.591993]  [<00000000be9f4b76>] pgm_check_handler+0x1d6/0x234
01: [   60.591997] INFO: lockdep is turned off.
01: [   60.592000] Last Breaking-Event-Address:
01: [   60.592004]  [<00000000bdfbeafc>] dump_page+0x2c/0x40
01: [   60.606521] Kernel panic - not syncing: Fatal exception: panic_on_oops
00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
 CPU 00.
00: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
 CPU 01.
01: HCPGIR450W CP entered; disabled wait PSW 00020001 80000000 00000000 BDB32B58
