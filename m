Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29757233834
	for <lists+linux-s390@lfdr.de>; Thu, 30 Jul 2020 20:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgG3SOy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Jul 2020 14:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgG3SOx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Jul 2020 14:14:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C5BC061574
        for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2020 11:14:53 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so2322359plq.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Jul 2020 11:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3XH19x0j9mpAwBbmALhrl+K1g6ws6AmAQc8yDsKxwc=;
        b=Rd+sngN9fVYhzl82nqy0DTTR682+o7qxhCC/+ghYliHvyO1hzJDTm0Q4K9N2e2sjvd
         N6jmVrVP1K+zH7o8lQSP7igJY1O84vbHMVMFz6s9vC7DFwyG9aRzqW/9TFWhy9bGwJDD
         8rWbAMt/fh9RSp/q+tWRyrXHkaKeB34igvVHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3XH19x0j9mpAwBbmALhrl+K1g6ws6AmAQc8yDsKxwc=;
        b=alJFyKhyhzy5LHnaHxU9SHQVarLon7KmGVrlcHg1BqSRb6nzgLjiuWG3O8TvO5HT2Y
         bXKSaAhDG2vyHEuDCGCwuM/3b1MvHtf5dLL4VQzd6j6l0iOrWA1p3vOsky0TWATYnDzG
         DCjClPg/v+9DcpXOW80n2rsGALw3vUcwdeujVVsHsinfvW57BxDsxXTKBzNVc8xE3+p3
         wcbRMo2DC2pfmUyfuDJ4rqavzKoj4G576KISuNiFZhuygxmKo8ejW0HmOHFouZsZ5A28
         ZNS0iqP/ENFgXYqBgGHKHGuOM2WHia25gjohbphi/147wREJyOlM/o53j4YdU8YXCdgD
         nftw==
X-Gm-Message-State: AOAM530ktCXIg+AQoZBxzvJHm1qtZhRWbegK4/rJaxrlI5yx+e3vqA2H
        YW4ue9rueCvTM5zmrjyHG23HBw==
X-Google-Smtp-Source: ABdhPJxh4YSRJo64KtvfOflwHcynTg8W1GmMjR98OKYM43hau9SWD31eOcjpDevGju3jfuntinpu7g==
X-Received: by 2002:a17:90a:884:: with SMTP id v4mr318901pjc.27.1596132893170;
        Thu, 30 Jul 2020 11:14:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b63sm7067818pfg.43.2020.07.30.11.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:14:52 -0700 (PDT)
Date:   Thu, 30 Jul 2020 11:14:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allen Pais <allen.lkml@gmail.com>,
        Oscar Carter <oscar.carter@gmx.com>,
        Romain Perier <romain.perier@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-usb@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        alsa-devel@alsa-project.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 0/3] Modernize tasklet callback API
Message-ID: <202007301113.45D24C9D@keescook>
References: <20200716030847.1564131-1-keescook@chromium.org>
 <87h7tpa3hg.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7tpa3hg.fsf@nanos.tec.linutronix.de>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[heavily trimmed CC list because I think lkml is ignoring this
thread...]

On Thu, Jul 30, 2020 at 09:03:55AM +0200, Thomas Gleixner wrote:
> Kees,
> 
> Kees Cook <keescook@chromium.org> writes:
> > This is the infrastructure changes to prepare the tasklet API for
> > conversion to passing the tasklet struct as the callback argument instead
> > of an arbitrary unsigned long. The first patch details why this is useful
> > (it's the same rationale as the timer_struct changes from a bit ago:
> > less abuse during memory corruption attacks, more in line with existing
> > ways of doing things in the kernel, save a little space in struct,
> > etc). Notably, the existing tasklet API use is much less messy, so there
> > is less to clean up.
> >
> > It's not clear to me which tree this should go through... Greg since it
> > starts with a USB clean-up, -tip for timer or interrupt, or if I should
> > just carry it. I'm open to suggestions, but if I don't hear otherwise,
> > I'll just carry it.
> >
> > My goal is to have this merged for v5.9-rc1 so that during the v5.10
> > development cycle the new API will be available. The entire tree of
> > changes is here[1] currently, but to split it up by maintainer the
> > infrastructure changes need to be landed first.
> >
> > Review and Acks appreciated! :)
> 
> I'd rather see tasklets vanish from the planet completely, but that's
> going to be a daring feat. So, grudgingly:

Understood! I will update the comments near the tasklet API.

> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

-- 
Kees Cook
