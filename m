Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACA486CE9E
	for <lists+linux-s390@lfdr.de>; Thu, 18 Jul 2019 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGRNLB (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 18 Jul 2019 09:11:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58582 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfGRNLB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Jul 2019 09:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DLl2tJMpUaGoeLMQ6I0VitEpGVDCB19VJEH7dB2QKXc=; b=pBMIed34NRvA7YjA9gmGRRTp3
        xtjaVeqT+YI3p2rrC1m4qgnJWi6zoDxJSBoD+6411Mt9EKl055AQeTZ9Ttgsdn0N/kRzu476VURNV
        JYqZTewyJlCopZ90IOcHQsasEsTG7/Y+0g3T/0dwhLAa03swZWIH++7Es9q2XcTfj6Qx0885JyCfi
        pyWWx6MJJErrtwxhtVQUM2e3GeIWvOc2Gc2/AXewP2GjLKiJgZgWf1AyixOIV8Fb2oegLVs5IKjfj
        UYlfr1fjl0qIwJb4jPf/xC3CZ9sifF2sB0chT3V+aPst0FGYlBbBxZS8d3DvtS14qB164sNL57lqB
        FkEl0LxIg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1ho6BX-0006Df-H1; Thu, 18 Jul 2019 13:10:59 +0000
Date:   Thu, 18 Jul 2019 06:10:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Petr Tesarik <ptesarik@suse.cz>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: Is __dma_direct_alloc_pages broken on s390?
Message-ID: <20190718131059.GA18742@infradead.org>
References: <20190718091700.353b3721@ezekiel.suse.cz>
 <20190718113633.GB3581@osiris>
 <20190718135112.5c65685f@ezekiel.suse.cz>
 <20190718145044.03dc9804.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190718145044.03dc9804.pasic@linux.ibm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jul 18, 2019 at 02:50:44PM +0200, Halil Pasic wrote:
> > I wondered why the kernel works OK on my system, and it is in fact not
> > so bad. If the first allocation fails, the kernel adds GFP_DMA and
> > retries, so this is not fatal, but with a proper definition of
> > ARCH_ZONE_DMA_BITS it should be possible to get success in the first
> > attempt already, let's do it.
> > 
> > Petr T
> 
> I fully agree! I will post a patch that provides correct
> ARCH_ZONE_DMA_BITS for s390.
> 
> BTW I wonder if ARCH_ZONE_DMA_BITS can be inferred from MAX_DMA_ADDRESS,
> and why do we need both.@Christoph, maybe you can help me understand if
> there is a relationship between the two or not, or?

MAX_DMA_ADDRESS is a bit of a weird beast which I honestly do not
understand fully, but most of the uses in common code look a little
bogus, and we should probably get rid of it.
