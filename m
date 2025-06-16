Return-Path: <linux-s390+bounces-11130-lists+linux-s390=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A54ADB04B
	for <lists+linux-s390@lfdr.de>; Mon, 16 Jun 2025 14:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8F83A2B0A
	for <lists+linux-s390@lfdr.de>; Mon, 16 Jun 2025 12:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093EF285CB4;
	Mon, 16 Jun 2025 12:34:26 +0000 (UTC)
X-Original-To: linux-s390@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571F6285C92
	for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750077265; cv=none; b=KOYIdD1qe0WcY0OE2XAAeHAb/caI10R8xx4+xpFBeA/I//deNC8AZ332u6kmO1Ep1ziTpEElb334y4/7Jkrtv01f/+Ffe2jvfTiFFABzf9fneg49bzAwPxmbKGTEGSmKBOTpALJnNNqWbva4b5qEv6H+Ei23tMze61BpHiEhbDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750077265; c=relaxed/simple;
	bh=KZNprXaoNfoaHYjHemA6YofvAUOkORsU2bqHvO7dDUs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XYWhL1BBgEWy6bHYhay1TVQI1x/l6mTOdPSDk6WytpkcHEXtlsAFxeE6knJByiFg80w9+n8vfb9Vey18nugWQ7mrUESXeZuQpgpNF7u1XrN+g5q3p1PzRe5pxg5wY7EJ5u2jNTN9SYyQ5wu9cH+dSXEN+rqlyLnAJHg8WW78ZVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3de0f73f9e0so12877945ab.1
        for <linux-s390@vger.kernel.org>; Mon, 16 Jun 2025 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750077263; x=1750682063;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EywSoWx1oh75bdKkhb/CF3mvca8guENbG+VQo+//llY=;
        b=bhDTGVAE2n9qoAio4jTw3sKgq0MLFoByNQalzp6sGf9ZFgNlxhnpUaKojgTfHWKyP9
         szAAYMeaVaC9AMsD7h1ryxnH3eIhyMUfq9VnhnLPV9zGDW49/u9HAcjIMq3m2esGvU6e
         hW/wm8zN8M8ZpvnjgpEZzAh2Q0/JDNO+m6jDEanm9zm7YvJaX8LPtKQgacklRVM7Fxwd
         pqOl5akqt+JO1WinNrIQuurJVYsn0xTfWsCSzRpGrg5u17umEUiX6xo8fxaepFtnPt5B
         oknR90iBU7NSWXfpreb/bkwIdYyf3gfjsNerwFLA1dcMBJEtqO19TskwAw0Ne3ea2lCq
         0S2w==
X-Forwarded-Encrypted: i=1; AJvYcCWe42T96PEW+qahngHeOnLo9k7j2TGMtx2ZSpVX+qyBPkbzsgPkMmjm8fWMVIZsz90K5D2GHCOs0F3/@vger.kernel.org
X-Gm-Message-State: AOJu0YzE07WfgpUUeWMTy9jOHztQK1dviw8CRWuG2H8NDzIhoIDnM2wp
	y/A4p/VonIdgf9y1GDj5A+3SlFSVysvs5YlhphwU8gl0jXOmJy1LSZpJwXTPDw9l/Q+s9uqKzS5
	8IL4Mm2I4wE2lxKPAPFn79QYM9yAAjrb/hGN3PSa2JwrtFuozJ6MV2FECNeQ=
X-Google-Smtp-Source: AGHT+IELIt9EJpzp0lXMB6qbr/z7PV1C/VGfrhZiQunu8N7r/BP9kLgcRjsJMR1aWG1N/ZdBaa3Twfku9bGlKYiuSPN8oW9SZGGG
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194f:b0:3dd:ebb5:5370 with SMTP id
 e9e14a558f8ab-3de07d3404bmr99194745ab.22.1750077263538; Mon, 16 Jun 2025
 05:34:23 -0700 (PDT)
Date: Mon, 16 Jun 2025 05:34:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68500f4f.050a0220.2608ac.0001.GAE@google.com>
Subject: [syzbot] Monthly smc report (Jun 2025)
From: syzbot <syzbot+list7085bff455d583cbad1e@syzkaller.appspotmail.com>
To: jaka@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello smc maintainers/developers,

This is a 31-day syzbot report for the smc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/smc

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 340     Yes   general protection fault in smc_diag_dump_proto
                  https://syzkaller.appspot.com/bug?extid=f69bfae0a4eb29976e44
<2> 93      Yes   possible deadlock in smc_release
                  https://syzkaller.appspot.com/bug?extid=621fd56ba002faba6392
<3> 92      Yes   general protection fault in __smc_diag_dump (3)
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

