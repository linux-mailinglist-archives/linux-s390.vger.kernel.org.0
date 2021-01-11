Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403062F1095
	for <lists+linux-s390@lfdr.de>; Mon, 11 Jan 2021 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbhAKKxY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 11 Jan 2021 05:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729420AbhAKKxX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 11 Jan 2021 05:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610362316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dw2Go3odg3xQMi8oKZf9V/+2r4MBnUAd+QSYJ2Ro4mk=;
        b=XvoWbWgUbiREjj5/mNKvpUsXsRj2SX505xCjpT385EdbBuK+1B7r3OpMl2vA5lmJ8lzcO6
        ekEFZh/j/Gza7Bib5oZw1oO/Qd61rwdhUwc6ixVDRlSiSUyPGk4tUl4sBdantbv3JT9I8+
        BYuVdab+A1sacAayRE90sS/Ltn6Xqq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-94NqtCM0NF23H57DTgUYyg-1; Mon, 11 Jan 2021 05:51:52 -0500
X-MC-Unique: 94NqtCM0NF23H57DTgUYyg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E87FF180A09F;
        Mon, 11 Jan 2021 10:51:50 +0000 (UTC)
Received: from [10.36.115.103] (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94DC274AAC;
        Mon, 11 Jan 2021 10:51:48 +0000 (UTC)
Subject: Re: [PATCH V2 1/3] mm/hotplug: Prevalidate the address range being
 added with platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
 <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <10e733fa-4568-d38f-9b95-2ccc5dc627b8@redhat.com>
Date:   Mon, 11 Jan 2021 11:51:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1608218912-28932-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17.12.20 16:28, Anshuman Khandual wrote:
> This introduces memhp_range_allowed() which can be called in various memory
> hotplug paths to prevalidate the address range which is being added, with
> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
> which provides applicable address range depending on whether linear mapping
> is required or not. For ranges that require linear mapping, it calls a new
> arch callback arch_get_mappable_range() which the platform can override. So
> the new callback, in turn provides the platform an opportunity to configure
> acceptable memory hotplug address ranges in case there are constraints.
> 
> This mechanism will help prevent platform specific errors deep down during
> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
> check in __add_pages() but instead adds a VM_BUG_ON() check which would
> ensure that the range has been validated with memhp_range_allowed() earlier
> in the call chain. Besides memhp_get_pluggable_range() also can be used by
> potential memory hotplug callers to avail the allowed physical range which
> would go through on a given platform.
> 
> This does not really add any new range check in generic memory hotplug but
> instead compensates for lost checks in arch_add_memory() where applicable
> and check_hotplug_memory_addressable(), with unified memhp_range_allowed().
> 

Subject s/mm\/hotplug/mm\/memory_hotplug/

Everywhere in this patch: Use "true/false" for boolean values.

> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/memory_hotplug.h | 10 +++++
>  mm/memory_hotplug.c            | 79 +++++++++++++++++++++++++---------
>  mm/memremap.c                  |  6 +++
>  3 files changed, 75 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 551093b74596..8d72354758c8 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -70,6 +70,9 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
> +bool memhp_range_allowed(u64 start, u64 size, bool need_mapping);
> +struct range memhp_get_pluggable_range(bool need_mapping);

AFAIKs, all memhp_get_pluggable_range() users pass "1".

What about the "add_pages()-only" path?

-- 
Thanks,

David / dhildenb

