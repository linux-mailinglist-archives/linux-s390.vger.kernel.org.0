Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4931F30146
	for <lists+linux-s390@lfdr.de>; Thu, 30 May 2019 19:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfE3RyD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 May 2019 13:54:03 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:32828 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfE3RyC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 May 2019 13:54:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id n17so10345495edb.0
        for <linux-s390@vger.kernel.org>; Thu, 30 May 2019 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlYOqgGgItn5hucl8pZOYZeRpF+/j+lyZEX0rN4v98g=;
        b=LYlHNdAV/SNBSa2OU1jdHVGlps7i+f4ToRjbTl9D2wFgpxOnqYU6L0tHRyBKqXN8PS
         bA20mdUlqFwilW74sDweWwxCRjLlo9fuLRBJptvvxIq+vYgZ96pbtG7pADnxLsZ5u6Ed
         xa3CEpbgxATF5V1HpcSCSGovWdI7wIoti8PlUbQ7uPq+eFKDXrzPzbDKxcOs/rbfxHdW
         3wcYT/Y0vSetxxTI7PMr+4dEKBZMAaPHqAJ4cafp6No1HT2gZdPpzYTqxY9BWFqu5i8v
         c8SEsw9ZPMpf8Cmj587OTzTy+La1UCwO9pu1FiOK6SpUJ9aeYM0ra8QLMjn3GNWlh/JN
         PXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlYOqgGgItn5hucl8pZOYZeRpF+/j+lyZEX0rN4v98g=;
        b=hJTx8ReQWr14eQJs0byOYZxK51Ua2HWhmwRxtMt0z9ZSleeoEVYXy7s5Oo6m7SCtCp
         sZjV3CJJqWr9Dz+/lXj6YKffyzQY6lYHnQ5+zj3U+1cqmpWoY+mnVppaC8Wh1g7DZln7
         4kbNmrZrXi1rjcUC7H6Hf13Y5tuupNk08apvqUNaQndKV2K+YhHDE2DByme+PWLck+6E
         2BjccoqfgviJWCxCZ0RAQTv6KqTVoLIMkXU3uk8rpI+1fuHikHowY1LYyZb63zIzxXmw
         ZjS4+6XCsEULxHuqAWPNNfqXE+TJcz2zPlwRue0y04138MOUuKyJi3l3kmBHnrkahIPC
         rINA==
X-Gm-Message-State: APjAAAXmzryQG1U8QArinVqCc/RW1Bu+waN6GKwIwY5mFDdx0FH2+1/n
        fLzOLz4+8j+/hnEmGDeYh9ci5ox2oM3/qZ6XwfRJ7w==
X-Google-Smtp-Source: APXvYqxJpnEky/HQoCMiqMXy5GPOyKza2hJ+52II0wfo1HpL9rVDxjuGoL3UWKguhdIYjncFwf0xnjjAWLfB3JRkG5w=
X-Received: by 2002:a17:906:a354:: with SMTP id bz20mr4932536ejb.209.1559238840892;
 Thu, 30 May 2019 10:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190527111152.16324-1-david@redhat.com> <20190527111152.16324-2-david@redhat.com>
In-Reply-To: <20190527111152.16324-2-david@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 May 2019 13:53:50 -0400
Message-ID: <CA+CK2bBW4vH+J6bam1dOxjSwFwvoOEok0VNO0n_JjyHxpkGj+A@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] mm/memory_hotplug: Simplify and fix check_hotplug_memory_range()
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 27, 2019 at 7:12 AM David Hildenbrand <david@redhat.com> wrote:
>
> By converting start and size to page granularity, we actually ignore
> unaligned parts within a page instead of properly bailing out with an
> error.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
