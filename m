Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F8255C45
	for <lists+linux-s390@lfdr.de>; Fri, 28 Aug 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgH1OVm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 28 Aug 2020 10:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgH1OVj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Aug 2020 10:21:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898A0C061264
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j10so440902qvo.13
        for <linux-s390@vger.kernel.org>; Fri, 28 Aug 2020 07:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTI6+GkcETTpHWIvvBypzVxQQpyEAhXbsVHo/bIanMg=;
        b=N8KwPRQVWfqwX32CjhM1MWZNedWHxDfw6QHu2eKgwvj9vZXqN5mcjL5D9YkLqZDqct
         qVdRY6y2fQd5JqyhniJ/tWcO1kt9vPsrCbbIbQXo+iG2GLNyJPMdkKtsmiuk9BxGJtim
         sYY782s/qFCyOcqJnIfqSkt3Mey4xuCjGbAzCME0dqtOf9yt+Oh3qnkDrmC2ueY6rOxF
         W9/Ocv6Pq7/EYz8n7ZAcDH/9kMa9jBAWYr0uJcvBCbv9K3HdEAlny7to5qpZ6rD9BmS+
         aeSPb8vfkGvF2XTgF18OVl35YbtXeH/Z5hi33XQem9U/qSlsPnsyh8Mw6NQ/8rFoA4iI
         qCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTI6+GkcETTpHWIvvBypzVxQQpyEAhXbsVHo/bIanMg=;
        b=ljsJ/rCW02AnsqmNngN/e/et36n9n2QlTuHU5EdeO3SM+X/5D0v7qNu5pQYfqO1AvP
         qTKmI9cT9mar5hLko4A/yeT07uAk/LlTpqkDEfKxLGKxFtpLY9kBTuczy1w7sf5nMkN1
         vCWXJq05zDA9tmJI64Gw7d38eTd3NiMPYH+v6upPYjNzYpBMOThiAem7GzKIiU9+Jpo9
         fe4q1fDUULPpzTJWQpW2eWYqluAWQZkJpYpe3gK0s6+Mv0fdJXWxZbufy40viiaEpzvr
         KYrIypsYav6vpWv4V9N4dVXIMY6HDEj5Hb0ZhuPF8rDGGG2pQHyu2FI/i5VJiQJZBU3z
         Ijcw==
X-Gm-Message-State: AOAM531gcCE+qBlU/HimtlYDO+PEzLPcTe05B1B351lOUB/kJmBiYaAz
        LFgneUfPdOG/J3g+XUu2IQcuVw==
X-Google-Smtp-Source: ABdhPJyEOuyU0xtQdqC+cKFxXBrGrcvFZATJ82c4w6FNraYAEqPXVCLM//u0MJDGSkHpJPB93i0WeA==
X-Received: by 2002:a05:6214:184a:: with SMTP id d10mr1927526qvy.190.1598624498625;
        Fri, 28 Aug 2020 07:21:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m17sm931967qkn.45.2020.08.28.07.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:21:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBfG5-000hDT-3F; Fri, 28 Aug 2020 11:21:37 -0300
Date:   Fri, 28 Aug 2020 11:21:37 -0300
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
Message-ID: <20200828142137.GX24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 28, 2020 at 04:03:12PM +0200, Gerald Schaefer wrote:
> Commit 1a42010cdc26 ("s390/mm: convert to the generic get_user_pages_fast
> code") introduced a subtle but severe bug on s390 with gup_fast, due to
> dynamic page table folding.

I think the page walk code in mm/pagewalk.c has similar issues to
GUP. I've been noodling on some patches to add the missing stack
copies to pagewalk.c as they are clearly missing..

It would be good if this could be less GUP specific?

Generically this is about walking the page table without holding the
page table spinlocks using READ_ONCE.

Jason
