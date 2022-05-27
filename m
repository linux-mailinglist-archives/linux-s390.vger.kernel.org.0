Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F38535B5B
	for <lists+linux-s390@lfdr.de>; Fri, 27 May 2022 10:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241205AbiE0IUI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 May 2022 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240910AbiE0IUH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 27 May 2022 04:20:07 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFA10276F
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 01:20:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t26so4559709edt.0
        for <linux-s390@vger.kernel.org>; Fri, 27 May 2022 01:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=q5z3Aufdrp/Gxi62uQV7hECtfAkDuGBcrftkqEmnImQ4nZWtXCDLQSUGZVAuB88pWo
         lNBAmHVQ4yGI5QQ4VX7WIWnnnSxxBk0mNSYbZIXj+OuEgZ29GJyTWu2djYrt4+zeOdKw
         cQ4FKj6b38cPZBQdSDR5F9CYFJRyFKqW8L0y3Mqzcr0vfS6zGoGNjhA8RR8BKj6ms/dk
         3VU/+Lx6y2bXY+1wc14rQa9Z0M6+2q+ckWbFMg5EKRaKiGCH6xXD3Lyvv11Ukga/QoB1
         xBuK08wSFO6Sf2XcQHUNMO4hmwkF7x2sWV2NvChYO3zW1UEBrbahQWtSeVDXqaGwKcW7
         T1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=FqppV2SUgtCfJQDai6SE0dll0ArgCakZHSHGP4kBK1uKLhh4qzCDur5Zy8i0woQ9PU
         R7e1sC+q2I2uzLAx6tKbC7P7bB8VgaKmQ+JSGvj95PVJiTdxF2e7467IC8i6+JiWcRQI
         fMErP57YO9tOsz4oSL0EVhuZ6/z7zY9RljFdY9ayVj57wjPFMtdf/S+l0lsEsP3xmcOr
         nUFYKbFFaadpCTkRr4z4wHk9+QQbyEmypztD776J2N40xSWaXNTI/McT/pc9WRkBrs4k
         5O7GZ0IcRE8QFB5Xi0RCI4JnAnb3PYluXqY17a+5J4Imud8s2hSH0xwvkEATXOmrOf0i
         X2Ng==
X-Gm-Message-State: AOAM532aA60ylrH5iCZyceYLNddSj8D2XgkIuuKULWbEU6mYz5AmJ+s8
        EnVstn99/3gwCFyHn7nlTa+BInETWd/PJov/wcg=
X-Google-Smtp-Source: ABdhPJyGH2WttTLj12vQVAglvL1i6kowj67BaAF+mTlYsVmet3/ALeTMaRvssWDytofpoNk0nkXRrCqb4sBdB3FnBjU=
X-Received: by 2002:aa7:d6c3:0:b0:42a:cc78:1764 with SMTP id
 x3-20020aa7d6c3000000b0042acc781764mr43470611edr.134.1653639604232; Fri, 27
 May 2022 01:20:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:2550:0:0:0:0:0 with HTTP; Fri, 27 May 2022 01:20:03
 -0700 (PDT)
Reply-To: tonywenn@asia.com
From:   Tony Wen <ezhejianghuayan@gmail.com>
Date:   Fri, 27 May 2022 04:20:03 -0400
Message-ID: <CAF6pdHzr08vHQ--Huzovdy0=b+gR_90VKvjxFdRm1Pp4YkRnJw@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Can I engage your services?
