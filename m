Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45610360B
	for <lists+linux-s390@lfdr.de>; Wed, 20 Nov 2019 09:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbfKTIdK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Nov 2019 03:33:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38998 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfKTIdK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Nov 2019 03:33:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id w24so20025340otk.6
        for <linux-s390@vger.kernel.org>; Wed, 20 Nov 2019 00:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PED6ZYCgPaRUxZYECcuhZmbEWK8QVrh8hGaeK/4Dmy0=;
        b=OGrrZDpatx6bnWp30f05n9y2GXrNbXiMo4e9QnZukpBs2mQBTMYpR68xirJL+yZqcb
         9sdnCPbGWC8kI+Cfxhyw/lPXYDeNYcaKH+DetkEa1FRbIkd8zXX73GJn0lDVma9Yn+DP
         P6ubPYauQ2q07e3JbhnQ03NsomnKDTD7KwaJlE13VEZ8iqI2Jq/KCqru5SQQ6i/f/8d0
         3rQNufU2Y4RZWJkAdK3paThpZyJKuucOdam3UrlGurxKo1MuSDntifUt38w141wp5c9v
         O/N6W558+sxx+m1/G9/XDUoUBRd0zOdZd98QHHgB5P+zsHbStOP8YVWSCC97LFS5QXpv
         AknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PED6ZYCgPaRUxZYECcuhZmbEWK8QVrh8hGaeK/4Dmy0=;
        b=gLJ2B95RC7OUzyl4Qe/pech9F152JZiSv9S+ijqgIsVgyPFBIdMuPbBR4DXnBb4vdm
         wgXEyJC6leDOykbC7NySkwdKzAWA4CxdvRJzoWEpMLCZFRQxdCQeb8ANI6UqKLzqtL5q
         0JSX5TwQsToo1UxeBOE3lDsG1TPVXsXdBFLLv1nXlZj92/j+etYa34FyFx3xqMRpQLq5
         k9dkAojBtD6FOKXFhCg258wfoH6z+WgMylxalnrRrB49kVK3nfqwBWXHlaRBr1R1hFbx
         8hEudixqR+s/aOMbg4rS2XF/nVDC0Okee2Yc17O7DHTYI2Kea8TmbvCZoiuPPcfPBwNG
         cH0A==
X-Gm-Message-State: APjAAAWo4KysSrNNvSnEGHSR9QJrJgb2YsVZvSj0y6cMnPS0numT+OW5
        0jM0zKAQnfIB42xySrPe8deJLYfJ+LMcoizTarB5Kw==
X-Google-Smtp-Source: APXvYqxkDqT6uw4KByP9K4bk7RdCzo7jskMlJLlwbVVqL/s87+pnLIejk259sfDec0B8L3KT9/52IYH0IkH9klKNnPo=
X-Received: by 2002:a9d:3d76:: with SMTP id a109mr1082964otc.233.1574238786622;
 Wed, 20 Nov 2019 00:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net>
 <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com>
 <87a78xgu8o.fsf@dja-thinkpad.axtens.net> <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 20 Nov 2019 09:32:55 +0100
Message-ID: <CANpmjNN-=F6GK_jHPUx8OdpboK7nMV=i=sKKfSsKwKEHnMTG0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with
 generic bitops
To:     Daniel Axtens <dja@axtens.net>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 20 Nov 2019 at 08:42, Daniel Axtens <dja@axtens.net> wrote:
>
> > But the docs do seem to indicate that it's atomic (for whatever that
> > means for a single read operation?), so you are right, it should live in
> > instrumented-atomic.h.
>
> Actually, on further inspection, test_bit has lived in
> bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
> generic __{,test_and_}{set,clear,change}_bit() and test_bit()")
>
> So to match that, the wrapper should live in instrumented-non-atomic.h
> too.
>
> If test_bit should move, that would need to be a different patch. But I
> don't really know if it makes too much sense to stress about a read
> operation, as opposed to a read/modify/write...

That's fair enough. I suppose this can stay where it is because it's
not hurting anyone per-se, but the only bad thing about it is that
kernel-api documentation will present test_bit() in non-atomic
operations.

Thanks,
-- Marco
