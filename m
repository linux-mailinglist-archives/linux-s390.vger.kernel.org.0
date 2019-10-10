Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F9D1ED3
	for <lists+linux-s390@lfdr.de>; Thu, 10 Oct 2019 05:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbfJJDPg (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Oct 2019 23:15:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:51238 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbfJJDPg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Oct 2019 23:15:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 20:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,278,1566889200"; 
   d="scan'208";a="223801015"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 20:15:32 -0700
Date:   Thu, 10 Oct 2019 11:15:16 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash on
 s390
Message-ID: <20191010031516.GA5060@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <1570656570.5937.24.camel@lca.pw>
 <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
 <20191010023601.GA4793@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010023601.GA4793@richard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 10, 2019 at 10:36:01AM +0800, Wei Yang wrote:
>Hi, Qian, Shakeel
>
>Thanks for testing.
>
>Sounds I missed some case to handle. anon_vma_clone() now would be called in
>vma_adjust, which is a different case when it is introduced.
>

Well, I have to correct my statement. The reason is we may did something more
in anon_vma_clone().

Here is a quick fix, while I need to go through all the cases carefully.

diff --git a/mm/rmap.c b/mm/rmap.c
index 12f6c3d7fd9d..2844f442208d 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -271,7 +271,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
         * 1. Parent has vm_prev, which implies we have vm_prev.
         * 2. Parent and its vm_prev have the same anon_vma.
         */
-       if (pprev && pprev->anon_vma == src->anon_vma)
+       if (!dst->anon_vma && pprev && pprev->anon_vma == src->anon_vma)
                dst->anon_vma = prev->anon_vma;
 
        list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {

>BTW, do you have the specific test case? So that I could verify my change. The
>kernel build test doesn't trigger this.
>
>Thanks a lot :-)
>
>On Wed, Oct 09, 2019 at 03:21:11PM -0700, Shakeel Butt wrote:
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
