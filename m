Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD12246E4E
	for <lists+linux-s390@lfdr.de>; Mon, 17 Aug 2020 19:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbgHQR1d (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Aug 2020 13:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731428AbgHQRUC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 13:20:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1A8C061389
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 10:20:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f24so18662498ejx.6
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmd.nu; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=RXi203ttZBEY4dGIWtwJA/nYmzrH6lL89pDg/BYwnKk=;
        b=FRuxRa7lTh8IhYIiuN1Wzq+zlLXGD8sx0kMJSa3C5Y0P3iYRwLcIoCQuf7YL29s8TH
         G0VwQaVzuVIQYC4lv50F98TfRKH+U/ELJgLLa6A5eZUatiWNY0pyIHk8ZCuz/5mIjKFD
         Fk9K+9xKXXpNGs8sj6wz927sPNqD3jJlmPmSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RXi203ttZBEY4dGIWtwJA/nYmzrH6lL89pDg/BYwnKk=;
        b=D8se6OeF5yk0TLyHOLRdyyzMUpN4sGx+fd4c/HM5ML9iwpM+jp40q2GHQcNzbv3IUr
         SlZtpS1Ng5cPuGKkKRaCfGvqhIuS/WWUlUuDk6WUG031YnoBZf2H1y3z25CitFtnBp/M
         d8itIPf56lNdNUzF3NdK375kI0TOxxc6J2yzewgtaPb0sWgopzLoD6M1AU56ahI+GNu0
         Wx2czzB/fDxmJ6cjzn9niLZxy8TIy11wuC1wqZAYgdyIa5R0XlA0jDg52UPpMH22jEbc
         mGd+9phbFaX488neD9XvdCO7BAnjWKcO8QLE0SmWvznMxaIlwQYRWdhUXYITsDtj+S1B
         r/ow==
X-Gm-Message-State: AOAM530Z17J+2oOUokJnD40rVKQjOSlbG3B6UY5eblYDpPvIwuo22zOO
        Wwoj2qUTeF1Hds4MbN1n6Br0KVMq9HOpmoeT+R+x2Uinv/LfjsVM
X-Google-Smtp-Source: ABdhPJxFtSYmBnYmLbDi0/tcg8IdIlIhCB5qExF/T2FgIU1ccwLdwwLfkYuF5eJF4YImz01JHl+LkV1PBbWzB9FUkTg=
X-Received: by 2002:a17:907:11d0:: with SMTP id va16mr16741375ejb.426.1597684799437;
 Mon, 17 Aug 2020 10:19:59 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Svensson <christian@cmd.nu>
Date:   Mon, 17 Aug 2020 19:19:47 +0200
Message-ID: <CADiuDAQuKZWppo6geDiquAbfak6+Y8MNALtEXcwbAP+MWYa6Pg@mail.gmail.com>
Subject: IUCV 2WAY missing from AF_IUCV?
To:     linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

[This message was posted to the z/VM and linux-390 message list as well]

I am trying to call TCPIP service using IUCV.
I found AF_IUCV which seemed to do what I want, but reading
more into it it looks like AF_IUCV only ever implemented one-way
SEND operations.

Is that correct?

There appears to exist a message_send and a message_send2way in
the Linux IUCV interface, however only message_send appears to be used
by AF_IUCV.

If my reading is correct, is there any way I can work around this
without writing a kernel module?

Thanks
