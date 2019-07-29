Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5ABB78825
	for <lists+linux-s390@lfdr.de>; Mon, 29 Jul 2019 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfG2JQn (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 29 Jul 2019 05:16:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbfG2JQn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 29 Jul 2019 05:16:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DADA43082B15;
        Mon, 29 Jul 2019 09:16:42 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64DC160C5F;
        Mon, 29 Jul 2019 09:16:42 +0000 (UTC)
Date:   Mon, 29 Jul 2019 11:16:40 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH] vfio-ccw: make vfio_ccw_async_region_ops static
Message-ID: <20190729111640.4c03169c.cohuck@redhat.com>
In-Reply-To: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
References: <patch.git-1c8e853871be.your-ad-here.call-01564389487-ext-4282@work.hours>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 29 Jul 2019 09:16:42 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 29 Jul 2019 10:38:52 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Since vfio_ccw_async_region_ops is not exported and has no reason to be
> globally visible make it static to avoid the following sparse warning:
> drivers/s390/cio/vfio_ccw_async.c:73:30: warning: symbol 'vfio_ccw_async_region_ops' was not declared. Should it be static?

Fixes: d5afd5d135c8 ("vfio-ccw: add handling for async channel instructions")
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_async.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 8c1d2357ef5b..7a838e3d7c0f 100644
> --- a/drivers/s390/cio/vfio_ccw_async.c
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -70,7 +70,7 @@ static void vfio_ccw_async_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_async_region_ops = {
>  	.read = vfio_ccw_async_region_read,
>  	.write = vfio_ccw_async_region_write,
>  	.release = vfio_ccw_async_region_release,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Should I queue this and send a pull request (currently, there's nothing
else pending), or do you want to apply this directly?
