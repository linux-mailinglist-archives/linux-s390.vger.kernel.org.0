Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D33F792968
	for <lists+linux-s390@lfdr.de>; Tue,  5 Sep 2023 18:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351901AbjIEQ0Z (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 Sep 2023 12:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353845AbjIEIU5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Sep 2023 04:20:57 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF93CEF
        for <linux-s390@vger.kernel.org>; Tue,  5 Sep 2023 01:20:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 2adb3069b0e04-5007616b756so3796381e87.3
        for <linux-s390@vger.kernel.org>; Tue, 05 Sep 2023 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693902051; x=1694506851; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=WyyvPMEfe4FOVqHOIWdr/B2P0p03RPzGq0eAy6olIuEmDr190DF60UMTUjSzD3ICzN
         0WsAegs64/BiRqCpXkN1qURw3kJmTI2wMa8rTaukjr0/l9jhm+3ubCn9+y0oKw0Vf/Ks
         YIRtHy/tktgd0JCbt9j66zUkqNxhaH1k0FzKmAu+yKNICqHvkjDH6q7yKGNLfZeY066C
         rjUXbiHJ42XZriL2gTX15/F6y+Se4qD3ChTlmHmU/A+Bl1kzMG1cMn1BnC25iR+qjjlJ
         Ikwy1nXebC5hCeU4AgcZQ4VZpVOWulwi6FywqPblj59NiPYUSn0tuU6Bbo6p4XZRvT/F
         gtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902051; x=1694506851;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CvUmRYKO5rN5JiKdYLn9/Xxm/soJiVGtQm650JnL3Yc=;
        b=gyugKIMThysz1c6j1ZkoHR+tp/PJiU/whCkHdjfDmLL6a+FT/Q9CuWmZgZDh0JBT32
         lte/AOE1Un/LVmz2NXFx878yLAD3Gfu/KRUSDDXux1fitp0kNIaNG3aopNVQEOHNttWA
         UV0RMQ8ZTyYbCgABdhzudhClSDpPcW+FgNbwa8kujwYG4ppoKnJAaDca8h/wNt0XJnv2
         mCUE2oMX+b2rdglSa+x2X/Xc+N4bLSRdjaLF630/YiRFm8YFIHL+GQMZtU9I9yWm8XBi
         N2pXac8P4XHI3sUvcxtiVU5bQ564RCAYOH8b4SGfCR0ZOwGsNoQBZfxyRvh9vRFp1omF
         1iQg==
X-Gm-Message-State: AOJu0YywD9gsjxvwvtkKlwKDoyep8B98Rq/7bRpbRnAkDNwxdLJiWXe+
        0uVcPNezTONRDD7Tzv7hq+9IoXVceOCt0Xz0ZfY=
X-Google-Smtp-Source: AGHT+IHc9ajH3Rii9UZwOOqLrsXanmcTWvKjiURPKmJK5D52sTkbD7l1BRzq/bCfrfUZjlWt/04s1jIBCk3z7CpHIFE=
X-Received: by 2002:a19:6755:0:b0:501:bf37:1fc0 with SMTP id
 e21-20020a196755000000b00501bf371fc0mr624754lfj.33.1693902050884; Tue, 05 Sep
 2023 01:20:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3ac4:0:b0:22f:40f:e031 with HTTP; Tue, 5 Sep 2023
 01:20:50 -0700 (PDT)
Reply-To: wuwumoneytransfer5000@hotmail.com
From:   "(IMF) SCAM VICTIMS" <mimichi4500@gmail.com>
Date:   Tue, 5 Sep 2023 01:20:50 -0700
Message-ID: <CAGhkD8USA9d9+1HDw3AKO0o45v_Z8cjdpcgnjTbVjdDUbiyg2w@mail.gmail.com>
Subject: Betrugsopfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Sehr geehrter E-Mail-Besitzer,



Der Internationale W=C3=A4hrungsfonds (IWF) entsch=C3=A4digt alle Betrugsop=
fer
und Ihre E-Mail-Adresse wurde auf der Liste der Betrugsopfer gefunden.

Dieses Western Union-B=C3=BCro wurde vom IWF beauftragt Ihnen Ihre
Verg=C3=BCtung per Western Union Money Transfer zu =C3=BCberweisen.

Wir haben uns jedoch entschieden Ihre eigene Zahlung =C3=BCber Geldtransfer
der Westunion in H=C3=B6he von =E2=82=AC5,000, pro Tag vorzunehmen bis die
Gesamtsumme von =E2=82=AC1,500.000.00, vollst=C3=A4ndig an Sie =C3=BCberwie=
sen wurde.

Wir k=C3=B6nnen die Zahlung m=C3=B6glicherweise nicht nur mit Ihrer
E-Mail-Adresse senden daher ben=C3=B6tigen wir Ihre Informationen dar=C3=BC=
ber
wohin wir das Geld an Sie senden wie z. B.:


Name des Adressaten ________________

Adresse________________

Land__________________

Telefonnummer________________

Angeh=C3=A4ngte Kopie Ihres Ausweises______________

Das Alter ________________________


Wir beginnen mit der =C3=9Cbertragung sobald wir Ihre Informationen
erhalten haben: Kontakt E-Mail: ( wuwumoneytransfer5000@hotmail.com)


Getreu,


Herr Anthony Duru,

Direktor von Geldtransfer der Westunion
