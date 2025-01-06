Return-Path: <linux-s390+bounces-7979-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD25A02267
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jan 2025 11:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFA93A2A74
	for <lists+linux-s390@lfdr.de>; Mon,  6 Jan 2025 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0511D63EA;
	Mon,  6 Jan 2025 10:01:30 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC8D1D9A63
	for <linux-s390@vger.kernel.org>; Mon,  6 Jan 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736157690; cv=none; b=PtMk2XvjUixfe59cXAtqOG5okoKDuTcfPamxFD6QlR7Nd2hkdK2cQMp54BVLht3PNq9sZ1H1x9JccZ9qicCZcn+Z2MDaTNJfqgjeq3C3J5zUHJRRaZ7XHfYZc4xDGpGaVT9cZ1pkRDcdvLG7lOcjJN4jKBMXFJhctkrh75mGJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736157690; c=relaxed/simple;
	bh=YEJy09+VZi/NFVG++wR5nJMwmmb7rfhGiYKZrkpbdr0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BbVqCWgmvZdAxOZ/q+F4/nvYTPtBgUI5xFv7OxRTipPEzFe2R93WfK+O/hYi/nyb62IyEawoYhnm3j/NxmTC73sLrOflUNdcR3vA0TdJRceC2jCrJi6ASyrnTmrrFuPph+W4IRPj/dP0mYYwANcc+9+MzBskfdsxPniM0weBC2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a817e4aa67so139192065ab.2
        for <linux-s390@vger.kernel.org>; Mon, 06 Jan 2025 02:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736157687; x=1736762487;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7v37jBGNMDkgAc2Y1HhS0TznHkH3BVfG42P2zjGCNk=;
        b=eoUJjP/HZg1VS4dVUCwQ5bdiO/kf5HyXpWUDAzcm5cmtMgtTDUtHLYPNg8EQlYTKuv
         AgykhW19lUCZVMKeJCt2X5ZRRzHFPahGO2m+7ixNTe1A8tFvCA1AfSSPQgV07In9zoen
         trpTb6jWW1dnFrEfwGn7Xulm1u3h8mbSO3VqHfKYTIMiFsxjTGb4Ah/73NJWnF6MRYOm
         htZc99Xjvx0RvYjTze8PjWTXeR8oNnWZVCdBXXeYiUMpK0j5FQsCB4MwIaWDLiJViZOD
         ybPudgTKuDIvzLZ4NTCDek36qbzlXXoF7hr9OmndgUR72gFY6U+kVQsQpK73iX+uzxn6
         4L2w==
X-Forwarded-Encrypted: i=1; AJvYcCXcIHXQXzvRfu5efHw9IVNVNrVUolAe5CSgvEJ8f+mIiBe6tominDiTApkGnmaMQkeTpi9ToVzln+8J@vger.kernel.org
X-Gm-Message-State: AOJu0YwMMFdxRy8UerXpe5pk1RxNPlH/itSiJ41yc64wI8nd4fx4VPJh
	fUKsT/pyY0uSY7rmQaFk4SylGDv3wawH/ujM93nn9FTKtPCU6rXgWVFE+RMJ7ttmhX+NDOTL4BL
	+yyQHLt6wYkGow3CVkjeMpDPPalK22pWlTkNgLCuXxZ1OP4j/WVWKxoM=
X-Google-Smtp-Source: AGHT+IFF07DySG9r4IU0XKMfJCCKh9f2dT8Pr6Nn5OP5wcy9Fa1WWZERA0OF+peMqVoKRkqOt7a2wnGmIRWpCuM7b8sO5aeAZk6i
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c87:b0:3a7:172f:1299 with SMTP id
 e9e14a558f8ab-3c2d2d50d0dmr498105615ab.12.1736157687057; Mon, 06 Jan 2025
 02:01:27 -0800 (PST)
Date: Mon, 06 Jan 2025 02:01:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677ba9f7.050a0220.a40f5.0008.GAE@google.com>
Subject: [syzbot] Monthly s390 report (Jan 2025)
From: syzbot <syzbot+list4a63d4f06484a1c63c1b@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello s390 maintainers/developers,

This is a 31-day syzbot report for the s390 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/s390

During the period, 1 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 43 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 13861   Yes   possible deadlock in smc_switch_to_fallback (2)
                  https://syzkaller.appspot.com/bug?extid=bef85a6996d1737c1a2f
<2> 2301    Yes   possible deadlock in smc_vlan_by_tcpsk
                  https://syzkaller.appspot.com/bug?extid=c75d1de73d3b8b76272f
<3> 153     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<4> 40      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<5> 39      Yes   general protection fault in __smc_diag_dump (3)
                  https://syzkaller.appspot.com/bug?extid=271fed3ed6f24600c364

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

