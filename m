Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD09D7834E2
	for <lists+linux-s390@lfdr.de>; Mon, 21 Aug 2023 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHUV1g (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 21 Aug 2023 17:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHUV1f (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 21 Aug 2023 17:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489F712D
        for <linux-s390@vger.kernel.org>; Mon, 21 Aug 2023 14:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692653207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kc1lL9HfVMeZHEEA4arnyJkoU4jVLawdPSW/zCLOVpk=;
        b=g8PHI/G77N+BcCEErppR0F+43FEgw2yB/aqG5rL19NqVnRHgASwynobCReel63jdV6Z6/q
        Y2WOaf4AWRVTMTeLQpbaPp8yvTx2vIBoqGxw5yV/yBuULHYNnaqo21Cs0O6AcZOy+PWFsY
        JrpH31xky5AqOtcU6HRYU5HEP0gKcVU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-AnvNuFvwMy2Q7rIxSF_79g-1; Mon, 21 Aug 2023 17:26:45 -0400
X-MC-Unique: AnvNuFvwMy2Q7rIxSF_79g-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63c9463c116so10477646d6.0
        for <linux-s390@vger.kernel.org>; Mon, 21 Aug 2023 14:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653205; x=1693258005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc1lL9HfVMeZHEEA4arnyJkoU4jVLawdPSW/zCLOVpk=;
        b=KKh/FRap/xAgC/pKqaBFMGvWf+5jFOFK9/5j0UL3Utor82VwSmK6h+jIcVjmnug/Zj
         oqQE41dIxaHV0HCFyzwmy+8OUn9p/C+n4+A81ej7kgcrkbnKIjtzLvLgvavmfKQMF0D0
         MQjTvi416E9kT5ZOKFVfPQn25lTxirrRZtNZabOmqI9t0lrH72A39jkJbZJbZw2Wsrj4
         /QP2LOoLbqt54852SLWYlkeFYgAv32mrGxVDXlNvw+MjGSlWGFnfricTp3s8O/IeOt6T
         MBTL8KPH4KsDnVYWmVxvahTJBhd7I+RCoWZ5dAMCf5+VIwMVou45RAt4LTQyIust6O8j
         ODDA==
X-Gm-Message-State: AOJu0YwrmjoXr1bQyo8FFh01rlKNbYFpstnvbwiXGqqiScqAa52eB8JK
        aS6Sh7U2PogaKH1jefLXcqAEIaO2vkRo2fCCo8FUM0DQsQ/SsXb+SYgbvcLA7elu5Tbdp7bV2Pa
        5g0ZWZKkubqWS5NrDR6k0SQ==
X-Received: by 2002:ad4:5c63:0:b0:645:3c6:56ab with SMTP id i3-20020ad45c63000000b0064503c656abmr9748550qvh.1.1692653205297;
        Mon, 21 Aug 2023 14:26:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgtWCOPeUpEzGq/iv0oKzAPjh78y7co8OVUrk5dfltW9vOj/sBZqVpomm+P1HZkyDqvpN/4A==
X-Received: by 2002:ad4:5c63:0:b0:645:3c6:56ab with SMTP id i3-20020ad45c63000000b0064503c656abmr9748513qvh.1.1692653205030;
        Mon, 21 Aug 2023 14:26:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id d28-20020a0cb2dc000000b0063d0b792469sm3261672qvf.136.2023.08.21.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:26:44 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:26:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Steven Price <steven.price@arm.com>,
        SeongJae Park <sj@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Zack Rusin <zackr@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Song Liu <song@kernel.org>,
        Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        sparclinux@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH mm-unstable] mm/khugepaged: fix collapse_pte_mapped_thp()
 versus uffd
Message-ID: <ZOPWkS7joexET6q8@x1n>
References: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d31abf5-56c0-9f3d-d12f-c9317936691@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Aug 21, 2023 at 12:51:20PM -0700, Hugh Dickins wrote:
> Jann Horn demonstrated how userfaultfd ioctl UFFDIO_COPY into a private
> shmem mapping can add valid PTEs to page table collapse_pte_mapped_thp()
> thought it had emptied: page lock on the huge page is enough to protect
> against WP faults (which find the PTE has been cleared), but not enough
> to protect against userfaultfd.  "BUG: Bad rss-counter state" followed.
> 
> retract_page_tables() protects against this by checking !vma->anon_vma;
> but we know that MADV_COLLAPSE needs to be able to work on private shmem
> mappings, even those with an anon_vma prepared for another part of the
> mapping; and we know that MADV_COLLAPSE needs to work on shared shmem
> mappings which are userfaultfd_armed().  Whether it needs to work on
> private shmem mappings which are userfaultfd_armed(), I'm not so sure:
> but assume that it does.
> 
> Just for this case, take the pmd_lock() two steps earlier: not because
> it gives any protection against this case itself, but because ptlock
> nests inside it, and it's the dropping of ptlock which let the bug in.
> In other cases, continue to minimize the pmd_lock() hold time.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/linux-mm/CAG48ez0FxiRC4d3VTu_a9h=rg5FW-kYD5Rg5xo_RDBM0LTTqZQ@mail.gmail.com/
> Fixes: 1043173eb5eb ("mm/khugepaged: collapse_pte_mapped_thp() with mmap_read_lock()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

The locking is indeed slightly complicated.. but I didn't spot anything
wrong.

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

