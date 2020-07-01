Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE59210D6B
	for <lists+linux-s390@lfdr.de>; Wed,  1 Jul 2020 16:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbgGAOSs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 1 Jul 2020 10:18:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51401 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731518AbgGAOSr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 1 Jul 2020 10:18:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593613126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OxgbA78Isty5LjQU/goDcTyWCLKH0Y+Zl49XxrxsnYY=;
        b=d2sc336/O6v0ydvUcBeVD8TCtLYfRgN7XBs0jpcfhhElpP2l218g+IBP3LOqRhnmk2GdB/
        sOzodu7YSj2cHTijeVAFJdbO3o0aGjnXFeBcvxR4YA5rvuxKjj5wWIvleKHrlQbBe3Y8EV
        +WRIk4jQaLfB8EOmmFOo9Y/mwWKo5Uo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-CENe1AYBMuGvlkWzP0lwXQ-1; Wed, 01 Jul 2020 10:18:44 -0400
X-MC-Unique: CENe1AYBMuGvlkWzP0lwXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBE58A0BDF;
        Wed,  1 Jul 2020 14:18:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-52.ams2.redhat.com [10.36.112.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F0B05C1C5;
        Wed,  1 Jul 2020 14:18:38 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>,
        Michael Holzheu <holzheu@linux.vnet.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 2/2] s390/mm: don't set ARCH_KEEP_MEMBLOCK
Date:   Wed,  1 Jul 2020 16:18:30 +0200
Message-Id: <20200701141830.18749-3-david@redhat.com>
In-Reply-To: <20200701141830.18749-1-david@redhat.com>
References: <20200701141830.18749-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Commit 50be63450728 ("s390/mm: Convert bootmem to memblock") mentions
	"The original bootmem allocator is getting replaced by memblock. To
	cover the needs of the s390 kdump implementation the physical
	memory list is used."

As we can now reference "physmem" managed in the memblock allocator after
init even without ARCH_KEEP_MEMBLOCK, and s390x does no longer need
other memblock metadata after boot (esp., the zcore memmap device that used
it got removed), we can stop setting ARCH_KEEP_MEMBLOCK.

With this change, we no longer create memblocks for standby/hotplugged
memory (added via add_memory()) and free up memblock metdata (except
physmem) after boot.

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Philipp Rudo <prudo@linux.ibm.com>
Cc: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index c7d7ede6300c5..7697a1f8e819a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -102,7 +102,6 @@ config S390
 	select ARCH_INLINE_WRITE_UNLOCK_BH
 	select ARCH_INLINE_WRITE_UNLOCK_IRQ
 	select ARCH_INLINE_WRITE_UNLOCK_IRQRESTORE
-	select ARCH_KEEP_MEMBLOCK
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.26.2

