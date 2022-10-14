Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50BA5FEF9B
	for <lists+linux-s390@lfdr.de>; Fri, 14 Oct 2022 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiJNODQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 14 Oct 2022 10:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJNOCv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 10:02:51 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14B51D20DC
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 07:02:08 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t186so5676936yba.12
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 07:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=EyqysdEcZyeNHGETROpG+eqDge9fV207SQKcnr92C9RKgTA8rzTHHxx2fDcblu00It
         PgkvoDxRC0LZAPWvmZFuZlgTo+9exb66DhETSBkYIJmvUP5eJfndyS+bJFSYKHaXNumt
         AUp1w5Qfnkfe6GU1+AblhNpC5JExAnIDuI+mPK/flMn/zcUxLCle9ddgWCjTWTBm1pm4
         F0FtnNlbwPDkQr3a6EkmdJIxSkNb4RGo39LU9OXuvTm9sF/gTuxgmDPdmhSVzHEZv/AD
         LB6CwFqFywfYSAqUD/wEHWXf10IP7ylwLuAHEMlqsQiL3w4iMwIaxeBo4/3QBpzqGGi4
         XX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=L0ac/f+JcxrwTLYUuz50CDbMKhhslCSUxuGDIYqebKA935TFrxX3kV9JRN1sY2nBo1
         6puOFrgE8U5160F89f4TSh9dTutCn/69ZfapMEkKHWQnEfWjbCPYs60D2spXbSTPLZxa
         viqdn2c1VVSvXBLz+LubzyzjdIa2GHZfWNQaXo7TQ3t258PXetGVqJ85AbQUQU6XHBJE
         TxHz4PVqZ96LuT6V24LyPEoljys4PVdGR7DDRKpEHx3aJ9mEMMd0Y6xgjxoabHp8T71V
         de2b/CHO7cj9uYof44EC4XNtcyb4D6XinDHS8skpyB3/p0ENuO74PZl2ZicGvZGQcP9F
         PLEg==
X-Gm-Message-State: ACrzQf36qWa95LhiMSiF2f1FX+F1LaeWDwtKgClOXdEOm7ZkDTw7e6M8
        qXi1AVwhYefhaqeAIT3Z6oYtzDDaCCUcxy1kdPLxhMKCLU8=
X-Google-Smtp-Source: AMsMyM4Z61VzO5fZEDkt1768LPsaLrxvuyztWToPwpp2LIebc48voQrAd+dostKHVEkWHatFogpVFAjmVQpHVezDy/s=
X-Received: by 2002:a25:1e89:0:b0:6bf:9e55:5cb4 with SMTP id
 e131-20020a251e89000000b006bf9e555cb4mr4690987ybe.642.1665756088067; Fri, 14
 Oct 2022 07:01:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6c05:b0:3c1:5961:57b5 with HTTP; Fri, 14 Oct 2022
 07:01:27 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <goowjarwq@gmail.com>
Date:   Fri, 14 Oct 2022 16:01:27 +0200
Message-ID: <CAC-x_XGPhaAFvtwSsv_dWvZJJHFhYhsKKzpxCm=_1oo_v5vL+Q@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


