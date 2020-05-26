Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDC521A3CE2
	for <lists+linux-s390@lfdr.de>; Fri, 10 Apr 2020 01:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgDIXd3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 9 Apr 2020 19:33:29 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:42565 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgDIXd3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Apr 2020 19:33:29 -0400
Received: by mail-qk1-f177.google.com with SMTP id x66so583812qkd.9
        for <linux-s390@vger.kernel.org>; Thu, 09 Apr 2020 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=wgkRZRi8nt7Sf7G72jvNnmXYWgvPJ9i4m7QAjv8A1Q4=;
        b=eLkZUa7uSnG9us9m8iieDngtLxC+HG8pwltFYbdcs1NrzCJ1z3j+wxkNs3NqTPdiFP
         MB5ptKIKgNVb9MAykm/y4xfy/zxJ6uC9yZIRf4ym7kjk420gx5der2gbEGnkHcTlAfW5
         VFONC2kJFuzKqfWOxd3DsyyC9ADMR0PVZafQqj5DMAUNJomT2s8FjsnRTwDf8cjlEMCw
         MjQv/woOdikoiIjG4NfBeicUqRY6QOBFzYkE3f/h58uQT+yc6yzDQ8MJVQUwS02YaFsM
         LRDjjuAaYaaKPTWVlyERWBcaSg/wwEhfLVTeAk2WriI0eqtNkz+EZjrL2Q3cU9MaVTEV
         2CaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=wgkRZRi8nt7Sf7G72jvNnmXYWgvPJ9i4m7QAjv8A1Q4=;
        b=XHI3PW49NaBbWJtCso3gkP+ulIj2ncQaABjiBADxezGI9KUjVwfep6uDhIfJ6qVZmh
         EpsYHlbKO3qBuMsXlbRBtvN0fsY86dxt7U+MDXENV2WeUIKzrO5rS2aVyeRmN3s+Moxs
         idSiYEZiq2TZlxMKpuxHJExQtAgfsIGQEqHQ/UDk9rIMi+AA0lalWGaoSzfiFH8+oelX
         7LkpLo5yiDEYXiHIP9kReJO7zZQJ+t8Bk6NQ8Ms/DRyV+iriTspcOBr3k4pF/GG7RMOT
         c4qKLn+3S04fIT3VtrWprjpGY+iLldoOEA3D+C/Q+j4epMLbsUoptWI9IuVb8kxn6G8U
         mSIw==
X-Gm-Message-State: AGi0PuZbuPDLNjPFe9LVUK3tUxms5v1WHwaQPB70vtXY2TNv4dEPJKP8
        O+QGDNXfG51ZdNpnOt0U1Q643A==
X-Google-Smtp-Source: APiQypIzSPzGROYB8GlTbojz86NPjyo4ppagaRVsPbtzp2x4iX5szJMdNvssk3f7fl49ywb/72hn2A==
X-Received: by 2002:a37:b93:: with SMTP id 141mr1489123qkl.192.1586475208596;
        Thu, 09 Apr 2020 16:33:28 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o16sm281681qki.110.2020.04.09.16.33.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 16:33:28 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
Message-Id: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
Date:   Thu, 9 Apr 2020 19:33:25 -0400
Cc:     Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Reverted the linux-next commit on today=E2=80=99s tree,

d3ef5536274f (=E2=80=9Cblock: fix busy device checking in =
blk_drop_partitions=E2=80=9D)

makes IBM partition to be recognized again on s390 rootfs,

01: [   83.443963]  dasda:VOL1/  0X0121: dasda1                          =
      =20
01: [   85.124667] qeth 0.0.8000 enc8000: renamed from eth0              =
      =20
01: [   85.731860] dasd-eckd 0.0.0120: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   86.076722]  dasdb:VOL1/  0X0120: dasdb1 dasdb2

Otherwise, it is DOA,

00:          Starting Show Plymouth Boot Screen...                       =
      =20
00: [   37.202263] qeth 0.0.8000: portname is deprecated and is ignored  =
      =20
00: [   37.677993] qdio: 0.0.8002 OSA on SC 4 using AI:1 QEBSM:0 PRI:1 =
TDD:1 SIG
00: A:RW A                                                               =
      =20
00: [   37.770970] qeth 0.0.8000: MAC address 02:de:ad:be:ef:87 =
successfully reg
00: istered                                                              =
      =20
00: [   37.771547] qeth 0.0.8000: Device is a Virtual NIC QDIO card =
(level: V642
00: )                                                                    =
      =20
00: [   37.771547] with link type Virt.NIC QDIO.                         =
      =20
00: [   38.036231] ccw_init (415) used greatest stack depth: 56496 bytes =
left  =20
00:          Starting dracut initqueue hook...                           =
      =20
00: [   39.176304] dasd-eckd 0.0.0120: A channel path to the device has =
become o
00: perational                                                           =
      =20
00: [   39.453273] dasd-eckd 0.0.0120: New DASD 3390/0E (CU 3990/01) =
with 100170
00:  cylinders, 15 heads, 224 sectors                                    =
      =20
00: [   39.655564] dasd-eckd 0.0.0121: A channel path to the device has =
become o
00: perational                                                           =
      =20
00: [   39.722706] dasd-eckd 0.0.0121: New DASD 3390/0E (CU 3990/01) =
with 100170
00:  cylinders, 15 heads, 224 sectors                                    =
      =20
01: [   41.133963] dasd-eckd 0.0.0121: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   41.145510] dasd-eckd 0.0.0120: DASD with 4 KB/block, 72122400 KB =
total s
01: ize, 48 KB/track, compatible disk layout                             =
      =20
01: [   41.609625] qeth 0.0.8000 enc8000: renamed from eth0 =20
01: [   41.609625] qeth 0.0.8000 enc8000: renamed from eth0              =
      =20
01: Warning: /dev/mapper/rhel_ibm--z--135-root does not exist            =
      =20
01: Warning: /dev/rhel_ibm-z-135/root does not exist                     =
      =20
01: Warning: /dev/rhel_ibm-z-135/swap does not exist                     =
      =20
01:                                                                      =
      =20
01: Generating "/run/initramfs/rdsosreport.txt"                          =
      =20
01:                                                                      =
      =20
01:                                                                      =
      =20
01: Entering emergency mode. Exit the shell to continue.                 =
      =20
01: Type "journalctl" to view system logs.                               =
      =20
01: You might want to save "/run/initramfs/rdsosreport.txt" to a USB =
stick or /b
01: oot                                                                  =
      =20
01: after mounting them and attach it to a bug report.                   =
      =20
01:                                                                      =
      =20
01:                                                                      =
      =20
00: dracut:/#=20

