Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8B25A0EB5
	for <lists+linux-s390@lfdr.de>; Thu, 25 Aug 2022 13:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbiHYLIj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 25 Aug 2022 07:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240965AbiHYLIi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 25 Aug 2022 07:08:38 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4932AE9D4
        for <linux-s390@vger.kernel.org>; Thu, 25 Aug 2022 04:08:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11c5505dba2so24400928fac.13
        for <linux-s390@vger.kernel.org>; Thu, 25 Aug 2022 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=QLEwT3mDYOVfQC+EWP0pgwxHJ5L5DBc6WDYdWESjhpLfI6/elYNa1pOQwdFucLwvpZ
         7AX6lj6vJ9IuoE4nE/SLtrqkWKzijt/YZbHb4wXbTeoShJnxkOsDaBUkgAwU4CGlXeMq
         XunJpgBUe/byqMt/IpWVQF9zZks0n1scp3wuhcXIJY0RvzJjmpROE73KqfVg/tizJaUw
         2RJ9jq4fKKmZOs/XQR3vZ2Yexc+f0o0rhDDasrg27o9htR/4LwOEIaBfceUSh6quYNAQ
         rswY9t8jMdCJ88eeB8PlSTNKRnVjIkXOwFQRw772qRRL9RSNHY2p89QDCWbaXKVvTNJJ
         4bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=NcQgfGWmNtGVcmYOkqhvmNWuEth66CXwSKmPdJfqqgM=;
        b=0nKAC3PMJgcD8uc7BCYYp9qh+JJb8FgQiH1qOYsZ85Is7hO3oWbD3YNGHO6xQUUCCM
         LlsRyGtIBa60fMmBU8phGlOdVHSPNhrzY7tS92udZ9ZDNbjXLU+X4+rTubqW2sR8Nw4B
         1ZCOOk6RIr0SYysmzZtwjpc5Waox7cvwGQ+I2RJP0wfmJvh2V8RWPazU5t4e6ibSzyU0
         FTCl59l/nnJEowzNpeQwiPk+yf5yqs1VcuS4JW4YZGO0hUZ8vmDJxwPJ5Ew6g1YJBXpX
         RYpZoD/BCH6dxqCH6bJXSynezYPGmpDdRbr1R4r5pwyH8Sp6rdARWbPCJjhT/mSORy/r
         HN4Q==
X-Gm-Message-State: ACgBeo3G8jKoV/say3GQPSx2cnKmKAw8LCkMaDA7vncdi8sDOJQP3ifO
        alOeXb49T/ss2fhoSiwWm8xQ4sfs5i8vareLatZl1x5c
X-Google-Smtp-Source: AA6agR6vxFu+T5Vi0JlBETP13HQZT8Q6LFfji/WvMjiIsdWgeDbghANJ0lVZsi9+DDNbMSXCgZ5mRKrBDtWrJnmB950=
X-Received: by 2002:a05:6870:b51f:b0:11e:39c8:cc10 with SMTP id
 v31-20020a056870b51f00b0011e39c8cc10mr360537oap.184.1661425712647; Thu, 25
 Aug 2022 04:08:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5ec3:0:0:0:0:0 with HTTP; Thu, 25 Aug 2022 04:08:32
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   kayla manthey <tadjokes@gmail.com>
Date:   Thu, 25 Aug 2022 11:08:32 +0000
Message-ID: <CAHi6=KYt_bAm4D5od95kP0tPF2g49oCa+O9rxeaPXVw96Pk-8A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tadjokes[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Bok draga, mogu li razgovarati s tobom, molim te?
