Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDB7DF469
	for <lists+linux-s390@lfdr.de>; Thu,  2 Nov 2023 14:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjKBN5p (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 2 Nov 2023 09:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjKBN5o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 09:57:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C77BA6
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 06:57:41 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-565334377d0so671436a12.2
        for <linux-s390@vger.kernel.org>; Thu, 02 Nov 2023 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698933460; x=1699538260; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=NyzT77R/4CMVImmwMCxmRQGIqm9IZ6M5gl8Ugrydk6OnhzBZSif679jd3C7PGqpeD2
         l+so7xWYhkIjxuH3KSJ8qUxxdGrG38BUyXzUYzzJwrMvdiSZqnipx0VJp62vzejAdaZv
         irYXh0i1AREsco4CxMAv1XzB5J7Dn2wadlNYYac2iJUoHRVwFOOnGI5HGD9ukhRFoHPT
         56U0tCXVbYscszPyHaLsUOwGr3kWuUObqyS7CM8kwfPqFZ7DqZX3fdqVkIHFhHU0XOMV
         XwcbzWBY+okO+RNfDX62YRn0XUmm5EzbBlN7BISCWMmpnNgWdKb80SbFKa99alNnm3J3
         ioVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698933460; x=1699538260;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNLytVSJlr1D0ot2ygWKsJu12BdCJtoL17C9W5FT6eY=;
        b=dxFpm39ApmAvTQlfh8K9pfp0VHN+NUteFueH3i/4uFZ7Ncx+PpEDaf7sxFqp4Et09b
         FhtoL6GqC2U5+3CYP9ovfWW/iP3lklTZZUKZL3GKypXkdB88GxhCSWXZqM9e78Z+hLlb
         H1FljyqO8oMXHXwIeuq6r6LZMvuDqqVgX1oLigupVbmKwEtvr67IAd+Klu9L9T0ndQgc
         OQc8sCj5i+7q4b4kMlAOaAzsRR+VTkuFgQhdRMuU7CUq2TX26UcT5bYadqzsV+/UxEzM
         5FxyX3A3czNuXwEhiVyTmUvTVPwwqMcgOyQaNQliXxw3e+Ft2RUMLgr3dL4MizRULktL
         b1Sw==
X-Gm-Message-State: AOJu0YzAbJX03hHxUMnk56UNpP86fJgrxbhuATB/Tw3f+/1m8DfkSwKG
        riGjL79Xqw98kzfp5t2FoLe6VB0/753PVCz4BlQ=
X-Google-Smtp-Source: AGHT+IER1nt3ORU3O6+8l+CndfXPEemSZI1X1A9+wMcbiwkONVgXD3wA8dQwCCgrqr8PufuWsH19pkuLQ0k1BUnZpXM=
X-Received: by 2002:a17:90b:190c:b0:27c:e062:c464 with SMTP id
 mp12-20020a17090b190c00b0027ce062c464mr18778782pjb.37.1698933460602; Thu, 02
 Nov 2023 06:57:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:522:792:b0:51a:59a:4014 with HTTP; Thu, 2 Nov 2023
 06:57:40 -0700 (PDT)
Reply-To: oj616414@gmail.com
From:   johnson pattaego <lenle.goungbiamam@gmail.com>
Date:   Thu, 2 Nov 2023 13:57:40 +0000
Message-ID: <CAL454wBiJsZ=yDoOvjqBe0WpYPTUh0+QA+kfwCHZpoEFtEzdSg@mail.gmail.com>
Subject: Greetings to you ///
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

=C3=9Cdv=C3=B6zl=C3=B6m, van egy v=C3=A1llalkoz=C3=A1som, amelyre =C3=BAgy =
hivatkoztam r=C3=A1d, mint
neked   ugyanaz a vezet=C3=A9kn=C3=A9v, mint a n=C3=A9hai =C3=BCgyfelem, de=
 a r=C3=A9szletek az
al=C3=A1bbiak lesznek =C3=A9rtes=C3=ADtj=C3=BCk =C3=96nt, amikor meger=C5=
=91s=C3=ADti ennek az e-mailnek
a k=C3=A9zhezv=C3=A9tel=C3=A9t. =C3=9Cdv=C3=B6zlettel
