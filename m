Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F6A210D6A
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2020 16:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbgGAOSo (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 1 Jul 2020 10:18:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36723 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731504AbgGAOSn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 10:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593613121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WXANX7e/4PKUrgXNjDH8epRg0aU4bUifT+MRphx7SbI=;
        b=NN1VtqhH+DRrERqGv7j39we1nD0Lhax9C9uYMyp38yTDrR6Urr1AGKOzdKmbbwOIydCCVr
        mQ8KEny8lH3/vpiapg4PKxHSBMpt8TbT8WzDOpbapqq3EdTb7zdQnIFKmLSmw5dv+yM9as
        BzX0Qb1OaNjWdlsfp2W/8M2S9G52QMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-8ISAIio-PKymnyTfUtGACQ-1; Wed, 01 Jul 2020 10:18:37 -0400
X-MC-Unique: 8ISAIio-PKymnyTfUtGACQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 013D3805EEE;
        Wed,  1 Jul 2020 14:18:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DDC65C1C5;
        Wed,  1 Jul 2020 14:18:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH v2 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Wed,  1 Jul 2020 16:18:28 +0200
Message-Id: <20200701141830.18749-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This series is based on the latest s390/features branch, which contains
"s390/zcore: remove memmap device". [1]

Looking into why we still create memblocks for stdnaby/hotplugged memory
(via add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK
on s390x after all.

This is relevant in the context of virtio-mem, where we hotplug a lot of
small memory blocks (and want to avoid managing unused metadata). But also
for existing setups, it might help to free up some memory after boot.

Compile-tested on s390x, pseries, arm64, i386, mips64, powernv, sh, and
x86_64.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

v1 -> v2:
- "mm/memblock: expose only miminal interface to add/walk physmem"
-- Use inline function for __next_physmem_range
-- Rewrite some comments

RFC -> v1:
- "s390/zcore: traverse resources instead of memblocks" has been replaced
  on s390/features by "s390/zcore: remove memmap devic"
- Add "mm/memblock: expose only miminal interface to add/walk physmem"
-- Sort out section mismatch errors when using physmem after boot without
   ARCH_KEEP_MEMBLOCK
- "s390/mm: don't set ARCH_KEEP_MEMBLOCK"
-- Rephrase description

David Hildenbrand (2):
  mm/memblock: expose only miminal interface to add/walk physmem
  s390/mm: don't set ARCH_KEEP_MEMBLOCK

 arch/s390/Kconfig             |  1 -
 arch/s390/kernel/crash_dump.c |  6 ++--
 include/linux/memblock.h      | 28 ++++++++++++++---
 mm/memblock.c                 | 57 ++++++++++++++++++-----------------
 4 files changed, 55 insertions(+), 37 deletions(-)

-- 
2.26.2

