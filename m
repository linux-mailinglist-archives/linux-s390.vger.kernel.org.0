Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A05857473D
	for <lists+linux-s390@lfdr.de>; Thu, 14 Jul 2022 10:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbiGNIiK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 14 Jul 2022 04:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236882AbiGNIhR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Jul 2022 04:37:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ACA3ED4A
        for <linux-s390@vger.kernel.org>; Thu, 14 Jul 2022 01:37:14 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id t25so1633034lfg.7
        for <linux-s390@vger.kernel.org>; Thu, 14 Jul 2022 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=H3bGT1ZyGPu3PRQJlJHyQI9TvTjBPuNSyHjFOzNfiP0=;
        b=eOKhIHPUU5qPTZbjyQcWfvRUY0zDAP8hnIUzGBjF2Jn5DfdNsbEWN2bt7ALPYmKFVp
         Dxr1gDHkbIBW6Zt+nHPJYVynuk8AW0yQZ/Zbg6Hs/Db/0s9SnaRXX8dPxs4FUxGCTJqt
         PUYZva9zdBfTCaw+ACjLsUUgRvbYiV1yKAF3EhOBh+YW55bYBsAw2vjNobpxCrdB648X
         A9Vj0WSfJubet8viXTg/I9X1Zmn6KwP7YNCJiSogQMOb5VTL9XQBYGsxHSC28kklqMwQ
         Xqm1mx/as6lOSd/UexvuUJPMkR0uIfSfLSUsGSd7SP6mXh7BeziDYVk18AfHAMhcFado
         ZNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=H3bGT1ZyGPu3PRQJlJHyQI9TvTjBPuNSyHjFOzNfiP0=;
        b=LyyMizCIUC/B/a0RPQq6i/flwhXzlBxozACWbOfnWLKDOUTrd3HXmb1F24kFvnVenV
         l/2dXeGDgzCxBnnlXoX26ebEMZn7aQHUpvIJknmB94/5UoVsRwmes0wR8mQiwhrAHnNW
         ScNJG1l3Pv0Z15gflq78aP99qYacABUraaCCyKii/hY2Nm/AwSuRcmvw/vQd4eObR4/d
         ZQp3e2zXSQkhV35HKZhdZ0BIDqJEp631ZNhChSdNR2zkJ1LUG1qF2zYoDU00eR0EZr73
         rbuErSbRT9HEeqlwq6VeqWEkncUI55WTTj4dJAlqA7vRj5RTckXHME3sA+uhyyKkzvPW
         u8zw==
X-Gm-Message-State: AJIora9OBO09IxZfLiND5L5HFKoxHb1WzmNaiJmbgSs4wp2AGgGGsVfr
        id40QZ1JA/2rSsEGHdFhRHIT0ccx/r66lSt0XfM=
X-Google-Smtp-Source: AGRyM1suH6kpL0bxxrdPqBdRw7fjg6QmbYsIJ5KtUWeYknhIH8CIkHpjEQ1bnLxbFcENJg0E8wYhVlYhJeESVTPizkI=
X-Received: by 2002:a05:6512:12c8:b0:489:efbf:18d1 with SMTP id
 p8-20020a05651212c800b00489efbf18d1mr4734610lfg.192.1657787832538; Thu, 14
 Jul 2022 01:37:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9041:0:0:0:0:0 with HTTP; Thu, 14 Jul 2022 01:37:11
 -0700 (PDT)
Reply-To: abdwabbomaddahm@gmail.com
From:   Abdwabbo Maddah <abdwabbomaddah746@gmail.com>
Date:   Thu, 14 Jul 2022 09:37:11 +0100
Message-ID: <CAFC-3icPrpmNqEMcqzAOFvzCPc-r5yv89mNAZ9SsCQvcOZ=+9g@mail.gmail.com>
Subject: Get back to me... URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:132 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4900]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [abdwabbomaddah746[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [abdwabbomaddah746[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.
Abd-Wabbo Maddah
