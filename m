Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854DC641AB8
	for <lists+linux-s390@lfdr.de>; Sun,  4 Dec 2022 05:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLDEu7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 3 Dec 2022 23:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiLDEuz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 3 Dec 2022 23:50:55 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1884A1AD81
        for <linux-s390@vger.kernel.org>; Sat,  3 Dec 2022 20:50:53 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id b16so1826630yba.0
        for <linux-s390@vger.kernel.org>; Sat, 03 Dec 2022 20:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ll505mTuuhfLc1+XZSIHO0whLDL6v0gWWrPnec0ii4Y=;
        b=k5mVMRjqX7Si5uG9z+Uscvrtps9Lm4l+J08vtkBLLMictjduN7yw83tsE++Hu+Y+Aj
         tzGMjHp1B1DVBsHBeaAno3yi2BVO1izqPQNjfE9efhoNad2WkUqtmN+u5ck7CRIJRDjF
         YM/dl+7BGD8/nxeEUA1XSJ81WAfcs6vkCLEGMF0P2bL6CTiqD6TUfX0qPUwprGQelNlI
         Y8aZ2lCfq+dEaYid+X7MscI8qzgPVVQAZJUwygBrxro7blbU3pOBNekJtI9+G2UshZ3G
         GHc7S9u550foOhzqlp8cvkhkpghQSTF1P8bew1u3cg2NPkmwUqUch+maLgoYjzwwvL3H
         yPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ll505mTuuhfLc1+XZSIHO0whLDL6v0gWWrPnec0ii4Y=;
        b=dceJWxrH/h180aqlrf0q2e0O6gmfxWxewzNyq9CnK6fIgUkDLnLMaFGYw/IKJw6cwi
         MTfBFyq8Vt5aed1H9GCSPMEd1xATzGPCPPyKuL69YdNb/KTOdbhQui9uqq/MMGwZbQ2s
         U0X7tjEiE+HWXmN5A01VxdAJN0EG77CauVbMOnJ0aVqN1Yg3wE6wm4s3dZB9VnYAMlMg
         /tgINcGSw1KeStVrT+hrKFCuGWaIApBWdAFcCP4QtOSlOCbKYb235T3rNUTM347wnKst
         Uq/ok4U0pJS/gPHf1gudHPUt+QvmYWWZMmZuKuCzmGg94YIW3ZVy/ysFSHrVj0gC3iqa
         EW2A==
X-Gm-Message-State: ANoB5pkOWMR/VZ11L7/NrSLMkOSJJ/UP+1y72IQGML05RsQ9yLIQw3SE
        Lq+wDJ5dA8LQ/l2fe8WI7cqm4TA70Og30N/dt7Q7RfeU8D2fOg==
X-Google-Smtp-Source: AA0mqf52pBcclC9lDKWIBghKNsRoQBaHiaJZlm0JdUCM7v2WBwAs6EPMpN3sOutADe/7qyKy21QWPgWJqBBadM6ij9I=
X-Received: by 2002:a25:ae08:0:b0:6fc:e336:3785 with SMTP id
 a8-20020a25ae08000000b006fce3363785mr10299755ybj.166.1670129451952; Sat, 03
 Dec 2022 20:50:51 -0800 (PST)
MIME-Version: 1.0
References: <20220830193701.1702962-1-maskray@google.com> <20220910075316.no72fdyqjvunomwm@google.com>
 <CAFP8O3+OwanSJdzd5V3oGJ_MOJOSVdbn+4iBJJKm2LCR8mCA0Q@mail.gmail.com>
 <9ce45cd2-dcd8-11f8-e496-7efe3649e241@csgroup.eu> <20221115004625.x4wl6zbg4iiuxl5t@google.com>
In-Reply-To: <20221115004625.x4wl6zbg4iiuxl5t@google.com>
From:   Fangrui Song <maskray@google.com>
Date:   Sat, 3 Dec 2022 20:50:40 -0800
Message-ID: <CAFP8O3LdSJCChGEwT57e=iZopceYkBFuW9XD=yhO1ZszVZGm4g@mail.gmail.com>
Subject: Re: [PATCH] vdso: Improve cmd_vdso_check to check all dynamic relocations
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 14, 2022 at 4:46 PM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-11-14, Christophe Leroy wrote:
> >
> >
> >Le 28/09/2022 =C3=A0 07:25, Fangrui Song a =C3=A9crit :
> >> On Sat, Sep 10, 2022 at 12:53 AM Fangrui Song <maskray@google.com> wro=
te:
> >>>
> >>> On 2022-08-30, Fangrui Song wrote:
> >>>> The actual intention is that no dynamic relocation exists. However, =
some
> >>>> GNU ld ports produce unneeded R_*_NONE. (If a port is not care enoug=
h to
> >>>> determine the exact .rel[a].dyn size, the trailing zeros become R_*_=
NONE
> >>>> relocations. E.g. powerpc64le ld as of 2.38 has the issue with
> >>>> defconfig.) R_*_NONE are generally no-op in the dynamic loaders. So =
just
> >>>> ignore them.
> >>>>
> >>>> With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS =
is a
> >>>> bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which =
are
> >>>> not called "absolute relocations". (The patch is motivated by the ar=
m64
> >>>> port missing R_AARCH64_RELATIVE.)
> >>>>
> >>>> While here, replace "egrep" with "grep" as "egrep" is deprecated in =
GNU
> >>>> grep 3.7.
> >>>>
> >>>> Signed-off-by: Fangrui Song <maskray@google.com>
> >>>> ---
> >>>> [...]
> >>>>
> >>>
> >>> Ping.
> >>
> >> Ping^2 :)
> >
> >Can you explain which ARCH_REL_TYPE_ABS can be removed with this change =
?
> >How is the verification done if ARCH_REL_TYPE_ABS is removed ?
>
> All ARCH_REL_TYPE_ABS relocation types can be removed. As explained, the
> real intention is to check no dynamic relocation, and this is done by
> the new
>
>    cmd_vdso_check =3D if $(READELF) -rW $@ | grep -v _NONE | grep -q "R_\=
w*_"; \
>
> in this patch.
>
> grep -v _NONE is to work around some GNU ld ports (and likely older relea=
ses
> of some ports even if their latest versions are fixed) which produce
> unneeded R_*_NONE dynamic relocations.

Ping :)
