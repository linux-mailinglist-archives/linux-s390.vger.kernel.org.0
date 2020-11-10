Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229DF2AD2A5
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgKJJlV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:41:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730164AbgKJJlV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605001280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MT6Q6Nj2H4sNmYfKL8LI82ClFp6tjg+I3AzElwbTe0g=;
        b=Dft1Bwi/h/NjNvr/TSSfevSwduMX6vWs9Beq/Xg8Y9oGWLwr15UfhzY7njoSX2BdRnnfoD
        7QwdB2E2bNGhABYMEzpmaiudAlUyZ5mSLJn7HG69qmNS/pKTXIljcM2qHvWrE4JSjoCVxq
        Kq5hq2hqV4U1r6S+Tj2MesijfZ3OqYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-ExUGVUGzNEKcFgl3sP2XaQ-1; Tue, 10 Nov 2020 04:41:18 -0500
X-MC-Unique: ExUGVUGzNEKcFgl3sP2XaQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8105809DE6;
        Tue, 10 Nov 2020 09:41:15 +0000 (UTC)
Received: from [10.36.114.232] (ovpn-114-232.ams2.redhat.com [10.36.114.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 036BB5C706;
        Tue, 10 Nov 2020 09:41:14 +0000 (UTC)
Subject: Re: [PATCH 2/3] s390/vmem: fix possible memory overwrite
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <aec7d80c-a7a1-d3db-9719-1ca69fb80887@redhat.com>
Date:   Tue, 10 Nov 2020 10:41:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1abf78a289d76d7448a5640073cf6e8221a54a55.1605000280.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.11.20 10:36, Alexander Gordeev wrote:
> If for whatever reason the sub-PMD region to be used is less
> than struct page size (e.g in the future), then it is possible
> to overwrite beyond the region size.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/s390/mm/vmem.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index 56ab9bb770f3a..d7f25884061f4 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -91,13 +91,15 @@ static void vmemmap_flush_unused_pmd(void)
>   
>   static void __vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
>   {
> +	unsigned long size = min(end - start, sizeof(struct page));
> +
>   	/*
>   	 * As we expect to add in the same granularity as we remove, it's
>   	 * sufficient to mark only some piece used to block the memmap page from
>   	 * getting removed (just in case the memmap never gets initialized,
>   	 * e.g., because the memory block never gets onlined).
>   	 */
> -	memset(__va(start), 0, sizeof(struct page));
> +	memset(__va(start), 0, size);
>   }
>   
>   static void vmemmap_use_sub_pmd(unsigned long start, unsigned long end)
> 

I don't really see a need for that. Can you spell out one possible 
configuration that would trigger that in the future? It's sounds very 
unlikely and I have the feeling there might be more to change at other 
points.

-- 
Thanks,

David / dhildenb

