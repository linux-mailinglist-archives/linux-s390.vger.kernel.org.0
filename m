Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF93290FF1
	for <lists+linux-s390@lfdr.de>; Sat, 17 Oct 2020 08:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411835AbgJQGBi (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Sat, 17 Oct 2020 02:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411646AbgJQGBg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35280C0613E0
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 17:15:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h10so4464105oie.5
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 17:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HVA/kHTRrZhh86c4arn8D36RGtXtr/RQmB9xUt/oL0=;
        b=A32JPmxYsX4aiV3Q14i8uetVyPYmCmRY3iSbBEknLM753yCl6sRwNODCazQzppqqIJ
         eeRKs26pITedApwf8ut6k1PLRquj3D05Z8s+/ChxJbDRQJGzatlEgKBjFnw9a4/neqvp
         dpSpiUwiBBvmbYfNYL1/G4wH0oxKZAX8JhpRgFCbGlRy30fCLiQbUDIaSXiV2WVIG5cw
         50wr8sY+4VtYd6WWQEKOB2L9mYAmMS4QkglCHTlWAeLnUqsY6RkJacC0G6NlwRQ9f/PD
         9iZdeAEmskHhuC7K9IOWwB52yblhhWs3qP80QUsQ5eb+0eA6wAVPknIEGt3SI55ZnKp7
         ImZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=9HVA/kHTRrZhh86c4arn8D36RGtXtr/RQmB9xUt/oL0=;
        b=MB7Wbw/XGyrceNW+TyIDaezr7GqBb2onag76GckIKaa1NT+mU9928076sKbdEuYgT5
         ruTcHS2zBEj2hRm4RrfsZUF1BASPEruVNrTxeaOJ108xEdtA1s/GMWw9USbpBeJcxyg/
         M5bIfC+LFId6u9OSeIRBdys6XTNEWaHxSgzNoBHvzjAV7q+Ae8VcAEY3xy25EPJLxVzd
         4Z7xauiwPPemvWF2qpraiKf6gLGOpfRtTYwIFC5InFGt0pkO7XiSawRNkoMRhbszguxl
         BIEJgaqWzuMeTXutQIBTsSWs2LhvT909Wr11cee7WXsaScoLeKUwXjWQevN+5/1n3leQ
         yFFw==
X-Gm-Message-State: AOAM531/sRqwW88mrZ6UwlUvGCvUU8QoBnyySNYQPOCECuH7swfDIZKf
        GztUnzCJ6NenYMjWAMohGPDWWnEC4+E=
X-Google-Smtp-Source: ABdhPJxEIQBUqjD9PD0rnhNmp6X7P2lHB0FaXSWtbvfWkPo9wcgDasUT4W9banjF8KFzCmVnBN5IBA==
X-Received: by 2002:aca:1115:: with SMTP id 21mr4339969oir.158.1602893703172;
        Fri, 16 Oct 2020 17:15:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t22sm1415452otk.24.2020.10.16.17.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 17:15:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: s390 - buildroot + qemu
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     egorenar@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
 <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
 <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f0164e2d-bb8c-0805-23bb-88443af11ea2@roeck-us.net>
Date:   Fri, 16 Oct 2020 17:15:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/16/20 4:40 PM, Nick Desaulniers wrote:
> On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/16/20 4:11 PM, Nick Desaulniers wrote:
>>> Hello all,
>>> I'm working on integrating the latest release of buildroot (2020.08.1)
>>> into our CI for ClangBuiltLinux.
>>>
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/25
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/26
>>> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
>>>
>>> I'm seeing the following error from QEMU:
>>> KASLR disabled: CPU has no PRNG
>>> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
>>> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
>>> ilc:2
>>> PSW : 0000200180000000 000000000001779e
>>>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
>>> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
>>>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
>>>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
>>>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0
>>>
>>> This is via a kernel built by:
>>> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71 defconfig
>>> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71
>>>
>>> The booting qemu:
>>> $ qemu-system-s390x -M s390-ccw-virtio -append 'rdinit=/bin/sh '
>>> -display none -initrd /android1/boot-utils/images/s390/rootfs.cpio
>>> -kernel /android0/kernel-all/arch/s390/boot/bzImage -m 512m
>>> -nodefaults -serial mon:stdio
>>>
>>> Is there a preferred kernel config or additional flags to QEMU I
>>> should be using to avoid this error?  It's also possible that there's
>>> a bug in the kernel image, but given that it fails very early with no
>>> other output, I am slightly suspicious of that.
>>>
>>
>> Maybe that helps ? From my builders:
>>
>>     # qemu only supports MARCH_Z900. Older kernels select it as default,
>>     # but newer kernels may select MARCH_Z196.
>>     sed -i -e '/CONFIG_MARCH_Z/d' ${defconfig}
>>     sed -i -e '/HAVE_MARCH_Z/d' ${defconfig}
>>     echo "CONFIG_MARCH_Z900=y" >> ${defconfig}
>>     echo "CONFIG_PCI=y" >> ${defconfig}
> 
> $ clang -march=z900 --target=s390x-linux-gnu -c -x c /dev/null -o -
> error: unknown target CPU 'z900'
> note: valid target CPU values are: arch8, z10, arch9, z196, arch10,
> zEC12, arch11, z13, arch12, z14, arch13, z15
> 
> Hopefully qemu supports something newer than Z900?  Or can we change

I don't think it does. I tried several others, and it always says "Some
features requested in the CPU model are not available in the configuration"
If I recall correctly, the s390 qemu is primarily supposed to be used on
real s390 systems, and  the simulator port is not officially supported
by IBM. My memory may defeat me, though.

> arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:

You could give it a try ...

Guenter

> > 252 config MARCH_Z900
> 253   bool "IBM zSeries model z800 and z900"
> 254   select HAVE_MARCH_Z900_FEATURES
> 255   depends on $(cc-option,-march=z900)
> 256   help
> 257     Select this to enable optimizations for model z800/z900 (2064
> and
> 258     2066 series). This will enable some optimizations that are not
> 259     available on older ESA/390 (31 Bit) only CPUs.
> 

