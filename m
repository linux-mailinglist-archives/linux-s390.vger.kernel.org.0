Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A75D1170CC1
	for <lists+linux-s390@lfdr.de>; Thu, 27 Feb 2020 00:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBZXsd (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 26 Feb 2020 18:48:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39294 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgBZXsd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Feb 2020 18:48:33 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so341152plp.6
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=UW09MiMy2GaFwFAJ/K3zl0bfOBctGn1N/5oBnyfXBBo=;
        b=p/9RYB8kgMB0e8z5IDwOgAal1bA5SLd2SFKLv25Ung8/p0BhAB86euEgkobREoxfmp
         yKqg6pDpBKuUpdrEwTr9vEVyrfSL+cXkHm3hBTYBDohCfSV3uahMaoXMOOdshJ4aR+Fu
         V1toxermAqGtoIKM5MGgcSal+/esLdjYKwiLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UW09MiMy2GaFwFAJ/K3zl0bfOBctGn1N/5oBnyfXBBo=;
        b=tOAhy3mW/svfyllO0vpdd/FOO3EvENvE2ef2zCQtWimvToL/oqoMuYitStxcvWmimj
         zoOD44qShfhBMIwzQs0aQna9ZTqNofqmlCvaCkBpn1434CC8AWfj87srVt3/aYr0iFhI
         LzJViL1hxgJOUlFQzgCcDE6NSO5UZy1kpp/hZFdLTK2gOg/7tGHn19DvK8EURgbajJk+
         W4gkaPAbO1YjTEnjVHrkFYoj98GeVa9rjcji4AhtP3dZIVg2zkPrX6jmbkdeUEG4dnuq
         9nq/28PcDGmHoEnaHqN1HvjMl612s5D9z1h1XnNeYbcVU6m1JRhAeew2a58VHYqoSRc6
         qo1Q==
X-Gm-Message-State: APjAAAWNrAkaHCDaaX3pXC0Bp2A0grAP2OTwQQSXkRMMK3iq5Z+QNong
        sEeg5dWTAGznKeTP79Zx947LX/v3Or8=
X-Google-Smtp-Source: APXvYqwO0geOgUQ2VFTz4udUkoL6gA+i5YLlDwNbhBkmZKUuVfAD8LuxK/3KK4B4kuG2YBBwmhPS2w==
X-Received: by 2002:a17:902:ba93:: with SMTP id k19mr1782695pls.197.1582760911494;
        Wed, 26 Feb 2020 15:48:31 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5952-947b-051c-ea5f.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5952:947b:51c:ea5f])
        by smtp.gmail.com with ESMTPSA id f127sm4475804pfa.112.2020.02.26.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 15:48:30 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, x86@kernel.org, dvyukov@google.com,
        christophe.leroy@c-s.fr
Subject: Re: [PATCH v2 0/3] Fix some incompatibilites between KASAN and FORTIFY_SOURCE
In-Reply-To: <20200116062625.32692-1-dja@axtens.net>
References: <20200116062625.32692-1-dja@axtens.net>
Date:   Thu, 27 Feb 2020 10:48:26 +1100
Message-ID: <87o8tkrjud.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:

> 3 KASAN self-tests fail on a kernel with both KASAN and FORTIFY_SOURCE:
> memchr, memcmp and strlen. I have observed this on x86 and powerpc.
>
> When FORTIFY_SOURCE is on, a number of functions are replaced with
> fortified versions, which attempt to check the sizes of the
> operands. However, these functions often directly invoke __builtin_foo()
> once they have performed the fortify check.
>
> This breaks things in 2 ways:
>
>  - the three function calls are technically dead code, and can be
>    eliminated. When __builtin_ versions are used, the compiler can detect
>    this.
>
>  - Using __builtins may bypass KASAN checks if the compiler decides to
>    inline it's own implementation as sequence of instructions, rather than
>    emit a function call that goes out to a KASAN-instrumented
>    implementation.
>
> The patches address each reason in turn. Finally, test_memcmp used a
> stack array without explicit initialisation, which can sometimes break
> too, so fix that up.

Hi all,

It doesn't look like this has been picked up yet. Is there anything I
can do to help things along?

Regards,
Daniel

>
> v2: - some cleanups, don't mess with arch code as I missed some wrinkles.
>     - add stack array init (patch 3)
>
> Daniel Axtens (3):
>   kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
>   string.h: fix incompatibility between FORTIFY_SOURCE and KASAN
>   kasan: initialise array in kasan_memcmp test
>
>  include/linux/string.h | 60 +++++++++++++++++++++++++++++++++---------
>  lib/test_kasan.c       | 32 +++++++++++++---------
>  2 files changed, 68 insertions(+), 24 deletions(-)
>
> -- 
> 2.20.1
