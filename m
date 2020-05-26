Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54D91E29E3
	for <lists+linux-s390@lfdr.de>; Tue, 26 May 2020 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgEZSQi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 26 May 2020 14:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41701 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727112AbgEZSQi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 26 May 2020 14:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590516996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=nLjXjlHBIkm/XDuvR0aMSKGbwOCZj+vUGdURjBkZE4k=;
        b=EglCR0zkbPI5kTFbKMnL/PGp7zNr0IHjGiVOcRYctLCBzMINikgRmd6LrLe/PAdAX5lBQZ
        G3LeRpK0ofvTbfD4LZe0AwrBZaPLpXofw9fvfFqvWPXcGPIETk1jzrNmbduIj+NPUxHij9
        rETiBbloweuEk80D8eah1O6T24LJIYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-ChwY5mq6NSSJ8OgO7G1sCg-1; Tue, 26 May 2020 14:16:32 -0400
X-MC-Unique: ChwY5mq6NSSJ8OgO7G1sCg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFEA380183C;
        Tue, 26 May 2020 18:16:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B3C979C40;
        Tue, 26 May 2020 18:16:26 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v7 06/12] s390x: use get_clock_ms() to
 calculate a delay in ms
To:     Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a490dc16-b323-5a52-2d29-f4707d89a1d6@redhat.com>
Date:   Tue, 26 May 2020 20:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-7-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 18/05/2020 18.07, Pierre Morel wrote:
> use get_clock_ms() to calculate a delay in ms
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/time.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/lib/s390x/asm/time.h b/lib/s390x/asm/time.h
> index 25c7a3c..931a119 100644
> --- a/lib/s390x/asm/time.h
> +++ b/lib/s390x/asm/time.h
> @@ -23,4 +23,14 @@ static inline uint64_t get_clock_ms(void)
>  	return (clk >> (63 - 51)) / 1000;
>  }
>  
> +static inline void mdelay(unsigned long ms)
> +{
> +	unsigned long startclk;
> +
> +	startclk = get_clock_ms();
> +	for (;;)
> +		if (get_clock_ms() - startclk > ms)
> +			break;

Maybe rather:

    for (;get_clock_ms() - startclk <= ms;)
	;

?
Or:

    while (get_clock_ms() - startclk <= ms)
        ;
?

 Thomas

