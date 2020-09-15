Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AFE26B261
	for <lists+linux-s390@lfdr.de>; Wed, 16 Sep 2020 00:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgIOWqc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Sep 2020 18:46:32 -0400
Received: from verein.lst.de ([213.95.11.211]:48275 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgIOPwr (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Sep 2020 11:52:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77ED768AFE; Tue, 15 Sep 2020 17:52:17 +0200 (CEST)
Date:   Tue, 15 Sep 2020 17:52:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/4] s390/dis: get rid of set_fs() usage
Message-ID: <20200915155217.GA22056@lst.de>
References: <20200915154340.4215-1-hca@linux.ibm.com> <20200915154340.4215-3-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915154340.4215-3-hca@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 15, 2020 at 05:43:38PM +0200, Heiko Carstens wrote:
> +		if (user_mode(regs)) {
> +			if (__copy_from_user(code + start - 2, (char __user *)addr, 2))
> +				break;
> +		} else {
> +			if (copy_from_kernel_nofault(code + start - 2, (char *)addr, 2))
> +				break;
> +		}

>  	for (end = 32; end < 64; end += 2) {
>  		addr = regs->psw.addr + end - 32;
> +		if (user_mode(regs)) {
> +			if (__copy_from_user(code + end, (char __user *)addr, 2))
> +				break;
> +		} else {
> +			if (copy_from_kernel_nofault(code + end, (char *)addr, 2))
> +				break;
> +		}

Maybe add a little copy_from_regs helper?  That would also get rid
of the awfully long lines here.

Also any good reason for the __copy_from_user instead of the normal
copy_from_user here?
