Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1791B71A1
	for <lists+linux-s390@lfdr.de>; Fri, 24 Apr 2020 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgDXKLo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 24 Apr 2020 06:11:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726667AbgDXKLn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Apr 2020 06:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=DU0V+U9WPB3BBfUQT4oXb1eZQQMpM0g5rHKwaAFTB48=;
        b=C9qSeEQLNi2dLzxbUuqRqg2D5Dq+RQmzKfEqFiJIabjI0YfrgpmBrFf/EzkqNO0mvaWxfS
        /6PbTXg7k8ChOFSHlDrEutEiEVoBJcxc43OjVi7Nrx/Y4q/Aqr28+JUdmN8AI6xw0Wshl8
        DrK8m9hGhbvhTPI6z4kpb7faQwNQbGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-BLSxr5EmN_2wUiSn4OyUrg-1; Fri, 24 Apr 2020 06:11:40 -0400
X-MC-Unique: BLSxr5EmN_2wUiSn4OyUrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F314F84E042;
        Fri, 24 Apr 2020 10:11:38 +0000 (UTC)
Received: from [10.36.113.138] (ovpn-113-138.ams2.redhat.com [10.36.113.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9455560606;
        Fri, 24 Apr 2020 10:11:37 +0000 (UTC)
Subject: Re: [PATCH v2 08/10] s390x: smp: Wait for sigp completion
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     thuth@redhat.com, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-9-frankja@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <6084d368-86d6-b8fd-d4d3-5e0d72cef590@redhat.com>
Date:   Fri, 24 Apr 2020 12:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-9-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 23.04.20 11:10, Janosch Frank wrote:
> Sigp orders are not necessarily finished when the processor finished
> the sigp instruction. We need to poll if the order has been finished
> before we continue.
> 
> For (re)start and stop we already use sigp sense running and sigp
> sense loops. But we still lack completion checks for stop and store
> status, as well as the cpu resets.
> 
> Let's add them.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/smp.c | 8 ++++++++
>  lib/s390x/smp.h | 1 +
>  s390x/smp.c     | 4 ++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/lib/s390x/smp.c b/lib/s390x/smp.c
> index 6ef0335..2555bf4 100644
> --- a/lib/s390x/smp.c
> +++ b/lib/s390x/smp.c
> @@ -154,6 +154,14 @@ int smp_cpu_start(uint16_t addr, struct psw psw)
>  	return rc;
>  }
>  
> +void smp_cpu_wait_for_completion(uint16_t addr)
> +{
> +	uint32_t status;
> +
> +	/* Loops when cc == 2, i.e. when the cpu is busy with a sigp order */
> +	sigp_retry(1, SIGP_SENSE, 0, &status);
> +}
> +
>  int smp_cpu_destroy(uint16_t addr)
>  {
>  	struct cpu *cpu;
> diff --git a/lib/s390x/smp.h b/lib/s390x/smp.h
> index ce63a89..a8b98c0 100644
> --- a/lib/s390x/smp.h
> +++ b/lib/s390x/smp.h
> @@ -45,6 +45,7 @@ int smp_cpu_restart(uint16_t addr);
>  int smp_cpu_start(uint16_t addr, struct psw psw);
>  int smp_cpu_stop(uint16_t addr);
>  int smp_cpu_stop_store_status(uint16_t addr);
> +void smp_cpu_wait_for_completion(uint16_t addr);
>  int smp_cpu_destroy(uint16_t addr);
>  int smp_cpu_setup(uint16_t addr, struct psw psw);
>  void smp_teardown(void);
> diff --git a/s390x/smp.c b/s390x/smp.c
> index 7462211..48321f4 100644
> --- a/s390x/smp.c
> +++ b/s390x/smp.c
> @@ -75,6 +75,7 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);
> +	smp_cpu_wait_for_completion(1);
>  	mb();
>  	report(lc->prefix_sa == (uint32_t)(uintptr_t)cpu->lowcore, "prefix");
>  	report(lc->grs_sa[15], "stack");
> @@ -85,6 +86,7 @@ static void test_stop_store_status(void)
>  	lc->prefix_sa = 0;
>  	lc->grs_sa[15] = 0;
>  	smp_cpu_stop_store_status(1);

Just curious: Would it make sense to add that inside
smp_cpu_stop_store_status() instead?

-- 
Thanks,

David / dhildenb

