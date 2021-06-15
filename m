Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8E93A78AD
	for <lists+linux-s390@lfdr.de>; Tue, 15 Jun 2021 10:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFOIF5 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 15 Jun 2021 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFOIF4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Jun 2021 04:05:56 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B4BC061574
        for <linux-s390@vger.kernel.org>; Tue, 15 Jun 2021 01:03:52 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id i12-20020a05683033ecb02903346fa0f74dso13451102otu.10
        for <linux-s390@vger.kernel.org>; Tue, 15 Jun 2021 01:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2CSh1z7Vp1/cJggYoB1jYFqsZlnKuhPcaTsNgRYwVSI=;
        b=O8yz83yvBRCtMVSzbGCfMg/eHcmAvfvQZTkOIrDmMi4Ya9lSWjT7L4v+4BdKPCHAr7
         o8i/5oXrv/AX3rVcPJxU+O2mwmLoFJX9GDiqaz5HSgNfEsgXYCPNJcP9FgE7IRuDoNkx
         tFHDu7d25Ci7vkTPCNOjJ0ZeoYPOGokqwLAGhgNmbyNuAeTPp5zd/L63WYBxn4HYzh91
         dRMVX09ftVaQWQV+pkiXcPlwECefKY/kQlEEaHx+kpinhn6YKL1DlJZq56FcetiW7RNx
         Kb+r7EfzgK//Y13xIojAuhb9Q27hA0AvG7oieQon3sgYE3dxk47SHgpgdFK6ACeBafwq
         FXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2CSh1z7Vp1/cJggYoB1jYFqsZlnKuhPcaTsNgRYwVSI=;
        b=eraHTw6o8LC7wgx2OMIe8gOmsZVEDauANgx74jOmrmvrP6V1TFLvPR1VZ8Kbat/sag
         AJgbNITAj9hN06fwnc1Fldn+TsrUgAPJwVZm9H/xQ1o8hSFTq+MrIcI3X2Unsi95y22V
         4J9WQ93tkO5nBjRrjSvD7zQw/19C0wLyb//5VIlq71vM4rzMwcCB2z+AWB3bCOEDOMjL
         sPZUuwPAmePDYfhMPQ4V1FZwnL2l41K9aPNietid728d3ghiiVoqZ6ra6lKcHUB/Pj5y
         MNFW27a55MuBKxvqG94Ib0X1nZWL6a1fqJZOsZDewqkv496tsI09rBlDx0UUKTpNNUfw
         RBfA==
X-Gm-Message-State: AOAM533H0EV7OXFBS6UQ/ivppF/RIO8uZFfSrwBQrfbyc0GbZftHgWOr
        vA0HInIO9srCUgk3IOwmP8vEqYDsu0qQRiftw77cSQ==
X-Google-Smtp-Source: ABdhPJw2enLCtbwE/790AuD9R9YvbkgrP2ijrQxAzA0UdoAox+QIbPoUXnczIrY5AxRCozcc/VKv6rYEd/Kk/Su7FrA=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr16213078otp.144.1623744231983;
 Tue, 15 Jun 2021 01:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210614212155.1670777-1-jingzhangos@google.com> <20210614212155.1670777-5-jingzhangos@google.com>
In-Reply-To: <20210614212155.1670777-5-jingzhangos@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 15 Jun 2021 09:03:15 +0100
Message-ID: <CA+EHjTybjrYL5KUJebmjvj_R5yULDxXsiPzn6f5f-y5HzQqM6A@mail.gmail.com>
Subject: Re: [PATCH v9 4/5] KVM: selftests: Add selftest for KVM statistics
 data binary interface
To:     Jing Zhang <jingzhangos@google.com>
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Jing,

> +int main(int argc, char *argv[])
> +{
> +       int max_vm = DEFAULT_NUM_VM, max_vcpu = DEFAULT_NUM_VCPU, ret, i, j;
> +       struct kvm_vm **vms;
> +
> +       /* Get the number of VMs and VCPUs that would be created for testing. */
> +       if (argc > 1) {
> +               max_vm = strtol(argv[1], NULL, 0);
> +               if (max_vm <= 0)
> +                       max_vm = DEFAULT_NUM_VM;
> +       }
> +       if (argc > 2) {
> +               max_vcpu = strtol(argv[2], NULL, 0);
> +               if (max_vcpu <= 0)
> +                       max_vcpu = DEFAULT_NUM_VCPU;
> +       }
> +
> +       /* Check the extension for binary stats */
> +       ret = kvm_check_cap(KVM_CAP_BINARY_STATS_FD);
> +       TEST_ASSERT(ret >= 0,
> +                       "Binary form statistics interface is not supported");

kvm_check_cap returns the value of KVM_CHECK_EXTENSION, which is 0 if
unsupported (-ERROR on an error). The assertion should be for ret > 0.

Made that change locally, and tested it with various configurations
(vhe, nvhe), as well as kernel versions (with and without
KVM_CAP_BINARY_STATS_FD), and it passes (or fails as expected).
Without that fix and with a kernel that doesn't support
KVM_CAP_BINARY_STATS_FD, it passes that assertion, but fails later at
vcpu_stats_test().

With that fixed:
Tested-by: Fuad Tabba <tabba@google.com> #arm64

Cheers,
/fuad


> +
> +       /* Create VMs and VCPUs */
> +       vms = malloc(sizeof(vms[0]) * max_vm);
> +       TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
> +       for (i = 0; i < max_vm; ++i) {
> +               vms[i] = vm_create(VM_MODE_DEFAULT,
> +                               DEFAULT_GUEST_PHY_PAGES, O_RDWR);
> +               for (j = 0; j < max_vcpu; ++j)
> +                       vm_vcpu_add(vms[i], j);
> +       }
> +
> +       /* Check stats read for every VM and VCPU */
> +       for (i = 0; i < max_vm; ++i) {
> +               vm_stats_test(vms[i]);
> +               for (j = 0; j < max_vcpu; ++j)
> +                       vcpu_stats_test(vms[i], j);
> +       }
> +
> +       for (i = 0; i < max_vm; ++i)
> +               kvm_vm_free(vms[i]);
> +       free(vms);
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 5c70596dd1b9..83c02cb0ae1e 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -2286,3 +2286,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
>         n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
>         return vm_adjust_num_guest_pages(mode, n);
>  }
> +
> +int vm_get_stats_fd(struct kvm_vm *vm)
> +{
> +       return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
> +}
> +
> +int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
> +{
> +       struct vcpu *vcpu = vcpu_find(vm, vcpuid);
> +
> +       return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
> +}
> --
> 2.32.0.272.g935e593368-goog
>
