Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C5F5384C3
	for <lists+linux-s390@lfdr.de>; Mon, 30 May 2022 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241637AbiE3PWy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 May 2022 11:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiE3PWD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 11:22:03 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05611C8665
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 07:23:32 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id y17so2529953ilj.11
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=RbLJCZVFtlwj7+Z3Y7O0qJYoBzYmhQGTvS5NB07cWgaLzfpl6yx8Kj4fQ2ftIv/z4J
         ngANjnThxfX6oIbbTJhPgykypESQf7OjTy2kYBz1v1fjPHzS1laSAPBPVJKj3uW9csWw
         yQJ9QY0OHMBfgiuXmszRqX7M19GcI4nUyWsNwY9mzZUaAA2IoGzn7L883g907c6jwD4V
         NqIMl3m3/I9AGi1Jngi+1iXud+358BbC3kf4kYrRHcR7qWJfE6pDNrfrWZgiTqa63xtZ
         RhPNiSI6Tt9IlA2KAo9braSDJGonjfWltprNqnSEuQFzgx5HEnkg7xtv5ur6zGMbz4jd
         J93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=XJqXgw0Qi4Ge6Q57wB4GlvotoYnhUuSq68y9152a6AE=;
        b=gf0Lj1jYHTNCP70OmqUJRALUuFMiCCEfZx23dmWjuLt+Q9OkwveWUYtZSSRmvaKTGL
         E04H9/65R7avm1xO7FeiWvI8XhyUSknxHV5gZeHKukS3Y2BgSeSnN8TCfnT2jMFRwduj
         a3i3ZkmmHgElaYYfyp3CGvTfPamalrnC8Z+xmWjeskbMQp2KnzdtHijv5xG9oM3u2t6J
         I00yZYsnMOP3uRy1uUXt0E1pwcMzBilfPus9ku2CsFKXo2X4DD+duGKPgqoKAGO6XA4+
         bJMsQ9tUEJjGnDbdz0rHte1A6AF/SFMaqU6dk4a680L4a8VgSuU4iZH6cj2DfZyXvDWI
         7HQA==
X-Gm-Message-State: AOAM533G28npfnF82R/nbAyyRn/9+MhNj15NkB3957yDghE5HsaA1xNM
        TsI7FO6DDzQxVEhH6Gcp0sTGhtfE9rCPDcrfSRU=
X-Google-Smtp-Source: ABdhPJwkqQ/OIioqBR97/5zzSyy3lV4aE87tmDKwpi6v68YH7z0pcYmIQ2y3lvQmeJxEofabhQ+YK6IbKXKNcCfn+P0=
X-Received: by 2002:a92:ddcb:0:b0:2cd:95b6:bede with SMTP id
 d11-20020a92ddcb000000b002cd95b6bedemr28008470ilr.280.1653920609933; Mon, 30
 May 2022 07:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6622:f06:0:0:0:0 with HTTP; Mon, 30 May 2022 07:23:29
 -0700 (PDT)
Reply-To: barristerbenjamin221@gmail.com
From:   Attorney Amadou <koadaidrissa1@gmail.com>
Date:   Mon, 30 May 2022 07:23:29 -0700
Message-ID: <CAOh7+P_S1KJjrGTcsy2OMG3ESqdo+WBN4sMaimz2b0zfWx46hQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:144 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [koadaidrissa1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [barristerbenjamin221[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [koadaidrissa1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

SGVsbG8gZGVhciBmcmllbmQuDQoNClBsZWFzZSBJIHdpbGwgbG92ZSB0byBkaXNjdXNzIHNvbWV0
aGluZyB2ZXJ5IGltcG9ydGFudCB3aXRoIHlvdSwgSQ0Kd2lsbCBhcHByZWNpYXRlIGl0IGlmIHlv
dSBncmFudCBtZSBhdWRpZW5jZS4NCg0KU2luY2VyZWx5Lg0KQmFycmlzdGVyIEFtYWRvdSBCZW5q
YW1pbiBFc3EuDQouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4NCuimquaEm+OB
quOCi+WPi+S6uuOAgeOBk+OCk+OBq+OBoeOBr+OAgg0KDQrnp4Hjga/jgYLjgarjgZ/jgajpnZ7l
uLjjgavph43opoHjgarjgZPjgajjgavjgaTjgYTjgaboqbHjgZflkIjjgYbjga7jgYzlpKflpb3j
gY3jgafjgZnjgIHjgYLjgarjgZ/jgYznp4HjgavogbTooYbjgpLkuI7jgYjjgabjgY/jgozjgozj
gbDnp4Hjga/jgZ3jgozjgpLmhJ/orJ3jgZfjgb7jgZnjgIINCg0K5b+D44GL44KJ44CCDQrjg5Dj
g6rjgrnjgr/jg7zjgqLjg57jg4njgqXjg5njg7Pjgrjjg6Pjg5/jg7NFc3HjgIINCg==
