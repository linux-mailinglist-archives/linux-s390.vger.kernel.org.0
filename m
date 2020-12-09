Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE152D3E54
	for <lists+linux-s390@lfdr.de>; Wed,  9 Dec 2020 10:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgLIJRI (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 9 Dec 2020 04:17:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727665AbgLIJRI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Dec 2020 04:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607505341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+rnz8YtChlioHEGnh6Vn+y7lnk3VwmtXCQpx8g+TACw=;
        b=QUZFps/c1c5Suq4fpN8S0re7yx/0LQ4P1G+c8EZzuCJIqAoCktK8/E1G1k27487FO3/ELE
        qkz0MGk550g8LywI6nm1fZe0oqRuyw2NNKYl92bYs72nBKmYl74id+3aojyRGsZywdjkMH
        D5eILUnr9vZJzBvUlL6st4Al8M3njKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Mu7P9TP0MpijyFF9K-GPDA-1; Wed, 09 Dec 2020 04:15:38 -0500
X-MC-Unique: Mu7P9TP0MpijyFF9K-GPDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC3AE1005513;
        Wed,  9 Dec 2020 09:15:36 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCA2A10016F5;
        Wed,  9 Dec 2020 09:15:35 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: lib: Move to GPL 2 and SPDX
 license identifiers
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20201208150902.32383-1-frankja@linux.ibm.com>
 <20201208150902.32383-3-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c236052c-598b-0d88-c80b-4bb2a999ec46@redhat.com>
Date:   Wed, 9 Dec 2020 10:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201208150902.32383-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08.12.20 16:09, Janosch Frank wrote:
> In the past we had some issues when developers wanted to use code
> snippets or constants from the kernel in a test or in the library. To
> remedy that the s390x maintainers decided to move all files to GPL 2
> (if possible).
> 
> At the same time let's move to SPDX identifiers as they are much nicer
> to read.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm-offsets.c     | 4 +---
>  lib/s390x/asm/arch_def.h    | 4 +---
>  lib/s390x/asm/asm-offsets.h | 4 +---
>  lib/s390x/asm/barrier.h     | 4 +---
>  lib/s390x/asm/cpacf.h       | 1 +
>  lib/s390x/asm/facility.h    | 4 +---
>  lib/s390x/asm/float.h       | 4 +---
>  lib/s390x/asm/interrupt.h   | 4 +---
>  lib/s390x/asm/io.h          | 4 +---
>  lib/s390x/asm/mem.h         | 4 +---
>  lib/s390x/asm/page.h        | 4 +---
>  lib/s390x/asm/pgtable.h     | 4 +---
>  lib/s390x/asm/sigp.h        | 4 +---
>  lib/s390x/asm/spinlock.h    | 4 +---
>  lib/s390x/asm/stack.h       | 4 +---
>  lib/s390x/asm/time.h        | 4 +---
>  lib/s390x/css.h             | 4 +---
>  lib/s390x/css_dump.c        | 4 +---
>  lib/s390x/css_lib.c         | 4 +---
>  lib/s390x/interrupt.c       | 4 +---
>  lib/s390x/io.c              | 4 +---
>  lib/s390x/mmu.c             | 4 +---
>  lib/s390x/mmu.h             | 4 +---
>  lib/s390x/sclp-console.c    | 5 +----
>  lib/s390x/sclp.c            | 4 +---
>  lib/s390x/sclp.h            | 5 +----
>  lib/s390x/smp.c             | 4 +---
>  lib/s390x/smp.h             | 4 +---
>  lib/s390x/stack.c           | 4 +---
>  lib/s390x/vm.c              | 3 +--
>  lib/s390x/vm.h              | 3 +--
>  31 files changed, 31 insertions(+), 90 deletions(-)
> 
> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
> index 61d2658..ee94ed3 100644
> --- a/lib/s390x/asm-offsets.c
> +++ b/lib/s390x/asm-offsets.c
> @@ -1,11 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2017 Red Hat Inc
>   *
>   * Authors:
>   *  David Hildenbrand <david@redhat.com>
> - *
> - * This code is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Library General Public License version 2.
>   */
>  #include <libcflat.h>
>  #include <kbuild.h>
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index edc06ef..f3ab830 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -1,11 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2017 Red Hat Inc
>   *
>   * Authors:
>   *  David Hildenbrand <david@redhat.com>
> - *
> - * This code is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Library General Public License version 2.
>   */
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> diff --git a/lib/s390x/asm/asm-offsets.h b/lib/s390x/asm/asm-offsets.h
> index a6d7af8..bed7f8e 100644
> --- a/lib/s390x/asm/asm-offsets.h
> +++ b/lib/s390x/asm/asm-offsets.h
> @@ -1,10 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2017 Red Hat Inc
>   *
>   * Authors:
>   *  David Hildenbrand <david@redhat.com>
> - *
> - * This code is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Library General Public License version 2.
>   */
>  #include <generated/asm-offsets.h>
> diff --git a/lib/s390x/asm/barrier.h b/lib/s390x/asm/barrier.h
> index d862e78..8e2fd6d 100644
> --- a/lib/s390x/asm/barrier.h
> +++ b/lib/s390x/asm/barrier.h
> @@ -1,12 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (c) 2017 Red Hat Inc
>   *
>   * Authors:
>   *  Thomas Huth <thuth@redhat.com>
>   *  David Hildenbrand <david@redhat.com>
> - *
> - * This code is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU Library General Public License version 2.
>   */
>  #ifndef _ASM_S390X_BARRIER_H_
>  #define _ASM_S390X_BARRIER_H_
> diff --git a/lib/s390x/asm/cpacf.h b/lib/s390x/asm/cpacf.h
> index 2146a01..805fcf1 100644
> --- a/lib/s390x/asm/cpacf.h
> +++ b/lib/s390x/asm/cpacf.h
> @@ -1,3 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * CP Assist for Cryptographic Functions (CPACF)
>   *

This file was originally copied from Linux v4.13. So I'm wondering if
this should be

SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note

instead. Doesn't make a real difference in practice I guess?

-- 
Thanks,

David / dhildenb

