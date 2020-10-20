Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BD228607F
	for <lists+linux-s390@lfdr.de>; Wed,  7 Oct 2020 15:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJGNyO (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 7 Oct 2020 09:54:14 -0400
Received: from verein.lst.de ([213.95.11.211]:37437 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728535AbgJGNyO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 7 Oct 2020 09:54:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8724E6736F; Wed,  7 Oct 2020 15:54:11 +0200 (CEST)
Date:   Wed, 7 Oct 2020 15:54:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        sth@linux.ibm.com, linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
Message-ID: <20201007135411.GA1000@lst.de>
References: <20201007124009.1438269-1-hch@lst.de> <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
> > Don't error out if the dasd_biodasdinfo symbol is not available.
> 
> Should this be marked for 5.8-stable?

The Fixes tag should automatically take care of that.
