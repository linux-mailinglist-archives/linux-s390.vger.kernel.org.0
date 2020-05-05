Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737471C4FAE
	for <lists+linux-s390@lfdr.de>; Tue,  5 May 2020 09:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgEEHxo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 5 May 2020 03:53:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55849 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgEEHxo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 May 2020 03:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588665223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hcR6/Igbt3v45wXDhjmAAPM4pdhFqVrSorKbx97+n0E=;
        b=ZQ1CH7lBg2pYpmzhc3PSbpUyhYSJRAeNjyjXxdJVn3sPBlK/UTF9eKu4NF9eZU95qJOYTX
        sNS3rbMWYOgIbjLUL4kIGz/43gaPAAM2PzpOgtWjJQMPI48gco3dtyfEIyF5Nmg/jvXZso
        YvI7Jkm1cKo0MeMHDTOixYfYklhP9T8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-cAk6SWduPCCm8t1YuchOVw-1; Tue, 05 May 2020 03:53:41 -0400
X-MC-Unique: cAk6SWduPCCm8t1YuchOVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09A2C80183C;
        Tue,  5 May 2020 07:53:40 +0000 (UTC)
Received: from gondolin (ovpn-112-219.ams2.redhat.com [10.36.112.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A384E100164D;
        Tue,  5 May 2020 07:53:35 +0000 (UTC)
Date:   Tue, 5 May 2020 09:53:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Janosch Frank <frankja@linux.vnet.ibm.com>,
        KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Qian Cai <cailca@icloud.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: Remove false WARN_ON_ONCE for the PQAP
 instruction
Message-ID: <20200505095332.528254e5.cohuck@redhat.com>
In-Reply-To: <20200505073525.2287-1-borntraeger@de.ibm.com>
References: <20200505073525.2287-1-borntraeger@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue,  5 May 2020 09:35:25 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> In LPAR we will only get an intercept for FC==3 for the PQAP
> instruction. Running nested under z/VM can result in other intercepts as
> well, for example PQAP(QCI). So the WARN_ON_ONCE is not right. Let
> us simply remove it.

While I agree with removing the WARN_ON_ONCE, I'm wondering why z/VM
gives us intercepts for those fcs... is that just a result of nesting
(or the z/VM implementation), or is there anything we might want to do?

> 
> Cc: Pierre Morel <pmorel@linux.ibm.com>
> Cc: Tony Krowiak <akrowiak@linux.ibm.com>
> Reported-by: Qian Cai <cailca@icloud.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/kvm/priv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 69a824f9ef0b..bbe46c6aedbf 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -626,10 +626,12 @@ static int handle_pqap(struct kvm_vcpu *vcpu)
>  	 * available for the guest are AQIC and TAPQ with the t bit set
>  	 * since we do not set IC.3 (FIII) we currently will only intercept
>  	 * the AQIC function code.
> +	 * Note: running nested under z/VM can result in intercepts, e.g.

s/intercepts/intercepts for other function codes/

> +	 * for PQAP(QCI). We do not support this and bail out.
>  	 */
>  	reg0 = vcpu->run->s.regs.gprs[0];
>  	fc = (reg0 >> 24) & 0xff;
> -	if (WARN_ON_ONCE(fc != 0x03))
> +	if (fc != 0x03)
>  		return -EOPNOTSUPP;
>  
>  	/* PQAP instruction is allowed for guest kernel only */

