Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EE229548
	for <lists+linux-s390@lfdr.de>; Wed, 22 Jul 2020 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731625AbgGVJqP (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 Jul 2020 05:46:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24558 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731612AbgGVJqO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Jul 2020 05:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWLTZ0ohTCOqY8W0BivI+pv17MHIbXm1Wg5QczAEU30=;
        b=Lz5o69d3lMKR+0DQqL+vKZjWm/ViqI3gca6fhJpWSf/rhwwqvr6Y0rJ1qkh2OpOSDUilEf
        BzOaveSZMlMbFNEGaghaEp8xPUL3yV/7NrL3XQ/2QnaPIIxfsoZo0UoqiIZKGnIV70vM4Y
        /vgbUujMCf/gnw0KpxWDaRYdh77djIo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-Tp74bpWWMNeI9H_3pCcviw-1; Wed, 22 Jul 2020 05:46:09 -0400
X-MC-Unique: Tp74bpWWMNeI9H_3pCcviw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6108C100CCC1;
        Wed, 22 Jul 2020 09:46:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D4195D9CA;
        Wed, 22 Jul 2020 09:46:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 1/9] s390/vmem: rename vmem_add_mem() to vmem_add_range()
Date:   Wed, 22 Jul 2020 11:45:50 +0200
Message-Id: <20200722094558.9828-2-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Let's match the name to vmem_remove_range().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 3b9e71654c37b..66c5333020ead 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -57,7 +57,7 @@ pte_t __ref *vmem_pte_alloc(void)
 /*
  * Add a physical memory range to the 1:1 mapping.
  */
-static int vmem_add_mem(unsigned long start, unsigned long size)
+static int vmem_add_range(unsigned long start, unsigned long size)
 {
 	unsigned long pgt_prot, sgt_prot, r3_prot;
 	unsigned long pages4k, pages1m, pages2g;
@@ -308,7 +308,7 @@ int vmem_add_mapping(unsigned long start, unsigned long size)
 		return -ERANGE;
 
 	mutex_lock(&vmem_mutex);
-	ret = vmem_add_mem(start, size);
+	ret = vmem_add_range(start, size);
 	if (ret)
 		vmem_remove_range(start, size);
 	mutex_unlock(&vmem_mutex);
@@ -325,7 +325,7 @@ void __init vmem_map_init(void)
 	struct memblock_region *reg;
 
 	for_each_memblock(memory, reg)
-		vmem_add_mem(reg->base, reg->size);
+		vmem_add_range(reg->base, reg->size);
 	__set_memory((unsigned long)_stext,
 		     (unsigned long)(_etext - _stext) >> PAGE_SHIFT,
 		     SET_MEMORY_RO | SET_MEMORY_X);
-- 
2.26.2

