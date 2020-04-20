Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C171B103D
	for <lists+linux-s390@lfdr.de>; Mon, 20 Apr 2020 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDTPea (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Apr 2020 11:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgDTPe3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Apr 2020 11:34:29 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ABDC061A0C
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 08:34:28 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so11048199qke.2
        for <linux-s390@vger.kernel.org>; Mon, 20 Apr 2020 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=npWq2XT20dmtrkzpn/wWrvRXENSuyiO3LHGOrfDPnHs=;
        b=jjjTrvy2vg5nuieofgLvVo3mBlaSZX2b9oWKA5VtEiQ6EvWHnkfztV+jI725AG3Xan
         3V7zdKw0z1oVgAEYO2If54k1Up3g3aqj1T+1QXj7qIcI2tKy/YW4tiBYp+m28jE14wCF
         5i+/2rVjwuUj8zKMSQlQ+PFf/if8JEfOhSIx0x4jjjKQsWuYE+l2kNguAOUymoAuOlZJ
         WfERH2FVT3WrkIC69PASIz/eibcyTS6dOhztcvnxs4+OOsCPb/UzYWbXlQ6lOosqG7vN
         qsJWEKj+6CtkfMRxXwqzdDVQCJ7K9+c6wZA3ZaOKa6ny6cXEzmN2xOcYJv2AdOhrSU7Y
         KIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=npWq2XT20dmtrkzpn/wWrvRXENSuyiO3LHGOrfDPnHs=;
        b=tYh4u5NvsWlBctlNdEIueWegwybB4JC3+QH+8q9wYqsxmfkHqJePJNCYyealGt9jbD
         +28WPf64jY4avWp01i89KhcabFfnnsdPFDs8djiINgIqIdpFkcNK7HhV1rEsUCwLXSqf
         +fuwwuBqq0hfVtI6ZFS/8tkmfoIIJuobg4VhfqjvIPfJ5OpeWsIA8ADQ8CE1JYwR/Iv9
         D+3syW/74Xfk27ggUhUAYmbHXhzeb5RkfIE8nw3FXlw0Zrwwr2hslefFzcV2WLW8g77i
         GuJ1jtOZkAT64j8x/uAa5wLV0CdaarxmWJKG2vJ6eb/JoKiVflL0s9kq+cWY12Mti67p
         wFBw==
X-Gm-Message-State: AGi0PuYY41SFKO6PihFZilXUMkHbw8PtIMhqgJRG0TX4rdNkHaOHpKYf
        NSXtAbggZ4vAW8M+Xe7tp3alLg==
X-Google-Smtp-Source: APiQypInAT0yQSOyX2ykJEcndc4QbjNLYen1mhs6MpEFOqtQyBg2OXGSeBnhQqPwJE4FVuLfBonbvA==
X-Received: by 2002:a37:61cf:: with SMTP id v198mr15721385qkb.485.1587396867942;
        Mon, 20 Apr 2020 08:34:27 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m1sm744465qtm.22.2020.04.20.08.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 08:34:27 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3 0/4] Clean up hugetlb boot command line processing
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200417185049.275845-1-mike.kravetz@oracle.com>
Date:   Mon, 20 Apr 2020 11:34:22 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mina Almasry <almasrymina@google.com>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5E312000-05D8-4C5D-A7C0-DDDE1842CB0E@lca.pw>
References: <20200417185049.275845-1-mike.kravetz@oracle.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org



> On Apr 17, 2020, at 2:50 PM, Mike Kravetz <mike.kravetz@oracle.com> =
wrote:
>=20
> Longpeng(Mike) reported a weird message from hugetlb command line =
processing
> and proposed a solution [1].  While the proposed patch does address =
the
> specific issue, there are other related issues in command line =
processing.
> As hugetlbfs evolved, updates to command line processing have been =
made to
> meet immediate needs and not necessarily in a coordinated manner.  The =
result
> is that some processing is done in arch specific code, some is done in =
arch
> independent code and coordination is problematic.  Semantics can vary =
between
> architectures.
>=20
> The patch series does the following:
> - Define arch specific arch_hugetlb_valid_size routine used to =
validate
>  passed huge page sizes.
> - Move hugepagesz=3D command line parsing out of arch specific code =
and into
>  an arch independent routine.
> - Clean up command line processing to follow desired semantics and
>  document those semantics.
>=20
> [1] =
https://lore.kernel.org/linux-mm/20200305033014.1152-1-longpeng2@huawei.co=
m
>=20
> Mike Kravetz (4):
>  hugetlbfs: add arch_hugetlb_valid_size
>  hugetlbfs: move hugepagesz=3D parsing to arch independent code
>  hugetlbfs: remove hugetlb_add_hstate() warning for existing hstate
>  hugetlbfs: clean up command line processing

