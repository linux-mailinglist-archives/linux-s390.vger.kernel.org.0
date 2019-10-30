Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDABEA5FA
	for <lists+linux-s390@lfdr.de>; Wed, 30 Oct 2019 23:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfJ3WJY (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 30 Oct 2019 18:09:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfJ3WJY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 30 Oct 2019 18:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LDHbgfB76rTN8r9CILX2s5kzAZbtKVtwbuHFVM2PVVo=; b=QHsP4VXYRFu9SW8jGB6LM9xEa
        Oftw4Mb+e/a25f1n+PfCZLBYUBv7hEOC0fihpZnRm9lqKNO6DsMyCwjxsaZLq+cysfApG8Bg1V6hd
        4e1kEHEpTZD/96Ik8rs/zFPBmZY02xRPMAFEVtkNjjT65m2A9B14ZJGC03Ed3f8vkUebDf3RYLv8L
        a8GsxN8GU6VOUk7uiyqOHS0vrnLA9H1Ee/I/2RBeTJCEVWCbDI17UoOeF9z/KEizuXCLQzgPHveIp
        NATHAUUz7Ymyx/4DLtq88D/w7yMLqAjMQe1aI2LwmYzKNcNQIgOws4K2QtauRq5BDDF8ARFXRXBNP
        Tsi/O746A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iPvq6-0004GJ-Sq; Wed, 30 Oct 2019 21:49:14 +0000
Date:   Wed, 30 Oct 2019 14:49:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>, mbrugger@suse.com,
        f.fainelli@gmail.com, wahrenst@gmx.net,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH RFC 1/5] dma/direct: turn ARCH_ZONE_DMA_BITS into a
 variable
Message-ID: <20191030214914.GA15939@infradead.org>
References: <20191014183108.24804-1-nsaenzjulienne@suse.de>
 <20191014183108.24804-2-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014183108.24804-2-nsaenzjulienne@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 14, 2019 at 08:31:03PM +0200, Nicolas Saenz Julienne wrote:
> Some architectures, notably ARM, are interested in tweaking this
> depending on their runtime DMA addressing limitations.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Do you want me to pick this up for the 5.5 dma-mapping tree, or do you
want me to wait for the rest to settle?
