Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2228AA4B
	for <lists+linux-s390@lfdr.de>; Sun, 11 Oct 2020 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgJKUXY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 11 Oct 2020 16:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgJKUXX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 11 Oct 2020 16:23:23 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DDC0613D7
        for <linux-s390@vger.kernel.org>; Sun, 11 Oct 2020 13:23:17 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id q21so13951144ota.8
        for <linux-s390@vger.kernel.org>; Sun, 11 Oct 2020 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tRceXdKhB8YrGa5UF3V+9BiDoHJDhSAujZzJPaxD6i8=;
        b=se4EGX91wXk2NZMva6HzFZt9bCZz8RMcBbrzoCXtUq3w7fZQ1NYTEx0+dle/di2F1+
         UMlSTWzAs2o5+wpceMyNbEGN2hTYHQpNNfyByKl5nEcsn66SyilMSjwsZ4cGPfkmBdYF
         yp6Nw97A01gYD5ub1/INhnhY970Z/HlYmbvK/LaNIIE3sBoaVVhmmclnwCCPgaULh6vY
         IxIhvUHsa77LoIoogl9eveMNpldGFUGa3mjyOxtKDwI1N8AyBQEUvYbZyS6WJk8fkRN4
         /evvAYdtKBs0YAniCPIKXpFnj29oVuIWyLaL/rGXSXn8Gch+kyM/AJyBMyFmUyuNfgxn
         vslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=tRceXdKhB8YrGa5UF3V+9BiDoHJDhSAujZzJPaxD6i8=;
        b=ReImwAL864gdmZ8SViWlzUMFarvhVHtDixbIHPqpHk5LjEyl+HOYJTJt8L/mj8XHdf
         UCBhkeU6sicMFXl7TNhVzDM16Rd/TF5Kxgt7TU3NwcH31Ew4qWC2uiVFw0qixCPVMwPt
         BCs6dMpg/LDT2n5lF8YyX5qN+3rcUGp6YIwrhmijljV83/O4x72JmUskJeRoWgUJr/Ox
         t2nm61EGLa0pi3TEjQdP+sdU2ncueMzV72f5BYiKB9NE3bOr7TV1V1vOy6n0ck+44Viz
         v0Yqq21UJo3XsnzJzoPBPoQU9cVA+cgmA+PHW2vBl1i3znUuty+dqwp8mIzVTEewFV06
         DV2Q==
X-Gm-Message-State: AOAM532YvSwgmWclC/mf2Itb2EbQIewAXneAyQY2quwAKkTuElnr1pvr
        JdeD+Z/AVagoE74rXmG26nLbig==
X-Google-Smtp-Source: ABdhPJxJevS9phfHNPbujhgUz0c2zM32mOg8hpn2iOLSemBV/AGaC7PVIMJ1K7/V4AWK3zP1Bm9Msg==
X-Received: by 2002:a05:6830:149:: with SMTP id j9mr15110595otp.187.1602447796574;
        Sun, 11 Oct 2020 13:23:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j34sm8210899otc.15.2020.10.11.13.23.14
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 11 Oct 2020 13:23:15 -0700 (PDT)
Date:   Sun, 11 Oct 2020 13:23:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <cai@lca.pw>
cc:     Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        borntraeger@de.ibm.com, darrick.wong@oracle.com,
        kirill@shutemov.name, peterx@redhat.com,
        yang.shi@linux.alibaba.com, hch@lst.de,
        linux-kernel@vger.kernel.org, songliubraving@fb.com
Subject: Re: VM_BUG_ON_PAGE(page_to_pgoff(page) != offset) on s390
In-Reply-To: <20200617031906.GA5065@lca.pw>
Message-ID: <alpine.LSU.2.11.2010111321430.15963@eggly.anvils>
References: <20200616013309.GB815@lca.pw> <20200616014859.GY8681@bombadil.infradead.org> <20200617031906.GA5065@lca.pw>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Adding a note to update this thread: the v5.9 tree now has
033b5d775511 ("mm/khugepaged: fix filemap page_to_pgoff(page) != offset")
which fixes this VM_BUG_ON_PAGE (or data corruption) when CONFIG_NUMA
is not set: we are hoping that may have have been the problem here.
