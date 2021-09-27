Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B710419D14
	for <lists+linux-s390@lfdr.de>; Mon, 27 Sep 2021 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbhI0RlQ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 27 Sep 2021 13:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238911AbhI0Rkd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Sep 2021 13:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632764334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jirQ9FfdlhvaJz4asll3MbjWE5MFUvpfdv5thabWi7A=;
        b=iy4tiEGVsMXV/mZtJzo6+jo5P+HM4YI5WMmjrbDnQqP6a5SyvO/xQWwIy3sQmzA20OCFZm
        LpHD1uCaeU1y7ceB8jUBAoL+Ey9rdzXd4bcpfgwNWAKXfDVx2zASLN2SUuBxQBxG8HIfrI
        GNM8CLXldYzYSuNDfWuYdcLbndcgAAo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-R2nWblpcPXGPxEQz63pj6Q-1; Mon, 27 Sep 2021 13:38:53 -0400
X-MC-Unique: R2nWblpcPXGPxEQz63pj6Q-1
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so14342714wrg.17
        for <linux-s390@vger.kernel.org>; Mon, 27 Sep 2021 10:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jirQ9FfdlhvaJz4asll3MbjWE5MFUvpfdv5thabWi7A=;
        b=hF9uM0aMigqfkvJgoU8jHb4LlNw8TdgROt2GA3kJQVOjWxh5M5S9wR9Eorumec2xyc
         +ApCXfJn3vTMNepk+G0hPquhfDQXkZmtlfdIUMhGI26H3KOdQumwrQMx0DOt6mx6d/hi
         F6R/JBqS+L77xytxF0hGvGyb/NIk2gxVHU6EcH+mdBL+o5ecOgIF4cyZk3YGxnJztJ4a
         zSjIYyzZr6TEi4M0erCKG93SI74sx+aQEgdnkhhdf7426qOAyMAYq6Jl7tbWlKEkgZ7W
         xqacFPeUiRxi7+J3B2INSPey6suR+dSE7Vfe0yAox6Dh5AbNwIYkhNbfdci7DUhf1ry5
         D5Nw==
X-Gm-Message-State: AOAM531C9KeJuEA4rNyPZQI4MSSY4vaiI9nyooAOwO7RhJylVnBoytd9
        i31SyLoE3rb+dhFTjuW7O0USaqmwvEsbxIAM8dztonc9PAzFCZM5jyeeeUQdZcsGr1i6U1dI11K
        Ix+fksuC158hdslaHOt1Thg==
X-Received: by 2002:a7b:cc8d:: with SMTP id p13mr334101wma.10.1632764332440;
        Mon, 27 Sep 2021 10:38:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygFnvXthhc22zdk5qwNvouSPfv7jgeqZp4tnutQ46qGYpl4iAodfS+D5/JP8rMpXiaGk50jQ==
X-Received: by 2002:a7b:cc8d:: with SMTP id p13mr334084wma.10.1632764332259;
        Mon, 27 Sep 2021 10:38:52 -0700 (PDT)
Received: from thuth.remote.csb (p549bb2bd.dip0.t-ipconnect.de. [84.155.178.189])
        by smtp.gmail.com with ESMTPSA id s2sm9315667wru.3.2021.09.27.10.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 10:38:51 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 4/9] lib: s390x: uv: Fix share return value
 and print
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     david@redhat.com, linux-s390@vger.kernel.org, seiden@linux.ibm.com,
        imbrenda@linux.ibm.com
References: <20210922071811.1913-1-frankja@linux.ibm.com>
 <20210922071811.1913-5-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <333dcee3-2d66-5e76-bd0e-149ede04ef7a@redhat.com>
Date:   Mon, 27 Sep 2021 19:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922071811.1913-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/09/2021 09.18, Janosch Frank wrote:
> Let's only return 0/1 for success/failure respectively.
> If needed we can later add rc/rrc pointers so we can check for the
> reasons of cc==1 cases like we do in the kernel.
> 
> As share might also be used in snippets it's best not to use prints to

Maybe: s/share/share()/
... so that it is clear that you're talking about the function here...

> avoid linking problems so lets remove the report_info().
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/uv.h | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/lib/s390x/asm/uv.h b/lib/s390x/asm/uv.h
> index ec10d1c4..2f099553 100644
> --- a/lib/s390x/asm/uv.h
> +++ b/lib/s390x/asm/uv.h
> @@ -219,15 +219,8 @@ static inline int share(unsigned long addr, u16 cmd)
>   		.header.len = sizeof(uvcb),
>   		.paddr = addr
>   	};
> -	int cc;
>   
> -	cc = uv_call(0, (u64)&uvcb);
> -	if (!cc && uvcb.header.rc == UVC_RC_EXECUTED)
> -		return 0;
> -
> -	report_info("uv_call: cmd %04x cc %d response code: %04x", cc, cmd,
> -		    uvcb.header.rc);
> -	return -1;
> +	return uv_call(0, (u64)&uvcb);
>   }

Acked-by: Thomas Huth <thuth@redhat.com>

