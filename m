Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7013A2475EE
	for <lists+linux-s390@lfdr.de>; Mon, 17 Aug 2020 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgHQTbS (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 17 Aug 2020 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388959AbgHQT3y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 Aug 2020 15:29:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4DEC061347
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 12:29:49 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d19so8574020pgl.10
        for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2020 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQEFM5eDrlk4uN0cUulgaoouXT3z+FbkNrUscxGEwfY=;
        b=Il4/WYWWqFE/qAzOwm9kfMC9NOlA004aXkbH1fIy/V7R5qAIiigoyGwSXJeap5fGzZ
         IAtDk7ThFw+I+uoN3iEBR0k7l7V4G8iWozOPbWwoF8xpj+feXJjxWDmDJxCbi3yVIIz4
         DcKKycHMZ5M8iGH9xX6OxumCJ3bPk/sESXWCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQEFM5eDrlk4uN0cUulgaoouXT3z+FbkNrUscxGEwfY=;
        b=aH7iMO/jcV1S+wwjwcIeyeqZX6EteZ5HUq6cyIe3V5F17FWblpJvvUlxdtmDfh0eUz
         78nsGtf6Skci15bICXdS468ujwGXxQ2xIe2xQQ/eYlj4e4crVrSRlmHl15gnHnOlnMHq
         m4XHcNaxbZliIC+esRnRPkwp10AbuR4CKwMmhppY4bVKgzuA6t5xHFb3SnFyFagLnDyc
         MEuxVypd6v0PG48mJ9a5frASicD9JBqW+ePKY7WO0cGyVOjo8+N64QS7EfD9vtjgmf8G
         iSKeByzWomM8+cl/2U0hrpptXGQ/lKXdlT70RLVHvnuwuveBK9EBVI3DEKpW/XH4aBI4
         6DEA==
X-Gm-Message-State: AOAM533bD40RBmWsSlLcA7xcCKfnX5C6UQwlM/MIrEEJg5AEMSygkUGv
        KeCbmb+G2AKDbmC3jlrk98Oitg==
X-Google-Smtp-Source: ABdhPJxcba+zdwEuQprcShXltivd2diUYpTiu6P3/hYoUspmLcf/BB1Tt2/E3lFjFEP7byFNgsURlA==
X-Received: by 2002:a63:2e87:: with SMTP id u129mr11009060pgu.347.1597692589083;
        Mon, 17 Aug 2020 12:29:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h19sm18737765pjv.41.2020.08.17.12.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:29:47 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:29:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Allen Pais <allen.cryptic@gmail.com>, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, 3chas3@gmail.com,
        stefanr@s5r6.in-berlin.de, airlied@linux.ie, daniel@ffwll.ch,
        sre@kernel.org, James.Bottomley@HansenPartnership.com,
        kys@microsoft.com, deller@gmx.de, dmitry.torokhov@gmail.com,
        jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, maximlevitsky@gmail.com, oakad@yahoo.com,
        ulf.hansson@linaro.org, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, broonie@kernel.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, mitch@sfgoth.com, davem@davemloft.net,
        kuba@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openipmi-developer@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-ntb@googlegroups.com, linux-s390@vger.kernel.org,
        linux-spi@vger.kernel.org, devel@driverdev.osuosl.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
Message-ID: <202008171228.29E6B3BB@keescook>
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
 <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 17, 2020 at 06:56:47AM -0700, Jens Axboe wrote:
> On 8/17/20 2:15 AM, Allen Pais wrote:
> > From: Allen Pais <allen.lkml@gmail.com>
> > 
> > In preparation for unconditionally passing the
> > struct tasklet_struct pointer to all tasklet
> > callbacks, switch to using the new tasklet_setup()
> > and from_tasklet() to pass the tasklet pointer explicitly.
> 
> Who came up with the idea to add a macro 'from_tasklet' that is just
> container_of? container_of in the code would be _much_ more readable,
> and not leave anyone guessing wtf from_tasklet is doing.
> 
> I'd fix that up now before everything else goes in...

As I mentioned in the other thread, I think this makes things much more
readable. It's the same thing that the timer_struct conversion did
(added a container_of wrapper) to avoid the ever-repeating use of
typeof(), long lines, etc.

-- 
Kees Cook
