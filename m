Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB995C941
	for <lists+linux-s390@lfdr.de>; Tue,  2 Jul 2019 08:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbfGBGYE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Jul 2019 02:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:50760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfGBGYE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Jul 2019 02:24:04 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 188F320881;
        Tue,  2 Jul 2019 06:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562048643;
        bh=RXHDYjpEhuWCagYcwS1U0tzzsb1eaa8TeIX5lT/bL/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=PBl5NPeuWqZxbOTd2Rg3l3Fl7T/ndjTO3ia2Scq6nhud3z0YQbEbM9BU2L++DIKYN
         dctI7fbzkXF9NkRj2/u2WiI8CT+WsK+sGxbP7CZeRdvO04QRLFvktNFdit457Q+cTd
         1ViXnz9pxl5KctvELhn1m/QPfklnIS5pEhq1/zLk=
Date:   Mon, 1 Jul 2019 23:24:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Reminder: 6 open syzbot bugs in "net/smc" subsystem
Message-ID: <20190702062401.GB3054@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[This email was generated by a script.  Let me know if you have any suggestions
to make it better, or if you want it re-generated with the latest status.]

Of the currently open syzbot reports against the upstream kernel, I've manually
marked 6 of them as possibly being bugs in the "net/smc" subsystem.  I've listed
these reports below, sorted by an algorithm that tries to list first the reports
most likely to be still valid, important, and actionable.

Of these 6 bugs, 3 were seen in mainline in the last week.

Of these 6 bugs, 1 was bisected to a commit from the following person:

	Ursula Braun <ubraun@linux.ibm.com>

If you believe a bug is no longer valid, please close the syzbot report by
sending a '#syz fix', '#syz dup', or '#syz invalid' command in reply to the
original thread, as explained at https://goo.gl/tpsmEJ#status

If you believe I misattributed a bug to the "net/smc" subsystem, please let me
know, and if possible forward the report to the correct people or mailing list.

Here are the bugs:

--------------------------------------------------------------------------------
Title:              WARNING in smc_unhash_sk (2)
Last occurred:      0 days ago
Reported:           79 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=f650845a184aed6947c0dd0f4d99d561335a7c31
Original thread:    https://lkml.kernel.org/lkml/000000000000ac48ed05866bbc2c@google.com/T/#u

This bug has a C reproducer.

This bug was bisected to:

	commit 50717a37db032ce783f50685a73bb2ac68471a5a
	Author: Ursula Braun <ubraun@linux.ibm.com>
	Date:   Fri Apr 12 10:57:23 2019 +0000

	  net/smc: nonblocking connect rework

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+bd8cc73d665590a1fcad@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000ac48ed05866bbc2c@google.com

--------------------------------------------------------------------------------
Title:              WARNING: ODEBUG bug in __sk_destruct
Last occurred:      0 days ago
Reported:           428 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=591666b46bf0d9e2fbb8dbb386982d12ba804648
Original thread:    https://lkml.kernel.org/lkml/000000000000451f9d056aff4397@google.com/T/#u

This bug has a C reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+92209502e7aab127c75f@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/000000000000451f9d056aff4397@google.com

--------------------------------------------------------------------------------
Title:              WARNING in debug_check_no_obj_freed
Last occurred:      2 days ago
Reported:           11 days ago
Branches:           Mainline
Dashboard link:     https://syzkaller.appspot.com/bug?id=83687867d4a435fce7c6045b34425b1cfb3bf2d6
Original thread:    https://lkml.kernel.org/lkml/00000000000090ae7a058bc12946@google.com/T/#u

This bug has a C reproducer.

syzbot has bisected this bug, but I think the bisection result is incorrect.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/00000000000090ae7a058bc12946@google.com

--------------------------------------------------------------------------------
Title:              BUG: workqueue leaked lock or atomic in smc_tx_work
Last occurred:      5 days ago
Reported:           7 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=dd71ec2acfdd198626ec8e914f70afc70cf35c72
Original thread:    https://lkml.kernel.org/lkml/0000000000006a28b5058c0d7e17@google.com/T/#u

Unfortunately, this bug does not have a reproducer.

No one has replied to the original thread for this bug yet.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+8759e3927fd85a7c520a@syzkaller.appspotmail.com

If you send any email or patch for this bug, please reply to the original
thread.  For the git send-email command to use, or tips on how to reply if the
thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000006a28b5058c0d7e17@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in inet_accept
Last occurred:      193 days ago
Reported:           355 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=282e2b3c76b4d2fc3e28d16518b757336a40b4f7
Original thread:    https://lkml.kernel.org/lkml/0000000000006e1bbe0570bea62e@google.com/T/#u

This bug has a C reproducer.

No one replied to the original thread for this bug.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+2e9616288940d15a6476@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/0000000000006e1bbe0570bea62e@google.com

--------------------------------------------------------------------------------
Title:              general protection fault in __smc_diag_dump
Last occurred:      167 days ago
Reported:           180 days ago
Branches:           Mainline and others
Dashboard link:     https://syzkaller.appspot.com/bug?id=4d03c161c6cc140b6234f534c6009d8c9da39f6c
Original thread:    https://lkml.kernel.org/lkml/00000000000060600e057e7748dc@google.com/T/#u

This bug has a syzkaller reproducer only.

syzbot has bisected this bug, but I think the bisection result is incorrect.

The original thread for this bug received 2 replies; the last was 175 days ago.

If you fix this bug, please add the following tag to the commit:
    Reported-by: syzbot+5dd1f9327a9ee760048c@syzkaller.appspotmail.com

If you send any email or patch for this bug, please consider replying to the
original thread.  For the git send-email command to use, or tips on how to reply
if the thread isn't in your mailbox, see the "Reply instructions" at
https://lkml.kernel.org/r/00000000000060600e057e7748dc@google.com

