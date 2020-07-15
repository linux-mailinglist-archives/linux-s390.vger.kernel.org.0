Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175A6220566
	for <lists+linux-s390@lfdr.de>; Wed, 15 Jul 2020 08:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGOGs6 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 15 Jul 2020 02:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGs5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 02:48:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D0C061755;
        Tue, 14 Jul 2020 23:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Xu0wDeMJVr4Fso9VMDrFXFtdZDxizg0iRDFYzL7qxg=; b=PikKUoj5RJk+gJSIrWoefNe2LO
        MYOdcsUH5TxR9dW7uwJKsy17jAfuJ68+U0y8Qd2Boo79ZpjG7i+/mGPnPuUhHrn1X9OVT8OCn7CkE
        HGUV+gjxVRrEBumyrkMN8s8w4drtjOo1QxCdtRfY50bc9dr1Ndg4ujsY2TrzrqQWT3aNS4YOoUQ/J
        ctjMTk/gE2+9zKkomv0jMdroxC7KQu4Pu4ID3wlCIt7PB69AXfRkb4eF8hUnivTE4hFAKPa+gKwZb
        VHplUcokz24V5bF+MDO9RaOMyHyBdIqySdrMkdGCMTbA0jrrTda/wBy+NjUkFUp48yLWPhE6mj2hH
        OktsMzUw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvbDq-0001Vp-VP; Wed, 15 Jul 2020 06:48:55 +0000
Date:   Wed, 15 Jul 2020 07:48:54 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stefan Haberland <sth@linux.ibm.com>, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
Message-ID: <20200715064854.GA5409@infradead.org>
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
> Just curious, any reason this isn't just using bio_alloc()?

The dasd_diag_bio doesn't seem to have anything to do with the
block layer struct bio..
