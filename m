Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7B276636
	for <lists+linux-s390@lfdr.de>; Thu, 24 Sep 2020 04:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgIXCGc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 23 Sep 2020 22:06:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgIXCGb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 23 Sep 2020 22:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600913189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8ZHcIulSGOzBD8uxM6rgIoMK8J76Sbkt6GTxH94yuI=;
        b=CfRSMVkRA1d3uhsTz8cFF9z3ftAHQBBa4YzXwo6EsNb/sijJj0hhBn5w66SEHMz2/0UlRC
        UNyUlujR6C1udl5Ds8OcQpYUGelqsKFLUTM4wjWPswEPVtb0Cw8CcTVl3I6ENioLlCE/fM
        aMZSmdJEGKS8qF2iS3Q/aoPJM/AgT20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-pYJrqiROO7OZqblLvyigNw-1; Wed, 23 Sep 2020 22:06:26 -0400
X-MC-Unique: pYJrqiROO7OZqblLvyigNw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32F51188C122;
        Thu, 24 Sep 2020 02:06:24 +0000 (UTC)
Received: from ovpn-66-35.rdu2.redhat.com (unknown [10.10.67.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD1B860C17;
        Thu, 24 Sep 2020 02:06:19 +0000 (UTC)
Message-ID: <76fef5dfd8efdb4130e41d1811b2a78ce39c8b0d.camel@redhat.com>
Subject: Re: BUG: Bad page state in process dirtyc0w_child
From:   Qian Cai <cai@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alex Shi <alex.shi@linux.alibaba.com>
Date:   Wed, 23 Sep 2020 22:06:19 -0400
In-Reply-To: <20200923153938.5be5dd2c@thinkpad>
References: <a46e9bbef2ed4e17778f5615e818526ef848d791.camel@redhat.com>
         <20200916142806.GD7076@osiris> <20200922190350.7a0e0ca5@thinkpad>
         <20200923153938.5be5dd2c@thinkpad>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2020-09-23 at 15:39 +0200, Gerald Schaefer wrote:
> OK, I can now reproduce this, and unfortunately also with the gup_fast
> fix, so it is something different. Bisecting is a bit hard, as it will
> not always show immediately, sometimes takes up to an hour.
> 
> Still, I think I found the culprit, merge commit b25d1dc9474e "Merge
> branch 'simplify-do_wp_page'". Without those 4 patches, it works fine,
> running over night.
> 
> Not sure why this only shows on s390, should not be architecture-specific,
> but we do often see subtle races earlier than others due to hypervisor
> impact.

Apparently, someone can reproduce something similar on x86 as well:

https://lore.kernel.org/linux-mm/c41149a8-211e-390b-af1d-d5eee690fecb@linux.alibaba.com/

Probably, Alex could revert the bad commits and confirm it there.

> 
> The first commit 09854ba94c6a ("mm: do_wp_page() simplification") already
> introduces this error. The dirtyc0w_child test seems to play with cow
> and racing madvise(MADV_DONTNEED), but I have not yet fully understood
> it and also not the changes from commit 09854ba94c6a. As Linus already
> mentioned in the merge commit message, this is some bad timing for such
> a change, so I don't want to delay this further with trying to understand
> it better before reporting. Maybe Peter or Linus can spot some obvious
> issue.
> 
> One thing that seems strange to me is that the page flags from the
> bad page state output are (uptodate|swapbacked), see below, or
> (referenced|uptodate|dirty|swapbacked) in the original report. But IIUC,
> that should not qualify for the "PAGE_FLAGS_CHECK_AT_FREE flag(s) set"
> reason. So it seems that the flags have changed between check_free_page()
> and __dump_page(), which would be very odd. Or maybe some issue with
> compound pages, because __dump_page() looks at head->flags.
> 
> [ 1863.237707] BUG: Bad page state in process dirtyc0w_child  pfn:58527d
> [ 1863.237721] page:000000008866956b refcount:0 mapcount:0
> mapping:0000000000000000 index:0x0 pfn:0x58527d
> [ 1863.237727] flags: 0x3ffff00000080004(uptodate|swapbacked)
> [ 1863.237734] raw: 3ffff00000080004 0000000000000100 0000000000000122
> 0000000000000000
> [ 1863.237738] raw: 0000000000000000 0000000000000000 ffffffff00000000
> 0000000000000000
> [ 1863.237742] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
> [ 1863.237745] Modules linked in:
> [ 1863.237752] CPU: 16 PID: 9074 Comm: dirtyc0w_child Tainted:
> G    B             5.9.0-rc6-00020-geff48ddeab78-dirty #104
> [ 1863.237756] Hardware name: IBM 3906 M03 703 (LPAR)
> [ 1863.237759] Call Trace:
> [ 1863.237768]  [<0000000000115f28>] show_stack+0x100/0x158 
> [ 1863.237775]  [<000000000096b41a>] dump_stack+0xa2/0xd8 
> [ 1863.237781]  [<00000000003d497c>] bad_page+0xdc/0x140 
> [ 1863.237785]  [<00000000003d5b62>] free_pcp_prepare+0x31a/0x360 
> [ 1863.237789]  [<00000000003d906a>] free_unref_page+0x32/0xb8 
> [ 1863.237794]  [<00000000003b05f4>] zap_p4d_range+0x64c/0xcf8 
> [ 1863.237797]  [<00000000003b0e7a>] unmap_page_range+0x9a/0x110 
> [ 1863.237801]  [<00000000003b0f84>] unmap_single_vma+0x94/0x100 
> [ 1863.237805]  [<00000000003b14c2>] zap_page_range+0x14a/0x1f0 
> [ 1863.237809]  [<00000000003e3a24>] do_madvise+0x75c/0x918 
> [ 1863.237812]  [<00000000003e3c06>] __s390x_sys_madvise+0x26/0x38 
> [ 1863.237817]  [<0000000000d280d4>] system_call+0xe0/0x2c0 
> [ 1863.237820] INFO: lockdep is turned off.
> 

