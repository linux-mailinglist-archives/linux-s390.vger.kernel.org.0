Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848E41DA069
	for <lists+linux-s390@lfdr.de>; Tue, 19 May 2020 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgESTDo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 19 May 2020 15:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESTDo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 May 2020 15:03:44 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E32C08C5C0;
        Tue, 19 May 2020 12:03:44 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jb7WX-00BxzX-83; Tue, 19 May 2020 19:03:33 +0000
Date:   Tue, 19 May 2020 20:03:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com
Subject: Re: [PATCH 3/2] block: remove ioctl_by_bdev
Message-ID: <20200519190333.GR23230@ZenIV.linux.org.uk>
References: <20200519142259.102279-1-sth@linux.ibm.com>
 <20200519143321.GB16127@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519143321.GB16127@lst.de>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 19, 2020 at 04:33:21PM +0200, Christoph Hellwig wrote:
> No callers left.

No callers left after...?  IOW, where are the patches?  There'd been
several patchsets posted, each with more than one revision...

I realize that some of that went into -mm, but could you repost
the final variant of the entire pile and/or tell which set of
git branches to look at?
