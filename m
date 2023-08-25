Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F12D78915B
	for <lists+linux-s390@lfdr.de>; Sat, 26 Aug 2023 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjHYWA1 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 25 Aug 2023 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjHYWAH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Aug 2023 18:00:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A0272D
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68bed2c786eso1101219b3a.0
        for <linux-s390@vger.kernel.org>; Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1693000786; x=1693605586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCmT1oESbAYhZeNNKJ5ShtRN4csCjH3Kne0S41EAnjg=;
        b=41e5WqQODP0hmu8CXJSYnJoxP9CYCTQIjvtSx0suLjuCd2LQoihd/jLrKiko4xwooZ
         7dYHeAbwy4v/acegR7zM2t87koKR6b9HdwUQM9+1khEZHSlP6Ay9Gyi1BnTTJyQ+N1sf
         Tihv+CPf4TPS3j/ZySi0TL4gDqhyuMZ+nJxTaDnexRh6Pcmjy8aRHLfP/t/1vg9xEN/C
         0OJKzvJcUqwLuYg4eu+OPeBIRa0lo/YObVmgzaCCijZ7OHy87LLvHUMM6er4JE4Dhtu4
         AWYpsvb+nGYnjp1AziAY3+XfPWUVf+GXDgs/Cvrt+UTpnf3nupIw3K4PynKsZ49o3GsI
         BY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693000786; x=1693605586;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCmT1oESbAYhZeNNKJ5ShtRN4csCjH3Kne0S41EAnjg=;
        b=KjhpQRLgfyBY8BG6vVvXhZcugip5LKc7jZ/Lb+sDOTWQmUNHrmClR4zEogRcIhzjoj
         HgpF+OXktf8fYuLQjNIHDC8fZ2Ac8zRxLHTKDjJp+3xjO2Rp201QLaTZOy9vzlApgjWN
         jNXmMZ3GpeCbSqddsXSspqtn6bH2G0qoA2e2xmBmPUZ9V5VysRjFdZfcNdILrRbefxqv
         reWt0dOSfmu9f68yWz/udveClwuoTG965QGJqyovawZY5KuYp6F9o0UaOXbyYTSoUd3I
         XaHdBFD7dkGrO1EaHGNQtkxHPJ8Q8BQkB+X0HsYQQZ1YJCEU3mNBk310HUtdPO1pzwuQ
         ZGuA==
X-Gm-Message-State: AOJu0YyRJ+hLK1vzH6GVFlx8uKIMN75UaIELlrOViGMIclNJSQ6oZMdr
        lYzMW18k9AwZUM9aqGePKP7Klg==
X-Google-Smtp-Source: AGHT+IH1qPsbAkUY/ApYOINMHsRtAsDWZuWyGwI872JdnDKqNbs04KgeM02oT1drFck2zagaT8PEnw==
X-Received: by 2002:a05:6a00:cc2:b0:68b:a137:3739 with SMTP id b2-20020a056a000cc200b0068ba1373739mr11002510pfv.4.1693000786153;
        Fri, 25 Aug 2023 14:59:46 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78742000000b0068be98f1228sm2025436pfo.57.2023.08.25.14.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 14:59:45 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qZeqF-006VO2-18;
        Sat, 26 Aug 2023 07:59:43 +1000
Date:   Sat, 26 Aug 2023 07:59:43 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hao Xu <hao.xu@linux.dev>
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH 28/29] xfs: support nowait semantics for xc_ctx_lock in
 xlog_cil_commit()
Message-ID: <ZOkkT5Ai7wyMGcWC@dread.disaster.area>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
 <20230825135431.1317785-29-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825135431.1317785-29-hao.xu@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 25, 2023 at 09:54:30PM +0800, Hao Xu wrote:
> From: Hao Xu <howeyxu@tencent.com>
> 
> Apply trylock logic for xc_ctx_lock in xlog_cil_commit() in nowait
> case and error out -EAGAIN for xlog_cil_commit().

Again, fundamentally broken. Any error from xlog_cil_commit() will
result in a filesystem shutdown as we cannot back out from failure
with dirty log items gracefully at this point.

-Dave.

-- 
Dave Chinner
david@fromorbit.com
