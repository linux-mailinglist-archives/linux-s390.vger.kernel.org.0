Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFD81C61A1
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 22:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgEEUKE (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 16:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728076AbgEEUKE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 16:10:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25989C061A0F
        for <linux-s390@vger.kernel.org>; Tue,  5 May 2020 13:10:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so32989otu.1
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 13:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHTwlgdwogMaMauWudijcuKhbWcUeWAm3wC8aKEGoGs=;
        b=GHjgCMOe8Ff1xkRGxZmhuI8ghIbPLW4dHl0dpKobopTJc41in+IJyncK1tVxF5/LTr
         gS0y4bPI+KFvs6u0ZVGO8Xy4BB7RzQbtdWZYKei/co/Yv2QoyDhsXnMTcPvAjApflxuF
         zHChxFMlDnfpUW3q4zmAjkwdVkZ5/gteZDjP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHTwlgdwogMaMauWudijcuKhbWcUeWAm3wC8aKEGoGs=;
        b=G9A4Dpdlgu9REa5ZRSQme9QiDvZF610S0DaczEbHR2ail2bAz0YFL/ffCvPqM3S/0e
         QUIHGnwrqfyVDJ33bP/QTRahK4KMV37tGVQu5rYkhNqtr4GOK85f4Pmb+XkhoMrI/BSP
         5J0Fsg6e2EeY36kViYlw7vWHPSuAupsyQ2HbyP8XNn/qO/ywy3WqGUapBkwex+/bIEdB
         sFTbYTRpf07AKO4cWQUYDhRWKlNlXUr9L2oBtSvEFK9VxWXQ5I/94dXjPm3pBR6GPwc0
         k6vffAWCw7N7Qr3ESNyfbdD3ndcVL6g6hk/PgIsUpg4UKZcMwxwyzsJ83mHgIH+guLne
         W17Q==
X-Gm-Message-State: AGi0PuaEYBzCeEp+88Wici1CLVSghORR6wVxFot03wpAvAj8i8yYxHMw
        fb23H71bFeB+By51rR4KTq6PWEiU5YLJXnBBSNxpEUzvFd4=
X-Google-Smtp-Source: APiQypJStawP9vJJqKbd5Qx2KNsVl70G0sQGOdwSYIg9LgR2Vh53MnSwYthujuHw5vVqN7DzpLyygyD5ljNHsxM2Aq8=
X-Received: by 2002:a05:6830:1e1c:: with SMTP id s28mr3549585otr.207.1588709403259;
 Tue, 05 May 2020 13:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200505162559.14138-1-jwi@linux.ibm.com> <20200505162559.14138-11-jwi@linux.ibm.com>
 <20200505102149.1fd5b9ba@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <a19ccf27-2280-036c-057f-8e6d2319bb28@linux.ibm.com> <20200505112940.6fe70918@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <6788c6f1-52cb-c421-7251-500a391bb48b@linux.ibm.com>
In-Reply-To: <6788c6f1-52cb-c421-7251-500a391bb48b@linux.ibm.com>
From:   Edwin Peer <edwin.peer@broadcom.com>
Date:   Tue, 5 May 2020 13:09:27 -0700
Message-ID: <CAKOOJTzfbo9NJpOWpNn5B-oQ_yTvc7-ZxJP6dWvCV46p0z-T3A@mail.gmail.com>
Subject: Re: [PATCH net-next 10/11] s390/qeth: allow reset via ethtool
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 5, 2020 at 12:57 PM Julian Wiedmann <jwi@linux.ibm.com> wrote:

> It's a virtual device, _none_ of them make much sense?!

Why not introduce a new reset bit that captures the semantics of
whatever qeth_schedule_recovery does?

Regards,
Edwin Peer
