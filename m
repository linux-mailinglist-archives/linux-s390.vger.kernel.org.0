Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C85DF6C9DC
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2019 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfGRHRC (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jul 2019 03:17:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:58136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbfGRHRC (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 18 Jul 2019 03:17:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9E326ABC6;
        Thu, 18 Jul 2019 07:17:01 +0000 (UTC)
Date:   Thu, 18 Jul 2019 09:17:00 +0200
From:   Petr Tesarik <ptesarik@suse.cz>
To:     linux-s390@vger.kernel.org
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Is __dma_direct_alloc_pages broken on s390?
Message-ID: <20190718091700.353b3721@ezekiel.suse.cz>
Organization: SUSE Linux, s.r.o.
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi all,

while looking into DMA allocation, I noticed that
__dma_direct_optimal_gfp_mask() in kernel/dma/direct.c can probably be
improved. It uses GFP_DMA if dev->coherent_dma_mask is less than
DMA_BIT_MASK(ARCH_ZONE_DMA_BITS). There is no s390-specific definition
of ARCH_ZONE_DMA_BITS. The default is 24 bits, but the DMA zone on s390
is 31 bits. CCW subchannel devices set sch->dev.coherent_dma_mask to
DMA_BIT_MASK(31), which is greater than DMA_BIT_MASK(24), so buffers
are allocated from the Normal zone first.

Would it make sense to set ARCH_ZONE_BITS to 31 on s390, or did I miss
something?

Petr T
