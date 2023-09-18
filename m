Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C73D7A4E34
	for <lists+linux-s390@lfdr.de>; Mon, 18 Sep 2023 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjIRQJD (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 18 Sep 2023 12:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjIRQIu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Sep 2023 12:08:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A689A35BD
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 09:07:01 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-4150f8480c5so58152161cf.2
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695053220; x=1695658020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2U3xsG0fg5xdFpPmP8zowhEzmg+gfxwbZh9hlXMaF+c=;
        b=TkYmJv/HAXQRUGNIBvSTRvvWh8bLp2W6K3RmZz01W8FxJeJ0rI3b23M1jVuvtFFu3C
         bIMOVbtcY3vpM0aGe1mCqRQ1FHDwCmlADKVf3g+TY5H6NajEvORvHqIouMKBBjQGiIiY
         N5nu8GxS3/QqCLlZNGT2CB1Lj4DhBNScrPDc10q52LPHcCFIJzLznIor8j5qDnJECnrw
         YX8HSCCnoBml1vES6kCUeDs8Ouel+QKNe0VDOeGzOgpsiSuoq4m/GiugZLkSYOECaF7+
         mlPGdNgFQx+xjISit2j1GURdrYDgc16y/+YM5CbN/sVA9OowkeCMLtrkm9H6+G5nxKaL
         5+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053220; x=1695658020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U3xsG0fg5xdFpPmP8zowhEzmg+gfxwbZh9hlXMaF+c=;
        b=NZFg2b5a/s96EkHiWmdNzTOIc0+UyPUTivBChh+wjDXRLIF6Jr04vKUEg+pokWUbNl
         AORZ8bL11cHaUUROGvVIsOXPq17iCbyeAbbyRKNLdpYKk/j399xH5x445qk0cJtG6vU4
         t34z94JD8WiiXlNIhEgUNcSpExSNyMKDnwRjaiZv/BZO5jkN6ZTte4WLUt9feGrE7+4q
         7Z6HB3WdaVfVqVTp5TUEuFhs2pteCoFN9+cU5w/2ewM6sM3b7myS5k0cp1FN7g847lp/
         EXBKcmQ82nNr5xJ1UmBFErk1k1DuTdnbzjg36ihHwUxvDG5MmOA1tVHtTrq3RmCK2A0m
         WfmQ==
X-Gm-Message-State: AOJu0YxHXZeWzwl68Qs/J0saeZg4FWqD1sYN8ml7/Spdfc0quIVYVCJe
        Wn2CDSCDCJz8RQGqam+cV/Nril6Wfhc=
X-Google-Smtp-Source: AGHT+IGgNS2Vz9a89mB0wnbmpqOo9ipRBHkgWDp+LBnX1+UB/D0eQmGLqC9so7UJgprSn2d6kzcCXv9BIzw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c2:b0:1c1:fbec:bc39 with SMTP id
 u2-20020a17090341c200b001c1fbecbc39mr210522ple.4.1695052361665; Mon, 18 Sep
 2023 08:52:41 -0700 (PDT)
Date:   Mon, 18 Sep 2023 08:52:40 -0700
In-Reply-To: <20230918152946.GJ13795@ziepe.ca>
Mime-Version: 1.0
References: <20230916003118.2540661-1-seanjc@google.com> <20230916003118.2540661-7-seanjc@google.com>
 <20230918152946.GJ13795@ziepe.ca>
Message-ID: <ZQhySMjmuyW2Czas@google.com>
Subject: Re: [PATCH 06/26] KVM: Drop CONFIG_KVM_VFIO and just look at KVM+VFIO
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Sep 18, 2023, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 05:30:58PM -0700, Sean Christopherson wrote:
> > Drop KVM's KVM_VFIO Kconfig, and instead compile in VFIO support if
> > and only if VFIO itself is enabled.  Similar to the recent change to have
> > VFIO stop looking at HAVE_KVM, compiling in support for talking to VFIO
> > just because the architecture supports VFIO is nonsensical.
> > 
> > This fixes a bug where RISC-V doesn't select KVM_VFIO, i.e. would silently
> > fail to do connect KVM and VFIO, even though RISC-V supports VFIO.  The
> > bug is benign as the only driver in all of Linux that actually uses the
> > KVM reference provided by VFIO is KVM-GT, which is x86/Intel specific.
> 
> Hmm, I recall that all the S390 drivers need it as well.
> 
> static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
> {
>         struct ap_matrix_mdev *matrix_mdev =
>                 container_of(vdev, struct ap_matrix_mdev, vdev);
> 
>         if (!vdev->kvm)
>                 return -EINVAL;
> 
>         return vfio_ap_mdev_set_kvm(matrix_mdev, vdev->kvm);

Ah, I missed that the KVM reference was routed through VFIO in that case.

> I wonder if we should be making the VFIO drivers that need the kvm to
> ask for it? 'select CONFIG_NEED_VFIO_KVM' or something?

I wondered the same thing, if only to make it easier to track which drivers actually
end up interacting directly with KVM.

> Regardless, I fully agree with getting rid of the arch flag.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> > --- a/virt/kvm/Makefile.kvm
> > +++ b/virt/kvm/Makefile.kvm
> > @@ -6,7 +6,9 @@
> >  KVM ?= ../../../virt/kvm
> >  
> >  kvm-y := $(KVM)/kvm_main.o $(KVM)/eventfd.o $(KVM)/binary_stats.o
> > -kvm-$(CONFIG_KVM_VFIO) += $(KVM)/vfio.o
> > +ifdef CONFIG_VFIO
> > +kvm-y += $(KVM)/vfio.o
> > +endif
> 
> I wonder if kvm-m magically works in kbuild so you don't need the ifdef?

Yeah, that should work, no idea why I added the ifdef.
