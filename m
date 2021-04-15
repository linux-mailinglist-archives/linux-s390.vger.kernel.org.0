Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA629360EB4
	for <lists+linux-s390@lfdr.de>; Thu, 15 Apr 2021 17:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbhDOPUl (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Thu, 15 Apr 2021 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236896AbhDOPUS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Apr 2021 11:20:18 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149BC06138E
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 08:17:44 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x26-20020aa7957a0000b0290250a7512179so2831915pfq.1
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 08:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rURblysS7kpTi9x8OxUlK9nhpB6vhBboGuvysGWXqRw=;
        b=qwVuZosddg0satSAHkPxr/aaneVDziK0pjqzjvPpzYyd+SSEXK6SULTE35ueUCjHrN
         l+w0Mh2h7+2aZC6eY1mOzHYVwWU+GhhFcFXsIJ5PxK6hhvMolFtcYb6teQ2ugZDS8yz/
         b0FHgvSS2lsZdAxl/Yfq6y6h/Hv9bD2bSAlnqTSzfATkOEqN1nl1h2l9tivwh7r9GE1f
         29Eb9eXira/eTJQmcRpROJZbiW9mxjYd8eF38EseaNoj67oiMWhelHbKRrskQ6g2fTWY
         +HikmUBXZeOGGfx12tmcLCf9lhN7jKRl6o/Ri3ag4QwxHLi/S6HtTbxqoSR0zGxQx9Nq
         24ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rURblysS7kpTi9x8OxUlK9nhpB6vhBboGuvysGWXqRw=;
        b=BJmDkAhFIM7yyJjjzgjZwVFV9zecaG1uGx9WH4oks8JzWCOkGeY5gB3obrLwHgyF6u
         /OY3/PZKKhTiUnJD729Z+iaIi89LwrSa7wDZPV15zfC1/EbHGtIXtdXrAeGfnEsfK+zL
         Hsz4lLKuUB61pNW0oOUJuSWJ5Sm4vD99PvZqc/gpXCaxVrtBH89ZWshGAD1+2kwhHViy
         xCh4ASKIGRD5212pxDyP+qpdmTmsPGng+/u1acbPubFYGZRmFUTAghvNCFIZZ3AvPgto
         IagE65JPYSXZq50JwRG0bXfEyhTQsIntmX3i8N/seCbWI+rc81rMfbDnWDpo7NZvHsfG
         7eIw==
X-Gm-Message-State: AOAM533fRLdKAKRSk0+L2zFO2ZgEiWCzukgq73U//xQWhYPgKR3gYgCi
        VKe86I3htT+hSgV+nlkTpoSYQvxAvI1gvV690g==
X-Google-Smtp-Source: ABdhPJyMwjuQSISfNP92ZO3vAT3rkA7W0fq6VXz1CTfac50JyTCuaWbGQONSE2dZOrNe3HMufpnoXv1hFXbgKqbE5w==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a05:6a00:1c67:b029:215:6f93:d220 with
 SMTP id s39-20020a056a001c67b02902156f93d220mr3521171pfw.36.1618499864440;
 Thu, 15 Apr 2021 08:17:44 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:17:37 +0000
Message-Id: <20210415151741.1607806-1-jingzhangos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 0/4] KVM statistics data fd-based binary interface
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

* v1 -> v2
  - Use ARRAY_SIZE to count the number of stats descriptors
  - Fix missing `size` field initialization in macro STATS_DESC

[1] https://lore.kernel.org/kvm/20210402224359.2297157-1-jingzhangos@google.com

---

Jing Zhang (4):
  KVM: stats: Separate common stats from architecture specific ones
  KVM: stats: Add fd-based API to read binary stats data
  KVM: stats: Add documentation for statistics data binary interface
  KVM: selftests: Add selftest for KVM statistics data binary interface

 Documentation/virt/kvm/api.rst                | 169 ++++++++
 arch/arm64/include/asm/kvm_host.h             |   9 +-
 arch/arm64/kvm/guest.c                        |  42 +-
 arch/mips/include/asm/kvm_host.h              |   9 +-
 arch/mips/kvm/mips.c                          |  67 +++-
 arch/powerpc/include/asm/kvm_host.h           |   9 +-
 arch/powerpc/kvm/book3s.c                     |  68 +++-
 arch/powerpc/kvm/book3s_hv.c                  |  12 +-
 arch/powerpc/kvm/book3s_pr.c                  |   2 +-
 arch/powerpc/kvm/book3s_pr_papr.c             |   2 +-
 arch/powerpc/kvm/booke.c                      |  63 ++-
 arch/s390/include/asm/kvm_host.h              |   9 +-
 arch/s390/kvm/kvm-s390.c                      | 133 ++++++-
 arch/x86/include/asm/kvm_host.h               |   9 +-
 arch/x86/kvm/x86.c                            |  71 +++-
 include/linux/kvm_host.h                      | 132 ++++++-
 include/linux/kvm_types.h                     |  12 +
 include/uapi/linux/kvm.h                      |  48 +++
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_bin_form_stats.c        | 370 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 virt/kvm/kvm_main.c                           | 237 ++++++++++-
 24 files changed, 1401 insertions(+), 90 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/kvm_bin_form_stats.c


base-commit: f96be2deac9bca3ef5a2b0b66b71fcef8bad586d
-- 
2.31.1.295.g9ea45b61b8-goog

