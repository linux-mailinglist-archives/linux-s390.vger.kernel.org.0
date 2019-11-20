Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF32103555
	for <lists+linux-s390@lfdr.de>; Wed, 20 Nov 2019 08:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKTHmz (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Nov 2019 02:42:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42426 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfKTHmz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 20 Nov 2019 02:42:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so12901885pgt.9
        for <linux-s390@vger.kernel.org>; Tue, 19 Nov 2019 23:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=02fPVIRaO1XujNDxX9CuuJM8AmBmXK/c/uAOUSL7B7k=;
        b=D5sJ4Q1DZ+jmx2DVVm+1lddxjWMyscFIn0ZB/gaJuX/YWXSDnLWVB21GQ32sqegcRf
         1735ifZ8P8hOiEklKsS6kwdQLIvUpfn/DKVERKUpoGkGBB/u13X8qNp9FjzDc2YaGxw3
         A1uULK7fqhZ6Tlt2onYPaBEz6YkRDu+lZPWQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=02fPVIRaO1XujNDxX9CuuJM8AmBmXK/c/uAOUSL7B7k=;
        b=cP601z5lzdRpvKKtufkMi6PIXHLr1XLABDYTVfyY20mHjpWjELMoH/Mzx9EKdV5N41
         lXjSPpzmgpe7skABPVFrsaNpE2ZTIHm/gC02r13jWoHVAltmFOTN6HtC1FzHS4XGBYnh
         QYP7ovYFXGVY7VGYMb3AIPy1s0TKAHyI4xzkRVmn87aDkzzjWeRfyjMnlVwJtQjoWAaR
         OHbDrVEpuhltPSKyZffP5uS619w3ISnjz1064mHv9RjPZVNcd/ViDV2CskmEXW7BmX5w
         MbCNLnUniSuVc6SWu/bXaWgZD+3QiR7T1iFFlXh/peaAbmAKF1hoa/n/FzOp2ybWOqeE
         VamQ==
X-Gm-Message-State: APjAAAWzl+I5COmkbtXMf8ItmTGsqSAj4tm32kfYczN6B3tzp7NThEsg
        ud/EwasLtPLDwlvisT/O19DaZw==
X-Google-Smtp-Source: APXvYqwm/x+WpaWJH4fsf1nTV8LKmnU/DjjJqE0nKakMSYxtLixOURk0cUOdKb/YWAirX92JzeUQPA==
X-Received: by 2002:a62:7847:: with SMTP id t68mr2372866pfc.140.1574235774458;
        Tue, 19 Nov 2019 23:42:54 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-9c57-4778-d90c-fd6d.static.ipv6.internode.on.net. [2001:44b8:1113:6700:9c57:4778:d90c:fd6d])
        by smtp.gmail.com with ESMTPSA id 186sm31138852pfb.99.2019.11.19.23.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 23:42:53 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Marco Elver <elver@google.com>
Cc:     christophe.leroy@c-s.fr, linux-s390@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v2 1/2] kasan: support instrumented bitops combined with generic bitops
In-Reply-To: <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
References: <20190820024941.12640-1-dja@axtens.net> <877e6vutiu.fsf@dja-thinkpad.axtens.net> <878sp57z44.fsf@dja-thinkpad.axtens.net> <CANpmjNOCxTxTpbB_LwUQS5jzfQ_2zbZVAc4nKf0FRXmrwO-7sA@mail.gmail.com> <87a78xgu8o.fsf@dja-thinkpad.axtens.net>
Date:   Wed, 20 Nov 2019 18:42:50 +1100
Message-ID: <87y2wbf0xx.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

> But the docs do seem to indicate that it's atomic (for whatever that
> means for a single read operation?), so you are right, it should live in
> instrumented-atomic.h.

Actually, on further inspection, test_bit has lived in
bitops/non-atomic.h since it was added in 4117b02132d1 ("[PATCH] bitops:
generic __{,test_and_}{set,clear,change}_bit() and test_bit()")

So to match that, the wrapper should live in instrumented-non-atomic.h
too.

If test_bit should move, that would need to be a different patch. But I
don't really know if it makes too much sense to stress about a read
operation, as opposed to a read/modify/write...

Regards,
Daniel
