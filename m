Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F092FD01D
	for <lists+linux-s390@lfdr.de>; Wed, 20 Jan 2021 13:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732997AbhATMZs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 20 Jan 2021 07:25:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:57914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732901AbhATL7O (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 20 Jan 2021 06:59:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B1E1AAAE;
        Wed, 20 Jan 2021 11:58:17 +0000 (UTC)
Date:   Wed, 20 Jan 2021 12:58:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] mm/memory_hotplug: Prevalidate the address range
 being added with platform
Message-ID: <20210120115814.GA7107@localhost.localdomain>
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-2-git-send-email-anshuman.khandual@arm.com>
 <691872bb-b251-83e0-126e-afd54683c83e@redhat.com>
 <3d4f3b14-0715-b2b3-b015-04b8a77abfb8@arm.com>
 <30bbf862-06a4-bd1d-b902-61aa4183b819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30bbf862-06a4-bd1d-b902-61aa4183b819@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jan 20, 2021 at 11:41:53AM +0100, David Hildenbrand wrote:
> On 20.01.21 09:33, Anshuman Khandual wrote:
> > 
> > 
> > On 1/19/21 5:51 PM, David Hildenbrand wrote:
> >> On 18.01.21 14:12, Anshuman Khandual wrote:
> >>> This introduces memhp_range_allowed() which can be called in various memory
> >>> hotplug paths to prevalidate the address range which is being added, with
> >>> the platform. Then memhp_range_allowed() calls memhp_get_pluggable_range()
> >>> which provides applicable address range depending on whether linear mapping
> >>> is required or not. For ranges that require linear mapping, it calls a new
> >>> arch callback arch_get_mappable_range() which the platform can override. So
> >>> the new callback, in turn provides the platform an opportunity to configure
> >>> acceptable memory hotplug address ranges in case there are constraints.
> >>>
> >>> This mechanism will help prevent platform specific errors deep down during
> >>> hotplug calls. This drops now redundant check_hotplug_memory_addressable()
> >>> check in __add_pages() but instead adds a VM_BUG_ON() check which would
> >>
> >> In this patch, you keep the __add_pages() checks. But as discussed, we
> >> could perform it in mm/memremap.c:pagemap_range() insted and convert it
> >> to a VM_BUG_ON().
> > 
> > Just to be sure, will the following change achieve what you are
> > suggesting here. pagemap_range() after this change, will again
> > be the same like the V1 series.
> 
> Yeah, as we used to have in v1. Maybe other reviewers (@Oscar?) have a
> different opinion.

No, I think that placing the check in pagemap_range() out of the if-else
makes much more sense.
Actually, unless my memory  fails me that is what I suggested in v2.

I plan to have a look at the series later this week as I am fairly busy
atm.

Thanks


-- 
Oscar Salvador
SUSE L3
