Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD633046E5
	for <lists+linux-s390@lfdr.de>; Tue, 26 Jan 2021 19:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbhAZRT3 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 Jan 2021 12:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390684AbhAZIzT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 Jan 2021 03:55:19 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E874C061756
        for <linux-s390@vger.kernel.org>; Tue, 26 Jan 2021 00:54:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id n6so18761678edt.10
        for <linux-s390@vger.kernel.org>; Tue, 26 Jan 2021 00:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=GGyBTb5u2IaUHbKiQ/SJcFo7rVvuCNL30ZstU8LYN/E=;
        b=BJF5+4SDPOkOCjs/4jNBihoQpnOZDsoC6XVRVTS2IXkC8sVxCVyNh1urW7WxOrRozy
         /yolIxrdnurMrhSzgq0YxbEOG+IgutS86Dgx5KXErqpeCLY+Q/b5NWyYFloYeAK5gKFI
         HF7sL+SzoCH82bT/koETLFf3o5kEwgNYMpUTxzJreCPEZxJBoCJF80dcsHEfw4STm1S3
         lamrPDYxrfzCSGyMdNMqkpzx/hVp3q/NcGWqgROMCYlq2mk3qttUYxETdp5dSdhHOF2d
         42xlWPg+yQtQnSQ7+Oah/LyNKnDhjV3pEmi8untGU6M933S8mkfFkSMu6J9WrgP/6onq
         o2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GGyBTb5u2IaUHbKiQ/SJcFo7rVvuCNL30ZstU8LYN/E=;
        b=TQl7JmAaQqRUF3Fo0r6Fz/Sn8eMdczKAoiihlTMmjyNZOAjbv1AmTHYTrP/Z6Eo4Je
         ax9NsS4Wy9JRIZAwpkm0QR6S/ghNKkuXPx78ZevWM+HbfwAfw+m0uayhf6sTigxXZkam
         K603PkJig6YuwSAAHGYLfSHXSZxkMRRU1QVRWtiLmBsu8VrqZRa2/Y2f7YsAaAI4+Uzp
         u+HHFR+Sh4uxGlEeYyyHg54lVkv7XqjyXEv7vSNJOpo+pukaiLOoUmOBkTMFZbd/dwHC
         wlEh3fno5VEXrlqp8idVO5o6OvU+pWWwN0on3STIRTFwe18+5IEtl0gjLTLRb52Cmf8r
         mg7g==
X-Gm-Message-State: AOAM531oHbTRv6Vi59oDdW/CFl4sr6eVwAchNrySYD3ud6+QLLzJzf5J
        OHag6iojkl4A1El9UW8PIGt5CzABLKArIs//EZpDoQ==
X-Google-Smtp-Source: ABdhPJwT/9Wb6/ynC7ThfNRIUvGN5jTnfb2/1aNKw0X7NVF05sImHp6YY/JgB91UAukCwenk83S3pKDmx3C7e1Gap08=
X-Received: by 2002:aa7:d905:: with SMTP id a5mr3900786edr.78.1611651277854;
 Tue, 26 Jan 2021 00:54:37 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 26 Jan 2021 14:24:26 +0530
Message-ID: <CA+G9fYuWbKX6o1HS-9vAs4PHQKhv0d33V6x0TZ6_UHVy6yp-qA@mail.gmail.com>
Subject: s390: syscall.c:165:3: error: implicit declaration of function 'sched_resched_local_allow'
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-s390@vger.kernel.org, lkft-triage@lists.linaro.org
Cc:     hca@linux.ibm.com, gor@linux.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

s390 build failed on Linux next 20210125 due to below error and suspected patch.

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc'
arch/s390/kernel/syscall.c: In function '__do_syscall':
arch/s390/kernel/syscall.c:165:3: error: implicit declaration of
function 'sched_resched_local_allow'
[-Werror=implicit-function-declaration]
  165 |   sched_resched_local_allow();
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Link to suspected patch,
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/s390/kernel/syscall.c?id=29819dc5f5e3dbb1770ee2062140b6566755ba00

-- 
Linaro LKFT
https://lkft.linaro.org
