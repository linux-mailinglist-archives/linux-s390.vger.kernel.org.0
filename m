Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27C55299E
	for <lists+linux-s390@lfdr.de>; Tue, 21 Jun 2022 05:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344989AbiFUDNW (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 20 Jun 2022 23:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiFUDNV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 20 Jun 2022 23:13:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D83120A4
        for <linux-s390@vger.kernel.org>; Mon, 20 Jun 2022 20:13:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z14so11916503pgh.0
        for <linux-s390@vger.kernel.org>; Mon, 20 Jun 2022 20:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=VuxBloebgqYs6q47Hdp+hDzN42mMVAk49JQ3qzvYsp/hBTLXwJUXe1nKHE9Wo/tnlx
         FV+L4G/9jcqPBdyoIX/TL2fsi0acPWP2hDAvGb8O4kl+ridK3PcU2FhUwJw2G5+Bnr5B
         5WX/yEwjh7lYUeXbLA2P332gBoFikewQngvBoQFGCEIVq4MA5neFJVHBJXbgXGyAazX2
         S3QkawbW6dC+1fS3tJAH+glmKoNyFUhi02lDAl/e/GXF3A/8p5/q07pGoSzpx+1U16ch
         OCjqW+IDf1TVsoAldLDPHP+ieOZbzPpEFWmg5dCea0Ifhpe8TIdioNJ3w7TTI9e7wkxN
         uFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=q9UdVyrLMOx/C7gJWc5Bizt5EBlt9Gi39tY1o9HlL8aePVazWDl8xbje1IbwMEwika
         mijA7EpzUTpZoGI4fct//fwq7nUNz/4RJHSH0OjcPm7Ehv3P7IBqbL5JRogy244AUkak
         ENY+2SnnR9GMvxaqasaRL7nCbPHwLtv5Tcj+PH9WvdXSdCYT/B9jBiofZZym8La1/SI9
         RpOsWjWecTDCaGrCiytM3LtgEM02fwKk/CPtitpJCjgoIlT0KDoJvNcFUqUrGCIxxoC0
         UCXOGi3sOusL5CeimJnK7XFz7LDW9WnXE1MCeKF/s+v7C0tvXW/zQIu3whyBLebJ8PBQ
         eyJg==
X-Gm-Message-State: AJIora8c5sEU5c4qX3LCqncige2LqWrbywrN52hFI+Bkfya5h4iLyfLB
        9eDGuHZSmrFkKl0f6mkxjHY8wHqHy1GEHn4El2s=
X-Google-Smtp-Source: AGRyM1vPILnufbOgVS46XEALHToRWDWJz9CMAN1pqRSwT+bCE/w+2MR3KNWyllBbK1FCvUfXfsMeNimOzK/kVCQOmF8=
X-Received: by 2002:a63:4a4d:0:b0:401:9f40:26a7 with SMTP id
 j13-20020a634a4d000000b004019f4026a7mr24688786pgl.282.1655781200308; Mon, 20
 Jun 2022 20:13:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:3726:b0:69:5676:9027 with HTTP; Mon, 20 Jun 2022
 20:13:19 -0700 (PDT)
Reply-To: jerrydosso@hotmail.com
From:   Jerry Dosso <jerry20dosso@gmail.com>
Date:   Tue, 21 Jun 2022 05:13:19 +0200
Message-ID: <CAHfM5QYEBY0PFE0sK4_q__d1U3Cm0T=5KGYaRAhQLOXSTL81Lw@mail.gmail.com>
Subject: Mr Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

-- 
My Dear Friend,

Did you receive the message i sent to you?

Regards,

Mr Jerry Dosso
