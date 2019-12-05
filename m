Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25337114137
	for <lists+linux-s390@lfdr.de>; Thu,  5 Dec 2019 14:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfLENJ7 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 5 Dec 2019 08:09:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60999 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729048AbfLENJ7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 08:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575551398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=9ZS3eRs/VTFhjUYbJbY7+X719DLjsWtfaUgf8EntmVQ=;
        b=AZk2mkP82e3IyJlxnoWMukIwvbhMvGKPsBbvRhAPAisnpXnFpi/FPptfqfALgqla6P03BD
        or3pNoDBEl/ashzxSU7Eyk4y5IYPIc6ZK5xh4Z8KKTxXJM6wqZK/N6I+Pas+rmc6IiN+5I
        IJuSKrgTfu3PhzbhH/yrECuwE6vewOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-_ikbm2M-NAyyUG-a5mKo6w-1; Thu, 05 Dec 2019 08:09:57 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C1E2800D41;
        Thu,  5 Dec 2019 13:09:56 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-87.ams2.redhat.com [10.36.116.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6235C21B;
        Thu,  5 Dec 2019 13:09:51 +0000 (UTC)
Subject: Re: [PATCH] KVM: s390: ENOTSUPP -> EOPNOTSUPP fixups
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.vnet.ibm.com>
Cc:     KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Julian Wiedmann <jwi@linux.ibm.com>
References: <20191205125147.229367-1-borntraeger@de.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <087b1693-6ec0-94e3-d94a-f55c2e717438@redhat.com>
Date:   Thu, 5 Dec 2019 14:09:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191205125147.229367-1-borntraeger@de.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: _ikbm2M-NAyyUG-a5mKo6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/12/2019 13.51, Christian Borntraeger wrote:
> There is no ENOTSUPP for userspace
> 
> Reported-by: Julian Wiedmann <jwi@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 2a711bae69a7..bd9b339bbb5e 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2312,7 +2312,7 @@ static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)
>  		return -EINVAL;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	mutex_lock(&fi->ais_lock);
>  	ais.simm = fi->simm;
> @@ -2621,7 +2621,7 @@ static int modify_ais_mode(struct kvm *kvm, struct kvm_device_attr *attr)
>  	int ret = 0;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&req, (void __user *)attr->addr, sizeof(req)))
>  		return -EFAULT;
> @@ -2701,7 +2701,7 @@ static int flic_ais_mode_set_all(struct kvm *kvm, struct kvm_device_attr *attr)
>  	struct kvm_s390_ais_all ais;
>  
>  	if (!test_kvm_facility(kvm, 72))
> -		return -ENOTSUPP;
> +		return -EOPNOTSUPP;
>  
>  	if (copy_from_user(&ais, (void __user *)attr->addr, sizeof(ais)))
>  		return -EFAULT;
> 

Good catch.

Reviewed-by: Thomas Huth <thuth@redhat.com>

There seems to be another one in arch/s390/include/asm/uv.h, are you
going to fix that, too?

