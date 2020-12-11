Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651DC2D71A1
	for <lists+linux-s390@lfdr.de>; Fri, 11 Dec 2020 09:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436848AbgLKIYK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 11 Dec 2020 03:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436851AbgLKIXz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Dec 2020 03:23:55 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2A5C0617A7
        for <linux-s390@vger.kernel.org>; Fri, 11 Dec 2020 00:22:28 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id o17so9278174lfg.4
        for <linux-s390@vger.kernel.org>; Fri, 11 Dec 2020 00:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2E9lnRJNmKjai1CIMZDErJ15p/JF+kjk/cqnxyQj4Dg=;
        b=Sg4cSLWy6IZckqqkeAYWtdI97FK7RQhI79W1qCeW5ejotUknN/MdP8pOZwiJvJO7uZ
         1g0ChmDEvTyZ23ejJpGuTfR48BiteLYb+OL/KdYtSnujk6eEaD9Otld8+8Y1g2J3MkZy
         tBoVa7+XwKCBx80qyQ1lEL4q5LEMtfg9bICdHSQfD91by6GBTt8+YUD0LCicXSAecwzu
         UGwPYj7soqTu0UOqubjIEnM4Y4/SCD8/nRHiZ64GIKuX4gCcysUu5Anc/HkVqEhjxidw
         EOW9o76j1CYEbDn1Eew6P3PNlPF6IkqqOz0I8fQQT/K3wBjEt9vG4/VgfYmY3wimDZ9S
         ttIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2E9lnRJNmKjai1CIMZDErJ15p/JF+kjk/cqnxyQj4Dg=;
        b=Vua8cm3BkLKC74TsYu4i9SuV3usagYGmeLFXisNSQ6NlaPIe2SsLulxxaTeusEIqfy
         wp6D0Pi4ZMI3PXHCBxxOO/5Doc86G35SgThz1xIktdaBuxWwW9xlZqq/28Neg4Uew2H6
         QZOEfXrc+NY+7BwXmiNyJusoTrkfyShvLXOEsVIlrnNKsbdqHJX1Zp5vb4Y7NqUafbOi
         mW14MyH8fYw9NyO1rpetyvu10sSX2PsEy1QMaw7NTl9Ou5olxVBmrTWCWlOMMtfvsQ/F
         bF64HgPRDTNZk542Zyqi+4JdGGBOBgfeXXsfiGB13SL1x1AjzrOtvQxnww4DPIO/CLPP
         KIuw==
X-Gm-Message-State: AOAM532f8ZvHzBYL6PrwJBsE5dKKGHxH7qzQI/dmDMZ8+4TEKmD15gMT
        KVBW3i3g+B6GFnkxNJR8t2zTSI5tF20ZagKa/hpwcA==
X-Google-Smtp-Source: ABdhPJy4uaPybRyNu7M8RrLozSmYT+Qwt4yF5yxQSb1/0NkgevgBErArzujQXpmZiKS3OBl0PE4C3Qi2TwkDPG47X1M=
X-Received: by 2002:a19:8384:: with SMTP id f126mr3904234lfd.649.1607674946619;
 Fri, 11 Dec 2020 00:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20201210192536.118432146@linutronix.de> <20201210194044.157283633@linutronix.de>
In-Reply-To: <20201210194044.157283633@linutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Dec 2020 09:22:15 +0100
Message-ID: <CACRpkdZuPp0KN1BCJ26vWH1=nopaD-ctv6bh-rt2X9bJczZE-Q@mail.gmail.com>
Subject: Re: [patch 16/30] mfd: ab8500-debugfs: Remove the racy fiddling with irq_desc
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-rdma@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Dec 10, 2020 at 8:42 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> First of all drivers have absolutely no business to dig into the internals
> of an irq descriptor. That's core code and subject to change. All of this
> information is readily available to /proc/interrupts in a safe and race
> free way.
>
> Remove the inspection code which is a blatant violation of subsystem
> boundaries and racy against concurrent modifications of the interrupt
> descriptor.
>
> Print the irq line instead so the information can be looked up in a sane
> way in /proc/interrupts.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
