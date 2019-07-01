Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F20F45B703
	for <lists+linux-s390@lfdr.de>; Mon,  1 Jul 2019 10:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfGAIlf (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 1 Jul 2019 04:41:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:37448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727128AbfGAIlf (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 1 Jul 2019 04:41:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A0E0AB7D;
        Mon,  1 Jul 2019 08:41:31 +0000 (UTC)
Date:   Mon, 1 Jul 2019 10:41:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Andrew Banman <andrew.banman@hpe.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mark Brown <broonie@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v3 09/11] mm/memory_hotplug: Remove memory block devices
 before arch_remove_memory()
Message-ID: <20190701084129.GI6376@dhcp22.suse.cz>
References: <20190527111152.16324-1-david@redhat.com>
 <20190527111152.16324-10-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527111152.16324-10-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon 27-05-19 13:11:50, David Hildenbrand wrote:
> Let's factor out removing of memory block devices, which is only
> necessary for memory added via add_memory() and friends that created
> memory block devices. Remove the devices before calling
> arch_remove_memory().
> 
> This finishes factoring out memory block device handling from
> arch_add_memory() and arch_remove_memory().

OK, this makes sense again. Just a nit. Calling find_memory_block_by_id
for each memory block looks a bit suboptimal, especially when we are
removing consequent physical memblocks. I have to confess that I do not
know how expensive is the search and I also expect that there won't be
that many memblocks in the removed range anyway as large setups have
large memblocks.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrew Banman <andrew.banman@hpe.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: Arun KS <arunks@codeaurora.org>
> Cc: Mathieu Malaterre <malat@debian.org>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Other than that looks good to me.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c  | 37 ++++++++++++++++++-------------------
>  drivers/base/node.c    | 11 ++++++-----
>  include/linux/memory.h |  2 +-
>  include/linux/node.h   |  6 ++----
>  mm/memory_hotplug.c    |  5 +++--
>  5 files changed, 30 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 5a0370f0c506..f28efb0bf5c7 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -763,32 +763,31 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
>  	return ret;
>  }
>  
> -void unregister_memory_section(struct mem_section *section)
> +/*
> + * Remove memory block devices for the given memory area. Start and size
> + * have to be aligned to memory block granularity. Memory block devices
> + * have to be offline.
> + */
> +void remove_memory_block_devices(unsigned long start, unsigned long size)
>  {
> +	const int start_block_id = pfn_to_block_id(PFN_DOWN(start));
> +	const int end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
>  	struct memory_block *mem;
> +	int block_id;
>  
> -	if (WARN_ON_ONCE(!present_section(section)))
> +	if (WARN_ON_ONCE(!IS_ALIGNED(start, memory_block_size_bytes()) ||
> +			 !IS_ALIGNED(size, memory_block_size_bytes())))
>  		return;
>  
>  	mutex_lock(&mem_sysfs_mutex);
> -
> -	/*
> -	 * Some users of the memory hotplug do not want/need memblock to
> -	 * track all sections. Skip over those.
> -	 */
> -	mem = find_memory_block(section);
> -	if (!mem)
> -		goto out_unlock;
> -
> -	unregister_mem_sect_under_nodes(mem, __section_nr(section));
> -
> -	mem->section_count--;
> -	if (mem->section_count == 0)
> +	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> +		mem = find_memory_block_by_id(block_id, NULL);
> +		if (WARN_ON_ONCE(!mem))
> +			continue;
> +		mem->section_count = 0;
> +		unregister_memory_block_under_nodes(mem);
>  		unregister_memory(mem);
> -	else
> -		put_device(&mem->dev);
> -
> -out_unlock:
> +	}
>  	mutex_unlock(&mem_sysfs_mutex);
>  }
>  
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 8598fcbd2a17..04fdfa99b8bc 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -801,9 +801,10 @@ int register_mem_sect_under_node(struct memory_block *mem_blk, void *arg)
>  	return 0;
>  }
>  
> -/* unregister memory section under all nodes that it spans */
> -int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -				    unsigned long phys_index)
> +/*
> + * Unregister memory block device under all nodes that it spans.
> + */
> +int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
>  	NODEMASK_ALLOC(nodemask_t, unlinked_nodes, GFP_KERNEL);
>  	unsigned long pfn, sect_start_pfn, sect_end_pfn;
> @@ -816,8 +817,8 @@ int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
>  		return -ENOMEM;
>  	nodes_clear(*unlinked_nodes);
>  
> -	sect_start_pfn = section_nr_to_pfn(phys_index);
> -	sect_end_pfn = sect_start_pfn + PAGES_PER_SECTION - 1;
> +	sect_start_pfn = section_nr_to_pfn(mem_blk->start_section_nr);
> +	sect_end_pfn = section_nr_to_pfn(mem_blk->end_section_nr);
>  	for (pfn = sect_start_pfn; pfn <= sect_end_pfn; pfn++) {
>  		int nid;
>  
> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index db3e8567f900..f26a5417ec5d 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -112,7 +112,7 @@ extern void unregister_memory_notifier(struct notifier_block *nb);
>  extern int register_memory_isolate_notifier(struct notifier_block *nb);
>  extern void unregister_memory_isolate_notifier(struct notifier_block *nb);
>  int create_memory_block_devices(unsigned long start, unsigned long size);
> -extern void unregister_memory_section(struct mem_section *);
> +void remove_memory_block_devices(unsigned long start, unsigned long size);
>  extern int memory_dev_init(void);
>  extern int memory_notify(unsigned long val, void *v);
>  extern int memory_isolate_notify(unsigned long val, void *v);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 1a557c589ecb..02a29e71b175 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -139,8 +139,7 @@ extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
>  extern int register_mem_sect_under_node(struct memory_block *mem_blk,
>  						void *arg);
> -extern int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -					   unsigned long phys_index);
> +extern int unregister_memory_block_under_nodes(struct memory_block *mem_blk);
>  
>  extern int register_memory_node_under_compute_node(unsigned int mem_nid,
>  						   unsigned int cpu_nid,
> @@ -176,8 +175,7 @@ static inline int register_mem_sect_under_node(struct memory_block *mem_blk,
>  {
>  	return 0;
>  }
> -static inline int unregister_mem_sect_under_nodes(struct memory_block *mem_blk,
> -						  unsigned long phys_index)
> +static inline int unregister_memory_block_under_nodes(struct memory_block *mem_blk)
>  {
>  	return 0;
>  }
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 9a92549ef23b..82136c5b4c5f 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -520,8 +520,6 @@ static void __remove_section(struct zone *zone, struct mem_section *ms,
>  	if (WARN_ON_ONCE(!valid_section(ms)))
>  		return;
>  
> -	unregister_memory_section(ms);
> -
>  	scn_nr = __section_nr(ms);
>  	start_pfn = section_nr_to_pfn((unsigned long)scn_nr);
>  	__remove_zone(zone, start_pfn);
> @@ -1845,6 +1843,9 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  	memblock_free(start, size);
>  	memblock_remove(start, size);
>  
> +	/* remove memory block devices before removing memory */
> +	remove_memory_block_devices(start, size);
> +
>  	arch_remove_memory(nid, start, size, NULL);
>  	__release_memory_resource(start, size);
>  
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
