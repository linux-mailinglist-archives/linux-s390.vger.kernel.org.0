Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9117E255DA9
	for <lists+linux-s390@lfdr.de>; Fri, 28 Aug 2020 17:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgH1PUL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 28 Aug 2020 11:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgH1PUJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Aug 2020 11:20:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B350CC061264
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so1247613qkd.9
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hmAVQxaLJpSgHlGpdC6W2VwrKbmge9YTpG2rcbgWFRY=;
        b=nacZRdtevNeYT9CJ6nLA4NoNXEAyPImxNMxzlfmMca1i8stapDOrP+Kxip7McKhAV5
         9l08gUo+8TyO6SN7VJAQU4gEAh0vE61+p3F5SrGs1jt0HPdwN0EihHO615GS6tH3XX//
         A0nOV+WX2a0KXUWY77Rer07c9z3S74bV4v2Bb585J/p8y5I44riACgPdeFN811woipZp
         TD72hirXsZeWcK+F8I5M2JyC0qJQZ/JdoITLLoxkYgfLPw2wtf7zY5nMI9Zk4ewPdMIL
         E5GAHWmTEy4YROGgjL9tDeBgbPku0C+eQHKQQ1SjhXL1STugmflpgEmdEcM/svZScCzw
         LjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hmAVQxaLJpSgHlGpdC6W2VwrKbmge9YTpG2rcbgWFRY=;
        b=oOg46I+cM9fJt/KKA4PYWJhBGicbhAOPFlaqCddSifj0GXBpRFNNYIjqiOjtQLDkkC
         fBl2O1SLlomJqfoYhoNOoP7hajA6NVXLfEqKu5a3OpjLH0k2J34Akf3y5JKl3P2W3iRB
         ymu6j1UsL8uk6ukqD8Sr2wCIbQ+OrexuWhh/+mF9ArG2hFHgb075njKAIDa/9WjQUDzG
         RzrkLSe9G1AwnY2/w8uVxgay6URZbsj6VespAX6yjh8iBXA1iVwAtyTjUpzsrFHXTCOA
         WUIl91mcEVKpPcJlNX2xXLZ8JIAe/WRwxz9G6AevIRtXVh7i66UEAw97TiWKV2fVSqh9
         56FQ==
X-Gm-Message-State: AOAM532CbpO4VdLegrWmfPNAIlupjxbSawgcG/Hz4UB/RWawewDR26m3
        VvESKqvayaV02Ubjjm7Ua9b+ltQwNQoOmQ==
X-Google-Smtp-Source: ABdhPJzcd9CgTfJl/sRgwevfrnu6z/jWnfmDFGgqlGh6cAgk0HZk1toJqs+TYqzoKCtlM+546U/ncQ==
X-Received: by 2002:a05:620a:1185:: with SMTP id b5mr1652758qkk.293.1598628008018;
        Fri, 28 Aug 2020 08:20:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v136sm1031904qkb.31.2020.08.28.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 08:20:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBgAg-000vxD-HJ; Fri, 28 Aug 2020 12:20:06 -0300
Date:   Fri, 28 Aug 2020 12:20:06 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200828152006.GY24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <20200828142137.GX24045@ziepe.ca>
 <20200828170103.6d954d95@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828170103.6d954d95@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 28, 2020 at 05:01:03PM +0200, Gerald Schaefer wrote:

> Just to make sure, you are referring to some future / planned
> changes to mm/pagewalk.c, and not some currently existing
> pagetable walkers already using the READ_ONCE logic w/o
> spinlocks? 

Yes no current code, just something I've been looking at slowly.

Jason