Reverted this series fixed many undefined behaviors on arm64 with the =
config,

https://raw.githubusercontent.com/cailca/linux-mm/master/arm64.config

[   54.172683][    T1] UBSAN: shift-out-of-bounds in =
./include/linux/hugetlb.h:555:34
[   54.180411][    T1] shift exponent 4294967285 is too large for 64-bit =
type 'unsigned long'
[   54.188885][    T1] CPU: 130 PID: 1 Comm: swapper/0 Not tainted =
5.7.0-rc2-next-20200420 #1
[   54.197284][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[   54.207888][    T1] Call trace:
[   54.211100][    T1]  dump_backtrace+0x0/0x224
[   54.215565][    T1]  show_stack+0x20/0x2c
[   54.219651][    T1]  dump_stack+0xfc/0x184
[   54.223829][    T1]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
[   54.230204][    T1]  hugetlb_add_hstate+0x3ec/0x414
huge_page_size at include/linux/hugetlb.h:555
(inlined by) hugetlb_add_hstate at mm/hugetlb.c:3301
[   54.235191][    T1]  hugetlbpage_init+0x14/0x30
[   54.239824][    T1]  do_one_initcall+0x6c/0x144
[   54.244446][    T1]  do_initcall_level+0x158/0x1c4
[   54.249336][    T1]  do_initcalls+0x68/0xb0
[   54.253597][    T1]  do_basic_setup+0x28/0x30
[   54.258049][    T1]  kernel_init_freeable+0x19c/0x228
[   54.263188][    T1]  kernel_init+0x14/0x208
[   54.267473][    T1]  ret_from_fork+0x10/0x18


[   55.534338][    T1] UBSAN: shift-out-of-bounds in =
./include/linux/hugetlb.h:555:34
[   55.542064][    T1] shift exponent 4294967285 is too large for 64-bit =
type 'unsigned long'
[   55.550555][    T1] CPU: 129 PID: 1 Comm: swapper/0 Not tainted =
5.7.0-rc2-next-20200420 #1
[   55.558992][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[   55.569659][    T1] Call trace:
[   55.572898][    T1]  dump_backtrace+0x0/0x224
[   55.577335][    T1]  show_stack+0x20/0x2c
[   55.581442][    T1]  dump_stack+0xfc/0x184
[   55.585621][    T1]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
[   55.592031][    T1]  __hugetlb_cgroup_file_dfl_init+0x37c/0x384
[   55.598062][    T1]  hugetlb_cgroup_file_init+0x9c/0xd8
[   55.603399][    T1]  hugetlb_init+0x248/0x448
[   55.607840][    T1]  do_one_initcall+0x6c/0x144
[   55.612493][    T1]  do_initcall_level+0x158/0x1c4
[   55.617404][    T1]  do_initcalls+0x68/0xb0
[   55.621664][    T1]  do_basic_setup+0x28/0x30
[   55.626107][    T1]  kernel_init_freeable+0x19c/0x228
[   55.631253][    T1]  kernel_init+0x14/0x208
[   55.635519][    T1]  ret_from_fork+0x10/0x18

[  153.283648][    T1] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[  153.293078][    T1] UBSAN: shift-out-of-bounds in =
./include/linux/hugetlb.h:555:34
[  153.300841][    T1] shift exponent 4294967285 is too large for 64-bit =
type 'unsigned long'
[  153.309185][    T1] CPU: 161 PID: 1 Comm: swapper/0 Tainted: G        =
     L    5.7.0-rc2-next-20200420 #1
[  153.318879][    T1] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  153.329352][    T1] Call trace:
[  153.332545][    T1]  dump_backtrace+0x0/0x224
[  153.336945][    T1]  show_stack+0x20/0x2c
[  153.341000][    T1]  dump_stack+0xfc/0x184
[  153.345149][    T1]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
[  153.351465][    T1]  hugetlbfs_fill_super+0x424/0x43c
[  153.356560][    T1]  vfs_get_super+0xcc/0x170
[  153.360959][    T1]  get_tree_nodev+0x28/0x34
[  153.365358][    T1]  hugetlbfs_get_tree+0xfc/0x128
[  153.370193][    T1]  vfs_get_tree+0x54/0x158
[  153.374513][    T1]  fc_mount+0x1c/0x5c
[  153.378399][    T1]  mount_one_hugetlbfs+0x54/0xc8
[  153.383233][    T1]  init_hugetlbfs_fs+0x18c/0x268
[  153.388068][    T1]  do_one_initcall+0x6c/0x144
[  153.392647][    T1]  do_initcall_level+0x158/0x1c4
[  153.397480][    T1]  do_initcalls+0x68/0xb0
[  153.401706][    T1]  do_basic_setup+0x28/0x30
[  153.406105][    T1]  kernel_init_freeable+0x19c/0x228
[  153.411208][    T1]  kernel_init+0x14/0x208
[  153.415436][    T1]  ret_from_fork+0x10/0x18


[  194.312926][ T1828] UBSAN: shift-out-of-bounds in =
./include/linux/hugetlb.h:584:11
[  194.320664][ T1828] shift exponent 4294967285 is too large for 32-bit =
type 'int'
[  194.328103][ T1828] CPU: 194 PID: 1828 Comm: systemd-journal Tainted: =
G             L    5.7.0-rc2-next-20200420 #1
[  194.338558][ T1828] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  194.349010][ T1828] Call trace:
[  194.352183][ T1828]  dump_backtrace+0x0/0x224
[  194.356560][ T1828]  show_stack+0x20/0x2c
[  194.360595][ T1828]  dump_stack+0xfc/0x184
[  194.364724][ T1828]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
[  194.371020][ T1828]  hugetlb_total_pages+0x100/0x128
[  194.376017][ T1828]  vm_commit_limit+0x54/0xb0
[  194.380484][ T1828]  meminfo_proc_show+0x8f4/0xc4c
[  194.385297][ T1828]  seq_read+0x380/0x930
[  194.389353][ T1828]  pde_read+0x5c/0x78
[  194.393232][ T1828]  proc_reg_read+0x74/0xc0
[  194.397528][ T1828]  __vfs_read+0x84/0x1d0
[  194.401646][ T1828]  vfs_read+0xec/0x124
[  194.405588][ T1828]  ksys_read+0xb0/0x120
[  194.409643][ T1828]  __arm64_sys_read+0x54/0x88
[  194.414195][ T1828]  do_el0_svc+0x128/0x1dc
[  194.418405][ T1828]  el0_sync_handler+0x150/0x250
[  194.423157][ T1828]  el0_sync+0x164/0x180
[  194.427425][ T1828] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[  194.436930][ T1828] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[  194.446355][ T1828] UBSAN: shift-out-of-bounds in =
mm/hugetlb.c:3564:23
[  194.453190][ T1828] shift exponent 4294967285 is too large for 64-bit =
type 'unsigned long'
[  194.461752][ T1828] CPU: 194 PID: 1828 Comm: systemd-journal Tainted: =
G             L    5.7.0-rc2-next-20200420 #1
[  194.472245][ T1828] Hardware name: HPE Apollo 70             =
/C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
[  194.482720][ T1828] Call trace:
[  194.485909][ T1828]  dump_backtrace+0x0/0x224
[  194.490312][ T1828]  show_stack+0x20/0x2c
[  194.494368][ T1828]  dump_stack+0xfc/0x184
[  194.498513][ T1828]  __ubsan_handle_shift_out_of_bounds+0x304/0x344
[  194.504828][ T1828]  hugetlb_report_meminfo+0x25c/0x2ac
[  194.510103][ T1828]  meminfo_proc_show+0xc08/0xc4c
[  194.514938][ T1828]  seq_read+0x380/0x930
[  194.518993][ T1828]  pde_read+0x5c/0x78
[  194.522874][ T1828]  proc_reg_read+0x74/0xc0
[  194.527190][ T1828]  __vfs_read+0x84/0x1d0
[  194.531335][ T1828]  vfs_read+0xec/0x124
[  194.535304][ T1828]  ksys_read+0xb0/0x120
[  194.539371][ T1828]  __arm64_sys_read+0x54/0x88
[  194.543958][ T1828]  do_el0_svc+0x128/0x1dc
[  194.548187][ T1828]  el0_sync_handler+0x150/0x250
[  194.552936][ T1828]  el0_sync+0x164/0x180

>=20
> .../admin-guide/kernel-parameters.txt         |  40 ++--
> Documentation/admin-guide/mm/hugetlbpage.rst  |  35 ++++
> arch/arm64/mm/hugetlbpage.c                   |  30 +--
> arch/powerpc/mm/hugetlbpage.c                 |  30 +--
> arch/riscv/mm/hugetlbpage.c                   |  24 +--
> arch/s390/mm/hugetlbpage.c                    |  24 +--
> arch/sparc/mm/init_64.c                       |  43 +---
> arch/x86/mm/hugetlbpage.c                     |  23 +--
> include/linux/hugetlb.h                       |   2 +-
> mm/hugetlb.c                                  | 190 +++++++++++++++---
> 10 files changed, 271 insertions(+), 170 deletions(-)
>=20
> --=20
> 2.25.2
>=20
>=20

