Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0382858AA19
	for <lists+linux-s390@lfdr.de>; Fri,  5 Aug 2022 13:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240626AbiHEL1H (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 5 Aug 2022 07:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbiHEL1G (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Aug 2022 07:27:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF373B7F7
        for <linux-s390@vger.kernel.org>; Fri,  5 Aug 2022 04:27:00 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-324ec5a9e97so21230197b3.7
        for <linux-s390@vger.kernel.org>; Fri, 05 Aug 2022 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=BqACUvNC35ZzRLm/C6CVkq5r/zaFsGTvsAO0hZSVg8BAxcVRE7Jku2TiCV9wYArHsW
         lazyBkRVvwkxA6jIWH9TP0Ix5AY88RAeP4vIhF3mn4nPG09XsM8Ic9nYfju15LtJ8xc0
         jzDDIkbpczrNSnqZl22wcCagCd7ew1rHjf114dqIwKA+dxtngpGjuvzXtoygrBlhEgqn
         r0pODtohqfXDfViiXU2LpEsUbNSqGCWjY6alVmjk4wY0RWPA6Vs6gPQ64BA6GvXzwFyy
         eTSuwWE0LpQ6i22+qppRXlLaaI2TjosKB+LEh4KCaD+H6BNWBN5IIGwoE9p7ryGCqk2y
         MxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=muUdW2iF3NLjwFcKkUArmJmVBNuXYz5InLqAh5elhfQ=;
        b=hOMtDIo26KoV3AfvNRsUJCgrR5lhe40RnIV3Mpw0ZrGA1OvXsqOfZJdmqhAVVtCrIU
         YwPI7h4ZZ5m13vDzXsK5sYcw2CAW+iost0ZD+vcvG4oOKg63SThep0oG0lFQFWHKAQfJ
         XnIWWkRNMZ3Uf+Xon8tcm+Lvmmmrx2JLTB4W2FIXXVCDorHhA5QFyZ9C1bmjFLRb4CtA
         ZvQlnS4OV+C/xEZaZotjda16gwyFhXDf52ce7FWrVDais9/zbHAHZkiB9+lqg56Zow/u
         5oMWUNtjRFqR8I4KoHTNsuO0Kvn74q6PeTh6QAYvOsehrrIxyrSxvxENn8lKpdUZdriU
         Tcjg==
X-Gm-Message-State: ACgBeo3YvcheNkmUAU9BAi8ocKdPvs5A5XI7i6yHdHgH/QL2zdst1B5g
        OH44+8SJmCcrUpFVxOvF+5euYutz6ybJqxNvnYw=
X-Google-Smtp-Source: AA6agR6aEJ88XvyOeTtvXE7q/gen0/geDK2rX8ZL9TOc/6x8rjDMk5k7ZugmgYlTx/51zPCtCnSDiZwGffzTWodw9P0=
X-Received: by 2002:a81:6d4d:0:b0:328:3b8d:2f6e with SMTP id
 i74-20020a816d4d000000b003283b8d2f6emr5531728ywc.37.1659698819995; Fri, 05
 Aug 2022 04:26:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:5087:b0:2e8:760f:3500 with HTTP; Fri, 5 Aug 2022
 04:26:59 -0700 (PDT)
Reply-To: rolandnyemih200@gmail.com
From:   Rowland Nyemih <fralaimetals100@gmail.com>
Date:   Fri, 5 Aug 2022 12:26:59 +0100
Message-ID: <CA+5KX21qD7xz962CyFE+jsHLRM9-cDOQr8_kDcNE-vWcVAV46A@mail.gmail.com>
Subject: Rowland
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fralaimetals100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fralaimetals100[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rolandnyemih200[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Rowland Nyemih
