Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0142E20F044
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2020 10:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgF3IRm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jun 2020 04:17:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728749AbgF3IRl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 30 Jun 2020 04:17:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593505060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mqoCAmbWLVew+uL9ZYjU1VZPjkLf7qSDUzEf8IJ6hME=;
        b=EhefZvt1m9YWdNl/jiR371e/GJjQYspEIuVXKYBwyXi4/LsB2OBkP3/lJX0QlhJUPv/w10
        WmxS6CAdyfYRTf4MeBc/90a/tPgufcfTbbRj8j8lynEWO6nHk4JeuqcJPJx8+OGOOdHgtW
        Yk+bNKN4iq5vFOEJQPOLLGg9i3Jn0P0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-xTMZIrTPMRCJ8fZFUQQFwQ-1; Tue, 30 Jun 2020 04:17:38 -0400
X-MC-Unique: xTMZIrTPMRCJ8fZFUQQFwQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46348805EEF;
        Tue, 30 Jun 2020 08:17:36 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1197B60BF3;
        Tue, 30 Jun 2020 08:17:30 +0000 (UTC)
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
Subject: [PATCH v1 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Tue, 30 Jun 2020 10:17:28 +0200
Message-Id: <20200630081730.6862-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This is the follow-up of [1]:
	[PATCH RFC 0/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK

This series is based on the latest s390/features branch, which contains
"s390/zcore: remove memmap device". [2]

Looking into why we still create memblocks for stdnaby/hotplugged memory
(via add_memory()), I discovered that we might not need ARCH_KEEP_MEMBLOCK
on s390x after all.

This is relevant in the context of virtio-mem, where we hotplug a lot of
small memory blocks (and want to avoid managing unused metadata). But also
for existing setups, it might help to free up some memory after boot.

Compile-tested on s390x, pseries, arm64, i386, mips64, powernv, sh, and
x86_64.

[1] https://lkml.kernel.org/r/20200417150151.17239-1-david@redhat.com
[2] https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git/commit/?h=features

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
 include/linux/memblock.h      | 17 +++++++---
 mm/memblock.c                 | 63 +++++++++++++++++++----------------
 4 files changed, 50 insertions(+), 37 deletions(-)

-- 
2.26.2

