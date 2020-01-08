Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51B61134B10
	for <lists+linux-s390@lfdr.de>; Wed,  8 Jan 2020 19:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgAHS6j (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 8 Jan 2020 13:58:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729595AbgAHS6j (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jan 2020 13:58:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578509918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=SttqYECqxm3uTxoSKfzrfwJdZN7awAbuMDdMNcxZWow=;
        b=hAU+ZRwR4yrMrPVxcLN9OuE2YAdvtOeRWCQCvHdFasuzetvxl8ED44CN4zI5+UKp/Pa/X/
        C9C1XGDJfP2xDseNRBMMJ3rcP5khlX3oU5Yja+7eOKxdrXcbmuXU9d6gakegcgAnrMcYgp
        dCot3Wllnxgphpf9ch6wwLOBvuFpzZw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-5EMx4dMDOKiN5DlgOKDcbw-1; Wed, 08 Jan 2020 13:58:34 -0500
X-MC-Unique: 5EMx4dMDOKiN5DlgOKDcbw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1743B800EBF;
        Wed,  8 Jan 2020 18:58:33 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-114.ams2.redhat.com [10.36.117.114])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B3EA9CA3;
        Wed,  8 Jan 2020 18:58:28 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v5 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, david@redhat.com,
        borntraeger@de.ibm.com, frankja@linux.ibm.com
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
 <20200108161317.268928-4-imbrenda@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ff1041f2-0262-ed89-4c5e-386f69d21cd0@redhat.com>
Date:   Wed, 8 Jan 2020 19:58:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200108161317.268928-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/01/2020 17.13, Claudio Imbrenda wrote:
> Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> use it instead of using inline assembly everywhere.

Either some hunks are missing in this patch, or you should update the
patch description and remove the second part of the sentence ? ... at
least I did not spot the changes where you "use it instead of using
inline assembly everywhere".

 Thomas


> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 1a5e3c6..38c9dfa 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -284,4 +284,17 @@ static inline int servc(uint32_t command, unsigned long sccb)
>  	return cc;
>  }
>  
> +static inline void spx(uint32_t new_prefix)
> +{
> +	asm volatile("spx %0" : : "Q" (new_prefix) : "memory");
> +}
> +
> +static inline uint32_t stpx(void)
> +{
> +	uint32_t prefix;
> +
> +	asm volatile("stpx %0" : "=Q" (prefix));
> +	return prefix;
> +}
> +
>  #endif
> 

