Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4572FA35D
	for <lists+linux-s390@lfdr.de>; Mon, 18 Jan 2021 15:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392959AbhAROnc (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Jan 2021 09:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2393146AbhAROlx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 09:41:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610980826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3N+dhxnbZmYIKc/JsDsi75PS42RwpRCaMA9h1SbChv8=;
        b=RgolPhPjCSCkShmancSNFqJ4mTHgB+p6WcO41H/m5+RpZf3BIYjklbNPiJK0yXT8+XNeZH
        7KX3ldgsE20FGZwe0qwPHUs+YMMSDHxwK5rRry5FJYVxWF/G4Ymn66B+hPMXIUtsyssGa2
        pR6uOoi08rJjEGr+pD4Bj1em3IiZMIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-vf1ppQGENJK1Agf0jFFiQg-1; Mon, 18 Jan 2021 09:40:24 -0500
X-MC-Unique: vf1ppQGENJK1Agf0jFFiQg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D2E51800D41;
        Mon, 18 Jan 2021 14:40:23 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-189.ams2.redhat.com [10.36.112.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC00071C92;
        Mon, 18 Jan 2021 14:40:10 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix uv_call() exception behavior
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org
References: <20210118140344.3074-1-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <4d402c02-c75a-5a9e-6f02-87a513864e0d@redhat.com>
Date:   Mon, 18 Jan 2021 15:40:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118140344.3074-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/01/2021 15.03, Janosch Frank wrote:
> On a program exception we usually skip the instruction that caused the
> exception and continue. That won't work for UV calls since a "brc 3,0b"
> will retry the instruction if the CC is > 1.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> I know this isn't very pretty.
> I'm open for suggestions.
> 
> ---
>   lib/s390x/asm/uv.h | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index 4c2fc48..252f1a3 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -53,21 +53,23 @@ struct uv_cb_share {
>   static inline int uv_call(unsigned long r1, unsigned long r2)
>   {
>   	int cc;
> +	struct lowcore *lc = 0x0;
>   
>   	/*
> -	 * The brc instruction will take care of the cc 2/3 case where
> -	 * we need to continue the execution because we were
> -	 * interrupted. The inline assembly will only return on
> -	 * success/error i.e. cc 0/1.
> -	*/
> +	 * CC 2 and 3 tell us to re-execute because the instruction
> +	 * hasn't yet finished.
> +	 */
> +	lc->pgm_int_code = 0;
> +retry:
>   	asm volatile(
>   		"0:	.insn rrf,0xB9A40000,%[r1],%[r2],0,0\n"
> -		"		brc	3,0b\n"
>   		"		ipm	%[cc]\n"
>   		"		srl	%[cc],28\n"
>   		: [cc] "=d" (cc)
>   		: [r1] "a" (r1), [r2] "a" (r2)
>   		: "memory", "cc");
> +	if (!lc->pgm_int_code && cc > 1)
> +		goto retry;

Why not simply:

	do {
		asm volatile(...);
	} while (!lc->pgm_int_code && cc > 1)

?

   Thomas

