Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5FD57AA2D
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jul 2022 01:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237741AbiGSXCc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 Jul 2022 19:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiGSXCJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 19:02:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447C61B16
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i14so29275961yba.1
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=IidRqp259LnIGwKSY8eSnwY2pSvVpnXgD6l4DtZ0nS1en5/eIODexxA8HY1P3fOj1G
         k3L2dqT2adyYNMP0Xveqboy+8rHiXHxkUk7eN+Z4c1u4A1dmYZTv8XeBq3Mcqc8JpY/J
         Y+FZqCw+ctBHW93xydCMO1T2zbJgKE6zi4yOKnSgCU0wXAb68jTgzbksOw/WF0fuySr4
         IszSqaPAblIoqFUVbDoenHDcU4oM8zz2T2X2YOFu4paIHinYHYAEpHDagNDILO9VwXpP
         1+8RZDNcKixJbUOVKzMHhr00ZyE0o1uffduD4Jla0qSaybMZB4f9mMaQZtZwFiKbVkVp
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=eMNbhODRhK+fdHGZKCuocQLP4oTjgg4ryO8XcDX2bG16sQwkdSs0qR4XvILGQr+Djr
         T3xURr6qQZgw9bMuGoB4J28MCJukrMkI05vgla+OnvnsAAMqmq7w+dbVV2Iot7SJLIa9
         To6Vw5M6Eu7OKfF9gmnAagrVL+GbkizQQnawfsFV4WtMD0wV28782WzI9X5xpp1VK2NF
         q2yf6TUL+mrR+SA/eP5sGwaZqfT6QRIgXkZm1ZYE2HudyFTynI4ektmhPThtSljK/cP9
         OepjLco0qMmjb97XgZGlQnUivCfFrvsYij1LWSUj9/GkVEc4TVemYjdP6xlAOU1ZBpEf
         AWUQ==
X-Gm-Message-State: AJIora8m2PkGT9/ZRXwhP/1xVvMZtBSuGf8Thgdmn8SZa9gfH+ogyEQS
        wv1XM0za9GlPVkJYXp4AHwkfbYf1YUrqdnHcRMc=
X-Google-Smtp-Source: AGRyM1sl0J4NyfzC2f29bqXT9oPchs8cDVndRHRbS2Q3refz6ns6Y35SIupBWILMCNYHx3pJ+wk7AlhI9UdwA1sMqK0=
X-Received: by 2002:a25:850b:0:b0:66c:d287:625a with SMTP id
 w11-20020a25850b000000b0066cd287625amr35727355ybk.31.1658271721069; Tue, 19
 Jul 2022 16:02:01 -0700 (PDT)
MIME-Version: 1.0
Sender: belloashawu72@gmail.com
Received: by 2002:a05:7000:26b1:0:0:0:0 with HTTP; Tue, 19 Jul 2022 16:02:00
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Wed, 20 Jul 2022 00:02:00 +0100
X-Google-Sender-Auth: BO4DmyfvjRINBOwOOpcYOq24sHk
Message-ID: <CAOjupQKQ6zRjFB_6SefXkEmKaf0_dwC_KfS2LmZFQLFEaDr30A@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
