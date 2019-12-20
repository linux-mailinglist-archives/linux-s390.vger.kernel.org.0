Return-Path: <linux-s390-owner@vger.kernel.org>
X-Original-To: lists+linux-s390@lfdr.de
Delivered-To: lists+linux-s390@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1EC7127DB8
	for <lists+linux-s390@lfdr.de>; Fri, 20 Dec 2019 15:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfLTOfs (ORCPT <rfc822;lists+linux-s390@lfdr.de>);
        Fri, 20 Dec 2019 09:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:39622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbfLTOfM (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 20 Dec 2019 09:35:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BB024684;
        Fri, 20 Dec 2019 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852511;
        bh=uoHI+zr6kvyEBV+qP09MMDEmOEe93V3zRQ8+fhnahHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TS5StZcNBBxYLUJmZgQG1hgHiuRrHKabjWPqJgt91HgZQAkVX6BFCC/L7Yvx6PTLN
         EaQ16gbx12BpNslTcgzpHhZ5jdLvV6FYb5yKqekFbjOPlws4GwxFS6OBmYwxKKThth
         AzjNcbrow7WORzEUKzDqNE8FVtOMyUt5CBRva/Os=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/34] s390/cpum_sf: Avoid SBD overflow condition in irq handler
Date:   Fri, 20 Dec 2019 09:34:28 -0500
Message-Id: <20191220143433.9922-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220143433.9922-1-sashal@kernel.org>
References: <20191220143433.9922-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

[ Upstream commit 0539ad0b22877225095d8adef0c376f52cc23834 ]

The s390 CPU Measurement sampling facility has an overflow condition
which fires when all entries in a SBD are used.
The measurement alert interrupt is triggered and reads out all samples
in this SDB. It then tests the successor SDB, if this SBD is not full,
the interrupt handler does not read any samples at all from this SDB
The design waits for the hardware to fill this SBD and then trigger
another meassurement alert interrupt.

This scheme works nicely until
an perf_event_overflow() function call discards the sample due to
a too high sampling rate.
The interrupt handler has logic to read out a partially filled SDB
when the perf event overflow condition in linux common code is met.
This causes the CPUM sampling measurement hardware and the PMU
device driver to operate on the same SBD's trailer entry.
This should not happen.

This can be seen here using this trace:
   cpumsf_pmu_add: tear:0xb5286000
   hw_perf_event_update: sdbt 0xb5286000 full 1 over 0 flush_all:0
   hw_perf_event_update: sdbt 0xb5286008 full 0 over 0 flush_all:0
        above shows 1. interrupt
   hw_perf_event_update: sdbt 0xb5286008 full 1 over 0 flush_all:0
   hw_perf_event_update: sdbt 0xb5286008 full 0 over 0 flush_all:0
        above shows 2. interrupt
	... this goes on fine until...
   hw_perf_event_update: sdbt 0xb5286068 full 1 over 0 flush_all:0
   perf_push_sample1: overflow
      one or more samples read from the IRQ handler are rejected by
      perf_event_overflow() and the IRQ handler advances to the next SDB
      and modifies the trailer entry of a partially filled SDB.
   hw_perf_event_update: sdbt 0xb5286070 full 0 over 0 flush_all:1
      timestamp: 14:32:52.519953

Next time the IRQ handler is called for this SDB the trailer entry shows
an overflow count of 19 missed entries.
   hw_perf_event_update: sdbt 0xb5286070 full 1 over 19 flush_all:1
      timestamp: 14:32:52.970058

Remove access to a follow on SDB when event overflow happened.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/perf_cpum_sf.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 0b09585305521..8ba440ba84624 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1248,12 +1248,6 @@ static void hw_perf_event_update(struct perf_event *event, int flush_all)
 		 */
 		if (flush_all && done)
 			break;
-
-		/* If an event overflow happened, discard samples by
-		 * processing any remaining sample-data-blocks.
-		 */
-		if (event_overflow)
-			flush_all = 1;
 	}
 
 	/* Account sample overflows in the event hardware structure */
-- 
2.20.1

