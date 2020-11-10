Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72882AD2AD
	for <lists+linux-s390@lfdr.de>; Tue, 10 Nov 2020 10:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgKJJmC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 10 Nov 2020 04:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38629 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730234AbgKJJmC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 10 Nov 2020 04:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605001321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tHnFSVL2juGVrhmR9DzJLfMBOJtD8mchi/sP5EaSbLI=;
        b=Z5uSXfCD3XXr6E0sDCAhxOp3SWNwNqW74k9OVjHatQo84BAiuSqrFfDMwuWTW83a2x/oD2
        CijGXZ6Gef5306y+uXrxGop4Xv+Of1OgGMmOw/MbejPWAti++5/K+glkhz+9wHa7ycL5TE
        h0UgIhMOEJ8jFvq+rBXYUoRKPyJIdZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-akr68bE5P0O-qvYZrUArTA-1; Tue, 10 Nov 2020 04:41:59 -0500
X-MC-Unique: akr68bE5P0O-qvYZrUArTA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24AC6108E1A1;
        Tue, 10 Nov 2020 09:41:58 +0000 (UTC)
Received: from [10.36.114.232] (ovpn-114-232.ams2.redhat.com [10.36.114.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 070535B4B6;
        Tue, 10 Nov 2020 09:41:56 +0000 (UTC)
Subject: Re: [PATCH 1/3] s390/vmem: remove redundant check
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>
References: <cover.1605000280.git.agordeev@linux.ibm.com>
 <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <c5eb5477-595a-77b0-8088-2c9e68a25b58@redhat.com>
Date:   Tue, 10 Nov 2020 10:41:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <90f322a1d24b63a639dec1876a7a5cbbf866482a.1605000280.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10.11.20 10:36, Alexander Gordeev wrote:
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>   arch/s390/mm/vmem.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
> index b239f2ba93b09..56ab9bb770f3a 100644
> --- a/arch/s390/mm/vmem.c
> +++ b/arch/s390/mm/vmem.c
> @@ -223,7 +223,7 @@ static int __ref modify_pmd_table(pud_t *pud, unsigned long addr,
>   		if (!add) {
>   			if (pmd_none(*pmd))
>   				continue;
> -			if (pmd_large(*pmd) && !add) {
> +			if (pmd_large(*pmd)) {
>   				if (IS_ALIGNED(addr, PMD_SIZE) &&
>   				    IS_ALIGNED(next, PMD_SIZE)) {
>   					if (!direct)
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

