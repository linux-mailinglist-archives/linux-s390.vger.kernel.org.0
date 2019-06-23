Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7E24FB00
	for <lists+linux-s390@lfdr.de>; Sun, 23 Jun 2019 11:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfFWJrB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 23 Jun 2019 05:47:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41063 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbfFWJrB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 23 Jun 2019 05:47:01 -0400
Received: by mail-io1-f71.google.com with SMTP id x17so17655862iog.8
        for <linux-s390@vger.kernel.org>; Sun, 23 Jun 2019 02:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=//qCEHHwsKmQKJGq2sElU6h7rWpgyd394JCVN/Ky63Y=;
        b=kHGFJf+HQHRabOHh/fhNGS0zc+jDVdTOfMh3gYrhNdItIZWbr1a98dCRUad6NqR0B8
         4bIZUFLXwZYNe5+0MbDFv2UB2QpimZb7Cdwt8Zh7YEcnv1dtegKLRnIIZrV0j70ZpzOa
         EDkabijLOY+DjOKAPUYh7p8lzXtV6QW5RZ9nyXKxVbM9GU88AvpVMXcAbnIHSdsv1TF4
         XmZqbhMZb3sRYAFiWzTvX29Nm6dzR0wnsUgkFS6wf/SZUxWekn7YRLqZ57mAcU1axdvl
         OEgFIyF74cI25HiLrktBRfmcQ0eAcMdbFg0kP7bxlVQX/mRlqaqsLEhYnBF/fDlC6pZE
         xnEw==
X-Gm-Message-State: APjAAAXKTxgXcRLH4kfGg2Ey1+Mze4uICSt4HrVy6jmV+2PxYf0wk/Xq
        gbMtuphgnV1qZT6kc49x+o+vrGdoJ4DNdwYuNHQqo6y4NJIc
X-Google-Smtp-Source: APXvYqyGiLQ70dP6eFGnQ63Jed2MzJ0lmOsmDLwDerlbWSICxM7PikGk1Wtt/hUYnDo1CxkwarJk5FqD8R5xYTNQF8/oFlSwbHR+
MIME-Version: 1.0
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr26057928iog.77.1561283220587;
 Sun, 23 Jun 2019 02:47:00 -0700 (PDT)
Date:   Sun, 23 Jun 2019 02:47:00 -0700
In-Reply-To: <00000000000090ae7a058bc12946@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1cb06058bfa9371@google.com>
Subject: Re: WARNING in debug_check_no_obj_freed
From:   syzbot <syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com>
To:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        andriy.shevchenko@linux.intel.com, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        dmitry.torokhov@gmail.com, f.fainelli@gmail.com,
        idosch@mellanox.com, jeffrey.t.kirsher@intel.com,
        jiri@mellanox.com, kafai@fb.com, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tyhicks@canonical.com,
        ubraun@linux.ibm.com, wanghai26@huawei.com, yhs@fb.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

syzbot has bisected this bug to:

commit 99182beed858a1bde22f60046602b9b223225f73
Author: Daniel Borkmann <daniel@iogearbox.net>
Date:   Tue Apr 2 21:17:19 2019 +0000

     Merge branch 'bpf-selftest-clang-fixes'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12faf81aa00000
start commit:   bed3c0d8 Merge tag 'for-5.2-rc5-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=11faf81aa00000
console output: https://syzkaller.appspot.com/x/log.txt?x=16faf81aa00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=b972214bb803a343f4fe
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12fcf0b2a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a22ad6a00000

Reported-by: syzbot+b972214bb803a343f4fe@syzkaller.appspotmail.com
Fixes: 99182beed858 ("Merge branch 'bpf-selftest-clang-fixes'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
