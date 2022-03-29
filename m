Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C04E4EB5F6
	for <lists+linux-s390@lfdr.de>; Wed, 30 Mar 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237358AbiC2Wbg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 29 Mar 2022 18:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiC2Wbf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Mar 2022 18:31:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1176A055;
        Tue, 29 Mar 2022 15:29:52 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso2363427wmz.4;
        Tue, 29 Mar 2022 15:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=Ebae8FwkrlJlE1BFNq+ANJECj4FooJVHM6vLRMyMFjUkHh5JrrmFRQ//T9pqlqC+Wk
         h12chq/RmrWlMaM6LM4ntSpHfxLYhQhRv5ftWfmRebLNFl9TbbZiBMRY0PTujHnMvPVp
         qQSw6FYnkWNaCp0eA1iLQqT9dDmEbB2bP9S/lMloj6dyyB4cauhtq08rfIENSUrJpxtU
         gTYhvl+ZPYHhBaflHY73L+Lr5YZRDqjfB64g+H1YsxUvhzUoQ5GvU1/9z3whIhBehrmp
         f1MNd1hceXcsVB32sDA6ufMB0/6wtzLD+K+K3vB4ikKy+CXvxKInB/yG1xqNaihI7nvi
         5Jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=EwUeHRiRAK9mmqTsV+9tMuvgUsw3emZPoCnCicWsQhPvi/ssHetBv3xBrwa2H3xPH/
         0FL076sRBHUOTE7NQTO6KfrcHVMdVVSk9N+KZyk0f9wiD0OTpcCmuPql7WWlgjYrmcbY
         zJoXLgjNyrrMoiKdmIgXWRzSHTRzch2VcIB/fUiZTw/hgkS5DQWrP370S4GPnyv40S7G
         /Q+vk4mBCRXocDBec1RKitX3YhCGSAbYQTkq1ICX7G6bdpMvm+hK74MOs6mHg5rfCh9C
         BR4OGBWmrvLxKQMsZDzXY+gFswyEPxLmRTkEhUzu5RcNZarTudJn5GPz6C+TEUlZjX+u
         mBKg==
X-Gm-Message-State: AOAM530WLe3iThbXyqCp7sH/nUwGafaiSFRV8pcTbBiDQgd/ALuUTY8z
        hPLBWZNplrCBP28dRDSevHu36VLMxf63rf1p1hE=
X-Google-Smtp-Source: ABdhPJy4aC73DHPUdZJDBFbPOL7n6cEDJ4B2MzETLotYLSuFf4cVS1J5JW5BCrjgowSndl+4WwGNJQ==
X-Received: by 2002:a05:600c:5021:b0:38c:70c0:80e9 with SMTP id n33-20020a05600c502100b0038c70c080e9mr1567338wmr.91.1648592990855;
        Tue, 29 Mar 2022 15:29:50 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.27])
        by smtp.gmail.com with ESMTPSA id n18-20020a5d6612000000b00203fbd39059sm16004923wru.42.2022.03.29.15.29.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:29:49 -0700 (PDT)
Message-ID: <6243885d.1c69fb81.4d4fe.f2d7@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:29:40 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
