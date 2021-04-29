Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D9D36F118
	for <lists+linux-s390@lfdr.de>; Thu, 29 Apr 2021 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233989AbhD2Uid (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 29 Apr 2021 16:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbhD2Uic (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Apr 2021 16:38:32 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D769C06138B
        for <linux-s390@vger.kernel.org>; Thu, 29 Apr 2021 13:37:44 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id g11-20020a17090a578bb029015564873bf4so494306pji.7
        for <linux-s390@vger.kernel.org>; Thu, 29 Apr 2021 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AGPbcGDitssQwR2vRkOkuDZa9dX2kbuG1ibqn3VGykk=;
        b=vKUaHf8Js7ssAthsBYE69zLm1fhKC668a4XSogrAS2/Dj/o0DGFMmmsqCnsDdBK3r8
         fU72HhuLV+N91HbI4pSgh5Tv0i1PzUEBWXj5fFX67L+XU+lVL8pWWznsP0NVQAQ5lUN8
         tnGqagWLjEKhm+kdYP0z5D1VFGd6D7c5iZaQMTCVsEY02BoS0mnuzX3PxsSzTzAH96TW
         tg88Vd5GmUxj49R4qFOrP19khvrv7Uk7Z12xOA/41VGF6xIzWWzGX5Ujhfw/yE2w/sDo
         5qe4eKKz4NBm3zmwuvIwm9mkX7c0VkNxwjlxlY2NlKl+E9wZZUof0MbYVFwoGUhzfAhm
         LpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AGPbcGDitssQwR2vRkOkuDZa9dX2kbuG1ibqn3VGykk=;
        b=LSqm7s7625YabyRfBVi9IEglLOFU5A9LcwuONzAmC79W9ZmxeaDWb4eyT+4Fhn2WHK
         8lIsG9qyF+ND5ahEQol1VZVX0EDWe4K/uWmuJluiV+FIoLmbc1FG/mQhXn2o3j1oMLWX
         JmjcVuVzj38xMCDkgCBcDL7J5gOf9jD97J4slSiJonPZ4RV9dZCdhc018tw9p030ECno
         PUcuGxe+MO+9TWjL09Hd7BvVJuBEmsaFYMHtUjNFVJpyOEMwPkLhwxf5RzMbcxl3GV2s
         mWEvHE51CXu2Q05PpKvaPVtGfdrRNZxn1GtOqO5X9/rvgViaZAl3vyDpxPWR9bGb1BTZ
         D4YA==
X-Gm-Message-State: AOAM533iY+JYoy3Ldu/Ejnzj1c4bKo/QUWQz6MioMqrxJR8Y5nJoKmQG
        125C9LOZ6iIXZwoCH57GdROCmmiwR5CF2A7z9w==
X-Google-Smtp-Source: ABdhPJxa1nzLFdFJjcOVu7fh1Y6W8Fs7WxRv4NSYd6yoIxBYT8+4qmIZrtv36CAWNU9/OaCLxfjmfxSFKptxvj1z1A==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:aa7:8e0d:0:b029:214:a511:d88b with
 SMTP id c13-20020aa78e0d0000b0290214a511d88bmr1651129pfr.2.1619728663762;
 Thu, 29 Apr 2021 13:37:43 -0700 (PDT)
Date:   Thu, 29 Apr 2021 20:37:36 +0000
Message-Id: <20210429203740.1935629-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 0/4] KVM statistics data fd-based binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
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
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This patchset provides a file descriptor for every VM and VCPU to read
KVM statistics data in binary format.
It is meant to provide a lightweight, flexible, scalable and efficient
lock-free solution for user space telemetry applications to pull the
statistics data periodically for large scale systems. The pulling
frequency could be as high as a few times per second.
In this patchset, every statistics data are treated to have some
attributes as below:
  * architecture dependent or common
  * VM statistics data or VCPU statistics data
  * type: cumulative, instantaneous,
  * unit: none for simple counter, nanosecond, microsecond,
    millisecond, second, Byte, KiByte, MiByte, GiByte. Clock Cycles
Since no lock/synchronization is used, the consistency between all
the statistics data is not guaranteed. That means not all statistics
data are read out at the exact same time, since the statistics date
are still being updated by KVM subsystems while they are read out.

---

* v3 -> v4
  - Rebase to kvm/queue, commit 9f242010c3b4 ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Use C-stype comments in the whole patch
  - Fix wrong count for x86 VCPU stats descriptors
  - Fix KVM stats data size counting and validity check in selftest

* v2 -> v3
  - Rebase to kvm/queue, commit edf408f5257b ("KVM: avoid "deadlock"
    between install_new_memslots and MMU notifier")
  - Resolve some nitpicks about format

* v1 -> v2
  - Use ARRAY_SIZE to count the number of stats descriptors
  - Fix missing `size` field initialization in macro STATS_DESC

[1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com
[2] https://lore.kernel.org/kvm/20210415151741.1607806-1-jingzhangos@google.com
[3] https://lore.kernel.org/kvm/20210423181727.596466-1-jingzhangos@google.com

---

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 171 ++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  42 +-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  67 ++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  68 +++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  63 ++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 133 +++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  71 +++-
 include/linux/kvm_host.h                      | 132 +++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  50 +++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 380 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 virt/kvm/kvm_main.c                           | 237 ++++++++++-
 24 files changed, 1415 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: 9f242010c3b46e63bc62f08fff42cef992d3801b
-- 
2.31.1.527.g47e6f16901-goog

