Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A4B2FFC6D
	for <lists+linux-s390@lfdr.de>; Fri, 22 Jan 2021 07:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbhAVGE7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 22 Jan 2021 01:04:59 -0500
Received: from foss.arm.com ([217.140.110.172]:59518 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbhAVGE6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Jan 2021 01:04:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFDF211B3;
        Thu, 21 Jan 2021 22:04:04 -0800 (PST)
Received: from [10.163.92.92] (unknown [10.163.92.92])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B7D03F68F;
        Thu, 21 Jan 2021 22:04:00 -0800 (PST)
Subject: Re: [PATCH V3 0/3] mm/memory_hotplug: Pre-validate the address range
 with platform
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <d57036a1-de12-2d32-be65-daaa3dc5b772@redhat.com>
 <20210119134016.GA23408@linux> <8df4e1e1-1ddd-398e-c9a6-17a67d8a95bc@arm.com>
Message-ID: <1c8c204d-1f96-d3aa-1b7b-ec4cc7b1b79b@arm.com>
Date:   Fri, 22 Jan 2021 11:34:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8df4e1e1-1ddd-398e-c9a6-17a67d8a95bc@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org


On 1/20/21 2:07 PM, Anshuman Khandual wrote:
> 
> 
> On 1/19/21 7:10 PM, Oscar Salvador wrote:
>> On Tue, Jan 19, 2021 at 02:33:03PM +0100, David Hildenbrand wrote:
>>> Minor thing, we should make up our mind if we want to call stuff
>>> internally "memhp_" or "mhp". I prefer the latter, because it is shorter.
>>
>> I would rather use the latter as well. I used that in [1].
> 
> Okay, will change all that is 'memhp' as 'mhp' instead.
> 
>> MEMHP_MERGE_RESOURCE should be renamed if we agree on that.
>>
>> [1] https://patchwork.kernel.org/project/linux-mm/cover/20201217130758.11565-1-osalvador@suse.de/
>>

While replacing 'memhp' as 'mhp' in this series, noticed there are
some more 'memhp' scattered around the code from earlier. A mix of
both 'memhp' and 'mhp' might not be a good idea. Hence should we
just change these remaining 'memhp' as 'mhp' as well and possibly
also MEMHP_MERGE_RESOURCE as suggested earlier, in a subsequent
clean up patch ? Would there be a problem with memhp_default_state
being a command line parameter ?

From a tree wide search -

Documentation/admin-guide/kernel-parameters.txt:        memhp_default_state=online/offline
drivers/base/memory.c:int memhp_online_type_from_str(const char *str)
drivers/base/memory.c:  const int online_type = memhp_online_type_from_str(buf);
drivers/base/memory.c:                    online_type_to_str[memhp_default_online_type]);
drivers/base/memory.c:  const int online_type = memhp_online_type_from_str(buf);
drivers/base/memory.c:  memhp_default_online_type = online_type;
include/linux/memory_hotplug.h:extern int memhp_online_type_from_str(const char *str);
include/linux/memory_hotplug.h:extern int memhp_default_online_type;
mm/memory_hotplug.c:int memhp_default_online_type = MMOP_OFFLINE;
mm/memory_hotplug.c:int memhp_default_online_type = MMOP_ONLINE;
mm/memory_hotplug.c:static int __init setup_memhp_default_state(char *str)
mm/memory_hotplug.c:    const int online_type = memhp_online_type_from_str(str);
mm/memory_hotplug.c:            memhp_default_online_type = online_type;
mm/memory_hotplug.c:__setup("memhp_default_state=", setup_memhp_default_state);
mm/memory_hotplug.c:    mem->online_type = memhp_default_online_type;
mm/memory_hotplug.c:    if (memhp_default_online_type != MMOP_OFFLINE)
