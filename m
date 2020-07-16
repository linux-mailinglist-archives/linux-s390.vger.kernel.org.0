Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAA22228B1
	for <lists+linux-s390@lfdr.de>; Thu, 16 Jul 2020 19:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgGPRFM (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Jul 2020 13:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGPRFM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Jul 2020 13:05:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB6DC061755
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2020 10:05:12 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id w17so4123364ply.11
        for <linux-s390@vger.kernel.org>; Thu, 16 Jul 2020 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j14+opphqNF4U86DBZtMYzwDu8f+tRjw4XJQRMpPA4I=;
        b=FKj1PFU+S6dmuzsw937AQmptM4LAiNQtHyfYVXDS1tCSj/+Ux+hMuXQXGuN+JAuE80
         6UyWV4dL5L4+xnnONe2RL+AntOtYm1CN4HF4wevPhrCJtH5LP1yffZKTIpSAE5XlAWgl
         lFO/+PuAi+J0onuXjtskW1Edvo+9U3djYppG7Vo8VOSwT5xcz7vKgofq8oRoR/ooK2oW
         9k0+J6SKNyoYfBUvS4S6camqKWCSwd5uxkHkz0yYdJuVKe13Jljh/fWazhU0WSrDtFkz
         qcJCUurDxlboEOtHhHFCZ3+rmmAHQ3VOb3y/BkFeeuQy441tbt/HQvF5SlrxVEocujEt
         hPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j14+opphqNF4U86DBZtMYzwDu8f+tRjw4XJQRMpPA4I=;
        b=nak0bQJtOt5EpMLMQRwWRAM3Y7sPIMSnSXOFVaMYy977xSnu0alHyDyhEWwW4PZRGT
         vPLILnyl0Nsnh/x6pp5U0kEdujCkTvDctSIfRJZQzXWQ4OcpNnD4RITLRfZ1sbIK5w23
         0565HjsDCT6hmcj6kDv/gB8RPyot75sQXAP9+z81QSaMBbfierLdGvpKBx3td8cId3D1
         1+ejvhstgsF54rOu38XD2U92IMIYJ0T84rdbsh2Bb4I/68xEoepYNsabdoXSoqryo/hD
         xDZOXqXttZGDAksQB1QxhRGbAmbvMd6+tASO0+p4+msgDuz9ExhxYawYf8Z5042i3rxK
         7gCg==
X-Gm-Message-State: AOAM530JVhrUqNbHrl0mdQV3Ae1V76DIUqAZfXbXPPig1Ezi6BbSMa93
        qbMPUeRtdUZh+LygO75Z+75gOVNRIy9uaasZJBnFhw==
X-Google-Smtp-Source: ABdhPJyWwbg4wI79SuNeMUuIsVSWr5bmDV2q1y+lOxsjw2961NgYNuV+yKqK3mKd0cwtSwtUhyGH3SKwQie614RBRaA=
X-Received: by 2002:a17:90a:30ea:: with SMTP id h97mr5949275pjb.32.1594919111381;
 Thu, 16 Jul 2020 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdn-2E=v_7Uie71pz2jjYCKnk98K1Ly8EkpxzvC6M5pXFA@mail.gmail.com>
 <20200716112840.GC8484@osiris>
In-Reply-To: <20200716112840.GC8484@osiris>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 16 Jul 2020 10:05:00 -0700
Message-ID: <CAKwvOd=_JL3+L7dY0W8LDTSer3iWvcwSqWoLN=_gR6zc86hDvw@mail.gmail.com>
Subject: Re: linux plumbers + clang + s390 virtualized testing
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 16, 2020 at 4:28 AM Heiko Carstens <hca@linux.ibm.com> wrote:
>
> Hi Nick,
>
> > We were very excited to see your patches going by for enabling Clang
> > support for s390.  Since then, we've added s390 builds to our
> > continuous integration setup.
> >
> > We've been running into a few issues with doing virtualized boot tests
> > of our kernels on s390.
> >
> > I was curious if you'll both be attending Linux plumbers conf?  If we
> > carve out time for an s390+clang talk, would this be of interest to
> > you to attend?
>
> I will not attend, however cannot speak for Vasily. He will have to
> answer as soon as he returns - besides that enabling Clang support for
> s390 was done by Vasily anyway :)

Hey,
Thanks for following up; I got a bounce back from your previous email
address.  I had just noticed your update to .mailmap+MAINTAINERS last
night.  You beat me to the punch.

No worries.

-- 
Thanks,
~Nick Desaulniers
