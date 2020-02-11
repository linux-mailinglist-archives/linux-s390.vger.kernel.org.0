Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 881B915962A
	for <lists+linux-s390@lfdr.de>; Tue, 11 Feb 2020 18:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBKRaj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 11 Feb 2020 12:30:39 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46336 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbgBKRah (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Feb 2020 12:30:37 -0500
Received: by mail-pf1-f193.google.com with SMTP id k29so5794322pfp.13
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 09:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bM2xQLURwsdpapQPw/vmgOLzWTtBkTWZo2XFKd2Fc+8=;
        b=UhUw4kZ1K/iv8XUFtbPsZE67iNVKeF3gHIfx4luTMSun/AiazJMw/EhJEbjEDMBGmB
         IqkfDnBx6ZhCodlj5vim1mqgXSqx4dtTLeAMl1sHlPvPJrMFH+QjPQbnAhl8DRqzyE+0
         bIMARUOacrDFUrqJe0XAE5Yej6WjDvGozDQToeELMtee1XjWWUOfbZdtE8RuI4cMQYMh
         FSa1l1RbZdqAagpgEPYEpj3R5jY8Jt77f+SHxdbtFHupODk8rpqr6dsAe2WScGXupCO4
         N4eiUMj6bxYgriLnjs33AThtA8d9tFc2NTnxxuziVV0X7UnODYSuSEAmeh8e8uSnsF0U
         xyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bM2xQLURwsdpapQPw/vmgOLzWTtBkTWZo2XFKd2Fc+8=;
        b=h2vAeZ79qE3dXNIHRJs0WsBnPBh6KGIxS5Pl9U5rUxyZ5STWfj7FuWOL7hh6ETjTDQ
         9ePavR9s/zP70GG2qxxRiyJDRbzVQ5VaZV+gglFyZK3CZey/aOB4PyECoB8d1NskNWfi
         hb9ksOXeUy4ioyQ/GzDa/42UCoVvIxykJRTEdOo+nzKl/YOqRXt0j4d2v8Y8SG5j0+Mj
         uKhaVg/9UjtF9L6sJ+79WlPH/iHaMd7pa3w+yVJWj8+f9qpudg7rIrP8VRQjzTuoLvRN
         oBtY80VxPUZeitf5B+s+lO/qUs/c/wHySiSSiwiQGucGge9R1k7HFanemUVnYNt8gFIx
         p0iQ==
X-Gm-Message-State: APjAAAUoKcof1Sza8hm4+DxRid4LKK/WFfbm0pVihUhiINUFHOkQPppX
        nAA2P2dkzYhRA/oQeFLCu1CYitlyOYn4YlupB+Loxw==
X-Google-Smtp-Source: APXvYqx1sbmFj+6yubaRWA1F7s2PkQxLnUx1wxZkhe3GdVuGxqkwu5RKJGr9IlPthyKETEuHKtKYLUWWHfSwkJVG48Y=
X-Received: by 2002:a63:64c5:: with SMTP id y188mr7815807pgb.10.1581442235797;
 Tue, 11 Feb 2020 09:30:35 -0800 (PST)
MIME-Version: 1.0
References: <20200208140858.47970-1-natechancellor@gmail.com> <your-ad-here.call-01581426728-ext-3459@work.hours>
In-Reply-To: <your-ad-here.call-01581426728-ext-3459@work.hours>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Feb 2020 17:30:24 +0000
Message-ID: <CAKwvOd=CWKnrY_T8vP4a-KXkz-V57dFqk+6FC_krm=pVAVibyg@mail.gmail.com>
Subject: Re: [PATCH] s390/time: Fix clk type in get_tod_clock
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Feb 11, 2020 at 5:12 AM Vasily Gorbik <gor@linux.ibm.com> wrote:
> Applied, thanks.

Hi Vasily, is this the expected tree+branch that the patch will be
pushed to? (I'm trying to track when+where our patches land).
https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/log/?h=fixes

-- 
Thanks,
~Nick Desaulniers
