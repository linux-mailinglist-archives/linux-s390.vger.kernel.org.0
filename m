Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0550DD1AEE
	for <lists+linux-s390@lfdr.de>; Wed,  9 Oct 2019 23:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbfJIV3e (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Oct 2019 17:29:34 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35146 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732076AbfJIV3e (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Oct 2019 17:29:34 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so3658029qkf.2
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2019 14:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=dIDzN1TKiY/MFPYq9mr7pNPGjNRJ119lyvL+5vcql2k=;
        b=ByPkjco4JiEeJAqac+I/JzwSeFttDQ8uxHxG2x2rBXKA107pUwCku9HH8nPFZcQrsr
         KTzfGf2yfp60U1sxA/hw25HWA/5VoQhySL7r7Br8hD3Ee90NHuZq3/b3D/xpMqdmwHaq
         zqCPxYlhtGVomUAiW+xXeawFqOmPo5VYZwLnpxda+SxwZu0R7xOfkfCAYfIpNTFOKPgT
         onf/peae0XC2xIqf6f88DYk+4bE3rgObIPAvacCQ9hmaEfs5LeKJKpyS0RQrVHytAEL+
         pumc4CUONqdgLXnVd99g4gvmZv4L0l+IMQCaEqyfY49vTxa4fyGUOidKjB+uf/qe0Zrv
         DfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
         :content-transfer-encoding;
        bh=dIDzN1TKiY/MFPYq9mr7pNPGjNRJ119lyvL+5vcql2k=;
        b=me+dsIJ2w4iSa4zlz9zMKqLURPdXefgJLEtIiLekyLxJRQjxJU6MA8a0bZGiR9ZMgm
         kgWxwH5GU1PuNIgOeOTQ9czORmOOoBvxH6wMMta2lyoWUSUiHDyOesHKNfPqBncyyGWP
         Uw9ojMWEcfEH+dLASuQMB+6m0jXLr3t4LCbXc0/8XPOj84yvE+g3aBNfAqAVCQAJBX8U
         sH3xxLxGBworV79Zb1rV651rzJdjH8xu0ubKKq3jj8lrmRASmopJG0eWXSUROd9/srMq
         Eu+hoLElmK1j1qJhu7PDBoTpcZaeIt12bW9NBQu4DPQSLUlzLbN6Wsi5p6ARnf7+ftlv
         k3zg==
X-Gm-Message-State: APjAAAWAfaUscHPSRuFajzZ0QlF3Blqdphyc+JzKu1a9ti6ADGNjG+2S
        ZM5GY3+Rhki9gRTSKZ811UCxkA==
X-Google-Smtp-Source: APXvYqw0RMsb2vJiOo9HceATB2lQ9s1WY/bkZQYqu9XLdiPxPIU7x2Vv2Gq4yRry8p0DZ0uG60MmOQ==
X-Received: by 2002:a05:620a:2193:: with SMTP id g19mr6125307qka.184.1570656572646;
        Wed, 09 Oct 2019 14:29:32 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n44sm2260197qtf.51.2019.10.09.14.29.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Oct 2019 14:29:31 -0700 (PDT)
Message-ID: <1570656570.5937.24.camel@lca.pw>
Subject: "reuse mergeable anon_vma as parent when fork" causes a crash on
 s390
From:   Qian Cai <cai@lca.pw>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Date:   Wed, 09 Oct 2019 17:29:30 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The linux-next commit "mm/rmap.c: reuse mergeable anon_vma as parent when fork"
[1] causes a crash on s390 while compiling some C code. Reverted it fixes the
issue.

[1] https://lore.kernel.org/lkml/20191004160632.30251-1-richardw.yang@linux.intel.com/

00: [  330.681233] vma 0000000049a08008 start 000003ff8ee7f000 end 000003ff8eee4
00: 000                                                                         
00: [  330.681233] next 000000004f272008 prev 0000000065c84230 mm 0000000037d1c1
00: 00                                                                          
00: [  330.681233] prot 711 anon_vma 000000001f4e4a80 vm_ops 0000000000000000   
00: [  330.681233] pgoff 3ff8ee7f file 0000000000000000 private_data 00000000000
00: 00000                                                                       
00: [  330.681233] flags: 0x8100073(read|write|mayread|maywrite|mayexec|account|
00: softdirty)                                                                  
00: [  330.681344] ------------[ cut here ]------------                         
00: [  330.681357] kernel BUG at include/linux/rmap.h:159!                      
00: [  330.681442] illegal operation: 0001 ilc:1 [#1] SMP DEBUG_PAGEALLOC       
00: [  330.681460] Modules linked in: ip_tables x_tables xfs dasd_fba_mod dasd_e
00: ckd_mod dm_mirror dm_region_hash dm_log dm_mod                              
00: [  330.681502] CPU: 0 PID: 7651 Comm: cc1 Not tainted 5.4.0-rc2-next-2019100
00: 9+ #4                                                                       
00: [  330.681516] Hardware name: IBM 2964 N96 400 (z/VM 6.4.0)                 
00: [  330.681530] Krnl PSW : 0704c00180000000 00000000531d9cac (__vma_adjust+0x
00: cf4/0xf30)                                                                  
00: [  330.681561]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0
00:  RI:0 EA:3                                                                  
00: [  330.681579] Krnl GPRS: 0000000000000001 0000030000000000 0000000000000146
00:  000000006cc03da4                                                           
00: [  330.681595]            0000030000000000 000000005304378c 00000000513de008
00:  0000000000000000                                                           
00: [  330.681611]            0000000049a08008 0000000049a08080 0000000000000000
00:  000000005a178438                                                           
00: [  330.681627]            0000000053bae3b0 0000000037d1c100 00000000531d9ca8
00:  00000000235ef880                                                           
01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
 CPU 01.                                                                        
01: HCPGSP2629I The virtual machine is placed in CP mode due to a SIGP stop from
 CPU 00.                                                                        
00: [  330.681668] Krnl Code: 00000000531d9c9c: fae0b9040028        ap      2308
00: (15,%r11),40(1,%r0)                                                         
00: [  330.681668]            00000000531d9ca2: c0e5ffff145f        brasl   %r14
00: ,531bc560                                                                   
00: [  330.681668]           #00000000531d9ca8: a7f40001            brc     15,5
00: 31d9caa                                                                     
00: [  330.681668]           >00000000531d9cac: c020005f1a5a        larl    %r2,
00: 53dbd160                                                                    
00: [  330.681668]            00000000531d9cb2: c0e50015ec2b        brasl   %r14
00: ,53497508                                                                   
00: [  330.681668]            00000000531d9cb8: e320f0d80004        lg      %r2,
00: 216(%r15)                                                                   
00: [  330.681668]            00000000531d9cbe: c0e500040de1        brasl   %r14
00: ,5325b880                                                                   
00: [  330.681668]            00000000531d9cc4: 4120d038            la      %r2,
00: 56(%r13)                                                                    
00: [  330.682579] Call Trace:                                                  
00: [  330.682665] ([<00000000531d9ca8>] __vma_adjust+0xcf0/0xf30)              
00: [  330.682684]  [<00000000531da4f0>] vma_merge+0x608/0x6b8                  
00: [  330.682699]  [<00000000531de3b8>] mmap_region+0x1e0/0x9b0                
00: [  330.682713]  [<00000000531defec>] do_mmap+0x464/0x650                    
00: [  330.682730]  [<00000000531930ba>] vm_mmap_pgoff+0x132/0x1c0              
00: [  330.682745]  [<00000000531da7b4>] ksys_mmap_pgoff+0xd4/0x458             
00: [  330.682761]  [<00000000531dac54>] __s390x_sys_old_mmap+0xdc/0x108        
00: [  330.682779]  [<00000000537dcdd0>] system_call+0xd8/0x2b4                 
00: [  330.682791] INFO: lockdep is turned off.                                 
00: [  330.682801] Last Breaking-Event-Address:                                 
00: [  330.682815]  [<00000000531d9ca8>] __vma_adjust+0xcf0/0xf30               
00: [  330.682833] Kernel panic - not syncing: Fatal exception: panic_on_oops
