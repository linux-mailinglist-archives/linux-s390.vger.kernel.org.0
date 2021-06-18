Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547073AD315
	for <lists+linux-s390@lfdr.de>; Fri, 18 Jun 2021 21:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFRTt2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Jun 2021 15:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFRTt0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Jun 2021 15:49:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5A2C061574
        for <linux-s390@vger.kernel.org>; Fri, 18 Jun 2021 12:47:16 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c15so5146003pls.13
        for <linux-s390@vger.kernel.org>; Fri, 18 Jun 2021 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eq0N34Elw7O9e3nBxwSL+pENedj11Jkr0/H5vmh3pBo=;
        b=md5MeIpFhcK2iIApQdDDALKT7hCraWLPVY3CbjtqgJicSzCUh6v5whBrWKvYm9kZPx
         +vweAivEg59pZRNL+Q6LtzJ8V4rmZjLZJC/dM7v5zPpBbsQg0nMqVD3JnIhd6yklk6Y5
         tnWZHSnsL1jw07DChiw4RbShzbMsPc3ybynFJLdK1PVN6tCOofoqrefLlTPQGy1NLtYR
         ddrwoLzLdY1oQ/QgAm+fd0mQI6wqGZTlQvuIzY7Olj2hCF8CPtqeyQGtx+b2z5NmE74i
         pWI39ae7i843LtjLzOWU/eneQaxPNAGa0NRPyJS0NFJu0mkBHzglNAawqyENDad+LzyE
         nkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eq0N34Elw7O9e3nBxwSL+pENedj11Jkr0/H5vmh3pBo=;
        b=Qaq/sWl9LEcxkZ5A9liGE89binDTgLHInNcAemhaGw9LDdrac8mbMbZsqHnRiw2+D3
         k8135E5Qqh0wIBQ9awmicQ6otag9GUcOPxzZlNB4Hgvd8Pft7v5qheY+vBuRwuFDDcGw
         ms70nNqIm8coGDMe5peW2whoBk2qf1aO0K+1ZBDuaiOmZPesLUStZoT8Ui/MMt9hCvFO
         eoc75XKVMAtMeDBT7xgJc20YsWgLFoHOcjTrVASNJJyCUqcRSY5b1QXfIUJkV3Q5C9T6
         p9zFeIqX8zTbu2iz4TB0IZetcCOCYwsazSdn70ZOu75cKTgSt+Moy30ajhYrYAjMO2pB
         DFOg==
X-Gm-Message-State: AOAM5328E52jNofliCBE5A0yrs7G/Fft6fHc5A0/bR2ibbE2o3McxgDt
        +nAxhxD8VKDtMi44wmc2GAntmQ==
X-Google-Smtp-Source: ABdhPJwIj5XwSwiZJe0QhGTCJrTe3ZX8MEoalt16+FuxZ8ezP+RY6l+/5DuS09FY/e3rd9JPPR2OkQ==
X-Received: by 2002:a17:902:c1cc:b029:122:52b4:3855 with SMTP id c12-20020a170902c1ccb029012252b43855mr1621009plc.10.1624045635401;
        Fri, 18 Jun 2021 12:47:15 -0700 (PDT)
Received: from [2620:15c:17:3:3a6:a5d0:1984:a150] ([2620:15c:17:3:3a6:a5d0:1984:a150])
        by smtp.gmail.com with ESMTPSA id s1sm9601820pgg.49.2021.06.18.12.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 12:47:14 -0700 (PDT)
Date:   Fri, 18 Jun 2021 12:47:13 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 1/2] mm/vmalloc: add vmalloc_no_huge
In-Reply-To: <20210614132357.10202-2-imbrenda@linux.ibm.com>
Message-ID: <1ab3bba4-dc91-4f8-ecd5-b18b17ec6d8@google.com>
References: <20210614132357.10202-1-imbrenda@linux.ibm.com> <20210614132357.10202-2-imbrenda@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 14 Jun 2021, Claudio Imbrenda wrote:

> Commit 121e6f3258fe3 ("mm/vmalloc: hugepage vmalloc mappings") added
> support for hugepage vmalloc mappings, it also added the flag
> VM_NO_HUGE_VMAP for __vmalloc_node_range to request the allocation to
> be performed with 0-order non-huge pages.  This flag is not accessible
> when calling vmalloc, the only option is to call directly
> __vmalloc_node_range, which is not exported.
> 
> This means that a module can't vmalloc memory with small pages.
> 
> Case in point: KVM on s390x needs to vmalloc a large area, and it needs
> to be mapped with non-huge pages, because of a hardware limitation.
> 
> This patch adds the function vmalloc_no_huge, which works like vmalloc,
> but it is guaranteed to always back the mapping using small pages. This
> new function is exported, therefore it is usable by modules.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Acked-by: Nicholas Piggin <npiggin@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Christoph Hellwig <hch@infradead.org>

Acked-by: David Rientjes <rientjes@google.com>
