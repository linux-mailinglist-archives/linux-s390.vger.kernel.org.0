Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403CD3ACB0F
	for <lists+linux-s390@lfdr.de>; Fri, 18 Jun 2021 14:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFRMgt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 18 Jun 2021 08:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhFRMgo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 18 Jun 2021 08:36:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DC9C061767
        for <linux-s390@vger.kernel.org>; Fri, 18 Jun 2021 05:34:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d2so13801643ljj.11
        for <linux-s390@vger.kernel.org>; Fri, 18 Jun 2021 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nZ8eZKcheetAVVtntDyOPDczvB8LGNmHxynp06Hwje4=;
        b=gem9n2oV7siw83AG8SlRs8mVxwOwxCy2gN2ftYt8Cz67bhgXmc2w00MxcPfoZ9mJpB
         sg/wSDsX34t83RRTKbk6Qs27kQStSxWG3HjPj6/XU2HOoxB14lnA7+ishARi3u47qouL
         A9ohAwN083OUKOdmoDlEFBPNodXkFN6VPz2ttTDC0uxV7v+gu+6Hw710eM5GaIYooO8/
         4DUDPjLNVyihbqd7JbECs734pUsTIHIC8tGN5Xt1IgghNHNM+TbucaOhD480OZ4REs27
         VL6ufqWcV+HYsEvcDPLjJJRwT4Lbxi6EUqfyDmTWaim1b0e8tq3/RkTCwRFcYY1isfOT
         aZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nZ8eZKcheetAVVtntDyOPDczvB8LGNmHxynp06Hwje4=;
        b=oIskUnembjOL0ra4mRq08eXb4Di2wMmRdgyk997/pp0O65sJiOERFdxNbOL2U58c1N
         xw3vFFz25CcZ+s1moeTWwOdS0k66xN6VgV+ghyGcK7MMzI1HCYR9Y+udAQphvKH6YQJW
         TPefD6TXFLUDXpUSJH/fpSzk1QH2CbSMP1xcW8/nG8Qx2VwTiBh+nkcLwzHJZgOhpe63
         8DftsFyhZIWRDZ7qPcf31bQskYhQm/sSX/64BTPQA8Tfr3YMdudfdcPggeJDkN5ItBaE
         40ZhKV5ieZLyEJDUtqnGTPw2TGdhBEQmviz0xX5htgJDkRQL3Vp/d5mLqnX3i54Yse0n
         HZwQ==
X-Gm-Message-State: AOAM532LXHYs5J4Xc1Rg+NL38+YzBEwrgrzpSyBTSXltREib2L7mEGtR
        jBd+o6IqFGbCK/8DT1Ye8kdphrsiDTv4OsVKRViR2Q==
X-Google-Smtp-Source: ABdhPJy/SmtmBEa6EeaTOLzSOUyOJ0FCW1v/VcB96xzGJFrUogLnnlSkPebfytnB2OvvIcWiKdLH+1HCeEh87E18VuA=
X-Received: by 2002:a2e:bf21:: with SMTP id c33mr9245298ljr.28.1624019671303;
 Fri, 18 Jun 2021 05:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
 <20210618044819.3690166-4-jingzhangos@google.com> <YMxD/NxAvKkXB2iM@kroah.com>
In-Reply-To: <YMxD/NxAvKkXB2iM@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 18 Jun 2021 07:34:19 -0500
Message-ID: <CAAdAUti86QZY+KT+NLnLyYf0P09_p5AWhXMmT7+mSt1r=OVEfA@mail.gmail.com>
Subject: Re: [PATCH v11 3/7] KVM: stats: Support binary stats retrieval for a VM
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Jun 18, 2021 at 1:58 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jun 18, 2021 at 04:48:15AM +0000, Jing Zhang wrote:
> > Add a VM ioctl to get a statistics file descriptor by which a read
> > functionality is provided for userspace to read out VM stats header,
> > descriptors and data.
> > Define VM statistics descriptors and header for all architectures.
> >
> > Reviewed-by: David Matlack <dmatlack@google.com>
> > Reviewed-by: Ricardo Koller <ricarkol@google.com>
> > Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> > Reviewed-by: Fuad Tabba <tabba@google.com>
> > Tested-by: Fuad Tabba <tabba@google.com> #arm64
> > Signed-off-by: Jing Zhang <jingzhangos@google.com>
> > ---
> >  arch/arm64/kvm/guest.c    | 14 +++++++++++++
> >  arch/mips/kvm/mips.c      | 14 +++++++++++++
> >  arch/powerpc/kvm/book3s.c | 16 +++++++++++++++
> >  arch/powerpc/kvm/booke.c  | 16 +++++++++++++++
> >  arch/s390/kvm/kvm-s390.c  | 19 +++++++++++++++++
> >  arch/x86/kvm/x86.c        | 24 ++++++++++++++++++++++
> >  include/linux/kvm_host.h  |  6 ++++++
> >  virt/kvm/kvm_main.c       | 43 +++++++++++++++++++++++++++++++++++++++
> >  8 files changed, 152 insertions(+)
> >
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 4962331d01e6..f456d1defe2b 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -28,6 +28,20 @@
> >
> >  #include "trace.h"
> >
> > +struct _kvm_stats_desc kvm_vm_stats_desc[] = {
> > +     KVM_GENERIC_VM_STATS()
> > +};
> > +static_assert(ARRAY_SIZE(kvm_vm_stats_desc) ==
> > +             sizeof(struct kvm_vm_stat) / sizeof(u64));
> > +
> > +struct kvm_stats_header kvm_vm_stats_header = {
>
> Can this be const?
>
> > +     .name_size = KVM_STATS_NAME_LEN,
> > +     .count = ARRAY_SIZE(kvm_vm_stats_desc),
> > +     .desc_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN,
> > +     .data_offset = sizeof(struct kvm_stats_header) + KVM_STATS_ID_MAXLEN +
> > +                    sizeof(kvm_vm_stats_desc),
> > +};
>
> If it can't be const, what is modified in it that prevents that from
> happening?
>
> thanks,
>
> greg k-h
Yes, it can be const.

Thanks,
Jing
