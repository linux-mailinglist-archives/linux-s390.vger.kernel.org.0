Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599DC1EE364
	for <lists+linux-s390@lfdr.de>; Thu,  4 Jun 2020 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFDL13 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 4 Jun 2020 07:27:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25563 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbgFDL13 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 07:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591270048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rp4fAo1ax4WZsSXkT7tUPY6cOf761WqUjP3FSXYOQp8=;
        b=VZFNNFWCM1ilsrTvegeNP8Kxmco+BFjXKk7fnDQWWWLUR8Z403P5zEiINPyIHyPMMYK2NY
        PvvoKCKrYMYBz2sUgFK9lcyQA6+QrAEAzy9drrVo1WrGKnnzutlWjtOHA/MAvVtjQuQVf7
        qPVnFOb8o1mm+bWwPtLJjeOFSkHVCMM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-K-rcBVYNORuwCiiSxB1cOQ-1; Thu, 04 Jun 2020 07:27:26 -0400
X-MC-Unique: K-rcBVYNORuwCiiSxB1cOQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 511A0835B42;
        Thu,  4 Jun 2020 11:27:25 +0000 (UTC)
Received: from gondolin (ovpn-112-76.ams2.redhat.com [10.36.112.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6E9C5C28E;
        Thu,  4 Jun 2020 11:27:23 +0000 (UTC)
Date:   Thu, 4 Jun 2020 13:27:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] vfio-ccw: make vfio_ccw_regops variables declarations
 static
Message-ID: <20200604132721.63b11800.cohuck@redhat.com>
In-Reply-To: <patch.git-a34be7aede18.your-ad-here.call-01591269421-ext-5655@work.hours>
References: <20200603112716.332801-1-cohuck@redhat.com>
        <patch.git-a34be7aede18.your-ad-here.call-01591269421-ext-5655@work.hours>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 4 Jun 2020 13:20:45 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> Fixes the following sparse warnings:
> drivers/s390/cio/vfio_ccw_chp.c:62:30: warning: symbol 'vfio_ccw_schib_region_ops' was not declared. Should it be static?
> drivers/s390/cio/vfio_ccw_chp.c:117:30: warning: symbol 'vfio_ccw_crw_region_ops' was not declared. Should it be static?
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_chp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index 876f6ade51cc..a646fc81c872 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -59,7 +59,7 @@ static void vfio_ccw_schib_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_schib_region_ops = {
>  	.read = vfio_ccw_schib_region_read,
>  	.write = vfio_ccw_schib_region_write,
>  	.release = vfio_ccw_schib_region_release,
> @@ -131,7 +131,7 @@ static void vfio_ccw_crw_region_release(struct vfio_ccw_private *private,
>  
>  }
>  
> -const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
> +static const struct vfio_ccw_regops vfio_ccw_crw_region_ops = {
>  	.read = vfio_ccw_crw_region_read,
>  	.write = vfio_ccw_crw_region_write,
>  	.release = vfio_ccw_crw_region_release,

Oops.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Feel free to merge this directly.

