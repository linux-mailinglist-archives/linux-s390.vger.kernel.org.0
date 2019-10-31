Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC30EB594
	for <lists+linux-s390@lfdr.de>; Thu, 31 Oct 2019 17:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJaQ65 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 31 Oct 2019 12:58:57 -0400
Received: from verein.lst.de ([213.95.11.211]:52079 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728597AbfJaQ65 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 31 Oct 2019 12:58:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 68576227A81; Thu, 31 Oct 2019 17:58:53 +0100 (CET)
Date:   Thu, 31 Oct 2019 17:58:53 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] dma/direct: turn ARCH_ZONE_DMA_BITS into a variable
Message-ID: <20191031165853.GA8532@lst.de>
References: <20191031152837.15253-1-nsaenzjulienne@suse.de> <20191031154759.GA7162@lst.de> <40d06d463c05d36968e8b64924d78f7794f8de50.camel@suse.de> <20191031155750.GA7394@lst.de> <6726a651c12d91ca22b9d8984745d90db5d507ec.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6726a651c12d91ca22b9d8984745d90db5d507ec.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Oct 31, 2019 at 05:22:59PM +0100, Nicolas Saenz Julienne wrote:
> OK, I see what you mean now. It's wrong indeed.
> 
> The trouble is the ZONE_DMA series[1] in arm64, also due for v5.5, will be
> affected by this patch. I don't know the right way to approach this problem
> since depending on the merge order, this patch should be updated or the arm64
> ZONE_DMA series fixed.
> 
> Maybe it's easier to just wait for v5.6.

Ok, I can wait.  Or the arm64 maintainers can pick up this patch if
you want to add it to that series.
