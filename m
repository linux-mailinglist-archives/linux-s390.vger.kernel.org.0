Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B04E605E7
	for <lists+linux-s390@lfdr.de>; Fri,  5 Jul 2019 14:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfGEM16 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 5 Jul 2019 08:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbfGEM16 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 5 Jul 2019 08:27:58 -0400
Received: from localhost (deibp9eh1--blueice1n7.emea.ibm.com [195.212.29.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05E9421850;
        Fri,  5 Jul 2019 12:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562329677;
        bh=dW7+yV8waH31bo5/Ho09eL3LeOtx3l2YmJNVaozgVu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FEUS8cWk+Q6Ul4bM5zwJjUs9QhRMjJIA4f4ZSlDYFAQihmc802L5/PdvVrf0HIKRH
         yyY7UwOP+7VZheiMqb258FlXlDs0ui7oW4YxuOoNb2kZkoruOLMww1NHymRRWRPu4h
         A0vTs2Qwn+D37ZAYJ+UgsLW4BQgVGSo1ZGtNxmBo=
Date:   Fri, 5 Jul 2019 14:27:53 +0200
From:   Vasily Gorbik <gor@kernel.org>
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] docs: s390: unify and update s390dbf kdocs at debug.c
Message-ID: <your-ad-here.call-01562329673-ext-3862@work.hours>
References: <1562149189-1417-1-git-send-email-maier@linux.ibm.com>
 <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1562149189-1417-3-git-send-email-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jul 03, 2019 at 12:19:48PM +0200, Steffen Maier wrote:
> For non-static-inlines, debug.c already had non-compliant function
> header docs. So move the pure prototype kdocs of
> ("s390: include/asm/debug.h add kerneldoc markups")
> from debug.h to debug.c and merge them with the old function docs.
> Also, I had the impression that kdoc typically is at the implementation
> in the compile unit rather than at the prototype in the header file.
> 
> While at it, update the short kdoc description to distinguish the
> different functions. And a few more consistency cleanups.
> 
> Added a new kdoc for debug_set_critical() since debug.h comments it
> as part of the API.
> 
> Signed-off-by: Steffen Maier <maier@linux.ibm.com>
> ---
>  Documentation/s390/s390dbf.rst |   1 +
>  arch/s390/include/asm/debug.h  | 112 ++++++-----------------------------------
>  arch/s390/kernel/debug.c       | 105 +++++++++++++++++++++++++++++++-------
>  3 files changed, 102 insertions(+), 116 deletions(-)
> 
Applied with "permisions->permissions" and couple of whitespaces removed, thanks.
