Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1973D59052E
	for <lists+linux-s390@lfdr.de>; Thu, 11 Aug 2022 18:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiHKQzy (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 11 Aug 2022 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbiHKQzT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 11 Aug 2022 12:55:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7D0B07F5
        for <linux-s390@vger.kernel.org>; Thu, 11 Aug 2022 09:28:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z16so21858069wrh.12
        for <linux-s390@vger.kernel.org>; Thu, 11 Aug 2022 09:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=Zczd81LNv1xHVJW5LMHbnrfWpLWiMppZkaou/EB+Esg=;
        b=CGz+bHAflj6Ox/CB01EJJWyj/OCmOrVJm/RB3qaD7hPKYjSeZvLrLY+a41cQokPVud
         3Lw/ZochYRmPs1HzdXHCKwbwZjlR1GrAZFnPlbaQHKqwPeVz6R7b0TfloPHIap/n+Jjq
         6gk3Ph6Wk7zD6fxTqwxlNdDRGueWTi1AjfXiuqUrzGQ5IKqGEBATREcPm+bdKra10hrv
         p4L/v2sE1nCeQvKwiAr2qLr1XF0WsbJAIvyYryLZwBr+DgBHdI+cbaZN0KifCzOfW56+
         Q/VD5IlwF5PipOX1eBYNWQ+f3RFm9Ryjh1c2jeclXE1lnhVjkzbwprKPr6i6REtMMmmo
         hlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Zczd81LNv1xHVJW5LMHbnrfWpLWiMppZkaou/EB+Esg=;
        b=4wcJ2/GlWfgo4uwLJXI7ZLBYN1Wj4JNHH8cuZ9zkqyycMNLFXp+iWVqZeJzz1WHSCP
         uSkeNk28N7LLmE90DweR/jVIHj+A6EYPk32BWKBTrOmh5G5dz3670fpCPm7ZBq0q4o2D
         osrVb3/JeXZRwGen2bgRPp9LmuDDjHOci3V2f552Kx25SD9XG0xYqN1vqiYtmQjD/+YV
         QVLOwPHZifIPDaaaoa5FOvQ1pIExmoWO7SLpcMPh2ypkq+ebq0nk1YH30dfxdWTZbQuT
         7HvXulf17FibhILIQIgaErn1mm8oASnTLyJvzjdEOeCU/xBqARgcBTHF5kZnXQ5nVrsV
         ziMg==
X-Gm-Message-State: ACgBeo39qyeYxquUQo3Oj2DwUOfMaqTpKFblC5myPDghGSbzSkwCAoKo
        xjSD2qdEFRm2ETlRKzyTIZelqPUrlzqHbDQAHsM=
X-Google-Smtp-Source: AA6agR6iZ9oe9s6F2xGf6jbGSXfGSldHPjrWOEw0vqoAFj0WpPXzJ5gBkXItb323xxiswUt3/yyzaj37sgU4cONuwwE=
X-Received: by 2002:a5d:5949:0:b0:223:88d6:bcf1 with SMTP id
 e9-20020a5d5949000000b0022388d6bcf1mr2757958wri.165.1660235286087; Thu, 11
 Aug 2022 09:28:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:548:0:0:0:0 with HTTP; Thu, 11 Aug 2022 09:28:05
 -0700 (PDT)
Reply-To: ubabankdirector07@gmail.com
From:   "Mr.Peter Usman" <toom72433@gmail.com>
Date:   Thu, 11 Aug 2022 09:28:05 -0700
Message-ID: <CAD+ThjanohL=hUX--_JBDN1dGe6J9ZpWj6R2i0ZfkyWi8sc4Cw@mail.gmail.com>
Subject: ATM Card Owner
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [toom72433[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ubabankdirector07[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [toom72433[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Attn: Honorable Customer,

This is to let you know that your Visa Card is ready now and the part
payment has been credited already as IRS has signed it. So contact Mr
Janny King of UBA for immediate mailing of your Visa card now. The
amount is $10.5USD

Name: Mr.Janny King
Email: (ubabankdirector07@gmail.com)

Thanks
Mr.Peter Usman
