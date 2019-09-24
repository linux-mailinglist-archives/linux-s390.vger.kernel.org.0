Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA362BC1AC
	for <lists+linux-s390@lfdr.de>; Tue, 24 Sep 2019 08:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405843AbfIXGT4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Sep 2019 02:19:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36937 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbfIXGT4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Sep 2019 02:19:56 -0400
Received: from [89.27.154.14] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iCeAy-0007jT-Bf; Tue, 24 Sep 2019 06:19:52 +0000
Date:   Tue, 24 Sep 2019 08:19:51 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-um@lists.infradead.org, X86 ML <x86@kernel.org>
Subject: Re: [PATCH] seccomp: remove unused arg from secure_computing()
Message-ID: <20190924061950.cu6aosio57pz4r3m@wittgenstein>
References: <20190920131907.6886-1-christian.brauner@ubuntu.com>
 <20190923094916.GB15355@zn.tnic>
 <CALCETrU_fs_At-hTpr231kpaAd0z7xJN4ku-DvzhRU6cvcJA_w@mail.gmail.com>
 <20190923193446.GL15355@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190923193446.GL15355@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 23, 2019 at 09:34:46PM +0200, Borislav Petkov wrote:
> On Mon, Sep 23, 2019 at 11:41:59AM -0700, Andy Lutomirski wrote:
> > On Mon, Sep 23, 2019 at 2:49 AM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Fri, Sep 20, 2019 at 03:19:09PM +0200, Christian Brauner wrote:
> > > > While touching seccomp code I realized that the struct seccomp_data
> > > > argument to secure_computing() seems to be unused by all current
> > > > callers. So let's remove it unless there is some subtlety I missed.
> > > > Note, I only tested this on x86.
> > >
> > > What was amluto thinking in
> > >
> > > 2f275de5d1ed ("seccomp: Add a seccomp_data parameter secure_computing()")
> > 
> > IIRC there was a period of time in which x86 used secure_computing()
> > for normal syscalls, and it was a good deal faster to have the arch
> > code supply seccomp_data.  x86 no longer works like this, and syscalls
> > aren't fast anymore ayway :(
> 
> Uhuh, thanks Andy.
> 
> Christian, pls add that piece of history to the commit message.

Yip, will do. Thanks!

Christian
