Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE4229553
	for <lists+linux-s390@lfdr.de>; Wed, 22 Jul 2020 11:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgGVJqa (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Wed, 22 Jul 2020 05:46:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53350 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731684AbgGVJqW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Jul 2020 05:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595411179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+W3E9XgHb0G6nVszkRK+6uLSR1+J1W6QhVtycYSbEnM=;
        b=hNuj6NDT0klvDgfPKL+NCUvz9oJglWYYzEElGSx6e4MPBNZjHbGSM2XW87/FUoB1QpeTgp
        uWmF4C9GtfnKtL452lx8NeQ0rlnvqw4FXMUsJ026bDD3XCuyZhX5baZ/olPjc+Aqu0YFvh
        x+0Xs+cWWuAZ3wP1zLciRVjsh/g/CJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-JEKjV4nNODe2wf8t2d3zAw-1; Wed, 22 Jul 2020 05:46:15 -0400
X-MC-Unique: JEKjV4nNODe2wf8t2d3zAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 62261800460;
        Wed, 22 Jul 2020 09:46:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-254.ams2.redhat.com [10.36.113.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B10BD5D9CA;
        Wed, 22 Jul 2020 09:46:12 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v2 4/9] s390/vmemmap: cleanup when vmemmap_populate() fails
Date:   Wed, 22 Jul 2020 11:45:53 +0200
Message-Id: <20200722094558.9828-5-david@redhat.com>
In-Reply-To: <20200722094558.9828-1-david@redhat.com>
References: <20200722094558.9828-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Cleanup what we partially added in case vmemmap_populate() fails. For
vmem, this is already handled by vmem_add_mapping().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/vmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 43fe1e2eb90ea..be32a38bb91fd 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -332,8 +332,13 @@ static void vmem_remove_range(unsigned long start, unsigned long size)
 int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 		struct vmem_altmap *altmap)
 {
+	int ret;
+
 	/* We don't care about the node, just use NUMA_NO_NODE on allocations */
-	return add_pagetable(start, end, false);
+	ret = add_pagetable(start, end, false);
+	if (ret)
+		remove_pagetable(start, end, false);
+	return ret;
 }
 
 void vmemmap_free(unsigned long start, unsigned long end,
-- 
2.26.2

