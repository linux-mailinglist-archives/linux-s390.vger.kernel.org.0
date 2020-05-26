Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEBC19FC75
	for <lists+linux-s390@lfdr.de>; Mon,  6 Apr 2020 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDFSGK (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Apr 2020 14:06:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56361 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbgDFSGK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Apr 2020 14:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586196368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zq2fOqfpnunCJPcnhnd4EahDTvQRSHEmjDBqkQFoh48=;
        b=BFyOEScHpbMwsvffNWwXQ8xSpc0r/vw4lrlRclPvwDRBuc5lfz5/TmGm5iLb+FmWdx+orb
        KOcaPcXNV9eNQND8VzIQyrk0ha6NT0N2Wtapt/tWzwWvk1RBGQOsGir9IotSW+vjCOesRd
        qqQUq4ba7ZzWMsRJ1EP8PllIH0lKZjc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-9IFO8revMOGTFSMvkfK3YQ-1; Mon, 06 Apr 2020 14:06:03 -0400
X-MC-Unique: 9IFO8revMOGTFSMvkfK3YQ-1
Received: by mail-qt1-f200.google.com with SMTP id n89so574295qte.15
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2020 11:06:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zq2fOqfpnunCJPcnhnd4EahDTvQRSHEmjDBqkQFoh48=;
        b=QP0McKWC4Wd9V5kwW5MJWzABUqD3/gd3C574QFhz5tyt/yrxqNLXsIoiaWwjEqO9Hs
         ouAV1kkVn6HR0hkrHw5Yox5TeGd/8PUnldz1E9ABZChXzn0SW6/3BuHPNvPK/ztBflND
         jY2GhQEivEdamcXMKi8D4pKeRWjbLGDSfjLnIG1Y/10hvWjw7BYfr+Bls09l1Ev7rJcy
         j7naRWp6Agza5m0VxzeATLNcwAoT/z3UpMR7CK86Z/5Mgitflp00D782J1AFZ9a29w/I
         vpVq3bJznYNbWabmBOFgKtMZYH5FIFcCbddczO1mJfklOo4CN8f/E46fXhtuJ/Bpvoph
         XoZg==
X-Gm-Message-State: AGi0PubRVZrfNEy0VLF4J5fgA/q9oV5vdaX5XptVxmjAU7yYFnpSUiSw
        0RjRnFWi8kSZFE+UWywLsmWVWdREvrwwQjkx5vfKbh/4KMO1xJHk00j9K5xAZQkqT7giJRu2sEJ
        B6u41AXahBJg6ppI95YUB2Q==
X-Received: by 2002:ac8:2a68:: with SMTP id l37mr698227qtl.77.1586196361387;
        Mon, 06 Apr 2020 11:06:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypLEox3UX8MCeX0tOeCXIrNeXeiRB52F4QJf5RdYuk+NCD4GaAPnvAscpKxCIJDbeDpCWYGZow==
X-Received: by 2002:ac8:2a68:: with SMTP id l37mr698198qtl.77.1586196361085;
        Mon, 06 Apr 2020 11:06:01 -0700 (PDT)
Received: from dev.jcline.org ([136.56.87.133])
        by smtp.gmail.com with ESMTPSA id s26sm14862683qkm.114.2020.04.06.11.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 11:06:00 -0700 (PDT)
Date:   Mon, 6 Apr 2020 14:05:58 -0400
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Michal Kubecek <mkubecek@suse.cz>,
        Philipp Rudo <prudo@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: add dummy toolchains to enable all cc-option
 etc. in Kconfig
Message-ID: <20200406180558.GA22412@dev.jcline.org>
References: <20200403090224.24045-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403090224.24045-1-masahiroy@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Apr 03, 2020 at 06:02:24PM +0900, Masahiro Yamada wrote:
> Staring v4.18, Kconfig evaluates compiler capabilities, and hides CONFIG
> options your compiler does not support. This works well if you configure
> and build the kernel on the same host machine.
> 
> It is inconvenient if you prepare the .config that is carried to a
> different build environment (typically this happens when you package
> the kernel for distros) because using a different compiler potentially
> produces different CONFIG options than the real build environment.
> So, you probably want to make as many options visible as possible.
> In other words, you need to create a super-set of CONFIG options that
> cover any build environment. If some of the CONFIG options turned out
> to be unsupported on the build machine, they are automatically disabled
> by the nature of Kconfig.
> 
> However, it is not feasible to get a full-featured compiler for every
> arch.
> 
> This issue was discussed here:
> 
>   https://lkml.org/lkml/2019/12/9/620
> 
> Other than distros, savedefconfig is also a problem. Some arch subsytems
> periodically resync defconfig files. If you use a less-capable compiler
> for savedefconfig, options that do not meet 'depends on $(cc-option,...)'
> will be forcibly disabled. So, defconfig && savedefconfig may silently
> change the behavior.
> 
> This commit adds a set of dummy toolchains that pretend to support any
> feature.
> 
> Most of compiler features are tested by cc-option, which simply checks
> the exit code of $(CC). The dummy tools are just a shell script that
> exits with 0 in most cases. So, $(cc-option, ...) is evaluated as 'y'.
> 
> There are more complicated checks such as:
> 
>   scripts/gcc-x86_{32,64}-has-stack-protector.sh
>   scripts/gcc-plugin.sh
>   scripts/tools-support-relr.sh
> 
> I tried my best to implement the dummy scripts to pass all checks.
> 
> From the top directory of the source tree, you can do:
> 
>    $ make CROSS_COMPILE=scripts/dummy-tools/ oldconfig
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/dummy-tools/gcc     | 91 +++++++++++++++++++++++++++++++++++++
>  scripts/dummy-tools/ld      |  4 ++
>  scripts/dummy-tools/nm      |  4 ++
>  scripts/dummy-tools/objcopy |  4 ++
>  4 files changed, 103 insertions(+)
>  create mode 100755 scripts/dummy-tools/gcc
>  create mode 100755 scripts/dummy-tools/ld
>  create mode 100755 scripts/dummy-tools/nm
>  create mode 100755 scripts/dummy-tools/objcopy
> 

<snip>

> diff --git a/scripts/dummy-tools/ld b/scripts/dummy-tools/ld
> new file mode 100755
> index 000000000000..3bc56ae4cc15
> --- /dev/null
> +++ b/scripts/dummy-tools/ld
> @@ -0,0 +1,4 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# Dummy script that always succeeds

It looks like scripts/Kbuild.include expects "$(LD) --version" to return
something. If it doesn't "ld-ifversion" stops working.

Other than that it seems to work as advertised. Thanks!

- Jeremy

