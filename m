Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70DDA16352A
	for <lists+linux-s390@lfdr.de>; Tue, 18 Feb 2020 22:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgBRVft (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 18 Feb 2020 16:35:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:31054 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgBRVft (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Feb 2020 16:35:49 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 13:35:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="382589447"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2020 13:35:48 -0800
Date:   Tue, 18 Feb 2020 13:35:48 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Michael Mueller <mimu@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v2 01/42] mm:gup/writeback: add callbacks for
 inaccessible pages
Message-ID: <20200218213548.GI28156@linux.intel.com>
References: <20200214222658.12946-1-borntraeger@de.ibm.com>
 <20200214222658.12946-2-borntraeger@de.ibm.com>
 <107a8a72-b745-26f2-5805-c4d99ce77b35@redhat.com>
 <dd33cc1a-214d-b949-8f5e-9c2d40a8e518@de.ibm.com>
 <a8f8786e-1ed0-0c44-08d0-ebc58f43ae40@redhat.com>
 <20200218154610.GB27565@linux.intel.com>
 <20200218160242.GB1133@willie-the-truck>
 <d2536349-bc47-2b0f-79dc-4bb7cea5182d@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2536349-bc47-2b0f-79dc-4bb7cea5182d@de.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Feb 18, 2020 at 05:15:57PM +0100, Christian Borntraeger wrote:
> 
> 
> On 18.02.20 17:02, Will Deacon wrote:
> > On Tue, Feb 18, 2020 at 07:46:10AM -0800, Sean Christopherson wrote:
> >> On Tue, Feb 18, 2020 at 09:27:20AM +0100, David Hildenbrand wrote:
> >>> On 17.02.20 12:10, Christian Borntraeger wrote:
> >>>> So yes, if everything is setup properly this should not fail in real life
> >>>> and only we have a kernel (or firmware) bug.
> >>>>
> >>>
> >>> Then, without feedback from other possible users, this should be a void
> >>> function. So either introduce error handling or convert it to a void for
> >>> now (and add e.g., BUG_ON and a comment inside the s390x implementation).
> >>
> >> My preference would also be for a void function (versus ignoring an int
> >> return).
> > 
> > The gup code could certainly handle the error value, although the writeback
> > is a lot less clear (so a BUG_ON() would seem to be sufficient for now).
> 
> Sean, David. Can we agree on merging patch 39?

I'm a-ok with adding error checking, ignoring the return value is the only
option I don't like :-)
