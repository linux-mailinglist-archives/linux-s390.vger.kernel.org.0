Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFA94C5380
	for <lists+linux-s390@lfdr.de>; Sat, 26 Feb 2022 04:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiBZDM0 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 25 Feb 2022 22:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiBZDMZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Feb 2022 22:12:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496732671EC
        for <linux-s390@vger.kernel.org>; Fri, 25 Feb 2022 19:11:52 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id n25-20020a05600c3b9900b00380f41e51e6so2773912wms.2
        for <linux-s390@vger.kernel.org>; Fri, 25 Feb 2022 19:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=1WmTiruYcLYjgfCVpwaSh4JcERuBX8rKufTgiQZnbQI=;
        b=BoqVQHt6JQ5I7JtsAWqwrjbfn676fu98HobhqaiOHHD1sRoS3hA18X7nI2SVy+M+WP
         hiQUZBOE1sHRErmv1tEiQgtvwDoSPWc2P+uqdMjbYpGHNNEINDkfj4G2VamoWPNLKTw6
         ZrNp6QT4hGAT0hNGeBULSBRpBQSRcwFg/T1ZZQ1hF7jxfMOtOYzuKwjq3CUHRJGlU3KT
         r3KpAH2NXK7xHdO1cea/fmOErT5J0DQcPK+IyqcROjigOp+ArFXI3mxvmSS8yBbYZMET
         v+5ACRSXLz3MqwJ/vfTxFpnh0vNqOGsLuQyv3QV8cPn1BmjQMKnXpdk96B7Z61AsZ13v
         vAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=1WmTiruYcLYjgfCVpwaSh4JcERuBX8rKufTgiQZnbQI=;
        b=bnzb3sXWBZJnUJUK8hQReFJXoMapFpEvX0sW3KOCXG/7Ok1JTqHjQJTr3XDDixZ+KN
         JMqrjyoD8G3Fm4ZZxMxKZ7X+F4GaHmdxaJUZKv5qSHkqYlQe4DN45UZ1QYCeWlrphFtk
         5CSGdMWouOfnAiEClMYxbBqrmfzp1l20xbkOSrouHQcUXUzFfTI6Y/6/P735ERSQnXEF
         6NyYHdFsMJ49rNdi6NhF6UH5DXPcENfU0xd7qxK36qt7pm4s4sNkhuRuUzFrYM3W9JoF
         hJo20YrMBUhEQXFGJ1bvSzF9eqdJPxwVEInIy4Z2Rihzty14pc9pKE1/J1ASi4RcuFbh
         t7Aw==
X-Gm-Message-State: AOAM531wknTg2G53KQzk+MfnbsAhmf+opH5KdxS61XV6Wrtj/Of34jNA
        4UVmOHqGnrhs4M5blKpK078Iw21e3nnDeud7Lns=
X-Google-Smtp-Source: ABdhPJynBaHqyA9yHQVDtUXwYZu1XZSnKSikSc2o1MJUOrZ2kl3jzS0+YiR6UJwkMky63l/7BUQbuGZeFCU8Z4g9pcs=
X-Received: by 2002:a05:600c:a4b:b0:37b:ea2b:5583 with SMTP id
 c11-20020a05600c0a4b00b0037bea2b5583mr5104668wmq.139.1645845110032; Fri, 25
 Feb 2022 19:11:50 -0800 (PST)
MIME-Version: 1.0
Sender: ag2439229@gmail.com
Received: by 2002:adf:c793:0:0:0:0:0 with HTTP; Fri, 25 Feb 2022 19:11:49
 -0800 (PST)
From:   aisha gaddafi <madamisha00@gmail.com>
Date:   Sat, 26 Feb 2022 04:11:49 +0100
X-Google-Sender-Auth: PBXvlLd4xQgHcAfA8zzlHoyNdQA
Message-ID: <CALz623FZ2SReVUMHC8AK13M9qK+f=gw4ko=n_dTUbaef5=g40w@mail.gmail.com>
Subject: I want to invest in your country
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MILLION_HUNDRED,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:341 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ag2439229[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ag2439229[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=20
Greetings Sir/Madam.

I want to invest in your country
May i use this medium to open a mutual communication with you, and
seeking your acceptance towards investing in your country under your
management as my partner, My name is Aisha Gaddafi , i am a Widow and
single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Gaddafi) and presently i
am under political asylum protection by the  Government of this
nation.
I have funds worth =E2=80=9CTwenty Seven Million Five Hundred Thousand Unit=
ed
State Dollars=E2=80=9D -$27.500.000.00 US Dollars which i want to entrust o=
n
you for investment project in your country. If you are willing to
handle this project on my behalf, kindly reply urgent to enable me
provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address
below: madamgadafiaisha@gmail.com
Thanks
Yours Truly Aisha
