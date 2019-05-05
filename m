Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 449A713F31
	for <lists+linux-s390@lfdr.de>; Sun,  5 May 2019 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfEELT4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sun, 5 May 2019 07:19:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43396 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfEELT4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 5 May 2019 07:19:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F53230821E2;
        Sun,  5 May 2019 11:19:56 +0000 (UTC)
Received: from gondolin (ovpn-204-34.brq.redhat.com [10.40.204.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A74EC5C298;
        Sun,  5 May 2019 11:19:51 +0000 (UTC)
Date:   Sun, 5 May 2019 13:19:47 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "Heiko Carstens" <heiko.carstens@de.ibm.com>,
        <linux-s390@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] KVM: s390: fix typo in parameter description
Message-ID: <20190505131947.6124d607.cohuck@redhat.com>
In-Reply-To: <20190504065145.53665-1-weiyongjun1@huawei.com>
References: <20190504065145.53665-1-weiyongjun1@huawei.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Sun, 05 May 2019 11:19:56 +0000 (UTC)
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, 4 May 2019 06:51:45 +0000
Wei Yongjun <weiyongjun1@huawei.com> wrote:

> Fix typo in parameter description.
> 
> Fixes: 8b905d28ee17 ("KVM: s390: provide kvm_arch_no_poll function")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  arch/s390/kvm/kvm-s390.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8d6d75db8de6..ac6163c334d6 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -181,7 +181,7 @@ MODULE_PARM_DESC(hpage, "1m huge page backing support");
>  /* maximum percentage of steal time for polling.  >100 is treated like 100 */
>  static u8 halt_poll_max_steal = 10;
>  module_param(halt_poll_max_steal, byte, 0644);
> -MODULE_PARM_DESC(hpage, "Maximum percentage of steal time to allow polling");
> +MODULE_PARM_DESC(halt_poll_max_steal, "Maximum percentage of steal time to allow polling");
>  
>  /*
>   * For now we handle at most 16 double words as this is what the s390 base
> 
> 
> 

Whoops.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
