Return-Path: <linux-s390+bounces-12067-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F4077B2A5D1
	for <lists+linux-s390@lfdr.de>; Mon, 18 Aug 2025 15:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA321B237FA
	for <lists+linux-s390@lfdr.de>; Mon, 18 Aug 2025 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E7322DDA;
	Mon, 18 Aug 2025 13:25:40 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E364D322759
	for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 13:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755523540; cv=none; b=QmdHVlRW/wzUjbQwQTiPO5qtKuf9vV3nWye39Vs1TeI/f15+Wn6kYXDCPGLRRRqsUC62xzDASJcsM0G1k2pnD8GXDQxc3qcL/9w19LEgsiEgi8vbqNOlBhmQH5YWnBADyxaGLBih4s4u8yGApvqaeGmcTk9ZSPod8FfkRpzJjGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755523540; c=relaxed/simple;
	bh=NFC4rDjWt49RV2YrszLSI351599VGmLwqN1VTO4QPbM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bb6LPAg/jPbIm3FKQv1JYkYdV1x91BXP63otGHdzkltXyCsQxnWn5rK4/gY56i8u0UsaPggRGzzgX5ptxP313qYDc0eyANJ3/wI7uVRMfYKCsB79xYGW550VD+EalVOoCWAqNjjDQ22fxbOtsCHz0gcs00c8Jy97H4MG+edmS+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-88432d88f64so1225878839f.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Aug 2025 06:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755523538; x=1756128338;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=buVrXnLbiUfXOlmQ5OxmbqCNm4uwO1BGwKJJdtwt5t8=;
        b=PjxIoGt5FokN+6iaqIjmm4VLjz49Jlmv9Zz5SZHHFKXKxds3WtYTO+mqoCdpfZ3A33
         yUX2qDYxxSZJgsadNLCbEAzKUUgN+XGjWckOq9A/ZVZh/7kSDW70a+YldLtr5U8ATbuv
         LmUF9UPHh2c3F3TvPWNlvz8y3GxOHpDYwIfE/niWqYb6LnardEBLZj/3dVbU2RG1LT/8
         gIekK/FbeLn7t0kO8KqF0klVAhA9uskZqeHtDN4GGeyR+IGgOI3ELLA9JYlvLBhqaUZM
         8AXK6zcjJocZvk0nqgn9lWNt5j8Y46zCHfW381isONDZrXJwUC4GEmP/I8S8hY668ZJC
         ypRw==
X-Forwarded-Encrypted: i=1; AJvYcCWuEnY0b923xrmCNBp+gT02rDRIkwS04sk2tXIbCpwCl+0OCKS17T8ZtVKb3fWDF6XUsbi0sV4kfrBK@vger.kernel.org
X-Gm-Message-State: AOJu0YzOf53L8bdfg/d+ZaIj0YxR0luNNvD7D6vOrTkFMFKW6sFY/wQg
	G8GM3obOQCUL4dcfAUUheuK4jLtDC5OUdCNC8h0w797eEV2KzsgPpoQmv8qLLK0r3OQR0v1pbrR
	E+i7tZfVHCh30KPIdibc4A1k9mSZxVEDst8f6ZMLMP3fEHspGuTQS4XBefZU=
X-Google-Smtp-Source: AGHT+IGDJ1IFJp0mWrBuEQafKJ/BcwQEtblJCF2eT/di6EdS+WEiAj/bZfDdJqvCIntYVSPSDkvxsgPl15kaaJGrssSOoRKXQhLi
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3410:b0:86c:e686:ca29 with SMTP id
 ca18e2360f4ac-8843e34cd35mr2395798539f.2.1755523538112; Mon, 18 Aug 2025
 06:25:38 -0700 (PDT)
Date: Mon, 18 Aug 2025 06:25:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a329d2.050a0220.e29e5.00aa.GAE@google.com>
Subject: [syzbot] Monthly smc report (Aug 2025)
From: syzbot <syzbot+list2777bcfe69a1c7125c95@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 5 issues are still open and 45 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 431     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 113     Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 16      Yes   KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
                  https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

