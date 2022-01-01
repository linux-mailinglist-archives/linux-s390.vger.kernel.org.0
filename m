Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3422B482771
	for <lists+linux-s390@lfdr.de>; Sat,  1 Jan 2022 13:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbiAAMFj (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 1 Jan 2022 07:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiAAMFj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 1 Jan 2022 07:05:39 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C13DC061574;
        Sat,  1 Jan 2022 04:05:39 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id gj24so25291843pjb.0;
        Sat, 01 Jan 2022 04:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=YFArSMJuez0m0xSePM4LBQDwd39Qq5A++nRmswdJD24Alg167pYPCnd8mYshqDo3/t
         7aoVHIwG5tnT2ZJ9c4f3d8sQYcgRCvn+h/ToyZqqjPi0AGWCUkAWMdCq97EzZF2NK+to
         oYEoKD0dcDLhZh2RBsqIKyMYaf2ixdUZaz7BruiuHTlJPs2Ox7aLF6Qq/DSZBTCF7yOR
         oOc2wJ0LoW5H+58DxGoUoxe8TsMiuw/0fv6WL8X55vRkFH/ydmbblbdP5nieAZyPO9DG
         2O7JizbVrPdDwIKbcLO8+nH9581Sd2dibYDZet87f/IS+oNu2YvZwvQzbSr3aQPK3EJM
         HrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=dhFaFNGf9P/hgzfpigNOAcNefTeR7Csml9+Bh/hdy/w=;
        b=HYlZR2G13gnn8A9EOgaDmw9/EpZplSi2LXHER5kyrNuVBPY1AVa7DxcrJsQL3Gq3j8
         RbH6xQohzL0qm4j/yVxOREi/ytdCmY18Q2VD58KUL7uEhyHe4nziQvH7XUlFLT2GfsZe
         YqdMVSJXz7Sbv3EdIHyelCNYgaBSanns3u9Bvzzp42FUZY517YwXHo812s7s8PhwK6WR
         z3htzn/T4w/uVp6tvlkVNKFF56Av3TFGBwOl/yPeh5hVcOm1tkCkltrD5By0AMIrVxPP
         kDMpirrQpRkN6YUhBuTbbVFY/NqMS5gX3km4DfTq4HxkXTp3ThQiDyLZt6ySd3M5GWtR
         BBAg==
X-Gm-Message-State: AOAM531Yh7zHbNzFAojsQO0Va+gDlm++Lc9nsV//2zNos7mqIoFCtZaC
        gMp8TfZ94+U0/t7uDE0wCSA=
X-Google-Smtp-Source: ABdhPJxFhVjhFOeNPhNmB+nDnTli7PNBSu+dEEPl1K5tWvNtJmsJbL7QqiDCEkbNjpozxCUiGzu4Rw==
X-Received: by 2002:a17:902:a50a:b0:149:7aa8:37f6 with SMTP id s10-20020a170902a50a00b001497aa837f6mr28124330plq.91.1641038738690;
        Sat, 01 Jan 2022 04:05:38 -0800 (PST)
Received: from [192.168.0.153] ([143.244.48.136])
        by smtp.gmail.com with ESMTPSA id w13sm27606619pgm.5.2022.01.01.04.05.30
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 01 Jan 2022 04:05:38 -0800 (PST)
Message-ID: <61d04392.1c69fb81.c547a.d7e0@mx.google.com>
From:   yalaiibrahim818@gmail.com
X-Google-Original-From: suport.prilend@gmail.com
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RE:
To:     Recipients <suport.prilend@gmail.com>
Date:   Sat, 01 Jan 2022 14:05:20 +0200
Reply-To: andres.stemmet1@gmail.com
X-Mailer: TurboMailer 2
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

I want to confide in you to finalize this transaction of mutual benefits. I=
t may seem strange to you, but it is real. This is a transaction that has n=
o risk at all, due process shall be followed and it shall be carried out un=
der the ambit of the financial laws. Being the Chief Financial Officer, BP =
Plc. I want to trust and put in your care Eighteen Million British Pounds S=
terling, The funds were acquired from an over-invoiced payment from a past =
contract executed in one of my departments. I can't successfully achieve th=
is transaction without presenting you as foreign contractor who will provid=
e a bank account to receive the funds.

Documentation for the claim of the funds will be legally processed and docu=
mented, so I will need your full cooperation on this matter for our mutual =
benefits. We will discuss details if you are interested to work with me to =
secure this funds. I will appreciate your prompt response in every bit of o=
ur communication. Stay Blessed and Stay Safe.

Best Regards


Tel: +44 7537 185910
Andres  Stemmet
Email: andres.stemmet1@gmail.com  =

Chief financial officer
BP Petroleum p.l.c.

                                                                           =
                        Copyright =A9 1996-2021

