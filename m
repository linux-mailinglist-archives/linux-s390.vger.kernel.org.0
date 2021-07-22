Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B73F3D2BBC
	for <lists+linux-s390@lfdr.de>; Thu, 22 Jul 2021 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhGVR2T (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 22 Jul 2021 13:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbhGVR2S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 22 Jul 2021 13:28:18 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2D5C061575
        for <linux-s390@vger.kernel.org>; Thu, 22 Jul 2021 11:08:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 23so6340525qke.0
        for <linux-s390@vger.kernel.org>; Thu, 22 Jul 2021 11:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=IjMSckWZc/4XWyN5MUQYmuM+FO7jerFrbq/RAcM7UA17qWWDuMR7KZchTc+dFWp+wP
         dnAusZ7jpBJzO51JwRozBmOuK2VW9T4IE5xCTvk8rQpOJIjwlut+1IPy41WrErQfr3rx
         ei6SsqqF0O8UZwdEcovrnhyhMhL6M1F0n0qTv8xOUpGeL2XWuEaJ5IGKXKddCgU1q59d
         zyJpBHdsUC0yPJBtir8BGHnn+w/2e2VxCf8tjybUH/L+QEjNMXFMlrlw+s6TdDonYOMP
         IrE/diUH48p2rrV3XyDbAPIhDm3QqyU+SNvdu1rFWmxbf54hNTDXp2cT1oMrSvFTcSJk
         D/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=dbiqOQhkV4brHmNgYUPaK3qcrMQfv2CyqM36P297Q3Y=;
        b=NWik6jbTlu1gqI2+DB6ll8+5NQB5IDFbEQ+vPzmlzUKqkyLwcdx4llpCnFIDtupNt0
         KbAotQR9TRFjAk3n42v3X/G+Uoua808Sw3CThjDEwJ+6EeUae8WcSYf9kfVkGq3KPDv+
         VZ7uI53pVMCHWpBn+o5iUqZYWVSXZIyAH1UBsw/Navd0IaDTOnGrlX4CyX8RGePXVfKC
         8MPEAziLIzH9lvEZv6x98sKELBvsRBfMOttrB6B5Vzqzt46Vj5EvyA7xNtm6hGOuRG8h
         mx974MnIf6R2mRlHMvsHHEhNdG3kb4Kf4pNHHvUUk30z89PJGtqTvbRJ7o8jqMQd3pPD
         xtoA==
X-Gm-Message-State: AOAM530pU8URhD/wRaEK+y+KG44Bfm2+IkFPO1RK6lOly8HVj0fFAvLU
        PMY0TU965CqMeGgBNEz677sjrrXWtwxlhhqpTXY=
X-Google-Smtp-Source: ABdhPJzBrBw7gztflAMM1KAEpwIwD63wXxFghKifCp7xy5JnzO3WiQu7drZUHP3b8u7UWDDIK3EuYcWm7C61OBm9tbU=
X-Received: by 2002:a37:6516:: with SMTP id z22mr918259qkb.203.1626977332853;
 Thu, 22 Jul 2021 11:08:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:5b8a:0:0:0:0:0 with HTTP; Thu, 22 Jul 2021 11:08:52
 -0700 (PDT)
Reply-To: cherrykona25@hotmail.com
From:   Cherry Kona <fernadezl768@gmail.com>
Date:   Thu, 22 Jul 2021 11:08:52 -0700
Message-ID: <CA+J-fD6v43szzi=S0qjPsXm89-PfYbj3hJZMMrC+MiNUT_Od9g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

-- 
You see my message i sent to you?
