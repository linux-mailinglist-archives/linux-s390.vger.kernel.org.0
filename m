Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F8820BCAC
	for <lists+linux-s390@lfdr.de>; Sat, 27 Jun 2020 00:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgFZWhF (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 26 Jun 2020 18:37:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41350 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgFZWgd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 26 Jun 2020 18:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=R5yfzOfw/PV9JKqBWdCUcsneH01bWix262il1741Kj1OJ69IAXHjGvEFMQT1ObrLRN/3WZ
        A7pj8arAS5sHFNBT1tuKmhSIx8mj+C1vN/5FhgwBIDKykzBoVKZPk6sgkWgiSng6ctd05w
        7ZXtLkpTInn6VBJf8VYIgGdjNB9cC88=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-knSWvzs7N1KJxLHhbzPC9w-1; Fri, 26 Jun 2020 18:36:30 -0400
X-MC-Unique: knSWvzs7N1KJxLHhbzPC9w-1
Received: by mail-qt1-f197.google.com with SMTP id e4so7542385qtd.13
        for <linux-s390@vger.kernel.org>; Fri, 26 Jun 2020 15:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=jAJnfu/ZGmmBw3fusfg+zOatNSOq6XzF9ikT364js/FyMsR6IfsMDMHhJVuOooiyjE
         E2KanO8j5NWelhGY9CfMWzVJAIbHdKoWKRJIzwjXiwTNOmG5BHe3TuZhmBwnw5J0mRHA
         j5KAfCmxlT6g5oT8ANA/Ru69PjHLUAZG3zvTEmORimBTguF5NfaYsbKrhwolADX8mWl0
         3KbnV8ZfqwULuAh1WiN57pBfI0qsTQtyyIbgiF0K+BzJTS1DkQyztoKpCu1zkLS5sgss
         cOcGqmTQjh5i3oCsVNQqHpX6i1jMP8h3siW1BduND7gcyWPQqqA9hV2zK8OG4UqPfLd7
         cBZA==
X-Gm-Message-State: AOAM531JBsIjHT0MvqAJHt+laXT9aPEddn6Hc4g0V4uwS4UcE4vPoD1O
        pby27bv7nVzw9dfL4EofdYRQBbih2KkT6ZMc6OJ+86VGUUiAPMu7lVyvyGS5xevD8PW0GvIC2Rk
        nxey1n+wsBlK2OAzyqEV61Q==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr4985242qkk.418.1593210990396;
        Fri, 26 Jun 2020 15:36:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLYGq3uXNWtPIgvnBvBRj+uEHvatOJbgH7Twl/utY0PoQ7HyXhGFahIL8nucdp7+auhoYPqQ==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr4985234qkk.418.1593210990186;
        Fri, 26 Jun 2020 15:36:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id k45sm3109699qtc.62.2020.06.26.15.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:36:29 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 18/26] mm/s390: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:36:27 -0400
Message-Id: <20200626223627.199861-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
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
index ab6d7eedcfab..4d62ca7d3e09 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -479,7 +479,7 @@ static inline vm_fault_t do_exception(struct pt_regs *regs, int access)
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	fault = handle_mm_fault(vma, address, flags, NULL);
+	fault = handle_mm_fault(vma, address, flags, regs);
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
-- 
2.26.2

