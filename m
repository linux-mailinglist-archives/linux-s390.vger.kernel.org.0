Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC38658CB2F
	for <lists+linux-s390@lfdr.de>; Mon,  8 Aug 2022 17:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243586AbiHHPTo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 8 Aug 2022 11:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbiHHPTi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Aug 2022 11:19:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5962313F04
        for <linux-s390@vger.kernel.org>; Mon,  8 Aug 2022 08:19:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u1so13173026lfq.4
        for <linux-s390@vger.kernel.org>; Mon, 08 Aug 2022 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=eAOn/H9c6ytA0ds1rzRpNtSuyO0IZdB7WZrbrNNXRk8=;
        b=LUkj7cfFN/n43Ho6Da9o4OJ3paeYQZVlftPUzkSNfw++RymO5QKQ9H7cJC/Ox+6f4J
         YnxzN+twLN5RZLqot/w7YyqjCdXFEawUtrrJMQ3ol2sUEe7H86RLciT/QDHuAF6vCUSb
         rr+0g3Ll9k9f3ZhW5o6VwSegeav0mCEm6BMMHViKUekEKEXunmfrHPsKLW5h7/uj7LHh
         k6UJJbiKhXXtw37YEdd3H/QKq39yIsYHFesLVEvfqOuQp5QPqLmW6nQa6ew27Fn1rmrd
         kYmT3ypJfWXTHFX7pWKw6JJ7CJGChHaEzh2FjU92gnLM/GvaCi/G/RxlIUdq679Qxd35
         RW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eAOn/H9c6ytA0ds1rzRpNtSuyO0IZdB7WZrbrNNXRk8=;
        b=r6CmOUlSmq6HIcZdSTdedGry0sNr3h7hkHqlAxwRSw0lRX7OTMKdbL79qFPvMqI+p2
         5zgr7a3iw6vVoQgkziMQiXXcQ4wdhhFaS7oWitdsQ70GHs9i2QMessTf2YrzoUyRzIVY
         +UKfIzkjWWE5n2JlzrM1MiUErWdq+JlRrtP+Vp8M04Hk9WtXTzr3s4ceVhpJnyHqiTOU
         wD2ijB5yAd/dqIJsqUt55/+C4zy0fHSp4pLEEwswi4WS+GYzJC6Ra7aH7SUAoHARaMt4
         d8PPB0ucZB7UjtnS3iGK/u5m0C/l4DRG1SsVdyTP+apiVOG5MwqaNSe9pslceIydvE7d
         TALQ==
X-Gm-Message-State: ACgBeo1jUirH7y4K0uUq6NiH9zbPnlYgr03Piei7PHnyp3EprtKTtoHP
        iZ3sVU0XBdffKBmxpGSkYBEk6Be/rBIZnXsNP5c=
X-Google-Smtp-Source: AA6agR7wdUz2DEZqRCRgHBZaT3altU8WKHnGxTzY3TnoIZj7tZtoaD0Ioj5Sh3t4fBj3nCGqkwPc3HMY0/rnXTMcRMo=
X-Received: by 2002:a05:6512:15a0:b0:48b:38e:bd8b with SMTP id
 bp32-20020a05651215a000b0048b038ebd8bmr6018365lfb.102.1659971974462; Mon, 08
 Aug 2022 08:19:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ad06:0:0:0:0:0 with HTTP; Mon, 8 Aug 2022 08:19:34 -0700 (PDT)
Reply-To: olsonfinancial.de@gmail.com
From:   OLSON FINANCIAL GROUP <kcpools16@gmail.com>
Date:   Mon, 8 Aug 2022 08:19:34 -0700
Message-ID: <CAM8gsMf_e6YN2xDE8B+sOubnw6LwBEoH+TZE9i1Yh64rxvhofw@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

--=20
H, guten Tag,
Ben=C3=B6tigen Sie dringend einen Kredit f=C3=BCr den Hauskauf? oder ben=C3=
=B6tigen
Sie ein Gesch=C3=A4fts- oder Privatdarlehen, um zu investieren? ein neues
Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen? Und zahlen Sie uns die
Installationen zur=C3=BCck? Wir sind ein zertifiziertes Finanzunternehmen.
Wir bieten Privatpersonen und Unternehmen Kredite an. Wir bieten
zuverl=C3=A4ssige Kreditarten zu einem sehr niedrigen Zinssatz von 2 %. F=
=C3=BCr
mehr Informationen
mailen Sie uns an: olsonfinancial.de@gmail.com......
