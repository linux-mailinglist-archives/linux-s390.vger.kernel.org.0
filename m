Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884E31FA36C
	for <lists+linux-s390@lfdr.de>; Tue, 16 Jun 2020 00:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgFOWXL (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Mon, 15 Jun 2020 18:23:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726408AbgFOWXK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Jun 2020 18:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6iJ7T2WCuS9j4a5Opdda9lcC0DUIC1agfdOIfVBRkmk=;
        b=JM0R61XmrpMRvMTem8IOt/bmPdu7/ZgVmRoJD7FJ1IoX3QkA/ZkJJMH2M+yy007S7bHRrD
        TQ5ukLs6GeVU49/Fx5n0nbCGZRFrMxJoVgYb5BxAW9NqemTxSf1+A1bkiY9uDNDyoQ++BB
        GCDpGYZWgCW46r2hIfrUdBjjjiOA10Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-4l8Tz7ouO-uapL037e-1Xw-1; Mon, 15 Jun 2020 18:23:05 -0400
X-MC-Unique: 4l8Tz7ouO-uapL037e-1Xw-1
Received: by mail-qt1-f200.google.com with SMTP id t24so15185763qtj.15
        for <linux-s390@vger.kernel.org>; Mon, 15 Jun 2020 15:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6iJ7T2WCuS9j4a5Opdda9lcC0DUIC1agfdOIfVBRkmk=;
        b=fwThPpiTR96Vt4O1inVkf5reZIhh9MckyaX3D6HkSTDdj3hk0UH1oIOyQ0yht2HZYU
         fmQeJaPtXRGkcyypS3yPp9t2a6A/SpT9cGcLJ0hYOaDmQL9aPnPOQ3n3FcNx4SbCBXQw
         gPpRgGm803FiM8qA/l+FT/ltbtsJO+FUvjEkjBCRZDMag74p/Y5AwHrYV3Z3NRSwmBZt
         ECnB2RT7mIvp16+/b3TTcdD27Mqyq6jWLwxUGqtpgayg/wHZTH6cwqfZWVz1EltdE7Yy
         c9+wp9wTxexsoIlARJtus/cp4228oR/JEuqJeXr0C20wsd+UlXkF+A0owLrSdTCnLeRP
         3zZA==
X-Gm-Message-State: AOAM532GOzhxUGC87uIIW1HlSS7CNWoIjrg9sC4iqIAwsOHsCrZQHkbs
        Z6enpv/BzkkeWxq0pgr8JyFgeELHol2TeUMD8JAfFxjiqOyroyCK1TgGjxiEhrmgAcsGp0CvLlo
        +f6vozgqD0F671H65d9tW+w==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr17839222qtw.317.1592259784901;
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsVEBhvqnlL41B27HM9K7iSgiXjn7WNVAulmZ9FZltbdlG0mU9CjIqjx17dmiutbX9UExfzg==
X-Received: by 2002:ac8:4f46:: with SMTP id i6mr17839209qtw.317.1592259784704;
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id d17sm12237625qke.101.2020.06.15.15.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:23:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 19/25] mm/s390: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:23:02 -0400
Message-Id: <20200615222302.8452-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.

Avoid doing page fault accounting multiple times if the page fault is retried.

CC: Heiko Carstens <heiko.carstens@de.ibm.com>
CC: Vasily Gorbik <gor@linux.ibm.com>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: linux-s390@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/s390/mm/fault.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index dedc28be27ab..8ca207635b59 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -392,7 +392,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	unsigned long trans_exc_code;
 	unsigned long address;
 	unsigned int flags;
-	vm_fault_t fault;
+	vm_fault_t fault, major = 0;
 
 	tsk = current;
 	/*
@@ -428,7 +428,6 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	}
 
 	address = trans_exc_code & __FAIL_ADDR_MASK;
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	flags = FAULT_FLAG_DEFAULT;
 	if (user_mode(regs))
 		flags |= FAULT_FLAG_USER;
@@ -480,6 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, flags);
+	major |= fault & VM_FAULT_MAJOR;
 	if (fault_signal_pending(fault, regs)) {
 		fault = VM_FAULT_SIGNAL;
 		if (flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -489,21 +489,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
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
@@ -519,6 +505,9 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 			goto retry;
 		}
 	}
+
+	mm_fault_accounting(tsk, regs, address, major);
+
 	if (IS_ENABLED(CONFIG_PGSTE) && gmap) {
 		address =  __gmap_link(gmap, current->thread.gmap_addr,
 				       address);
-- 
2.26.2

