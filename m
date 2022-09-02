Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05155AB8A5
	for <lists+linux-s390@lfdr.de>; Fri,  2 Sep 2022 20:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiIBS7S (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 2 Sep 2022 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiIBS7R (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Sep 2022 14:59:17 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD2EF32DC
        for <linux-s390@vger.kernel.org>; Fri,  2 Sep 2022 11:59:16 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id d14so1136651ual.9
        for <linux-s390@vger.kernel.org>; Fri, 02 Sep 2022 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=eMVCF1fPAuqmYegJoCJUJU7da8MHPWujB10GZ78eaYE=;
        b=birhDn+38bRnuzUHU1hRGW0KRU8j7nbzhBKBUI8JsfRHu8pX6TVL4K4f54AMPHkQ1a
         Eux3lwq4AjYUIC+gdjLcAYLXufbdjfuDqoSbh3muyO/empxIqWucRNo1pWA0ZkBLMXUl
         /EE4XKs0O9XZo3FIA+8fpThETFQRB/rXykOEJsNlf31BVaAgBw8PEPUz0wK9/BdvSkkR
         SiM71M0RLYJVuU3kMcQGvC0bF0AHPZEQ4CbHGM0CcE5y8nFnBrht7Dj6sLQb4CNFP9XR
         cs7QF8Gm/ljG4r5IPbjhfHlHgVLnk5c60vY81gpFXeNlwhuqgr5ImkmufhOJ6kSs6TnH
         3uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=eMVCF1fPAuqmYegJoCJUJU7da8MHPWujB10GZ78eaYE=;
        b=39i1Vt1Y2mpEzGFO+jmOIoDYDQyM/UqCMgWLqAtNKZIV0Ozs4PdpivfR26xgsvFFe6
         9aIQIcg0/tlFjpEARN+NkFV3mbq7sRUDLPo8OUWeciuSPPo3jFbJb8E9hdf3JxH+KOHo
         vnyv4sax8LHEyl2pvfg7cctDBFZeK1fCUh3b/vrDnNL/yQjEiWgqzjmeqS+yoXrLUVMs
         /BzvBKAlKI7MobU1s7paivuc1TyrhERowzO2bqXCytKWSHkJyo2uSHUxtTEcmONQjnX2
         dU16xZIBUrS3p7E6WEBogrA8uSS6Q9a1jq5PGJi3UQa6vIlJRQfTmRRTPTNff5lqXmvK
         X7CA==
X-Gm-Message-State: ACgBeo3YAP5UocPVRgIFFyvIFK3AbA3xjNJ6+mhcxJZmFSU3DuzZn5+n
        h/4ShjD68LpY0k9UzOrm8ogLz4a35Wzj9ldRydQ=
X-Google-Smtp-Source: AA6agR47HgBStOldmWi7FmpfKtIMYvJjO03/3YvMDmyw8evoOwCastM8wD2QAKmS7vrbW3tYXp0T4wDeAWg5bzJXgTs=
X-Received: by 2002:a9f:23ec:0:b0:39e:c54f:ffc7 with SMTP id
 99-20020a9f23ec000000b0039ec54fffc7mr11307445uao.17.1662145155320; Fri, 02
 Sep 2022 11:59:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:c9d1:0:b0:2de:35c8:c59f with HTTP; Fri, 2 Sep 2022
 11:59:14 -0700 (PDT)
Reply-To: officeeemaf@gmail.com
From:   "Chester R. Ellis" <offficcemua@gmail.com>
Date:   Fri, 2 Sep 2022 19:59:14 +0100
Message-ID: <CALY5DG8JRJ=sj6sDU6qOBSUyjowvSmPCegRtCONm-CG4QA_sVQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Greetings

I have sent you emails, but still have not receive a response. Kindly
get back to me for a mutual benefit transaction.

Thank you.
Chester R. Ellis
