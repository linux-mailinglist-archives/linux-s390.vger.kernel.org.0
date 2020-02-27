Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 261861724D2
	for <lists+linux-s390@lfdr.de>; Thu, 27 Feb 2020 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729677AbgB0RRH (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 27 Feb 2020 12:17:07 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37611 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729678AbgB0RRH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 27 Feb 2020 12:17:07 -0500
Received: by mail-qv1-f65.google.com with SMTP id ci20so1912105qvb.4
        for <linux-s390@vger.kernel.org>; Thu, 27 Feb 2020 09:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARo9Rla66Kxeu/Z2V78mx/ehDWu077QNPWdzDFxfOJY=;
        b=dth2WWWZKp9HGsnWrcnEGnyDwu2blK8iDXb8vLMtoeR2VaMJ3fz37+cGHyNAha/rWV
         dK1sGTg22oiYuz24KPwTF2AS2YzOdqQyu6b+TiUBCYZk9V0zbua+mDMo3YTMUSvN9nIT
         EMJKHUaXkpfsveCsIHveNriBa6Vtjb0vFsMy7lGIqEqrtAiZ99Xs/sQZQxUbkx1mzgHf
         AVJsII2Jxg233IpQwYAVVL3i04SYIDZ8pS2nl8aTFh1Sh2y4snmhOeu+kOn7LsejaKvN
         5rYQfvFElRSnuNIftRZI411+PoKrYCAMkJ59tu4Fy8L8tWs1KfJP0Uu0uqOwYZUWVb/k
         btJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARo9Rla66Kxeu/Z2V78mx/ehDWu077QNPWdzDFxfOJY=;
        b=gow4HCkxUiWNFbK7wYHAclKPH1B45YtLv8mNJ6k4UFyr9htqlhNB7p399KZuo9MUAT
         U8qXDhJ+z4dsKBQbmNTH7Mm81AxDCka8nVJqUhf8gJ/oDCFQyUW8OfMOkH8y8EDlvQ/Q
         wjI5VpRWA03Vp+QW8RgDIf/JkHv4/OYijQe9MVezhe4hdmmDjgHAUDcA3eaKG/PVSwf2
         eq5C7uIV7Zw92L7fvTNJ1V2UHUtzE3NtvfSikOvgJ7Z8r4ho/RESYnCJs98v6pxVFv6k
         ipj6eZdYzow7bUQP8UfPOT9NuB4SxNYBIQZ/Ps/l9drMj9BPIPeJl8Ipv99mYKxFRArk
         ovig==
X-Gm-Message-State: APjAAAULqsIw3vMviaKCVBjyAnfQPjhhmgUVozYMRxolHAAgY21EMgy8
        LiTJONQ+lzddC5AaZSl4W5Rjcw==
X-Google-Smtp-Source: APXvYqzIGS93ngPFOoj3vliIAB10vgE4M/ehyQsI06gG80887mNylpBqlEfVijkpuc5v919Oz9PGMQ==
X-Received: by 2002:ad4:5429:: with SMTP id g9mr757799qvt.134.1582823826213;
        Thu, 27 Feb 2020 09:17:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x14sm3375572qkf.99.2020.02.27.09.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 09:17:05 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j7MmW-0003YD-SC; Thu, 27 Feb 2020 13:17:04 -0400
Date:   Thu, 27 Feb 2020 13:17:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
Message-ID: <20200227171704.GK31668@ziepe.ca>
References: <20200221182503.28317-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221182503.28317-1-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 21, 2020 at 11:24:56AM -0700, Logan Gunthorpe wrote:
> Hi,
> 
> This is v3 of the patchset which cleans up a number of minor issues
> from the feedback of v2 and rebases onto v5.6-rc2. Additional feedback
> is welcome.
> 
> Thanks,
> 
> Logan
> 
> --
> 
> Changes in v3:
>  * Rebased onto v5.6-rc2
>  * Rename mhp_modifiers to mhp_params per David with an updated kernel
>    doc per Dan
>  * Drop support for s390 per David seeing it does not support
>    ZONE_DEVICE yet and there was a potential problem with huge pages.
>  * Added WARN_ON_ONCE in cases where arches recieve non PAGE_KERNEL
>    parameters
>  * Collected David and Micheal's Reviewed-By and Acked-by Tags
> 
> Changes in v2:
>  * Rebased onto v5.5-rc5
>  * Renamed mhp_restrictions to mhp_modifiers and added the pgprot field
>    to that structure instead of using an argument for
>    arch_add_memory().
>  * Add patch to drop the unused flags field in mhp_restrictions
> 
> A git branch is available here:
> 
> https://github.com/sbates130272/linux-p2pmem remap_pages_cache_v3
> 
> --
> 
> Currently, the page tables created using memremap_pages() are always
> created with the PAGE_KERNEL cacheing mode. However, the P2PDMA code
> is creating pages for PCI BAR memory which should never be accessed
> through the cache and instead use either WC or UC. This still works in
> most cases, on x86, because the MTRR registers typically override the
> caching settings in the page tables for all of the IO memory to be
> UC-. However, this tends not to work so well on other arches or
> some rare x86 machines that have firmware which does not setup the
> MTRR registers in this way.
> 
> Instead of this, this series proposes a change to arch_add_memory()
> to take the pgprot required by the mapping which allows us to
> explicitly set pagetable entries for P2PDMA memory to WC.

Is there a particular reason why WC was selected here? I thought for
the p2pdma cases there was no kernel user that touched the memory?

I definitely forsee devices where we want UC instead.

Even so, the whole idea looks like the right direction to me.

Jason
