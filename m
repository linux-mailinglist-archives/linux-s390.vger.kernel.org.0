Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3420FDFF
	for <lists+linux-s390@lfdr.de>; Tue, 30 Jun 2020 22:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgF3Up4 (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Tue, 30 Jun 2020 16:45:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23003 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730274AbgF3Upz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 30 Jun 2020 16:45:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QmKrOvMWqrUVt7J9PTTUHlaMQYpm2NLJh4q6ELyuhdM=;
        b=JAM1aBUA6MYGNVFTwYKs7lJnspANiRIjQPNM9jsMaoLXP+w04hoJEseqmlGz8MQX52abYN
        zrR4YcdZ2cjTxxfbbX5ypW42G/9/ODS75Euc1yFfDvAdWOHJvWgM0/JZWW/pY1oe1jkebe
        6aSbPfU7yziHmDNdnfeAX2EvEXn8lPQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-7RcQLFT-OReDcTDjjuKRvw-1; Tue, 30 Jun 2020 16:45:51 -0400
X-MC-Unique: 7RcQLFT-OReDcTDjjuKRvw-1
Received: by mail-qv1-f71.google.com with SMTP id r4so14611030qvh.10
        for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2020 13:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QmKrOvMWqrUVt7J9PTTUHlaMQYpm2NLJh4q6ELyuhdM=;
        b=YFfiVIZc7eBwPXRXDRn7/Rs04y+wlbx48/PYFFzeAsQ1/C5PgxuBbn77hPnfiDVw2q
         XpOYIvYkG3GcOjRD5GDqvHZOu7GWD3DJRrcpLW39LNxUTB38wTLodsgKd1BbKCfXUxIh
         xan0gFVSnGN8+igdQomrIf6bmj5rlWqiPZ99MHugpR4miSkQy27RJDNhKTpjQkKocJuv
         IdX4v1mUDzefhFtUbxVCrUbZl1WSjx3ywqVaj+j5Orvr3CurDMpj7gnPCBRcb1dTqw5j
         keQqc+14vmXbGczbbUO13PI+FSdJ31SgGmrg84klI7IplydedMFinAEVfPHdsea/kVXC
         y9fA==
X-Gm-Message-State: AOAM531ytTMXWKJb/KeV6Fo/WweTRcgGkkf7RSrnj3bD7f1j7FlKJH6w
        VHbVwxB5wMqT6YSMnJmoHh6wALCHvcd7qd07uDcVrJQwJ0bIYcZyTWCiQsSbNU5L9YohG5NA3El
        mboWnjkPAx6YaHCuYv0TYhQ==
X-Received: by 2002:aed:25fd:: with SMTP id y58mr22804779qtc.310.1593549951209;
        Tue, 30 Jun 2020 13:45:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/hkCkeODL2Wy8DJkssVjFyiyJsWkeyAfUcqwLI37xKcbykEL4x8zUn+pbQH01QHAlweYYdg==
X-Received: by 2002:aed:25fd:: with SMTP id y58mr22804761qtc.310.1593549950997;
        Tue, 30 Jun 2020 13:45:50 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d79sm4006344qkb.101.2020.06.30.13.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 18/26] mm/s390: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:48 -0400
Message-Id: <20200630204548.39342-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index fc14df0b4d6e..9aa201df2e94 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -478,7 +478,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -488,21 +488,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	if (unlikely(fault & VM_FAULT_ERROR))
 		goto out_up;
 
-	/*
-	 * Major/minor page fault accounting is only done on the
-	 * initial attempt. If we go through a retry, it is extremely
-	 * likely that the page will be found in page cache at that point.
-	 */
 	if (flags & FAULT_FLAG_ALLOW_RETRY) {
-		if (fault & VM_FAULT_MAJOR) {
-			tsk->maj_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
-				      regs, address);
-		} else {
-			tsk->min_flt++;
-			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
-				      regs, address);
-		}
 		if (fault & VM_FAULT_RETRY) {
 			if (IS_ENABLED(CONFIG_PGSTE) && gmap &&
 			    (flags & FAULT_FLAG_RETRY_NOWAIT)) {
-- 
2.26.2

