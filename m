Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594D23F778
	for <lists+linux-s390@lfdr.de>; Sat,  8 Aug 2020 14:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgHHMLG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 8 Aug 2020 08:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHHMKx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 8 Aug 2020 08:10:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7238EC061756
        for <linux-s390@vger.kernel.org>; Sat,  8 Aug 2020 05:10:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d19so2372113pgl.10
        for <linux-s390@vger.kernel.org>; Sat, 08 Aug 2020 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EuDMSmp04hSHSVLRHL1PUWBPuYB4U3JnGDB9t2qv6ho=;
        b=a27s0HjDAgd0N2W+2hyaEb/r9U8rPWgKPcToKVqzsY6g1RHey3lP/n73NLKJYe/Ok9
         55O55oJSSu9auuHd0IZZMeayaFYrB0XkDdzao+sYMQoIml9w00hFjBH8r/pwdPpew/sz
         D4U3ycTuRW2hhSyGQ/+vQPPBrkxE9ZKOeqrJhg7L0PM3vPL7tG3pJcxpNVs3aBK4ByJe
         KCqGQqzLjn/hShsU0zUkoh4exC0lP0KHzK4vtrIfJ3N9ohkhYUxOT1oj/NDw/OG3J1d+
         9y8hysX2pQorUHhg24RtZ6E+WgR2WN28nXtkQnzysvPpbbsZGt1ljbQWW59Kk3ViJl54
         tcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EuDMSmp04hSHSVLRHL1PUWBPuYB4U3JnGDB9t2qv6ho=;
        b=ZP5GytSS/d4lxZnO8T///uzKGvwMAXWVHR4vmay83oGu6EjjFkH8SD2iEPcoyydyk6
         pwGbQLt60Jw6/z8qDBnILAywMwJDVOIQSQ5kHuoc9XLXtgRgRYruHv4lH8QVhAibzzYM
         Ois9pyKXHXFz713d69dPQjSqVFrx6um1tvogHvRWPLk4mlRjhE+E+NJtLK4YRXaoIBDf
         lMS72AsMI3Xglz3tITZjQNyx8TSjYydPIXO0PsWlGEKeysdAc5yv36TgHvlTTvNCXZdl
         4DNzbeCIx6hmqap4eV3c3da88wy3aAWC9C3FUfrJ4r13jp8L4dhCqrgChqgjEs6DmqBm
         +Vag==
X-Gm-Message-State: AOAM5315B0vGMGzYXuEKmn/uS3gcuNIpJsbVR9ixVMTTTALuAWtvzFUN
        LmAmma4pnnAEvVwGvt/8WvzhXqzKy8p7l4fdWAU0+g==
X-Google-Smtp-Source: ABdhPJzM1muWFLwLDSvo0MoNAYjZ2t7+UNajWvXxXMkjymrpkaeIPbZuHepCLbtxZZBVSatO1nbVYIIZ+/IHe775HYM=
X-Received: by 2002:a63:4b44:: with SMTP id k4mr15861573pgl.305.1596888644708;
 Sat, 08 Aug 2020 05:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200807162010.18979-1-andrei.botila@oss.nxp.com> <20200807162010.18979-17-andrei.botila@oss.nxp.com>
In-Reply-To: <20200807162010.18979-17-andrei.botila@oss.nxp.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Sat, 8 Aug 2020 15:10:33 +0300
Message-ID: <CAOtvUMero-gF5ZE1unnD_wcDnzZX_SL0tQ2yJNqzc3rg5RhuDA@mail.gmail.com>
Subject: Re: [PATCH 16/22] crypto: ccree - add check for xts input length
 equal to zero
To:     Andrei Botila <andrei.botila@oss.nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, x86@kernel.org,
        linux-arm-kernel@axis.com, Andrei Botila <andrei.botila@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 7, 2020 at 7:22 PM Andrei Botila <andrei.botila@oss.nxp.com> wr=
ote:
>
> From: Andrei Botila <andrei.botila@nxp.com>
>
> Standardize the way input lengths equal to 0 are handled in all skcipher
> algorithms. All the algorithms return 0 for input lengths equal to zero.
> This change has implications not only for xts(aes) but also for cts(cbc(a=
es))
> and cts(cbc(paes)).
>
> Cc: Gilad Ben-Yossef <gilad@benyossef.com>
> Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_c=
ipher.c
> index 076669dc1035..112bb8b4dce6 100644
> --- a/drivers/crypto/ccree/cc_cipher.c
> +++ b/drivers/crypto/ccree/cc_cipher.c
> @@ -912,17 +912,18 @@ static int cc_cipher_process(struct skcipher_reques=
t *req,
>
>         /* STAT_PHASE_0: Init and sanity checks */
>
> -       if (validate_data_size(ctx_p, nbytes)) {
> -               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> -               rc =3D -EINVAL;
> -               goto exit_process;
> -       }
>         if (nbytes =3D=3D 0) {
>                 /* No data to process is valid */
>                 rc =3D 0;
>                 goto exit_process;
>         }
>
> +       if (validate_data_size(ctx_p, nbytes)) {
> +               dev_dbg(dev, "Unsupported data size %d.\n", nbytes);
> +               rc =3D -EINVAL;
> +               goto exit_process;
> +       }
> +
>         if (ctx_p->fallback_on) {
>                 struct skcipher_request *subreq =3D skcipher_request_ctx(=
req);
>
> --
> 2.17.1
>

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Thanks,
Gilad

--=20
Gilad Ben-Yossef
Chief Coffee Drinker

values of =CE=B2 will give rise to dom!
