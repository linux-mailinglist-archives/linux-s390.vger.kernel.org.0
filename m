Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552FE1C0C37
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2020 04:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgEACi2 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 30 Apr 2020 22:38:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20505 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728050AbgEACi0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 22:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588300705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P8k2aTeCbIA0Pe5nqRNlnguJBbZob6iEKj+wNv40n6s=;
        b=OQjNORmsSLYYujNiIOWKWp3ybwru/UmntRHxje++DKPQ5vd6LZX5r+YQRZGeFs0D4yKYkO
        K4AfDlhZOGIeiASF7cErLGKhwFkOudTPowZhUkO4tFT7264qhKEXdT6RIPDXzwQWzWMCBu
        /Kss3WMvqsB47TmsomWDfB3lO+bf+ok=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-gtVbUUDQP0i4OE7to56APw-1; Thu, 30 Apr 2020 22:38:22 -0400
X-MC-Unique: gtVbUUDQP0i4OE7to56APw-1
Received: by mail-vk1-f200.google.com with SMTP id u190so4184214vke.0
        for <linux-s390@vger.kernel.org>; Thu, 30 Apr 2020 19:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8k2aTeCbIA0Pe5nqRNlnguJBbZob6iEKj+wNv40n6s=;
        b=nHSwc0gTjBht+NZColB/EkVF7mU9Y0opwKoeR981QJ14pzOlOQL/Ww/oYKLmR07DuV
         HXoRAIb3MmdmcROLoVBg70QOeUy8phR1J9L3Hw7lHEnNj3BomeacC3tubgJQXotWQK9L
         uKa4LuO7YLHzgL17MuCSRLJY9iKu1cztkKSMyChl1vkEDbQuF5Qcihqa0n5tVk7oMiwB
         yFzzuj16mEtZyxLlX0OxYtMXO73s7MyvDrGXqtqUSdqyj8SBVD3/FmrFTvfKqywO+55z
         +vxcx50Q2ri2RFGAmPR0VLHLfut0Vv81wTLC4sAz0x69G47YOgrGwIcYO0V8VFwyaXaw
         pldw==
X-Gm-Message-State: AGi0PualEgCawzAR7mzMXCLHZJpky7rMX6Xg88DRsDofJMB79kBNB2k4
        A5MdteMiS6NAkY8nhV2yEyysWjALCUH5/7mR3Z8+N+WFP48iiVaYVxWfPBWmH8HYTsXgGiZwErN
        CzHcgRDGIO9GOQYy1/xkdrPc/Ygd91Kjm18MntQ==
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr1848892vsp.198.1588300701706;
        Thu, 30 Apr 2020 19:38:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKu6ClZ61atP80MD4lQJkn2FtP3gZkiC+YuTXU2rwKV21SshkG1nW93zQxISm3Y7jRVOl6JpuyIYF8Yu55j3FA=
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr1848869vsp.198.1588300701546;
 Thu, 30 Apr 2020 19:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200414131348.444715-1-hch@lst.de> <20200414131348.444715-22-hch@lst.de>
 <20200414151344.zgt2pnq7cjq2bgv6@debian> <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
In-Reply-To: <CAMeeMh8Q3Od76WaTasw+BpYVF58P-HQMaiFKHxXbZ_Q3tQPZ=A@mail.gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 30 Apr 2020 22:38:10 -0400
Message-ID: <CAMeeMh_9N0ORhPM8EmkGeeuiDoQY3+QoAPX5QBuK7=gsC5ONng@mail.gmail.com>
Subject: Re: [PATCH 21/29] mm: remove the pgprot argument to __vmalloc
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>, x86@kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laura Abbott <labbott@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        bpf@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Gao Xiang <xiang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

>> On Tue, Apr 14, 2020 at 03:13:40PM +0200, Christoph Hellwig wrote:
>> > The pgprot argument to __vmalloc is always PROT_KERNEL now, so remove
>> > it.

Greetings;

I recently noticed this change via the linux-next tree.

It may not be possible to edit at this late date, but the change
description refers to PROT_KERNEL, which is a symbol which does not
appear to exist; perhaps PAGE_KERNEL was meant? The mismatch caused me
and a couple other folks some confusion briefly until we decided it
was supposed to be PAGE_KERNEL; if it's not too late, editing the
description to clarify so would be nice.

Many thanks.

John Dorminy

