Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46BE02014A4
	for <lists+linux-s390@lfdr.de>; Fri, 19 Jun 2020 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394395AbgFSQNm (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 19 Jun 2020 12:13:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2394390AbgFSQNl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 19 Jun 2020 12:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592583219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=g31txkb7064DGT16E5DNXqbhZ4Y2JfKNHoTv8e5LP6DGROyASe4p36hcbBr61Z/ebRAtxd
        b9JzAoXeSPHc6yz/HPoeKp1iVs6/iauucMIgl3T4vrlMg0OdHNmHI4PjWfkHQoiOPXqT2g
        eLe2u030MckT4351jIiYiP2C8NSpepM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-bUlaS6yUPtukcyozO98dBQ-1; Fri, 19 Jun 2020 12:13:38 -0400
X-MC-Unique: bUlaS6yUPtukcyozO98dBQ-1
Received: by mail-qv1-f70.google.com with SMTP id 59so7120963qvb.4
        for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2020 09:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHCFBr0H2Wj98J64LoxM3OjPsGeWNQz7WDWbAHsmGis=;
        b=oan5cpQO+Drcl3QgIJddDzcPelbNcvcPgS5hHpXFq+Wvu7fhIG/sj6WxmceaZx/Cn5
         r2GPZVajB68EW8tnHe2OZ8vzZfJbYkEBT4fjJRN7DI/t2KUrIiozCXcHh/DlUkzVnryS
         qXWcvhqjDNw1p7vAh4/qqBxM7rzyoQ6tiuiBLTl21c90fMMLQl9aqoKMREa1xU+Uv0q8
         PqwJTaBPXEhVrc6+//Oc8zA+Fl48eMSkvtSp+ll8ULaRxtli/tSQ53ujG9LhKxxAN5vk
         f5CC0JUnf93ApLG8Uf5vD+9G5tCpMYblqDVYQGLoybK9wPeul3vfPAvmzTdSgt1B8pMA
         LGTg==
X-Gm-Message-State: AOAM5320ED96CtQisGIyz12dhnjE23k2v2NUle79sUWiXxKvNOsUS95S
        wUHhA7JQuGQtSmHhs5FZeINf5RDnR6B1DZCn84JsbKPiQ2NEz1sda+GE75R22Y1K0698k34jwu9
        agoXx32SWqdt0XPYEcsk2kQ==
X-Received: by 2002:ac8:4746:: with SMTP id k6mr4197646qtp.234.1592583217569;
        Fri, 19 Jun 2020 09:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8FxSE1nBWsTRVRNtg8kxaR64T2HjUjPlWnGOgZGa7/UjveZ5zpprBuiIcJe4cj3bpOnvD0g==
X-Received: by 2002:ac8:4746:: with SMTP id k6mr4197618qtp.234.1592583217335;
        Fri, 19 Jun 2020 09:13:37 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r76sm6090318qka.30.2020.06.19.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:13:36 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Peter Xu <peterx@redhat.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 18/26] mm/s390: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:13:35 -0400
Message-Id: <20200619161335.9664-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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

