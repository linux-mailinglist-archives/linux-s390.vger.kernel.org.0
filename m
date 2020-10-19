Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489F92930E4
	for <lists+linux-s390@lfdr.de>; Tue, 20 Oct 2020 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgJSWDX (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Oct 2020 18:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387747AbgJSWDX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 19 Oct 2020 18:03:23 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22348C0613CE
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2020 15:03:23 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id q136so1761662oic.8
        for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2020 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dl1YdIVr5wZ1kujV5dB8ERFijWDPmZI8HY91ssXfEbM=;
        b=f/DuA6aPvvQF+pjuwSawwnxm2QJp66XtrYzpSfZ3vp7mmnm0JGIzNPEwu2wTmTi7OG
         E/vqxzcPbZpH0LyPtAOqMWcXIvOoIFEiEMlU8qToEXbGvGCJSEm/lGTMRYAn457wKjwY
         lg8fhqPbXRrjQ1Ab4Oc/LS49hG/oNK1+A2u1OM42/uRR1fqm9FokR2NdvVYXvEaf2yPh
         ONmQNEUIJ9TCqJ/f4h+dEu6Kf0x/7VSLa4tru3z4hTB4phtc1FL0ePDZ3TonVbnZtZw1
         gWdf/j/hhEEtNEzw3C0+h1/rj2Xk0GvGUUHgpOEhySl338cIWoAeknywWP69W0aILka9
         imLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=dl1YdIVr5wZ1kujV5dB8ERFijWDPmZI8HY91ssXfEbM=;
        b=pDmMw4g/Vvj6gbVExOnSkYkRGTR++ncf5s6FkESyZsGnj1GeRDWCakxjz7Uf1aGtA7
         XJs2n4JMRZGF5aJ0+t3FZcRnQr16ZZHupkgKPU/41Hh9q4qFhSifGRc+/JDrqabk/ZzC
         RS3X357n1nzStHkHzW9fI4KONU5GB7WoicllakHMz4P27AkLKFnXF2V3ZKULi1KrKQbY
         GXoM03epJMe4qfKefIxFg9sWXzLrJ78snn5Kl43gTjYtFPZTs8T3VajMp5mUVLZIj1Ej
         BqwoT1+MXi6hGWLPLG/04+aSEdVUT81IoXdiKep1IAeZUUeJ8Rqhb61cKzpcVRx4xaw6
         wRRg==
X-Gm-Message-State: AOAM532iQA8UELIZ96Zhz1Bu201G1CSxyb8/Dr3D4nSw9y6plTTmmkt2
        jEq1Rmn3lxBpj/EEr6OVqHQ99je8XHk=
X-Google-Smtp-Source: ABdhPJxo2dqLTa/vdDaAmgWqtSi/+N9syYDsm6w61/dJtmMizGHSyI/IaScodYzChpjWrfgu2fosEw==
X-Received: by 2002:aca:3a46:: with SMTP id h67mr1116124oia.21.1603145002176;
        Mon, 19 Oct 2020 15:03:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h4sm352647oot.45.2020.10.19.15.03.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2020 15:03:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: s390 - buildroot + qemu
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     egorenar@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
 <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
 <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
 <c461496a-1ea4-4d44-4913-950cabcd3e31@de.ibm.com>
 <CAKwvOdnn=i_Jg4B5o4sh2mRNGY9aH1piXoBYwEB4E3PpWZM5bw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f21e2581-a115-d958-5d83-fe094d92c292@roeck-us.net>
Date:   Mon, 19 Oct 2020 15:03:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnn=i_Jg4B5o4sh2mRNGY9aH1piXoBYwEB4E3PpWZM5bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 10/19/20 2:36 PM, Nick Desaulniers wrote:
> On Mon, Oct 19, 2020 at 3:55 AM Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>>
>>
>> On 17.10.20 01:40, Nick Desaulniers wrote:
>>> On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>
>>>> On 10/16/20 4:11 PM, Nick Desaulniers wrote:
>>>>> Hello all,
>>>>> I'm working on integrating the latest release of buildroot (2020.08.1)
>>>>> into our CI for ClangBuiltLinux.
>>>>>
>>>>> https://github.com/ClangBuiltLinux/boot-utils/pull/25
>>>>> https://github.com/ClangBuiltLinux/boot-utils/pull/26
>>>>> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
>>>>>
>>>>> I'm seeing the following error from QEMU:
>>>>> KASLR disabled: CPU has no PRNG
>>>>> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
>>>>> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
>>>>> ilc:2
>>>>> PSW : 0000200180000000 000000000001779e
>>>>>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
>>>>> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
>>>>>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
>>>>>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
>>>>>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0
>>
>> Do you have more information? If not, any chance to run objdump on the kernel
>> and check what instructions do you have aroung address 0x1779e
>> [...]
> 
> Is PSW the program counter?
> /me skims https://www.kernel.org/doc/Documentation/s390/Debugging390.txt *woah*
> Is there something more specific I should be running than:
> $ s390x-linux-gnu-objdump -Dr vmlinux | grep 179fe
> because I get lots of hits for that, but not 0x179fe.
> 
> In fact, the first symbol starts at 0x100000. Unless this is a failure
> in the image decompressor?
> 
>>
>>> Hopefully qemu supports something newer than Z900?  Or can we change
>>> arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:
>>
>> Newer QEMUs do support up to z13, so I think this is not an issue as long
>> as you have an uptodate qemu.
> 
> $ qemu-system-s390x --version
> QEMU emulator version 5.1.0 (Debian 1:5.1+dfsg-4)
> 
I found that you have to run "qemu-system-s390x -cpu qemu ...". I was able
to boot s390 defconfig without changes after doing that.

Guenter

