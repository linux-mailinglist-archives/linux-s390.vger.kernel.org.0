Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B53120F0AE
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2020 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgF3Im4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jun 2020 04:42:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731615AbgF3Imz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 04:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593506573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mMek0t2pSkJxyvN4LFvUyYB33GHpZByMfTgNNPMGb7s=;
        b=b9fH4b1zXmInXmfKrYqijfsuNkSVICCMwcin9Wpm2pvVaFbUnrTxxmP1IPpJ0bjw49m+ny
        M+QKVk8rF9R4tECNDMOVSmgU5VEdzWfjUErwvK+Jmbe3fGl0X8R98SIKhvr+eahbMSGa8P
        WZ9pjO6q6hH5Q/E2bGQAuOXNikajV8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-xaprAVJLPJWW_5PpBSGALg-1; Tue, 30 Jun 2020 04:42:47 -0400
X-MC-Unique: xaprAVJLPJWW_5PpBSGALg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBEE107ACCA;
        Tue, 30 Jun 2020 08:42:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67D7710013C0;
        Tue, 30 Jun 2020 08:42:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH v1] s390/extmem: remove stale -ENOSPC comment and handling
Date:   Tue, 30 Jun 2020 10:42:40 +0200
Message-Id: <20200630084240.8283-1-david@redhat.com>
In-Reply-To: <20200625150029.45019-1-david@redhat.com>
References: <20200625150029.45019-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

segment_load() will no longer return -ENOSPC. If a segment overlaps with
storage, we now also return -EBUSY. Remove the stale comment from
__segment_load() and the stale handling from segment_warning().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/extmem.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 105c09282f8c5..5060956b8e7d6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -401,8 +401,7 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
  * -EIO     : could not perform query or load diagnose
  * -ENOENT  : no such segment
  * -EOPNOTSUPP: multi-part segment cannot be used with linux
- * -ENOSPC  : segment cannot be used (overlaps with storage)
- * -EBUSY   : segment can temporarily not be used (overlaps with dcss)
+ * -EBUSY   : segment cannot be used (overlaps with dcss or storage)
  * -ERANGE  : segment cannot be used (exceeds kernel mapping range)
  * -EPERM   : segment is currently loaded with incompatible permissions
  * -ENOMEM  : out of memory
@@ -627,10 +626,6 @@ void segment_warning(int rc, char *seg_name)
 		pr_err("DCSS %s has multiple page ranges and cannot be "
 		       "loaded or queried\n", seg_name);
 		break;
-	case -ENOSPC:
-		pr_err("DCSS %s overlaps with used storage and cannot "
-		       "be loaded\n", seg_name);
-		break;
 	case -EBUSY:
 		pr_err("%s needs used memory resources and cannot be "
 		       "loaded or queried\n", seg_name);
-- 
2.26.2

