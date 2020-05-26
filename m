Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773AA1C1A9C
	for <lists+linux-s390@lfdr.de>; Fri,  1 May 2020 18:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgEAQcr (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 1 May 2020 12:32:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:56120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgEAQcr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 1 May 2020 12:32:47 -0400
IronPort-SDR: lqPEMRdDOaO7Ky04patmk2J7kwjR4fzIG0D5CCZ1zXnqDfRMULV2kzKck93rTZ6dZkcU6QK5mm
 RtDBiq4F3rVQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2020 09:32:46 -0700
IronPort-SDR: IRlEnw96PyW2wS0xq/MI/Ft7/+0Pp51LZQsrLWOgqrKr4uogpI7iSja65OD1MiLWM19MAn6TgZ
 Kj4V8cTQry3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,340,1583222400"; 
   d="scan'208";a="262131924"
Received: from vjaiswa1-mobl.amr.corp.intel.com (HELO [10.252.137.219]) ([10.252.137.219])
  by orsmga006.jf.intel.com with ESMTP; 01 May 2020 09:32:45 -0700
Subject: Re: [PATCH v2 1/1] fs/splice: add missing callback for inaccessible
 pages
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        viro@zeniv.linux.org.uk
Cc:     david@redhat.com, akpm@linux-foundation.org, aarcange@redhat.com,
        linux-mm@kvack.org, frankja@linux.ibm.com, sfr@canb.auug.org.au,
        jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, jack@suse.cz, kirill@shutemov.name,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        Ulrich.Weigand@de.ibm.com
References: <20200430143825.3534128-1-imbrenda@linux.ibm.com>
 <1a3f5107-9847-73d4-5059-c6ef9d293551@de.ibm.com>
 <e3e95a35-b0e3-b733-92f4-98bcccbe7ca5@intel.com>
 <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <a10ec7ad-2648-950e-7f30-07c08e400e7b@intel.com>
Date:   Fri, 1 May 2020 09:32:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3d379d9e-241c-ef3b-dcef-20fdd3b8740d@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 5/1/20 12:18 AM, Christian Borntraeger wrote:
>> 					unlock_page();
>> 	get_page();
>> 	// ^ OK because I have a ref
>> 	// do DMA on inaccessible page
>>
>> Because the make_secure_pte() code isn't looking for a *specific*
>> 'expected' value, it has no way of noticing that the extra ref snuck in
>> there.
> I think the expected calcution is actually doing that,giving back the minimum
> value when no one else has any references that are valid for I/O.
> 
> But I might not have understood what you are trying to tell me?

I was wrong.  I was looking at migrate_page_move_mapping():

>         int expected_count = expected_page_refs(mapping, page) + extra_count;
...
>         xas_lock_irq(&xas);
>         if (page_count(page) != expected_count || xas_load(&xas) != page) {
>                 xas_unlock_irq(&xas);
>                 return -EAGAIN;
>         }
> 
>         if (!page_ref_freeze(page, expected_count)) {
>                 xas_unlock_irq(&xas);
>                 return -EAGAIN;
>         }

I saw the check for page_count(page) *and* the page_ref_freeze() call.
My assumption was that both were needed.  My assumption was wrong.  (I
think the migrate_page_move_mapping() code may actually be doing a
superfluous check.)

The larger point, though, is that the s390 code ensures no extra
references exist upon entering make_secure_pte(), but it still has no
mechanism to prevent future, new references to page cache pages from
being created.

The one existing user of expected_page_refs() freezes the refs then
*removes* the page from the page cache (that's what the xas_lock_irq()
is for).  That stops *new* refs from being acquired.

The s390 code is missing an equivalent mechanism.

One example:

	page_freeze_refs();
	// page->_count==0 now
					find_get_page();
					// ^ sees a "freed" page
	page_unfreeze_refs();

find_get_page() will either fail to *find* the page because it will see
page->_refcount==0 think it is freed (not great), or it will
VM_BUG_ON_PAGE() in __page_cache_add_speculative().

My bigger point is that this patches doesn't systematically stop finding
page cache pages that are arch-inaccessible.  This patch hits *one* of
those sites.
