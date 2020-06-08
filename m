Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C5C1F1F80
	for <lists+linux-s390@lfdr.de>; Mon,  8 Jun 2020 21:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgFHTKD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Jun 2020 15:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHTKA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 15:10:00 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B304DC08C5C3
        for <linux-s390@vger.kernel.org>; Mon,  8 Jun 2020 12:09:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so10974042ljb.12
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ym4tU45MMnDn25Yhgd7+0Tq2VQSssyVJvFlY7FBum3s=;
        b=R63Bra+tBgqvZPgopT1FJ8n2T+OgE8VA8m7mcDj+55e2Todzm9t2WJlHgbFo/Isqm6
         Ld6soz/+MFK7Kk5DnXXHBSb8xgvSJEVBif0UvuZjrjGkqPH5vuuwwq7ihLUqfSsewrML
         aeYgDYnLPIX9JxlIgql5glnikrkgxcCJI5Pis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ym4tU45MMnDn25Yhgd7+0Tq2VQSssyVJvFlY7FBum3s=;
        b=oiGAIyRWCnDKCJPHSVWzTsa/tpC+PgEpDGHudPwHV/MbbmdpZD111n7xAGyrsBNMrO
         4H1cvfzh2hiNwNRjk/MV1jNEEepdt3XOIfj3WCbqUIzpddUh1T1XJQtwmn1ljj5DimJf
         4PzIvFo5b53lFZDzB0jqr2Py3rzhG3WSls4xxFPxr0nfLopGc/9eXhqiv4Jce+yDBMo5
         capIm+BXTe0MXk66FSj4GsUl6APmbERCDk9/AcD8bpik5jkohVJa0vir5Q+TqsWCZgP/
         MSQ2HxLYtloC1X2TbSn8jroQPFdO/N4DkDlQnoOKVMMv2H1u1WUZVMMhs9et8S4gMcO1
         Zp9Q==
X-Gm-Message-State: AOAM532EDt5Y3by5oNbRVzjMNuCHHXgbzEONFUBOHXRHVXRUN/TdK4pO
        Utbas66OvNVfz7MeuC6yghmx1V2NdI0=
X-Google-Smtp-Source: ABdhPJz6U22f5LgJmWSGZshtW3YKGFQa6dPRbPJL+S+0dairXHV3IO09XnxwuNfqr0OOy2OyfGm4Tw==
X-Received: by 2002:a05:651c:29b:: with SMTP id b27mr11378937ljo.454.1591643397358;
        Mon, 08 Jun 2020 12:09:57 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w25sm4562004lfn.42.2020.06.08.12.09.56
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 12:09:56 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id d7so10918555lfi.12
        for <linux-s390@vger.kernel.org>; Mon, 08 Jun 2020 12:09:56 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr13102855lfu.192.1591643395609;
 Mon, 08 Jun 2020 12:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <your-ad-here.call-01591630479-ext-3636@work.hours>
In-Reply-To: <your-ad-here.call-01591630479-ext-3636@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 8 Jun 2020 12:09:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
Message-ID: <CAHk-=whC98Ge2Y2uooRkbt11R1QpF0283Oqnz6X6AUBa_XBbzQ@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for the 5.8 merge window
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 8, 2020 at 8:35 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> Please note 2 minor merge conflict resolutions below:

There was a third because of the iommu tree I merged today.

That one looked trivial too, but please double-check things anyway,

              Linus
