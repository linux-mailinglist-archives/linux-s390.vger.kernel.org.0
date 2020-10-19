Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9975C2926A3
	for <lists+linux-s390@lfdr.de>; Mon, 19 Oct 2020 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgJSLpJ (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 19 Oct 2020 07:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42235 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgJSLpJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 19 Oct 2020 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603107908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9MhPh8Vfa3e/5KEXVGAJdVdkMkQHofFaBZvRbNELhvM=;
        b=PEuOGKUzCLBgyU6tJTQKGrJf3V/zQOJPkRMYTB1R9wwxKKxaOCGBiccF6tJ5dR9E1OqBxo
        jNjxa+75D3K8B0M4+XsnxUyWs09gKLvTLVqetvRNGiW7ReOBPNKAazS3NgSMrY8Tm87A2F
        Hd+6YcaYWfToLMHLX8/TaQI8t8rqOyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-55wiP8rZPaai-BJMuRA9bw-1; Mon, 19 Oct 2020 07:45:03 -0400
X-MC-Unique: 55wiP8rZPaai-BJMuRA9bw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 655EA1074646;
        Mon, 19 Oct 2020 11:45:01 +0000 (UTC)
Received: from gondolin (ovpn-115-105.ams2.redhat.com [10.36.115.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B1F81002382;
        Mon, 19 Oct 2020 11:44:59 +0000 (UTC)
Date:   Mon, 19 Oct 2020 13:44:56 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, egorenar@linux.ibm.com,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: s390 - buildroot + qemu
Message-ID: <20201019134456.21a7bda9.cohuck@redhat.com>
In-Reply-To: <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
        <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
        <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 16 Oct 2020 16:40:43 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:

> > Maybe that helps ? From my builders:
> >
> >     # qemu only supports MARCH_Z900. Older kernels select it as default,
> >     # but newer kernels may select MARCH_Z196.
> >     sed -i -e '/CONFIG_MARCH_Z/d' ${defconfig}
> >     sed -i -e '/HAVE_MARCH_Z/d' ${defconfig}
> >     echo "CONFIG_MARCH_Z900=y" >> ${defconfig}
> >     echo "CONFIG_PCI=y" >> ${defconfig}  
> 
> $ clang -march=z900 --target=s390x-linux-gnu -c -x c /dev/null -o -
> error: unknown target CPU 'z900'
> note: valid target CPU values are: arch8, z10, arch9, z196, arch10,
> zEC12, arch11, z13, arch12, z14, arch13, z15
> 
> Hopefully qemu supports something newer than Z900? 

Current QEMU/TCG with the 'qemu' cpu model with give you a
stripped-down z13 that should run fine if you compile to z13. (There's
work ongoing to bump this even to a stripped-down z14, but that needs
some more time.) Anything prior to z13 should be fine as well.

> Or can we change
> arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:

My understanding is arch8 == z10 and so on.

> 
> 252 config MARCH_Z900
> 253   bool "IBM zSeries model z800 and z900"
> 254   select HAVE_MARCH_Z900_FEATURES
> 255   depends on $(cc-option,-march=z900)
> 256   help
> 257     Select this to enable optimizations for model z800/z900 (2064
> and
> 258     2066 series). This will enable some optimizations that are not
> 259     available on older ESA/390 (31 Bit) only CPUs.

