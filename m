Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803A7EDE94
	for <lists+linux-s390@lfdr.de>; Thu, 16 Nov 2023 11:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbjKPKeY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 16 Nov 2023 05:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPKeY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Nov 2023 05:34:24 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9853D1
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 02:34:20 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67089696545so3340856d6.0
        for <linux-s390@vger.kernel.org>; Thu, 16 Nov 2023 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700130860; x=1700735660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCzmGpWmQul4wYiJvXX4QGBTD7ZNE9De5NBHM0dQ8JI=;
        b=gyb2sOjsJh64yKJY92DI+11XTUrz8vDPBIhiPDzickHe91aBE/zIxmv8ULiXtESFXr
         WFhtxbCeO7szK3OscKGPMOE9YvjJw6vuepxbOHI4lN4tURE40V5i9ffpwArWa58F1Tu5
         e7yBhlSJ5pRUMSwpYccwKW0n07sCcpqMueIE2DlQcuARCjNv5MVqASNXadm+5TDUYs7i
         95QyRu7wjL4yWCXHJRJ2n8oOqQ5PpiTnRKj2TFb+E2EYoa7guUHZAS3eaM9q81UH32PD
         sOhndC+NtXoXchkWdE5Wn5CYl2mdsnoa7T16vcleNbzN4Wf7m5koykXDGaLm45kaQ4RE
         3Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700130860; x=1700735660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCzmGpWmQul4wYiJvXX4QGBTD7ZNE9De5NBHM0dQ8JI=;
        b=Us7dK9SFXYpZ5WJ1uePGLwNa/m+UlY0I4EAIVT3D4OkMP1YN6PRmwYbY3jT3jwoRJi
         21L+XLj7roUQS5XVRtmOtv13tyC9OC1YpKyNj2NPMAJp6AtjpiIQw1LHvgAhrA/pMtF8
         MnyVNtNpsd6w56yfh5f0MNG2QHqdOStF5Q7HCzUKRZcdOsw0nsXQAzYA12BIPk+RtIKh
         KaeRvpWoexFRn4v2+OX+Xwf5r+E2kFFuIPVatXJIL8ahEQAEk+31aMDLH45KbESdKkFD
         jvv85a32CMMvi9JyrsnzpKmJxysbNDmb4NASk6+9ytk/+b2Upx2rX/VIVRuX+/5u5Rqn
         MTyg==
X-Gm-Message-State: AOJu0YxxM3aFLHbHGSYAdi57HYteV1ufX4KWSl5zJId4Z7KftZgyv4LC
        ciFllkb+8AoJ5VUlTaWak9vTZE8Na43cJyIJ6T4cyQ==
X-Google-Smtp-Source: AGHT+IG4aY9GHR76tVKMTAGmd0CseNMuUXkNiPOGtMWZyskYlNgHZ6XGDtn1AzcetJJpwAPmQpPFevQ/edxH5B4nbxw=
X-Received: by 2002:a05:6214:12d3:b0:66d:1d3f:17d7 with SMTP id
 s19-20020a05621412d300b0066d1d3f17d7mr7472430qvv.8.1700130859918; Thu, 16 Nov
 2023 02:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20231115203401.2495875-1-iii@linux.ibm.com> <20231115203401.2495875-20-iii@linux.ibm.com>
In-Reply-To: <20231115203401.2495875-20-iii@linux.ibm.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Nov 2023 11:33:43 +0100
Message-ID: <CAG_fn=VMKwcsBL4KuRYG-dojpZg0WFqJgZc67ks5Rg-HEnd2bQ@mail.gmail.com>
Subject: Re: [PATCH 19/32] kmsan: Accept ranges starting with 0 on s390
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Nov 15, 2023 at 9:34=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On s390 the virtual address 0 is valid (current CPU's lowcore is mapped
> there), therefore KMSAN should not complain about it.
>
> Disable the respective check on s390. There doesn't seem to be a
> Kconfig option to describe this situation, so explicitly check for
> s390.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(see the nit below)

> ---
>  mm/kmsan/init.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
> index ffedf4dbc49d..14f4a432fddd 100644
> --- a/mm/kmsan/init.c
> +++ b/mm/kmsan/init.c
> @@ -33,7 +33,9 @@ static void __init kmsan_record_future_shadow_range(voi=
d *start, void *end)
>         bool merged =3D false;
>
>         KMSAN_WARN_ON(future_index =3D=3D NUM_FUTURE_RANGES);
> -       KMSAN_WARN_ON((nstart >=3D nend) || !nstart || !nend);
> +       KMSAN_WARN_ON((nstart >=3D nend) ||
> +                     (!IS_ENABLED(CONFIG_S390) && !nstart) ||
Please add a comment explaining this bit.

> +                     !nend);
>         nstart =3D ALIGN_DOWN(nstart, PAGE_SIZE);
>         nend =3D ALIGN(nend, PAGE_SIZE);
>
> --
> 2.41.0
>
