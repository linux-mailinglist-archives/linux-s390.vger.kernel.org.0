Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4324AC1FBB
	for <lists+linux-s390@lfdr.de>; Mon, 30 Sep 2019 13:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfI3LEh (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 30 Sep 2019 07:04:37 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43796 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfI3LEh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 Sep 2019 07:04:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id r9so8206088edl.10
        for <linux-s390@vger.kernel.org>; Mon, 30 Sep 2019 04:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3k6dAmBoQBVj4O9ENLrppdo0K0+1hJqkhh7Nc8T2PGg=;
        b=X42lMnnx21hsZzUbXK4K09UEcg8JN5kUGkiMXkCDlre/ah2Vjy5ukUfyiQJ9TL4BTr
         wg0eMRd45KG/JAWicVc4DcRa5et4YZVgWbxDA6W780jF6mXEvBfN9R1Z+cdjsz1AgLQU
         C+Qlf7rbRk5HL+th7zt1WS+4nd9UMV6sW08hDwhpPubs00OvuT8UcGU+Yi/C07WIuoQ8
         fFfmYHnlI+YOYuBE+GJXTMr7AYNZPBT4y6ZgM1U1hYRWlhtKdJqS1prucSEPfByOd0gY
         FV7ztb9DXRvWYblRLvC3rDSEi3u8ZIZqj2cCGtoi34IBQ24x5S661NlVcVJMP5Sq2z7/
         Wwsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3k6dAmBoQBVj4O9ENLrppdo0K0+1hJqkhh7Nc8T2PGg=;
        b=DlEjtl7owhns5RYInj1QXmj0Vlij0YNAyqsGly+Bvn23uE6+PhVk+a+93iMkNA1+qA
         0GrApMIgZR5OooT6h2iNA8zU95ZP6uvlNFueUATHvZa0OEsbhexG6OweriWjcewzfgAB
         hSWJfmHeDkpF63Vrcf1fN0uLiOxJ+ZAEbCfkVVvsuVZh0cfNMi2KgL+olXEIR+tzoXU5
         mg4MFoOA1GxLQzYVnXs8E8X5B8MIygUZwc7s/4OgY00+NgfY3smcQFrq7ao0SIIIURQG
         x2SRSYJuSEpW400nmETQ6ZTqrkpuliiy4Hdq87nRpSvGh5OOrcovnOtFyezt1/njyjcX
         W53w==
X-Gm-Message-State: APjAAAUk3NGjL6pgb8N648jhXIklx2GNO71gYAZFB10//mNTCs9PqtXd
        1jHEO7r+U6qMn0BMHCXIl0RgLA==
X-Google-Smtp-Source: APXvYqy2PIFBcDe67nBH9RLsiz23AOO3Np3ANSt8QomqGwKLLjduWHQhucN8Jl+fY1ZvKnMFismhaw==
X-Received: by 2002:a05:6402:3d2:: with SMTP id t18mr18496910edw.136.1569841475915;
        Mon, 30 Sep 2019 04:04:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id 4sm1392570ejm.47.2019.09.30.04.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 04:04:35 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 633301020E6; Mon, 30 Sep 2019 14:04:34 +0300 (+03)
Date:   Mon, 30 Sep 2019 14:04:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: fix a crash in free_pages_prepare()
Message-ID: <20190930110434.5k47w7xfvkjcohkp@box>
References: <1569613623-16820-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569613623-16820-1-git-send-email-cai@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 27, 2019 at 03:47:03PM -0400, Qian Cai wrote:
> On architectures like s390, arch_free_page() could mark the page unused
> (set_page_unused()) and any access later would trigger a kernel panic.
> Fix it by moving arch_free_page() after all possible accessing calls.

Looks like Power also uses the hook. Have you check that this patch will
not affect Power?

-- 
 Kirill A. Shutemov
