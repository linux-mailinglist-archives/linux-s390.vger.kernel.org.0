Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB83AB6F6
	for <lists+linux-s390@lfdr.de>; Thu, 17 Jun 2021 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhFQPLt (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 17 Jun 2021 11:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbhFQPLt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Jun 2021 11:11:49 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03C7C0617A6
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:09:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bp38so11191771lfb.0
        for <linux-s390@vger.kernel.org>; Thu, 17 Jun 2021 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xXZRhEcd2Cbrj/tVl2ryBxrcp7ZNIEiNaJWzDG2F5Kg=;
        b=TqWgVeNXToRFcCgGFrlG52MtXOvoEpEgH+psGbhdraIxWdvhr8qhRpfWoVKcSxORjB
         B831vy6R7RTZzs2nM/KQJ71iM9aVLCvGMf20DJUF4AiJWHbwKHIT31rxxZUeXh2p2oRt
         XL4KPiTOT9hbUZgUJfDFuKG7oGbFDKYHU8SCBYWaX0RmwnVcF135fDTnUplDx6/kg56A
         WtUBi4LRlBK+S9bbzajtt7FAUOTE3fofCi+CtbjwZsPln+zjbIngScXUpHx9H35LbAYv
         yhbCZ2245i7w4fll7tlZ0JTQLXy7oTYwQOusiRyXIwwEXch8Jc2WjtK44ttM+hrJsoLv
         Zk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXZRhEcd2Cbrj/tVl2ryBxrcp7ZNIEiNaJWzDG2F5Kg=;
        b=jILWL3U83eOAiZrsi0Hm8skEXOXnqiz2RJeCU9l27oWs9E6mIfPnJCu3Twz55vTw1M
         yjoyNVKHXu6TVGSKxrfCDG+Dh/Qc3zxGPBJxaSVjv0Aom/LGg8zL6kMrBFmZQEofgzXY
         V8HCzlEovpGPX++X/DJWlvIG54TL6XWvBKeWfyRrd+InQNUQSpbWpBDrFHy3uC3g7rh4
         Ev30tNehqXfqY6BjR2+6jL5neWo3VsXAOPapTEyR2fizXNLUi39dZ5nOGpsOcVsWfrR8
         1UF6p8HGVm6ndsfsnHkWlaCRqWVV0nHxJKmZU9WJmiorbzHKXEvzMFNZ5FBUqdgvpwbw
         Pz8Q==
X-Gm-Message-State: AOAM5301c+ZOgRRQoqAwtden8XabYPlGGqHOb+VJGT+0JJE4aY4j5qGB
        NXrgXtwxkUMkG8TolJfUu+/eZlGYQxmDc5cP9zJAgA==
X-Google-Smtp-Source: ABdhPJzAyrQsMnAqbBOEYMZVZQD5qO0SZlAXpM63+DpcX+GVx2elMNK7wl3R9skQOGetSMH5r+n7sJJM07csoEf6gTw=
X-Received: by 2002:a05:6512:33c4:: with SMTP id d4mr4587741lfg.536.1623942578963;
 Thu, 17 Jun 2021 08:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210617044146.2667540-1-jingzhangos@google.com>
 <20210617044146.2667540-4-jingzhangos@google.com> <YMrjKhV8TNwmRtf6@kroah.com>
In-Reply-To: <YMrjKhV8TNwmRtf6@kroah.com>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Thu, 17 Jun 2021 10:09:27 -0500
Message-ID: <CAAdAUtiySqu6VKpK2LDnG5S0m9tRKjrKSu5BWoFurkhWay4yCg@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] KVM: stats: Add documentation for binary
 statistics interface
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

Hi Greg,

On Thu, Jun 17, 2021 at 12:52 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 17, 2021 at 04:41:44AM +0000, Jing Zhang wrote:
> > +     struct kvm_stats_desc {
> > +             __u32 flags;
> > +             __s16 exponent;
> > +             __u16 size;
> > +             __u32 offset;
> > +             __u32 unused;
> > +             char name[0];
> > +     };
> > +
> > +The ``flags`` field contains the type and unit of the statistics data described
> > +by this descriptor. The following flags are supported:
> > +
> > +Bits 0-3 of ``flags`` encode the type:
>
> <snip>
>
> As flags is a bit field, what is the endian of it?  Native or LE or BE?
> I'm guessing "cpu native", but you should be explicit as userspace will
> have to deal with this somehow.
Sure, will add clarification for endianness.
>
> thanks,
>
> greg k-h

Thanks,
Jing
