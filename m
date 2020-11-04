Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD71F2A6EF8
	for <lists+linux-s390@lfdr.de>; Wed,  4 Nov 2020 21:40:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgKDUk4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 4 Nov 2020 15:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgKDUk4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 15:40:56 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94BAC0613D4
        for <linux-s390@vger.kernel.org>; Wed,  4 Nov 2020 12:40:55 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so31755064ejm.0
        for <linux-s390@vger.kernel.org>; Wed, 04 Nov 2020 12:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QOvOv6k4yxUy0hyawpvvCGGKwO1X441zF4A9AtOMrdE=;
        b=PSmjLCkAh+tIc9NbfITOvBRkKiWDnO80opt3qIqCSXQQTsixM9SCCNDDHcEJnRuqIz
         abB5KKtzf2ObH9dyFQNSMRXlwPgb0roeePf4z4qMoerGYzzo32lDfBDRmeNAnzSPL0fr
         muD5aW7EWjR0p8kDND1mhYymyBir12oOTsp9uVjV3IEn7vk/MX/F0gm/gMaXxaecDdwZ
         IbPin8k/mrxRGv/k8RHST3XIinryQXZ/7e4mI+OXS62+NmY09vFEQMHritLkEyIDvGM5
         gCrkCQ3/i33cO2Nf6zGBcZB6DPkNUn6ktOLpY6CrEIL1rPKG8+6s2gY5PE3HA908nSdE
         HYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QOvOv6k4yxUy0hyawpvvCGGKwO1X441zF4A9AtOMrdE=;
        b=ZzE5VKoKVvFfDcSncL20K9WRKU65OmQAveurh7bO4DN8vKn9Km6IyZg2k/HFeHKydl
         9g3BNu1SNn1luSv+GXN0rzhX50Tt8/geCYXV8NR5BuH711LKQGidKPyfYbsM+BEpaYre
         XZfzhgNSJ/GE+pwbru/eN55ww8tXOJV9zTYzhSAbD++HTRX6dzOL+CkwKX0AM8C3Js0i
         //EBh7QkIy7Jv7jPijA0akPSgrNnrEeMrVTSj0BhklaOPiAfEouF8xQu7tVq5lkY+B9f
         CsNyuDOAFWc8A+NOIBAUEguSmUf1uf2tfTEP13pnSES35R+5VGBe05n94tKuMisEbgm9
         VchQ==
X-Gm-Message-State: AOAM532otbq9qMtiAnt5iiBQtNJuuTinMyef93iq/2k9Z1YnhQu2QkIx
        ewT8xNBtxjxiZvZrugJl/4bJU625QJhqADPMKi3s
X-Google-Smtp-Source: ABdhPJyh4WUv5vFp0gfxQlwd97hCqaxvwLiCSg9gka7Yv4g0BlXFbWbPQ4ZynRy96ZD57vo9hNzGK/6Fuq4ZIOzWzJ0=
X-Received: by 2002:a17:906:cb0f:: with SMTP id lk15mr17846190ejb.431.1604522454330;
 Wed, 04 Nov 2020 12:40:54 -0800 (PST)
MIME-Version: 1.0
References: <CAHC9VhQTp3Rc_7zM661Rzur0XSuWRWKJJg=CwLPAQo5ABRpS-w@mail.gmail.com>
 <20201009013630.6777-1-rentianyue@tj.kylinos.cn> <20201009013630.6777-2-rentianyue@tj.kylinos.cn>
 <CAHC9VhR2KPKN8ot9WrkjZQ08X-VPDGkXro18C5jhDEwcFH6wog@mail.gmail.com>
 <yt9dh7q64m8a.fsf@linux.ibm.com> <CAHC9VhT-dgT8pP7ZfPu+Ssw4RAYUpcwhTWfXXeciVPz0mRcP3A@mail.gmail.com>
 <yt9dpn4u9scs.fsf@linux.ibm.com> <CAHC9VhRxm=YR1yBy8fnWPXRZ48pq4MA4b26YAtqAJORJZD61wg@mail.gmail.com>
 <yt9dpn4twqp1.fsf@linux.ibm.com>
In-Reply-To: <yt9dpn4twqp1.fsf@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 4 Nov 2020 15:40:43 -0500
Message-ID: <CAHC9VhRzJEdqTywGnCtq8mb5C=4k99oJ1ZTH64n4KcWn0mF0pA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] selinux: fix error initialization in inode_doinit_with_dentry()
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     rentianyue@tj.kylinos.cn,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Andreas Gruenbacher <agruenba@redhat.com>, yangzhao@kylinos.cn,
        selinux@vger.kernel.org, Tianyue Ren <rentianyue@kylinos.cn>,
        linux-s390@vger.kernel.org, hca@linux.ibm.com,
        borntraeger@de.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 4, 2020 at 2:02 AM Sven Schnelle <svens@linux.ibm.com> wrote:
> Paul Moore <paul@paul-moore.com> writes:
> > On Tue, Nov 3, 2020 at 2:02 PM Sven Schnelle <svens@linux.ibm.com> wrote:
> >> Thanks for the patch. Unfortunately it doesn't seem to change anything
> >> for me. I can take a look into this tomorrow, but i don't know much
> >> about the internals of selinux, so i'm not sure whether i'm of much help.
> >
> > I'm sorry that patch didn't work out.  I just spent some more time
> > looking at the code+patch and the only other thing that I can see is
> > that if we mark the isec invalid, we don't bother setting the
> > isec->sid value to whatever default we may have already found.  In a
> > perfect world this shouldn't matter, but if for whatever reason the
> > kernel can't revalidate the inode's label when it tries later it will
> > fallback to that default isec->sid.
> >
> > I'm sorry to ask this again, but would you be able to test the attached patch?
>
> This patch fixes the issue. So it looks like your assumption is right.

Great, I'm glad that fixed the problem you were seeing; thanks for
your help with testing!  I'll post a proper version of the patch to
the list later today.

-- 
paul moore
www.paul-moore.com
