Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA24D6AFC
	for <lists+linux-s390@lfdr.de>; Mon, 14 Oct 2019 22:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbfJNU7J (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 14 Oct 2019 16:59:09 -0400
Received: from foss.arm.com ([217.140.110.172]:52526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731815AbfJNU7J (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Oct 2019 16:59:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A383337;
        Mon, 14 Oct 2019 13:59:08 -0700 (PDT)
Received: from iMac-3.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5423F68E;
        Mon, 14 Oct 2019 13:59:06 -0700 (PDT)
Date:   Mon, 14 Oct 2019 21:59:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-s390@vger.kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        hch@infradead.org, mbrugger@suse.com, wahrenst@gmx.net,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC 0/5] ARM: Raspberry Pi 4 DMA support
Message-ID: <20191014205859.GA7634@iMac-3.local>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-1-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 14, 2019 at 08:31:02PM +0200, Nicolas Saenz Julienne wrote:
> the Raspberry Pi 4 offers up to 4GB of memory, of which only the first
> is DMA capable device wide. This forces us to use of bounce buffers,
> which are currently not very well supported by ARM's custom DMA ops.
> Among other things the current mechanism (see dmabounce.c) isn't
> suitable for high memory. Instead of fixing it, this series introduces a
> way of selecting dma-direct as the default DMA ops provider which allows
> for the Raspberry Pi to make use of swiotlb.

I presume these patches go on top of this series:

http://lkml.kernel.org/r/20190911182546.17094-1-nsaenzjulienne@suse.de

which I queued here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/zone-dma

-- 
Catalin
