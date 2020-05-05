Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D61C5DFA
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgEEQyI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729949AbgEEQyH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 12:54:07 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34587C061BD3
        for <linux-s390@vger.kernel.org>; Tue,  5 May 2020 09:54:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so2042487iog.13
        for <linux-s390@vger.kernel.org>; Tue, 05 May 2020 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQPV38VFHq5jUdj3xuK872aLx1CmmM995oAhTR/zeg4=;
        b=p0OmBMiNRcbZeEVttRyrUydpDTEXD+loILZwadE01yiYrZMAefBa5lEnkCd8IE/f1C
         wqtNt3itnutwU9SNyU/Y0fQOnPrSFTEoDV1obS+naK5wdvSAbwcozgcVIGkY/Otjnd9p
         51XhOstTUsx5ISmBzOTD1jNv/oS5q27DmqmWhYSeqm+5U94xAJaIyLgweW34StzfEErI
         3dfM/v0XMGcRAFe9bPtoLVFLg5ACcy1j8Rnan0JmxmJvsltfDo9KWXkcjYgZK/TvXSRC
         Oh/P44Cii0cxHTkyJ4tN2a3504hNbCU0BEhwsSTKenaJXoMTLVbgu3JdVv36Y/5fs6vB
         BO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQPV38VFHq5jUdj3xuK872aLx1CmmM995oAhTR/zeg4=;
        b=K9UiwlxfzU97pyDCNFJbI/qM9tB7Ld99h1yDLZs7XBTuPOyht3Nk/pp3UtbqRGM0k2
         yQDxUPt98Q+ctINZhUKDKg8/eiVIhTuDKFRxOJk8nday+wVuVzA4ctUbt5/VEIJw2sye
         htdLOahHyAU1AHex1VxNm6xPrtWTqT9nQ/TCN356QUyyLlpIQ/qC7YGuLPYlWSEheM8k
         UZrZECc9qIV95dRk9LpkEXL27lhD9wgaBJQGMewRrRE3FXY4Z6EDd4fx5Bs/7J/IAyy9
         /2fPNuhUs5D+6XCzX7EJnd0hm7dgQ9F0J2ZPl8XaI0+Es2MjTPGMPfmscapHbvZGQsKd
         rDsQ==
X-Gm-Message-State: AGi0PuYHHJhw6cWUq1sd8wjIES2sF4fiUF/eqsnX5Kie/6tray04Eu6N
        fN2COQ1ABWfLbwteROY6O13UU6nigT/uo5DiIxXorw==
X-Google-Smtp-Source: APiQypIh87tWtIMtuteWC1af3Q4H+FkjslZ8xyNvCG2aA394n3dc+bOaNgbwVm/hpp4CR/gsTCwAOETr4pzr5lry2Mw=
X-Received: by 2002:a02:a004:: with SMTP id a4mr3700717jah.18.1588697644142;
 Tue, 05 May 2020 09:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200504110344.17560-1-eesposit@redhat.com> <alpine.DEB.2.22.394.2005041429210.224786@chino.kir.corp.google.com>
 <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
In-Reply-To: <f2654143-b8e5-5a1f-8bd0-0cb0df2cd638@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 5 May 2020 09:53:53 -0700
Message-ID: <CALMp9eQYcLr_REzDC1kWTHX4SJWt7x+Zd1KwNvS1YGd5TVM1xA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Statsfs: a new ram-based file sytem for Linux
 kernel statistics
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     David Rientjes <rientjes@google.com>,
        Jonathan Adams <jwadams@google.com>,
        kvm list <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 5, 2020 at 2:18 AM Emanuele Giuseppe Esposito
<eesposit@redhat.com> wrote:
>
>
>
> On 5/4/20 11:37 PM, David Rientjes wrote:
> > Since this is becoming a generic API (good!!), maybe we can discuss
> > possible ways to optimize gathering of stats in mass?
>
> Sure, the idea of a binary format was considered from the beginning in
> [1], and it can be done either together with the current filesystem, or
> as a replacement via different mount options.

ASCII stats are not scalable. A binary format is definitely the way to go.
