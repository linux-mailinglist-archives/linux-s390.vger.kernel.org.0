Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A10172D5F76
	for <lists+linux-s390@lfdr.de>; Thu, 10 Dec 2020 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389952AbgLJPTI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 10 Dec 2020 10:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389430AbgLJPTC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Dec 2020 10:19:02 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295EAC0613CF
        for <linux-s390@vger.kernel.org>; Thu, 10 Dec 2020 07:18:22 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id g20so7864294ejb.1
        for <linux-s390@vger.kernel.org>; Thu, 10 Dec 2020 07:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=blXIOyDK7ieYqlALF2nPKv5GmeIkK2wQ08lk7KSbvXw=;
        b=YzcypfqDnurbJeh+wucAAtfNf0pvjpgyFmf7CNDuVsziQQL100Erbxe4mE2IWaj0zp
         xahy3RSG23zulp2ICknD2F8ChZI8iR+2BpljU+CYz/2ivrMV867sLrBXaflR/kzEzmsV
         oivFfvhLTdOeTiXZQ4P3c6B31e4Wdf42FMU4t85EPWfiMFSdP5yogsVo9Z5JZGgmyMhu
         qIwZscXijMIrofkGxKGmQyndsrru7dDIGUK/5P8/f2Rx/LBpLzLFmGAU8ZMuzDqr3nko
         8J0u1d8TuPyBDp5CQ4gF3ecFwlD4We25Uxj8TWz+d/TnCRUv9XGDYi9qvDy6F5IRNbOq
         b3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=blXIOyDK7ieYqlALF2nPKv5GmeIkK2wQ08lk7KSbvXw=;
        b=oVl2ykABPBjFVH+OFLrZug7BKQn7q+GJDnx2sYq+73qaZc8MkN/Q5fJdc7PFwdpzHz
         YS9xdXn+tdKCWEbxC2I+v07Fi+jP2inWTMjcUGQ7TKhk7QZMu+5cTgbJo5PM3Q72RH4p
         yipiGTDvdsLL+O9M/X7WN3MMkKHzmfrGwen6M7Md1/107Zqf2qTo6fx24KxRHwAFxzdW
         hyAsOnRbLYQrV8/+OuI2cRKRu5AF4SFcNtfo/siNv4vwKDoZty8eyBUm3eEV8p5nB5Yt
         8dxN4Bc9KrBPpp3y365rKiB07TdYGD65T0EcLUwt10YRi6oeUZmqtkyaqRWuXA8ANygy
         gjBw==
X-Gm-Message-State: AOAM533fAfGqu0/jokZbzn1ncLjqjFBwmSXLMTZ8bFX7DKdAfgC7HGbH
        UBLPBCK+YihbBqa9graNxL2tG4VhbJ+5XQ8bk5D6wg==
X-Google-Smtp-Source: ABdhPJwpnnFgTsdsTklxoxKW9djD7iB5aOM84qiFgX3Wo2SEAnKWFHkO0QWJh2SejrS5D5XuyslmPgJNGdJ39jv2rh4=
X-Received: by 2002:a17:906:edc8:: with SMTP id sb8mr6878017ejb.247.1607613500430;
 Thu, 10 Dec 2020 07:18:20 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 10 Dec 2020 20:48:09 +0530
Message-ID: <CA+G9fYsXCcmcJTVnNUu1Pb5j5gv4CCnSqTO79Uu3tKc=aECYTg@mail.gmail.com>
Subject: [s390] pci_irq.c:106: error: implicit declaration of function 'smp_cpu_get_cpu_address'
To:     open list <linux-kernel@vger.kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

While building S390 the following kernel warning / error noticed
on stable -rc 5.4 branch with gcc-8, gcc-9 and gcc-10 and defconfig

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/6/tmp ARCH=s390
CROSS_COMPILE=s390x-linux-gnu- 'CC=sccache s390x-linux-gnu-gcc'
'HOSTCC=sccache gcc' vmlinux
arch/s390/pci/pci_irq.c: In function 'zpci_set_irq_affinity':
arch/s390/pci/pci_irq.c:106:17: error: implicit declaration of
function 'smp_cpu_get_cpu_address'
[-Werror=implicit-function-declaration]
  106 |  int cpu_addr = smp_cpu_get_cpu_address(cpumask_first(dest));
      |                 ^~~~~~~~~~~~~~~~~~~~~~~


Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>

steps to reproduce:
--------------------------
# TuxMake is a command line tool and Python library that provides
# portable and repeatable Linux kernel builds across a variety of
# architectures, toolchains, kernel configurations, and make targets.
#
# TuxMake supports the concept of runtimes.
# See https://docs.tuxmake.org/runtimes/, for that to work it requires
# that you install podman or docker on your system.
#
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.

tuxmake --runtime docker --target-arch s390 --toolchain gcc-9
--kconfig defconfig

metadata:
    git_repo: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
    target_arch: s390
    toolchain: gcc-9
    git_short_log: 82a0751eb2d3 (\Linux 5.4.83-rc1\)
    git_describe: v5.4.82-55-g82a0751eb2d3
    kernel_version: 5.4.83-rc1
    download_url: https://builds.tuxbuild.com/1lTC2KYDTwqeueHNt1eiSzoLiFb/


full build log link,
https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc/-/jobs/903123659#L158


--
Linaro LKFT
https://lkft.linaro.org
