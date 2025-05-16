Return-Path: <linux-s390+bounces-10634-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722BFAB99EE
	for <lists+linux-s390@lfdr.de>; Fri, 16 May 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFF43A7DB4
	for <lists+linux-s390@lfdr.de>; Fri, 16 May 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF4722DF97;
	Fri, 16 May 2025 10:17:32 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF90213E8E
	for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390652; cv=none; b=Jmcmdg0z6nF4hvNDDNF49+pAx0iWT48438Pi6QXFPu1R1AKB1pcHxTMryzx5OMIg9/LBZl1xzrpU8P/FfYdbFBUSEfkjoNmJqZIpqg6r+OMqEvI+2YvyV/qf8DtpSieec8SyHqTb1XfGJKWYZ/foTK0FQg3hQhOGZ2ULGgPhGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390652; c=relaxed/simple;
	bh=Xol6wi0uV1fmTpSn2Y8V20Qyl8nzYWBqxDUmPlg3yJM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lUWAorMlH4WqV0q2EFCuvupUdfpuOn3bgZTPuWCkvReDfE+L+IIOtwNnRd9ekJY3cbWxcgva8SChXLTtygpHDdBw/IfumesZG160FX0UisVGWI8bnUuV394SrWK5RFaXCYk+rgkqme3oGR5zAUkrwNoOWk8RL88/wvWZ2aj0kkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3db6dc76193so37238915ab.2
        for <linux-s390@vger.kernel.org>; Fri, 16 May 2025 03:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390649; x=1747995449;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6M2DPVjlQQj1l7tZgOW7xpWl0T5tZezkpbkFHSK1Y5E=;
        b=CJEZoisEdcvhgSa9oK48JILDSH/ghq1ZdS9YUHdcVK7cgZ6Y23ZrhiQ5/DJ7iWbfjp
         kuhXEHy+mHACb3stePxs5UnA48YqHOW8nhiRD273bqJhjtozAmYM67TPpnq2A7aypYtf
         n3/Hc2OzJAycPvW4t350IHBoi0yQBc/mnN20KE3cxIK3PQs2yZr4UMoFQqdNcAVTThY/
         N+q9w/Y970KErB30T4Pbl/ONFxK2+6dQLDzVd0Im8VYmP9hISdFaXHnYWYyq/IWnvuzV
         Lf7wh0tUf1CxEZkBaexhixWiAoXwmFIzamD9Ws5xF5j1ILBRqqbWgTGu3rAiBHoOkGBU
         zlEA==
X-Forwarded-Encrypted: i=1; AJvYcCVdZJvN8u6hP2ikgb0VtbyTP58AJPNlpGFEo1kiCFsNVVhiYOS30ytbfMZQwetcRoXxBgHTuakXnmrT@vger.kernel.org
X-Gm-Message-State: AOJu0YxUz+ESStBOrU4t5D/IdduhRYOECvad3fROzFqDe3jw3yXoHPQE
	cI7GwjPXW1TWT7x5OCx3w2xEhI6NYGFjGc1Isdx4P2iNjBIEBBrEY3dobG3Qabgd0Vc0WyNFY+D
	bEHKRY4EhBNCO3iIEg7lW16k5ym0Hgr5ndcJC55ZmVPgJ4ms/Qyb4X6orZIE=
X-Google-Smtp-Source: AGHT+IGfopz6HPz9olGYC+CF+abURQHYa4/P/72pxan4xxCeMOnsBg7LfD2zgeozwxYJl9XRuPS2SrDFjXshZ3Oivd2P5DV71rBk
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18c7:b0:3d8:1bd0:9a79 with SMTP id
 e9e14a558f8ab-3db84334fa6mr37329945ab.21.1747390649487; Fri, 16 May 2025
 03:17:29 -0700 (PDT)
Date: Fri, 16 May 2025 03:17:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682710b9.a70a0220.38f255.0001.GAE@google.com>
Subject: [syzbot] Monthly smc report (May 2025)
From: syzbot <syzbot+listf6f56d6a8ea41d6b17f7@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 12 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 299     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 82      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 71      Yes   general protection fault in __smc_diag_dump (3)
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

