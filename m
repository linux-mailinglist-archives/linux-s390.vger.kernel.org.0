Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F43A7D5ECA
	for <lists+linux-s390@lfdr.de>; Wed, 25 Oct 2023 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344685AbjJXXqL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 24 Oct 2023 19:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344663AbjJXXqK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 Oct 2023 19:46:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB79BA2
        for <linux-s390@vger.kernel.org>; Tue, 24 Oct 2023 16:46:06 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6b7f0170d7bso4817761b3a.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Oct 2023 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698191166; x=1698795966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SQudVLvWcmKYsHmvQvFrVCaGB2Fcdq9CCmdIycleMZc=;
        b=d4HejUPW5ZWDx7e3B3/tc11iOAub3J1eabAz9/VwkgoG8TPj2Qv0YZsQuBMYJjRBvg
         X6hHqM9U1RbN309fPAFxkDcMZf1ng5IILGzL5cD9MSCOfLfU1qUbRDmrnx/1jGDTvPUH
         fbrgDenpvSVFn0l+l4x0iVebIGj2mTJWW6Wn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698191166; x=1698795966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQudVLvWcmKYsHmvQvFrVCaGB2Fcdq9CCmdIycleMZc=;
        b=EVfjX5gEOF4HCfmUsN/gWZU3olCldMoKb7+DYuDZXLGX8mRM5nNeCT3AKvwVm1OFmc
         5Nm3kZ5V3+p6+Fx8Prg1ohnctV+WCWpUB9DtM9AHlCy2yrff+diIIJZHAVm951vLTQWS
         qJEjc9V/MZOnoZIn1SO/V3+US2LzSyGNS9zXakIar9X33g82UuluFcerw8+kKV3Rl+VW
         boMrE8z5oR77Y/rfjdVvX3JUVlZg7YBJCpWyE6xQwIdT3d7JqawUKftqNdxqe5XO7MJu
         C69Gr5d0GPDXccJkkco0c96/qvB994gvdy6pbNdNR6Ehf1X7tlw5spNlbT5Yi4l4KCl2
         IekQ==
X-Gm-Message-State: AOJu0YwQWEYKUdsno46SzhFOTp4UTQBls7RjNavz5DrGJoe+K0a1GDO1
        xI9uQfqzHn4OOBPa2J/rmlKQPg==
X-Google-Smtp-Source: AGHT+IG9D2Aw99ZWyxncC7MZP37o9nAmXlhaRrCgASEzu3QBvsK5SxQS81VWgUJOGHj36wsSLEIUSA==
X-Received: by 2002:a05:6a20:7487:b0:16b:74db:8fe1 with SMTP id p7-20020a056a20748700b0016b74db8fe1mr4383675pzd.29.1698191166190;
        Tue, 24 Oct 2023 16:46:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a00000a00b00688435a9915sm8177865pfk.189.2023.10.24.16.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 16:46:05 -0700 (PDT)
Date:   Tue, 24 Oct 2023 16:46:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Justin Stitt <justinstitt@google.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] s390/sclp: replace deprecated strncpy with strtomem
Message-ID: <202310241645.62B11FE65@keescook>
References: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023-strncpy-drivers-s390-char-sclp-c-v1-1-eaeef80522bb@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 23, 2023 at 07:14:49PM +0000, Justin Stitt wrote:
> Let's move away from using strncpy() as it is deprecated [1].
> 
> Instead use strtomem() as `e.id` is already marked as nonstring:
> |       char id[4] __nonstring;

I'm surprised the compiler didn't complain about this -- I thought that
was the point of the __nonstring attribute: to diagnose when used with a
string function. Hmpf.

> 
> We don't need strtomem_pad() because `e` is already memset to 0 --
> rendering any additional NUL-padding useless.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.
> 
> Found with: $ rg "strncpy\("
> ---
>  drivers/s390/char/sclp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
> index 8f74db689a0c..486cf57a1605 100644
> --- a/drivers/s390/char/sclp.c
> +++ b/drivers/s390/char/sclp.c
> @@ -81,7 +81,7 @@ static inline void sclp_trace(int prio, char *id, u32 a, u64 b, bool err)
>  	struct sclp_trace_entry e;
>  
>  	memset(&e, 0, sizeof(e));
> -	strncpy(e.id, id, sizeof(e.id));
> +	strtomem(e.id, id);

Looks right to me; thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>  	e.a = a;
>  	e.b = b;
>  	debug_event(&sclp_debug, prio, &e, sizeof(e));
> 
> ---
> base-commit: 9c5d00cb7b6bbc5a7965d9ab7d223b5402d1f02c
> change-id: 20231023-strncpy-drivers-s390-char-sclp-c-bb66226a7eaa
> 
> Best regards,
> --
> Justin Stitt <justinstitt@google.com>
> 
> 

-- 
Kees Cook
