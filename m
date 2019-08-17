Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE4A90F78
	for <lists+linux-s390@lfdr.de>; Sat, 17 Aug 2019 10:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfHQI2H (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Aug 2019 04:28:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45789 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfHQI2H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 17 Aug 2019 04:28:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id x19so7020636eda.12
        for <linux-s390@vger.kernel.org>; Sat, 17 Aug 2019 01:28:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGByj43V4T8nAqTozj7dDB6qHI2gcS79MAeL84ybVrU=;
        b=FpWX4+wNCAsOEPQmG4zDdoznD+XyKX8IeovhUebq6hjc1QxodtW0xWm12FPOxbzC37
         tDWGZmTrMi6vPvnDkuBo3Vtl+13yaSIbG/TGjCB3Jink2IQn+O9SXk1cfQ3UdVlDpML8
         51Kry/o55oHEvClSZmWpaoLu2il9ZlZ1ew+YbhPqwEHc2OxgNPttK1O/UZ9q/3wZc6I2
         igk3bABTmK2OL6NkvQ0PVIzopIQ76KkBHA1IK7kwVfQPLtiEcQg1hPZPERzjh6UnKYn2
         crqxW63bhWu4eb+O/SlphfY8vrS3Y39j7yIvcrYyGzTPY/U0xVhDPyy3yErLXftFND/N
         DqUw==
X-Gm-Message-State: APjAAAWsM1EkDsA2ztHF55v9Ew0UVM68wMgf1LfS10Ucvbgv/vv9mZvu
        nT7uat7cLnYywDylX1mYaV7+Pw==
X-Google-Smtp-Source: APXvYqyldH64Fl/cJU0xJFoHIoSYIEu7aVtzlIYMBK8z93yWrTlW6TgFzU8e8oaQEP5O8F7Ekr0RHw==
X-Received: by 2002:a17:906:578a:: with SMTP id k10mr12623742ejq.235.1566030485927;
        Sat, 17 Aug 2019 01:28:05 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id um15sm1133948ejb.27.2019.08.17.01.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Aug 2019 01:28:05 -0700 (PDT)
Subject: Re: [PATCH 3/6] crypto: sha256 - Move lib/sha256.c to lib/crypto
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190816211611.2568-1-hdegoede@redhat.com>
 <20190816211611.2568-4-hdegoede@redhat.com>
 <20190817051942.GB8209@sol.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <909d255d-a648-13b5-100f-fe67be547961@redhat.com>
Date:   Sat, 17 Aug 2019 10:28:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190817051942.GB8209@sol.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi,

On 17-08-19 07:19, Eric Biggers wrote:
> On Fri, Aug 16, 2019 at 11:16:08PM +0200, Hans de Goede wrote:
>> diff --git a/include/linux/sha256.h b/include/crypto/sha256.h
>> similarity index 100%
>> rename from include/linux/sha256.h
>> rename to include/crypto/sha256.h
> 
> <crypto/sha.h> already has the declarations for both SHA-1 and SHA-2, including
> SHA-256.  So I'm not sure a separate sha256.h is appropriate.  How about putting
> these declarations in <crypto/sha.h>?

The problems with that is that the sha256_init, etc. names are quite generic
and they have not been reserved before, so a lot of the crypto hw-accel
drivers use them, for private file-local (static) code, e.g.:

[hans@shalem linux]$ ack -l sha256_init
include/crypto/sha256.h
drivers/crypto/marvell/hash.c
drivers/crypto/ccp/ccp-ops.c
drivers/crypto/nx/nx-sha256.c
drivers/crypto/ux500/hash/hash_core.c
drivers/crypto/inside-secure/safexcel_hash.c
drivers/crypto/chelsio/chcr_algo.h
drivers/crypto/stm32/stm32-hash.c
drivers/crypto/omap-sham.c
drivers/crypto/padlock-sha.c
drivers/crypto/n2_core.c
drivers/crypto/atmel-aes.c
drivers/crypto/axis/artpec6_crypto.c
drivers/crypto/mediatek/mtk-sha.c
drivers/crypto/qat/qat_common/qat_algs.c
drivers/crypto/img-hash.c
drivers/crypto/ccree/cc_hash.c
lib/crypto/sha256.c
arch/powerpc/crypto/sha256-spe-glue.c
arch/mips/cavium-octeon/crypto/octeon-sha256.c
arch/x86/purgatory/purgatory.c
arch/s390/crypto/sha256_s390.c
arch/s390/purgatory/purgatory.c

(in case you do not know ack is a smarter grep, which skips .o files, etc.)

All these do include crypto/sha.h and putting the stuff which is in what
was linux/sha256.h into crypto/sha.h leads to name collisions which causes
more churn then I would like this series to cause.

I guess we could do a cleanup afterwards, with one patch per file above
to fix the name collision issue, and then merge the 2 headers. I do not
want to do that for this series, as I want to keep this series as KISS
as possible since it is messing with somewhat sensitive stuff.

And TBH I even wonder if a follow-up series is worth the churn...

Regards,

Hans

