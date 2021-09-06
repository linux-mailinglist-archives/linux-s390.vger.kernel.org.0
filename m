Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC56401A45
	for <lists+linux-s390@lfdr.de>; Mon,  6 Sep 2021 12:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbhIFK7h (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 6 Sep 2021 06:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240963AbhIFK7g (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Sep 2021 06:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630925912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1RDA8Bk3nt+swtUOnWsFb/ykCw+znhVEXQGv+yky4p8=;
        b=YTHGZNAu07rEVIoARTlILYYr+5WIMVV+tiC5bDesCTSfJleprUnjhzdiuL402N98tJOaCz
        mtDtFxfslDaAvH8eLQ7D0oVAI9sAZYe8uk3kyg8F+9Q5GcMzOz9/Si0Kla+Nfdgjlr9oit
        6oTglZwBC1JrFr6eKKMyXlhSk6xQV7g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-auNR85bgOPCrpwZRa--Qdg-1; Mon, 06 Sep 2021 06:58:31 -0400
X-MC-Unique: auNR85bgOPCrpwZRa--Qdg-1
Received: by mail-ej1-f71.google.com with SMTP id r21-20020a1709067055b02904be5f536463so2203463ejj.0
        for <linux-s390@vger.kernel.org>; Mon, 06 Sep 2021 03:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1RDA8Bk3nt+swtUOnWsFb/ykCw+znhVEXQGv+yky4p8=;
        b=Mqr6pwnN9cHgvAUvQKb/602l47X0vtxXOmlUZDxdAjkXpDesR0vy3aV6L1h211Uflj
         mIax/B+QYspHnnTvVajT/pFldcNTZ6q7/a+08K7NRahfVaGZYDUU6aFrAGBk35mR5XHC
         fIfTj7XlYsXLd8WWZrLmlFqp4oks2ZzpabHRBNmW++Z9jia3YbRKanz/FeZ6zPJ6oUEg
         XAjXGZvXxBOwNyZ6UAMcMn8xC6mAzNikiScCMB5wPbEgLwdq9Py9ONhWGnoTfA1T018N
         vCJWf7Fi47MMaV0z3Dh52MeYBTz9+6WUSXJ2gn1PFgnYRX9XIi8VOom3vQzoVjVMjkIr
         /VwQ==
X-Gm-Message-State: AOAM532Ff+fjSCLi5fSebr5RIDbDGZl6sUZ+tMPVOAnyPD8T+1ENpwYP
        mfSl4mJnN2Bc+QsFXH5Z53VJA1zZ+KPSIEkxslGxWelV01WzQcc9yNJeZXWOqCN2oDazq424VzY
        EsGQD+8ChYniL9VpCTDc2Dg==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr12573282ejo.54.1630925910059;
        Mon, 06 Sep 2021 03:58:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWrX2GgCzwIGIlvdKnLO5nw6k3AjkJdy6n1BkDhKb1omv4ojZVj6K69QMmQGj9nmdtLh4Dng==
X-Received: by 2002:a17:906:5408:: with SMTP id q8mr12573265ejo.54.1630925909864;
        Mon, 06 Sep 2021 03:58:29 -0700 (PDT)
Received: from gator.home (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id cn16sm4433015edb.87.2021.09.06.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 03:58:29 -0700 (PDT)
Date:   Mon, 6 Sep 2021 12:58:27 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>
Cc:     thuth@redhat.com, pbonzini@redhat.com, lvivier@redhat.com,
        kvm-ppc@vger.kernel.org, david@redhat.com, frankja@linux.ibm.com,
        cohuck@redhat.com, imbrenda@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, andre.przywara@arm.com,
        maz@kernel.org, vivek.gautam@arm.com
Subject: Re: [kvm-unit-tests RFC PATCH 1/5] lib: arm: Print test exit status
 on exit if chr-testdev is not available
Message-ID: <20210906105827.wneqtlrsgbz3pxk5@gator.home>
References: <20210702163122.96110-1-alexandru.elisei@arm.com>
 <20210702163122.96110-2-alexandru.elisei@arm.com>
 <20210712163647.oxntpjapur4z23sl@gator>
 <7814beab-547e-98d9-9aa0-3b7e5afd803b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7814beab-547e-98d9-9aa0-3b7e5afd803b@arm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 06, 2021 at 11:20:31AM +0100, Alexandru Elisei wrote:
> Hi Drew,
> 
> Sorry for taking so long to reply, been busy with other things.
> 
> On 7/12/21 5:36 PM, Andrew Jones wrote:
> > On Fri, Jul 02, 2021 at 05:31:18PM +0100, Alexandru Elisei wrote:
> >> The arm64 tests can be run under kvmtool, which doesn't emulate a
> >> chr-testdev device. In preparation for adding run script support for
> >> kvmtool, print the test exit status so the scripts can pick it up and
> >> correctly mark the test as pass or fail.
> >>
> >> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >> ---
> >>  lib/chr-testdev.h |  1 +
> >>  lib/arm/io.c      | 10 +++++++++-
> >>  lib/chr-testdev.c |  5 +++++
> >>  3 files changed, 15 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/chr-testdev.h b/lib/chr-testdev.h
> >> index ffd9a851aa9b..09b4b424670e 100644
> >> --- a/lib/chr-testdev.h
> >> +++ b/lib/chr-testdev.h
> >> @@ -11,4 +11,5 @@
> >>   */
> >>  extern void chr_testdev_init(void);
> >>  extern void chr_testdev_exit(int code);
> >> +extern bool chr_testdev_available(void);
> >>  #endif
> >> diff --git a/lib/arm/io.c b/lib/arm/io.c
> >> index 343e10822263..9e62b571a91b 100644
> >> --- a/lib/arm/io.c
> >> +++ b/lib/arm/io.c
> >> @@ -125,7 +125,15 @@ extern void halt(int code);
> >>  
> >>  void exit(int code)
> >>  {
> >> -	chr_testdev_exit(code);
> >> +	if (chr_testdev_available()) {
> >> +		chr_testdev_exit(code);
> > chr_testdev_exit() already has a 'if !vcon goto out' in it, so you can
> > just call it unconditionally. No need for chr_testdev_available().
> 
> I'm not sure what you mean. There has to be a way to check if chr-testdev is
> available, and if it's not present on the system, to print the EXIT: STATUS
> message, and vcon is static in chr-testdev.c.
> 
> Are you suggesting that we move the message to chr_testdev_exit(code)?

I'm saying you can unconditionally call chr_testdev_exit(), because it
only conditionally does anything, and on the same condition that you're
adding (vcon != NULL). 

$ /usr/bin/qemu-system-aarch64 -nodefaults -machine virt,accel=tcg -cpu cortex-a57 -device virtio-serial-device -device virtconsole,chardev=ctd -chardev testdev,id=ctd -device pci-testdev -display none -serial stdio -kernel arm/selftest.flat
ABORT: selftest: no test specified
SUMMARY: 0 tests
$ echo $?
127
$ /usr/bin/qemu-system-aarch64 -nodefaults -machine virt,accel=tcg -cpu cortex-a57 -display none -serial stdio -kernel arm/selftest.flat
ABORT: selftest: no test specified
SUMMARY: 0 tests
$ echo $?
0

See, no explosions when the device is removed. Just a lack of return code.

Also, since chr_testdev_exit() exits, any calls after it won't happen. So
the exit print statement doesn't need to be in an else clause. That said,
I think the print statement should come first in order to also put it in
the qemu output logs. We might as well have consistent output between qemu
and kvmtool.

Thanks,
drew


> 
> Thanks,
> 
> Alex
> 
> >
> >> +	} else {
> >> +		/*
> >> +		 * Print the test return code in the format used by chr-testdev
> >> +		 * so the runner script can parse it.
> >> +		 */
> >> +		printf("\nEXIT: STATUS=%d\n", ((code) << 1) | 1);
> >> +	}
> >>  	psci_system_off();
> >>  	halt(code);
> >>  	__builtin_unreachable();
> >> diff --git a/lib/chr-testdev.c b/lib/chr-testdev.c
> >> index b3c641a833fe..301e73a6c064 100644
> >> --- a/lib/chr-testdev.c
> >> +++ b/lib/chr-testdev.c
> >> @@ -68,3 +68,8 @@ void chr_testdev_init(void)
> >>  	in_vq = vqs[0];
> >>  	out_vq = vqs[1];
> >>  }
> >> +
> >> +bool chr_testdev_available(void)
> >> +{
> >> +	return vcon != NULL;
> >> +}
> >> -- 
> >> 2.32.0
> >>
> > Thanks,
> > drew 
> >
> 

