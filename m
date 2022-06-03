Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BB53C95B
	for <lists+linux-s390@lfdr.de>; Fri,  3 Jun 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243957AbiFCL35 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 3 Jun 2022 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243880AbiFCL3z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jun 2022 07:29:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABC3C703
        for <linux-s390@vger.kernel.org>; Fri,  3 Jun 2022 04:29:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o9so3965031wmd.0
        for <linux-s390@vger.kernel.org>; Fri, 03 Jun 2022 04:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=UqOXahmL9BfB383tTJBgHu6G22xRf+OKSRgCFsT4r4tJePNVS75l6QRwzCmA/tV39Z
         pNNA4/U3XhEQlUBwP9xsXhCTNhde6/mHCpvJYMmHdfBKG0t2xOrFaRTDAjLpmTrbIDmI
         hZeXiHhTs1+lyNsfzFT+skZmO+T7/KjezF7/vXKef+aTrYx0XLV/bivc/5kQuEAG+1Df
         m90IEV8xQerchxdq6MhorxMfZeeRwyieC0+DheLrXpixDxR+RT4Ie8Cb8gpWsLIK38fv
         zneLbaZ1dmMXBVFVE7wMo42ozpaBZHn2Q3ZWBRhU2xc2y4nK5Kq9vbD5T3BzoT+7dZl6
         43Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=PaEzrm9U0WjJMxkE+zbw8yGRv0uhjcRl9sFl9vmbKpk=;
        b=3v+2IuNswII4qiku4bSiwietOCjiqDRGyaYgFBYJAoEoUyBHe0C+Kwxjo2ctvzJOSn
         LSqDDwaCMAUAzypmmFy8l7tw+Ji5FTxhQ1/NM9nkc1n7hNRQJXftkSPctJX8RhjxfQQT
         hAzPtnl+m6ld98KaNUX5EkrQiZWFSHHq2YSMj6Gn//tM8ZqJUorlyoAnzr6DYhk13lOn
         4eR/++mYn8/UOyIm3ziduePl6aRamM12cMfefTIHZ2vuBhSyXJzOo9GnL7yVpMn/5fRv
         ToxIDuCKPr290C0juQ1DqtYi7stiWOMAK/7tw0ELau6qPfCKNfkETq3zP5AcMXVZuP/0
         59OA==
X-Gm-Message-State: AOAM533r0eVGE6LA7zaxvtyY+Dm6j4XOvLPoAg3X6kpWXCabu6fER5zl
        AzmcBI8A4JvqyUM7/MywkzrVlnQfyrSxDM+hvZ0=
X-Google-Smtp-Source: ABdhPJw7Ih30gKUIi9ZSLyr7q/1X+eKLEGYrYm9nlCTEiNBMuWMpjKLsSv0M8Mnsi9fm9GXYBpm3HsRWYt6/RJw0ybk=
X-Received: by 2002:a7b:cc13:0:b0:38e:67e3:db47 with SMTP id
 f19-20020a7bcc13000000b0038e67e3db47mr37823950wmh.133.1654255792234; Fri, 03
 Jun 2022 04:29:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64ed:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 04:29:51 -0700 (PDT)
Reply-To: markwillima00@gmail.com
From:   Mark <mariamabdul888@gmail.com>
Date:   Fri, 3 Jun 2022 04:29:51 -0700
Message-ID: <CAP9xyD2ouspSRZHJQVxeA7d=YeBD9NoSOAN49Kw8RwOVeztQeA@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hello,

Good day,

The HSBC Bank is a financial institution in United Kingdom. We
promotes long-term,sustainable and broad-based economic growth in
developing and emerging countries by providing financial support like
loans and investment to large, small and
medium-sized companies (SMEs) as well as fast-growing enterprises
which in turn helps to create secure and permanent jobs and reduce
poverty.

If you need fund to promotes your business, project(Project Funding),
Loan, planning, budgeting and expansion of your business(s) , do not
hesitate to indicate your interest as we are here to serve you better
by granting your request.


Thank you
Mr:Mark
