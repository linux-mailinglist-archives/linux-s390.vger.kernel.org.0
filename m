Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE77364F2
	for <lists+linux-s390@lfdr.de>; Tue, 20 Jun 2023 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjFTHlm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 20 Jun 2023 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjFTHlR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Jun 2023 03:41:17 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC721FC4
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:40:14 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5702116762fso49450837b3.3
        for <linux-s390@vger.kernel.org>; Tue, 20 Jun 2023 00:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687246813; x=1689838813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xgtva00uaRjPQjQYWCbyYlUVerqtzlz4H3/JM5nRsA=;
        b=0LMD2/Bp9LkZIBYgPbN4jKWx5l3xqsV5p+9EAezDq6xR/SWmyYTEAe1FdDy1xbMmRb
         H8PBsbrNU4fYI4mKZfhyMwB/CU4nG5b31JuXXrIAyWt0sajI0olzTibXN+ktWNYF0oep
         x0ccngPNp6kQepRw/XRcKOWVrIwm+WEupexqrFO6FFWjiu1SlHy8yMCBdGb2CGeJXPQe
         rQ6klP2gqbiJAoxVWslA7bD8MQXYp6OVctc8Pm9x7E9rZqqXloCfaCSI/DExJxOsqSJT
         4d6fjthovhopd44fEKacEstPh46MmIG/u5ZNkKED0IyMDYNloqJ4rKSwMXR8oHsnZsZm
         /6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687246813; x=1689838813;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Xgtva00uaRjPQjQYWCbyYlUVerqtzlz4H3/JM5nRsA=;
        b=eZ3Otq8j30zNDh7QSXrS3Rs2fTVtlTJQxqjuduy8sFrpo5enmvJaXNi/iiiGSy7sy9
         JbdE4uqF+npd/nayuyne0qhuv6idP6/jV0sH0khmg9liHWuiNDfQb6y8vQJvnFnySLmb
         DEkT6YX3K8/BSFrmJoA0RW6jchvI2RN/C2UJ5W9XHYf2TrNHMxU9DmSkCQm4iBSJ/rcq
         3S5XB3M2szj1EuFDuCBgfAhAKymZQ5LMrQ0s9pvdsVP+kXfHRbgwdGs2SJ2ryMLZvNje
         BxT0/gm2SyihPz/5gjjzES89riS7JnZ19t60/QIbaCOEJJTgM24Z/p8w638T7j9b9JIX
         HL8A==
X-Gm-Message-State: AC+VfDzeHpIm+FN8Epcksq6i7hbGwLdeqALdxfN1UKHPQFloxYNabfbW
        +TAI/O7HpaJ8jtHBoqyE5LjGTA==
X-Google-Smtp-Source: ACHHUZ75OBuUzMptMwBPGDkg2ahPnjw/MJzrATJW6OVlCqaB4pyoJIMCLPp7Z4SL32qkhEKJol5B6w==
X-Received: by 2002:a81:75d6:0:b0:56d:b98:cc16 with SMTP id q205-20020a8175d6000000b0056d0b98cc16mr13330173ywc.45.1687246813120;
        Tue, 20 Jun 2023 00:40:13 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x8-20020a817c08000000b005623ae13106sm368166ywc.100.2023.06.20.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 00:40:12 -0700 (PDT)
Date:   Tue, 20 Jun 2023 00:40:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Gerald Shaefer <gerald.schaefer@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Yang Shi <shy828301@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Xu <peterx@redhat.com>,
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
        Jann Horn <jannh@google.com>,
        Vishal Moola <vishal.moola@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 01/12] mm/pgtable: add rcu_read_lock() and
 rcu_read_unlock()s
In-Reply-To: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
Message-ID: <53514a65-9053-1e8a-c76a-c158f8965@google.com>
References: <54cb04f-3762-987f-8294-91dafd8ebfb0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Before putting them to use (several commits later), add rcu_read_lock()
to pte_offset_map(), and rcu_read_unlock() to pte_unmap().  Make this a
separate commit, since it risks exposing imbalances: prior commits have
fixed all the known imbalances, but we may find some have been missed.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 include/linux/pgtable.h | 4 ++--
 mm/pgtable-generic.c    | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index a1326e61d7ee..8b0fc7fdc46f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -99,7 +99,7 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
 #define pte_unmap(pte)	do {	\
 	kunmap_local((pte));	\
-	/* rcu_read_unlock() to be added later */	\
+	rcu_read_unlock();	\
 } while (0)
 #else
 static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
@@ -108,7 +108,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 }
 static inline void pte_unmap(pte_t *pte)
 {
-	/* rcu_read_unlock() to be added later */
+	rcu_read_unlock();
 }
 #endif
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c7ab18a5fb77..674671835631 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -236,7 +236,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
 	pmd_t pmdval;
 
-	/* rcu_read_lock() to be added later */
+	rcu_read_lock();
 	pmdval = pmdp_get_lockless(pmd);
 	if (pmdvalp)
 		*pmdvalp = pmdval;
@@ -250,7 +250,7 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 	}
 	return __pte_map(&pmdval, addr);
 nomap:
-	/* rcu_read_unlock() to be added later */
+	rcu_read_unlock();
 	return NULL;
 }
 
-- 
2.35.3

