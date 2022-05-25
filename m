Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E403E53452A
	for <lists+linux-s390@lfdr.de>; Wed, 25 May 2022 22:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiEYUmi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 May 2022 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344075AbiEYUmi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 25 May 2022 16:42:38 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1410B0D0A
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 13:42:36 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-30026b1124bso70022557b3.1
        for <linux-s390@vger.kernel.org>; Wed, 25 May 2022 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=qXByR7EufpzoGQiN06MDPIVWzdylLG3o46SZpFvmALD7dQ/PgjHu3dAOdG4vHKIlfe
         o4pnFLvM6qO7tfMb32rqQxgUNzZp6gdeGFDkaYnNu/L384UihSeFla/OCMwsBAF3705g
         aoIOUM85zZmqEG9ecsktReRuF0D56BtsybiDVuBWXKXg1j5P64zJQv9Dpj1ReV3CPl4j
         5alt292Xc+TmQmAS9PrcySvzwaZnTkvZZdWEtMf296xtKREeKQCGVfeCiibW0qnTX9Qu
         7bEy8jEeJHs+TVn/2WvP0NanfefW/JaGuBcJU8L63BJmai1/hqD3u/byWhupBBZYSYoU
         /IYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=LDBqQh/PztHeiDiV9Pr0v62BTTaDnPQyU98FGi1REkw=;
        b=Jw2TaHeG0DrGL2ztCb2LLb+5c+ttzuSEQ3WE7/9c4eh16CjOJ6EUlfLYXgMV96OH6+
         JR1Ejk+he0tfpY0/vYcPtg94YcqDT3wfozF+hWGIn1+910RisPWLpzwcPNQJyL3+UAAS
         /RLgcocAowoHcc+EbCjUdXa02TlWa2IfIMsraRVs4Ot9CvD77lDa+bIMHjcgEttTllwo
         5Xp+1PBUyM4qiUmgOCW8j4oZyN8d63XlaHKSQRbUQg+fcZIjNL1BXxlZZfQkV0EAIgBp
         eiSKmAqLYLJkIxSPG1Exc0o+mEIEjivG/OZ6Aye1/BJXDa3+eJkNE8lHDaZRigRni7P9
         Xp9Q==
X-Gm-Message-State: AOAM530+xUwpiEd6xDKAUZ4Yohg5FxzWFffzFYhAYpHVU2Gt3yjccgGX
        QOoDf+EgNK5hvE4SaKmMRQFxAMyYLu1gnta4yBM=
X-Google-Smtp-Source: ABdhPJwSy9gIL2rmC2eVlR4qYfk4gjTw3/aO1KuvySOFfkgG3DuJQpFytIvDDKuHulBchsUQTaGwWGCGNDaLcVgEOHA=
X-Received: by 2002:a81:7607:0:b0:2fb:7bee:bf70 with SMTP id
 r7-20020a817607000000b002fb7beebf70mr35495161ywc.279.1653511356175; Wed, 25
 May 2022 13:42:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:506:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:42:35 -0700 (PDT)
From:   Deterin Falcao <falcaodeterin@gmail.com>
Date:   Wed, 25 May 2022 22:42:35 +0200
Message-ID: <CABCO4Z1qRyNfOn1xz1AEWfgUaQmSXp-LftTWBPBTfu+NB_4BTA@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Falcao Deterin

falcaodeterin@gmail.com








----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Falcao Deterin

falcaodeterin@gmail.com
