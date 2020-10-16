Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8590C290E16
	for <lists+linux-s390@lfdr.de>; Sat, 17 Oct 2020 01:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411158AbgJPXSV (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 16 Oct 2020 19:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411155AbgJPXSV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Oct 2020 19:18:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301FFC061755
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 16:18:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id e20so4038323otj.11
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 16:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yFeodx+++6H5IZCOudFZ+pFMKNbTTXh7U0LTT5CQ2ME=;
        b=G/y9mwpYwfCBZ7L8EYvajSXDDDDPJ7fc7fxX3Rz4h7uNmPpuywbv5dpRxd/muyXagu
         Sb/ig1y4WIGdz9fRVHnOOzW0auLUyhB+O7LAVENs+1CJx/iOFbJ39HUik8Z9Zmfpj+fq
         /3MAw29/QNCeUB0E55u1BxPivMN7joVioWaE4uEIYhrdwNUhs6HJJ2Fqqb5jNOagxZcD
         nrcxwum8PrxCMs+HZ7oSf2eUhL8HcM/jr5fI13U87bQIfgg8QmM/igCPle28BV39P8dZ
         S8We2eZQIE0F2vzmO8/pu24FmZ5nNQsNFlebiTpdYLYBzoig+qM9oZaObG48EdUB8oe9
         Oc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=yFeodx+++6H5IZCOudFZ+pFMKNbTTXh7U0LTT5CQ2ME=;
        b=rcVemO14pcHo5eP4MBlexOgJOAmBptrWW8evrNuoBKuTwy3XnmrT/PH7bi52sZMwDX
         EDqPs1lRrTgsJUqctsza5v+QTydLlOHJPZ2ouApVArtTIKovhMnOKlxuR+PulYk588JC
         BJzU3ym2t4pmOFkSb1KFheuMGoYX8aQc0ZPfDH8+uKDRtJB0W+PVOytXcmvUzPZEaGyg
         vRu39sMlKMz2N1hQ42JyfyPsGIxVpqN2PoyxL28SwozpNepHvzV91VR4H8nhPZt3WSNX
         RUGInxiQsMdl+kb+UffWBJXna3ZOh+iD5NtTIpAX4UZvr5b93PXxiEH2wSu2TCxoexMt
         PlVw==
X-Gm-Message-State: AOAM531pQ53aDKIziOPySAmHAbF98fB5iFERwOkyn/4riBD5Rk9CP2DN
        hrYLV0SZ/VVmQicPHBIBaf3g5KtgulM=
X-Google-Smtp-Source: ABdhPJxIKg4/w1kHcsDbNUJ1XnfwyB2aAQTQjBSzAYQQiX2qMkph692r8qo7DUxJOXJX4UYvI2qpdA==
X-Received: by 2002:a05:6830:1d8e:: with SMTP id y14mr4468843oti.267.1602890300390;
        Fri, 16 Oct 2020 16:18:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o10sm1475450oib.1.2020.10.16.16.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 16:18:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: s390 - buildroot + qemu
To:     Nick Desaulniers <ndesaulniers@google.com>, egorenar@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     Joel Stanley <joel@jms.id.au>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
Date:   Fri, 16 Oct 2020 16:18:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/16/20 4:11 PM, Nick Desaulniers wrote:
> Hello all,
> I'm working on integrating the latest release of buildroot (2020.08.1)
> into our CI for ClangBuiltLinux.
> 
> https://github.com/ClangBuiltLinux/boot-utils/pull/25
> https://github.com/ClangBuiltLinux/boot-utils/pull/26
> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
> 
> I'm seeing the following error from QEMU:
> KASLR disabled: CPU has no PRNG
> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
> ilc:2
> PSW : 0000200180000000 000000000001779e
>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0
> 
> This is via a kernel built by:
> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71 defconfig
> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71
> 
> The booting qemu:
> $ qemu-system-s390x -M s390-ccw-virtio -append 'rdinit=/bin/sh '
> -display none -initrd /android1/boot-utils/images/s390/rootfs.cpio
> -kernel /android0/kernel-all/arch/s390/boot/bzImage -m 512m
> -nodefaults -serial mon:stdio
> 
> Is there a preferred kernel config or additional flags to QEMU I
> should be using to avoid this error?  It's also possible that there's
> a bug in the kernel image, but given that it fails very early with no
> other output, I am slightly suspicious of that.
> 

Maybe that helps ? From my builders:

    # qemu only supports MARCH_Z900. Older kernels select it as default,
    # but newer kernels may select MARCH_Z196.
    sed -i -e '/CONFIG_MARCH_Z/d' ${defconfig}
    sed -i -e '/HAVE_MARCH_Z/d' ${defconfig}
    echo "CONFIG_MARCH_Z900=y" >> ${defconfig}
    echo "CONFIG_PCI=y" >> ${defconfig}

Guenter
