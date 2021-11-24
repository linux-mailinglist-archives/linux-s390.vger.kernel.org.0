Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9A45B4FC
	for <lists+linux-s390@lfdr.de>; Wed, 24 Nov 2021 08:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbhKXHNn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 24 Nov 2021 02:13:43 -0500
Received: from verein.lst.de ([213.95.11.211]:35973 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231555AbhKXHNl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 24 Nov 2021 02:13:41 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9250868AFE; Wed, 24 Nov 2021 08:10:28 +0100 (CET)
Date:   Wed, 24 Nov 2021 08:10:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 22/29] iomap: add a IOMAP_DAX flag
Message-ID: <20211124071028.GC7229@lst.de>
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-23-hch@lst.de> <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4gQO6F5-8Ux8ye5cU-W3ZQVDjj5614Xb8EsTvH9UhfAfg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Nov 23, 2021 at 06:47:10PM -0800, Dan Williams wrote:
> On Tue, Nov 9, 2021 at 12:34 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a flag so that the file system can easily detect DAX operations.
> 
> Looks ok, but I would have preferred a quick note about the rationale
> here before needing to read other patches to figure that out.

The reason is to only apply the DAX partition offsets to actual DAX
operations, and not to e.g. fiemap.  I'll document that more clearly.
