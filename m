Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B086C0DC1
	for <lists+linux-s390@lfdr.de>; Fri, 27 Sep 2019 23:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728323AbfI0V7r (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 27 Sep 2019 17:59:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfI0V7r (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Sep 2019 17:59:47 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883312082F;
        Fri, 27 Sep 2019 21:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569621586;
        bh=PK8b13bjmCsYmkQdL08hbsEZcnCC+UVSudjG9MgcJqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a1EB0Jfk92b0u0UZlXn9Ms6VE7tfNDsGyOhdTEi2indVTH6LqicuYWehBpKyOixpL
         4GjhxvGnOHFSvnyZYMtfBI075kUoLSNyt9xjKEpVsHG1iMffAJTUwuRoJXMVQXSJ05
         b31eGiIpCPoWnl3EdifTimDezcotfBvLvJNYqdcU=
Date:   Fri, 27 Sep 2019 14:59:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, linux-s390@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Message-Id: <20190927145945.846a3f3405d3af066827d3f5@linux-foundation.org>
In-Reply-To: <1569619686.5576.242.camel@lca.pw>
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
        <20190927140222.6f7d0a41b9e734053ee911b9@linux-foundation.org>
        <1569619686.5576.242.camel@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 27 Sep 2019 17:28:06 -0400 Qian Cai <cai@lca.pw> wrote:

> >=20
> > So I think you've moved the arch_free_page() to be after the final
> > thing which can access page contents, yes?  If so, we should have a
> > comment in free_pages_prepare() to attmept to prevent this problem from
> > reoccurring as the code evolves?
>=20
> Right, something like this above arch_free_page() there?
>=20
> /*
>  * It needs to be just above=A0kernel_map_pages(), as s390 could mark tho=
se
>  * pages unused and then trigger a fault when accessing.
>  */

I did this.

--- a/mm/page_alloc.c~mm-page_alloc-fix-a-crash-in-free_pages_prepare-fix
+++ a/mm/page_alloc.c
@@ -1179,7 +1179,13 @@ static __always_inline bool free_pages_p
 		kernel_init_free_pages(page, 1 << order);
=20
 	kernel_poison_pages(page, 1 << order, 0);
+	/*
+	 * arch_free_page() can make the page's contents inaccessible.  s390
+	 * does this.  So nothing which can access the page's contents should
+	 * happen after this.
+	 */
 	arch_free_page(page, order);
+
 	if (debug_pagealloc_enabled())
 		kernel_map_pages(page, 1 << order, 0);
=20
_

