Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEB82C46B8
	for <lists+linux-s390@lfdr.de>; Wed, 25 Nov 2020 18:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgKYR1d (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 25 Nov 2020 12:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730653AbgKYR1d (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Nov 2020 12:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606325251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=128QzWN5ZV6H8TGg9AgMhcOfUvIwMfuRP45rtKXIJzc=;
        b=IFy6WZPhFFrp/NBGH5ZbRm8E4UFDbzgpuK7LsSXBKFWxpSXek7fEgUpGUsrNO5O3w9h3at
        fU1EynJb91uPE6ndTXQUyNtKfrghjHt8mE5FgaD6n3Yd/X4OoRwkQfxLoxtYbo0dXcC83v
        ej+jBEJL1RfSUr1+xf9JOjXI7W88UcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-VZlW4DNdMHaUwzfL9ixwkA-1; Wed, 25 Nov 2020 12:27:24 -0500
X-MC-Unique: VZlW4DNdMHaUwzfL9ixwkA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95D7D1087D6C;
        Wed, 25 Nov 2020 17:27:20 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18B3260BE5;
        Wed, 25 Nov 2020 17:27:18 +0000 (UTC)
Subject: Re: [RFC 3/3] s390/mm: Define arch_get_addressable_range()
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <fc5ebaf9-ce6a-95fd-a2fe-84bfdf73512a@redhat.com>
Date:   Wed, 25 Nov 2020 18:27:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.11.20 03:28, Anshuman Khandual wrote:
> This overrides arch_get_addressable_range() on s390 platform and drops
> now redudant similar check in vmem_add_mapping().
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: linux-s390@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/s390/include/asm/mmu.h |  2 ++
>  arch/s390/mm/vmem.c         | 16 ++++++++++++----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
> index e12ff0f29d1a..f92d3926b188 100644
> --- a/arch/s390/include/asm/mmu.h
> +++ b/arch/s390/include/asm/mmu.h
> @@ -55,4 +55,6 @@ static inline int tprot(unsigned long addr)
>  	return rc;
>  }
>  
> +#define arch_get_addressable_range arch_get_addressable_range
> +struct range arch_get_addressable_range(bool need_mapping);
>  #endif
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b0..e03ad0ed13a7 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -532,14 +532,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>  	mutex_unlock(&vmem_mutex);
>  }
>  
> +struct range arch_get_addressable_range(bool need_mapping)
> +{
> +	struct range memhp_range;
> +
> +	memhp_range.start = 0;
> +	if (need_mapping)
> +		memhp_range.end =  VMEM_MAX_PHYS;
> +	else
> +		memhp_range.end = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
> +	return memhp_range;
> +}
> +
>  int vmem_add_mapping(unsigned long start, unsigned long size)
>  {
>  	int ret;
>  
> -	if (start + size > VMEM_MAX_PHYS ||
> -	    start + size < start)
> -		return -ERANGE;
> -
>  	mutex_lock(&vmem_mutex);
>  	ret = vmem_add_range(start, size);
>  	if (ret)
> 

Note that vmem_add_mapping() is also called from extmem
(arch/s390/mm/extmem.c).

-- 
Thanks,

David / dhildenb

