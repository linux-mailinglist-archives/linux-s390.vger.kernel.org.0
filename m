Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3F65B700
	for <lists+linux-s390@lfdr.de>; Mon,  2 Jan 2023 20:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjABT4D (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 2 Jan 2023 14:56:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjABT4C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 2 Jan 2023 14:56:02 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63DC766B
        for <linux-s390@vger.kernel.org>; Mon,  2 Jan 2023 11:56:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d15so30465555pls.6
        for <linux-s390@vger.kernel.org>; Mon, 02 Jan 2023 11:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DxVDaSEGQzZr2xTk/kD9xvGjWaBbwlyDI8YoihGUwfI=;
        b=Mg00pYPW3BnNUk4MVYKI1iRW5AkFxAK1k8GoSNLRf1hbRiiG0qocTfwGvA9j8/mVAB
         NbRccA1N3qfOQqkUNEeJdidOvm5hmt3WIPbAgAesV29CetHX7F2IGPtwBwQEXghfh299
         fk95m4TQDTb/Yx+d/HjqqHU9EQewAquh+0MMSjv9K33gvmOfgWtyUCaghNCUDTpn6aH1
         IMKq2qT2CpveTTvSTWLES08QmzNhkU/aTQ3jwXjvrmh+cwC0weZmeIqfTcb0cCqMg1BG
         EPxmp7gyJgWGXcoeIHGhvO/vJm9wofmK0F7T4hdkJnrOS5hXfQ0molo/l2LwkUioRZcc
         6ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxVDaSEGQzZr2xTk/kD9xvGjWaBbwlyDI8YoihGUwfI=;
        b=moa6E5cDcyg7pDH7Vxw1txc1GSpeO+vP5XHmG4E7tm15rASAwvPrED/xTPbSjIefHR
         UoUKDv7r+chH8Zw6McXyheq8KfhgH1xCP5OOR33QtDQsTrVYyvbk0Atb1VFufLrROdcJ
         xNCn+l2QyG/FL/zp1ehJufcD9JxGu0zDD9/hvN7odWyhNT3rFZNC2lpMzFdI6rRzDYgk
         oy364lJr+FtwQkspnl/kqomtbapXdIQ1s8/99utd60VZc9z6riprrWQ6O15DfvKXbMh7
         OARbGTxK/dljwim6uIubpHsq9vu/iUimhAOa1zReDGdMXukdCiPzmYNVRxUPLjbuRgU9
         ju/A==
X-Gm-Message-State: AFqh2kqucB1gDwE8Yd9eJrsBDetwCVZIo+QeV5nLBr5bfxhHaPvWEuzx
        TUli++HtLKMrNTM6t+Vce0VX1s644YwFnKGRyaU=
X-Google-Smtp-Source: AMrXdXufdLSIfhv0zPEY8/klwfrpjRY+nHNeujkz3YdirGSruFsvDr1WTAWdU0WJqeer38MrFJgdScggFlrwbV4Ozd8=
X-Received: by 2002:a17:902:d882:b0:192:d632:14f7 with SMTP id
 b2-20020a170902d88200b00192d63214f7mr171208plz.152.1672689360366; Mon, 02 Jan
 2023 11:56:00 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:670a:b0:364:9f48:7cfa with HTTP; Mon, 2 Jan 2023
 11:55:59 -0800 (PST)
Reply-To: silvantenro08@gmail.com
From:   Silvana Tenreyro <mulaudzitshengelo@gmail.com>
Date:   Mon, 2 Jan 2023 21:55:59 +0200
Message-ID: <CAGVrPi3NQMSwQeKjBZ3ojFMwJHFGrSVX6d2sovvZW+MAvVbLdA@mail.gmail.com>
Subject: Business Deal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9904]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [silvantenro08[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mulaudzitshengelo[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=20
Hallo, meine Namen sind Silvana Tenreyro. Ich habe einen
Gesch=C3=A4ftsvorschlag f=C3=BCr Sie. Zu Ihrer Information haben wir eine
Erbschaft in Verwahrung, die mit Ihren Namen verkn=C3=BCpft ist.
Kontaktieren Sie Frau S. Tenreyro unter: silvantenro08@gmail.com mit
Ihrem vollst=C3=A4ndigen Namen f=C3=BCr Anspr=C3=BCche.

Mit bestem Gru=C3=9F
Silvana Tenreyro
Mitglied des geldpolitischen Ausschusses
Bank of England (http://www.bankofengland.co.uk)
Gro=C3=9Fbritannien.
