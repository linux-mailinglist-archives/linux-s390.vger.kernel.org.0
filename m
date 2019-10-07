Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4D6CECE3
	for <lists+linux-s390@lfdr.de>; Mon,  7 Oct 2019 21:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfJGTga (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 7 Oct 2019 15:36:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbfJGTg3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 7 Oct 2019 15:36:29 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 550C2C065116
        for <linux-s390@vger.kernel.org>; Mon,  7 Oct 2019 19:36:29 +0000 (UTC)
Received: by mail-ed1-f72.google.com with SMTP id p55so9686799edc.5
        for <linux-s390@vger.kernel.org>; Mon, 07 Oct 2019 12:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ljeQp8GB5NCWoYLQPc6omSfgvu4MNul47KparjzcLdc=;
        b=ZjE7CJKajZrbFe0xM7qmDCKFiiE/OPvOvSkq+05yV8hweClH9J2L4HuaRIfxvxeci8
         HfT38OKVG9Uzw1Zro0vztxd4qpQj4yJe1BI6fO+hlr/ZfKKPkGePXm6XXfJ33hX7E0sl
         8Q65xKC/rcp7bIkbG6xjLDlPVJWrjF2jjLsAT7vFmpNKGieOlBPLjavgAGuAKFPSjbol
         JmFzzlfUpxPJqPFg4uvxJ0li43R4GYkjKYJBsq9aGIqG7lsf3+7tU1eGvrzbmTyIJdIR
         xU6z7UaCDk2el8ykQ9iJMmVW/AqMviv9JwURJiqXkWTkhcDt9gxi2R33pfoj1neTuhjY
         /ySQ==
X-Gm-Message-State: APjAAAUccoOJ6f/yi5uyLw8lAgn9jNgCNcUoMipFiBM/zhZB2OLAgTjX
        F0lMlHzmUmhByoXstXJaXIf2+sG/l9ItW4WrhmLnpxWHModSSVl3UcmyK2jjguePuDN4SZkRk46
        a8DJ2fVt914pCpHWWl2K7iQ==
X-Received: by 2002:a17:906:cec3:: with SMTP id si3mr25362432ejb.145.1570476987545;
        Mon, 07 Oct 2019 12:36:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz6Da4NEDWiQMcaC9fAtmpy1da8A1+7AzwgtoUpoptiUpd1fibFowoiKw31dJ8eZhCyne3fDw==
X-Received: by 2002:a17:906:cec3:: with SMTP id si3mr25362409ejb.145.1570476987315;
        Mon, 07 Oct 2019 12:36:27 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c14-2800-ec23-a060-24d5-2453.cable.dynamic.v6.ziggo.nl. [2001:1c00:c14:2800:ec23:a060:24d5:2453])
        by smtp.gmail.com with ESMTPSA id x5sm1967822ejc.53.2019.10.07.12.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 12:36:26 -0700 (PDT)
Subject: Re: [PATCH v2 5.4 regression fix] x86/boot: Provide memzero_explicit
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Stephan Mueller <smueller@chronox.de>,
        linux-s390@vger.kernel.org
References: <20191007134724.4019-1-hdegoede@redhat.com>
 <20191007140022.GA29008@gmail.com>
 <1dc3c53d-785e-f9a4-1b4c-3374c94ae0a7@redhat.com>
 <20191007142230.GA117630@gmail.com>
 <2982b666-e310-afb7-40eb-e536ce95e23d@redhat.com>
 <20191007144600.GB59713@gmail.com>
 <20191007152049.GA384920@rani.riverdale.lan>
 <20191007154007.GA96929@gmail.com>
 <20191007184237.GB13589@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1d17349e-98ab-b582-6981-b484b0e970b6@redhat.com>
Date:   Mon, 7 Oct 2019 21:36:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191007184237.GB13589@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

On 07-10-2019 20:42, Arvind Sankar wrote:
> On Mon, Oct 07, 2019 at 05:40:07PM +0200, Ingo Molnar wrote:
>>
>> * Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>
>>> With the barrier in there, is there any reason to *not* inline the
>>> function? barrier_data() is an asm statement that tells the compiler
>>> that the asm uses the memory that was set to zero, thus preventing it
>>> from removing the memset even if nothing else uses that memory later. A
>>> more detailed comment is there in compiler-gcc.h. I can't see why it
>>> wouldn't work even if it were inlined.
>>>
>>> If the function can indeed be inlined, we could just make the common
>>> implementation a macro and avoid duplicating it? As mentioned in another
>>> mail, we otherwise will likely need another duplicate implementation for
>>> arch/s390/purgatory as well.
>>
>> I suspect macro would be justified in this case. Mind sending a v3 patch
>> to demonstrate how it would all look like?
>>
>> I'll zap v2 if the macro solution looks better.
>>
>> Thanks,
>>
>> 	Ingo
> 
> Patch attached to turn memzero_explicit into inline function.

Hehe, I had prepared and have just tested the exact same patch
(only the commit msg was different).

I've just booted a kernel build with that patch and that works
fine (as expected).

So your patch is:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Hans de Goede <hdegoede@redhat.com>

Since this is a bit of a core change though, I think it is
best if you send it to the linux-kernel list (with my tags from above
added) as is normally done for kernel patches. Then others, who may
not be following this thread, will get a chance to give feedback on it.

Regards,

Hans
