Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F5A2190B4
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jul 2020 21:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGHTeP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jul 2020 15:34:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgGHTeO (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:14 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FB4220720;
        Wed,  8 Jul 2020 19:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594236854;
        bh=trbpVxueRJhho0ntp4U+HjeFPyUeIcRU0OSyGcAoJPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qMWroq5v6pTfxB6LhBOnQArAQxz/wuA55yPp68otSILYyP/aP6gxFM7+oK/h939JA
         4xzxrg2WLfAQ45stASiEVHiqDJ201/scLQQQFtsoGwzF2U+b/E7rLpundKwLHqynuO
         e5rkZsUTtQgitkxUNzn0Hbt3VPAXN/wl9UMAQZg4=
Date:   Wed, 8 Jul 2020 14:39:42 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] s390/dasd: Use struct_size() helper
Message-ID: <20200708193942.GJ11533@embeddedor>
References: <20200619165600.GA8668@embeddedor>
 <47a86753-fd4d-9a7a-c808-5f387c872ab3@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47a86753-fd4d-9a7a-c808-5f387c872ab3@linux.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 08, 2020 at 11:13:08AM +0200, Stefan Haberland wrote:
> Am 19.06.20 um 18:56 schrieb Gustavo A. R. Silva:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes. Also, remove unnecessary
> > variable _datasize_.
> >
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Thanks for the patch.
> Tested and applied.

Thanks, Stefan.

--
Gustavo
