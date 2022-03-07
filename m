Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6FE54CF187
	for <lists+linux-s390@lfdr.de>; Mon,  7 Mar 2022 07:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiCGGDw (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Mar 2022 01:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiCGGDv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Mar 2022 01:03:51 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87BF33EA5
        for <linux-s390@vger.kernel.org>; Sun,  6 Mar 2022 22:02:57 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id u10so9016785ybd.9
        for <linux-s390@vger.kernel.org>; Sun, 06 Mar 2022 22:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=c1bDG9VxRM0GGNj757DrmXHfFRpAS5nkQXMs+Oj4aPTCkzXBOFbj1k5qasjuP7b7w1
         npZK8ypTFGHQkM192ZbB3h70SclmR/FmMnE+o2NAlsAka1vqxjsPQeWInjwcch4TWwgd
         4QVOYWL8dQqZPl+i4iCJaqArfPnnv+jExWbuY3eVqEjcJc1aSHg3Lcx3lIOQXDek7wFm
         t7MzZLz82GBobHT7mDif3bTdRhxbaDoNrhirZ+qnUTn6EuqEMnP6dAqdpJ1F4dkR6Svp
         iHP0XtJsVxroeHH+7LQk43FT7RNNVvr+5ATFXMTuMadcULQyJpXd23Q2U4Bv/EiS3fq5
         idng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=7Im1JG6q3q15hqSa7NWQHVGGERLfnPf1iBbuaSTqgJQ=;
        b=wOhwkDcOp8KV9QfgHCRfFpoxIJO88R958P0C8WxtHHPwU2jeToDxLqI7zoDEh/lY0w
         gD7VIhAM2KJHHelSP/q8EqDZZzqukBVF1kjOs/wJh67QFFi7N+71G8QSKOw0wJMM+ucI
         yCPN63ODHTb6xPVarrQJZfaKJXJdgvC6t+BZICsHl0b6mEZDqMVwoekA9JahncdW50LI
         suoZ0zpcvpZPiFclO7HwhNIouar9aD/9L7harbsg2DWDuCS+WNl+J5TwN/7jZEb4gxLr
         ZJQXTTMVQBiLfHtAVk36huA5sSJursKu4pkRdk326xPE3MClVLztKyJePyxfZihSJDvb
         lyoA==
X-Gm-Message-State: AOAM5332PNjWeAmkn2xW80OPcn8d6sNfLVmQ+im+ld4HYTf8Njcb3u2K
        OoYWAa+fGXggQHL0fTnDpJ7wvrBBUjzRK6aiCy0=
X-Google-Smtp-Source: ABdhPJyAe5UnFIIefjeCQ7lyCJoaXg9dQlqs5YWp+6bozjLqI+f6cKyL2Z06ocEcRIxz94VzK8QoOBCTKjhmSTrR4+c=
X-Received: by 2002:a25:dfd3:0:b0:629:24ff:eab0 with SMTP id
 w202-20020a25dfd3000000b0062924ffeab0mr5097816ybg.613.1646632976811; Sun, 06
 Mar 2022 22:02:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6918:b986:b0:a4:b698:78d9 with HTTP; Sun, 6 Mar 2022
 22:02:56 -0800 (PST)
Reply-To: markwillima00@gmail.com
From:   Mark <markpeterdavid@gmail.com>
Date:   Sun, 6 Mar 2022 22:02:56 -0800
Message-ID: <CAC_St2-sdO6bqD=Ek0iLO-xK1-wW3yNcMoWDU3W-5iJ1Rf4Gsg@mail.gmail.com>
Subject: Re: Greetings!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5002]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [markwillima00[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [markpeterdavid[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
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
