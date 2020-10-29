Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4A529E735
	for <lists+linux-s390@lfdr.de>; Thu, 29 Oct 2020 10:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgJ2JZf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 29 Oct 2020 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgJ2JZ2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Oct 2020 05:25:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9DEC0613D4
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:25:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n15so1664167otl.8
        for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2020 02:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXd5L3340dzHPl4D7TSnIVGFAYIoQ/W+pLHz6LYz95I=;
        b=RAZGAbKdB4XcnSD0wp1Kz5dBTHMEAkPA/y5Q5zBFcm5ek6TOqOD+2MjSuNA7CsSuFv
         QdasXZzvzm82On3eSCMCjzvEPeFEdeSGCKm4fjXr/Z2Mh9xwUtFmVb6ioAaMFNhmVvnm
         LvNYGo6oa8r1Gs3CbA9euLgw6UBFM7BcU9IdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXd5L3340dzHPl4D7TSnIVGFAYIoQ/W+pLHz6LYz95I=;
        b=m6fS1R47OKEvhWdgKrB7Jm/wyv+Jt0vDY4llT23OlEs3zZVBVqwjSRjNmQwmnLnuxX
         pF+f6APnaUelKK16i6/AgV4I/6IK4QLb+YrVW4XbOyGq6/rY+BeL3LByz741Z3c87ziE
         D9AzS9YSGWYDzZtK5Ja0QpFARmRAgzygm1VMmkM7YjLcpkCwhd1L+qGAF1QzRDi0S+63
         sUHhQhegyRb3cjZAwECRwnEQzugO1W4k7+y/zUGIOHZGp0usvctzT7jXJ66zfyOLItkE
         EJllpJwYpwIvcv1h5QVfUFCYa2YJB/MCVU1JvsUSTS+yHqnVcFY+fO3tvkhBN5v49V8u
         MUKg==
X-Gm-Message-State: AOAM530DUnfdGAkbG+pakxOQJBBQ53Ig9JC4dP8e8KQ5BP2fyye+XkbS
        QLws4fpmJokCPCD+h39g0NQSEx2WOWqLOdrYdmhAQxvszTIICQ==
X-Google-Smtp-Source: ABdhPJz3d3GbocYLOWK17PC84OSTKCpC1P9Cp1Gqiuhg8zJB6kTRUJIIoeLruWIEtxgmiFM3IrJbR1M7sDMXTefUSTI=
X-Received: by 2002:a05:6830:1c3c:: with SMTP id f28mr2685703ote.188.1603963527533;
 Thu, 29 Oct 2020 02:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026105818.2585306-1-daniel.vetter@ffwll.ch> <20201029085749.GB25658@infradead.org>
In-Reply-To: <20201029085749.GB25658@infradead.org>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 29 Oct 2020 10:25:16 +0100
Message-ID: <CAKMK7uEV7sQ48w1Dd=WCY1r6LrY+aEq3ASnouOebQoo=Zr=CTQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] follow_pfn and other iomap races
To:     Christoph Hellwig <hch@infradead.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 29, 2020 at 9:57 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Maybe I'm missing something, but shouldn't follow_pfn be unexported
> at the end of the series?

kvm is a legit user and modular afaict. But since you can't use this
without an mmu_notifier anyway (or digging around in pagetable
locking), maybe it should be EXPORT_SYMBOL_GPL now at least?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
