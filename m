Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42077A7DE3
	for <lists+linux-s390@lfdr.de>; Wed,  4 Sep 2019 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfIDIbG (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 4 Sep 2019 04:31:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51784 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbfIDIbF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 4 Sep 2019 04:31:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C3C5A8980F9;
        Wed,  4 Sep 2019 08:31:05 +0000 (UTC)
Received: from gondolin (ovpn-117-161.ams2.redhat.com [10.36.117.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3129E60606;
        Wed,  4 Sep 2019 08:31:03 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:31:00 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <kvm@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] vfio-ccw: fix error return code in
 vfio_ccw_sch_init()
Message-ID: <20190904103100.4a53d035.cohuck@redhat.com>
In-Reply-To: <20190904083315.105600-1-weiyongjun1@huawei.com>
References: <20190904083315.105600-1-weiyongjun1@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Wed, 04 Sep 2019 08:31:05 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 4 Sep 2019 08:33:15 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix to return negative error code -ENOMEM from the memory alloc failed
> error handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 60e05d1cf087 ("vfio-ccw: add some logging")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/s390/cio/vfio_ccw_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Ah, yes.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Heiko/Vasily/Christian: can you queue this directly?
