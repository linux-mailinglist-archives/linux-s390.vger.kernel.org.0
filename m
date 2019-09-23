Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 330F6BBBBC
	for <lists+linux-s390@lfdr.de>; Mon, 23 Sep 2019 20:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732943AbfIWSmN (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 23 Sep 2019 14:42:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728050AbfIWSmN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 23 Sep 2019 14:42:13 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA50B20B7C
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 18:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569264133;
        bh=jh64/+Mh1tv9gqnwGn/6R1p+9BuONhUOHdnYdG9WQDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LN56fypZJ27Zy37NVd37Wcdv7C172QPewnf72fmSvvDoGl5X0KRe6wXjM1ewQpfs4
         eOSnwnw+Ly8K/VMFrH3FkF5KFJLkKtfB/7gHXKjG3xohQ+zmxI5/f95uYmMw2eA0HB
         6PmYQmkxLC8Q/jJTww3thq8tRCJ25rU8yJf1ajYM=
Received: by mail-wm1-f47.google.com with SMTP id b24so10384783wmj.5
        for <linux-s390@vger.kernel.org>; Mon, 23 Sep 2019 11:42:12 -0700 (PDT)
X-Gm-Message-State: APjAAAVfF85ef2XNqkMLZkBOXN0XTA7wKBpGmIPalZwoVqnD29zcMtOM
        IFab90KoPha7w3R7Ouv7Ipg4BpWzSlbxmKIZanvbGg==
X-Google-Smtp-Source: APXvYqzlorbAOK1pZewfmhFMCZa9D1IW2om6vHHCEX4YXqvLd98q3SRZFESbOSIcQdidWUK/iViVSejOT+cnBl7sG/4=
X-Received: by 2002:a7b:c353:: with SMTP id l19mr695433wmj.173.1569264131365;
 Mon, 23 Sep 2019 11:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190920131907.6886-1-christian.brauner@ubuntu.com> <20190923094916.GB15355@zn.tnic>
In-Reply-To: <20190923094916.GB15355@zn.tnic>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 23 Sep 2019 11:41:59 -0700
X-Gmail-Original-Message-ID: <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
Message-ID: <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
To:     Borislav Petkov <bp@alien8.de>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 23, 2019 at 2:49 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> > While touching seccomp code I realized that the struct seccomp_data
> > argument to secure_computing() seems to be unused by all current
> > callers. So let's remove it unless there is some subtlety I missed.
> > Note, I only tested this on x86.
>
> What was amluto thinking in
>
> 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")

IIRC there was a period of time in which x86 used secure_computing()
for normal syscalls, and it was a good deal faster to have the arch
code supply seccomp_data.  x86 no longer works like this, and syscalls
aren't fast anymore ayway :(
