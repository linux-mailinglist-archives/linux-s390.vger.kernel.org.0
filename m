Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D959C44358E
	for <lists+linux-s390@lfdr.de>; Tue,  2 Nov 2021 19:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhKBS37 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 2 Nov 2021 14:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhKBS37 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 2 Nov 2021 14:29:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B1C061714
        for <linux-s390@vger.kernel.org>; Tue,  2 Nov 2021 11:27:24 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so52154wme.4
        for <linux-s390@vger.kernel.org>; Tue, 02 Nov 2021 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=aZ1qACKNp6s690RtJWkkxKsMw0YuJS6984cWR7xm12Q=;
        b=XGDsh3Y8M5HGW5fPWPWhaVIf40yxG7yQkrnZQLSbGFylX6nfX8XwH1frolucTD0Pzq
         9al8GmCdYni3XDiuEQUedTnXadLYjSESTNXgkX/pTkcbzAt4jjS30Qhf5L9OYsrRnnX4
         wi+LsTuHzcC+pKqqnebog5Fx12FkraRwVB77vDAZQElUr4yzt+q1u7O+JIhodKo9kz//
         lspPDFwgYc8nEVcEA5OjKOVzD3PgU2IiFIAbBL991g/L0SrdqD5K0Hsd0juzupcTXxN5
         IWeFLpDSqeMPY5z9ImpXaSMbMXbq/ajZytX+Kvh0mRgHdTYiXvLKoCl8Wx8iRzwBLboG
         EWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=aZ1qACKNp6s690RtJWkkxKsMw0YuJS6984cWR7xm12Q=;
        b=R6qWOfMoprDKsOKTKrVrGhwa4F2fhCxkduURGZd634iWSkolgl5Du3GfuXvES3e+kG
         uBjxKIa5pnLOO2bbAO4JgX5ZcvXo+/qxgUL7vQT/R6IUpmFulT3d3gMaTt97pClWVjXc
         6z3DyFY/eURdOIQsfUW1OKuEnjr/OVH9Nao88YA6V/BNofcQs7lJACJR22Uhy3rEsPb6
         Nedr/iChIivJmw/ioLeKvZNTR1fQucyRIFhZMIG47MtgCZxmsGwU4B64NvKWEH6PJPD2
         yBim4FZclPhcxLobo/ywDF+IRFHFqPwagQHxwGJN3nVJw4XIbFcbNY29hUMOHRxCZ94h
         +Yog==
X-Gm-Message-State: AOAM533n01Uv4Kdasmw72n964LL4MaY/a27RQQpJ7tB5lh3NJRisUUoo
        3OSkv/V4IZTZQsSLOjtEkylQEUpGakfmarGqcnI=
X-Google-Smtp-Source: ABdhPJyccNIpxNumEB2hYpMjiDsBL40OmKJFdFhgm4Xm3PHUxJRTafTlO2KGXUkDCTKuQBiKA9+EwxWy/tOnSa2euh8=
X-Received: by 2002:a05:600c:430c:: with SMTP id p12mr9491478wme.127.1635877642725;
 Tue, 02 Nov 2021 11:27:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:18c7:0:0:0:0 with HTTP; Tue, 2 Nov 2021 11:27:22
 -0700 (PDT)
Reply-To: alimaanwari48@gmail.com
From:   Alima Anwari <khuntamar5@gmail.com>
Date:   Tue, 2 Nov 2021 19:27:22 +0100
Message-ID: <CAOdLAAKFk3_zRyH-e9kCdWRy6mLTw2QHmMWAq3O1KyZ5KZmNyQ@mail.gmail.com>
Subject: =?UTF-8?B?xLB5aSBnw7xubGVy?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=20
Merhaba sevgili arkada=C5=9F=C4=B1m, ben Afganistan'dan Alima Anwari, l=C3=
=BCtfen cevap verin
bana geri d=C3=B6n, seninle payla=C5=9Fmam gereken acil bir sorunum var. be=
kliyor olaca=C4=9F=C4=B1m
cevab=C4=B1n=C4=B1z i=C3=A7in.
Te=C5=9Fekk=C3=BCrler.
Kire=C3=A7.
