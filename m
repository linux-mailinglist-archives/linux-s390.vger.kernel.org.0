Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F603097D2
	for <lists+linux-s390@lfdr.de>; Sat, 30 Jan 2021 20:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhA3TJJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 30 Jan 2021 14:09:09 -0500
Received: from smtprelay0020.hostedemail.com ([216.40.44.20]:59056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230360AbhA3TJI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 30 Jan 2021 14:09:08 -0500
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 14:09:08 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 21C681801FA4A
        for <linux-s390@vger.kernel.org>; Sat, 30 Jan 2021 19:02:05 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C861818009FF3;
        Sat, 30 Jan 2021 19:01:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:4321:5007:6119:7652:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21627:21740:30003:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hen49_5905c85275b3
X-Filterd-Recvd-Size: 1893
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 30 Jan 2021 19:01:22 +0000 (UTC)
Message-ID: <0d72bc0b518c416d32e11abfacda36e6370b8f2c.camel@perches.com>
Subject: Re: [PATCH 19/29] s390/tty3270: Avoid comma separated statements
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Date:   Sat, 30 Jan 2021 11:01:21 -0800
In-Reply-To: <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
References: <cover.1598331148.git.joe@perches.com>
         <9988babd9cca4ac841961d9f0bbf5e49caa87659.1598331149.git.joe@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 2020-08-24 at 21:56 -0700, Joe Perches wrote:
> Use semicolons and braces.

ping?

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/s390/char/tty3270.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
> index aec996de44d9..6acce975df26 100644
> --- a/drivers/s390/char/tty3270.c
> +++ b/drivers/s390/char/tty3270.c
> @@ -424,8 +424,10 @@ tty3270_update(struct timer_list *t)
>  			 * last output position matches the start address
>  			 * of this line.
>  			 */
> -			if (s->string[1] == sba[0] && s->string[2] == sba[1])
> -				str += 3, len -= 3;
> +			if (s->string[1] == sba[0] && s->string[2] == sba[1]) {
> +				str += 3;
> +				len -= 3;
> +			}
>  			if (raw3270_request_add_data(wrq, str, len) != 0)
>  				break;
>  			list_del_init(&s->update);


